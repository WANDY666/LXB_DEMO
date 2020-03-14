`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/09 19:17:26
// Design Name: 
// Module Name: grf
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


module grf(
    input clk,
    input reset,
    input [31:0] PC,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
    input WEN,
    output [31:0] RD1,
    output [31:0] RD2
    );
    
    reg [31:0] GRF[0:31];
    integer i;

    assign RD1 = (WEN && (A3 != 0) && (A3 == A1))? WD3 : GRF[A1];   
    assign RD2 = (WEN && (A3 != 0) && (A3 == A2))? WD3 : GRF[A2];

    always @(posedge clk)
        if(reset)
            for(i = 0; i<32 ; i = i+1)
                GRF[i] = 0;
        else if((A3 != 0) && WEN) begin
            GRF[A3] = WD3;
            $display("%d@%h: $%d <= %h", $time, PC, A3, WD3);
        end
    
endmodule
