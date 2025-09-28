`timescale 1ns/1ps
/* verilator lint_off STMTDLY */
module tb;
    reg en = 0;
    reg [7:0] in = 0;
    wire [7:0] out;

    // Instantiate DUT (Design Under Test)
    buffer #(8) dut (
        .en(en),
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        // Test cases
        in = 8'h00; #8;
        en = 1;     #5;
        in = 8'hAA; #10;
        en = 0;     #5;
        in = 8'h55; #10;
        en = 1;     #5;
        in = 8'h04; #10;
        en = 0;     #5;
        in = 8'hFF; #10;
        en = 1;     #5;

        $finish;
    end

endmodule
