`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/15 10:50:57
// Design Name: 
// Module Name: md
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

`define  	mult  	3'b000
`define 	multu  	3'b001 
`define 	div    	3'b010     
`define 	divu	3'b011 
`define  	mthi  	3'b100
`define  	mtlo	3'b101
`define     mfhi    3'b110
`define     mflo    3'b111

module md(
    input clk,
    input reset,
    input clr,
    input start,
    input [2:0] MD_OP,
    input [31:0] A,
    input [31:0] B,
    output [31:0] HL,
    output BUSY
    );
	
	integer timeOfCal;
	reg[31:0] H, L, HI, LO;
	
	assign BUSY = (timeOfCal > 0);
    assign HL = (MD_OP == `mfhi)? HI:
                (MD_OP == `mflo)? LO:
                                  0; 
	
	always@(posedge clk) begin
		if(reset || clr) begin
			timeOfCal = 0;
			H <= 0;
			L <= 0;
			HI <= 0;
			LO <= 0;
		end
		else if(start) begin
			case(MD_OP)
				`mult: begin
						timeOfCal = 17;
						{H, L} <= ($signed(A) * $signed(B));
					end
				`multu: begin
						timeOfCal = 17;
						{H, L} <= A * B;
					end
				`div: begin
						timeOfCal = 17;
						L <= ($signed(A)) / ($signed(B));
						H <= $signed(A) % $signed(B);
					end
				`divu: begin
						timeOfCal = 17;
						L <= A / B;
						H <= A % B;
					end
				`mthi: 
					HI <= A;
				`mtlo:
					LO <= A;
			endcase
		end
		else if(timeOfCal > 0) begin
			if(timeOfCal == 1) begin
				HI <= H;
				LO <= L;
			end
			timeOfCal = timeOfCal - 1;
		end
	end
	
endmodule
