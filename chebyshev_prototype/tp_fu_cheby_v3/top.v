`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:07:29 06/16/2015 
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
	output 		user_r_read_32_empty,		//empty signal from output FIFO
//	input[23:0] inst,
	output [15:0] src1,
	output [15:0] src2,
	output [15:0] dst
    );

wire        hls_fifo_rd_en_1;
wire [31:0] in_r_dout_1;
wire        hls_fifo_empty_1;

wire        hls_fifo_rd_en_2;
wire [31:0] in_r_dout_2;
wire        hls_fifo_empty_2;

wire        hls_fifo_rd_en_3;
wire [31:0] in_r_dout_3;
wire        hls_fifo_empty_3;

wire        hls_fifo_rd_en_4;
wire [31:0] in_r_dout_4;
wire        hls_fifo_empty_4;

wire        hls_fifo_rd_en_5;
wire [31:0] in_r_dout_5;
wire        hls_fifo_empty_5;

wire        hls_fifo_rd_en_6;
wire [31:0] in_r_dout_6;
wire        hls_fifo_empty_6;

wire        hls_fifo_rd_en_7;
wire [31:0] in_r_dout_7;
wire        hls_fifo_empty_7;

wire [31:0] out_r_din;	//?
wire        out_r_full_1;
wire        out_r_full_2;
wire        out_r_full_3;
wire        out_r_full_4;
wire        out_r_full_5;
wire        out_r_full_6;
wire        out_r_full_7;
wire        out_r_write;
	
assign out_r_din = in_r_dout_1;	//?
assign hls_fifo_rd_en_1 = !out_r_full_1;
assign hls_fifo_rd_en_2 = !out_r_full_2;
assign hls_fifo_rd_en_3 = !out_r_full_3;
assign hls_fifo_rd_en_4 = !out_r_full_4;
assign hls_fifo_rd_en_5 = !out_r_full_5;
assign hls_fifo_rd_en_6 = !out_r_full_6;
assign hls_fifo_rd_en_7 = !out_r_full_7;
//assign out_r_write = !hls_fifo_empty_1;

/********** Signals for input_pipe and mycpu1 **********/
wire [15:0] dout_1;
wire dout_v_1;

/*reg din_v_1;
always@(posedge bus_clk)
	if(!user_w_write_32_open)
		din_v_1 <= 0;
	else
		din_v_1 <= !hls_fifo_empty_1;*/
/********** Signals for input_pipe and cpu_1 **********/


reg ready = 0;
reg[5:0] count = 0; 
always @(posedge bus_clk)
begin
	if(user_w_write_32_wren)
	begin	
		if(count == 1)
		begin
			count <= count + 1;
			ready <= 0;
		end
		else if (count == 2)
		begin
			count <= count + 1;
			ready <= 0;
		end
		else if (count == 3)
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
		

fifo_32x512 input_pipe(
      .clk(bus_clk),
      .srst(!user_w_write_32_open),
      .din(user_w_write_32_data),
      .wr_en(user_w_write_32_wren),
      .rd_en(ready),	//hls_fifo_rd_en_1
      .dout(in_r_dout_1),
      .full(user_w_write_32_full),
      .empty(hls_fifo_empty_1)			
);

top_cpu_1 cpu_1(
    .clk(bus_clk), 
    .rst(!user_w_write_32_open), 
//    .inst(inst),
	 .din(in_r_dout_1[15:0]),
	 .valid(din_v_1),
    .src1(src1), 
    .src2(src2), 
    .dst(dst),
	 .dout(dout_1),
	 .dout_v(dout_v_1)
    );

/********** Signals for inter_pipe_1 and cpu_2 **********/
wire [15:0] src1_2;
wire [15:0] src2_2;
wire [15:0] dst_2;

wire [15:0] dout_2;
wire dout_v_2;

reg din_v_2;
always@(posedge bus_clk)
	if(!user_w_write_32_open)
		din_v_2 <= 0;
	else
		din_v_2 <= !hls_fifo_empty_2;
/********** Signals for inter_pipe_1 and cpu_2 **********/
		
fifo_32x512 inter_pipe_1(
      .clk(bus_clk),
      .srst(!user_r_read_32_open),
      .din({16'd0, dout_1}),
      .wr_en(dout_v_1),
      .rd_en(hls_fifo_rd_en_2),	//!inter_pipe_2.full
      .dout(in_r_dout_2),
      .full(out_r_full_1),
      .empty(hls_fifo_empty_2)
);	 

top_cpu_2 cpu_2(
    .clk(bus_clk), 
    .rst(!user_w_write_32_open), 
//    .inst(inst),
	 .din(in_r_dout_2[15:0]),
	 .valid(din_v_2),
    .src1(src1_2), 
    .src2(src2_2), 
    .dst(dst_2),
	 .dout(dout_2),
	 .dout_v(dout_v_2)
    );

/********** Signals for inter_pipe_2 and cpu_3 **********/
wire [15:0] src1_3;
wire [15:0] src2_3;
wire [15:0] dst_3;

wire [15:0] dout_3;
wire dout_v_3;

reg din_v_3;
always@(posedge bus_clk)
	if(!user_w_write_32_open)
		din_v_3 <= 0;
	else
		din_v_3 <= !hls_fifo_empty_3;
/********** Signals for inter_pipe_2 and cpu_3 **********/

fifo_32x512 inter_pipe_2(
      .clk(bus_clk),
      .srst(!user_r_read_32_open),
      .din({16'd0, dout_2}),
      .wr_en(dout_v_2),
      .rd_en(hls_fifo_rd_en_3),
      .dout(in_r_dout_3),
      .full(out_r_full_2),
      .empty(hls_fifo_empty_3)
);

top_cpu_3 cpu_3(
    .clk(bus_clk), 
    .rst(!user_w_write_32_open), 
//    .inst(inst),
	 .din(in_r_dout_3[15:0]),
	 .valid(din_v_3),
    .src1(src1_3), 
    .src2(src2_3), 
    .dst(dst_3),
	 .dout(dout_3),
	 .dout_v(dout_v_3)
    );

/********** Signals for inter_pipe_3 and cpu_4 **********/
wire [15:0] src1_4;
wire [15:0] src2_4;
wire [15:0] dst_4;

wire [15:0] dout_4;
wire dout_v_4;

reg din_v_4;
always@(posedge bus_clk)
	if(!user_w_write_32_open)
		din_v_4 <= 0;
	else
		din_v_4 <= !hls_fifo_empty_4;
/********** Signals for inter_pipe_3 and cpu_4 **********/

fifo_32x512 inter_pipe_3(
      .clk(bus_clk),
      .srst(!user_r_read_32_open),
      .din({16'd0, dout_3}),
      .wr_en(dout_v_3),
      .rd_en(hls_fifo_rd_en_4),
      .dout(in_r_dout_4),
      .full(out_r_full_3),
      .empty(hls_fifo_empty_4)
);

top_cpu_4 cpu_4(
    .clk(bus_clk), 
    .rst(!user_w_write_32_open), 
//    .inst(inst),
	 .din(in_r_dout_4[15:0]),
	 .valid(din_v_4),
    .src1(src1_4), 
    .src2(src2_4), 
    .dst(dst_4),
	 .dout(dout_4),
	 .dout_v(dout_v_4)
    );

/********** Signals for inter_pipe_4 and cpu_5 **********/
wire [15:0] src1_5;
wire [15:0] src2_5;
wire [15:0] dst_5;

wire [15:0] dout_5;
wire dout_v_5;

reg din_v_5;
always@(posedge bus_clk)
	if(!user_w_write_32_open)
		din_v_5 <= 0;
	else
		din_v_5 <= !hls_fifo_empty_5;
/********** Signals for inter_pipe_4 and cpu_5 **********/

fifo_32x512 inter_pipe_4(
      .clk(bus_clk),
      .srst(!user_r_read_32_open),
      .din({16'd0, dout_4}),
      .wr_en(dout_v_4),
      .rd_en(hls_fifo_rd_en_5),
      .dout(in_r_dout_5),
      .full(out_r_full_4),
      .empty(hls_fifo_empty_5)
);

top_cpu_5 cpu_5(
    .clk(bus_clk), 
    .rst(!user_w_write_32_open), 
//    .inst(inst),
	 .din(in_r_dout_5[15:0]),
	 .valid(din_v_5),
    .src1(src1_5), 
    .src2(src2_5), 
    .dst(dst_5),
	 .dout(dout_5),
	 .dout_v(dout_v_5)
    );

/********** Signals for inter_pipe_5 and cpu_6 **********/
wire [15:0] src1_6;
wire [15:0] src2_6;
wire [15:0] dst_6;

wire [15:0] dout_6;
wire dout_v_6;

reg din_v_6;
always@(posedge bus_clk)
	if(!user_w_write_32_open)
		din_v_6 <= 0;
	else
		din_v_6 <= !hls_fifo_empty_6;
/********** Signals for inter_pipe_5 and cpu_6 **********/

fifo_32x512 inter_pipe_5(
      .clk(bus_clk),
      .srst(!user_r_read_32_open),
      .din({16'd0, dout_5}),
      .wr_en(dout_v_5),
      .rd_en(hls_fifo_rd_en_6),
      .dout(in_r_dout_6),
      .full(out_r_full_5),
      .empty(hls_fifo_empty_6)
);

top_cpu_6 cpu_6(
    .clk(bus_clk), 
    .rst(!user_w_write_32_open), 
//    .inst(inst),
	 .din(in_r_dout_6[15:0]),
	 .valid(din_v_6),
    .src1(src1_6), 
    .src2(src2_6), 
    .dst(dst_6),
	 .dout(dout_6),
	 .dout_v(dout_v_6)
    );

/********** Signals for inter_pipe_6 and cpu_7 **********/
wire [15:0] src1_7;
wire [15:0] src2_7;
wire [15:0] dst_7;

wire [15:0] dout_7;
wire dout_v_7;

reg din_v_7;
always@(posedge bus_clk)
	if(!user_w_write_32_open)
		din_v_7 <= 0;
	else
		din_v_7 <= !hls_fifo_empty_7;
/********** Signals for inter_pipe_6 and cpu_7 **********/

fifo_32x512 inter_pipe_6(
      .clk(bus_clk),
      .srst(!user_r_read_32_open),
      .din({16'd0, dout_6}),
      .wr_en(dout_v_6),
      .rd_en(hls_fifo_rd_en_7),
      .dout(in_r_dout_7),
      .full(out_r_full_6),
      .empty(hls_fifo_empty_7)
);

top_cpu_7 cpu_7(
    .clk(bus_clk), 
    .rst(!user_w_write_32_open), 
//    .inst(inst),
	 .din(in_r_dout_7[15:0]),
	 .valid(din_v_7),
    .src1(src1_7), 
    .src2(src2_7), 
    .dst(dst_7),
	 .dout(dout_7),
	 .dout_v(dout_v_7)
    );

fifo_32x512 output_pipe(
      .clk(bus_clk),
      .srst(!user_r_read_32_open),
      .din({16'd0, dout_7}),
      .wr_en(dout_v_7),
      .rd_en(user_r_read_32_rden),
      .dout(user_r_read_32_data),
      .full(out_r_full_7),	//?
      .empty(user_r_read_32_empty)
);

endmodule
