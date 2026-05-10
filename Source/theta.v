module theta(
	input [63:0] in_data_0,
	input [63:0] in_data_1,
	input [63:0] in_data_2,
	input [63:0] in_data_3,
	input [63:0] in_data_4,
	input [63:0] in_data_5,
	input [63:0] in_data_6,
	input [63:0] in_data_7,
	input [63:0] in_data_8,
	input [63:0] in_data_9,
	input [63:0] in_data_10,
	input [63:0] in_data_11,
	input [63:0] in_data_12,
	input [63:0] in_data_13,
	input [63:0] in_data_14,
	input [63:0] in_data_15,
	input [63:0] in_data_16,
	input [63:0] in_data_17,
	input [63:0] in_data_18,
	input [63:0] in_data_19,
	input [63:0] in_data_20,
	input [63:0] in_data_21,
	input [63:0] in_data_22,
	input [63:0] in_data_23,
	input [63:0] in_data_24,
	
	output [63:0] out_data_0,
	output [63:0] out_data_1,
	output [63:0] out_data_2,
	output [63:0] out_data_3,
	output [63:0] out_data_4,
	output [63:0] out_data_5,
	output [63:0] out_data_6,
	output [63:0] out_data_7,
	output [63:0] out_data_8,
	output [63:0] out_data_9,
	output [63:0] out_data_10,
	output [63:0] out_data_11,
	output [63:0] out_data_12,
	output [63:0] out_data_13,
	output [63:0] out_data_14,
	output [63:0] out_data_15,
	output [63:0] out_data_16,
	output [63:0] out_data_17,
	output [63:0] out_data_18,
	output [63:0] out_data_19,
	output [63:0] out_data_20,
	output [63:0] out_data_21,
	output [63:0] out_data_22,
	output [63:0] out_data_23,
	output [63:0] out_data_24
);

// C[i] = A[i,0] xor A[i,1] xor A[i,2] xor A[i,3] xor A[i,4]
wire [63:0] c_0 = in_data_0 ^ in_data_5 ^ in_data_10 ^ in_data_15 ^ in_data_20;
wire [63:0] c_1 = in_data_1 ^ in_data_6 ^ in_data_11 ^ in_data_16 ^ in_data_21;
wire [63:0] c_2 = in_data_2 ^ in_data_7 ^ in_data_12 ^ in_data_17 ^ in_data_22;
wire [63:0] c_3 = in_data_3 ^ in_data_8 ^ in_data_13 ^ in_data_18 ^ in_data_23;
wire [63:0] c_4 = in_data_4 ^ in_data_9 ^ in_data_14 ^ in_data_19 ^ in_data_24;
// D[i] = C[i-1] xor rotate(C[i+1],1)
wire [63:0] d_0 = c_4 ^ {c_1[62:0], c_1[63]};
wire [63:0] d_1 = c_0 ^ {c_2[62:0], c_2[63]};
wire [63:0] d_2 = c_1 ^ {c_3[62:0], c_3[63]};
wire [63:0] d_3 = c_2 ^ {c_4[62:0], c_4[63]};
wire [63:0] d_4 = c_3 ^ {c_0[62:0], c_0[63]};
// A'[i,j] = A[i,j] xor D[i]
assign out_data_0 = in_data_0 ^ d_0;	
assign out_data_5 = in_data_5 ^ d_0;	
assign out_data_10 = in_data_10 ^ d_0;	
assign out_data_15 = in_data_15 ^ d_0;	
assign out_data_20 = in_data_20 ^ d_0;
	
assign out_data_1 = in_data_1 ^ d_1;	
assign out_data_6 = in_data_6 ^ d_1;	
assign out_data_11 = in_data_11 ^ d_1;	
assign out_data_16 = in_data_16 ^ d_1;	
assign out_data_21 = in_data_21 ^ d_1;
	
assign out_data_2 = in_data_2 ^ d_2;	
assign out_data_7 = in_data_7 ^ d_2;	
assign out_data_12 = in_data_12 ^ d_2;	
assign out_data_17 = in_data_17 ^ d_2;	
assign out_data_22 = in_data_22 ^ d_2;
	
assign out_data_3 = in_data_3 ^ d_3;	
assign out_data_8 = in_data_8 ^ d_3;	
assign out_data_13 = in_data_13 ^ d_3;	
assign out_data_18 = in_data_18 ^ d_3;
assign out_data_23 = in_data_23 ^ d_3;
	
assign out_data_4 = in_data_4 ^ d_4;	
assign out_data_9 = in_data_9 ^ d_4;	
assign out_data_14 = in_data_14 ^ d_4;	
assign out_data_19 = in_data_19 ^ d_4;	
assign out_data_24 = in_data_24 ^ d_4;

endmodule
