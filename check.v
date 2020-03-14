`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/16 13:45:24
// Design Name: 
// Module Name: check
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
`define WORD 2'b00
`define H 2'b01
`define B 2'b10

module check(
    input [31:0] PC_M,
    input [1:0] S_SEL_M,
    input [31:0] SL_Addr,
    input DM_REN_M,
    input DM_WEN_M,
    input RI,               //from ctr
    input break,            //from ctr
    input syscall,          //from ctr
    input Overable,         //from ctr
    input Over,             //from alu
    output Exc,
    output [4:0] ExcCode
    );

    wire AdEL, AdES, Ov;

    assign AdEL = (PC_M[1:0] != 2'b00) || (DM_REN_M && (((S_SEL_M == `WORD) && (SL_Addr[1:0] != 2'b00)) || ((S_SEL_M == `H) && (SL_Addr[0] != 1'b0))));
    assign AdES = (DM_WEN_M && ((S_SEL_M == `WORD) && (SL_Addr[1:0] != 2'b00)) || ((S_SEL_M == `H) && (SL_Addr[0] != 1'b0)));
    assign Ov = Overable & Over;
    
    assign ExcCode = (PC_M[1:0] != 2'b00)? 5'h04:
                     RI?                   5'h0a:
                     Ov?                   5'h0c:
                     syscall?              5'h08:
                     break?                5'h09:
                     (AdEL)?               5'h04:
                     (AdES)?               5'h05:
                                           5'h00;

    assign Exc = ExcCode != 5'h00;

endmodule
