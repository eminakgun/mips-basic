module cla_16 (input [15:0] A,
               input [15:0] B,
               input Cin,
               output Cout,
               output [15:0] Sum,
               // P and G for second layer CLL
               output P,
               output G,
               output [15:0] AND,
               output [15:0] OR,
               output [15:0] XOR,
               output [15:0] NOR);
    
    wire P_0, G_0;
    wire P_1, G_1;
    wire P_2, G_2;
    wire P_3, G_3;

    cla_4 cla_4_0(A[3:0],   B[3:0],      Cin, Sum[ 3: 0], P_0, G_0, AND[3:0],   OR[3:0],   XOR[3:0],   NOR[3:0]);
    cla_4 cla_4_1(A[7:4],   B[7:4],   cout_0, Sum[ 7: 4], P_1, G_1, AND[7:4],   OR[7:4],   XOR[7:4],   NOR[7:4]);
    cla_4 cla_4_2(A[11:8],  B[11:8],  cout_1, Sum[11: 8], P_2, G_2, AND[11:8],  OR[11:8],  XOR[11:8],  NOR[11:8]);
    cla_4 cla_4_3(A[15:12], B[15:12], cout_2, Sum[15:12], P_3, G_3, AND[15:12], OR[15:12], XOR[15:12], NOR[15:12]);

    // CLL
    and P_out(P, P_0, P_1, P_2, P_3); // P_3_0 = P_0.P_1.P_2.P_3

    and g_and_0(p3_p2_p1_g0, P_3, P_2, P_1, G_0);
    and g_and_1(p3_g2_g1, P_3, P_2, G_1);
    and g_and_2(p3_g2, P_3, G_2);

    // G3:0 = g3 + p3g2 + p3p2g1 + p3p2p1g0
    or G_out(G, G_3, p3_g2, p3_g2_g1, p3_p2_p1_g0);

    // Internal Carry calcualtion via CLL
    and P_and_Cin(p0_and_cin, P_0, Cin);
    or Cout_0(cout_0, G_0, p0_and_cin); // Cout_0 = G_0 + P_0.Cin;

    and P_and_C_0(p1_and_c0, P_1, cout_0);
    or Cout_1(cout_1, G_1, p1_and_c0); // Cout_1 = G_1 + P_1.Cout_0;

    and P_and_C_1(p2_and_c1, P_2, cout_1);
    or Cout_2(cout_2, G_2, p2_and_c1); // Cout_2 = G_2 + P_2.Cout_1;

endmodule