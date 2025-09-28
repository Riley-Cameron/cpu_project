`timescale 1ns/1ps
module buffered_register #(parameter N=8) (
    input wire clk,
    input wire en,
    input wire ld,
    input wire [N-1:0] in,
    output wire [N-1:0] out
);
    wire [N-1:0] reg_to_buf;
    register #(N) _reg(.clk(clk), .in(in), .ld(ld), .out(reg_to_buf));
    buffer #(N) _buf(.en(en), .in(reg_to_buf), .out(out));
endmodule
