module Gate_clock(
/*AUTOARG*/
   // Outputs
   g_clk,
   // Inputs
   clk, en
   );

input   clk;
input   en;
output  g_clk;

reg     latch_en;

always@(*)
begin
    if(~clk)
        latch_en = en;
end

assign g_clk = clk & latch_en;

endmodule
