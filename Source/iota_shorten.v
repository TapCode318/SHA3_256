module iota_shorten(
	input [63:0] in_data,
	input [4:0] in_round,
	output [63:0] out_data
);

// ta co the rut gon KC tu 64bit thanh 7bit vi chi co cac bit co the thay doi
// tuong ung la 63, 31, 15, 7, 3, 1, 0
reg [6:0] sel_kc_7bit;

always @(*) begin
        case(in_round)
            0:  sel_kc_7bit = 7'b0000001; 
            1:  sel_kc_7bit = 7'b0011010; 
            2:  sel_kc_7bit = 7'b1011110; 
            3:  sel_kc_7bit = 7'b1110000; 
            4:  sel_kc_7bit = 7'b0011111; 
            5:  sel_kc_7bit = 7'b0100001; 
            6:  sel_kc_7bit = 7'b1111001; 
            7:  sel_kc_7bit = 7'b1010101; 
            8:  sel_kc_7bit = 7'b0001110; 
            9:  sel_kc_7bit = 7'b0001100; 
            10: sel_kc_7bit = 7'b0110101; 
            11: sel_kc_7bit = 7'b0100110; 
            12: sel_kc_7bit = 7'b0111111; 
            13: sel_kc_7bit = 7'b1001111; 
            14: sel_kc_7bit = 7'b1011101; 
            15: sel_kc_7bit = 7'b1010011; 
				16: sel_kc_7bit = 7'b1010010; 
            17: sel_kc_7bit = 7'b1001000; 
            18: sel_kc_7bit = 7'b0010110; 
            19: sel_kc_7bit = 7'b1100110; 
            20: sel_kc_7bit = 7'b1111001; 
            21: sel_kc_7bit = 7'b1011000; 
            22: sel_kc_7bit = 7'b0100001; 
            23: sel_kc_7bit = 7'b1110100; 
            default: sel_kc_7bit = 7'b0000000;
        endcase
    end

genvar i;

generate 
	for(i = 0; i < 64; i = i + 1) begin : iota_xor
		if(i == 0) assign out_data[0] = in_data[0] ^ sel_kc_7bit[0];
		else if(i == 1) assign out_data[1] = in_data[1] ^ sel_kc_7bit[1];
		else if(i == 3) assign out_data[3] = in_data[3] ^ sel_kc_7bit[2];
		else if(i == 7) assign out_data[7] = in_data[7] ^ sel_kc_7bit[3];
		else if(i == 15) assign out_data[15] = in_data[15] ^ sel_kc_7bit[4];
		else if(i == 31) assign out_data[31] = in_data[31] ^ sel_kc_7bit[5];
		else if(i == 63) assign out_data[63] = in_data[63] ^ sel_kc_7bit[6];
		else assign out_data[i] = in_data[i];
	end 
endgenerate

endmodule
	