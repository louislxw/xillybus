module xillydemo
  (
  input  PS_CLK,
  input  PS_PORB,
  input  PS_SRSTB,
  input  clk_100,
  input  otg_oc,   
  inout [14:0] DDR_Addr,
  inout [2:0] DDR_BankAddr,
  inout  DDR_CAS_n,
  inout  DDR_CKE,
  inout  DDR_CS_n,
  inout  DDR_Clk,
  inout  DDR_Clk_n,
  inout [3:0] DDR_DM,
  inout [31:0] DDR_DQ,
  inout [3:0] DDR_DQS,
  inout [3:0] DDR_DQS_n,
  inout  DDR_DRSTB,
  inout  DDR_ODT,
  inout  DDR_RAS_n,
  inout  DDR_VRN,
  inout  DDR_VRP,
  inout [53:0] MIO,
  inout [55:0] PS_GPIO,
  output  DDR_WEB,
  output [3:0] GPIO_LED,
  output [3:0] vga4_blue,
  output [3:0] vga4_green,
  output [3:0] vga4_red,
  output  vga_hsync,
  output  vga_vsync,

  output  audio_mclk,
  output  audio_dac,
  input   audio_adc,
  input   audio_bclk,
  input   audio_lrclk,

  output smb_sclk,
  inout  smb_sdata,
  output [1:0] smbus_addr

  ); 
   // Clock and quiesce
   wire    bus_clk;
   wire    quiesce;

   // Memory arrays
   reg [7:0] demoarray[0:31];
   
   reg [7:0] litearray0[0:31];
   reg [7:0] litearray1[0:31];
   reg [7:0] litearray2[0:31];
   reg [7:0] litearray3[0:31];

   // Wires related to /dev/xillybus_mem_8
   wire      user_r_mem_8_rden;
   wire      user_r_mem_8_empty;
   reg [7:0] user_r_mem_8_data;
   wire      user_r_mem_8_eof;
   wire      user_r_mem_8_open;
   wire      user_w_mem_8_wren;
   wire      user_w_mem_8_full;
   wire [7:0] user_w_mem_8_data;
   wire       user_w_mem_8_open;
   wire [4:0] user_mem_8_addr;
   wire       user_mem_8_addr_update;

   // Wires related to /dev/xillybus_read_32
   wire       user_r_read_32_rden;
   wire       user_r_read_32_empty;
   wire [31:0] user_r_read_32_data;
   wire        user_r_read_32_eof;
   wire        user_r_read_32_open;

   // Wires related to /dev/xillybus_read_8
   wire        user_r_read_8_rden;
   wire        user_r_read_8_empty;
   wire [7:0]  user_r_read_8_data;
   wire        user_r_read_8_eof;
   wire        user_r_read_8_open;

   // Wires related to /dev/xillybus_write_32
   wire        user_w_write_32_wren;
   wire        user_w_write_32_full;
   wire [31:0] user_w_write_32_data;
   wire        user_w_write_32_open;

   // Wires related to /dev/xillybus_write_8
   wire        user_w_write_8_wren;
   wire        user_w_write_8_full;
   wire [7:0]  user_w_write_8_data;
   wire        user_w_write_8_open;

   // Wires related to /dev/xillybus_audio
   wire        user_r_audio_rden;
   wire        user_r_audio_empty;
   wire [31:0] user_r_audio_data;
   wire        user_r_audio_eof;
   wire        user_r_audio_open;
   wire        user_w_audio_wren;
   wire        user_w_audio_full;
   wire [31:0] user_w_audio_data;
   wire        user_w_audio_open;
 
   // Wires related to /dev/xillybus_smb
   wire        user_r_smb_rden;
   wire        user_r_smb_empty;
   wire [7:0]  user_r_smb_data;
   wire        user_r_smb_eof;
   wire        user_r_smb_open;
   wire        user_w_smb_wren;
   wire        user_w_smb_full;
   wire [7:0]  user_w_smb_data;
   wire        user_w_smb_open;

   // Wires related to Xillybus Lite
   wire        user_clk;
   wire        user_wren;
   wire [3:0]  user_wstrb;
   wire        user_rden;
   reg [31:0]  user_rd_data;
   wire [31:0] user_wr_data;
   wire [31:0] user_addr;
   wire        user_irq;
   
   xillybus xillybus_ins (

    // Ports related to /dev/xillybus_mem_8
    // FPGA to CPU signals:
    .user_r_mem_8_rden(user_r_mem_8_rden),
    .user_r_mem_8_empty(user_r_mem_8_empty),
    .user_r_mem_8_data(user_r_mem_8_data),
    .user_r_mem_8_eof(user_r_mem_8_eof),
    .user_r_mem_8_open(user_r_mem_8_open),

    // CPU to FPGA signals:
    .user_w_mem_8_wren(user_w_mem_8_wren),
    .user_w_mem_8_full(user_w_mem_8_full),
    .user_w_mem_8_data(user_w_mem_8_data),
    .user_w_mem_8_open(user_w_mem_8_open),

    // Address signals:
    .user_mem_8_addr(user_mem_8_addr),
    .user_mem_8_addr_update(user_mem_8_addr_update),


    // Ports related to /dev/xillybus_read_32
    // FPGA to CPU signals:
    .user_r_read_32_rden(user_r_read_32_rden),
    .user_r_read_32_empty(user_r_read_32_empty),
    .user_r_read_32_data(user_r_read_32_data),
    .user_r_read_32_eof(user_r_read_32_eof),
    .user_r_read_32_open(user_r_read_32_open),


    // Ports related to /dev/xillybus_read_8
    // FPGA to CPU signals:
    .user_r_read_8_rden(user_r_read_8_rden),
    .user_r_read_8_empty(user_r_read_8_empty),
    .user_r_read_8_data(user_r_read_8_data),
    .user_r_read_8_eof(user_r_read_8_eof),
    .user_r_read_8_open(user_r_read_8_open),


    // Ports related to /dev/xillybus_write_32
    // CPU to FPGA signals:
    .user_w_write_32_wren(user_w_write_32_wren),
    .user_w_write_32_full(user_w_write_32_full),
    .user_w_write_32_data(user_w_write_32_data),
    .user_w_write_32_open(user_w_write_32_open),


    // Ports related to /dev/xillybus_write_8
    // CPU to FPGA signals:
    .user_w_write_8_wren(user_w_write_8_wren),
    .user_w_write_8_full(user_w_write_8_full),
    .user_w_write_8_data(user_w_write_8_data),
    .user_w_write_8_open(user_w_write_8_open),

    // Ports related to /dev/xillybus_audio
    // FPGA to CPU signals:
    .user_r_audio_rden(user_r_audio_rden),
    .user_r_audio_empty(user_r_audio_empty),
    .user_r_audio_data(user_r_audio_data),
    .user_r_audio_eof(user_r_audio_eof),
    .user_r_audio_open(user_r_audio_open),

    // CPU to FPGA signals:
    .user_w_audio_wren(user_w_audio_wren),
    .user_w_audio_full(user_w_audio_full),
    .user_w_audio_data(user_w_audio_data),
    .user_w_audio_open(user_w_audio_open),

    // Ports related to /dev/xillybus_smb
    // FPGA to CPU signals:
    .user_r_smb_rden(user_r_smb_rden),
    .user_r_smb_empty(user_r_smb_empty),
    .user_r_smb_data(user_r_smb_data),
    .user_r_smb_eof(user_r_smb_eof),
    .user_r_smb_open(user_r_smb_open),

    // CPU to FPGA signals:
    .user_w_smb_wren(user_w_smb_wren),
    .user_w_smb_full(user_w_smb_full),
    .user_w_smb_data(user_w_smb_data),
    .user_w_smb_open(user_w_smb_open),

    // Xillybus Lite signals:
    .user_clk ( user_clk ),
    .user_wren ( user_wren ),
    .user_wstrb ( user_wstrb ),
    .user_rden ( user_rden ),
    .user_rd_data ( user_rd_data ),
    .user_wr_data ( user_wr_data ),
    .user_addr ( user_addr ),
    .user_irq ( user_irq ),
			  			  
    // General signals
    .PS_CLK(PS_CLK),
    .PS_PORB(PS_PORB),
    .PS_SRSTB(PS_SRSTB),
    .clk_100(clk_100),
    .otg_oc(otg_oc),
    .DDR_Addr(DDR_Addr),
    .DDR_BankAddr(DDR_BankAddr),
    .DDR_CAS_n(DDR_CAS_n),
    .DDR_CKE(DDR_CKE),
    .DDR_CS_n(DDR_CS_n),
    .DDR_Clk(DDR_Clk),
    .DDR_Clk_n(DDR_Clk_n),
    .DDR_DM(DDR_DM),
    .DDR_DQ(DDR_DQ),
    .DDR_DQS(DDR_DQS),
    .DDR_DQS_n(DDR_DQS_n),
    .DDR_DRSTB(DDR_DRSTB),
    .DDR_ODT(DDR_ODT),
    .DDR_RAS_n(DDR_RAS_n),
    .DDR_VRN(DDR_VRN),
    .DDR_VRP(DDR_VRP),
    .MIO(MIO),
    .PS_GPIO(PS_GPIO),
    .DDR_WEB(DDR_WEB),
    .GPIO_LED(GPIO_LED),
    .bus_clk(bus_clk),
    .quiesce(quiesce),

    // VGA port related outputs
			    
    .vga4_blue(vga4_blue),
    .vga4_green(vga4_green),
    .vga4_red(vga4_red),
    .vga_hsync(vga_hsync),
    .vga_vsync(vga_vsync)
  );

   assign      user_irq = 0; // No interrupts for now
   
   always @(posedge user_clk)
     begin
	if (user_wstrb[0])
	  litearray0[user_addr[6:2]] <= user_wr_data[7:0];

	if (user_wstrb[1])
	  litearray1[user_addr[6:2]] <= user_wr_data[15:8];

	if (user_wstrb[2])
	  litearray2[user_addr[6:2]] <= user_wr_data[23:16];

	if (user_wstrb[3])
	  litearray3[user_addr[6:2]] <= user_wr_data[31:24];
	
	if (user_rden)
	  user_rd_data <= { litearray3[user_addr[6:2]],
			    litearray2[user_addr[6:2]],
			    litearray1[user_addr[6:2]],
			    litearray0[user_addr[6:2]] };
     end
   
   // A simple inferred RAM
   always @(posedge bus_clk)
     begin
	if (user_w_mem_8_wren)
	  demoarray[user_mem_8_addr] <= user_w_mem_8_data;
	
	if (user_r_mem_8_rden)
	  user_r_mem_8_data <= demoarray[user_mem_8_addr];	  
     end

   assign  user_r_mem_8_empty = 0;
   assign  user_r_mem_8_eof = 0;
   assign  user_w_mem_8_full = 0;

