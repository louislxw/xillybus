`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:20:57 06/17/2015
// Design Name:   top
// Module Name:   F:/dpoverlay/tp_fu_v2/test_top.v
// Project Name:  tp_fu_v2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_top;

	// Inputs
	reg bus_clk;
	reg user_w_write_32_open;
	reg [31:0] user_w_write_32_data;
	reg user_w_write_32_wren;
	reg user_r_read_32_open;
	reg user_r_read_32_rden;
	reg [23:0] inst;

	// Outputs
	wire [15:0] src1;
	wire [15:0] src2;
	wire [15:0] dst;

	// Outputs
	wire user_w_write_32_full;
//	wire k_done;
//	wire k_idle;
//	wire k_ready;
	wire [31:0] user_r_read_32_data;
	wire user_r_read_32_empty;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.bus_clk(bus_clk), 
		.user_w_write_32_open(user_w_write_32_open), 
		.user_w_write_32_data(user_w_write_32_data), 
		.user_w_write_32_wren(user_w_write_32_wren), 
		.user_w_write_32_full(user_w_write_32_full), 
		.user_r_read_32_open(user_r_read_32_open), 
//		.k_done(k_done), 
//		.k_idle(k_idle), 
//		.k_ready(k_ready), 
		.user_r_read_32_rden(user_r_read_32_rden), 
		.user_r_read_32_data(user_r_read_32_data), 
		.user_r_read_32_empty(user_r_read_32_empty),
//		.inst(inst),
		.src1(src1),
		.src2(src2),
		.dst(dst)		
	);
	parameter PERIOD = 20;

   always begin
      bus_clk = 1'b0;
      #(PERIOD/2) bus_clk = 1'b1;
      #(PERIOD/2);
   end  
	
	integer cycle;
   initial cycle = 0;
   always @(posedge bus_clk)
    cycle = cycle + 1;

	initial begin
		// Initialize Inputs		
		user_w_write_32_open = 0;
		user_w_write_32_data = 0;
		user_w_write_32_wren = 0;
		user_r_read_32_open = 0;
		user_r_read_32_rden = 0;

		// Wait 100 ns for global reset to finish
		#200;       
		// Add stimulus here
		user_w_write_32_open = 1;
		user_w_write_32_data = 1;	//previous: 1
		user_w_write_32_wren = 1;
		user_r_read_32_open = 1;
		user_r_read_32_rden = 1;
//		#20; user_w_write_32_wren = 0;
		#20;user_w_write_32_data = 2;
		#20;user_w_write_32_data = 3;
		#20;user_w_write_32_data = 4;
		#20;user_w_write_32_data = 5;
//		#20;user_w_write_32_wren = 0;
//		#600; user_w_write_32_wren = 1; user_w_write_32_data = 3;		
		#20;
		#20;
		#20;
//		#20;user_w_write_32_data = 4;
		#20;
//		user_w_write_32_wren = 0;
//		user_w_write_32_data = 4;		
		#20;
//		user_w_write_32_data = 5;
//		#20;
//		user_w_write_32_data = 6;		
//		#20;
//		user_w_write_32_data = 7;
//		#20;
//		user_w_write_32_data = 8;
////		user_w_write_32_wren = 0;		
//		#20;
//		user_w_write_32_data = 9;
//		#20;
//		user_w_write_32_data = 10;	
////		user_w_write_32_wren = 0;		
//		#20;
//		user_w_write_32_data = 11;		
		#20;
		inst 		= 24'b000111_010000_000000_000011; //Mul R0, 3
		#20;
		inst 		= 24'b000111_010000_000001_000011; //Mul R1, 3
		#20;
		inst 		= 24'b000111_010000_000010_000011; //Mul R2, 3
		#20;
		inst 		= 24'b000111_010000_000011_000011; //Mul R3, 3
		#20;
		inst 		= 24'b000111_010000_000100_000011; //Mul R4, 3
		#20;
		inst 		= 24'b000111_010000_000101_000011; //Mul R5, 3
		#20;
		inst 		= 24'b000111_010000_000110_000011; //Mul R6, 3
		#20;
		inst 		= 24'b000111_010000_000111_000011; //Mul R7, 3
		#20;
		inst 		= 24'b000011_001000_000100_000011; //Mul R8, R4, R3
		#20;
		inst 		= 24'b000111_001001_000110_001011; //Mul R9, R6, 11
		#20;
		inst 		= 24'b000001_001010_000111_000010; //Add R10, R7, R2
		#20;
		inst 		= 24'b000111_001011_000101_001000; //Mul R11, R5, 8
		#20;
		inst 		= 24'b000111_001100_001000_011001; //Mul R12, R8, 25
		#20;
		inst 		= 24'b000010_001101_001001_001010; //Sub R13, R9, R10
		#20;
//		inst 		= 24'b000000_000000_000000_000000; //NOP
		#20;
		inst 		= 24'b000010_001110_001100_001011; //Sub R14, R12, R11
		#20;
		inst 		= 24'b000111_001111_001101_001111; //Mul R15, R13, 15
		#20;
//		inst 		= 24'b000000_000000_000000_000000; //NOP
		#20;
//		inst 		= 24'b000000_000000_000000_000000; //NOP
		#20;
		inst 		= 24'b000001_010000_001111_001110; //Add R16, R15, R14
	end

endmodule
