`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:27:50 04/24/2015 
// Design Name: 	 Temporally Programmed Functional Unit (TP-FU)
// Module Name:    top_cpu 
// Project Name: 
// Target Devices: Zynq-7000
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:	Single FU Design
//
//////////////////////////////////////////////////////////////////////////////////
`include "defines.v"

module top_cpu(clk, rst, din, valid, dout, dout_v, ins, ins_out, tag 
    );
	 
parameter DATA_WIDTH = 32;
parameter INS_WIDTH	= 40;
parameter INST_WIDTH	= 32;
parameter TAG_WIDTH	= 8;

input	 clk, rst;
input  [DATA_WIDTH-1:0]	din;
input valid;
output reg [DATA_WIDTH-1:0] dout;
output reg dout_v;
wire [DATA_WIDTH-1:0] src1;
wire [DATA_WIDTH-1:0] src2;

input [INS_WIDTH-1:0] ins;
output reg [INS_WIDTH-1:0] ins_out;
input [TAG_WIDTH-1:0] tag;

wire[47:0] p_o;
wire control_d7;

always@(posedge clk)
begin
	dout 	<= p_o[DATA_WIDTH-1:0];
	dout_v  <= control_d7;
end	

//assign dout 	= p_o[DATA_WIDTH-1:0];
//assign dout_v	= control_d7;


wire [INST_WIDTH-1:0] inst;
inst_mem	my_inst_mem(.clk(clk), .rst(rst), .valid(valid), .tag(tag), .ins(ins), .inst(inst), .control_d7(control_d7));
//imem_bram	my_inst_mem(.clk(clk), .rst(rst), .valid(valid), .tag(tag), .ins(ins), .inst(inst), .control_d7(control_d7));
						
reg [INST_WIDTH-1:0] inst_d1, inst_d2;
always@(posedge clk)
begin
	ins_out <= ins;
	inst_d1 <= inst;
	inst_d2 <= inst_d1;
end

wire en = 1;
regfile	my_regfile(.clk(clk),.en(en),	.valid(valid), .din(din), .inst(inst), .src1(src1), .src2(src2));
//regfile_bram	my_regfile(.clk(clk),.en(en),	.valid(valid), .din(din), .inst(inst), .src1(src1), .src2(src2));

wire [5:0] imm;
assign imm = inst_d2[5:0];

/***************** INPUT MAP **********************/	 
reg [17:0]	b_i;
reg [29:0]	a_i;
reg [47:0]	c_i;

wire split;	//add by Louis
wire immop;

assign split = inst_d2[12];
assign immop = inst_d2[11];

wire [1:0]	select;
assign select = {split, immop};
always @ (*)
case (select)
		2'b00: begin
					a_i <= {14'd0, src1[15:0]};
					b_i <= {2'd0, src2[15:0]};
					c_i <= {16'd0, src1};
				 end
		2'b01: begin
					a_i <= {14'd0, src1[15:0]};
					b_i <= {12'd0, imm};
					c_i <= {16'd0, src1};
				 end
		2'b10: begin
					a_i <= {16'd0, src2[31:18]};
					b_i <= src2[17:0];
					c_i <= {16'd0, src1};
				 end
		2'b11: begin
					a_i <= 30'd0;
					b_i <= {12'd0, imm};
					c_i <= {16'd0, src1};
				 end
endcase

/***************** EXECUTION UNIT***************/
alu_core uut (
		.clk(clk), 
		.rst(rst), 
		.a_i(a_i), 
		.b_i(b_i), 
		.c_i(c_i), 
		.alumode_i(inst_d2[31:28]), 
		.inmode_i(inst_d2[27:23]), 
		.opmode_i(inst_d2[22:16]), 
		.cea2_i(inst_d2[15]), 
		.ceb2_i(inst_d2[14]), 
		.usemult_i(inst_d2[13]), 
		.p_o(p_o)
);
endmodule