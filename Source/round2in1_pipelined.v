module round2in1_pipelined(
    input wire clk,
    input wire [4:0] in_round,
    input wire [63:0] in_data_0,
    input wire [63:0] in_data_1,
    input wire [63:0] in_data_2,
    input wire [63:0] in_data_3,
    input wire [63:0] in_data_4,
    input wire [63:0] in_data_5,
    input wire [63:0] in_data_6,
    input wire [63:0] in_data_7,
    input wire [63:0] in_data_8,
    input wire [63:0] in_data_9,
    input wire [63:0] in_data_10,
    input wire [63:0] in_data_11,
    input wire [63:0] in_data_12,
    input wire [63:0] in_data_13,
    input wire [63:0] in_data_14,
    input wire [63:0] in_data_15,
    input wire [63:0] in_data_16,
    input wire [63:0] in_data_17,
    input wire [63:0] in_data_18,
    input wire [63:0] in_data_19,
    input wire [63:0] in_data_20,
    input wire [63:0] in_data_21,
    input wire [63:0] in_data_22,
    input wire [63:0] in_data_23,
    input wire [63:0] in_data_24,
    output wire [63:0] out_data_0,
    output wire [63:0] out_data_1,
    output wire [63:0] out_data_2,
    output wire [63:0] out_data_3,
    output wire [63:0] out_data_4,
    output wire [63:0] out_data_5,
    output wire [63:0] out_data_6,
    output wire [63:0] out_data_7,
    output wire [63:0] out_data_8,
    output wire [63:0] out_data_9,
    output wire [63:0] out_data_10,
    output wire [63:0] out_data_11,
    output wire [63:0] out_data_12,
    output wire [63:0] out_data_13,
    output wire [63:0] out_data_14,
    output wire [63:0] out_data_15,
    output wire [63:0] out_data_16,
    output wire [63:0] out_data_17,
    output wire [63:0] out_data_18,
    output wire [63:0] out_data_19,
    output wire [63:0] out_data_20,
    output wire [63:0] out_data_21,
    output wire [63:0] out_data_22,
    output wire [63:0] out_data_23,
    output wire [63:0] out_data_24
);

wire [63:0] w_theta1_0, w_theta1_1, w_theta1_2, w_theta1_3, w_theta1_4, w_theta1_5, w_theta1_6, w_theta1_7, w_theta1_8, w_theta1_9, w_theta1_10, w_theta1_11, w_theta1_12, w_theta1_13, w_theta1_14, w_theta1_15, w_theta1_16, w_theta1_17, w_theta1_18, w_theta1_19, w_theta1_20, w_theta1_21, w_theta1_22, w_theta1_23, w_theta1_24;
wire [63:0] w_rhopi1_0, w_rhopi1_1, w_rhopi1_2, w_rhopi1_3, w_rhopi1_4, w_rhopi1_5, w_rhopi1_6, w_rhopi1_7, w_rhopi1_8, w_rhopi1_9, w_rhopi1_10, w_rhopi1_11, w_rhopi1_12, w_rhopi1_13, w_rhopi1_14, w_rhopi1_15, w_rhopi1_16, w_rhopi1_17, w_rhopi1_18, w_rhopi1_19, w_rhopi1_20, w_rhopi1_21, w_rhopi1_22, w_rhopi1_23, w_rhopi1_24;
wire [63:0] w_chi1_0, w_chi1_1, w_chi1_2, w_chi1_3, w_chi1_4, w_chi1_5, w_chi1_6, w_chi1_7, w_chi1_8, w_chi1_9, w_chi1_10, w_chi1_11, w_chi1_12, w_chi1_13, w_chi1_14, w_chi1_15, w_chi1_16, w_chi1_17, w_chi1_18, w_chi1_19, w_chi1_20, w_chi1_21, w_chi1_22, w_chi1_23, w_chi1_24;
wire [63:0] w_iota1_0;

