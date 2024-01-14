module mux8x1x1 (
    input In_0,
    input In_1,
    input In_2,
    input In_3,
    input In_4,
    input In_5,
    input In_6,
    input In_7,
    input [2:0] Sel,
    output Out
);

wire and_result_0, and_result_1, and_result_2, and_result_3,
and_result_4, and_result_5, and_result_6, and_result_7;

// AND gates for each input and its corresponding selection bit
and and_result_0_inst (and_result_0, ~(Sel[2]), ~(Sel[1]), ~(Sel[0]), In_0);
and and_result_1_inst (and_result_1, ~(Sel[2]), ~(Sel[1]),   Sel[0],  In_1);
and and_result_2_inst (and_result_2, ~(Sel[2]),   Sel[1],  ~(Sel[0]), In_2);
and and_result_3_inst (and_result_3, ~(Sel[2]),   Sel[1],    Sel[0],  In_3);
and and_result_4_inst (and_result_4,   Sel[2] , ~(Sel[1]), ~(Sel[0]), In_4);
and and_result_5_inst (and_result_5,   Sel[2] , ~(Sel[1]),   Sel[0],  In_5);
and and_result_6_inst (and_result_6,   Sel[2] ,   Sel[1],  ~(Sel[0]), In_6);
and and_result_7_inst (and_result_7,   Sel[2] ,   Sel[1],    Sel[0],  In_7);

// OR gate to combine the outputs of the AND gates
or or_result (Out,
              and_result_0, and_result_1, and_result_2, and_result_3,
              and_result_4, and_result_5, and_result_6, and_result_7);
    
endmodule