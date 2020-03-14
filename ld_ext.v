`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/14 16:47:28
// Design Name: 
// Module Name: ld_ext
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


module ld_ext(
    input [1:0] addr,
    input [31:0] rdata_dm,
    input [2:0] LD_CTR,
    output reg [31:0] rdata
    );

    always@* begin
		case(LD_CTR)
			3'b000: rdata = rdata_dm;
			3'b001: begin	
				case(addr)
					2'b00: rdata = {24'b0, rdata_dm[7:0]}; 
					2'b01: rdata = {24'b0, rdata_dm[15:8]};
					2'b10: rdata = {24'b0, rdata_dm[23:16]};
					2'b11: rdata = {24'b0, rdata_dm[31:24]};
					default: rdata = rdata;
				endcase
			end
			3'b010: begin
				case(addr)
					2'b00: rdata = {{24{rdata_dm[7]}}, rdata_dm[7:0]}; 
					2'b01: rdata = {{24{rdata_dm[15]}}, rdata_dm[15:8]};
					2'b10: rdata = {{24{rdata_dm[23]}}, rdata_dm[23:16]};
					2'b11: rdata = {{24{rdata_dm[31]}}, rdata_dm[31:24]};
					default: rdata = rdata;
				endcase
			end 
			3'b011: begin
				case(addr[1])
					1'b0: rdata = {16'b0, rdata_dm[15:0]};
					1'b1: rdata = {16'b0, rdata_dm[31:16]};
					default: rdata = rdata;
				endcase
			end
			3'b100: begin
				case(addr[1])
					1'b0: rdata = {{16{rdata_dm[15]}}, rdata_dm[15:0]};
					1'b1: rdata = {{16{rdata_dm[31]}}, rdata_dm[31:16]};
					default: rdata = rdata;
				endcase
			end
			default: rdata = rdata;
		endcase
	end

endmodule
