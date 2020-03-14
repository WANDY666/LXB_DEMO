`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/11 21:30:42
// Design Name: 
// Module Name: mux_forward
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


module mux_forward(
    input [31:0] RD1,
    input [31:0] PC8_E,
    input [31:0] PC8_M,
    input [31:0] PC8_R,
    input [31:0] AO_M,
    input [31:0] AO_R,
    input [2:0] F_RS_D,
    output [31:0] MF_RS_D,

    input [31:0] RD2,
    input [2:0] F_RT_D,
    output [31:0] MF_RT_D,

    input [31:0] RS_E,
    input [31:0] WD3,
    input [2:0] F_RS_E,
    output [31:0] MF_RS_E,

    input [31:0] RT_E,
    input [2:0] F_RT_E,
    output [31:0] MF_RT_E,

    input [31:0] RT_M,
    input [2:0] F_RT_M,
    output [31:0] MF_RT_M
    );

    assign MF_RS_D = (F_RS_D == 3'b001)? PC8_E:
                     (F_RS_D == 3'b010)? PC8_M:
                     (F_RS_D == 3'b011)? AO_M:
                     (F_RS_D == 3'b100)? PC8_R:
                     (F_RS_D == 3'b101)? AO_R:
                                         RD1;

    assign MF_RT_D = (F_RT_D == 3'b001)? PC8_E:
                     (F_RT_D == 3'b010)? PC8_M:
                     (F_RT_D == 3'b011)? AO_M:
                     (F_RT_D == 3'b100)? PC8_R:
                     (F_RT_D == 3'b101)? AO_R:
                                         RD2;

    assign MF_RS_E = (F_RS_E == 3'b001)? PC8_M:
                     (F_RS_E == 3'b010)? AO_M:
                     (F_RS_E == 3'b011)? PC8_R:
                     (F_RS_E == 3'b100)? AO_R:
                     (F_RS_E == 3'b101)? WD3:
                                         RS_E;

    assign MF_RT_E = (F_RT_E == 3'b001)? PC8_M: 
                     (F_RT_E == 3'b010)? AO_M: 
                     (F_RT_E == 3'b011)? PC8_R: 
                     (F_RT_E == 3'b100)? AO_R: 
                     (F_RT_E == 3'b101)? WD3:   
                                         RT_E;                                                                               

    assign MF_RT_M = (F_RT_M == 3'b001)? PC8_R: 
                     (F_RT_M == 3'b010)? AO_R: 
                     (F_RT_M == 3'b011)? WD3: 
                                         RT_M;
                                                            

endmodule
