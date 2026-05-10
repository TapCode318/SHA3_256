module sha3_256_top(
    input  wire clk,
    input  wire rst,
    input  wire [63:0] data_in,
    input  wire start,
    input  wire valid_in, 
    input  wire is_last, // Bao word hien tai la word cuoi cung cua messag
    input  wire [3:0] valid_bytes, // So byte hop le trong word cuoi, tu 0 den 8
    output wire [255:0] hash_out,  // Gia tri bam SHA3-256 dau ra, 256 bit
    output wire ready, // =1 khi FIFO chua day, co the nhan them input
    output reg  valid_out // =1 trong 1 chu ky khi hash_out da hop le
);

    localparam IDLE = 3'd0;
    localparam ABSORB = 3'd1; // ABSORB: doc FIFO va XOR du lieu vao phan rate cua state Keccak
    localparam CALC = 3'd2;
    localparam PAD_BLOCK = 3'd3; // PAD_BLOCK : them padding block rieng khi message ket thuc dung cuoi block 136 byte
    localparam CALC_LAST = 3'd4; 
    localparam SQUEEZE = 3'd5;

    localparam [63:0] SHA3_SUFFIX = 64'h0000000000000006;
    localparam [63:0] SHA3_FINAL = 64'h8000000000000000;

    reg [2:0] state;
    reg [2:0] next_state;
    
    // Du lieu message chi duoc XOR truc tiep vao phan rate,
    reg [63:0] s0;
    reg [63:0] s1;
    reg [63:0] s2;
    reg [63:0] s3;
    reg [63:0] s4;
    reg [63:0] s5;
    reg [63:0] s6;
    reg [63:0] s7;
    reg [63:0] s8;
    reg [63:0] s9;
    reg [63:0] s10;
    reg [63:0] s11;
    reg [63:0] s12;
    reg [63:0] s13;
    reg [63:0] s14;
    reg [63:0] s15;
    reg [63:0] s16;
    reg [63:0] s17;
    reg [63:0] s18;
    reg [63:0] s19;
    reg [63:0] s20;
    reg [63:0] s21;
    reg [63:0] s22;
    reg [63:0] s23;
    reg [63:0] s24;
