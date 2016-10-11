`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:51:06 06/20/2014
// Design Name:   top
// Module Name:   C:/Users/abhishek013/Desktop/xillinux-eval-zedboard-1.3/xillinux-eval-zedboard-1.3/verilog/test_top.v
// Project Name:  xillydemo
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
		.user_r_read_32_empty(user_r_read_32_empty)
	);
	
	parameter PERIOD = 20;

   always begin
      bus_clk = 1'b0;
      #(PERIOD/2) bus_clk = 1'b1;
      #(PERIOD/2);
   end  
	
	 // Clock cycle
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
		#100;
		
		// Add stimulus here
		user_w_write_32_open = 1;
		
		//Waiting for system to load the schedule into the FU instruction memories
		#200;
		
		user_w_write_32_data = 1;	//Start sending data to the input fifo in a streaming fashion
		user_w_write_32_wren = 1;
		user_r_read_32_open = 1;
		user_r_read_32_rden = 1;
		#20;		
		user_w_write_32_data = 2;		
		#20;
		user_w_write_32_data = 3;		
		#20;
		user_w_write_32_data = 4;		
		#20;
		user_w_write_32_data = 5;		
		#20;
		user_w_write_32_data = 6;		
		#20;
		user_w_write_32_data = 7;		
		#20;
		user_w_write_32_data = 8;		
		#20;
		user_w_write_32_data = 9;		
		#20;
		user_w_write_32_data = 10;		
		#20;
		user_w_write_32_data = 11;		
		#20;
		user_w_write_32_data = 1;
		#20;
		user_w_write_32_data = 2;		
		#20;
		user_w_write_32_data = 3;		
		#20;
		user_w_write_32_data = 4;		
		#20;
		user_w_write_32_data = 5;		
		#20;
		user_w_write_32_data = 6;		
		#20;
		user_w_write_32_data = 7;		
		#20;
		user_w_write_32_data = 8;		
		#20;
		user_w_write_32_data = 9;		
		#20;
		user_w_write_32_data = 10;		
		#20;
		user_w_write_32_data = 11;
		#20;
		user_w_write_32_data = 1;
		#20;
		user_w_write_32_data = 2;		
		#20;
		user_w_write_32_data = 3;		
		#20;
		user_w_write_32_data = 4;		
		#20;
		user_w_write_32_data = 5;		
		#20;
		user_w_write_32_data = 6;		
		#20;
		user_w_write_32_data = 7;		
		#20;
		user_w_write_32_data = 8;		
		#20;
		user_w_write_32_data = 9;		
		#20;
		user_w_write_32_data = 10;		
		#20;
		user_w_write_32_data = 11;		
		#20;
//		user_w_write_32_wren = 0;
//		$finish();
	end
      
endmodule

