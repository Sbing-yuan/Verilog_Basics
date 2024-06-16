`timescale 1ns/1ps
`define VCDDUMP

module TB();

reg SB;
reg RB;
reg G;
reg D;

initial begin
    SB = 1; RB = 1; G = 0; D = 0;
#10 SB = 0;
#10 SB = 1;
#10 D = 1;
#10 D = 0;
#10 D = 1;
#4  G = 1;
#10 D = 0;
#10 D = 1;
#4  G = 1;
#10 D = 0;
#10 D = 1;
end

D_Latch UD_Latch(
/*AUTOINST*/
		 // Outputs
		 .Q			(Q),
		 .QB			(QB),
		 // Inputs
		 .SB			(SB),
		 .RB			(RB),
		 .G			(G),
		 .D			(D));

`ifdef VCDDUMP
initial begin
    $dumpfile("Test.vcd");  //
    $dumpvars(0,TB);       
end
`endif

endmodule
