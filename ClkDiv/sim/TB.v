`timescale 1ns/1ps
`define VCDDUMP

module TB();

parameter CNT_BW = 13; // 0~8191

reg clk_50M;
reg rst_n;
reg [CNT_BW-1:0] B_n;

wire    out_clk;

initial begin 
    clk_50M = 1'b0;
    rst_n = 1'b1;
    #1;
    rst_n = 1'b0;
    #1;
    rst_n = 1'b1;
    B_n = 'd1;
    repeat(10) @(posedge out_clk);
    B_n = 'd10;
    repeat(10) @(posedge out_clk);
    B_n = 'd11;
    repeat(10) @(posedge out_clk);
    B_n = 'd100;
    repeat(10) @(posedge out_clk);
    B_n = 'd101;
    repeat(10) @(posedge out_clk);
    B_n = 'd6250;
    repeat(10) @(posedge out_clk);
    $finish;
end

//50MHz -> 0.02*10^-6 = 20*10^-9 = 20ns
always #10 clk_50M = ~clk_50M;

ClkDiv #(.CNT_BW(CNT_BW))
UClkDiv (
/*AUTOINST*/
	       // Outputs
	       .out_clk			(out_clk),
	       // Inputs
	       .in_clk			(clk_50M),
	       .B_n			(B_n[CNT_BW-1:0]),
	       .rst_n			(rst_n));

`ifdef VCDDUMP
initial begin
    $dumpfile("Test.vcd");  //
    $dumpvars(0,TB);       
end
`endif

endmodule
