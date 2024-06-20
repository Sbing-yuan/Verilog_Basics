`timescale 1ns/1ps
`define VCDDUMP

module TB();

reg clk_4k;
reg rst_n;
reg [3:0] num1;
reg [3:0] num2;
reg [3:0] num3;
reg [3:0] num4;

initial begin 
    clk_4k = 1'b0;
    rst_n = 1'b1;
    num1 = 4'h0;
    num2 = 4'h1;
    num3 = 4'h2;
    num4 = 4'h3;
    #10;
    rst_n = 1'b0;
    #10;
    rst_n = 1'b1;

    repeat(10) @(posedge clk_4k);
    num1 = 4'h4;
    num2 = 4'h5;
    num3 = 4'h6;
    num4 = 4'h7;

    repeat(10) @(posedge clk_4k);
    num1 = 4'h8;
    num2 = 4'h9;
    num3 = 4'hA;
    num4 = 4'hB;

    repeat(10) @(posedge clk_4k);
    num1 = 4'hC;
    num2 = 4'hD;
    num3 = 4'hE;
    num4 = 4'hF;

    repeat(10) @(posedge clk_4k);
    $finish;
end

//4kHz -> 0.25*10^-3 = 250*10^-6 = 250,000 ns
always #125000 clk_4k = ~clk_4k;

seg7 Useg7(
/*AUTOINST*/
	   // Outputs
	   .a				(a),
	   .b				(b),
	   .c				(c),
	   .d				(d),
	   .e				(e),
	   .f				(f),
	   .g				(g),
	   .dp				(dp),
	   .D1_sel			(D1_sel),
	   .D2_sel			(D2_sel),
	   .D3_sel			(D3_sel),
	   .D4_sel			(D4_sel),
	   // Inputs
	   .num1			(num1[3:0]),
	   .num2			(num2[3:0]),
	   .num3			(num3[3:0]),
	   .num4			(num4[3:0]),
	   .scan_clk			(clk_4k),
	   .rst_n			(rst_n));

`ifdef VCDDUMP
initial begin
    $dumpfile("Test.vcd");  //
    $dumpvars(0,TB);       
end
`endif

endmodule