wire [63:0] w_theta2_0, w_theta2_1, w_theta2_2, w_theta2_3, w_theta2_4, w_theta2_5, w_theta2_6, w_theta2_7, w_theta2_8, w_theta2_9, w_theta2_10, w_theta2_11, w_theta2_12, w_theta2_13, w_theta2_14, w_theta2_15, w_theta2_16, w_theta2_17, w_theta2_18, w_theta2_19, w_theta2_20, w_theta2_21, w_theta2_22, w_theta2_23, w_theta2_24;
wire [63:0] w_rhopi2_0, w_rhopi2_1, w_rhopi2_2, w_rhopi2_3, w_rhopi2_4, w_rhopi2_5, w_rhopi2_6, w_rhopi2_7, w_rhopi2_8, w_rhopi2_9, w_rhopi2_10, w_rhopi2_11, w_rhopi2_12, w_rhopi2_13, w_rhopi2_14, w_rhopi2_15, w_rhopi2_16, w_rhopi2_17, w_rhopi2_18, w_rhopi2_19, w_rhopi2_20, w_rhopi2_21, w_rhopi2_22, w_rhopi2_23, w_rhopi2_24;
wire [63:0] w_chi2_0, w_chi2_1, w_chi2_2, w_chi2_3, w_chi2_4, w_chi2_5, w_chi2_6, w_chi2_7, w_chi2_8, w_chi2_9, w_chi2_10, w_chi2_11, w_chi2_12, w_chi2_13, w_chi2_14, w_chi2_15, w_chi2_16, w_chi2_17, w_chi2_18, w_chi2_19, w_chi2_20, w_chi2_21, w_chi2_22, w_chi2_23, w_chi2_24;
wire [63:0] w_iota2_0;

reg [63:0] r_theta1_0, r_theta1_1, r_theta1_2, r_theta1_3, r_theta1_4, r_theta1_5, r_theta1_6, r_theta1_7, r_theta1_8, r_theta1_9, r_theta1_10, r_theta1_11, r_theta1_12, r_theta1_13, r_theta1_14, r_theta1_15, r_theta1_16, r_theta1_17, r_theta1_18, r_theta1_19, r_theta1_20, r_theta1_21, r_theta1_22, r_theta1_23, r_theta1_24;
reg [63:0] r_out1_0, r_out1_1, r_out1_2, r_out1_3, r_out1_4, r_out1_5, r_out1_6, r_out1_7, r_out1_8, r_out1_9, r_out1_10, r_out1_11, r_out1_12, r_out1_13, r_out1_14, r_out1_15, r_out1_16, r_out1_17, r_out1_18, r_out1_19, r_out1_20, r_out1_21, r_out1_22, r_out1_23, r_out1_24;
reg [63:0] r_theta2_0, r_theta2_1, r_theta2_2, r_theta2_3, r_theta2_4, r_theta2_5, r_theta2_6, r_theta2_7, r_theta2_8, r_theta2_9, r_theta2_10, r_theta2_11, r_theta2_12, r_theta2_13, r_theta2_14, r_theta2_15, r_theta2_16, r_theta2_17, r_theta2_18, r_theta2_19, r_theta2_20, r_theta2_21, r_theta2_22, r_theta2_23, r_theta2_24;
reg [63:0] r_out2_0, r_out2_1, r_out2_2, r_out2_3, r_out2_4, r_out2_5, r_out2_6, r_out2_7, r_out2_8, r_out2_9, r_out2_10, r_out2_11, r_out2_12, r_out2_13, r_out2_14, r_out2_15, r_out2_16, r_out2_17, r_out2_18, r_out2_19, r_out2_20, r_out2_21, r_out2_22, r_out2_23, r_out2_24;

reg [4:0] r_round1;
reg [4:0] r_round2;
reg [4:0] r_round3;