//-------------------------------------------kernel----------------------------------------//
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


/********** Signals for input_pipe and mycpu1 **********/
wire [15:0] dout_1;
wire dout_v_1;

reg ready = 0;
reg[5:0] count = 0; 
always @(posedge bus_clk)
begin
	if(!hls_fifo_empty_1)
	begin	
		if ((count >= 1) && (count <= 2))
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
/********** Signals for input_pipe and cpu_1 **********/		


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

//-------------------------------------------kernel----------------------------------------//

   i2s_audio audio
     (
      .bus_clk(bus_clk),
      .clk_100(clk_100),
      .quiesce(quiesce),

      .audio_mclk(audio_mclk),
      .audio_dac(audio_dac),
      .audio_adc(audio_adc),
      .audio_bclk(audio_bclk),
      .audio_lrclk(audio_lrclk),
      
      .user_r_audio_rden(user_r_audio_rden),
      .user_r_audio_empty(user_r_audio_empty),
      .user_r_audio_data(user_r_audio_data),
      .user_r_audio_eof(user_r_audio_eof),
      .user_r_audio_open(user_r_audio_open),
      
      .user_w_audio_wren(user_w_audio_wren),
      .user_w_audio_full(user_w_audio_full),
      .user_w_audio_data(user_w_audio_data),
      .user_w_audio_open(user_w_audio_open)
      );
   
   smbus smbus
     (
      .bus_clk(bus_clk),
      .quiesce(quiesce),

      .smb_sclk(smb_sclk),
      .smb_sdata(smb_sdata),
      .smbus_addr(smbus_addr),

      .user_r_smb_rden(user_r_smb_rden),
      .user_r_smb_empty(user_r_smb_empty),
      .user_r_smb_data(user_r_smb_data),
      .user_r_smb_eof(user_r_smb_eof),
      .user_r_smb_open(user_r_smb_open),
      
      .user_w_smb_wren(user_w_smb_wren),
      .user_w_smb_full(user_w_smb_full),
      .user_w_smb_data(user_w_smb_data),
      .user_w_smb_open(user_w_smb_open)
      );

endmodule
