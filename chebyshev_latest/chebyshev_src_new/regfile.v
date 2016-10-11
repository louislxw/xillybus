`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:44:41 08/26/2015 
// Design Name: 
// Module Name:    regfile 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module regfile(clk, en, valid, din, inst, src1, src2
    );

	parameter DATA_WIDTH = 32;
	parameter INS_WIDTH	= 40;
	parameter INST_WIDTH	= 32;
	parameter TAG_WIDTH	= 8;
	
	parameter RAM_WIDTH = 32;
	parameter RAM_ADDR_BITS = 5;

	input clk, en;
	input valid;
	input [DATA_WIDTH-1:0] din;
	input [INST_WIDTH-1:0] inst;
	
	output[RAM_WIDTH-1:0] src1;
	output[RAM_WIDTH-1:0] src2;
	
	reg  [DATA_WIDTH-1:0] din_r = 0;
	reg  [RAM_ADDR_BITS-1:0] count = 0;
	reg  [RAM_ADDR_BITS-1:0] addra = 0;
	wire [RAM_ADDR_BITS-1:0] src1_addr;
	reg  [RAM_ADDR_BITS-1:0] src2_addr = 0;
	reg  valid_r = 0;

	always @(posedge clk) 
	begin
		src2_addr <= inst[5:1];	//{1'b0,inst[6:3]}
		addra <= (valid) ? count : src1_addr;
		din_r <= din;
		valid_r <= valid;
		if (valid)
			count <= count + 1;
		else 
			count <= 0;
   end
	
	memtest_regfile RF (clk, valid_r, din_r, src2_addr, addra, src2, src1);
	
	assign src1_addr = inst[10:6];	//{1'b0,inst[10:7]}

endmodule
