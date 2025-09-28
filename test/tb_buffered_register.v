`timescale 1ns/1ps
/* verilator lint_off STMTDLY */
module tb;
    reg clk = 0;
    reg en_a = 0;
    reg ld_a = 0;
    reg [7:0] in_a = 0;
    reg en_b = 0;
    reg ld_b = 0;
    reg [7:0] in_b = 0;
    wire [7:0] bus;

    // Instantiate DUT (Design Under Test)
    buffered_register #(8) dut_a (
        .clk(clk),
        .ld(ld_a),
        .en(en_a),
        .in(in_a),
        .out(bus)
    );

    // Instantiate DUT (Design Under Test)
    buffered_register #(8) dut_b (
        .clk(clk),
        .ld(ld_b),
        .en(en_b),
        .in(in_b),
        .out(bus)
    );

    // Clock generator
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        // Test cases
        in_a = 8'hAA; in_b = 8'hBB; #10;
        ld_a = 1; #3; ld_b = 1;     #7;
        ld_a = 0; ld_b = 0;         #10;
        in_a = 8'h00; in_b = 8'h00; #10;
        en_a = 1; en_b = 0;         #10;
        en_a = 0; en_b = 0;         #10;
        en_a = 0; en_b = 1;         #10;
        en_a = 0; en_b = 0;         #10;
        en_a = 1; en_b = 1;         #10;
        en_a = 0; en_b = 0;         #10;

        $finish;
    end

endmodule