theta u_theta1 (
    .in_data_0(in_data_0),
    .in_data_1(in_data_1),
    .in_data_2(in_data_2),
    .in_data_3(in_data_3),
    .in_data_4(in_data_4),
    .in_data_5(in_data_5),
    .in_data_6(in_data_6),
    .in_data_7(in_data_7),
    .in_data_8(in_data_8),
    .in_data_9(in_data_9),
    .in_data_10(in_data_10),
    .in_data_11(in_data_11),
    .in_data_12(in_data_12),
    .in_data_13(in_data_13),
    .in_data_14(in_data_14),
    .in_data_15(in_data_15),
    .in_data_16(in_data_16),
    .in_data_17(in_data_17),
    .in_data_18(in_data_18),
    .in_data_19(in_data_19),
    .in_data_20(in_data_20),
    .in_data_21(in_data_21),
    .in_data_22(in_data_22),
    .in_data_23(in_data_23),
    .in_data_24(in_data_24),
    .out_data_0(w_theta1_0),
    .out_data_1(w_theta1_1),
    .out_data_2(w_theta1_2),
    .out_data_3(w_theta1_3),
    .out_data_4(w_theta1_4),
    .out_data_5(w_theta1_5),
    .out_data_6(w_theta1_6),
    .out_data_7(w_theta1_7),
    .out_data_8(w_theta1_8),
    .out_data_9(w_theta1_9),
    .out_data_10(w_theta1_10),
    .out_data_11(w_theta1_11),
    .out_data_12(w_theta1_12),
    .out_data_13(w_theta1_13),
    .out_data_14(w_theta1_14),
    .out_data_15(w_theta1_15),
    .out_data_16(w_theta1_16),
    .out_data_17(w_theta1_17),
    .out_data_18(w_theta1_18),
    .out_data_19(w_theta1_19),
    .out_data_20(w_theta1_20),
    .out_data_21(w_theta1_21),
    .out_data_22(w_theta1_22),
    .out_data_23(w_theta1_23),
    .out_data_24(w_theta1_24)
);

always @(posedge clk) begin
    r_theta1_0 <= w_theta1_0;
    r_theta1_1 <= w_theta1_1;
    r_theta1_2 <= w_theta1_2;
    r_theta1_3 <= w_theta1_3;
    r_theta1_4 <= w_theta1_4;
    r_theta1_5 <= w_theta1_5;
    r_theta1_6 <= w_theta1_6;
    r_theta1_7 <= w_theta1_7;
    r_theta1_8 <= w_theta1_8;
    r_theta1_9 <= w_theta1_9;
    r_theta1_10 <= w_theta1_10;
    r_theta1_11 <= w_theta1_11;
    r_theta1_12 <= w_theta1_12;
    r_theta1_13 <= w_theta1_13;
    r_theta1_14 <= w_theta1_14;
    r_theta1_15 <= w_theta1_15;
    r_theta1_16 <= w_theta1_16;
    r_theta1_17 <= w_theta1_17;
    r_theta1_18 <= w_theta1_18;
    r_theta1_19 <= w_theta1_19;
    r_theta1_20 <= w_theta1_20;
    r_theta1_21 <= w_theta1_21;
    r_theta1_22 <= w_theta1_22;
    r_theta1_23 <= w_theta1_23;
    r_theta1_24 <= w_theta1_24;
    r_round1 <= in_round;
end

