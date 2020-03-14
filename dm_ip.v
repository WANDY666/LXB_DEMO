`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/09 19:18:42
// Design Name: 
// Module Name: dm_ip
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


module dm_ip(
    input clk,
    input reset,
    input [31:0] PC,
    input wen,
    input [3:0] BE,
    input [31:0] wdata,
    input ren,
    input [31:0] addr,
    output reg [31:0] rdata
    );

    reg [31:0] sram[0:1023];

    integer i;
    always @(posedge clk)
        if(reset) begin
            rdata <= 0;
            for(i = 0; i<1024 ; i = i+1)    
                sram[i] <= 0;   
        end
        else if(wen) begin  
            begin
                if(BE[3])
                    sram[addr[11:2]][31:24] <= wdata[31:24];
                if(BE[2])
                    sram[addr[11:2]][23:16] <= wdata[23:16];
                if(BE[1])
                    sram[addr[11:2]][15:8] <= wdata[15:8];
                if(BE[0])
                    sram[addr[11:2]][7:0] <= wdata[7:0];
            end
            $display("%d@%h: *%h <= %h", $time, PC, addr, sram[addr[11:2]]);
        end
        else if(ren) begin  
            rdata <= sram[addr[11:2]];
        end

endmodule
