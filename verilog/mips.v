module mips (
    input clock
);

// Wire Declarations

// instruction_block
wire [31:0] instruction;
wire [31:0] pc;

// register_block
wire [31:0] read_data1;
wire [31:0] read_data2;
wire [31:0] write_data;
wire [5:0] read_reg1;
wire [5:0] read_reg2;
wire [5:0] write_reg;
wire regWrite;

// control_unit
wire       regDst;
wire       branch;
wire       memRead;
wire       memWrite;
wire [2:0] ALUop;
wire       ALUsrc;
wire       regWrite;
wire [5:0] opcode;

// sign-extend
wire[31:0] sign_ext_imm;
wire[15:0] imm;

// alu
wire [31:0] alu_result;
wire        zero_bit;
wire [31:0] alu_src1;
wire [31:0] alu_src2;
wire [2:0]  alu_ctr;

// alu control
wire [2:0] alu_ctr;
wire [5:0] function_code;
wire [2:0] ALUop;

// memory block
wire [31:0] read_data;
wire [17:0] address;
wire [31:0] write_data;
wire        memRead;
wire        memWrite;


// Logic Blocks

// TODO Program counter logic
// 1- PC + 4
// 2- Shift left Sign extended immed value and add PC
// 3- Selection logic that connects to PC register
//    based on Branch bit and Zero bit outputs

instruction_block inst_block_i(instruction, pc);

// TODO Slice instruction logic

// TODO Write register logic

register_block reg_block_i(read_data1, read_data2, write_data, 
                            read_reg1, read_reg2, write_reg, regWrite);

control_unit ctrl_unit_i(regDst, branch, memRead, memWrite, 
                            ALUop, ALUsrc, regWrite, opcode);

sign_extend sign_extend_i(sign_ext_imm, imm);

// TODO Alu 2nd operand selection logic

alu alu_i(alu_result, zero_bit, alu_src1, alu_src2, alu_ctr);

alu_control alu_ctrl_i(alu_ctr, function_code, ALUop);

memory_block mem_block_i(read_data, address, write_data, memRead, memWrite);

// TODO Selection logic for write back register_block

endmodule