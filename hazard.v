`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/11 13:42:37
// Design Name: 
// Module Name: hazard
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
`define D 5'd0
`define E 5'd1
`define M 5'd2
`define R 5'd3
`define W 5'd4

`define PC8 5'b0
`define AO 5'b1
`define DR 5'b2
`define NULL 5'b3

module hazard(
    input [44:0] Data_D,
    input [44:0] Data_E,
    input [44:0] Data_M,
    input [44:0] Data_R,
    input [44:0] Data_W,
    input start_E,
    input BUSY_E,
    input MD_D,
    output [2:0] F_RS_D,
    output [2:0] F_RT_D,
    output [2:0] F_RS_E,
    output [2:0] F_RT_E,
    output [2:0] F_RT_M,
    output Stall_PC,
    output Stall_T,
    output Stall_D,
    output Stall_BPU,
    output Flush_E
    );

//       {Tuse1, Tuse2, grf1, grf2, grfchange, Tnew, WD3}
    wire [4:0] RS_D, RT_D, Tuse1_D, Tuse2_D, grf1_D, grf2_D, grfchange_D, Tnew_D, WD3_D;
    wire [4:0] RS_E, RT_E, Tuse1_E, Tuse2_E, grf1_E, grf2_E, grfchange_E, Tnew_E, WD3_E;
    wire [4:0] RS_M, RT_M, Tuse1_M, Tuse2_M, grf1_M, grf2_M, grfchange_M, Tnew_M, WD3_M;
    wire [4:0] RS_R, RT_R, Tuse1_R, Tuse2_R, grf1_R, grf2_R, grfchange_R, Tnew_R, WD3_R;
    wire [4:0] RS_W, RT_W, Tuse1_W, Tuse2_W, grf1_W, grf2_W, grfchange_W, Tnew_W, WD3_W;

    assign {RS_D, RT_D, Tuse1_D, Tuse2_D, grf1_D, grf2_D, grfchange_D, Tnew_D, WD3_D} = {Data_D[44:10], (`D >= Data_D[9:5])? 5'b0: (Data_D[9:5] - `D), Data_D[4:0]};
    assign {RS_E, RT_E, Tuse1_E, Tuse2_E, grf1_E, grf2_E, grfchange_E, Tnew_E, WD3_E} = {Data_E[44:10], (`E >= Data_E[9:5])? 5'b0: (Data_E[9:5] - `E), Data_E[4:0]};
    assign {RS_M, RT_M, Tuse1_M, Tuse2_M, grf1_M, grf2_M, grfchange_M, Tnew_M, WD3_M} = {Data_M[44:10], (`M >= Data_M[9:5])? 5'b0: (Data_M[9:5] - `M), Data_M[4:0]};
    assign {RS_R, RT_R, Tuse1_R, Tuse2_R, grf1_R, grf2_R, grfchange_R, Tnew_R, WD3_R} = {Data_R[44:10], (`R >= Data_R[9:5])? 5'b0: (Data_R[9:5] - `R), Data_R[4:0]};
    assign {RS_W, RT_W, Tuse1_W, Tuse2_W, grf1_W, grf2_W, grfchange_W, Tnew_W, WD3_W} = {Data_W[44:10], (`W >= Data_W[9:5])? 5'b0: (Data_W[9:5] - `W), Data_W[4:0]};

    wire stall_E, stall_M, stall_R, stall_MD;
	assign stall_E = ((grfchange_E) && (((grfchange_E == grf1_D) && (Tnew_E > Tuse1_D)) || ((grfchange_E == grf2_D) && (Tnew_E > Tuse2_D))));
    assign stall_M = ((grfchange_M) && (((grfchange_M == grf1_D) && (Tnew_M > Tuse1_D)) || ((grfchange_M == grf2_D) && (Tnew_M > Tuse2_D))));
    assign stall_R = ((grfchange_R) && (((grfchange_R == grf1_D) && (Tnew_R > Tuse1_D)) || ((grfchange_R == grf2_D) && (Tnew_R > Tuse2_D))));
    assign stall_MD = (start_E || BUSY_E) && MD_D;

    assign stall = stall_E || stall_M || stall_R || stall_MD;
    assign Stall_PC = stall; 
    assign Stall_T = stall;
    assign Stall_D = stall;
    assign Stall_BPU = stall;
    assign Flush_E = stall;
    
    assign F_RS_D = ((grfchange_E != 5'd0) && (grfchange_E == RS_D) && (WD3_E == `PC8) && (Tnew_E == 5'd0))? 3'b001:
                    ((grfchange_M != 5'd0) && (grfchange_M == RS_D) && (WD3_M == `PC8) && (Tnew_M == 5'd0))? 3'b010:
                    ((grfchange_M != 5'd0) && (grfchange_M == RS_D) && (WD3_M == `AO) && (Tnew_M == 5'd0))? 3'b011:
                    ((grfchange_R != 5'd0) && (grfchange_R == RS_D) && (WD3_R == `PC8) && (Tnew_R == 5'd0))? 3'b100:
                    ((grfchange_R != 5'd0) && (grfchange_R == RS_D) && (WD3_R == `AO) && (Tnew_R == 5'd0))? 3'b101:
                                                                                                            3'b000;

    assign F_RT_D = ((grfchange_E != 5'd0) && (grfchange_E == RT_D) && (WD3_E == `PC8) && (Tnew_E == 5'd0))? 3'b001:
                    ((grfchange_M != 5'd0) && (grfchange_M == RT_D) && (WD3_M == `PC8) && (Tnew_M == 5'd0))? 3'b010:
                    ((grfchange_M != 5'd0) && (grfchange_M == RT_D) && (WD3_M == `AO) && (Tnew_M == 5'd0))? 3'b011:
                    ((grfchange_R != 5'd0) && (grfchange_R == RT_D) && (WD3_R == `PC8) && (Tnew_R == 5'd0))? 3'b100:
                    ((grfchange_R != 5'd0) && (grfchange_R == RT_D) && (WD3_R == `AO) && (Tnew_R == 5'd0))? 3'b101:
                                                                                                            3'b000;

    assign F_RS_E = ((grfchange_M != 5'd0) && (grfchange_M == RS_E) && (WD3_M == `PC8) && (Tnew_M == 5'd0))? 3'b001:
                    ((grfchange_M != 5'd0) && (grfchange_M == RS_E) && (WD3_M == `AO) && (Tnew_M == 5'd0))? 3'b010:
                    ((grfchange_R != 5'd0) && (grfchange_R == RS_E) && (WD3_R == `PC8) && (Tnew_R == 5'd0))? 3'b011:
                    ((grfchange_R != 5'd0) && (grfchange_R == RS_E) && (WD3_R == `AO) && (Tnew_R == 5'd0))? 3'b100:
                                      ((grfchange_W != 5'd0) && (grfchange_W == RS_E) && (Tnew_W == 5'd0))? 3'b101:
                                                                                                            3'b000;

    assign F_RT_E = ((grfchange_M != 5'd0) && (grfchange_M == RT_E) && (WD3_M == `PC8) && (Tnew_M == 5'd0))? 3'b001:
                    ((grfchange_M != 5'd0) && (grfchange_M == RT_E) && (WD3_M == `AO) && (Tnew_M == 5'd0))? 3'b010:
                    ((grfchange_R != 5'd0) && (grfchange_R == RT_E) && (WD3_R == `PC8) && (Tnew_R == 5'd0))? 3'b011:
                    ((grfchange_R != 5'd0) && (grfchange_R == RT_E) && (WD3_R == `AO) && (Tnew_R == 5'd0))? 3'b100:
                                       ((grfchange_W != 5'd0) && (grfchange_W == RT_E) && (Tnew_W == 5'd0))? 3'b101:
                                                                                                             3'b000;

    assign F_RT_M = ((grfchange_R != 5'd0) && (grfchange_R == RT_M) && (WD3_R == `PC8) && (Tnew_R == 5'd0))? 3'b001:
                    ((grfchange_R != 5'd0) && (grfchange_R == RT_M) && (WD3_R == `AO) && (Tnew_R == 5'd0))? 3'b010:
                                      ((grfchange_W != 5'd0) && (grfchange_W == RT_M)  && (Tnew_W == 5'd0))? 3'b011:
                                                                                                             3'b000;

                    

endmodule