rho_pi u_rho_pi1 (
    .in_data_0(r_theta1_0),
    .in_data_1(r_theta1_1),
    .in_data_2(r_theta1_2),
    .in_data_3(r_theta1_3),
    .in_data_4(r_theta1_4),
    .in_data_5(r_theta1_5),
    .in_data_6(r_theta1_6),
    .in_data_7(r_theta1_7),
    .in_data_8(r_theta1_8),
    .in_data_9(r_theta1_9),
    .in_data_10(r_theta1_10),
    .in_data_11(r_theta1_11),
    .in_data_12(r_theta1_12),
    .in_data_13(r_theta1_13),
    .in_data_14(r_theta1_14),
    .in_data_15(r_theta1_15),
    .in_data_16(r_theta1_16),
    .in_data_17(r_theta1_17),
    .in_data_18(r_theta1_18),
    .in_data_19(r_theta1_19),
    .in_data_20(r_theta1_20),
    .in_data_21(r_theta1_21),
    .in_data_22(r_theta1_22),
    .in_data_23(r_theta1_23),
    .in_data_24(r_theta1_24),
    .out_data_0(w_rhopi1_0),
    .out_data_1(w_rhopi1_1),
    .out_data_2(w_rhopi1_2),
    .out_data_3(w_rhopi1_3),
    .out_data_4(w_rhopi1_4),
    .out_data_5(w_rhopi1_5),
    .out_data_6(w_rhopi1_6),
    .out_data_7(w_rhopi1_7),
    .out_data_8(w_rhopi1_8),
    .out_data_9(w_rhopi1_9),
    .out_data_10(w_rhopi1_10),
    .out_data_11(w_rhopi1_11),
    .out_data_12(w_rhopi1_12),
    .out_data_13(w_rhopi1_13),
    .out_data_14(w_rhopi1_14),
    .out_data_15(w_rhopi1_15),
    .out_data_16(w_rhopi1_16),
    .out_data_17(w_rhopi1_17),
    .out_data_18(w_rhopi1_18),
    .out_data_19(w_rhopi1_19),
    .out_data_20(w_rhopi1_20),
    .out_data_21(w_rhopi1_21),
    .out_data_22(w_rhopi1_22),
    .out_data_23(w_rhopi1_23),
    .out_data_24(w_rhopi1_24)
);

chi u_chi1 (
    .in_data_0(w_rhopi1_0),
    .in_data_1(w_rhopi1_1),
    .in_data_2(w_rhopi1_2),
    .in_data_3(w_rhopi1_3),
    .in_data_4(w_rhopi1_4),
    .in_data_5(w_rhopi1_5),
    .in_data_6(w_rhopi1_6),
    .in_data_7(w_rhopi1_7),
    .in_data_8(w_rhopi1_8),
    .in_data_9(w_rhopi1_9),
    .in_data_10(w_rhopi1_10),
    .in_data_11(w_rhopi1_11),
    .in_data_12(w_rhopi1_12),
    .in_data_13(w_rhopi1_13),
    .in_data_14(w_rhopi1_14),
    .in_data_15(w_rhopi1_15),
    .in_data_16(w_rhopi1_16),
    .in_data_17(w_rhopi1_17),
    .in_data_18(w_rhopi1_18),
    .in_data_19(w_rhopi1_19),
    .in_data_20(w_rhopi1_20),
    .in_data_21(w_rhopi1_21),
    .in_data_22(w_rhopi1_22),
    .in_data_23(w_rhopi1_23),
    .in_data_24(w_rhopi1_24),
    .out_data_0(w_chi1_0),
    .out_data_1(w_chi1_1),
    .out_data_2(w_chi1_2),
    .out_data_3(w_chi1_3),
    .out_data_4(w_chi1_4),
    .out_data_5(w_chi1_5),
    .out_data_6(w_chi1_6),
    .out_data_7(w_chi1_7),
    .out_data_8(w_chi1_8),
    .out_data_9(w_chi1_9),
    .out_data_10(w_chi1_10),
    .out_data_11(w_chi1_11),
    .out_data_12(w_chi1_12),
    .out_data_13(w_chi1_13),
    .out_data_14(w_chi1_14),
    .out_data_15(w_chi1_15),
    .out_data_16(w_chi1_16),
    .out_data_17(w_chi1_17),
    .out_data_18(w_chi1_18),
    .out_data_19(w_chi1_19),
    .out_data_20(w_chi1_20),
    .out_data_21(w_chi1_21),
    .out_data_22(w_chi1_22),
    .out_data_23(w_chi1_23),
    .out_data_24(w_chi1_24)
);

iota_shorten u_iota1 (
    .in_data(w_chi1_0),
    .in_round(r_round1),
    .out_data(w_iota1_0)
);

