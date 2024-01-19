module mips (
    input clock
);

// Wire Declarations

// instruction_block
wire [31:0] instruction;
reg  [31:0] pc=0;

// register_block
wire [31:0] read_data1;
wire [31:0] read_data2;
wire [31:0] write_data;
wire [4:0] read_reg1;
wire [4:0] read_reg2;
wire [4:0] write_reg;
wire regWrite;

// control_unit
wire       regDst;
wire       branch;
wire       memRead;
wire       memWrite;
wire [2:0] ALUop;
wire       ALUsrc;
wire [5:0] opcode;

// sign-extend
wire[31:0] sign_ext_imm;
wire[15:0] imm;

// alu
wire [31:0] alu_result;
wire        zero_bit;
wire [31:0] alu_src1;
wire [31:0] alu_src2;

// alu control
wire [2:0] alu_ctr;
wire [5:0] function_code;

// memory block
wire [31:0] read_data_mem;
wire [17:0] address;

wire move;
//assign move = (opcode == 6'b100000);
wire [4:0] move_opcode;
not move_opcode_i0(move_opcode[0], opcode[0]);
not move_opcode_i1(move_opcode[1], opcode[1]);
not move_opcode_i2(move_opcode[2], opcode[2]);
not move_opcode_i3(move_opcode[3], opcode[3]);
not move_opcode_i4(move_opcode[4], opcode[4]);
and move_final_i(move, move_opcode[0], opcode[5], 
                       move_opcode[1], move_opcode[2], 
                       move_opcode[3], move_opcode[4]);


// Logic Blocks

// Program counter logic
// TODO Convert into structural

