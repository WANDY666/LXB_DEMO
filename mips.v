`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/18 15:03:24
// Design Name: 
// Module Name: mips
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


module mips(
    input clk,
    input reset
    );

    wire inst_sram_en;
    wire [3:0] inst_sram_wen;
    wire [31:0] inst_sram_addr;
    wire [31:0] inst_sram_wdata;
    wire [31:0] inst_sram_rdata;
    wire data_sram_en;
    wire [3:0] data_sram_wen;
    wire [31:0] data_sram_addr;
    wire [31:0] data_sram_wdata;
    wire [31:0] data_sram_rdata;
    wire [31:0] debug_wb_pc;
    wire [3:0] debug_wb_rf_wen;
    wire [4:0] debug_wb_rf_wnum;
    wire [31:0] debug_wb_rf_wdata;
    wire [31:0] PC_M;
    wire DM_REN_M;
    wire [31:0] AO_M;
    wire [31:0] PC_F;
    cpu CPU(
        .clk(clk),
        .resetn(~reset),
        .int(6'd0),
        .inst_sram_en(inst_sram_en),
        .inst_sram_wen(inst_sram_wen),
        .inst_sram_addr(inst_sram_addr),
        .inst_sram_wdata(inst_sram_wdata),
        .inst_sram_rdata(inst_sram_rdata),
        .data_sram_en(data_sram_en),
        .data_sram_wen(data_sram_wen),
        .data_sram_addr(data_sram_addr),
        .data_sram_wdata(data_sram_wdata),
        .data_sram_rdata(data_sram_rdata),
        .debug_wb_pc(debug_wb_pc),
        .debug_wb_rf_wen(debug_wb_rf_wen),
        .debug_wb_rf_wnum(debug_wb_rf_wnum),
        .debug_wb_rf_wdata(debug_wb_rf_wdata),
        .PC_M(PC_M),
        .DM_REN_M(DM_REN_M),
        .AO_M(AO_M),
        .PC_F(PC_F)
    );

    im_ip IM(
        .clk(clk),
        .reset(reset),
        .addr(PC_F),
        .ren(inst_sram_en),
        .rdata(inst_sram_rdata)
    );

    dm_ip DM(
        .clk(clk),
        .reset(reset),
        .PC(PC_M),
        .wen(|data_sram_wen),
        .BE(data_sram_wen),
        .wdata(data_sram_wdata),
        .ren(DM_REN_M),
        .addr(AO_M),
        .rdata(data_sram_rdata)
    );
    
endmodule
