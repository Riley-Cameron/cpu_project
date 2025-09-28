`timescale 1ns/1ps
module register #(parameter N=8) (
    input wire clk,
    input wire ld,
    input wire [N-1:0] in,
    output reg [N-1:0] out
);
    always @(posedge clk)
        if (ld) out <= in;
endmodule
