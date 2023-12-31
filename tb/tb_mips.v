module tb_mips ();
    
    reg clk=0;

    mips uut(clk);

    always #5 clk = ~clk;


    initial begin
        $dumpfile("build/tb_mips.vcd");
        $dumpvars(0);

        #100;

        $finish;
    end

endmodule