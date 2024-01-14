module instruction_block (
    output reg [31:0] instruction,
    input [31:0] pc
);

reg [31:0] instructions[0:1023];

integer i;
initial begin
    // zero initialize first
    for (i = 0; i < 1024; i = i + 1) begin
        instructions[i] = 0;
    end
    $readmemb("memory_files/instructions.mem", instructions);
    // now zero-initialize the rest of the file
    $writememb("memory_files/instructions.mem", instructions);
end

always @(pc) begin
    $readmemb("memory_files/instructions.mem", instructions);
    instruction = instructions[pc[9:2]];
    //$display("instruction: %32b", instruction);
end

endmodule