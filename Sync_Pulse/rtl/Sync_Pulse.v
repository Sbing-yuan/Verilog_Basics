module Sync_Pulse(
/*AUTOARG*/
   // Outputs
   b_pulseout,
   // Inputs
   a_pulsein, a_clk, a_rstn, b_clk, b_rstn
   );

input   a_pulsein;
input   a_clk;
input   a_rstn;

input   b_clk;
input   b_rstn;
output  b_pulseout;

reg     a_toggle;
reg     sync_a_toggle_d;


always@(posedge a_clk or negedge a_rstn)
    if(~a_rstn)
        a_toggle <= 1'b0;
    else
        a_toggle <= a_toggle ^ a_pulsein;

CDCSync_Signal_ResetL CDCSync_a_toggle(
    .DI(a_toggle),
    .clk(b_clk),
    .rst_n(b_rstn),
    .DO(sync_a_toggle)
);

always@(posedge b_clk or negedge b_rstn)
    if(~b_rstn)
        sync_a_toggle_d <= 1'b0;
    else
        sync_a_toggle_d <= sync_a_toggle;
        
assign b_pulseout = sync_a_toggle_d ^ sync_a_toggle;

endmodule
