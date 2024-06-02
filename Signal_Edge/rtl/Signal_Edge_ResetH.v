module Signal_Edge_ResetH(
/*AUTOARG*/
   // Outputs
   DO_rise, DO_fall,
   // Inputs
   clk, rst_n, DI
   );

input   clk;
input   rst_n;
input   DI;
output  DO_rise;
output  DO_fall;

reg DI_d;

always@(posedge clk or negedge rst_n)
    if(~rst_n)
        DI_d <= 1'b1;
    else
        DI_d <= DI;

assign DO_rise = DI & ~DI_d;
assign DO_fall = ~DI & DI_d;

endmodule
