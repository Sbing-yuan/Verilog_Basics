`timescale 1ns/1ps
`define VCDDUMP

module TB();

reg clk_50M;
reg rst_n;
reg sig_a;
reg sig_b;
reg [2:0] cnt;

initial begin 
    clk_50M = 1'b0;
    rst_n = 1'b1;
    #10;
    rst_n = 1'b0;
    #10;
    rst_n = 1'b1;
    #500;
    $finish;
end

always #10 clk_50M = ~clk_50M;

always@(posedge clk_50M or negedge rst_n) 
    if(~rst_n)
        cnt <= 3'd0;
    else 
        cnt <= cnt + 1;

always@(posedge clk_50M or negedge rst_n) 
begin
    if(~rst_n)
    begin
        sig_a <= 1'b0;
        sig_b <= 1'b1;
    end
    else if(cnt == 3'd5)
        sig_a <= ~sig_a;
    else if(cnt == 3'd7)
        sig_b <= ~sig_b;
end

Signal_Edge_ResetL Signal_Edge_sig_a(
/*AUTOINST*/
				     // Outputs
				     .DO_rise		(sig_a_rise),
				     .DO_fall		(sig_a_fall),
				     // Inputs
				     .clk		(clk_50M),
				     .rst_n		(rst_n),
				     .DI		(sig_a));

Signal_Edge_ResetH Signal_Edge_sig_b(
/*AUTOINST*/
				     // Outputs
				     .DO_rise		(sig_b_rise),
				     .DO_fall		(sig_b_fall),
				     // Inputs
				     .clk		(clk_50M),
				     .rst_n		(rst_n),
				     .DI		(sig_b));

`ifdef VCDDUMP
initial begin
    $dumpfile("Test.vcd");  //
    $dumpvars(0,TB);       
end
`endif

endmodule
