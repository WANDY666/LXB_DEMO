`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/09 19:17:26
// Design Name: 
// Module Name: ext
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


module ext(
    input [15:0] imm,
    input [1:0] EXT_CTR,
    output [31:0] imm_ext
    );

    assign imm_ext = (EXT_CTR == 2'b10)? {imm, 16'b0}:
                     (EXT_CTR == 2'b00)? {16'b0, imm}:
                                         {{16{imm[15]}}, imm};
                                         

endmodule