always @(posedge clk) begin
    r_out1_0 <= w_iota1_0;
    r_out1_1 <= w_chi1_1;
    r_out1_2 <= w_chi1_2;
    r_out1_3 <= w_chi1_3;
    r_out1_4 <= w_chi1_4;
    r_out1_5 <= w_chi1_5;
    r_out1_6 <= w_chi1_6;
    r_out1_7 <= w_chi1_7;
    r_out1_8 <= w_chi1_8;
    r_out1_9 <= w_chi1_9;
    r_out1_10 <= w_chi1_10;
    r_out1_11 <= w_chi1_11;
    r_out1_12 <= w_chi1_12;
    r_out1_13 <= w_chi1_13;
    r_out1_14 <= w_chi1_14;
    r_out1_15 <= w_chi1_15;
    r_out1_16 <= w_chi1_16;
    r_out1_17 <= w_chi1_17;
    r_out1_18 <= w_chi1_18;
    r_out1_19 <= w_chi1_19;
    r_out1_20 <= w_chi1_20;
    r_out1_21 <= w_chi1_21;
    r_out1_22 <= w_chi1_22;
    r_out1_23 <= w_chi1_23;
    r_out1_24 <= w_chi1_24;
    r_round2 <= r_round1 + 5'd1;
end

theta u_theta2 (
    .in_data_0(r_out1_0),
    .in_data_1(r_out1_1),
    .in_data_2(r_out1_2),
    .in_data_3(r_out1_3),
    .in_data_4(r_out1_4),
    .in_data_5(r_out1_5),
    .in_data_6(r_out1_6),
    .in_data_7(r_out1_7),
    .in_data_8(r_out1_8),
    .in_data_9(r_out1_9),
    .in_data_10(r_out1_10),
    .in_data_11(r_out1_11),
    .in_data_12(r_out1_12),
    .in_data_13(r_out1_13),
    .in_data_14(r_out1_14),
    .in_data_15(r_out1_15),
    .in_data_16(r_out1_16),
    .in_data_17(r_out1_17),
    .in_data_18(r_out1_18),
    .in_data_19(r_out1_19),
    .in_data_20(r_out1_20),
    .in_data_21(r_out1_21),
    .in_data_22(r_out1_22),
    .in_data_23(r_out1_23),
    .in_data_24(r_out1_24),
    .out_data_0(w_theta2_0),
    .out_data_1(w_theta2_1),
    .out_data_2(w_theta2_2),
    .out_data_3(w_theta2_3),
    .out_data_4(w_theta2_4),
    .out_data_5(w_theta2_5),
    .out_data_6(w_theta2_6),
    .out_data_7(w_theta2_7),
    .out_data_8(w_theta2_8),
    .out_data_9(w_theta2_9),
    .out_data_10(w_theta2_10),
    .out_data_11(w_theta2_11),
    .out_data_12(w_theta2_12),
    .out_data_13(w_theta2_13),
    .out_data_14(w_theta2_14),
    .out_data_15(w_theta2_15),
    .out_data_16(w_theta2_16),
    .out_data_17(w_theta2_17),
    .out_data_18(w_theta2_18),
    .out_data_19(w_theta2_19),
    .out_data_20(w_theta2_20),
    .out_data_21(w_theta2_21),
    .out_data_22(w_theta2_22),
    .out_data_23(w_theta2_23),
    .out_data_24(w_theta2_24)
);

