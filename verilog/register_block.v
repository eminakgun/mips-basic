module register_block (
    output reg [31:0] read_data1,
    output reg [31:0] read_data2,
    input [31:0] write_data,
    input [5:0] read_reg1,
    input [5:0] read_reg2,
    input [5:0] write_reg,
    input regWrite
);

reg [31:0] registers[0:31];

always @(read_reg1) begin
    $readmemb("memory_files/registers.mem", registers);
    read_data1 = registers[read_reg1];
end

always @(read_reg2) begin
    $readmemb("memory_files/registers.mem", registers);
    read_data2 = registers[read_reg2];
end

always @(regWrite) begin
    registers[write_reg] = write_data;
    $writememb("memory_files/registers.mem", registers);
end


// initialize register file
integer file;
integer i;
initial begin
    // Open file for writing
    file = $fopen("memory_files/registers.mem", "w");
    
    // Populate the file with 32 32-bit zero-initialized binary numbers
    for (i = 0; i < 32; i = i + 1) begin
        $fwrite(file, "%032b\n", 0);
    end
    
    // Close the file
    $fclose(file);
end
    
endmodule