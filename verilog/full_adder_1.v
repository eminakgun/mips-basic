module full_adder_1(input A,
                    input B,
                    input Cin,
                    output Sum,
                    output Cout
                    output A_and_B
                    output A_or_B);

    // Sum
    xor(a_xor_b, A, B)
    xor(Sum, a_xor_b, Cin);

    // Cout
    and(temp1, a_xor_b, cin); // cin and (a xor b)
    and(a_and_b, A, B);
    or(Cout, a_and_b, temp1);

    

endmodule