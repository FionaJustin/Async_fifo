module data_sync #(
parameter ADDR_WIDTH = 4
)(
input wire clk, 
input wire rst_n,
input wire [ADDR_WIDTH-1:0] in,
output reg [ADDR_WIDTH-1:0] out
);
reg [ADDR_WIDTH-1:0] in_d1;
reg [ADDR_WIDTH-1:0] in_d2;


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
