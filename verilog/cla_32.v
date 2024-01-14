module cla_32 (input [31:0] A,
               input [31:0] B,
               input  Cin,
               output Cout,
               output [31:0] Sum,
               output [31:0] AND,
               output [31:0] OR,
               output [31:0] XOR,
               output [31:0] NOR);

    wire P_0, G_0;
    wire P_1, G_1;

    cla_16 cla_16_0(A[15:0],   B[15:0],     Cin, /*Ignore Couts*/, Sum[15:0],  P_0, G_0, AND[ 15:0],  OR[15:0],  XOR[15:0],  NOR[15:0]);
    cla_16 cla_16_1(A[31:16],  B[31:16], cout_0, /*Ignore Couts*/, Sum[31:16], P_1, G_1, AND[31:16], OR[31:16], XOR[31:16], NOR[31:16]);


    // Carry calcualtion via CLL
    and P_and_Cin(p0_and_cin, P_0, Cin);
    or Cout_0(cout_0, G_0, p0_and_cin); // Cout_0 = G_0 + P_0.Cin;

    and P_and_C_0(p1_and_c0, P_1, cout_0);
    or Cout_1(Cout, G_1, p1_and_c0); // Cout_1 = G_1 + P_1.Cout_0;

endmodule