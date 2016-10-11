`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:43:37 08/17/2015 
// Design Name: 
// Module Name:    top_overlay 
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
`include "defines.v"

module top_overlay(bus_clk, user_w_write_32_open, user_w_write_32_data, user_w_write_32_wren, user_w_write_32_full, user_r_read_32_open,
						 user_r_read_32_rden, user_r_read_32_data, user_r_read_32_empty);

parameter DATA_WIDTH = 32;
parameter INS_WIDTH	= 40;
parameter INST_WIDTH	= 32;
parameter TAG_WIDTH	= 8;

input 						bus_clk;							//clk 		
input 						user_w_write_32_open;		//rst for input FIFO (active low) i.e. FIFO will get reset when it will go low.
input [DATA_WIDTH-1:0] 	user_w_write_32_data;		//input data (should come from testbench)
input				 			user_w_write_32_wren;		//write enable for input FIFO (should come from testbench)
output 						user_w_write_32_full;		//FIFO full signal for backpressure

input 						user_r_read_32_open;			//rst for output FIFO (active low) i.e. FIFO will get reset when it will go low.
input 						user_r_read_32_rden;			//read enable for output FIFO (should come from testbench)
output [DATA_WIDTH-1:0]	user_r_read_32_data; 		//output data
output 						user_r_read_32_empty;		//empty signal from output FIFO

wire        				hls_fifo_rd_en_1;
wire [DATA_WIDTH-1:0]	in_r_dout_1;
wire        				hls_fifo_empty_1;

wire       					hls_fifo_rd_en_8;
wire [DATA_WIDTH-1:0] 	in_r_dout_8;
wire        				hls_fifo_empty_8;



/***************** IMEM **********************/
   parameter ROM_WIDTH = 40;
   parameter ROM_ADDR_BITS = 8;

   (* ROM_STYLE="{AUTO | DISTRIBUTED | BLOCK}" *)
   reg [ROM_WIDTH-1:0] myschedule [(2**ROM_ADDR_BITS)-1:0];
   reg [ROM_WIDTH-1:0] instruction = 0;

//   reg [ROM_ADDR_BITS-1:0] instruction_addr;
	reg  [ROM_ADDR_BITS-1:0] instruction_addr = 0;
	reg  [ROM_WIDTH-1:0] instruction_d1 = 0;
	reg  [ROM_WIDTH-1:0] instruction_d2 = 0;
   
   initial
      $readmemb("schedule.mif", myschedule, 0, 255);

   always @(posedge bus_clk)
      if (user_w_write_32_open)
		begin
			instruction_addr <= instruction_addr + 1;
			instruction <= myschedule[instruction_addr];
			instruction_d1 <= instruction;
			instruction_d2 <= instruction_d1;
		end

/********** Signals for input_pipe and mycpu1 **********/
wire [DATA_WIDTH-1:0]	dout_1;
wire 							dout_v_1;

reg 		ready = 0;
reg[5:0] count = 0; 
always @(posedge bus_clk)
begin
	if(!hls_fifo_empty_1)
	begin	
		if ((count >= 1) && (count <= 4))
		begin
			count <= count + 1;
			ready <= 0;
		end
		else if (count == 5)
		begin
			count <= 0;
			ready <= 0;
		end
		else
		begin
			count <= count + 1;
			ready <= 1;
		end
	end
	else
	begin
		count <= 0;	//count
	end		
end

reg din_v_1;
always@(posedge bus_clk)
	if(!user_w_write_32_open)
		din_v_1 <= 0;
	else
		din_v_1 <= ready;
/********** Signals for input_pipe and cpu_1 **********/		

//DRAM-based FIFO
dram_pipe input_pipe (
  .clk(bus_clk), // input clk
  .srst(!user_w_write_32_open), // input srst
  .din(user_w_write_32_data), // input [31 : 0] din
  .wr_en(user_w_write_32_wren), // input wr_en
  .rd_en(ready), // input rd_en
  .dout(in_r_dout_1), // output [31 : 0] dout
  .full(user_w_write_32_full), // output full
  .empty(hls_fifo_empty_1) // output empty
);

//SRL-based FIFO
//srl_pipe input_pipe (
//  .clk(bus_clk), // input clk
//  .srst(!user_w_write_32_open), // input srst
//  .din(user_w_write_32_data), // input [31 : 0] din
//  .wr_en(user_w_write_32_wren), // input wr_en
//  .rd_en(ready), // input rd_en
//  .dout(in_r_dout_1), // output [31 : 0] dout
//  .full(user_w_write_32_full), // output full
//  .empty(hls_fifo_empty_1) // output empty
//);

//BRAM-based FIFO
//bram_pipe input_pipe (
//  .clk(bus_clk), // input clk
//  .srst(!user_w_write_32_open), // input srst
//  .din(user_w_write_32_data), // input [31 : 0] din
//  .wr_en(user_w_write_32_wren), // input wr_en
//  .rd_en(ready), // input rd_en
//  .dout(in_r_dout_1), // output [31 : 0] dout
//  .full(user_w_write_32_full), // output full
//  .empty(hls_fifo_empty_1) // output empty
//);

