`timescale 1ns/1ps
module tb;
    reg clk = 0;
    reg [7:0] in = 0;
    wire [7:0] out;

    // Instantiate DUT (Design Under Test)
    register #(8) dut (
        .clk(clk),
        .in(in),
        .out(out)
    );

    // Clock generator
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        // Test cases
        in = 8'h00; #8;
        in = 8'hAA; #10;
        in = 8'h55; #10;

        $finish;
    end

endmodule
