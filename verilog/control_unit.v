`include "mips_defines.vh"

module control_unit (
    output reg regDst,
    output reg branch,
    output reg memRead,
    output reg memWrite,
    output reg [2:0] ALUop,
    output reg ALUsrc,
    output reg regWrite,
    output reg jump,
    input [5:0] opcode
);

localparam [5:0] ADD_IMM = 6'b000010;
localparam [5:0] SUB_IMM = 6'b000011;
localparam [5:0] AND_IMM = 6'b000100;
localparam [5:0] OR_IMM = 6'b000101;
localparam [5:0] LOAD_WORD = 6'b001000;
localparam [5:0] STORE_WORD = 6'b010000;
localparam [5:0] LOAD_BYTE = 6'b001001;
localparam [5:0] STORE_BYTE = 6'b010001;
localparam [5:0] SET_LESS_THAN_IMM = 6'b000111;
localparam [5:0] BRANCH_EQUAL = 6'b100011;
localparam [5:0] BRANCH_NOT_EQUAL = 6'b100111;
localparam [5:0] JUMP = 6'b111000;
localparam [5:0] JUMP_AND_LINK = 6'b111001;


always @(opcode) begin
    // default assignments
    branch   = 1'b0;
    jump     = 0;
    regDst   = 1'b0;
    regWrite = 1'b0;
    memRead  = 1'b0;
    memWrite = 1'b0;
    case (opcode)
        6'b100000: begin // Move
        // TODO
        end
        6'b000000: begin // R-type
            regWrite = 1'b1;    // Write enable register block
            regDst   = 1'b1;    // select Rd to be written
            ALUop    = `ALUop_RTYPE;
            ALUsrc   = 1'b0;    // Use Rt for ALU's 2nd operand
        end
        ADD_IMM: begin
            regWrite = 1'b1;    // Write enable register block
            regDst   = 1'b0;    // select Rt to be written
            ALUop = `ALUop_ADD;
            ALUsrc   = 1'b1; // Immediate
        end
        SUB_IMM: begin
            regWrite = 1'b1;    // Write enable register block
            regDst   = 1'b0;    // select Rt to be written
            ALUop = `ALUop_SUB;
            ALUsrc   = 1'b1; // Immediate
        end
        AND_IMM: begin
            regWrite = 1'b1;    // Write enable register block
            regDst   = 1'b0;    // select Rt to be written
            ALUop = `ALUop_AND;
            ALUsrc   = 1'b1; // Immediate
        end
        OR_IMM: begin
            regWrite = 1'b1;    // Write enable register block
            regDst   = 1'b0;    // select Rt to be written
            ALUop = `ALUop_OR;
            ALUsrc   = 1'b1;    // Immediate
        end
        LOAD_WORD: begin
            memRead  = 1;
            regWrite = 1'b1;
            regDst   = 1'b0;   // select Rt to be written
            ALUop    = `ALUop_ADD;
            ALUsrc   = 1'b1; // Immediate
        end
        STORE_WORD: begin
            memWrite = 1;
            ALUop    = `ALUop_ADD;
            ALUsrc   = 1'b1; // Immediate
        end
        // LOAD_BYTE:  // TODO
        // STORE_BYTE: // TODO
        SET_LESS_THAN_IMM: begin
            regWrite = 1'b1;    // Write enable register block
            regDst   = 1'b0;    // select Rt to be written
            ALUop    = `ALUop_LESS;
        end
        BRANCH_EQUAL: begin
            branch = 1;
            ALUop = `ALUop_SUB;
            ALUsrc   = 1'b0;    // Use Rt for ALU's 2nd operand
        end
        BRANCH_NOT_EQUAL: begin
            branch = 1;
            ALUop = `ALUop_SUB;
            ALUsrc   = 1'b0;    // Use Rt for ALU's 2nd operand
        end
        JUMP: begin
            jump = 1;
        end
        JUMP_AND_LINK: begin
            // $ra = PC + 4; go to address 1000
            regWrite = 1'b1;
            jump = 1;
        end
    endcase
end


    
endmodule