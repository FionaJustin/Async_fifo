`include "params.hv"
module b2g_conv(
input wire [INPUT_WIDTH-1:0] in,
output wire [OUTPUT_WIDTH-1:0] out
);

assign out = in ^ (in >> 1);

endmodule
