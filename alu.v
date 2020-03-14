    `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/09 19:17:26
// Design Name: 
// Module Name: alu
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


module alu(
    input [4:0] ALU_CTR,
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [4:0 ] shamt,
    output [31:0] AO_E,
	output over
    );

    wire[31:0] SRAV, SRA;
	wire[32:0] temp_add, temp_sub;
	assign SRAV = ($signed(SrcB)) >>> SrcA[4:0];
	assign SRA = ($signed(SrcB)) >>> (shamt);
	assign AO_E = (ALU_CTR == 5'b00000)? (SrcA & SrcB) :
                  (ALU_CTR == 5'b00001)? (SrcA | SrcB) :
				  (ALU_CTR == 5'b00010)? (SrcA + SrcB) : 
				  (ALU_CTR == 5'b00011)? (~(SrcA | SrcB)) :
				  (ALU_CTR == 5'b00100)? (SrcA ^ SrcB) :
				  (ALU_CTR == 5'b00110)? (SrcA - SrcB) :
				  (ALU_CTR == 5'b01001)? (SrcA < SrcB) :		
				  (ALU_CTR == 5'b01000)? ($signed(SrcA) < $signed(SrcB)) :
				  (ALU_CTR == 5'b01010)? (SrcB << shamt) :	
				  (ALU_CTR == 5'b01011)? (SrcB >> shamt) :	
				  (ALU_CTR == 5'b01100)? SRA :	
				  (ALU_CTR == 5'b01101)? (SrcB << SrcA[4:0]) :	
				  (ALU_CTR == 5'b01110)? (SrcB >> SrcA[4:0]) :	
				  (ALU_CTR == 5'b01111)? SRAV:	
									     (SrcA + SrcB);

	assign temp_add = {SrcA[31], SrcA} + {SrcB[31], SrcB};
	assign temp_sub = {SrcA[31], SrcA} - {SrcB[31], SrcB};
	assign over = (temp_add[32] != temp_add[31] && ALU_CTR == 5'b00010) || (temp_sub[32] != temp_sub[31] && ALU_CTR == 5'b00110);

endmodule
