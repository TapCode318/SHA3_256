    module fifo_buffer #(
        parameter DATA_WIDTH = 66,  // 66 bit = {is_last, last_full_word, padded_data[63:0]}
        parameter DEPTH = 16
    )(
        input  wire clk,
        input  wire rst,
    
        input  wire [DATA_WIDTH-1:0] din,
        input  wire wr_en,
        output wire full,
    
        output wire [DATA_WIDTH-1:0] dout,
        input  wire rd_en,
        output wire empty
    );
    
        reg [DATA_WIDTH-1:0] mem [0:15]; // bo nho co 16 o voi do dai la 66 bit
    
        reg [4:0] wr_ptr;
        reg [4:0] rd_ptr;
    
        assign empty = (wr_ptr == rd_ptr); // fifo rong khi tro read = tro write
    
        assign full = (wr_ptr[4] != rd_ptr[4]) &&
                      (wr_ptr[3:0] == rd_ptr[3:0]); // bit 4 de phan biet vung read va write
    
        assign dout = mem[rd_ptr[3:0]];
    
        always @(posedge clk) begin
            if (rst) begin
                wr_ptr <= 5'd0;
                rd_ptr <= 5'd0;
            end
            else begin
                if (wr_en && !full) begin
                    mem[wr_ptr[3:0]] <= din;
                    wr_ptr <= wr_ptr + 1'b1;
                end
    
                if (rd_en && !empty) begin
                    rd_ptr <= rd_ptr + 1'b1;
                end
            end
        end
    
    endmodule
