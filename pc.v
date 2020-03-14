`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/08 12:30:13
// Design Name: 
// Module Name: pc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pc(
    input clk,
    input reset,
    input en,
    input [31:0] PC4_F,
    output reg [31:0] PC
    );

    always @(posedge clk)
        if(reset)
            PC <= 32'd0;
        else if(en)
            PC <= PC4_F;

endmodule
