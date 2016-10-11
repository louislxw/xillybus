`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:21:17 06/20/2014 
// Design Name: 
// Module Name:    top 
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
module top(
	input 		bus_clk,							//clk 		
	input 		user_w_write_32_open,		//rst for input FIFO (active low) i.e. FIFO will get reset when it will go low.
	input[31:0] user_w_write_32_data,		//input data (should come from testbench)
	input 		user_w_write_32_wren,		//write enable for input FIFO (should come from testbench)
	output 		user_w_write_32_full,		//FIFO full signal for backpressure
	input 		user_r_read_32_open,			//rst for output FIFO (active low) i.e. FIFO will get reset when it will go low.
//	output 		k_done,							//done signal from kernel
//	output 		k_idle,							//idle signal from kernel
//	output 		k_ready,							//ready signal from kernel
	input 		user_r_read_32_rden,			//read enable for output FIFO (should come from testbench)
	output[31:0]user_r_read_32_data,			//output data
	output 		user_r_read_32_empty			//empty signal from output FIFO
    );

parameter DATA_WIDTH = 32;
parameter INS_WIDTH	= 40;
parameter INST_WIDTH	= 32;
parameter TAG_WIDTH	= 8;

wire        				hls_fifo_rd_en_1;
wire [DATA_WIDTH-1:0]	in_r_dout_1;
wire        				hls_fifo_empty_1;

wire       					hls_fifo_rd_en_8;
wire [DATA_WIDTH-1:0] 	in_r_dout_8;
wire        				hls_fifo_empty_8;

wire [TAG_WIDTH-1:0] tag_1 = 8'b00000000;
wire [TAG_WIDTH-1:0] tag_2 = 8'b00000001;
wire [TAG_WIDTH-1:0] tag_3 = 8'b00000010;
wire [TAG_WIDTH-1:0] tag_4 = 8'b00000011;
wire [TAG_WIDTH-1:0] tag_5 = 8'b00000100;
wire [TAG_WIDTH-1:0] tag_6 = 8'b00000101;
wire [TAG_WIDTH-1:0] tag_7 = 8'b00000110;
wire [TAG_WIDTH-1:0] tag_8 = 8'b00000111;

wire [DATA_WIDTH-1:0] dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, dout_8;
wire dout_v_1, dout_v_2, dout_v_3, dout_v_4, dout_v_5, dout_v_6, dout_v_7, dout_v_8;
wire [INS_WIDTH-1:0] ins_out_1, ins_out_2, ins_out_3, ins_out_4, ins_out_5, ins_out_6, ins_out_7, ins_out_8; 


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

	reg[31:0] counter = 0;
   always @(posedge bus_clk)
      if (user_w_write_32_open)
		begin
			instruction_addr <= instruction_addr + 1;
			instruction <= myschedule[instruction_addr];
			instruction_d1 <= instruction;
			instruction_d2 <= instruction_d1;
			counter <= counter + 1;	//ADD a counter
		end
		else
			counter <= 0;

//	always @(posedge bus_clk)
//		if (counter >= 30)
//			user_w_write_32_wren <= 1;
//		else 
//			user_w_write_32_wren <= 0;

	wire input_fifo_wren;
	assign input_fifo_wren = (counter>=20) ? user_w_write_32_wren : 0;

//-------------------------------------------kernel----------------------------------------//
wire        out_r_full_7;

/********** Signals for input_pipe and mycpu1 **********/
reg ready = 0;
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


fifo_32x512 input_pipe(
      .clk(bus_clk),
      .srst(!user_w_write_32_open),
      .din(user_w_write_32_data),
      .wr_en(input_fifo_wren),	//user_w_write_32_wren
      .rd_en(ready),	//hls_fifo_rd_en_1
      .dout(in_r_dout_1),
      .full(user_w_write_32_full),
      .empty(hls_fifo_empty_1)			
);


top_cpu cpu_1(bus_clk, !user_w_write_32_open,  in_r_dout_1, din_v_1, dout_1, dout_v_1, instruction_d2, ins_out_1, tag_1);
top_cpu cpu_2(bus_clk, !user_w_write_32_open,	dout_1, dout_v_1, dout_2, dout_v_2, ins_out_1, ins_out_2, tag_2);
top_cpu cpu_3(bus_clk, !user_w_write_32_open, 	dout_2, dout_v_2, dout_3, dout_v_3, ins_out_2, ins_out_3, tag_3);
top_cpu cpu_4(bus_clk, !user_w_write_32_open, 	dout_3, dout_v_3, dout_4, dout_v_4, ins_out_3, ins_out_4, tag_4);
top_cpu cpu_5(bus_clk, !user_w_write_32_open, 	dout_4, dout_v_4, dout_5, dout_v_5, ins_out_4, ins_out_5, tag_5);
top_cpu cpu_6(bus_clk, !user_w_write_32_open, 	dout_5, dout_v_5, dout_6, dout_v_6, ins_out_5, ins_out_6, tag_6);
top_cpu cpu_7(bus_clk, !user_w_write_32_open, 	dout_6, dout_v_6, dout_7, dout_v_7, ins_out_6, ins_out_7, tag_7);


fifo_32x512 output_pipe(
      .clk(bus_clk),
      .srst(!user_r_read_32_open),
      .din(dout_7),
      .wr_en(dout_v_7),
      .rd_en(user_r_read_32_rden),
      .dout(user_r_read_32_data),
      .full(out_r_full_7),	//?
      .empty(user_r_read_32_empty)
);


endmodule
