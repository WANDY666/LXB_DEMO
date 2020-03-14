`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/09 19:17:26
// Design Name: 
// Module Name: cmp
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


module cmp(
    input [31:0] D1,
    input [31:0] D2,
    input [2:0] CMP_CTR,
    output RES_CMP
    );

    wire EQ, LEZ, GTZ, LTZ, GEZ;
    assign EQ = (D1 == D2);
	assign GEZ = ($signed(D1) >= 0);
	assign GTZ = ($signed(D1) > 0);
	assign LEZ = ($signed(D1) <= 0);
	assign LTZ = ($signed(D1) < 0);

    assign RES_CMP = (CMP_CTR == 3'b110)? EQ:
                     (CMP_CTR == 3'b001)? ~EQ:
                     (CMP_CTR == 3'b010)? GEZ:
                     (CMP_CTR == 3'b011)? GTZ:
                     (CMP_CTR == 3'b100)? LEZ:
                     (CMP_CTR == 3'b101)? LTZ:
                                         1'b0;

endmodule
