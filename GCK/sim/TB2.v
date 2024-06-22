`timescale 1ns/1ps
`define VCDDUMP

module TB();

reg clk;
reg en;
reg [2:0] cnt;

initial begin
    clk = 1'b0;
    en  = 1'b0;
    cnt = 3'd0;
    #3333;
    $finish;
end

always #10 clk = ~clk;

always@(posedge clk)
begin
    if(cnt == 3'd7)
    begin
        cnt <= 0;
        en  <= 1'b1;
    end
    else 
    begin
        cnt <= cnt + 1;
        en  <= 1'b0;
    end
end

Gate_clock UGate_clock(
/*AUTOINST*/
		       // Outputs
		       .g_clk		(g_clk),
		       // Inputs
		       .clk		(clk),
		       .en		(en));

`ifdef VCDDUMP
initial begin
    $dumpfile("Test2.vcd");  //
    $dumpvars(0,TB);       
end
`endif

endmodule