always @(posedge clk) begin
    r_theta2_0 <= w_theta2_0;
    r_theta2_1 <= w_theta2_1;
    r_theta2_2 <= w_theta2_2;
    r_theta2_3 <= w_theta2_3;
    r_theta2_4 <= w_theta2_4;
    r_theta2_5 <= w_theta2_5;
    r_theta2_6 <= w_theta2_6;
    r_theta2_7 <= w_theta2_7;
    r_theta2_8 <= w_theta2_8;
    r_theta2_9 <= w_theta2_9;
    r_theta2_10 <= w_theta2_10;
    r_theta2_11 <= w_theta2_11;
    r_theta2_12 <= w_theta2_12;
    r_theta2_13 <= w_theta2_13;
    r_theta2_14 <= w_theta2_14;
    r_theta2_15 <= w_theta2_15;
    r_theta2_16 <= w_theta2_16;
    r_theta2_17 <= w_theta2_17;
    r_theta2_18 <= w_theta2_18;
    r_theta2_19 <= w_theta2_19;
    r_theta2_20 <= w_theta2_20;
    r_theta2_21 <= w_theta2_21;
    r_theta2_22 <= w_theta2_22;
    r_theta2_23 <= w_theta2_23;
    r_theta2_24 <= w_theta2_24;
    r_round3 <= r_round2;
end

rho_pi u_rho_pi2 (
    .in_data_0(r_theta2_0),
    .in_data_1(r_theta2_1),
    .in_data_2(r_theta2_2),
    .in_data_3(r_theta2_3),
    .in_data_4(r_theta2_4),
    .in_data_5(r_theta2_5),
    .in_data_6(r_theta2_6),
    .in_data_7(r_theta2_7),
    .in_data_8(r_theta2_8),
    .in_data_9(r_theta2_9),
    .in_data_10(r_theta2_10),
    .in_data_11(r_theta2_11),
    .in_data_12(r_theta2_12),
    .in_data_13(r_theta2_13),
    .in_data_14(r_theta2_14),
    .in_data_15(r_theta2_15),
    .in_data_16(r_theta2_16),
    .in_data_17(r_theta2_17),
    .in_data_18(r_theta2_18),
    .in_data_19(r_theta2_19),
    .in_data_20(r_theta2_20),
    .in_data_21(r_theta2_21),
    .in_data_22(r_theta2_22),
    .in_data_23(r_theta2_23),
    .in_data_24(r_theta2_24),
    .out_data_0(w_rhopi2_0),
    .out_data_1(w_rhopi2_1),
    .out_data_2(w_rhopi2_2),
    .out_data_3(w_rhopi2_3),
    .out_data_4(w_rhopi2_4),
    .out_data_5(w_rhopi2_5),
    .out_data_6(w_rhopi2_6),
    .out_data_7(w_rhopi2_7),
    .out_data_8(w_rhopi2_8),
    .out_data_9(w_rhopi2_9),
    .out_data_10(w_rhopi2_10),
    .out_data_11(w_rhopi2_11),
    .out_data_12(w_rhopi2_12),
    .out_data_13(w_rhopi2_13),
    .out_data_14(w_rhopi2_14),
    .out_data_15(w_rhopi2_15),
    .out_data_16(w_rhopi2_16),
    .out_data_17(w_rhopi2_17),
    .out_data_18(w_rhopi2_18),
    .out_data_19(w_rhopi2_19),
    .out_data_20(w_rhopi2_20),
    .out_data_21(w_rhopi2_21),
    .out_data_22(w_rhopi2_22),
    .out_data_23(w_rhopi2_23),
    .out_data_24(w_rhopi2_24)
);

