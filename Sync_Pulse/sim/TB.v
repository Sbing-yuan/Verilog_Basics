`timescale 1ns/1ps
`define VCDDUMP

module TB();

reg clk_50M;
reg clk_33M;
reg rst_n;
reg pulse_a;
reg [2:0] cnt;

initial begin 
    clk_50M = 1'b0;
    clk_33M = 1'b0;
    rst_n = 1'b1;
    #10;
    rst_n = 1'b0;
    #10;
    rst_n = 1'b1;
    #500;
    $finish;
end

always #10 clk_50M = ~clk_50M;
always #15 clk_33M = ~clk_33M;

always@(posedge clk_50M or negedge rst_n) 
    if(~rst_n)
        cnt <= 3'd0;
    else 
        cnt <= cnt + 1;

always@(posedge clk_50M or negedge rst_n) 
    if(~rst_n)
        pulse_a <= 1'b0;
    else if(cnt == 3'd5)
        pulse_a <= 1'b1;
    else 
        pulse_a <= 1'b0;


Sync_Pulse Sync_Pulse_sig_a(
/*AUTOINST*/
			    // Outputs
			    .b_pulseout		(b_pulseout),
			    // Inputs
			    .a_pulsein		(pulse_a),
			    .a_clk		(clk_50M),
			    .a_rstn		(rst_n),
			    .b_clk		(clk_33M),
			    .b_rstn		(rst_n));

`ifdef VCDDUMP
initial begin
    $dumpfile("Test.vcd");  //
    $dumpvars(0,TB);       
end
`endif

endmodule
