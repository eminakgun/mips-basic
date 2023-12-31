module instruction_block (
    output reg [31:0] instruction,
    input [31:0] pc
);
    
reg [31:0] instructions[0:1023];

always @(pc) begin
    $readmemb("memory_files/instructions.mem", instructions);
    instruction = instructions[pc[9:0]];
    //$display("instruction: %32b", instruction);
end

endmodule