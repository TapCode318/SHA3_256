module sha3_padder (
    input  wire [63:0] din,
    input  wire [3:0] valid_bytes, // so bytes hop le trong word cuoi
    input  wire is_last, // flag word cuoi cung 

    output reg [63:0] dout,
    output wire last_full_word // neu word cuoi du 8 bytes thi = 1
);

    assign last_full_word = is_last && (valid_bytes == 4'd8); // word cuoi cung cua message co du 8 bytes

    always @(*) begin
        dout = din;

        if (is_last) begin
            case (valid_bytes)
                4'd0: dout = 64'h0000000000000006;
                4'd1: dout = {48'h0, 8'h06, din[7:0]};
                4'd2: dout = {40'h0, 8'h06, din[15:0]};
                4'd3: dout = {32'h0, 8'h06, din[23:0]};
                4'd4: dout = {24'h0, 8'h06, din[31:0]};
                4'd5: dout = {16'h0, 8'h06, din[39:0]};
                4'd6: dout = {8'h0, 8'h06, din[47:0]};
                4'd7: dout = {8'h06, din[55:0]};
                4'd8: dout = din;
                default: dout = din;
            endcase
        end
    end

endmodule