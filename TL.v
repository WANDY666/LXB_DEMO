`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/18 13:41:59
// Design Name: 
// Module Name: TL
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

module TL(
    input [31:0] VAddr,
    output [31:0] RAddr
    );

    assign RAddr = (VAddr[31:29] == 3'd4)? {3'd0, VAddr[28:0]}:
                   (VAddr[31:29] == 3'd5)? {3'd0, VAddr[28:0]}:
                                           VAddr;             

endmodule
