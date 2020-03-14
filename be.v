`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/14 16:47:28
// Design Name: 
// Module Name: be
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
`define WORD 2'b00
`define H 2'b01
`define B 2'b10

module be(
    input [1:0] addr,
    input [31:0] MF_RT_M,
    input [1:0] S_SEL,
    output reg [31:0] wdata,
    output reg [3:0] BE
    );

	integer i;
    always@(*) 
        case(S_SEL)
            `WORD:   
                begin
                    BE = 4'b1111;
                    wdata = MF_RT_M;
                end
            `H:	
                begin
                    if(addr[1]) begin
                        BE = 4'b1100;	
                        wdata [31:16] = MF_RT_M[15:0];
                    end
                    else begin
                        BE = 4'b0011;
                        wdata [15:0] = MF_RT_M[15:0];
                    end
                end
            `B:
                begin
                    case(addr[1:0])
                        2'b00: begin
                            BE = 4'b0001;           
                            wdata[7:0] = MF_RT_M[7:0];
                        end
                        2'b01: begin
                            BE = 4'b0010;
                            wdata[15:8] = MF_RT_M[7:0];
                        end
                        2'b10: begin
                            BE = 4'b0100;
                            wdata[23:16] = MF_RT_M[7:0];
                        end
                        2'b11: begin
                            BE = 4'b1000;
                            wdata[31:24] = MF_RT_M[7:0];
                        end
                        default: begin
                            BE = BE;
                            wdata = wdata;
                        end
                    endcase
                end
            default:
                begin
                    BE = BE;
                    wdata = wdata;
                end
        endcase

endmodule