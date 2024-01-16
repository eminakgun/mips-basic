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
assign move = (opcode == 6'b100000);

// Logic Blocks

// Program counter logic
// TODO Convert into structural

// 1- PC + 4
wire [31:0] pc_plus_4;
assign pc_plus_4 = pc + 4;

// 2- Shift left Sign extended immed value and add PC
wire [31:0] branch_addr;
assign branch_addr = pc_plus_4 + (sign_ext_imm << 2);

// 3- Selection logic that connects to PC register
//    based on Branch bit and Zero bit outputs
wire zerobit_n;
not not_zero(zerobit_n, zero_bit);

wire branch_eq_or_ne;
assign branch_eq_or_ne = (opcode == 6'b100011) ? zero_bit : zerobit_n;

wire branch_select;
and and_branch_select(branch_select, branch_eq_or_ne, branch);


// TODO Implement jump register
wire jal;
assign jal = (instruction[31:26] == 6'b111001);

wire jr;
assign jr = instruction[31:26] == 6'b000000 && function_code == 6'b001000;

wire reg_block_we;
assign reg_block_we = jr ? 1'b0 : jal == 1'b1 ? 1'b1
                                              : regWrite;

wire jump_cu;
wire [31:0] ra_content;
wire jump_final;
wire [31:0] jump_address;
wire [31:0] pc_final;

assign jump_address = jump_cu ? {{6{1'b0}},instruction[25:0]} 
                              : read_data1; // Jump Register
assign jump_final = jr ? 1'b1 : jump_cu;
assign pc_final = jump_final ? jump_address
                             : branch_select ? branch_addr : pc_plus_4;

// PC register
always @(posedge clock) begin
    pc <= pc_final;
end

// Instruction block
instruction_block inst_block_i(instruction, pc);

// Slice instruction logic
// TODO Convert into structural
assign opcode = instruction[31:26];
assign read_reg1 = instruction[25:21];
assign read_reg2 = instruction[20:16];


// Write register/data logic
// TODO use 4x1 mux
assign write_reg = jal == 1'b1 ? 5'd31 // Ra adress
                               : regDst == 1'b1 ? instruction[15:11] 
                                                : instruction[20:16];
register_block reg_block_i(read_data1, read_data2, write_data, 
                            read_reg1, read_reg2, write_reg, reg_block_we);

control_unit ctrl_unit_i(regDst, branch, memRead, memWrite, 
                            ALUop, ALUsrc, regWrite, jump_cu, opcode);

// TODO Convert into structural, use buffer
assign imm = instruction[15:0];
sign_extend sign_extend_i(sign_ext_imm, imm);

// Alu 2nd operand selection logic
assign alu_src1 = read_data1;
// TODO use 2x1 mux
assign alu_src2 = ALUsrc == 1'b0 ? read_data2 : sign_ext_imm;
alu alu_i(alu_result, zero_bit, read_data1, alu_src2, alu_ctr);

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


assign write_data = move ? read_data1 
                         : jal == 1'b1 ? pc_plus_4 
                                       : memRead == 1'b1 ? read_data_mem
                                                         : alu_result;

endmodule