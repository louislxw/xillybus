`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:52:00 10/21/2015 
// Design Name: 
// Module Name:    memtest 
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
module memtest_regfile(clk, we, din, addr_1, addr_2, dout_1, dout_2
    );
input clk, we;	 
input[31:0] din;
input[4:0] addr_1;
input[4:0] addr_2;
output reg[31:0] dout_1;
output reg[31:0] dout_2;


//wire A0, A1, A2, A3, A4;
wire D31, D30, D29, D28, D27, D26, D25, D24, D23, D22, D21, D20, D19, D18, D17, D16, D15, D14, D13, D12, D11, D10, D9, D8, D7, D6, D5, D4, D3, D2, D1, D0;
wire O1_31, O1_30, O1_29, O1_28, O1_27, O1_26, O1_25, O1_24, O1_23, O1_22, O1_21, O1_20, O1_19, O1_18, O1_17, O1_16, O1_15, O1_14, O1_13, O1_12, O1_11, O1_10, O1_9, O1_8, O1_7, O1_6, O1_5, O1_4, O1_3, O1_2, O1_1, O1_0;
wire O2_31, O2_30, O2_29, O2_28, O2_27, O2_26, O2_25, O2_24, O2_23, O2_22, O2_21, O2_20, O2_19, O2_18, O2_17, O2_16, O2_15, O2_14, O2_13, O2_12, O2_11, O2_10, O2_9, O2_8, O2_7, O2_6, O2_5, O2_4, O2_3, O2_2, O2_1, O2_0;


always@(posedge clk)
begin
	dout_1  <= {O1_31, O1_30, O1_29, O1_28, O1_27, O1_26, O1_25, O1_24, O1_23, O1_22, O1_21, O1_20, O1_19, O1_18, O1_17, O1_16, O1_15, O1_14, O1_13, O1_12, O1_11, O1_10, O1_9, O1_8, O1_7, O1_6, O1_5, O1_4, O1_3, O1_2, O1_1, O1_0}; 	
	dout_2  <= {O2_31, O2_30, O2_29, O2_28, O2_27, O2_26, O2_25, O2_24, O2_23, O2_22, O2_21, O2_20, O2_19, O2_18, O2_17, O2_16, O2_15, O2_14, O2_13, O2_12, O2_11, O2_10, O2_9, O2_8, O2_7, O2_6, O2_5, O2_4, O2_3, O2_2, O2_1, O2_0}; 	
end	



//assign {A4, A3, A2, A1, A0} = addr;
assign {D31, D30, D29, D28, D27, D26, D25, D24, D23, D22, D21, D20, D19, D18, D17, D16, D15, D14, D13, D12, D11, D10, D9, D8, D7, D6, D5, D4, D3, D2, D1, D0} = din;
//assign dout = {O3, O2, O1, O0}; 

  RAM32M #(
      .INIT_A(64'h0000000000000000), // Initial contents of A Port
      .INIT_B(64'h0000000000000000), // Initial contents of B Port
      .INIT_C(64'h0000000000000000), // Initial contents of C Port
      .INIT_D(64'h0000000000000000)  // Initial contents of D Port
   ) RAM32M_inst_0 (
      .DOA({O1_1, O1_0}),     // Read port A 2-bit output
      .DOB({O1_3, O1_2}),     // Read port B 2-bit output
      .DOC({O2_1, O2_0}),     // Read port C 2-bit output
      .DOD({O2_3, O2_2}),     // Readw/rite port D 2-bit output
      .ADDRA(addr_1), // Read port A 5-bit address input
      .ADDRB(addr_1), // Read port B 5-bit address input
      .ADDRC(addr_2), // Read port C 5-bit address input
      .ADDRD(addr_2), // Readw/rite port D 5-bit address input
      .DIA({D1, D0}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRA
      .DIB({D3, D2}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRB
      .DIC({D1, D0}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRC
      .DID({D3, D2}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRD
      .WCLK(clk),   // Write clock input
      .WE(we)        // Write enable input
   );	
	 
  RAM32M #(
      .INIT_A(64'h0000000000000000), // Initial contents of A Port
      .INIT_B(64'h0000000000000000), // Initial contents of B Port
      .INIT_C(64'h0000000000000000), // Initial contents of C Port
      .INIT_D(64'h0000000000000000)  // Initial contents of D Port
   ) RAM32M_inst_1 (
      .DOA({O1_5, O1_4}),     // Read port A 2-bit output
      .DOB({O1_7, O1_6}),     // Read port B 2-bit output
      .DOC({O2_5, O2_4}),     // Read port C 2-bit output
      .DOD({O2_7, O2_6}),     // Readw/rite port D 2-bit output
      .ADDRA(addr_1), // Read port A 5-bit address input
      .ADDRB(addr_1), // Read port B 5-bit address input
      .ADDRC(addr_2), // Read port C 5-bit address input
      .ADDRD(addr_2), // Readw/rite port D 5-bit address input
      .DIA({D5, D4}),     // RAM 2-bit data write input addressed by ADDRD, 
                   //   read addressed by ADDRA
      .DIB({D7, D6}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRB
      .DIC({D5, D4}),     // RAM 2-bit data write input addressed by ADDRD, 
                   //   read addressed by ADDRC
      .DID({D7, D6}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRD
      .WCLK(clk),   // Write clock input
      .WE(we)        // Write enable input
   );	

  RAM32M #(
      .INIT_A(64'h0000000000000000), // Initial contents of A Port
      .INIT_B(64'h0000000000000000), // Initial contents of B Port
      .INIT_C(64'h0000000000000000), // Initial contents of C Port
      .INIT_D(64'h0000000000000000)  // Initial contents of D Port
   ) RAM32M_inst_2 (
      .DOA({O1_9, O1_8}),     // Read port A 2-bit output
      .DOB({O1_11, O1_10}),     // Read port B 2-bit output
      .DOC({O2_9, O2_8}),     // Read port C 2-bit output
      .DOD({O2_11, O2_10}),     // Readw/rite port D 2-bit output
      .ADDRA(addr_1), // Read port A 5-bit address input
      .ADDRB(addr_1), // Read port B 5-bit address input
      .ADDRC(addr_2), // Read port C 5-bit address input
      .ADDRD(addr_2), // Readw/rite port D 5-bit address input
      .DIA({D9,  D8 }),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRA
      .DIB({D11, D10}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRB
      .DIC({D9,  D8 }),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRC
      .DID({D11, D10}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRD
      .WCLK(clk),   // Write clock input
      .WE(we)        // Write enable input
   );	

  RAM32M #(
      .INIT_A(64'h0000000000000000), // Initial contents of A Port
      .INIT_B(64'h0000000000000000), // Initial contents of B Port
      .INIT_C(64'h0000000000000000), // Initial contents of C Port
      .INIT_D(64'h0000000000000000)  // Initial contents of D Port
   ) RAM32M_inst_3 (
      .DOA({O1_13, O1_12}),     // Read port A 2-bit output
      .DOB({O1_15, O1_14}),     // Read port B 2-bit output
      .DOC({O2_13, O2_12}),     // Read port C 2-bit output
      .DOD({O2_15, O2_14}),     // Readw/rite port D 2-bit output
      .ADDRA(addr_1), // Read port A 5-bit address input
      .ADDRB(addr_1), // Read port B 5-bit address input
      .ADDRC(addr_2), // Read port C 5-bit address input
      .ADDRD(addr_2), // Readw/rite port D 5-bit address input
      .DIA({D13, D12}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRA
      .DIB({D15, D14}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRB
      .DIC({D13, D12}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRC
      .DID({D15, D14}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRD
      .WCLK(clk),   // Write clock input
      .WE(we)        // Write enable input
   );	
	 
  RAM32M #(
      .INIT_A(64'h0000000000000000), // Initial contents of A Port
      .INIT_B(64'h0000000000000000), // Initial contents of B Port
      .INIT_C(64'h0000000000000000), // Initial contents of C Port
      .INIT_D(64'h0000000000000000)  // Initial contents of D Port
   ) RAM32M_inst_4 (
      .DOA({O1_17, O1_16}),     // Read port A 2-bit output
      .DOB({O1_19, O1_18}),     // Read port B 2-bit output
      .DOC({O2_17, O2_16}),     // Read port C 2-bit output
      .DOD({O2_19, O2_18}),     // Readw/rite port D 2-bit output
      .ADDRA(addr_1), // Read port A 5-bit address input
      .ADDRB(addr_1), // Read port B 5-bit address input
      .ADDRC(addr_2), // Read port C 5-bit address input
      .ADDRD(addr_2), // Readw/rite port D 5-bit address input
      .DIA({D17, D16}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRA
      .DIB({D19, D18}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRB
      .DIC({D17, D16}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRC
      .DID({D19, D18}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRD
      .WCLK(clk),   // Write clock input
      .WE(we)        // Write enable input
   );	

  RAM32M #(
      .INIT_A(64'h0000000000000000), // Initial contents of A Port
      .INIT_B(64'h0000000000000000), // Initial contents of B Port
      .INIT_C(64'h0000000000000000), // Initial contents of C Port
      .INIT_D(64'h0000000000000000)  // Initial contents of D Port
   ) RAM32M_inst_5 (
      .DOA({O1_21, O1_20}),     // Read port A 2-bit output
      .DOB({O1_23, O1_22}),     // Read port B 2-bit output
      .DOC({O2_21, O2_20}),     // Read port C 2-bit output
      .DOD({O2_23, O2_22}),     // Readw/rite port D 2-bit output
      .ADDRA(addr_1), // Read port A 5-bit address input
      .ADDRB(addr_1), // Read port B 5-bit address input
      .ADDRC(addr_2), // Read port C 5-bit address input
      .ADDRD(addr_2), // Readw/rite port D 5-bit address input
      .DIA({D21, D20}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRA
      .DIB({D23, D22}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRB
      .DIC({D21, D20}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRC
      .DID({D23, D22}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRD
      .WCLK(clk),   // Write clock input
      .WE(we)        // Write enable input
   );	

  RAM32M #(
      .INIT_A(64'h0000000000000000), // Initial contents of A Port
      .INIT_B(64'h0000000000000000), // Initial contents of B Port
      .INIT_C(64'h0000000000000000), // Initial contents of C Port
      .INIT_D(64'h0000000000000000)  // Initial contents of D Port
   ) RAM32M_inst_6 (
      .DOA({O1_25, O1_24}),     // Read port A 2-bit output
      .DOB({O1_27, O1_26}),     // Read port B 2-bit output
      .DOC({O2_25, O2_24}),     // Read port C 2-bit output
      .DOD({O2_27, O2_26}),     // Readw/rite port D 2-bit output
      .ADDRA(addr_1), // Read port A 5-bit address input
      .ADDRB(addr_1), // Read port B 5-bit address input
      .ADDRC(addr_2), // Read port C 5-bit address input
      .ADDRD(addr_2), // Readw/rite port D 5-bit address input
      .DIA({D25, D24}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRA
      .DIB({D27, D26}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRB
      .DIC({D25, D24}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRC
      .DID({D27, D26}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRD
      .WCLK(clk),   // Write clock input
      .WE(we)        // Write enable input
   );	

  RAM32M #(
      .INIT_A(64'h0000000000000000), // Initial contents of A Port
      .INIT_B(64'h0000000000000000), // Initial contents of B Port
      .INIT_C(64'h0000000000000000), // Initial contents of C Port
      .INIT_D(64'h0000000000000000)  // Initial contents of D Port
   ) RAM32M_inst_7 (
      .DOA({O1_29, O1_28}),     // Read port A 2-bit output
      .DOB({O1_31, O1_30}),     // Read port B 2-bit output
      .DOC({O2_29, O2_28}),     // Read port C 2-bit output
      .DOD({O2_31, O2_30}),     // Readw/rite port D 2-bit output
      .ADDRA(addr_1), // Read port A 5-bit address input
      .ADDRB(addr_1), // Read port B 5-bit address input
      .ADDRC(addr_2), // Read port C 5-bit address input
      .ADDRD(addr_2), // Readw/rite port D 5-bit address input
      .DIA({D29, D28}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRA
      .DIB({D31, D30}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRB
      .DIC({D29, D28}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRC
      .DID({D31, D30}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRD
      .WCLK(clk),   // Write clock input
      .WE(we)        // Write enable input
   );	

/*   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_0 (
      .O0(O0),     // RAM data[0] output
      .O1(O1),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D0),     // RAM data[0] input
      .D1(D1),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );	 
	
   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_1 (
      .O0(O2),     // RAM data[0] output
      .O1(O3),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D2),     // RAM data[0] input
      .D1(D3),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );		

   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_2 (
      .O0(O4),     // RAM data[0] output
      .O1(O5),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D4),     // RAM data[0] input
      .D1(D5),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );		

   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_3 (
      .O0(O6),     // RAM data[0] output
      .O1(O7),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D6),     // RAM data[0] input
      .D1(D7),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );		

   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_4 (
      .O0(O8),     // RAM data[0] output
      .O1(O9),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D8),     // RAM data[0] input
      .D1(D9),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );		

   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_5 (
      .O0(O10),     // RAM data[0] output
      .O1(O11),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D10),     // RAM data[0] input
      .D1(D11),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );		

   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_6 (
      .O0(O12),     // RAM data[0] output
      .O1(O13),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D12),     // RAM data[0] input
      .D1(D13),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );		

   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_7 (
      .O0(O14),     // RAM data[0] output
      .O1(O15),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D14),     // RAM data[0] input
      .D1(D15),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );		

   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_8 (
      .O0(O16),     // RAM data[0] output
      .O1(O17),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D16),     // RAM data[0] input
      .D1(D17),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );		

   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_9 (
      .O0(O18),     // RAM data[0] output
      .O1(O19),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D18),     // RAM data[0] input
      .D1(D19),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );		

   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_10 (
      .O0(O20),     // RAM data[0] output
      .O1(O21),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D20),     // RAM data[0] input
      .D1(D21),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );		

   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_11 (
      .O0(O22),     // RAM data[0] output
      .O1(O23),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D22),     // RAM data[0] input
      .D1(D23),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );		

   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_12 (
      .O0(O24),     // RAM data[0] output
      .O1(O25),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D24),     // RAM data[0] input
      .D1(D25),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );		

   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_13 (
      .O0(O26),     // RAM data[0] output
      .O1(O27),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D26),     // RAM data[0] input
      .D1(D27),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );		

   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_14 (
      .O0(O28),     // RAM data[0] output
      .O1(O29),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D28),     // RAM data[0] input
      .D1(D29),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );		

   RAM32X2S #(
      .INIT_00(32'h00000000), // INIT for bit 0 of RAM
      .INIT_01(32'h00000000)  // INIT for bit 1 of RAM
   ) RAM32X2S_inst_15 (
      .O0(O30),     // RAM data[0] output
      .O1(O31),     // RAM data[1] output
      .A0(A0),     // RAM address[0] input
      .A1(A1),     // RAM address[1] input
      .A2(A2),     // RAM address[2] input
      .A3(A3),     // RAM address[3] input
      .A4(A4),     // RAM address[4] input
      .D0(D30),     // RAM data[0] input
      .D1(D31),     // RAM data[1] input
      .WCLK(clk), // Write clock input
      .WE(we)      // Write enable input
   );	*/	

endmodule
