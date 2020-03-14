`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/16 13:45:24
// Design Name: 
// Module Name: cp0
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


module cp0(
    input clk,
    input reset,
    input [31:0] PC_M,
    input [31:0] Addr,
    input [5:0] HW,     
    input eret,             //from ctr
    input BD,               //from ctr
    input EXC,              //from check
    input [4:0] EXCCODE,    //from check
    input [4:0] A,          //rt -> rd
    input WEN,              //from ctr
    input [31:0] WD,        
    output [31:0] RD,       //mux with AO, AC_SEL
    output reg [31:0] EPC,
    output IntReq
    );

    reg bd, ti, exl, ie;
    reg [4:0] exccode;
    reg [7:0] ip, im;
    reg [31:0] badvaddr;
    reg [32:0] count;

    assign IntReq = (((|(ip & im)) & ie) || EXC) & !exl;
    assign RD = (A == 5'd14)? EPC:
                (A == 5'd13)? {bd, ti, 14'd0, ip, 1'd0, exccode, 2'd0}:
                (A == 5'd12)? {9'd0, 1'b1, 6'd0, im, 6'd0, exl, ie}:
                (A == 5'd9)?  count[32:1]:
                (A == 5'd8)?  badvaddr : 32'd88488848;

    always @(posedge clk) begin
        count = count + 1;
        if(reset) begin
            EPC <= 0;
            bd <= 0;
            ti <= 0;
            exl <= 0;
            ie <= 0;
            exccode <= 0;
            ip <= 0;
            im <= 0;
            count <= 0;
            badvaddr <= 0;
        end
        else begin
            ip[7:2] <= HW;
            if(IntReq) begin
                exl <= 1'b1;
                bd <= BD;
                EPC <= BD? PC_M-4 : PC_M;
                if((|(HW & im)) & ie)
                    exccode <= 5'd0;
                else begin
                    exccode <= EXCCODE;
                    badvaddr <= Addr;
                end
            end
            else if(eret) begin
                exl <= 1'b0;
                bd <= 1'b0;
            end
            else if(WEN) begin
                if(A == 5'd9)
                    count <= WD;
                else if(A == 5'd12) begin
                    im <= WD[15:8];
                    exl <= WD[1];
                    ie <= WD[0];
                end
                else if (A == 5'd13) begin
                    ip[1:0] <= WD[9:8];
                end 
                else if(A == 5'd14) begin
                    EPC[31:0] <= WD[31:0];
                end
            end
        end
    end

endmodule
