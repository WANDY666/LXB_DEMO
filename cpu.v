`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Data: 2020/02/12 09:41:41
// Design Name: 
// Module Name: cpu
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


module cpu(
    input clk,
    input resetn,
    input [5:0] int,
    output inst_sram_en,
    output [3:0] inst_sram_wen,
    output [31:0] inst_sram_addr,
    output [31:0] inst_sram_wdata,
    input [31:0] inst_sram_rdata,
    output data_sram_en,
    output [3:0] data_sram_wen,
    output [31:0] data_sram_addr,
    output [31:0] data_sram_wdata,
    input [31:0] data_sram_rdata,
    output [31:0] debug_wb_pc,
    output [3:0] debug_wb_rf_wen,
    output [4:0] debug_wb_rf_wnum,
    output [31:0] debug_wb_rf_wdata,
    output [31:0] PC_M,
    output DM_REN_M,
    output [31:0] AO_M,
    output [31:0] PC_F
    );
// ========================================================================
    reg BD;
    wire reset;
    wire BP, ALUB_SEL_D, DM_REN_D, DM_WEN_D, REG_WEN_D, BR_D, START_D, START_E, MD_D, AO_SEL_D, AO_SEL_E, IntReq;
    wire BJ_D, ERET_D, BREAK_D, SYSCALL_D, CP_WEN_D, AC_SEL_D, RI_D, OVERABLE_D, OVER_E, OVER_M;
    wire BJ_E, ERET_E, BREAK_E, SYSCALL_E, CP_WEN_E, AC_SEL_E, RI_E, OVERABLE_E;
    wire BJ_M, ERET_M, BREAK_M, SYSCALL_M, CP_WEN_M, AC_SEL_M, RI_M, OVERABLE_M;
    wire EN_PC, BP_WR, CLR_FT, EN_FT, ISIR_T, ISIR_D, ISIR_E, ISIR_M, ISIR_R, ISIR_W, CLR_TD, EN_TD, STALL_PC, STALL_T, STALL_D, REG_WEN_W;
    wire CLR_BPU, STALL_BPU, RES_CMP, STALL_TD, CLR_DE, EN_DE, ALUB_SEL_E, DM_REN_E, DM_WEN_E, REG_WEN_E; 
    wire CLR_EM, EN_EM, DM_WEN_M, REG_WEN_M, CLR_MR, EN_MR, REG_WEN_R, CLR_RW, EN_RW, EXC;
    wire CLR_MD, BUSY;
    wire [1:0] NPC_CTR_D, EXT_CTR_D, A3_SEL_D, WD3_SEL_D, S_SEL_D, S_SEL_E, S_SEL_M, WD3_SEL_E, WD3_SEL_M, WD3_SEL_R, WD3_SEL_W;
    wire [2:0] CMP_CTR_D, CMP_CTR_E, LD_CTR_D, LD_CTR_E, LD_CTR_M, LD_CTR_R, MD_OP_D, MD_OP_E, F_RS_D, F_RT_D, F_RS_E, F_RT_E, F_RT_M;
    wire [3:0] BE;
    wire [4:0] ALU_CTR_D, A3_W, A3_D, A3_M, A3_R, ALU_CTR_E, A3_E, EXCCODE;
    wire [31:0] IR_D, EPC, CP0_RD, AO_R, PC4_F, PC, PC4_D, MF_RS_D, PC_BP, PC_B, PC_T, PC4_T, IR_T, PC8_T, PC_D, PC8_D, WD3, RD1, RD2, PC_W; 
    wire [31:0] IMM_EXT_D, PC_E, PC4_E, PC8_E, IR_E, MF_RT_D, RF_RS_E, RF_RT_E, IMM_EXT_E, MF_RS_E, MF_RT_E;
    wire [31:0] SRCB, AO_E, RES_ALU_E, HL_E, PC4_M, PC8_M, IR_M, RF_RT_M, RDATA_R, MF_RT_M, RDATA, WDATA;
    wire [31:0] PC_R, PC4_R, PC8_R, IR_R, PC4_W, PC8_W, IR_W, AO_W, RDATA_W;
    wire [44:0] Data_HI_D, Data_HI_E, Data_HI_M, Data_HI_R, Data_HI_W;
    assign CLR_TD = (BP_WR && !STALL_BPU) || IntReq;
    assign EN_PC = ~STALL_PC;
    assign EN_FT = ~STALL_T;
    assign EN_TD = ~STALL_D;
    assign EN_DE = ~(STALL_BPU && BP_WR);
    assign CLR_EM = ~EN_DE;
    always @(posedge clk)
        if(reset)
            BD <= 1'b0;
        else if(!(IR_M == 0 && REG_WEN_M == 0))
            BD <= BJ_M;
    wire [31:0] PC_CP0 = ISIR_M? PC_M:
                         ISIR_E? PC_E:
                         ISIR_D? PC_D:
                         ISIR_T? PC_T:
                                 PC_F;
// ========================================================================
    assign reset = !resetn;
    assign inst_sram_en = 1'b1;
    assign inst_sram_wen = 4'd0;
    
    TL TL_IM(
        .VAddr(PC_F),
        .RAddr(inst_sram_addr)
    );
    
    assign inst_sram_wdata = 32'd0;
    assign IR_T = inst_sram_rdata;

    assign data_sram_en = DM_REN_M || (DM_WEN_M && !IntReq);
    assign data_sram_wen = (DM_WEN_M && !IntReq)? BE:4'd0;
    
    TL TL_DM(
        .VAddr(AO_M),
        .RAddr(data_sram_addr)
    );
    
    assign data_sram_wdata = WDATA;
    assign RDATA = data_sram_rdata;

    assign debug_wb_pc = PC_W;
    assign debug_wb_rf_wen = {4{REG_WEN_W}};
    assign debug_wb_rf_wnum = A3_W;
    assign debug_wb_rf_wdata = WD3; 

    // im_ip IM(
    //     .clk(clk),
    //     .reset(reset),
    //     .addr(PC_F),
    //     .ren(1'b1),
    //     .rdata(IR_T)
    // );
    // dm_ip DM(
    //     .clk(clk),
    //     .reset(reset),
    //     .PC(PC_M),
    //     .wen(DM_WEN_M && !IntReq),
    //     .BE(BE),
    //     .wdata(WDATA),
    //     .ren(DM_REN_M),
    //     .addr(AO_M),
    //     .rdata(RDATA)
    // );

    controller CTR(
        .IR(IR_D),
        .BP(BP),
        .NPC_CTR(NPC_CTR_D),
        .EXT_CTR(EXT_CTR_D),
        .ALUB_SEL(ALUB_SEL_D),
        .ALU_CTR(ALU_CTR_D),
        .DM_REN(DM_REN_D),
        .DM_WEN(DM_WEN_D),
        .A3_SEL(A3_SEL_D),
        .WD3_SEL(WD3_SEL_D),
        .REG_WEN(REG_WEN_D),
        .CMP_CTR(CMP_CTR_D),
        .Data_Hazard_IR(Data_HI_D),
        .BR(BR_D),
        .S_SEL(S_SEL_D),
        .LD_CTR(LD_CTR_D),
        .MD_OP(MD_OP_D),
        .start(START_D),
        .MD(MD_D),
        .AO_SEL(AO_SEL_D),
        .BJ(BJ_D),
        .eret(ERET_D),
        .break(BREAK_D),
        .syscall(SYSCALL_D),
        .CP_WEN(CP_WEN_D),
        .AC_SEL(AC_SEL_D),
        .RI(RI_D),
        .Overable(OVERABLE_D) 
    );
// ========================================================================

    pc Pc(
        .clk(clk),
        .reset(reset),
        .en(EN_PC || IntReq),
        .PC4_F(PC4_F),
        .PC(PC)
    );
// ========================================================================

    npc NPC(
        .eret(ERET_M),
        .IntReq(IntReq),
        .stall(STALL_PC),
        .PC(PC),
        .PC4_D(PC4_D),
        .IR26_D(IR_D[25:0]),
        .RF_RS(MF_RS_D),
        .PC_BP(PC_BP),
        .BP_WR(BP_WR),
        .NPC_CTR(NPC_CTR_D), 
        .PC_T(PC_T),
        .NPC(PC_F),
        .NPC_01(PC_B),
        .EPC(EPC)
    );
// ========================================================================
    add4 ADD4_F(.PC(PC_F), .PC4(PC4_F));
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

    reg_flow FT(
        .clk(clk),
        .reset(reset),
        .clr(CLR_FT),
        .en(EN_FT || IntReq),
        .isIR_I(1'b1),
        .PC_I(PC_F),
        .PC4_I(PC4_F),
        .PC_O(PC_T),
        .PC4_O(PC4_T),
        .isIR_O(ISIR_T)
    );
// ========================================================================

    add4 ADD4_T(.PC(PC4_T), .PC4(PC8_T));
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

    reg_flow TD(
        .clk(clk),
        .reset(reset),
        .clr(CLR_TD || ERET_M),
        .en(EN_TD),
        .isIR_I(ISIR_T),
        .PC_I(PC_T),
        .PC4_I(PC4_T),
        .PC8_I(PC8_T),
        .IR_I(IR_T),
        .isIR_O(ISIR_D),
        .PC_O(PC_D),
        .PC4_O(PC4_D),
        .PC8_O(PC8_D),
        .IR_O(IR_D)
    );
// ========================================================================
    
    grf GRF(
        .clk(clk),
        .reset(reset),
        .PC(PC_W),
        .A1(IR_D[25:21]),
        .A2(IR_D[20:16]),
        .A3(A3_W),
        .WD3(WD3),
        .WEN(REG_WEN_W),
        .RD1(RD1),
        .RD2(RD2)
    );
// ========================================================================
    
    bpu BPU(
        .clk(clk),
        .reset(reset),
        .clr(IntReq || ERET_M),
        .stall(STALL_BPU),
        .BR(BR_D),
        .RES_CMP(RES_CMP),
        .PC(PC),
        .PC_B(PC_B),
        .BP(BP),
        .PC_BP(PC_BP),
        .BP_WR(BP_WR)
    );
// ========================================================================

    ext EXT(
        .imm(IR_D[15:0]),
        .EXT_CTR(EXT_CTR_D),
        .imm_ext(IMM_EXT_D)
    );
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

    reg_flow DE(
        .clk(clk),
        .reset(reset),
        .clr(CLR_DE || IntReq || ERET_M),
        .en(EN_DE),
        .isIR_I(ISIR_D),
        .PC_I(PC_D),
        .PC4_I(PC4_D),
        .PC8_I(PC8_D),
        .IR_I(IR_D),
        .RF_RS_I(MF_RS_D),
        .RF_RT_I(MF_RT_D),
        .IMM_EXT_I(IMM_EXT_D),
        .ALUB_SEL_I(ALUB_SEL_D),
        .ALU_CTR_I(ALU_CTR_D),
        .DM_REN_I(DM_REN_D),
        .DM_WEN_I(DM_WEN_D),
        .WD3_SEL_I(WD3_SEL_D),
        .REG_WEN_I(REG_WEN_D),
        .Data_Hazard_I(Data_HI_D),
        .A3_I(A3_D),
        .CMP_CTR_I(CMP_CTR_D),
        .S_SEL_I(S_SEL_D),
        .LD_CTR_I(LD_CTR_D),
        .MD_OP_I(MD_OP_D),
        .start_I(START_D),
        .AO_SEL_I(AO_SEL_D),
        .BJ_I(BJ_D),
        .eret_I(ERET_D),
        .break_I(BREAK_D),
        .syscall_I(SYSCALL_D),
        .CP_WEN_I(CP_WEN_D),
        .AC_SEL_I(AC_SEL_D),
        .RI_I(RI_D),
        .Overable_I(OVERABLE_D),
        .isIR_O(ISIR_E),
        .PC_O(PC_E),
        .PC4_O(PC4_E),
        .PC8_O(PC8_E),
        .IR_O(IR_E),
        .RF_RS_O(RF_RS_E),
        .RF_RT_O(RF_RT_E),
        .IMM_EXT_O(IMM_EXT_E),
        .ALUB_SEL_O(ALUB_SEL_E),
        .ALU_CTR_O(ALU_CTR_E),
        .DM_REN_O(DM_REN_E),
        .DM_WEN_O(DM_WEN_E),
        .WD3_SEL_O(WD3_SEL_E),
        .REG_WEN_O(REG_WEN_E),
        .Data_Hazard_O(Data_HI_E),
        .A3_O(A3_E),
        .CMP_CTR_O(CMP_CTR_E),
        .S_SEL_O(S_SEL_E),
        .LD_CTR_O(LD_CTR_E),
        .MD_OP_O(MD_OP_E),
        .start_O(START_E),
        .AO_SEL_O(AO_SEL_E),
        .BJ_O(BJ_E),
        .eret_O(ERET_E),
        .break_O(BREAK_E),
        .syscall_O(SYSCALL_E),
        .CP_WEN_O(CP_WEN_E),
        .AC_SEL_O(AC_SEL_E),
        .RI_O(RI_E),
        .Overable_O(OVERABLE_E)
    );
// ========================================================================
    cmp CMP(
        .D1(MF_RS_E),
        .D2(MF_RT_E),
        .CMP_CTR(CMP_CTR_E),
        .RES_CMP(RES_CMP)
    );
// ========================================================================

    alu ALU(
        .ALU_CTR(ALU_CTR_E),
        .SrcA(MF_RS_E),
        .SrcB(SRCB),
        .shamt(IR_E[10:6]),
        .AO_E(RES_ALU_E),
        .over(OVER_E)
    );

    md MD(
        .clk(clk),
        .reset(reset),
        .clr(1'b0),
        .start(START_E && !IntReq),
        .MD_OP(MD_OP_E),
        .A(MF_RS_E),
        .B(MF_RT_E),
        .HL(HL_E),
        .BUSY(BUSY)
    );

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
    
    reg_flow EM(
        .clk(clk),
        .reset(reset),
        .clr(CLR_EM || IntReq || ERET_M),
        .en(1'b1),
        .isIR_I(ISIR_E),
        .PC_I(PC_E),
        .PC4_I(PC4_E),
        .PC8_I(PC8_E),
        .IR_I(IR_E),
        .RF_RT_I(MF_RT_E),
        .AO_I(AO_E),
        .DM_REN_I(DM_REN_E),
        .DM_WEN_I(DM_WEN_E),
        .WD3_SEL_I(WD3_SEL_E),
        .REG_WEN_I(REG_WEN_E),
        .Data_Hazard_I(Data_HI_E),
        .A3_I(A3_E),
        .S_SEL_I(S_SEL_E),
        .LD_CTR_I(LD_CTR_E),
        .BJ_I(BJ_E),
        .eret_I(ERET_E),
        .break_I(BREAK_E),
        .syscall_I(SYSCALL_E),
        .CP_WEN_I(CP_WEN_E),
        .AC_SEL_I(AC_SEL_E),
        .RI_I(RI_E),
        .Overable_I(OVERABLE_E),
        .over_I(OVER_E),
        .isIR_O(ISIR_M),
        .PC_O(PC_M),
        .PC4_O(PC4_M),
        .PC8_O(PC8_M),
        .IR_O(IR_M),
        .RF_RT_O(RF_RT_M),
        .AO_O(AO_M),
        .DM_REN_O(DM_REN_M),
        .DM_WEN_O(DM_WEN_M),
        .WD3_SEL_O(WD3_SEL_M),
        .REG_WEN_O(REG_WEN_M),
        .Data_Hazard_O(Data_HI_M),
        .A3_O(A3_M),
        .S_SEL_O(S_SEL_M),
        .LD_CTR_O(LD_CTR_M),
        .BJ_O(BJ_M),
        .eret_O(ERET_M),
        .break_O(BREAK_M),
        .syscall_O(SYSCALL_M),
        .CP_WEN_O(CP_WEN_M),
        .AC_SEL_O(AC_SEL_M),
        .RI_O(RI_M),
        .Overable_O(OVERABLE_M),
        .over_O(OVER_M)
    );
// ========================================================================
    be Be(
        .addr(AO_M[1:0]),
        .MF_RT_M(MF_RT_M),
        .S_SEL(S_SEL_M),
        .wdata(WDATA),
        .BE(BE)
    );


    ld_ext LD_EXT(
        .addr(AO_R[1:0]),
        .rdata_dm(RDATA),
        .LD_CTR(LD_CTR_R),
        .rdata(RDATA_R)
    );
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 

    reg_flow MR(
        .clk(clk),
        .reset(reset),
        .clr(CLR_MR || IntReq),
        .en(1'b1),
        .isIR_I(ISIR_M),
        .PC_I(PC_M),
        .PC4_I(PC4_M),
        .PC8_I(PC8_M),
        .IR_I(IR_M),
        .AO_I(AC_SEL_M? CP0_RD: AO_M),
        .WD3_SEL_I(WD3_SEL_M),
        .REG_WEN_I(REG_WEN_M),
        .Data_Hazard_I(Data_HI_M),
        .A3_I(A3_M),
        .LD_CTR_I(LD_CTR_M),
        .isIR_O(ISIR_R),
        .PC_O(PC_R),
        .PC4_O(PC4_R),
        .PC8_O(PC8_R),
        .IR_O(IR_R),
        .AO_O(AO_R),
        .WD3_SEL_O(WD3_SEL_R),
        .REG_WEN_O(REG_WEN_R),
        .Data_Hazard_O(Data_HI_R),
        .A3_O(A3_R),
        .LD_CTR_O(LD_CTR_R)
    );
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 

    reg_flow RW(
        .clk(clk),
        .reset(reset),
        .clr(CLR_RW),
        .en(1'b1),
        .isIR_I(ISIR_R),
        .PC_I(PC_R),
        .PC4_I(PC4_R),
        .PC8_I(PC8_R),
        .IR_I(IR_R),
        .AO_I(AO_R),
        .RDATA_I(RDATA_R),
        .WD3_SEL_I(WD3_SEL_R),
        .REG_WEN_I(REG_WEN_R),
        .Data_Hazard_I(Data_HI_R),
        .A3_I(A3_R),
        .isIR_O(ISIR_W),
        .PC_O(PC_W),
        .PC4_O(PC4_W),
        .PC8_O(PC8_W),
        .IR_O(IR_W),
        .AO_O(AO_W),
        .RDATA_O(RDATA_W),
        .WD3_SEL_O(WD3_SEL_W),
        .REG_WEN_O(REG_WEN_W),
        .Data_Hazard_O(Data_HI_W),
        .A3_O(A3_W)
    );
// ################################################################
    

    hazard HAZARD(
        .Data_D(Data_HI_D),
        .Data_E(Data_HI_E),
        .Data_M(Data_HI_M),
        .Data_R(Data_HI_R),
        .Data_W(Data_HI_W),
        .start_E(START_E),
        .BUSY_E(BUSY),
        .MD_D(MD_D),
        .F_RS_D(F_RS_D),
        .F_RT_D(F_RT_D),
        .F_RS_E(F_RS_E),
        .F_RT_E(F_RT_E),
        .F_RT_M(F_RT_M),
        .Stall_PC(STALL_PC),
        .Stall_T(STALL_T),
        .Stall_D(STALL_D),
        .Stall_BPU(STALL_BPU),
        .Flush_E(CLR_DE)
    );

// ========================================================================
    mux_normal MUX_NORMAL(
        .IR_D(IR_D),
        .A3_SEL(A3_SEL_D),
        .A3(A3_D),
        .RF_RT(MF_RT_E),
        .imm_ext(IMM_EXT_E),
        .ALUB_SEL(ALUB_SEL_E),
        .ALUB(SRCB),
        .RDATA(RDATA_W),
        .RES_ALU_W(AO_W),
        .PC8_W(PC8_W),
        .WD3_SEL(WD3_SEL_W),
        .WD3(WD3),
        .RES_ALU_E(RES_ALU_E),
        .HL_E(HL_E),
        .AO_SEL_E(AO_SEL_E),
        .AO_E(AO_E)
    );
// ========================================================================
    mux_forward MUX_FORWARD(
        .RD1(RD1),
        .PC8_E(PC4_E),
        .PC8_M(PC8_M),
        .PC8_R(PC8_R),
        .AO_M(AO_M),
        .AO_R(AO_R),
        .F_RS_D(F_RS_D),
        .MF_RS_D(MF_RS_D),
    
        .RD2(RD2),
        .F_RT_D(F_RT_D),
        .MF_RT_D(MF_RT_D),
    
        .RS_E(RF_RS_E),
        .WD3(WD3),
        .F_RS_E(F_RS_E),
        .MF_RS_E(MF_RS_E),
    
        .RT_E(RF_RT_E),
        .F_RT_E(F_RT_E),
        .MF_RT_E(MF_RT_E),
    
        .RT_M(RF_RT_M),
        .F_RT_M(F_RT_M),
        .MF_RT_M(MF_RT_M)
    );
    check CKECK(
        .PC_M(PC_M),
        .S_SEL_M(S_SEL_M),
        .SL_Addr(AO_M),
        .DM_REN_M(DM_REN_M),
        .DM_WEN_M(DM_WEN_M),
        .RI(RI_M),             
        .break(BREAK_M),          
        .syscall(SYSCALL_M),        
        .Overable(OVERABLE_M),       
        .Over(OVER_M),           
        .Exc(EXC),
        .ExcCode(EXCCODE)
    );


    cp0 CP0(
        .clk(clk),
        .reset(reset),
        .PC_M(PC_CP0),
        .Addr(AO_M),
        .HW(int),     
        .eret(ERET_M),           
        .BD(BD),             
        .EXC(EXC),            
        .EXCCODE(EXCCODE),  
        .A(IR_M[15:11]),        
        .WEN(CP_WEN_M),            
        .WD(MF_RT_M),      
        .RD(CP0_RD),     
        .EPC(EPC),
        .IntReq(IntReq)
    );

endmodule
