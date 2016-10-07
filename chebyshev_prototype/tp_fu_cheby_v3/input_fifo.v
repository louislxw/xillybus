`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:31 06/16/2015 
// Design Name: 
// Module Name:    input_fifo 
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
module input_fifo(
	clk,
	srst,
	din,
	wr_en,
	rd_en,
	dout,
	full,
	empty
	);

	input clk;
	input srst;
	input [15 : 0] din;
	input wr_en;
	input rd_en;
	output [15 : 0] dout;
	output full;
	output empty;

endmodule
