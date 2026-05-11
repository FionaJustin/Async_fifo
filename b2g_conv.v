module b2g_conv #(
parameter ADDR_WIDTH = 4
)(
input wire [ADDR_WIDTH-1:0] in,
output wire [ADDR_WIDTH-1:0] out
);

assign out = in ^ (in >> 1);

endmodule
