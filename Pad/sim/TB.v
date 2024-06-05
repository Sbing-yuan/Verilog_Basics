`timescale 1ns/1ps
`define VCDDUMP

module TB();

reg     OE;
reg     Out;
reg     Pad_drv;

initial begin
    $display("Rx mode, drv low");
    OE = 0; 
    Pad_drv = 1'b0;
    Out = 1'b1;
    #10;

    $display("Rx mode, drv high");
    Pad_drv = 1'b1;
    Out = 1'b0;
    #10;

    $display("Tx mode, drv high");
    Pad_drv = 1'bz;
    OE = 1; 
    Out = 1'b1;
    #10;

    $display("Tx mode, drv low");
    Out = 1'b0;
    #10;

    $display("Tx mode, conflict1");
    Pad_drv = 1'b1;
    Out = 1'b0;
    #10;

    $display("Tx mode, conflict2");
    Pad_drv = 1'b0;
    Out = 1'b1;
    #10;
end

assign Pad = Pad_drv;

GPIO UGPIO(
/*AUTOINST*/
	   // Outputs
	   .In				(In),
	   // Inouts
	   .Pad				(Pad),
	   // Inputs
	   .Out				(Out),
	   .OE				(OE));

`ifdef VCDDUMP
initial begin
    $dumpfile("Test.vcd");  //
    $dumpvars(0,TB);       
end
`endif

endmodule
