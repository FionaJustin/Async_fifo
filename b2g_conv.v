//`include "params.hv"
module b2g_conv(
input wire [FIFO_DEPTH:0] in,
output wire [FIFO_DEPTH:0] out
);

assign out = in ^ (in >> 1);

endmodule
