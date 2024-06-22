`timescale 1ns/1ps
`define VCDDUMP

module TB();

reg clk;
reg en;

initial begin
    clk = 1'b0;
    en = 1'b0;
    #333;
    en = 1'b1;
    #333;
    en = 1'b0;
    #333;
    en = 1'b1;
    #333;
    en = 1'b0;
    $finish;
end

always #10 clk = ~clk;

Gate_clock UGate_clock(
/*AUTOINST*/
		       // Outputs
		       .g_clk		(g_clk),
		       // Inputs
		       .clk		(clk),
		       .en		(en));

`ifdef VCDDUMP
initial begin
    $dumpfile("Test1.vcd");  //
    $dumpvars(0,TB);       
end
`endif

endmodule
