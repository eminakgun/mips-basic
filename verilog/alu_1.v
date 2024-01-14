module alu_1(input  A,
             input  B,
             input  Cin,
             output Cout,
             output Sum,
             output P,
             output G,
             output AND,
             output OR,
             output XOR,
             output NOR);

    or  A_or_B (a_or_b,    A, B); // A or B
    not A_nor_B(a_nor_b, a_or_b); // A nor B
    and A_and_B(a_and_b,   A, B); // A and B
    not   A_not(a_not,        A);
    and    Less(less, a_not,  B); // not(A) && B

    buf (AND,  a_and_b);
    buf (OR,   a_or_b );
    buf (XOR,  a_xor_b);
    buf (NOR,  a_nor_b);
    //buf (LESS, less   );

    // A + B, FA
    not not_A_and_B(not_a_and_b, a_and_b); // ~(A and B)
    and A_xor_B(a_xor_b, not_a_and_b, a_or_b); // A xor B
    xor Sum_a_b_c(Sum, a_xor_b, Cin); // sum = (A xor B) xor Cin

    // CLL
    buf (P, a_or_b);  // Propagate
    buf (G, a_and_b); // Generate

    and(P_and_Cin, P, Cin);
    or(Cout, G, P_and_Cin); // Cout = g(i) + p(i)c(i)
    

endmodule