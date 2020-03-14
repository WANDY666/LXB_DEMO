`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/09 19:17:26
// Design Name: 
// Module Name: controller
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

`define PC8 5'd0
`define AO 5'd1
`define DR 5'd2
`define NULL 5'd3

module controller(
    input [31:0] IR,
    input BP,
    output [1:0] NPC_CTR,
    output [1:0] EXT_CTR,
    output ALUB_SEL,
    output [4:0] ALU_CTR,
    output DM_REN,
    output DM_WEN,
    output [1:0] A3_SEL,
    output [1:0] WD3_SEL,
    output REG_WEN,
    output [2:0] CMP_CTR,
    output[44:0] Data_Hazard_IR,
    output BR,
    output [1:0] S_SEL,
    output [2:0] LD_CTR,
    output [2:0] MD_OP,
    output start,
    output MD,
    output AO_SEL,
    // P7
    output BJ,
    output eret,
    output break,
    output syscall,
    output CP_WEN,
    output AC_SEL,
    output RI,
    output Overable 
    );

    wire [5:0] op, func;
    wire [4:0] rs, rt, rd, shamt;
    wire [34:0] Data_Hazard;
    assign {op, rs, rt, rd, shamt, func} = IR;

    wire addu, subu, lui, ori, lw, sw, beq, j, jal, jr, jalr;
    wire add, addi, addiu, sub, slt, slti, sltu, sltiu, And, andi, Nor,	Or,	Xor, xori, sllv, sll, srav, sra, srlv, srl;
    wire bne, bgez, bgtz, blez, bltz, bgezal, bltzal;
    wire lb, lbu, lh, lhu, sb, sh;
    wire mult, multu, div, divu, mthi, mtlo, mfhi, mflo;
    wire CAL_R, CAL_I, J, SHIFT, ST, LD;
    wire mtc0, mfc0;
    assign CAL_R = addu || add || sub || subu || slt || sltu || And || Nor || Or || Xor;
    assign CAL_I = lui || ori || addi || addiu || slti || sltiu || andi || xori;
    assign J = j || jal || jalr || jr;
    assign SHIFT = sllv || sll || srav || sra || srlv || srl;
    assign BR = beq || bne || bgez || bgtz || blez || bltz || bgezal || bltzal;
    assign ST = sb || sh || sw;
    assign LD = lb || lbu || lh || lhu || lw;
    assign MD = mult || multu || div || divu || mthi || mtlo || mfhi || mflo;
    assign BJ = J || BR;
    assign RI = !(CAL_R || CAL_I || J || SHIFT || BR || ST || LD || MD || mtc0 || mfc0 || eret || syscall || break); 
    assign Overable = add || addi || sub;

    assign addu = (op == 0) && (func == 6'b100001);
	assign subu = (op == 0) && (func == 6'b100011);
	assign lui = (op == 6'b001111);
	assign ori = (op == 6'b001101);
    assign lw = (op == 6'b100011);
	assign sw = (op == 6'b101011);
	assign beq = (op == 6'b000100);
	assign j = (op == 6'b000010);
	assign jal = (op == 6'b000011);
	assign jr = (op == 0) && (func == 6'b001000);
    assign jalr = (op == 0) && (func == 6'b001001);

    assign add = (op == 0) && (func == 6'b100000);
    assign addi = (op == 6'b001000);
    assign addiu = (op == 6'b001001);
    assign sub = (op == 0) && (func == 6'b100010);
    assign slt = (op == 0) && (func == 6'b101010);
    assign slti = (op == 6'b001010);
    assign sltu = (op == 0) && (func == 6'b101011);
    assign sltiu = (op == 6'b001011);
    assign And = (op == 0) && (func == 6'b100100);
    assign andi = (op == 6'b001100);
    assign Nor = (op == 0) && (func == 6'b100111);
    assign Or = (op == 0) && (func == 6'b100101);
    assign Xor = (op == 0) && (func == 6'b100110);
    assign xori = (op == 6'b001110);
    assign sllv = (op == 0) && (func == 6'b000100);
    assign sll = (op == 0) && (func == 6'b000000);
    assign srav = (op == 0) && (func == 6'b000111);
    assign sra = (op == 0) && (func == 6'b000011);
    assign srlv = (op == 0) && (func == 6'b000110);
    assign srl = (op == 0) && (func == 6'b000010);
    
    assign bne = (op == 6'b000101);
    assign bgez = (op == 6'b000001) && (rt == 5'b00001);
    assign bgtz = (op == 6'b000111) && (rt == 5'b00000);
    assign blez = (op == 6'b000110) && (rt == 5'b00000);
    assign bltz = (op == 6'b000001) && (rt == 5'b00000);
    assign bgezal = (op == 6'b000001) && (rt == 5'b10001);
    assign bltzal = (op == 6'b000001) && (rt == 5'b10000);

    assign lb = (op == 6'b100000);
    assign lbu = (op == 6'b100100);
    assign lh = (op == 6'b100001);
    assign lhu = (op == 6'b100101);
    assign sb = (op == 6'b101000);
    assign sh = (op == 6'b101001);

    assign mult = (op == 0) && (func == 6'b011000);
	assign multu = (op == 0) && (func == 6'b011001);
	assign div = (op == 0) && (func == 6'b011010);
	assign divu = (op == 0) && (func == 6'b011011);
	assign mthi = (op == 0) && (func == 6'b010001);
	assign mtlo = (op == 0) && (func == 6'b010011);
	assign mfhi = (op == 0) && (func == 6'b010000);
	assign mflo = (op == 0) && (func == 6'b010010);

    assign eret =  (op == 6'b010000) && (func == 6'b011000);
    assign mfc0 = (op == 6'b010000) && (rs == 5'b00000);
    assign mtc0 = (op == 6'b010000) && (rs == 5'b00100); 
    assign break = (op == 0) && (func == 6'b001101);
    assign syscall = (op == 0) && (func == 6'b001100);

    assign NPC_CTR = {j || jal || jr || jalr, BP || jr || jalr};
    assign EXT_CTR = {lui, ST || LD || addi || addiu || slti || sltiu};
    assign ALUB_SEL = ST || LD || CAL_I;
    assign ALU_CTR = {1'b0, slt || slti || sltu || sltiu || sllv || sll || srav || sra || srlv || srl, subu || sub || sllv || srav || sra || srlv || Xor || xori, addu || subu || ST || LD || add || addi || addiu || sub || Nor || sll || srav || srlv || srl || lui, ori || sltu || sltiu || Nor || Or || sllv || srav || srl};
    assign DM_REN = LD;
    assign DM_WEN = ST;
    assign A3_SEL = {jal || bgezal || bltzal, jalr || SHIFT || CAL_R || mfhi || mflo};
    assign WD3_SEL = {jal || jalr || bgezal || bltzal, LD};
    assign REG_WEN = CAL_R || CAL_I || SHIFT || LD || jal || jalr || bgezal || bltzal || mfhi || mflo || mfc0; 
    assign CMP_CTR = {beq || blez || bltz || bltzal, beq || bgez || bgezal || bgtz, bne || bgtz || bltz || bltzal};
    assign S_SEL = {sb || lb || lbu, sh || lh || lhu};
    assign LD_CTR = {lh, lb || lhu, lbu || lhu};
    assign MD_OP = {mthi || mtlo || mfhi || mflo, div || divu || mfhi || mflo, multu || divu || mtlo || mflo};  
    assign start =  mult || multu || div || divu || mthi || mtlo;
    assign AO_SEL = mfhi || mflo;
//  P7
    assign CP_WEN = mtc0;
    assign AC_SEL = mfc0;

//                           {`W, `W, 5'd0, 5'd0, 5'd0, `D, `NULL}
//                           {Tuse1, Tuse2, grf1, grf2, grfchange, Tnew, WD3}
    assign Data_Hazard = ST? {`E, `M, rs, rt, 5'd0, `D, `NULL}:
                         LD? {`E, `W, rs, 5'd0, rt, `W, `DR}:
                         (CAL_R || sllv || srav || srlv)? {`E, `E, rs, rt, rd, `M, `AO}:
                         (sll || sra || srl)? {`E, `W, rt, 5'd0, rd, `M, `AO}:
                         (CAL_I)? {`E, `W, rs, 5'd0, rt, `M, `AO}:
                         (beq || bne)? {`E, `E, rs, rt, 5'd0, `D, `NULL}:
                         (bgez || bgtz || blez || bltz)? {`E, `W, rs, 5'd0, 5'd0, `D, `NULL}:
                         (bltzal || bgezal)? {`E, `W, rs, 5'd0, 5'd31, `E, `PC8}: 
                         jal? {`W, `W, 5'd0, 5'd0, 5'd31, `E, `PC8}:
                         jr? {`D, `W, rs, 5'd0, 5'd0, `D, `NULL}:
                         j? {`W, `W, 5'd0, 5'd0, 5'd0, `D, `NULL}:
                         jalr? {`D, `W, rs, 5'd0, rd, `E, `PC8}:
                         (div || divu || mult || multu)? {`E, `E, rs, rt, 5'd0, `D, `NULL}:
                         (mthi || mtlo)? {`E, `W, rs, 5'd0, 5'd0, `D, `NULL}:
                         (mfhi || mflo)? {`W, `W, 5'd0, 5'd0, rd, `M, `AO}:
                         mtc0?           {`M, `W, rt, 5'd0, 5'd0, `D, `NULL}:
                         mfc0?           {`W, `W, 5'd0, 5'd0, rt, `R, `AO}:
                                         {`W, `W, 5'd0, 5'd0, 5'd0, `D, `NULL};

    assign Data_Hazard_IR = {rs, rt, Data_Hazard}; 

endmodule