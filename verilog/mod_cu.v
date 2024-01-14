module mod_cu(input Clk,
              input Reset,
              input En,
              input  [31:0] A,
              input  [31:0] B,
              input  [31:0] Sub_Result,
              input  [0:0]        Done,
              output [31:0] Dp_Result_reg,
              output reg [31:0] Mod_Result,
              output reg We);

localparam WaitEn = 2'b00;
localparam WaitDone = 2'b01;
localparam RegisterOutput = 2'b10;

reg [1:0] state;
reg [1:0] next_state;
reg [31:0] dp_result_reg;

assign Dp_Result_reg = state == WaitEn ? A : dp_result_reg;

// Registers
always @(posedge Clk) begin
    if (Reset) begin
        state <= WaitEn;
        dp_result_reg <= 0;
        We <= 0;
    end
    else begin
        state <= next_state;
        dp_result_reg <= Sub_Result;
        We <= Done; // align with Mod_Result
    end
end

// State logic
always @(*) begin
    if (Reset) begin
        next_state = WaitEn;
        Mod_Result = 0;
    end
    else begin
        // default value assignment
        next_state = state;
        Mod_Result = 0;

        case (state)
            WaitEn: 
                if (En) begin
                    next_state = WaitDone;
                end
            WaitDone: 
                if (Done == 1) begin
                    next_state = RegisterOutput;
                end
            RegisterOutput: begin
                Mod_Result = dp_result_reg;
                next_state = WaitEn;
            end
            default: next_state = WaitEn;
        endcase
        
    end
end

endmodule