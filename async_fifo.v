`include "params.hv"
module async_fifo(
input wire                  wr_clk,
input wire                  rd_clk, 
input wire                  rst_n,
input wire                  wr_enb,
input wire[FIFO_WIDTH-1:0]  wr_data,
input wire                  rd_enb,
output reg [FIFO_WIDTH-1:0] rd_data,
output wire                 full,
output wire                 empty
);

parameter ADDR_WIDTH = FIFO_DEPTH + 1;
reg [ADDR_WIDTH-1:0] wr_addr;
reg [ADDR_WIDTH-1:0] rd_addr;
reg [FIFO_WIDTH-1:0] fifo_mem [FIFO_DEPTH-1:0];
wire [ADDR_WIDTH-1:0] g_wr_addr;
wire [ADDR_WIDTH-1:0] g_rd_addr;
wire [ADDR_WIDTH-1:0] sync_wr_addr;
wire [ADDR_WIDTH-1:0] sync_rd_addr;
wire [ADDR_WIDTH-1:0] nxt_rd_addr;
wire [ADDR_WIDTH-1:0] nxt_wr_addr;


always @(posedge wr_clk or negedge rst_n) begin
    if(!rst_n)begin
        wr_addr<={ADDR_WIDTH{1'd0}};
    end else begin
        if(wr_enb & !full) begin
            wr_addr<=wr_addr+{{FIFO_DEPTH{1'd0}},{1'd1}};
            fifo_mem[wr_addr]<=wr_data;
        end
    end
end

always @(posedge rd_clk or negedge rst_n) begin
    if(!rst_n)begin
        rd_addr<={ADDR_WIDTH{1'd0}};
        rd_data<={FIFO_WIDTH{1'd0}};
    end else begin
        if(rd_enb & !empty) begin
            rd_addr<=rd_addr+{{FIFO_DEPTH{1'd0}},{1'd1}};
            rd_data<=fifo_mem[rd_addr];
        end
    end
end

b2g_conv conv1(
    .in({nxt_rd_addr}),
    .out({g_wr_addr})
    );
b2g_conv conv2(
    .in({nxt_wr_addr}),
    .out({g_rd_addr})
    );

data_sync sync1(
    .clk(wr_clk),
    .rst_n(rst_n),
    .in({g_rd_addr}),
    .out({sync_rd_addr})
    );
data_sync sync2(
    .clk(rd_clk),
    .rst_n(rst_n),
    .in({g_wr_addr}),
    .out({sync_wr_addr})
    );

assign full = (g_wr_addr == sync_rd_addr)&&(g_wr_addr[FIFO_DEPTH]^sync_rd_addr[FIFO_DEPTH])
               ? 1'b1 : 1'b0;
assign empty = (g_rd_addr == sync_wr_addr) ? 1'b1 : 1'b0;

endmodule