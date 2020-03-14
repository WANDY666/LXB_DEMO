`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Data: 2020/02/09 19:17:26
// Design Name: 
// Module Name: reg_flow
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


module reg_flow(
    input clk,
    input reset,
    input clr,
    input en,
    input [31:0] PC_I,
    input [31:0] PC4_I,
    input [31:0] PC8_I,
    input [31:0] IR_I,
    input [31:0] RF_RS_I,
    input [31:0] RF_RT_I,
    input [31:0] IMM_EXT_I,
    input [31:0] AO_I,
    input [31:0] RDATA_I,
    input ALUB_SEL_I,
    input [4:0] ALU_CTR_I,
    input DM_REN_I,
    input DM_WEN_I,
    input [1:0] WD3_SEL_I,
    input REG_WEN_I,
    input [44:0] Data_Hazard_I,
    input [4:0] A3_I,
    input [2:0] CMP_CTR_I,
    input [1:0] S_SEL_I,
    input [2:0] LD_CTR_I,
    input [2:0] MD_OP_I, 
    input start_I,
    input [31:0] AO_SEL_I,
    input BJ_I,
    input eret_I,
    input break_I,
    input syscall_I,
    input CP_WEN_I,
    input AC_SEL_I,
    input RI_I,
    input Overable_I,
    input over_I,
    input isIR_I,
    output reg [31:0] PC_O,
    output reg [31:0] PC4_O,
    output reg [31:0] PC8_O,
    output reg [31:0] IR_O,
    output reg [31:0] RF_RS_O,
    output reg [31:0] RF_RT_O,
    output reg [31:0] IMM_EXT_O,
    output reg [31:0] AO_O,
    output reg [31:0] RDATA_O,
    output reg ALUB_SEL_O,
    output reg [4:0] ALU_CTR_O,
    output reg DM_REN_O,
    output reg DM_WEN_O,
    output reg [1:0] WD3_SEL_O,
    output reg REG_WEN_O,
    output reg [44:0] Data_Hazard_O,
    output reg [4:0] A3_O,
    output reg [2:0] CMP_CTR_O,
    output reg [1:0] S_SEL_O,
    output reg [2:0] LD_CTR_O,
    output reg [2:0] MD_OP_O,
    output reg start_O,
    output reg AO_SEL_O,
    output reg BJ_O,
    output reg eret_O,
    output reg break_O,
    output reg syscall_O,
    output reg CP_WEN_O,
    output reg AC_SEL_O,
    output reg RI_O,
    output reg Overable_O,
    output reg over_O,
    output reg isIR_O
    );

    always @(posedge clk)
        if(reset || clr) begin
            PC_O <= 32'd0;
            PC4_O <= 32'd0;
            PC8_O <= 32'd0;
            IR_O <= 32'd0;
            RF_RS_O <= 32'd0;
            RF_RT_O <= 32'd0;
            IMM_EXT_O <= 32'd0;
            AO_O <= 32'd0;
            RDATA_O <= 32'd0;
            ALUB_SEL_O <= 0;  
            ALU_CTR_O <= 0;  
            DM_REN_O <= 0;    
            DM_WEN_O <= 0;    
            WD3_SEL_O <= 0;  
            REG_WEN_O <= 0;  
            Data_Hazard_O <= 45'd0; 
            A3_O <= 5'd0;
            CMP_CTR_O <= 3'd0;
            S_SEL_O <= 2'd0;
            LD_CTR_O <= 3'd0;
            MD_OP_O <= 3'd0;
            start_O <= 1'd0;
            AO_SEL_O <= 32'd0;
            BJ_O <= 1'b0;
            eret_O <= 1'b0;
            break_O <= 1'b0;
            syscall_O <= 1'b0;
            CP_WEN_O <= 1'b0;
            AC_SEL_O <= 1'b0;
            RI_O <= 1'b0;
            Overable_O <= 1'b0;
            over_O <= 1'b0;     
            isIR_O <= 1'b0;   
        end
        else if(en) begin
            PC_O <= PC_I;
            PC4_O <= PC4_I;
            PC8_O <= PC8_I;
            IR_O <= IR_I;
            RF_RS_O <= RF_RS_I;
            RF_RT_O <= RF_RT_I;
            IMM_EXT_O <= IMM_EXT_I;
            AO_O <= AO_I;
            RDATA_O <= RDATA_I;
            ALUB_SEL_O <= ALUB_SEL_I;  
            ALU_CTR_O <= ALU_CTR_I;  
            DM_REN_O <= DM_REN_I;    
            DM_WEN_O <= DM_WEN_I;    
            WD3_SEL_O <= WD3_SEL_I;  
            REG_WEN_O <= REG_WEN_I;  
            Data_Hazard_O <=Data_Hazard_I; 
            A3_O <= A3_I;   
            CMP_CTR_O <= CMP_CTR_I;
            S_SEL_O <= S_SEL_I;
            LD_CTR_O <= LD_CTR_I;
            MD_OP_O <= MD_OP_I;
            start_O <= start_I;
            AO_SEL_O <= AO_SEL_I;
            BJ_O <= BJ_I;
            eret_O <= eret_I;
            break_O <= break_I;
            syscall_O <= syscall_I;
            CP_WEN_O <= CP_WEN_I;
            AC_SEL_O <= AC_SEL_I;
            RI_O <= RI_I;
            Overable_O <= Overable_I;
            over_O <= over_I;     
            isIR_O <= isIR_I;   
        end



endmodule
