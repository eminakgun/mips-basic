module cla_4 (input [3:0] A,
              input [3:0] B,
              input Cin,
              output [3:0] Sum,
              // P and G for second layer CLL
              output P,
              output G,
              output [3:0] AND,
              output [3:0] OR,
              output [3:0] XOR,
              output [3:0] NOR);

	wire [3:0] p, g;
				  
    alu_1 alu_1_0(A[0], B[0], Cin,    /*Ignore Cout*/ , Sum[0], p[0], g[0], AND[0], OR[0], XOR[0], NOR[0]);
    alu_1 alu_1_1(A[1], B[1], cout_0, /*Ignore Cout*/ , Sum[1], p[1], g[1], AND[1], OR[1], XOR[1], NOR[1]);
    alu_1 alu_1_2(A[2], B[2], cout_1, /*Ignore Cout*/ , Sum[2], p[2], g[2], AND[2], OR[2], XOR[2], NOR[2]);
    alu_1 alu_1_3(A[3], B[3], cout_2, /*Ignore Cout*/ , Sum[3], p[3], g[3], AND[3], OR[3], XOR[3], NOR[3]);

    // CLL
    and P_out(P, p[0], p[1], p[2], p[3]); // P_3_0 = P_0.P_1.P_2.P_3

    and g_and_0(p3_p2_p1_g0, p[3], p[2], p[1], g[0]);
    and g_and_1(p3_g2_g1, p[3], p[2], g[1]);
    and g_and_2(p3_g2, p[3], g[2]);

    // G3:0 = g3 + p3g2 + p3p2g1 + p3p2p1g0
    or G_out(G, g[3], p3_g2, p3_g2_g1, p3_p2_p1_g0);

    // Internal Carry calcualtion via CLL

    and P_and_Cin(p0_and_cin, p[0], Cin);
    or Cout_0(cout_0, g[0], p0_and_cin); // Cout_0 = G_0 + P_0.Cin;

    and P_and_C_0(p1_and_c0, p[1], cout_0);
    or Cout_1(cout_1, g[1], p1_and_c0); // Cout_1 = G_1 + P_1.Cout_0;

    and P_and_C_1(p2_and_c1, p[2], cout_1);
    or Cout_2(cout_2, g[2], p2_and_c1); // Cout_2 = G_2 + P_2.Cout_1;

    // Cout[3] is ignored
    //and P_and_C_2(p3_and_c2, p[3], cout_2);
    //or Cout_3(cout_3, g[3], p3_and_c2); // Cout_3 = G_3 + P_3.Cout_2;

    //buf Cout_buf(Cout, cout_3); // Cout

endmodule