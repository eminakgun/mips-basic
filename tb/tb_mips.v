module tb_mips ();
    
    reg clk=0;

    mips uut(clk);

    always #5 clk = ~clk;

    integer inst_cnt;
    initial begin
        $dumpfile("build/tb_mips.vcd");
        $dumpvars(0);

        //#100;

        for (inst_cnt= 0; inst_cnt <= 1024; ++inst_cnt) begin
            //$display("inst: %0d", inst_cnt);
            @(posedge clk);
        end

        $finish;
    end

endmodule