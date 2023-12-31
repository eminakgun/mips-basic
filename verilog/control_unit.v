module control_unit (
    output reg regDst,
    output reg branch,
    output memRead,
    output memWrite,
    output [2:0] ALUop,
    output ALUsrc,
    output regWrite,
    input [5:0] opcode
);

// regDst
always @(opcode) begin
    case (opcode)
        6'b000000: // R-type

        default: 
    endcase

    
end


    
endmodule