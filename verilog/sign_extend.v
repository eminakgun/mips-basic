module sign_extend (
    output [31:0] sign_ext_imm,
    input  [15:0] imm
);

    buf  sign_ext_imm_0(sign_ext_imm[0],  imm[0]);
    buf  sign_ext_imm_1(sign_ext_imm[1],  imm[1]);
    buf  sign_ext_imm_2(sign_ext_imm[2],  imm[2]);
    buf  sign_ext_imm_3(sign_ext_imm[3],  imm[3]);
    buf  sign_ext_imm_4(sign_ext_imm[4],  imm[4]);
    buf  sign_ext_imm_5(sign_ext_imm[5],  imm[5]);
    buf  sign_ext_imm_6(sign_ext_imm[6],  imm[6]);
    buf  sign_ext_imm_7(sign_ext_imm[7],  imm[7]);
    buf  sign_ext_imm_8(sign_ext_imm[8],  imm[8]);
    buf  sign_ext_imm_9(sign_ext_imm[9],  imm[9]);
    buf sign_ext_imm_10(sign_ext_imm[10], imm[10]);
    buf sign_ext_imm_11(sign_ext_imm[11], imm[11]);
    buf sign_ext_imm_12(sign_ext_imm[12], imm[12]);
    buf sign_ext_imm_13(sign_ext_imm[13], imm[13]);
    buf sign_ext_imm_14(sign_ext_imm[14], imm[14]);
    buf sign_ext_imm_15(sign_ext_imm[15], imm[15]);
    buf sign_ext_imm_16(sign_ext_imm[16], imm[15]);
    buf sign_ext_imm_17(sign_ext_imm[17], imm[15]);
    buf sign_ext_imm_18(sign_ext_imm[18], imm[15]);
    buf sign_ext_imm_19(sign_ext_imm[19], imm[15]);
    buf sign_ext_imm_20(sign_ext_imm[20], imm[15]);
    buf sign_ext_imm_21(sign_ext_imm[21], imm[15]);
    buf sign_ext_imm_22(sign_ext_imm[22], imm[15]);
    buf sign_ext_imm_23(sign_ext_imm[23], imm[15]);
    buf sign_ext_imm_24(sign_ext_imm[24], imm[15]);
    buf sign_ext_imm_25(sign_ext_imm[25], imm[15]);
    buf sign_ext_imm_26(sign_ext_imm[26], imm[15]);
    buf sign_ext_imm_27(sign_ext_imm[27], imm[15]);
    buf sign_ext_imm_28(sign_ext_imm[28], imm[15]);
    buf sign_ext_imm_29(sign_ext_imm[29], imm[15]);
    buf sign_ext_imm_30(sign_ext_imm[30], imm[15]);
    buf sign_ext_imm_31(sign_ext_imm[31], imm[15]);
    
    
endmodule