`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/08 10:01:05
// Design Name: 
// Module Name: npc
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


module npc(
    input eret,
    input IntReq,
    input stall,
    input [31:0] PC,
    input [31:0] PC4_D,
    input [25:0] IR26_D,
    input [31:0] RF_RS,
    input [31:0] PC_BP,
    input BP_WR,
    input [1:0] NPC_CTR, 
    input [31:0] PC_T,
    input [31:0] EPC,
    output [31:0] NPC,
    output [31:0] NPC_01
    );

    wire [31:0] NPC_00, NPC_10, NPC_11;
    assign NPC_00 = PC;
    assign NPC_01 = PC4_D + {{14{IR26_D[15]}}, IR26_D[15:0], 2'b00};
    assign NPC_10 = {PC4_D[31:28], IR26_D, 2'b00};
    assign NPC_11 = RF_RS;

    assign NPC = IntReq? 32'hBFC00380:
                 eret?   EPC:
                 stall? PC_T:
                 BP_WR? PC_BP:
                 (NPC_CTR == 2'b00)? NPC_00:
                 (NPC_CTR == 2'b01)? NPC_01:
                 (NPC_CTR == 2'b10)? NPC_10:
                 (NPC_CTR == 2'b11)? NPC_11:
                                     NPC_00;
                                   
endmodule
