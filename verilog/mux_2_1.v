module mux_2_1 (input in_1, input in_2, input Select, output MuxOut);

    not (S_n, Select);
    and(and_0, in_1, S_n);
    and(and_1, in_2, Select);

    or or_2(MuxOut, and_0, and_1);
endmodule

module mux_2_1_32(input [31:0] in_1, input [31:0] in_2, input Select, output [31:0] MuxOut);

    mux_2_1 mux_2_1__0(in_1[0], in_2[0], Select, MuxOut[0]);
    mux_2_1 mux_2_1__1(in_1[1], in_2[1], Select, MuxOut[1]);
    mux_2_1 mux_2_1__2(in_1[2], in_2[2], Select, MuxOut[2]);
    mux_2_1 mux_2_1__3(in_1[3], in_2[3], Select, MuxOut[3]);
    mux_2_1 mux_2_1__4(in_1[4], in_2[4], Select, MuxOut[4]);
    mux_2_1 mux_2_1__5(in_1[5], in_2[5], Select, MuxOut[5]);
    mux_2_1 mux_2_1__6(in_1[6], in_2[6], Select, MuxOut[6]);
    mux_2_1 mux_2_1__7(in_1[7], in_2[7], Select, MuxOut[7]);
    mux_2_1 mux_2_1__8(in_1[8], in_2[8], Select, MuxOut[8]);
    mux_2_1 mux_2_1__9(in_1[9], in_2[9], Select, MuxOut[9]);
    mux_2_1 mux_2_1_1_10(in_1[10], in_2[10], Select, MuxOut[10]);
    mux_2_1 mux_2_1_1_11(in_1[11], in_2[11], Select, MuxOut[11]);
    mux_2_1 mux_2_1_1_12(in_1[12], in_2[12], Select, MuxOut[12]);
    mux_2_1 mux_2_1_1_13(in_1[13], in_2[13], Select, MuxOut[13]);
    mux_2_1 mux_2_1_1_14(in_1[14], in_2[14], Select, MuxOut[14]);
    mux_2_1 mux_2_1_1_15(in_1[15], in_2[15], Select, MuxOut[15]);
    mux_2_1 mux_2_1_1_16(in_1[16], in_2[16], Select, MuxOut[16]);
    mux_2_1 mux_2_1_1_17(in_1[17], in_2[17], Select, MuxOut[17]);
    mux_2_1 mux_2_1_1_18(in_1[18], in_2[18], Select, MuxOut[18]);
    mux_2_1 mux_2_1_1_19(in_1[19], in_2[19], Select, MuxOut[19]);
    mux_2_1 mux_2_1_2_20(in_1[20], in_2[20], Select, MuxOut[20]);
    mux_2_1 mux_2_1_2_21(in_1[21], in_2[21], Select, MuxOut[21]);
    mux_2_1 mux_2_1_2_22(in_1[22], in_2[22], Select, MuxOut[22]);
    mux_2_1 mux_2_1_2_23(in_1[23], in_2[23], Select, MuxOut[23]);
    mux_2_1 mux_2_1_2_24(in_1[24], in_2[24], Select, MuxOut[24]);
    mux_2_1 mux_2_1_2_25(in_1[25], in_2[25], Select, MuxOut[25]);
    mux_2_1 mux_2_1_2_26(in_1[26], in_2[26], Select, MuxOut[26]);
    mux_2_1 mux_2_1_2_27(in_1[27], in_2[27], Select, MuxOut[27]);
    mux_2_1 mux_2_1_2_28(in_1[28], in_2[28], Select, MuxOut[28]);
    mux_2_1 mux_2_1_2_29(in_1[29], in_2[29], Select, MuxOut[29]);
    mux_2_1 mux_2_1_3_30(in_1[30], in_2[30], Select, MuxOut[30]);
    mux_2_1 mux_2_1_3_31(in_1[31], in_2[31], Select, MuxOut[31]);
endmodule