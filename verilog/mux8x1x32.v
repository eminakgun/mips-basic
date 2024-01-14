module mux8x1x32 (
    input  [31:0] In_0,
    input  [31:0] In_1,
    input  [31:0] In_2,
    input  [31:0] In_3,
    input  [31:0] In_4,
    input  [31:0] In_5,
    input  [31:0] In_6,
    input  [31:0] In_7,
    input  [ 2:0]  Sel,
    output [31:0] Out
);

    mux8x1x1 mux8x1x1_0 ( In_0[0],  In_1[0],  In_2[0],  In_3[0],  In_4[0],  In_5[0],  In_6[0],  In_7[0], Sel,  Out[0]);
    mux8x1x1 mux8x1x1_1 ( In_0[1],  In_1[1],  In_2[1],  In_3[1],  In_4[1],  In_5[1],  In_6[1],  In_7[1], Sel,  Out[1]);
    mux8x1x1 mux8x1x1_2 ( In_0[2],  In_1[2],  In_2[2],  In_3[2],  In_4[2],  In_5[2],  In_6[2],  In_7[2], Sel,  Out[2]);
    mux8x1x1 mux8x1x1_3 ( In_0[3],  In_1[3],  In_2[3],  In_3[3],  In_4[3],  In_5[3],  In_6[3],  In_7[3], Sel,  Out[3]);
    mux8x1x1 mux8x1x1_4 ( In_0[4],  In_1[4],  In_2[4],  In_3[4],  In_4[4],  In_5[4],  In_6[4],  In_7[4], Sel,  Out[4]);
    mux8x1x1 mux8x1x1_5 ( In_0[5],  In_1[5],  In_2[5],  In_3[5],  In_4[5],  In_5[5],  In_6[5],  In_7[5], Sel,  Out[5]);
    mux8x1x1 mux8x1x1_6 ( In_0[6],  In_1[6],  In_2[6],  In_3[6],  In_4[6],  In_5[6],  In_6[6],  In_7[6], Sel,  Out[6]);
    mux8x1x1 mux8x1x1_7 ( In_0[7],  In_1[7],  In_2[7],  In_3[7],  In_4[7],  In_5[7],  In_6[7],  In_7[7], Sel,  Out[7]);
    mux8x1x1 mux8x1x1_8 ( In_0[8],  In_1[8],  In_2[8],  In_3[8],  In_4[8],  In_5[8],  In_6[8],  In_7[8], Sel,  Out[8]);
    mux8x1x1 mux8x1x1_9 ( In_0[9],  In_1[9],  In_2[9],  In_3[9],  In_4[9],  In_5[9],  In_6[9],  In_7[9], Sel,  Out[9]);
    mux8x1x1 mux8x1x1_10(In_0[10], In_1[10], In_2[10], In_3[10], In_4[10], In_5[10], In_6[10], In_7[10], Sel, Out[10]);
    mux8x1x1 mux8x1x1_11(In_0[11], In_1[11], In_2[11], In_3[11], In_4[11], In_5[11], In_6[11], In_7[11], Sel, Out[11]);
    mux8x1x1 mux8x1x1_12(In_0[12], In_1[12], In_2[12], In_3[12], In_4[12], In_5[12], In_6[12], In_7[12], Sel, Out[12]);
    mux8x1x1 mux8x1x1_13(In_0[13], In_1[13], In_2[13], In_3[13], In_4[13], In_5[13], In_6[13], In_7[13], Sel, Out[13]);
    mux8x1x1 mux8x1x1_14(In_0[14], In_1[14], In_2[14], In_3[14], In_4[14], In_5[14], In_6[14], In_7[14], Sel, Out[14]);
    mux8x1x1 mux8x1x1_15(In_0[15], In_1[15], In_2[15], In_3[15], In_4[15], In_5[15], In_6[15], In_7[15], Sel, Out[15]);
    mux8x1x1 mux8x1x1_16(In_0[16], In_1[16], In_2[16], In_3[16], In_4[16], In_5[16], In_6[16], In_7[16], Sel, Out[16]);
    mux8x1x1 mux8x1x1_17(In_0[17], In_1[17], In_2[17], In_3[17], In_4[17], In_5[17], In_6[17], In_7[17], Sel, Out[17]);
    mux8x1x1 mux8x1x1_18(In_0[18], In_1[18], In_2[18], In_3[18], In_4[18], In_5[18], In_6[18], In_7[18], Sel, Out[18]);
    mux8x1x1 mux8x1x1_19(In_0[19], In_1[19], In_2[19], In_3[19], In_4[19], In_5[19], In_6[19], In_7[19], Sel, Out[19]);
    mux8x1x1 mux8x1x1_20(In_0[20], In_1[20], In_2[20], In_3[20], In_4[20], In_5[20], In_6[20], In_7[20], Sel, Out[20]);
    mux8x1x1 mux8x1x1_21(In_0[21], In_1[21], In_2[21], In_3[21], In_4[21], In_5[21], In_6[21], In_7[21], Sel, Out[21]);
    mux8x1x1 mux8x1x1_22(In_0[22], In_1[22], In_2[22], In_3[22], In_4[22], In_5[22], In_6[22], In_7[22], Sel, Out[22]);
    mux8x1x1 mux8x1x1_23(In_0[23], In_1[23], In_2[23], In_3[23], In_4[23], In_5[23], In_6[23], In_7[23], Sel, Out[23]);
    mux8x1x1 mux8x1x1_24(In_0[24], In_1[24], In_2[24], In_3[24], In_4[24], In_5[24], In_6[24], In_7[24], Sel, Out[24]);
    mux8x1x1 mux8x1x1_25(In_0[25], In_1[25], In_2[25], In_3[25], In_4[25], In_5[25], In_6[25], In_7[25], Sel, Out[25]);
    mux8x1x1 mux8x1x1_26(In_0[26], In_1[26], In_2[26], In_3[26], In_4[26], In_5[26], In_6[26], In_7[26], Sel, Out[26]);
    mux8x1x1 mux8x1x1_27(In_0[27], In_1[27], In_2[27], In_3[27], In_4[27], In_5[27], In_6[27], In_7[27], Sel, Out[27]);
    mux8x1x1 mux8x1x1_28(In_0[28], In_1[28], In_2[28], In_3[28], In_4[28], In_5[28], In_6[28], In_7[28], Sel, Out[28]);
    mux8x1x1 mux8x1x1_29(In_0[29], In_1[29], In_2[29], In_3[29], In_4[29], In_5[29], In_6[29], In_7[29], Sel, Out[29]);
    mux8x1x1 mux8x1x1_30(In_0[30], In_1[30], In_2[30], In_3[30], In_4[30], In_5[30], In_6[30], In_7[30], Sel, Out[30]);
    mux8x1x1 mux8x1x1_31(In_0[31], In_1[31], In_2[31], In_3[31], In_4[31], In_5[31], In_6[31], In_7[31], Sel, Out[31]);

    
endmodule