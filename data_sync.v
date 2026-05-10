//`include "params.hv"

module data_sync(
input wire clk, 
input wire rst_n,
input wire [FIFO_DEPTH:0] in,
output reg [FIFO_DEPTH:0] out
);
reg [FIFO_DEPTH:0] in_d1;
reg [FIFO_DEPTH:0] in_d2;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        in_d1 <= 0;
        in_d2 <= 0;
        out <= 0;
    end else begin
        in_d1 <= in;
        in_d2 <= in_d1;
        out <= in_d2;
    end
end

endmodule