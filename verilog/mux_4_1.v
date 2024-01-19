module mux_4_1 (input [3:0] MuxIn, input [1:0] Select, output MuxOut);

// 

not Select_0_n(S0_n, Select[0]);
not Select_1_n(S1_n, Select[1]);

and And_0(and_3_0, MuxIn[0], S0_n, S1_n);           // In[0] and ~Select[0] and ~Select[1]
and And_1(and_3_1, MuxIn[1], Select[0], S1_n);      // In[1] and Select[0] and ~Select[1]
and And_2(and_3_2, MuxIn[2], Select[1], S0_n);      // In[2] and ~Select[0] and Select[1]
and And_3(and_3_3, MuxIn[3], Select[0], Select[1]); // In[3] and Select[0] and Select[1]

or or_4(MuxOut, and_3_0, and_3_1, and_3_2, and_3_3);
    
endmodule