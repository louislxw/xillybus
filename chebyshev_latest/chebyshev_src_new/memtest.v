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
module memtest(clk, we, din, addr, dout
    );
input clk, we;	 
input[31:0] din;
input[4:0] addr; 
output reg[31:0] dout=0;


wire A0, A1, A2, A3, A4;
wire D31, D30, D29, D28, D27, D26, D25, D24, D23, D22, D21, D20, D19, D18, D17, D16, D15, D14, D13, D12, D11, D10, D9, D8, D7, D6, D5, D4, D3, D2, D1, D0;
wire O31, O30, O29, O28, O27, O26, O25, O24, O23, O22, O21, O20, O19, O18, O17, O16, O15, O14, O13, O12, O11, O10, O9, O8, O7, O6, O5, O4, O3, O2, O1, O0;


always@(posedge clk)
begin
	dout  <= {O31, O30, O29, O28, O27, O26, O25, O24, O23, O22, O21, O20, O19, O18, O17, O16, O15, O14, O13, O12, O11, O10, O9, O8, O7, O6, O5, O4, O3, O2, O1, O0}; 	
end	


assign {A4, A3, A2, A1, A0} = addr;
assign {D31, D30, D29, D28, D27, D26, D25, D24, D23, D22, D21, D20, D19, D18, D17, D16, D15, D14, D13, D12, D11, D10, D9, D8, D7, D6, D5, D4, D3, D2, D1, D0} = din;
//assign dout = {O3, O2, O1, O0}; 

  RAM32M #(
      .INIT_A(64'h0000000000000000), // Initial contents of A Port
      .INIT_B(64'h0000000000000000), // Initial contents of B Port
      .INIT_C(64'h0000000000000000), // Initial contents of C Port
      .INIT_D(64'h0000000000000000)  // Initial contents of D Port
   ) RAM32M_inst_0 (
      .DOA({O1, O0}),     // Read port A 2-bit output
      .DOB({O3, O2}),     // Read port B 2-bit output
      .DOC({O5, O4}),     // Read port C 2-bit output
      .DOD({O7, O6}),     // Readw/rite port D 2-bit output
      .ADDRA(addr), // Read port A 5-bit address input
      .ADDRB(addr), // Read port B 5-bit address input
      .ADDRC(addr), // Read port C 5-bit address input
      .ADDRD(addr), // Readw/rite port D 5-bit address input
      .DIA({D1, D0}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRA
      .DIB({D3, D2}),     // RAM 2-bit data write input addressed by ADDRD, 
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
   ) RAM32M_inst_1 (
      .DOA({O9, O8}),     // Read port A 2-bit output
      .DOB({O11, O10}),     // Read port B 2-bit output
      .DOC({O13, O12}),     // Read port C 2-bit output
      .DOD({O15, O14}),     // Readw/rite port D 2-bit output
      .ADDRA(addr), // Read port A 5-bit address input
      .ADDRB(addr), // Read port B 5-bit address input
      .ADDRC(addr), // Read port C 5-bit address input
      .ADDRD(addr), // Readw/rite port D 5-bit address input
      .DIA({D9, D8}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRA
      .DIB({D11, D10}),     // RAM 2-bit data write input addressed by ADDRD, 
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
   ) RAM32M_inst_2 (
      .DOA({O17, O16}),     // Read port A 2-bit output
      .DOB({O19, O18}),     // Read port B 2-bit output
      .DOC({O21, O20}),     // Read port C 2-bit output
      .DOD({O23, O22}),     // Readw/rite port D 2-bit output
      .ADDRA(addr), // Read port A 5-bit address input
      .ADDRB(addr), // Read port B 5-bit address input
      .ADDRC(addr), // Read port C 5-bit address input
      .ADDRD(addr), // Readw/rite port D 5-bit address input
      .DIA({D17, D16}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRA
      .DIB({D19, D18}),     // RAM 2-bit data write input addressed by ADDRD, 
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
   ) RAM32M_inst_3 (
      .DOA({O25, O24}),     // Read port A 2-bit output
      .DOB({O27, O26}),     // Read port B 2-bit output
      .DOC({O29, O28}),     // Read port C 2-bit output
      .DOD({O31, O30}),     // Readw/rite port D 2-bit output
      .ADDRA(addr), // Read port A 5-bit address input
      .ADDRB(addr), // Read port B 5-bit address input
      .ADDRC(addr), // Read port C 5-bit address input
      .ADDRD(addr), // Readw/rite port D 5-bit address input
      .DIA({D25, D24}),     // RAM 2-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRA
      .DIB({D27, D26}),     // RAM 2-bit data write input addressed by ADDRD, 
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
