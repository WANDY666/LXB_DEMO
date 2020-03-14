`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/08 12:34:56
// Design Name: 
// Module Name: ram_ip
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


module im_ip(
    input clk,
    input reset,
    input [31:0] addr,
    input ren,
    output reg[31:0] rdata
    );
    
    integer i;
    reg [31:0] sram [0:1023];
    
    always @(posedge clk) 
        if(reset) begin
            rdata <= 0;
            for(i = 0; i<1024 ; i = i + 1)
			    sram[i] = 0;
          	$readmemh("code.mem", sram, 0, 1023);
        end
        else if(ren)
            rdata <= sram[addr[11:2]]; 

endmodule