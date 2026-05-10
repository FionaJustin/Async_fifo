module tb_b2g;
reg [INPUT_WIDTH-1:0] in;
wire [OUTPUT_WIDTH-1:0] out;
b2g_conv conv(.in(in),.out(out));
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    in = 8'b00000000;
    #10 in = 8'b11111111;
    #10 in = 8'b10101010;
    #10 in = 8'b01010101;
    #10 in = 8'b11001100;
    #10 in = 8'b00110011;
    #10 $finish;
end
endmodule
