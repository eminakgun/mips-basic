module control_unit (
    output reg regDst,
    output reg branch,
    output memRead,
    output memWrite,
    output [1:0] ALUop,
    output ALUsrc,
    output regWrite
    input [5:0] opcode
);
    
endmodule