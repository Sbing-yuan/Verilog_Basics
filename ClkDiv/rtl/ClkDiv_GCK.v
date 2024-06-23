module ClkDiv_GCK
#(
parameter   CNT_BW = 8,
parameter   RST_VAL = 0
)(
/*AUTOARG*/
   // Outputs
   out_clk,
   // Inputs
   in_clk, B_n, rst_n
   );

output                  out_clk;
input                   in_clk;
input   [CNT_BW-1:0]    B_n;
input                   rst_n;

reg [CNT_BW-1:0]        cnt;

always@(posedge in_clk or negedge rst_n)
    if(~rst_n)
        cnt <= {{(CNT_BW-1){1'b0}},1'd1};
    else
    begin
        if(cnt >= B_n)
            cnt <= {{(CNT_BW-1){1'b0}},1'd1};
        else
            cnt <= cnt + {{(CNT_BW-1){1'b0}},1'd1};
    end

assign clk_en = (B_n == {{(CNT_BW-1){1'b0}},1'd1}) || (B_n == {{(CNT_BW){1'b0}}}) ? 1'b1 : (cnt == {{(CNT_BW-1){1'b0}},1'd1});

Gate_clock out_clk_gck(
/*AUTOINST*/
		       // Outputs
		       .g_clk		(out_clk),
		       // Inputs
		       .clk		(in_clk),
		       .en		(clk_en));

endmodule
