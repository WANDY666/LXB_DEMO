`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/11 13:42:37
// Design Name: 
// Module Name: bpu
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
`define S0 2'b00
`define S1 2'b01
`define S2 2'b10

`define SNT 2'b00
`define WNT 2'b01
`define WT 2'b10
`define ST 2'b11

module bpu(
    input clk,
    input reset,
    input clr,
    input stall,
    input BR,
    input RES_CMP,
    input [31:0] PC,
    input [31:0] PC_B,
    output BP,
    output reg [31:0] PC_BP,
    output BP_WR
    );

    reg[1:0] state, DBP;
    assign BP = BR && DBP[1];
    assign BP_WR = ((RES_CMP && (state == `S2)) || (!RES_CMP && (state == `S1)));

    always @(posedge clk) begin
        if (reset || clr) begin
            state <= `S0;
            DBP <= `WT;
            PC_BP <= 0;
        end
        else if(!stall) begin
            case (state)
                `S0: 
                    if(BR) begin
                        if(DBP[1]) begin
                            state <= `S1;
                            PC_BP <= PC;
                        end
                        else begin
                            state <= `S2;
                            PC_BP <= PC_B;
                        end
                        state <= DBP[1]? `S1 : `S2;
                    end 
                default:begin
                    if(RES_CMP && (DBP != `ST))
                        DBP <= DBP + 2'b01;
                    else if(!RES_CMP && (DBP != `SNT))
                        DBP <= DBP - 2'b01;
                    state <= `S0;
                end
            endcase
        end
    end

endmodule
