`timescale 1ns/1ps
module buffer #(parameter N=8) (
    input wire en,
    input wire [N-1:0] in,
    output wire [N-1:0] out
);
    assign out = en ? in : {N{1'bz}};
endmodule