//Built-in FIFO
//fifo_pipe input_pipe (
//  .clk(bus_clk), // input clk
//  .rst(!user_w_write_32_open), // input rst
//  .din(user_w_write_32_data), // input [31 : 0] din
//  .wr_en(user_w_write_32_wren), // input wr_en
//  .rd_en(ready), // input rd_en
//  .dout(in_r_dout_1), // output [31 : 0] dout
//  .full(user_w_write_32_full), // output full
//  .empty(hls_fifo_empty_1) // output empty
//);

wire [TAG_WIDTH-1:0] tag_1 = 8'b00000000;
wire [TAG_WIDTH-1:0] tag_2 = 8'b00000001;
wire [TAG_WIDTH-1:0] tag_3 = 8'b00000010;
wire [TAG_WIDTH-1:0] tag_4 = 8'b00000011;
wire [TAG_WIDTH-1:0] tag_5 = 8'b00000100;
wire [TAG_WIDTH-1:0] tag_6 = 8'b00000101;
wire [TAG_WIDTH-1:0] tag_7 = 8'b00000110;
wire [TAG_WIDTH-1:0] tag_8 = 8'b00000111;

wire [DATA_WIDTH-1:0] dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, dout_8;
wire dout_v_2, dout_v_3, dout_v_4, dout_v_5, dout_v_6, dout_v_7, dout_v_8;
wire [INS_WIDTH-1:0] ins_out_1, ins_out_2, ins_out_3, ins_out_4, ins_out_5, ins_out_6, ins_out_7, ins_out_8; 


top_cpu cpu_1(bus_clk, !user_w_write_32_open,  in_r_dout_1, din_v_1, dout_1, dout_v_1, instruction_d2, ins_out_1, tag_1);
top_cpu cpu_2(bus_clk, !user_w_write_32_open,	dout_1, dout_v_1, dout_2, dout_v_2, ins_out_1, ins_out_2, tag_2);
top_cpu cpu_3(bus_clk, !user_w_write_32_open, 	dout_2, dout_v_2, dout_3, dout_v_3, ins_out_2, ins_out_3, tag_3);
top_cpu cpu_4(bus_clk, !user_w_write_32_open, 	dout_3, dout_v_3, dout_4, dout_v_4, ins_out_3, ins_out_4, tag_4);
top_cpu cpu_5(bus_clk, !user_w_write_32_open, 	dout_4, dout_v_4, dout_5, dout_v_5, ins_out_4, ins_out_5, tag_5);
top_cpu cpu_6(bus_clk, !user_w_write_32_open, 	dout_5, dout_v_5, dout_6, dout_v_6, ins_out_5, ins_out_6, tag_6);
top_cpu cpu_7(bus_clk, !user_w_write_32_open, 	dout_6, dout_v_6, dout_7, dout_v_7, ins_out_6, ins_out_7, tag_7);
//end_cpu cpu_8(bus_clk, !user_w_write_32_open, 	dout_7, dout_v_7, dout_8, dout_v_8, ins_out_7, ins_out_8, tag_8);


//DRAM-based FIFO
dram_pipe output_pipe (
  .clk(bus_clk), // input clk
  .srst(!user_w_write_32_open), // input srst
  .din(dout_7), // input [31 : 0] din
  .wr_en(dout_v_7), // input wr_en
  .rd_en(user_r_read_32_rden), // input rd_en
  .dout(user_r_read_32_data), // output [31 : 0] dout
  .full(out_r_full_8), // output full
  .empty(user_r_read_32_empty) // output empty
); 

//SRL-based FIFO
//srl_pipe output_pipe (
//  .clk(bus_clk), // input clk
//  .srst(!user_w_write_32_open), // input srst
//  .din(dout_8), // input [31 : 0] din
//  .wr_en(dout_v_8), // input wr_en
//  .rd_en(user_r_read_32_rden), // input rd_en
//  .dout(user_r_read_32_data), // output [31 : 0] dout
//  .full(out_r_full_8), // output full
//  .empty(user_r_read_32_empty) // output empty
//);

//BRAM-based FIFO
//bram_pipe output_pipe (
//  .clk(bus_clk), // input clk
//  .srst(!user_w_write_32_open), // input srst
//  .din(dout_8), // input [31 : 0] din
//  .wr_en(dout_v_8), // input wr_en
//  .rd_en(user_r_read_32_rden), // input rd_en
//  .dout(user_r_read_32_data), // output [31 : 0] dout
//  .full(out_r_full_8), // output full
//  .empty(user_r_read_32_empty) // output empty
//);
 
 //Built-in FIFO
//fifo_pipe output_pipe (
//  .clk(bus_clk), // input clk
//  .rst(!user_w_write_32_open), // input rst
//  .din(dout_8), // input [31 : 0] din
//  .wr_en(dout_v_8), // input wr_en
//  .rd_en(user_r_read_32_rden), // input rd_en
//  .dout(user_r_read_32_data), // output [31 : 0] dout
//  .full(out_r_full_8), // output full
//  .empty(user_r_read_32_empty) // output empty
//);
 
endmodule 