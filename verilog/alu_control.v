module alu_control (output reg [2:0] alu_ctr,
                    input [5:0] function_code,
                    input [2:0] ALUop);

    localparam [2:0] AND = 3'b000;
    localparam [2:0] OR  = 3'b001;
    localparam [2:0] LESS_THAN = 3'b100;
    localparam [2:0] ADD = 3'b101;
    localparam [2:0] SUB = 3'b110;
        
    always @(*) begin
        alu_ctr = AND; // default value
        if (ALUop == 3'b111) begin
            // R-Type Instruction depends on function_code
            case (function_code)
                6'b000010: alu_ctr = ADD; // add
                6'b000011: alu_ctr = SUB; // subtract
                6'b000100: alu_ctr = AND; // and
                6'b000101: alu_ctr = OR;  // or
                6'b000111: alu_ctr = LESS_THAN; // set on less than
                //6'b001000: alu_ctr = // TODO jump register
            endcase
        end
        else if (ALUop == 3'b110) begin
            // subi, beq, bne, operation SUB
            alu_ctr = SUB;
        end
        else if (ALUop == 3'b101) begin
            // addi, lb, sb, lw, sw
            // operation ADD
            alu_ctr = ADD;
        end
        else if (ALUop == 3'b100) begin
            // slti, operation LESS THAN
            alu_ctr = LESS_THAN;
        end
        else if (ALUop == 3'b001) begin
            // ori, operation OR
            alu_ctr = OR;
        end
        else if (ALUop == 3'b000) begin
            // andi, operation ADD
            alu_ctr = ADD;
        end
    end

endmodule