chi u_chi2 (
    .in_data_0(w_rhopi2_0),
    .in_data_1(w_rhopi2_1),
    .in_data_2(w_rhopi2_2),
    .in_data_3(w_rhopi2_3),
    .in_data_4(w_rhopi2_4),
    .in_data_5(w_rhopi2_5),
    .in_data_6(w_rhopi2_6),
    .in_data_7(w_rhopi2_7),
    .in_data_8(w_rhopi2_8),
    .in_data_9(w_rhopi2_9),
    .in_data_10(w_rhopi2_10),
    .in_data_11(w_rhopi2_11),
    .in_data_12(w_rhopi2_12),
    .in_data_13(w_rhopi2_13),
    .in_data_14(w_rhopi2_14),
    .in_data_15(w_rhopi2_15),
    .in_data_16(w_rhopi2_16),
    .in_data_17(w_rhopi2_17),
    .in_data_18(w_rhopi2_18),
    .in_data_19(w_rhopi2_19),
    .in_data_20(w_rhopi2_20),
    .in_data_21(w_rhopi2_21),
    .in_data_22(w_rhopi2_22),
    .in_data_23(w_rhopi2_23),
    .in_data_24(w_rhopi2_24),
    .out_data_0(w_chi2_0),
    .out_data_1(w_chi2_1),
    .out_data_2(w_chi2_2),
    .out_data_3(w_chi2_3),
    .out_data_4(w_chi2_4),
    .out_data_5(w_chi2_5),
    .out_data_6(w_chi2_6),
    .out_data_7(w_chi2_7),
    .out_data_8(w_chi2_8),
    .out_data_9(w_chi2_9),
    .out_data_10(w_chi2_10),
    .out_data_11(w_chi2_11),
    .out_data_12(w_chi2_12),
    .out_data_13(w_chi2_13),
    .out_data_14(w_chi2_14),
    .out_data_15(w_chi2_15),
    .out_data_16(w_chi2_16),
    .out_data_17(w_chi2_17),
    .out_data_18(w_chi2_18),
    .out_data_19(w_chi2_19),
    .out_data_20(w_chi2_20),
    .out_data_21(w_chi2_21),
    .out_data_22(w_chi2_22),
    .out_data_23(w_chi2_23),
    .out_data_24(w_chi2_24)
);

iota_shorten u_iota2 (
    .in_data(w_chi2_0),
    .in_round(r_round3),
    .out_data(w_iota2_0)
);

always @(posedge clk) begin
    r_out2_0 <= w_iota2_0;
    r_out2_1 <= w_chi2_1;
    r_out2_2 <= w_chi2_2;
    r_out2_3 <= w_chi2_3;
    r_out2_4 <= w_chi2_4;
    r_out2_5 <= w_chi2_5;
    r_out2_6 <= w_chi2_6;
    r_out2_7 <= w_chi2_7;
    r_out2_8 <= w_chi2_8;
    r_out2_9 <= w_chi2_9;
    r_out2_10 <= w_chi2_10;
    r_out2_11 <= w_chi2_11;
    r_out2_12 <= w_chi2_12;
    r_out2_13 <= w_chi2_13;
    r_out2_14 <= w_chi2_14;
    r_out2_15 <= w_chi2_15;
    r_out2_16 <= w_chi2_16;
    r_out2_17 <= w_chi2_17;
    r_out2_18 <= w_chi2_18;
    r_out2_19 <= w_chi2_19;
    r_out2_20 <= w_chi2_20;
    r_out2_21 <= w_chi2_21;
    r_out2_22 <= w_chi2_22;
    r_out2_23 <= w_chi2_23;
    r_out2_24 <= w_chi2_24;
end

assign out_data_0 = r_out2_0;
assign out_data_1 = r_out2_1;
assign out_data_2 = r_out2_2;
assign out_data_3 = r_out2_3;
assign out_data_4 = r_out2_4;
assign out_data_5 = r_out2_5;
assign out_data_6 = r_out2_6;
assign out_data_7 = r_out2_7;
assign out_data_8 = r_out2_8;
assign out_data_9 = r_out2_9;
assign out_data_10 = r_out2_10;
assign out_data_11 = r_out2_11;
assign out_data_12 = r_out2_12;
assign out_data_13 = r_out2_13;
assign out_data_14 = r_out2_14;
assign out_data_15 = r_out2_15;
assign out_data_16 = r_out2_16;
assign out_data_17 = r_out2_17;
assign out_data_18 = r_out2_18;
assign out_data_19 = r_out2_19;
assign out_data_20 = r_out2_20;
assign out_data_21 = r_out2_21;
assign out_data_22 = r_out2_22;
assign out_data_23 = r_out2_23;
assign out_data_24 = r_out2_24;

endmodule
