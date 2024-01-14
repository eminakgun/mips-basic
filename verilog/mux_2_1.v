module mux_2_1 (input in_1, input in_2, input Select, output MuxOut);

    not (S_n, Select);
    and(and_0, in_1, S_n);
    and(and_1, in_2, Select);

    or or_2(MuxOut, and_0, and_1);
endmodule