module alu_cla(input Clk,
           input Reset,
           input [31:0] A,
           input [31:0] B, 
           input [ 2:0] ALUOp,
           output C, //  C32 = 1, if Carry-Out
           output [31:0] Result,
           output We);

    // intermediate wires
    wire [31:0] A_in;
    wire [31:0] B_in;
    wire        Cout;
    wire [31:0]  Sum;
    wire [31:0]  AND;
    wire [31:0]   OR;
    wire [31:0]  XOR;
    wire [31:0]  NOR;
    wire        Less;

    wire Cin;
    wire Sub_En;

    // CLA-32 instantiation
    cla_32 cla_32_inst(A_in, B_in, Cin, Cout, Sum, AND, OR, XOR, NOR);
    
    // Cin selection
    buf Cin_buf(Cin, Sub_En); // basically same as Sub_En

    // Instruction detection for Sub and Less
    wire Sub_Inst, Less_Inst, Mod_Inst;
    not (ALU0_not, ALUOp[0]);
    not (ALU1_not, ALUOp[1]);
    and Sub_Inst_i(Sub_Inst, ALUOp[2], ALUOp[1], ALU0_not);
    and Less_Inst_i(Less_Inst, ALUOp[2], ALU1_not, ALU0_not);
    and Mod_Inst_i(Mod_Inst, ALUOp[0], ALUOp[1], ALUOp[2]);

    or Sub_En_or(Sub_En, Sub_Inst, Less_Inst, Mod_Inst);
    
    // B xor SubEn
	xor B_xor_0( B_in[0],  B[0],  Sub_En);
	xor B_xor_1( B_in[1],  B[1],  Sub_En);
	xor B_xor_2( B_in[2],  B[2],  Sub_En);
	xor B_xor_3( B_in[3],  B[3],  Sub_En);
	xor B_xor_4( B_in[4],  B[4],  Sub_En);
	xor B_xor_5( B_in[5],  B[5],  Sub_En);
	xor B_xor_6( B_in[6],  B[6],  Sub_En);
	xor B_xor_7( B_in[7],  B[7],  Sub_En);
	xor B_xor_8( B_in[8],  B[8],  Sub_En);
	xor B_xor_9( B_in[9],  B[9],  Sub_En);
	xor B_xor_10(B_in[10], B[10], Sub_En);
	xor B_xor_11(B_in[11], B[11], Sub_En);
	xor B_xor_12(B_in[12], B[12], Sub_En);
	xor B_xor_13(B_in[13], B[13], Sub_En);
	xor B_xor_14(B_in[14], B[14], Sub_En);
	xor B_xor_15(B_in[15], B[15], Sub_En);
	xor B_xor_16(B_in[16], B[16], Sub_En);
	xor B_xor_17(B_in[17], B[17], Sub_En);
	xor B_xor_18(B_in[18], B[18], Sub_En);
	xor B_xor_19(B_in[19], B[19], Sub_En);
	xor B_xor_20(B_in[20], B[20], Sub_En);
	xor B_xor_21(B_in[21], B[21], Sub_En);
	xor B_xor_22(B_in[22], B[22], Sub_En);
	xor B_xor_23(B_in[23], B[23], Sub_En);
	xor B_xor_24(B_in[24], B[24], Sub_En);
	xor B_xor_25(B_in[25], B[25], Sub_En);
	xor B_xor_26(B_in[26], B[26], Sub_En);
	xor B_xor_27(B_in[27], B[27], Sub_En);
	xor B_xor_28(B_in[28], B[28], Sub_En);
	xor B_xor_29(B_in[29], B[29], Sub_En);
	xor B_xor_30(B_in[30], B[30], Sub_En);
	xor B_xor_31(B_in[31], B[31], Sub_En);

    // Less logic
    buf Less_0(Less, Sum[31]);

    // Mod
    wire We_Mod;
    wire [31:0] Mod_Result;
    wire [31:0] Dp_Result_reg;
    mod mod_inst(Clk, Reset, Mod_Inst, A, B, Sum, Dp_Result_reg, Mod_Result, We_Mod);

    // A Selection, 2:1 32-bit Mux
    mux_2_1 mux_2_1_0(A[0],    Dp_Result_reg[0], Mod_Inst, A_in[0]);
    mux_2_1 mux_2_1_1(A[1],    Dp_Result_reg[1], Mod_Inst, A_in[1]);
    mux_2_1 mux_2_1_2(A[2],    Dp_Result_reg[2], Mod_Inst, A_in[2]);
    mux_2_1 mux_2_1_3(A[3],    Dp_Result_reg[3], Mod_Inst, A_in[3]);
    mux_2_1 mux_2_1_4(A[4],    Dp_Result_reg[4], Mod_Inst, A_in[4]);
    mux_2_1 mux_2_1_5(A[5],    Dp_Result_reg[5], Mod_Inst, A_in[5]);
    mux_2_1 mux_2_1_6(A[6],    Dp_Result_reg[6], Mod_Inst, A_in[6]);
    mux_2_1 mux_2_1_7(A[7],    Dp_Result_reg[7], Mod_Inst, A_in[7]);
    mux_2_1 mux_2_1_8(A[8],    Dp_Result_reg[8], Mod_Inst, A_in[8]);
    mux_2_1 mux_2_1_9(A[9],    Dp_Result_reg[9], Mod_Inst, A_in[9]);
    mux_2_1 mux_2_1_10(A[10], Dp_Result_reg[10], Mod_Inst, A_in[10]);
    mux_2_1 mux_2_1_11(A[11], Dp_Result_reg[11], Mod_Inst, A_in[11]);
    mux_2_1 mux_2_1_12(A[12], Dp_Result_reg[12], Mod_Inst, A_in[12]);
    mux_2_1 mux_2_1_13(A[13], Dp_Result_reg[13], Mod_Inst, A_in[13]);
    mux_2_1 mux_2_1_14(A[14], Dp_Result_reg[14], Mod_Inst, A_in[14]);
    mux_2_1 mux_2_1_15(A[15], Dp_Result_reg[15], Mod_Inst, A_in[15]);
    mux_2_1 mux_2_1_16(A[16], Dp_Result_reg[16], Mod_Inst, A_in[16]);
    mux_2_1 mux_2_1_17(A[17], Dp_Result_reg[17], Mod_Inst, A_in[17]);
    mux_2_1 mux_2_1_18(A[18], Dp_Result_reg[18], Mod_Inst, A_in[18]);
    mux_2_1 mux_2_1_19(A[19], Dp_Result_reg[19], Mod_Inst, A_in[19]);
    mux_2_1 mux_2_1_20(A[20], Dp_Result_reg[20], Mod_Inst, A_in[20]);
    mux_2_1 mux_2_1_21(A[21], Dp_Result_reg[21], Mod_Inst, A_in[21]);
    mux_2_1 mux_2_1_22(A[22], Dp_Result_reg[22], Mod_Inst, A_in[22]);
    mux_2_1 mux_2_1_23(A[23], Dp_Result_reg[23], Mod_Inst, A_in[23]);
    mux_2_1 mux_2_1_24(A[24], Dp_Result_reg[24], Mod_Inst, A_in[24]);
    mux_2_1 mux_2_1_25(A[25], Dp_Result_reg[25], Mod_Inst, A_in[25]);
    mux_2_1 mux_2_1_26(A[26], Dp_Result_reg[26], Mod_Inst, A_in[26]);
    mux_2_1 mux_2_1_27(A[27], Dp_Result_reg[27], Mod_Inst, A_in[27]);
    mux_2_1 mux_2_1_28(A[28], Dp_Result_reg[28], Mod_Inst, A_in[28]);
    mux_2_1 mux_2_1_29(A[29], Dp_Result_reg[29], Mod_Inst, A_in[29]);
    mux_2_1 mux_2_1_30(A[30], Dp_Result_reg[30], Mod_Inst, A_in[30]);
    mux_2_1 mux_2_1_31(A[31], Dp_Result_reg[31], Mod_Inst, A_in[31]);
    
    // We selection
    // 2:1 Mux for Write Enable, We
    // Mod_Inst We
    // 0        1
    // 1        We_Mod
    mux_2_1 mux_2_1_We(1, We_Mod, Mod_Inst, We);
    //not Mod_En_not(ModEn_not, Mod_Inst);
    //and Mod_We_and(We_Mod_En, Mod_Inst,  We_Mod);
    //or  We_or     (We, ModEn_not, We_Mod_En);

    // 8:1 32-bit Mux for Result
    mux8x1x32 mux8x1x32_inst(AND, OR, XOR, NOR, Less, Sum, Sum, Mod_Result, ALUOp, Result);

endmodule