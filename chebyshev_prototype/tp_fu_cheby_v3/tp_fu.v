`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:02:39 06/11/2015 
// Design Name:    Temporally Programmed Functional Unit (TP-FU)
// Module Name:    tp_fu 
// Project Name: 
// Target Devices: Zynq-7000
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: Single FU Design
//
//////////////////////////////////////////////////////////////////////////////////
module tp_fu(clk, rst, inst, src1, src2, dst 
    );

input clk, rst;
input[23:0] inst;	 
	 
/***************** REGFILE **********************/	 
parameter RAM_WIDTH = 16;
parameter RAM_ADDR_BITS = 6;

(* RAM_STYLE="{AUTO | DISTRIBUTED | PIPE_DISTRIBUTED}" *)
reg [RAM_WIDTH-1:0] regfile [(2**RAM_ADDR_BITS)-1:0];
output [RAM_WIDTH-1:0] src1;
output [RAM_WIDTH-1:0] src2;
output [RAM_WIDTH-1:0] dst;
wire[47:0] p_o;
wire [5:0] imm;
assign imm = inst[5:0];
reg immop;
wire immsel;
assign immsel = inst[23];
wire [RAM_ADDR_BITS-1:0] src1_addr, src2_addr, dst_addr;
assign src1_addr = inst[11:6];
assign src2_addr = inst[5:0];
assign dst_addr = inst[17:12];
reg [5:0] dst_addr_d1, dst_addr_d2, dst_addr_d3;
reg [5:0] imm_d1, imm_d2, imm_d3;
reg immsel_d1, immsel_d2, immsel_d3;


always@(posedge clk)
begin
	if(rst)
	begin
		dst_addr_d1 <= 0;
		dst_addr_d2 <= 0;
		dst_addr_d3 <= 0;
		imm_d1 <= 0;
		imm_d2 <= 0;
		imm_d3 <= 0;
		immsel_d1 <= 0;
		immsel_d2 <= 0;
		immsel_d3 <= 0;	
	end
	else
	begin
		dst_addr_d1 <= dst_addr;
		dst_addr_d2 <= dst_addr_d1;
		dst_addr_d3 <= dst_addr_d2;		
		imm_d1 <= imm;
		imm_d2 <= imm_d1;
		imm_d3 <= imm_d2;
		immsel_d1 <= immsel;
		immsel_d2 <= immsel_d1;
		immsel_d3 <= immsel_d2;	
	end
end

assign dst = (immsel_d3) ? {10'd0, imm_d3} : p_o[15:0];
always @(*)
	regfile[dst_addr_d3] <= dst;

assign src1 = regfile[src1_addr]; 
assign src2 = regfile[src2_addr]; 


/***************** INPUT MAP **********************/	 
wire [17:0]	b_i;
wire [29:0]	a_i;
wire [47:0]	c_i;
reg off_a;

assign b_i = (immop) ? {12'd0, imm} : {2'd0, src2};
assign a_i = (off_a) ? 30'd0 : {14'd0, src1};
assign c_i = {32'd0, src1};


/***************** INSTRUCTION DECODE***************/	 
wire[5:0] opcode;
assign opcode = inst[23:18];

reg [3:0]		alumode_i = 0;
reg [4:0]		inmode_i = 0;
reg [6:0]		opmode_i = 0;
reg  				cea2_i = 0;
reg 				ceb2_i = 0;
reg 				usemult_i = 0;


always@ (*)
begin
	case (opcode[2:0])
		/*`ADD*/ 3'b001: begin alumode_i <= 4'b0000; inmode_i <= 5'b00000; opmode_i <= 7'b0110011; cea2_i <= 1; ceb2_i <= 1; usemult_i <= 0; off_a <= 1; immop <= 0; end
		/*`SUB*/ 3'b010: begin alumode_i <= 4'b0011; inmode_i <= 5'b00000; opmode_i <= 7'b0110011; cea2_i <= 1; ceb2_i <= 1; usemult_i <= 0; off_a <= 1; immop <= 0; end
		/*`MUL*/ 3'b011: begin alumode_i <= 4'b0000; inmode_i <= 5'b10001; opmode_i <= 7'b0000101; cea2_i <= 0; ceb2_i <= 0; usemult_i <= 1; off_a <= 0; immop <= 0; end
		/*`ADDI*/ 3'b101: begin alumode_i <= 4'b0000; inmode_i <= 5'b00000; opmode_i <= 7'b0110011; cea2_i <= 1; ceb2_i <= 1; usemult_i <= 0; off_a <= 1; immop <= 1; end
		/*`SUBI*/ 3'b110: begin alumode_i <= 4'b0011; inmode_i <= 5'b00000; opmode_i <= 7'b0110011; cea2_i <= 1; ceb2_i <= 1; usemult_i <= 0; off_a <= 1; immop <= 1; end
		/*`MULI*/ 3'b111: begin alumode_i <= 4'b0000; inmode_i <= 5'b10001; opmode_i <= 7'b0000101; cea2_i <= 0; ceb2_i <= 0; usemult_i <= 1; off_a <= 0; immop <= 1; end
//		/*`MAC*/ 3'b101: alumode_i = 4'b0000; inmode_i = 5'b00000; opmode_i = 7'b0110011; cea2_i = 1; ceb2_i = 1; usemult_i = 0;
//		/*`MADD*/3'b110: alumode_i = 4'b0000; inmode_i = 5'b00000; opmode_i = 7'b0110011; cea2_i = 1; ceb2_i = 1; usemult_i = 0;
//		/*`MSUB*/3'b111: alumode_i = 4'b0011; inmode_i = 5'b00000; opmode_i = 7'b0110011; cea2_i = 1; ceb2_i = 1; usemult_i = 0;
		default: begin alumode_i <= 4'b0000; inmode_i <= 5'b00000; opmode_i <= 7'b0000000; cea2_i <= 0; ceb2_i <= 0; usemult_i <= 0; off_a <= 0; immop <= 0; end
	endcase
end

/***************** EXECUTION UNIT***************/
alu_core uut (
		.clk(clk), 
		.rst(rst), 
		.a_i(a_i), 
		.b_i(b_i), 
		.c_i(c_i), 
		.alumode_i(alumode_i), 
		.inmode_i(inmode_i), 
		.opmode_i(opmode_i), 
		.cea2_i(cea2_i), 
		.ceb2_i(ceb2_i), 
		.usemult_i(usemult_i), 
		.p_o(p_o)
);

endmodule

