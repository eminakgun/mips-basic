module memory_block (
    output reg [31:0] read_data,
    input [17:0] address,
    input [31:0] write_data,
    input memRead,
    input memWrite
);
    
reg [31:0] mem[0:65535]; // 256KB

always @(address) begin
    if (memRead) begin
        $readmemb("memory_files/memory.mem", mem);
        read_data = mem[address];
    end
    else if (memWrite) begin
        mem[address] = write_data;
        $writememb("memory_files/memory.mem", mem);
    end
end

// initialize main memory file
integer file;
integer i;
initial begin
    // Open file for writing
    file = $fopen("memory_files/memory.mem", "w");
    
    // Populate the file with 65536 32-bit zero-initialized binary numbers
    for (i = 0; i < 65536; i = i + 1) begin
        $fwrite(file, "%032b\n", 0);
    end
    
    // Close the file
    $fclose(file);
end

endmodule