// 1- PC + 4
wire [31:0] pc_plus_4;
//assign pc_plus_4 = pc + 4;
alu_cla alu_pc_plus_4(,, pc, 4, 3'd5,, pc_plus_4,);

// 2- Shift left Sign extended immed value and add PC
wire [31:0] branch_addr;
//assign branch_addr = pc_plus_4 + sign_ext_imm;
alu_cla alu_branch_addr(,, pc_plus_4, sign_ext_imm, 3'd5,, branch_addr,);

// 3- Selection logic that connects to PC register
//    based on Branch bit and Zero bit outputs
wire zerobit_n;
not not_zero(zerobit_n, zero_bit);

wire branch_eq_or_ne;
wire [5:0] opcode_i;
buf opcode_0_i (opcode_i[0], opcode[0]);
buf opcode_1_i (opcode_i[1], opcode[1]);
not opcode_2_ni(opcode_i[2], opcode[2]);
not opcode_3_ni(opcode_i[3], opcode[3]);
not opcode_4_i (opcode_i[4], opcode[4]);
buf opcode_5_i (opcode_i[5], opcode[5]);

wire opcode_branch;
and opcode_c_i(opcode_branch, opcode_i[0], opcode_i[1], opcode_i[2], opcode_i[3], 
                              opcode_i[4], opcode_i[5]);
mux_2_1 mux_branch_eq_or_ne(zerobit_n, zero_bit, opcode_branch, branch_eq_or_ne);

//assign branch_eq_or_ne = (opcode == 6'b100011) ? zero_bit : zerobit_n;

wire branch_select;
and and_branch_select(branch_select, branch_eq_or_ne, branch);

// Jump and link

wire jal;
wire jal_0;
wire jal_1;
wire jal_2;
wire jal_3;
wire jal_4;
wire jal_5;

buf jal_0_i(jal_0, instruction[26]);
not jal_1_i(jal_1, instruction[27]);
not jal_2_i(jal_2, instruction[28]);
buf jal_3_i(jal_3, instruction[29]);
buf jal_4_i(jal_4, instruction[30]);
buf jal_5_i(jal_5, instruction[31]);
and jal_i(jal, jal_0, jal_1, jal_2, jal_3, jal_4, jal_5);

// Jump register
wire jr;
wire [6:0] jri;
not jri_0_i(jri[0], instruction[26]);
not jri_1_i(jri[1], instruction[27]);
not jri_2_i(jri[2], instruction[28]);
not jri_3_i(jri[3], instruction[29]);
not jri_4_i(jri[4], instruction[30]);
not jri_5_i(jri[5], instruction[31]);

and jri_i(jri[6], jri[0], jri[1], jri[2], jri[3], jri[4], jri[5]);

wire [6:0] jrf;
not jrf_0_i(jrf[0],function_code[0]);
not jrf_1_i(jrf[1],function_code[1]);
not jrf_2_i(jrf[2],function_code[2]);
buf jrf_3_i(jrf[3],function_code[3]);
not jrf_4_i(jrf[4],function_code[4]);
not jrf_5_i(jrf[5],function_code[5]);

and jrf_i(jrf[6], jrf[0], jrf[1], jrf[2], jrf[3], jrf[4], jrf[5]);

and jr_i(jr, jri[6], jrf[6]);

// wire jr;
// assign jr = instruction[31:26] == 6'b000000 && function_code == 6'b001000;

// overwrite regWrite for jump operations
wire reg_block_we;
// assign reg_block_we = jr ? 1'b0 : jal == 1'b1 ? 1'b1
//                                               : regWrite;
wire jal_o;
wire jr_n;

or jal_mi_i(jal_o, jal, regWrite);
not jr_n_i(jr_n, jr);
and reg_block_we_i(reg_block_we, jr_n, jal_o);

// pc assignment logic
wire jump_cu;
wire [31:0] jump_address;

//assign jump_address = jump_cu ? {{6{1'b0}},instruction[25:0]} 
//                              : read_data1; // Jump Register
mux_2_1 m21_ja0( read_data1[0],  instruction[0],  jump_cu,  jump_address[0]);
mux_2_1 m21_ja1( read_data1[1],  instruction[1],  jump_cu,  jump_address[1]);
mux_2_1 m21_ja2( read_data1[2],  instruction[2],  jump_cu,  jump_address[2]);
mux_2_1 m21_ja3( read_data1[3],  instruction[3],  jump_cu,  jump_address[3]);
mux_2_1 m21_ja4( read_data1[4],  instruction[4],  jump_cu,  jump_address[4]);
mux_2_1 m21_ja5( read_data1[5],  instruction[5],  jump_cu,  jump_address[5]);
mux_2_1 m21_ja6( read_data1[6],  instruction[6],  jump_cu,  jump_address[6]);
mux_2_1 m21_ja7( read_data1[7],  instruction[7],  jump_cu,  jump_address[7]);
mux_2_1 m21_ja8( read_data1[8],  instruction[8],  jump_cu,  jump_address[8]);
mux_2_1 m21_ja9( read_data1[9],  instruction[9],  jump_cu,  jump_address[9]);
mux_2_1 m21_ja10(read_data1[10], instruction[10], jump_cu, jump_address[10]);
mux_2_1 m21_ja11(read_data1[11], instruction[11], jump_cu, jump_address[11]);
mux_2_1 m21_ja12(read_data1[12], instruction[12], jump_cu, jump_address[12]);
mux_2_1 m21_ja13(read_data1[13], instruction[13], jump_cu, jump_address[13]);
mux_2_1 m21_ja14(read_data1[14], instruction[14], jump_cu, jump_address[14]);
mux_2_1 m21_ja15(read_data1[15], instruction[15], jump_cu, jump_address[15]);
mux_2_1 m21_ja16(read_data1[16], instruction[16], jump_cu, jump_address[16]);
mux_2_1 m21_ja17(read_data1[17], instruction[17], jump_cu, jump_address[17]);
mux_2_1 m21_ja18(read_data1[18], instruction[18], jump_cu, jump_address[18]);
mux_2_1 m21_ja19(read_data1[19], instruction[19], jump_cu, jump_address[19]);
mux_2_1 m21_ja20(read_data1[20], instruction[20], jump_cu, jump_address[20]);
mux_2_1 m21_ja21(read_data1[21], instruction[21], jump_cu, jump_address[21]);
mux_2_1 m21_ja22(read_data1[22], instruction[22], jump_cu, jump_address[22]);
mux_2_1 m21_ja23(read_data1[23], instruction[23], jump_cu, jump_address[23]);
mux_2_1 m21_ja24(read_data1[24], instruction[24], jump_cu, jump_address[24]);
mux_2_1 m21_ja25(read_data1[25], instruction[25], jump_cu, jump_address[25]);
mux_2_1 m21_ja26(read_data1[26],            1'b0, jump_cu, jump_address[26]);
mux_2_1 m21_ja27(read_data1[27],            1'b0, jump_cu, jump_address[27]);
mux_2_1 m21_ja28(read_data1[28],            1'b0, jump_cu, jump_address[28]);
mux_2_1 m21_ja29(read_data1[29],            1'b0, jump_cu, jump_address[29]);
mux_2_1 m21_ja30(read_data1[30],            1'b0, jump_cu, jump_address[30]);
mux_2_1 m21_ja31(read_data1[31],            1'b0, jump_cu, jump_address[31]);

// Jump & PC
wire jump_final;
// assign jump_final = jr ? 1'b1 : jump_cu;
or jump_final_i(jump_final, jr, jump_cu);

wire [31:0] pc_final;
// assign pc_final = jump_final ? jump_address
//                              : branch_select ? branch_addr : pc_plus_4;

wire [31:0] branch_or_pc4;
mux_2_1_32 m21_branch(pc_plus_4, branch_addr, branch_select, branch_or_pc4);
mux_2_1_32 m21_pc_final(branch_or_pc4, jump_address, jump_final, pc_final); // jump or branch


// PC register
always @(posedge clock) begin
    pc <= pc_final;
end

// Instruction block
instruction_block inst_block_i(instruction, pc);

// Slice instruction logic
// assign opcode = instruction[31:26];
// assign read_reg1 = instruction[25:21];
// assign read_reg2 = instruction[20:16];

buf opcode_b0(opcode[0], instruction[26]);
buf opcode_b1(opcode[1], instruction[27]);
buf opcode_b2(opcode[2], instruction[28]);
buf opcode_b3(opcode[3], instruction[29]);
buf opcode_b4(opcode[4], instruction[30]);
buf opcode_b5(opcode[5], instruction[31]);

buf read_reg1_b0(read_reg1[0], instruction[21]);
buf read_reg1_b1(read_reg1[1], instruction[22]);
buf read_reg1_b2(read_reg1[2], instruction[23]);
buf read_reg1_b3(read_reg1[3], instruction[24]);
buf read_reg1_b4(read_reg1[4], instruction[25]);

buf read_reg2_b0(read_reg2[0], instruction[16]);
buf read_reg2_b1(read_reg2[1], instruction[17]);
buf read_reg2_b2(read_reg2[2], instruction[18]);
buf read_reg2_b3(read_reg2[3], instruction[19]);
buf read_reg2_b4(read_reg2[4], instruction[20]);


// Write register/data logic
// TODO use 4x1 muxes
//assign write_reg = jal == 1'b1 ? 5'd31 // Ra adress
//                               : move ? instruction[25:21]
//                                      : regDst == 1'b1 ? instruction[15:11] 
//                                                       : instruction[20:16];
// stage-1 mux, regDst selection
wire [4:0] write_reg_s0;
mux_2_1 m21_write_reg_s0_0 (  instruction[16],  instruction[11], regDst, write_reg_s0[0]);
mux_2_1 m21_write_reg_s0_1 (  instruction[17],  instruction[12], regDst, write_reg_s0[1]);
mux_2_1 m21_write_reg_s0_2 (  instruction[18],  instruction[13], regDst, write_reg_s0[2]);
mux_2_1 m21_write_reg_s0_3 (  instruction[19],  instruction[14], regDst, write_reg_s0[3]);
mux_2_1 m21_write_reg_s0_4 (  instruction[20],  instruction[15], regDst, write_reg_s0[4]);


// stage-2 mux, move selection, instruction[25:21]
wire [4:0] write_reg_s1;
mux_2_1 m21_write_reg_s1_0 ( write_reg_s0[0],  instruction[21], move, write_reg_s1[0]);
mux_2_1 m21_write_reg_s1_1 ( write_reg_s0[1],  instruction[22], move, write_reg_s1[1]);
mux_2_1 m21_write_reg_s1_2 ( write_reg_s0[2],  instruction[23], move, write_reg_s1[2]);
mux_2_1 m21_write_reg_s1_3 ( write_reg_s0[3],  instruction[24], move, write_reg_s1[3]);
mux_2_1 m21_write_reg_s1_4 ( write_reg_s0[4],  instruction[25], move, write_reg_s1[4]);


// Final stage-3 mux, jal selection, 5'd31 // Ra adress
wire [4:0] write_reg_s2;
mux_2_1 m21_write_reg_0 ( write_reg_s1[0],  1'b1, jal, write_reg[0]);
mux_2_1 m21_write_reg_1 ( write_reg_s1[1],  1'b1, jal, write_reg[1]);
mux_2_1 m21_write_reg_2 ( write_reg_s1[2],  1'b1, jal, write_reg[2]);
mux_2_1 m21_write_reg_3 ( write_reg_s1[3],  1'b1, jal, write_reg[3]);
mux_2_1 m21_write_reg_4 ( write_reg_s1[4],  1'b1, jal, write_reg[4]);


register_block reg_block_i(read_data1, read_data2, write_data, 
                            read_reg1, read_reg2, write_reg, reg_block_we);

control_unit ctrl_unit_i(regDst, branch, memRead, memWrite, 
                            ALUop, ALUsrc, regWrite, jump_cu, opcode);

// TODO Convert into structural, use buffer
// assign imm = instruction[15:0];
buf imm_b0(imm[0], instruction[0]);
buf imm_b1(imm[1], instruction[1]);
buf imm_b2(imm[2], instruction[2]);
buf imm_b3(imm[3], instruction[3]);
buf imm_b4(imm[4], instruction[4]);
buf imm_b5(imm[5], instruction[5]);
buf imm_b6(imm[6], instruction[6]);
buf imm_b7(imm[7], instruction[7]);
buf imm_b8(imm[8], instruction[8]);
buf imm_b9(imm[9], instruction[9]);
buf imm_b10(imm[10], instruction[10]);
buf imm_b11(imm[11], instruction[11]);
buf imm_b12(imm[12], instruction[12]);
buf imm_b13(imm[13], instruction[13]);
buf imm_b14(imm[14], instruction[14]);
buf imm_b15(imm[15], instruction[15]);

sign_extend sign_extend_i(sign_ext_imm, imm);

// Alu 2nd operand selection logic
// TODO use 2x1 mux
//assign alu_src2 = ALUsrc == 1'b0 ? read_data2 : sign_ext_imm;
wire [31:0] alu_src;
mux_2_1 m21_alu_src0 (   read_data2[0],  sign_ext_imm[0], ALUsrc,  alu_src[0]);
mux_2_1 m21_alu_src1 (   read_data2[1],  sign_ext_imm[1], ALUsrc,  alu_src[1]);
mux_2_1 m21_alu_src2 (   read_data2[2],  sign_ext_imm[2], ALUsrc,  alu_src[2]);
mux_2_1 m21_alu_src3 (   read_data2[3],  sign_ext_imm[3], ALUsrc,  alu_src[3]);
mux_2_1 m21_alu_src4 (   read_data2[4],  sign_ext_imm[4], ALUsrc,  alu_src[4]);
mux_2_1 m21_alu_src5 (   read_data2[5],  sign_ext_imm[5], ALUsrc,  alu_src[5]);
mux_2_1 m21_alu_src6 (   read_data2[6],  sign_ext_imm[6], ALUsrc,  alu_src[6]);
mux_2_1 m21_alu_src7 (   read_data2[7],  sign_ext_imm[7], ALUsrc,  alu_src[7]);
mux_2_1 m21_alu_src8 (   read_data2[8],  sign_ext_imm[8], ALUsrc,  alu_src[8]);
mux_2_1 m21_alu_src9 (   read_data2[9],  sign_ext_imm[9], ALUsrc,  alu_src[9]);
mux_2_1 m21_alu_src10(  read_data2[10], sign_ext_imm[10], ALUsrc, alu_src[10]);
mux_2_1 m21_alu_src11(  read_data2[11], sign_ext_imm[11], ALUsrc, alu_src[11]);
mux_2_1 m21_alu_src12(  read_data2[12], sign_ext_imm[12], ALUsrc, alu_src[12]);
mux_2_1 m21_alu_src13(  read_data2[13], sign_ext_imm[13], ALUsrc, alu_src[13]);
mux_2_1 m21_alu_src14(  read_data2[14], sign_ext_imm[14], ALUsrc, alu_src[14]);
mux_2_1 m21_alu_src15(  read_data2[15], sign_ext_imm[15], ALUsrc, alu_src[15]);
mux_2_1 m21_alu_src16(  read_data2[16], sign_ext_imm[16], ALUsrc, alu_src[16]);
mux_2_1 m21_alu_src17(  read_data2[17], sign_ext_imm[17], ALUsrc, alu_src[17]);
mux_2_1 m21_alu_src18(  read_data2[18], sign_ext_imm[18], ALUsrc, alu_src[18]);
mux_2_1 m21_alu_src19(  read_data2[19], sign_ext_imm[19], ALUsrc, alu_src[19]);
mux_2_1 m21_alu_src20(  read_data2[20], sign_ext_imm[20], ALUsrc, alu_src[20]);
mux_2_1 m21_alu_src21(  read_data2[21], sign_ext_imm[21], ALUsrc, alu_src[21]);
mux_2_1 m21_alu_src22(  read_data2[22], sign_ext_imm[22], ALUsrc, alu_src[22]);
mux_2_1 m21_alu_src23(  read_data2[23], sign_ext_imm[23], ALUsrc, alu_src[23]);
mux_2_1 m21_alu_src24(  read_data2[24], sign_ext_imm[24], ALUsrc, alu_src[24]);
mux_2_1 m21_alu_src25(  read_data2[25], sign_ext_imm[25], ALUsrc, alu_src[25]);
mux_2_1 m21_alu_src26(  read_data2[26], sign_ext_imm[26], ALUsrc, alu_src[26]);
mux_2_1 m21_alu_src27(  read_data2[27], sign_ext_imm[27], ALUsrc, alu_src[27]);
mux_2_1 m21_alu_src28(  read_data2[28], sign_ext_imm[28], ALUsrc, alu_src[28]);
mux_2_1 m21_alu_src29(  read_data2[29], sign_ext_imm[29], ALUsrc, alu_src[29]);
mux_2_1 m21_alu_src30(  read_data2[30], sign_ext_imm[30], ALUsrc, alu_src[30]);
mux_2_1 m21_alu_src31(  read_data2[31], sign_ext_imm[31], ALUsrc, alu_src[31]);

alu alu_i(alu_result, zero_bit, read_data1, alu_src, alu_ctr);

// Alu Control
buf function_code_0(function_code[0], instruction[0]);
buf function_code_1(function_code[1], instruction[1]);
buf function_code_2(function_code[2], instruction[2]);
buf function_code_3(function_code[3], instruction[3]);
buf function_code_4(function_code[4], instruction[4]);
buf function_code_5(function_code[5], instruction[5]);
alu_control alu_ctrl_i(alu_ctr, function_code, ALUop);

// address = alu_result[17:0]
// write_data = read_data2;
memory_block mem_block_i(read_data_mem, alu_result[17:0], read_data2, memRead, memWrite);


// reg block write_data
//assign write_data = move ? read_data2 
//                         : jal == 1'b1 ? pc_plus_4 
//                                       : memRead == 1'b1 ? read_data_mem
//                                                         : alu_result;

// stage-1 mux
wire [31:0] write_data_s0;
mux_2_1 m21_write_data_s0_0 (  alu_result[0],  read_data_mem[0], memRead, write_data_s0[0]);
mux_2_1 m21_write_data_s0_1 (  alu_result[1],  read_data_mem[1], memRead, write_data_s0[1]);
mux_2_1 m21_write_data_s0_2 (  alu_result[2],  read_data_mem[2], memRead, write_data_s0[2]);
mux_2_1 m21_write_data_s0_3 (  alu_result[3],  read_data_mem[3], memRead, write_data_s0[3]);
mux_2_1 m21_write_data_s0_4 (  alu_result[4],  read_data_mem[4], memRead, write_data_s0[4]);
mux_2_1 m21_write_data_s0_5 (  alu_result[5],  read_data_mem[5], memRead, write_data_s0[5]);
mux_2_1 m21_write_data_s0_6 (  alu_result[6],  read_data_mem[6], memRead, write_data_s0[6]);
mux_2_1 m21_write_data_s0_7 (  alu_result[7],  read_data_mem[7], memRead, write_data_s0[7]);
mux_2_1 m21_write_data_s0_8 (  alu_result[8],  read_data_mem[8], memRead, write_data_s0[8]);
mux_2_1 m21_write_data_s0_9 (  alu_result[9],  read_data_mem[9], memRead, write_data_s0[9]);
mux_2_1 m21_1write_data_s0_0( alu_result[10], read_data_mem[10], memRead, write_data_s0[10]);
mux_2_1 m21_1write_data_s0_1( alu_result[11], read_data_mem[11], memRead, write_data_s0[11]);
mux_2_1 m21_1write_data_s0_2( alu_result[12], read_data_mem[12], memRead, write_data_s0[12]);
mux_2_1 m21_1write_data_s0_3( alu_result[13], read_data_mem[13], memRead, write_data_s0[13]);
mux_2_1 m21_1write_data_s0_4( alu_result[14], read_data_mem[14], memRead, write_data_s0[14]);
mux_2_1 m21_1write_data_s0_5( alu_result[15], read_data_mem[15], memRead, write_data_s0[15]);
mux_2_1 m21_1write_data_s0_6( alu_result[16], read_data_mem[16], memRead, write_data_s0[16]);
mux_2_1 m21_1write_data_s0_7( alu_result[17], read_data_mem[17], memRead, write_data_s0[17]);
mux_2_1 m21_1write_data_s0_8( alu_result[18], read_data_mem[18], memRead, write_data_s0[18]);
mux_2_1 m21_1write_data_s0_9( alu_result[19], read_data_mem[19], memRead, write_data_s0[19]);
mux_2_1 m21_2write_data_s0_0( alu_result[20], read_data_mem[20], memRead, write_data_s0[20]);
mux_2_1 m21_2write_data_s0_1( alu_result[21], read_data_mem[21], memRead, write_data_s0[21]);
mux_2_1 m21_2write_data_s0_2( alu_result[22], read_data_mem[22], memRead, write_data_s0[22]);
mux_2_1 m21_2write_data_s0_3( alu_result[23], read_data_mem[23], memRead, write_data_s0[23]);
mux_2_1 m21_2write_data_s0_4( alu_result[24], read_data_mem[24], memRead, write_data_s0[24]);
mux_2_1 m21_2write_data_s0_5( alu_result[25], read_data_mem[25], memRead, write_data_s0[25]);
mux_2_1 m21_2write_data_s0_6( alu_result[26], read_data_mem[26], memRead, write_data_s0[26]);
mux_2_1 m21_2write_data_s0_7( alu_result[27], read_data_mem[27], memRead, write_data_s0[27]);
mux_2_1 m21_2write_data_s0_8( alu_result[28], read_data_mem[28], memRead, write_data_s0[28]);
mux_2_1 m21_2write_data_s0_9( alu_result[29], read_data_mem[29], memRead, write_data_s0[29]);
mux_2_1 m21_3write_data_s0_0( alu_result[30], read_data_mem[30], memRead, write_data_s0[30]);
mux_2_1 m21_3write_data_s0_1( alu_result[31], read_data_mem[31], memRead, write_data_s0[31]);


// stage-2 mux, jal selection
wire [31:0] write_data_s1;
mux_2_1 m21_write_data_s1_0 ( write_data_s0[0],  pc_plus_4[0], jal, write_data_s1[0]);
mux_2_1 m21_write_data_s1_1 ( write_data_s0[1],  pc_plus_4[1], jal, write_data_s1[1]);
mux_2_1 m21_write_data_s1_2 ( write_data_s0[2],  pc_plus_4[2], jal, write_data_s1[2]);
mux_2_1 m21_write_data_s1_3 ( write_data_s0[3],  pc_plus_4[3], jal, write_data_s1[3]);
mux_2_1 m21_write_data_s1_4 ( write_data_s0[4],  pc_plus_4[4], jal, write_data_s1[4]);
mux_2_1 m21_write_data_s1_5 ( write_data_s0[5],  pc_plus_4[5], jal, write_data_s1[5]);
mux_2_1 m21_write_data_s1_6 ( write_data_s0[6],  pc_plus_4[6], jal, write_data_s1[6]);
mux_2_1 m21_write_data_s1_7 ( write_data_s0[7],  pc_plus_4[7], jal, write_data_s1[7]);
mux_2_1 m21_write_data_s1_8 ( write_data_s0[8],  pc_plus_4[8], jal, write_data_s1[8]);
mux_2_1 m21_write_data_s1_9 ( write_data_s0[9],  pc_plus_4[9], jal, write_data_s1[9]);
mux_2_1 m21_write_data_s1_10( write_data_s0[10], pc_plus_4[10], jal, write_data_s1[10]);
mux_2_1 m21_write_data_s1_11( write_data_s0[11], pc_plus_4[11], jal, write_data_s1[11]);
mux_2_1 m21_write_data_s1_12( write_data_s0[12], pc_plus_4[12], jal, write_data_s1[12]);
mux_2_1 m21_write_data_s1_13( write_data_s0[13], pc_plus_4[13], jal, write_data_s1[13]);
mux_2_1 m21_write_data_s1_14( write_data_s0[14], pc_plus_4[14], jal, write_data_s1[14]);
mux_2_1 m21_write_data_s1_15( write_data_s0[15], pc_plus_4[15], jal, write_data_s1[15]);
mux_2_1 m21_write_data_s1_16( write_data_s0[16], pc_plus_4[16], jal, write_data_s1[16]);
mux_2_1 m21_write_data_s1_17( write_data_s0[17], pc_plus_4[17], jal, write_data_s1[17]);
mux_2_1 m21_write_data_s1_18( write_data_s0[18], pc_plus_4[18], jal, write_data_s1[18]);
mux_2_1 m21_write_data_s1_19( write_data_s0[19], pc_plus_4[19], jal, write_data_s1[19]);
mux_2_1 m21_write_data_s1_20( write_data_s0[20], pc_plus_4[20], jal, write_data_s1[20]);
mux_2_1 m21_write_data_s1_21( write_data_s0[21], pc_plus_4[21], jal, write_data_s1[21]);
mux_2_1 m21_write_data_s1_22( write_data_s0[22], pc_plus_4[22], jal, write_data_s1[22]);
mux_2_1 m21_write_data_s1_23( write_data_s0[23], pc_plus_4[23], jal, write_data_s1[23]);
mux_2_1 m21_write_data_s1_24( write_data_s0[24], pc_plus_4[24], jal, write_data_s1[24]);
mux_2_1 m21_write_data_s1_25( write_data_s0[25], pc_plus_4[25], jal, write_data_s1[25]);
mux_2_1 m21_write_data_s1_26( write_data_s0[26], pc_plus_4[26], jal, write_data_s1[26]);
mux_2_1 m21_write_data_s1_27( write_data_s0[27], pc_plus_4[27], jal, write_data_s1[27]);
mux_2_1 m21_write_data_s1_28( write_data_s0[28], pc_plus_4[28], jal, write_data_s1[28]);
mux_2_1 m21_write_data_s1_29( write_data_s0[29], pc_plus_4[29], jal, write_data_s1[29]);
mux_2_1 m21_write_data_s1_30( write_data_s0[30], pc_plus_4[30], jal, write_data_s1[30]);
mux_2_1 m21_write_data_s1_31( write_data_s0[31], pc_plus_4[31], jal, write_data_s1[31]);


// Final stage-3 mux, move selection
mux_2_1 m21_write_data_0(  write_data_s1[0],  read_data2[0], move, write_data[0]);
mux_2_1 m21_write_data_1(  write_data_s1[1],  read_data2[1], move, write_data[1]);
mux_2_1 m21_write_data_2(  write_data_s1[2],  read_data2[2], move, write_data[2]);
mux_2_1 m21_write_data_3(  write_data_s1[3],  read_data2[3], move, write_data[3]);
mux_2_1 m21_write_data_4(  write_data_s1[4],  read_data2[4], move, write_data[4]);
mux_2_1 m21_write_data_5(  write_data_s1[5],  read_data2[5], move, write_data[5]);
mux_2_1 m21_write_data_6(  write_data_s1[6],  read_data2[6], move, write_data[6]);
mux_2_1 m21_write_data_7(  write_data_s1[7],  read_data2[7], move, write_data[7]);
mux_2_1 m21_write_data_8(  write_data_s1[8],  read_data2[8], move, write_data[8]);
mux_2_1 m21_write_data_9(  write_data_s1[9],  read_data2[9], move, write_data[9]);
mux_2_1 m21_write_data_10( write_data_s1[10], read_data2[10], move, write_data[10]);
mux_2_1 m21_write_data_11( write_data_s1[11], read_data2[11], move, write_data[11]);
mux_2_1 m21_write_data_12( write_data_s1[12], read_data2[12], move, write_data[12]);
mux_2_1 m21_write_data_13( write_data_s1[13], read_data2[13], move, write_data[13]);
mux_2_1 m21_write_data_14( write_data_s1[14], read_data2[14], move, write_data[14]);
mux_2_1 m21_write_data_15( write_data_s1[15], read_data2[15], move, write_data[15]);
mux_2_1 m21_write_data_16( write_data_s1[16], read_data2[16], move, write_data[16]);
mux_2_1 m21_write_data_17( write_data_s1[17], read_data2[17], move, write_data[17]);
mux_2_1 m21_write_data_18( write_data_s1[18], read_data2[18], move, write_data[18]);
mux_2_1 m21_write_data_19( write_data_s1[19], read_data2[19], move, write_data[19]);
mux_2_1 m21_write_data_20( write_data_s1[20], read_data2[20], move, write_data[20]);
mux_2_1 m21_write_data_21( write_data_s1[21], read_data2[21], move, write_data[21]);
mux_2_1 m21_write_data_22( write_data_s1[22], read_data2[22], move, write_data[22]);
mux_2_1 m21_write_data_23( write_data_s1[23], read_data2[23], move, write_data[23]);
mux_2_1 m21_write_data_24( write_data_s1[24], read_data2[24], move, write_data[24]);
mux_2_1 m21_write_data_25( write_data_s1[25], read_data2[25], move, write_data[25]);
mux_2_1 m21_write_data_26( write_data_s1[26], read_data2[26], move, write_data[26]);
mux_2_1 m21_write_data_27( write_data_s1[27], read_data2[27], move, write_data[27]);
mux_2_1 m21_write_data_28( write_data_s1[28], read_data2[28], move, write_data[28]);
mux_2_1 m21_write_data_29( write_data_s1[29], read_data2[29], move, write_data[29]);
mux_2_1 m21_write_data_30( write_data_s1[30], read_data2[30], move, write_data[30]);
mux_2_1 m21_write_data_31( write_data_s1[31], read_data2[31], move, write_data[31]);

endmodule