// round2in1_pipelined nhan 25 lane state hien tai, xu ly 2 round Keccak lien tiep, va tra ve 25 lane moi o0 den o24
    wire [63:0] o0;
    wire [63:0] o1;
    wire [63:0] o2;
    wire [63:0] o3;
    wire [63:0] o4;
    wire [63:0] o5;
    wire [63:0] o6;
    wire [63:0] o7;
    wire [63:0] o8;
    wire [63:0] o9;
    wire [63:0] o10;
    wire [63:0] o11;
    wire [63:0] o12;
    wire [63:0] o13;
    wire [63:0] o14;
    wire [63:0] o15;
    wire [63:0] o16;
    wire [63:0] o17;
    wire [63:0] o18;
    wire [63:0] o19;
    wire [63:0] o20;
    wire [63:0] o21;
    wire [63:0] o22;
    wire [63:0] o23;
    wire [63:0] o24;

    reg [255:0] hash_out_reg;
    assign hash_out = hash_out_reg;

    reg [4:0] word_count; // Dem word 64-bit dang absorb vao rate.
    reg pad_block_pending; // Duoc bat len khi message ket thuc dung cuoi block rate 136 byte.
    reg [3:0] pair_count;// pair_count dem tu 0 den 11 vi moi 2 round 1 lan
    reg [2:0] wait_count; //Do wait_count dem 0,1,2,3,4 nen moi cap 2 round mat 5 chu ky dieu khien, cung la latency 

    wire [4:0] current_round;
    assign current_round = {pair_count, 1'b0};

    wire pair_done;// Bao da hoan thanh du 24 round cua mot permutation.
    assign pair_done = ((state == CALC) || (state == CALC_LAST)) &&
                       (pair_count == 4'd11) &&
                       (wait_count == 3'd4);

    wire [63:0] pre_padded_data;
    wire pre_last_full_word; //pre_last_full_word = 1 de top xu ly o lane tiep theo

    sha3_padder u_padder (
        .din (data_in),
        .valid_bytes (valid_bytes),
        .is_last (is_last),
        .dout (pre_padded_data),
        .last_full_word (pre_last_full_word)
    );

    wire fifo_full;
    wire fifo_empty;
    wire [65:0] fifo_dout;
    wire [65:0] fifo_din;

    assign fifo_din = {is_last, pre_last_full_word, pre_padded_data};
    assign ready = !fifo_full;

    wire fifo_rd_en; // tin hieu doc cho fifo
    assign fifo_rd_en = (state == ABSORB) && !fifo_empty;

    fifo_buffer #(
        .DATA_WIDTH(66),
        .DEPTH(16)
    ) u_input_fifo (
        .clk (clk),
        .rst (rst),
        .din (fifo_din),
        .wr_en (valid_in && !fifo_full),
        .full (fifo_full),
        .dout (fifo_dout),
        .rd_en (fifo_rd_en),
        .empty (fifo_empty)
    );

    wire fifo_is_last;
    wire fifo_last_full_word;
    wire [63:0] fifo_data;

    assign fifo_is_last = fifo_dout[65];
    assign fifo_last_full_word = fifo_dout[64];
    assign fifo_data = fifo_dout[63:0];

    function [63:0] swap_bytes;
        input [63:0] in;
        begin
            swap_bytes = {
                in[7:0], in[15:8],
                in[23:16], in[31:24],
                in[39:32], in[47:40],
                in[55:48], in[63:56]
            };
        end
    endfunction

    always @(*) begin
        next_state = state;

        case (state)
        
        // Khi start = 1, bat dau qua trinh hash moi va chuyen sang ABSORB.
            IDLE: begin
                if (start)
                    next_state = ABSORB;
            end

            ABSORB: begin
             //Case: Word cuoi du 8 byte va nam dung lane 16 => chay CALC truoc roi them padding cho block rieng => CALC_LAST cho padding word
                if (fifo_rd_en) begin
                    if (fifo_is_last) begin
                        if (fifo_last_full_word && (word_count == 5'd16))
                            next_state = CALC;
                        else
             // Case2: word cuoi nhung van paddinf duoc: hoac da padding vao word khoi hoac khong phai word thu 17
                            next_state = CALC_LAST;
                    end
                    else begin
             // Case3; chua phia word cuoi cua message => chay CALC cho block trung gian nay
                        if (word_count == 5'd16)
                            next_state = CALC;
                    end
                end
            end

            CALC: begin
                if (pair_done) begin
                    if (pad_block_pending) // Neu dang cho padding block rieng thi sang PAD_BLOCK.
                        next_state = PAD_BLOCK;
                    else
                        next_state = ABSORB;
                end
            end

            PAD_BLOCK: begin // Them padding block rieng trong 1 chu ky. Sau do sang CALC_LAST de chay permutation cuoi.
                next_state = CALC_LAST;
            end

            CALC_LAST: begin
                if (pair_done)
                    next_state = SQUEEZE;
            end

            SQUEEZE: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    always @(posedge clk) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(posedge clk) begin
        if (rst) begin
            valid_out         <= 1'b0;
            word_count        <= 5'd0;
            pad_block_pending <= 1'b0;
            pair_count        <= 4'd0;
            wait_count        <= 3'd0;
            hash_out_reg      <= 256'd0;
        end
        else begin
            hash_out_reg <= {
                swap_bytes(s0),
                swap_bytes(s1),
                swap_bytes(s2),
                swap_bytes(s3)
            };

            valid_out <= 1'b0;

            case (state)

                IDLE: begin
                    word_count        <= 5'd0;
                    pad_block_pending <= 1'b0;
                    pair_count        <= 4'd0;
                    wait_count        <= 3'd0;
                    //khi bat dau: Sponge construction bat dau voi state 1600 bit toan 0.
                    if (start) begin
                        s0  <= 64'd0;
                        s1  <= 64'd0;
                        s2  <= 64'd0;
                        s3  <= 64'd0;
                        s4  <= 64'd0;
                        s5  <= 64'd0;
                        s6  <= 64'd0;
                        s7  <= 64'd0;
                        s8  <= 64'd0;
                        s9  <= 64'd0;
                        s10 <= 64'd0;
                        s11 <= 64'd0;
                        s12 <= 64'd0;
                        s13 <= 64'd0;
                        s14 <= 64'd0;
                        s15 <= 64'd0;
                        s16 <= 64'd0;
                        s17 <= 64'd0;
                        s18 <= 64'd0;
                        s19 <= 64'd0;
                        s20 <= 64'd0;
                        s21 <= 64'd0;
                        s22 <= 64'd0;
                        s23 <= 64'd0;
                        s24 <= 64'd0;
                    end
                end

                ABSORB: begin
                    if (fifo_rd_en) begin

                        if (!fifo_is_last) begin
                            case (word_count)
                                5'd0:  s0  <= s0  ^ fifo_data;
                                5'd1:  s1  <= s1  ^ fifo_data;
                                5'd2:  s2  <= s2  ^ fifo_data;
                                5'd3:  s3  <= s3  ^ fifo_data;
                                5'd4:  s4  <= s4  ^ fifo_data;
                                5'd5:  s5  <= s5  ^ fifo_data;
                                5'd6:  s6  <= s6  ^ fifo_data;
                                5'd7:  s7  <= s7  ^ fifo_data;
                                5'd8:  s8  <= s8  ^ fifo_data;
                                5'd9:  s9  <= s9  ^ fifo_data;
                                5'd10: s10 <= s10 ^ fifo_data;
                                5'd11: s11 <= s11 ^ fifo_data;
                                5'd12: s12 <= s12 ^ fifo_data;
                                5'd13: s13 <= s13 ^ fifo_data;
                                5'd14: s14 <= s14 ^ fifo_data;
                                5'd15: s15 <= s15 ^ fifo_data;
                                5'd16: s16 <= s16 ^ fifo_data;
                                default: ;
                            endcase
                            // Neu vua nap lane 16 thi da du 1 block rate 1088 bit.
                            // Reset word_count va bo dem round de sang CALC.
                            if (word_count == 5'd16) begin
                                word_count <= 5'd0;
                                pair_count <= 4'd0;
                                wait_count <= 3'd0;
                            end
                            else begin
                                word_count <= word_count + 1'b1;
                            end
                        end

                        else begin // case word cuoi du 8 bytes
                            if (fifo_last_full_word) begin

                                if (word_count == 5'd16) begin // lane 16
                                    s16 <= s16 ^ fifo_data;   // XOR data vao s16 => CALC => PAD_BLOCK => 
                                    word_count        <= 5'd0;
                                    pad_block_pending <= 1'b1;
                                    pair_count        <= 4'd0;
                                    wait_count        <= 3'd0;
                                end

                                else begin
                                    case (word_count)
                                        5'd0:  s0  <= s0  ^ fifo_data;
                                        5'd1:  s1  <= s1  ^ fifo_data;
                                        5'd2:  s2  <= s2  ^ fifo_data;
                                        5'd3:  s3  <= s3  ^ fifo_data;
                                        5'd4:  s4  <= s4  ^ fifo_data;
                                        5'd5:  s5  <= s5  ^ fifo_data;
                                        5'd6:  s6  <= s6  ^ fifo_data;
                                        5'd7:  s7  <= s7  ^ fifo_data;
                                        5'd8:  s8  <= s8  ^ fifo_data;
                                        5'd9:  s9  <= s9  ^ fifo_data;
                                        5'd10: s10 <= s10 ^ fifo_data;
                                        5'd11: s11 <= s11 ^ fifo_data;
                                        5'd12: s12 <= s12 ^ fifo_data;
                                        5'd13: s13 <= s13 ^ fifo_data;
                                        5'd14: s14 <= s14 ^ fifo_data;
                                        5'd15: s15 <= s15 ^ fifo_data;
                                        default: ;
                                    endcase

                                    if (word_count == 5'd15) begin // neu chi o lane 15
                                        s16 <= s16 ^ SHA3_SUFFIX ^ SHA3_FINAL;
                                    end
                                    else begin
                                        case (word_count)
                                            5'd0:  s1  <= s1  ^ SHA3_SUFFIX;
                                            5'd1:  s2  <= s2  ^ SHA3_SUFFIX;
                                            5'd2:  s3  <= s3  ^ SHA3_SUFFIX;
                                            5'd3:  s4  <= s4  ^ SHA3_SUFFIX;
                                            5'd4:  s5  <= s5  ^ SHA3_SUFFIX;
                                            5'd5:  s6  <= s6  ^ SHA3_SUFFIX;
                                            5'd6:  s7  <= s7  ^ SHA3_SUFFIX;
                                            5'd7:  s8  <= s8  ^ SHA3_SUFFIX;
                                            5'd8:  s9  <= s9  ^ SHA3_SUFFIX;
                                            5'd9:  s10 <= s10 ^ SHA3_SUFFIX;
                                            5'd10: s11 <= s11 ^ SHA3_SUFFIX;
                                            5'd11: s12 <= s12 ^ SHA3_SUFFIX;
                                            5'd12: s13 <= s13 ^ SHA3_SUFFIX;
                                            5'd13: s14 <= s14 ^ SHA3_SUFFIX;
                                            5'd14: s15 <= s15 ^ SHA3_SUFFIX;
                                            default: ;
                                        endcase

                                        s16 <= s16 ^ SHA3_FINAL;
                                    end

                                    word_count <= 5'd0;
                                    pair_count <= 4'd0;
                                    wait_count <= 3'd0;
                                end
                            end
                            
                            //case word khong du 8bytes
                            else begin 
                                if (word_count == 5'd16) begin // neu nam o lane 16
                                    s16 <= s16 ^ fifo_data ^ SHA3_FINAL;
                                end
                                else begin
                                    case (word_count)
                                        5'd0:  s0  <= s0  ^ fifo_data;
                                        5'd1:  s1  <= s1  ^ fifo_data;
                                        5'd2:  s2  <= s2  ^ fifo_data;
                                        5'd3:  s3  <= s3  ^ fifo_data;
                                        5'd4:  s4  <= s4  ^ fifo_data;
                                        5'd5:  s5  <= s5  ^ fifo_data;
                                        5'd6:  s6  <= s6  ^ fifo_data;
                                        5'd7:  s7  <= s7  ^ fifo_data;
                                        5'd8:  s8  <= s8  ^ fifo_data;
                                        5'd9:  s9  <= s9  ^ fifo_data;
                                        5'd10: s10 <= s10 ^ fifo_data;
                                        5'd11: s11 <= s11 ^ fifo_data;
                                        5'd12: s12 <= s12 ^ fifo_data;
                                        5'd13: s13 <= s13 ^ fifo_data;
                                        5'd14: s14 <= s14 ^ fifo_data;
                                        5'd15: s15 <= s15 ^ fifo_data;
                                        default: ;
                                    endcase

                                    s16 <= s16 ^ SHA3_FINAL;
                                end

                                word_count <= 5'd0;
                                pair_count <= 4'd0;
                                wait_count <= 3'd0;
                            end
                        end
                    end
                end

                CALC: begin
                    if (wait_count == 3'd4) begin
                        s0  <= o0;
                        s1  <= o1;
                        s2  <= o2;
                        s3  <= o3;
                        s4  <= o4;
                        s5  <= o5;
                        s6  <= o6;
                        s7  <= o7;
                        s8  <= o8;
                        s9  <= o9;
                        s10 <= o10;
                        s11 <= o11;
                        s12 <= o12;
                        s13 <= o13;
                        s14 <= o14;
                        s15 <= o15;
                        s16 <= o16;
                        s17 <= o17;
                        s18 <= o18;
                        s19 <= o19;
                        s20 <= o20;
                        s21 <= o21;
                        s22 <= o22;
                        s23 <= o23;
                        s24 <= o24;

                        wait_count <= 3'd0;
                        // Neu da xu ly cap round cuoi 22-23 thi reset pair_count.
                        // Neu chua thi tang pair_count de xu ly cap round tiep theo.
                        if (pair_count == 4'd11)
                            pair_count <= 4'd0;
                        else
                            pair_count <= pair_count + 1'b1;
                    end
                    else begin
                        wait_count <= wait_count + 1'b1;
                    end
                end

                PAD_BLOCK: begin
                    s0  <= s0  ^ SHA3_SUFFIX;
                    s16 <= s16 ^ SHA3_FINAL;

                    word_count        <= 5'd0;
                    pad_block_pending <= 1'b0;
                    pair_count        <= 4'd0;
                    wait_count        <= 3'd0;
                end

                CALC_LAST: begin
                    if (wait_count == 3'd4) begin
                        s0  <= o0;
                        s1  <= o1;
                        s2  <= o2;
                        s3  <= o3;
                        s4  <= o4;
                        s5  <= o5;
                        s6  <= o6;
                        s7  <= o7;
                        s8  <= o8;
                        s9  <= o9;
                        s10 <= o10;
                        s11 <= o11;
                        s12 <= o12;
                        s13 <= o13;
                        s14 <= o14;
                        s15 <= o15;
                        s16 <= o16;
                        s17 <= o17;
                        s18 <= o18;
                        s19 <= o19;
                        s20 <= o20;
                        s21 <= o21;
                        s22 <= o22;
                        s23 <= o23;
                        s24 <= o24;

                        wait_count <= 3'd0;

                        if (pair_count == 4'd11)
                            pair_count <= 4'd0;
                        else
                            pair_count <= pair_count + 1'b1;
                    end
                    else begin
                        wait_count <= wait_count + 1'b1;
                    end
                end

                SQUEEZE: begin
                    valid_out <= 1'b1;
                end

                default: begin
                    valid_out <= 1'b0;
                end

            endcase
        end
    end

    round2in1_pipelined u_round2in1(
        .clk(clk),
        .in_round(current_round),

        .in_data_0(s0),
        .in_data_1(s1),
        .in_data_2(s2),
        .in_data_3(s3),
        .in_data_4(s4),
        .in_data_5(s5),
        .in_data_6(s6),
        .in_data_7(s7),
        .in_data_8(s8),
        .in_data_9(s9),
        .in_data_10(s10),
        .in_data_11(s11),
        .in_data_12(s12),
        .in_data_13(s13),
        .in_data_14(s14),
        .in_data_15(s15),
        .in_data_16(s16),
        .in_data_17(s17),
        .in_data_18(s18),
        .in_data_19(s19),
        .in_data_20(s20),
        .in_data_21(s21),
        .in_data_22(s22),
        .in_data_23(s23),
        .in_data_24(s24),

        .out_data_0(o0),
        .out_data_1(o1),
        .out_data_2(o2),
        .out_data_3(o3),
        .out_data_4(o4),
        .out_data_5(o5),
        .out_data_6(o6),
        .out_data_7(o7),
        .out_data_8(o8),
        .out_data_9(o9),
        .out_data_10(o10),
        .out_data_11(o11),
        .out_data_12(o12),
        .out_data_13(o13),
        .out_data_14(o14),
        .out_data_15(o15),
        .out_data_16(o16),
        .out_data_17(o17),
        .out_data_18(o18),
        .out_data_19(o19),
        .out_data_20(o20),
        .out_data_21(o21),
        .out_data_22(o22),
        .out_data_23(o23),
        .out_data_24(o24)
    );

endmodule