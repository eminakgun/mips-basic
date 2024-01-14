module alu (
    output [31:0] alu_result,
    output reg zero_bit,
    input [31:0] alu_src1,
    input [31:0] alu_src2,
    input [2:0] alu_ctr
);

    // ALU with CLA from submodule
    alu_cla alu_cla_i(/* Clk */,
                      /* Reset */, 
                        alu_src1, alu_src2, alu_ctr,
                        /* C */, 
                        alu_result, 
                        /* We */);

    always @(*) begin
        zero_bit = 1'b0;
        if (alu_result == 0) begin
            zero_bit = 1'b1;
        end
    end
    
endmodule