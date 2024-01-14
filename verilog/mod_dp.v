module mod_dp(input  [31:0] A,
              input  [31:0] B,
              output [31:0] SubResult,
              output reg Done);

    cla_32 subtractor(A, B ^ 'hFFFFFFFF, 1'b1, /*Ignore Cout*/, SubResult,/*Ignore*/,/*Ignore*/,/*Ignore*/,/*Ignore*/);
    
    always @(*) begin
        Done = 0;
        if (SubResult < B) begin
            Done = 1;
        end
    end

endmodule
