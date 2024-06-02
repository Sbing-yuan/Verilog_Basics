`timescale 1ns/1ps
`define VCDDUMP

module TB();

reg clk_50M;
reg rst_n;
reg sig_a;
reg sig_b;

initial begin 
    clk_50M = 1'b0;
    rst_n = 1'b0;
    sig_a = 1'b0;
    sig_b = 1'b1;
    #30;
    rst_n = 1'b1;
    #12;
    sig_a = 1'b1;
    #5;
    sig_b = 1'b0;
    #100;
    $finish;
end

always #10 clk_50M = ~clk_50M;

CDCSync_Signal_ResetL CDCSync_sig_a(
/*AUTOINST*/
				    // Outputs
				    .DO			(sync_sig_a),
				    // Inputs
				    .clk		(clk_50M),
				    .rst_n		(rst_n),
				    .DI			(sig_a));

CDCSync_Signal_ResetH CDCSync_sig_b(
/*AUTOINST*/
				    // Outputs
				    .DO			(sync_sig_b),
				    // Inputs
				    .clk		(clk_50M),
				    .rst_n		(rst_n),
				    .DI			(sig_b));

`ifdef VCDDUMP
initial begin
    $dumpfile("Test.vcd");  //
    $dumpvars(0,TB);       
end
`endif

endmodule
