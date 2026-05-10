//`timescale 1ns/1ps
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
    $dumpvars;
    $dumpfile("dump.vcd");
    wr_clk = 1'b0;
    rd_clk = 1'b0;  
    rst_n = 1'b0;
    wr_enb = 1'b0;
    rd_enb = 1'b0;
    wr_data = {FIFO_WIDTH{1'd0}};
    #10 rst_n = 1'b1;
forever begin
    #0.005 wr_clk = ~wr_clk;
    #0.01 rd_clk = ~rd_clk;
end
  #1000;
    $finish;
end

always @(posedge wr_clk or negedge rst_n) begin
    if(!rst_n) begin
        wr_enb <= 1'd0;
        wr_data <= {FIFO_WIDTH{1'd0}};
    end else begin
        wr_enb <= 1'd1;
        wr_data <= wr_data + {{(FIFO_WIDTH-1){1'd0}},{1'd1}};
        if(wr_data == 8'd100) begin
            wr_enb <= 1'd0;
        end
    end
end

always@(posedge rd_clk or negedge rst_n) begin
    if(!rst_n) begin
        rd_enb <= 1'd0;
    end else begin
        rd_enb <= 1'd1;
        if(rd_data == 8'd100) begin
            rd_enb <= 1'd0;
        end
    end
end
endmodule