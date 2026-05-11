`timescale 1ns/1ps
`include "params.hv"
module tb_async_fifo;
reg wr_clk;
reg rd_clk; 
reg rst_n;
reg wr_enb;
reg rd_enb;
reg [FIFO_WIDTH-1:0] wr_data;
wire [FIFO_WIDTH-1:0] rd_data; 
wire full;
wire empty;
reg start_rd;
async_fifo fifo(
    .wr_clk         (wr_clk       ),
    .rd_clk         (rd_clk       ),
    .rst_n          (rst_n        ),
    .wr_enb         (wr_enb       ),
    .wr_data        (wr_data      ),
    .rd_enb         (rd_enb       ),
    .rd_data        (rd_data      ),
    .full           (full         ),
    .empty          (empty        )
);

initial begin
    $dumpfile("async_fifo_dump.vcd");
    $dumpvars(0, tb_async_fifo);
    wr_clk = 1'b0;
    rd_clk = 1'b0; 
    start_rd = 1'b0; 
    rst_n = 1'b0;
    wr_enb = 1'b0;
    rd_enb = 1'b0;
    wr_data = {FIFO_WIDTH{1'd0}};
    #10 rst_n = 1'b1;
    #50 start_rd = 1'b1;
    #100000 $finish;
end

always #5 wr_clk = ~wr_clk;
always #10 rd_clk = ~rd_clk;

always @(posedge wr_clk or negedge rst_n) begin
    if(!rst_n) begin
        wr_enb <= 1'd0;
        wr_data <= {FIFO_WIDTH{1'd0}};
    end else begin
        if(wr_data == 8'd255) begin
            wr_enb <= 1'd0;
        end else if(!full) begin
            wr_enb <= 1'd1;
            wr_data <= wr_data + {{(FIFO_WIDTH-1){1'd0}},{1'd1}};
        end
    end
end

always@(posedge rd_clk or negedge rst_n) begin
    if(!rst_n) begin
        rd_enb <= 1'd0;
    end else begin
        rd_enb <= start_rd & !empty;
    end
end
endmodule
