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
module top_cpu_7(clk, rst, din, valid, src1, src2, dst, dout, dout_v 
    );

input clk, rst;
//input[23:0] inst;
input[15:0] din;
input valid;
output [15:0] dout;
output dout_v;

wire[47:0] p_o;

reg valid_d1;
reg valid_d2;
reg valid_d3;
reg valid_d4;
reg valid_d5;

reg control_d1;
reg control_d2;
reg control_d3;
reg control_d4;
reg control_d5;

reg[1:0] inscount = 1;

reg control;
always @(*)
case (inscount)
         2'b00: control <= 0;
         2'b01: control <= (~valid) & (valid_d1);
         2'b10: control <= ((~valid) & (valid_d1)) | ((~valid_d1) & (valid_d2));
         2'b11: control <= ((~valid) & (valid_d1)) | ((~valid_d1) & (valid_d2)) | ((~valid_d2) & (valid_d3));
endcase


assign dout = p_o[15:0];//(valid) ? din : p_o[15:0];
assign dout_v = control_d4;// | valid_d4;

//assign dout = (valid) ? din : p_o[15:0];
//assign dout_v = valid | valid_d4;
/***************** IMEM **********************/	 


   parameter ROM_WIDTH = 24;

   reg [ROM_WIDTH-1:0] inst;
//   reg [3:0] pc = 4'b1111;
	reg [1:0] pc = 2'b00;
	
  
   always @(posedge clk)
      if (control)
		begin
			pc <= pc + 1;
         case (pc)
				2'b00: inst <= 24'b000011_010000_000001_000000; //Mul R1, R0
            2'b01: inst <= 24'b000111_010000_000000_000001; //Mul R0, 1 (BYPASS R0)
            2'b10: inst <= 24'b000110_010000_000010_010100; //Mul R2, 20
            2'b11: inst <= 24'b000110_010000_000011_010100; //Mul R3, 20
/*            4'b0000: inst <= 24'b000110_010000_000000_010100; //Sub R0, 20
            4'b0001: inst <= 24'b000111_010000_000001_000011; //Mul R1, 3
            4'b0010: inst <= 24'b000111_010000_000010_000011; //Mul R2, 3
            4'b0011: inst <= 24'b000111_010000_000011_000011; //Mul R3, 3
            4'b0100: inst <= 24'b000111_010000_000100_000011; //Mul R4, 3
            4'b0101: inst <= 24'b000111_010000_000101_000011; //Mul R5, 3
            4'b0110: inst <= 24'b000111_010000_000110_000011; //Mul R6, 3
            4'b0111: inst <= 24'b000111_010000_000111_000011; //Mul R7, 3
            4'b1000: inst <= 24'b000111_010000_001000_000011; //Mul R8, 3
            4'b1001: inst <= 24'b000111_010000_001001_000011; //Mul R9, 3
            4'b1010: inst <= 24'b000111_010000_001010_000011; //Mul R10, 3
            4'b1011: inst <= 24'b000111_010000_001011_000011; //Mul R11, 3
            4'b1100: inst <= 24'b000111_010000_001100_000011; //Mul R12, 3
            4'b1101: inst <= 24'b000111_010000_001101_000011; //Mul R13, 3
            4'b1110: inst <= 24'b000111_010000_001110_000011; //Mul R14, 3
            4'b1111: inst <= 24'b000111_010000_001111_000011; //Mul R15, 3
				*/
            default: inst <= 0;
         endcase
		end
		else
			pc <= 0;
	 
	 
/***************** REGFILE **********************/	 
parameter RAM_WIDTH = 16;
parameter RAM_ADDR_BITS = 6;

(* RAM_STYLE="{AUTO | DISTRIBUTED | PIPE_DISTRIBUTED}" *)
reg [RAM_WIDTH-1:0] regfile [(2**RAM_ADDR_BITS)-1:0];
output [RAM_WIDTH-1:0] src1;
output [RAM_WIDTH-1:0] src2;
output [RAM_WIDTH-1:0] dst;
//wire[47:0] p_o;
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
		valid_d1 <= 0;
		valid_d2 <= 0;
		valid_d3 <= 0;		
		valid_d4 <= 0;
		valid_d5 <= 0;
		control_d1 <= 0;
		control_d2 <= 0;
		control_d3 <= 0;		
		control_d4 <= 0;		
		control_d5 <= 0;
		
		//dout_v <= 0;
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
		valid_d1 <= valid;
		valid_d2 <= valid_d1;
		valid_d3 <= valid_d2;
		valid_d4 <= valid_d3;
		valid_d5 <= valid_d4;
		control_d1 <= control;
		control_d2 <= control_d1;
		control_d3 <= control_d2;		
		control_d4 <= control_d3;		
		control_d5 <= control_d4;
		
		//dout_v <= valid | valid_d3;		
	end
end

assign dst = (immsel_d3) ? {10'd0, imm_d3} : p_o[15:0];
reg[5:0] count = 0; 
always @(posedge clk)
begin
	if(valid)
	begin	
		regfile[count] <= din;
		count <= count + 1;
	end
	else
	begin
		regfile[count] <= regfile[count];
		count <= 0;	//count
	end		
end
	
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
