
`timescale 1 ns / 1 ps

module myip_v1_0_S00_AXI #
(
	// (lab10) Users to add parameters here
	parameter CNT_BIT = 31,

	// Users to add parameters here
	// Input Bram
	parameter integer MEM_IN_0_DATA_WIDTH = 32,
	parameter integer MEM_IN_0_ADDR_WIDTH = 12,

	parameter integer MEM_IN_1_DATA_WIDTH = 32,
	parameter integer MEM_IN_1_ADDR_WIDTH = 12,

	parameter integer MEM_IN_2_DATA_WIDTH = 32,
	parameter integer MEM_IN_2_ADDR_WIDTH = 12,

	parameter integer MEM_IN_3_DATA_WIDTH = 32,
	parameter integer MEM_IN_3_ADDR_WIDTH = 12,

	parameter integer MEM_IN_4_DATA_WIDTH = 32,
	parameter integer MEM_IN_4_ADDR_WIDTH = 12,

	parameter integer MEM_IN_5_DATA_WIDTH = 32,
	parameter integer MEM_IN_5_ADDR_WIDTH = 12,

	parameter integer MEM_IN_6_DATA_WIDTH = 32,
	parameter integer MEM_IN_6_ADDR_WIDTH = 12,

	parameter integer MEM_IN_7_DATA_WIDTH = 32,
	parameter integer MEM_IN_7_ADDR_WIDTH = 12,

	parameter integer MEM_IN_8_DATA_WIDTH = 32,
	parameter integer MEM_IN_8_ADDR_WIDTH = 12,

	parameter integer MEM_IN_9_DATA_WIDTH = 32,
	parameter integer MEM_IN_9_ADDR_WIDTH = 12,

	parameter integer MEM_IN_10_DATA_WIDTH = 32,
	parameter integer MEM_IN_10_ADDR_WIDTH = 12,

	parameter integer MEM_IN_11_DATA_WIDTH = 32,
	parameter integer MEM_IN_11_ADDR_WIDTH = 12,

	parameter integer MEM_IN_12_DATA_WIDTH = 32,
	parameter integer MEM_IN_12_ADDR_WIDTH = 12,

	parameter integer MEM_IN_13_DATA_WIDTH = 32,
	parameter integer MEM_IN_13_ADDR_WIDTH = 12,

	parameter integer MEM_IN_14_DATA_WIDTH = 32,
	parameter integer MEM_IN_14_ADDR_WIDTH = 12,

	parameter integer MEM_IN_15_DATA_WIDTH = 32,
	parameter integer MEM_IN_15_ADDR_WIDTH = 12,

	// Output Bram
	parameter integer MEM_OUT_0_DATA_WIDTH = 32,
	parameter integer MEM_OUT_0_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_1_DATA_WIDTH = 32,
	parameter integer MEM_OUT_1_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_2_DATA_WIDTH = 32,
	parameter integer MEM_OUT_2_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_3_DATA_WIDTH = 32,
	parameter integer MEM_OUT_3_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_4_DATA_WIDTH = 32,
	parameter integer MEM_OUT_4_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_5_DATA_WIDTH = 32,
	parameter integer MEM_OUT_5_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_6_DATA_WIDTH = 32,
	parameter integer MEM_OUT_6_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_7_DATA_WIDTH = 32,
	parameter integer MEM_OUT_7_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_8_DATA_WIDTH = 32,
	parameter integer MEM_OUT_8_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_9_DATA_WIDTH = 32,
	parameter integer MEM_OUT_9_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_10_DATA_WIDTH = 32,
	parameter integer MEM_OUT_10_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_11_DATA_WIDTH = 32,
	parameter integer MEM_OUT_11_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_12_DATA_WIDTH = 32,
	parameter integer MEM_OUT_12_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_13_DATA_WIDTH = 32,
	parameter integer MEM_OUT_13_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_14_DATA_WIDTH = 32,
	parameter integer MEM_OUT_14_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_15_DATA_WIDTH = 32,
	parameter integer MEM_OUT_15_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_16_DATA_WIDTH = 32,
	parameter integer MEM_OUT_16_ADDR_WIDTH = 12,

	parameter integer MEM_OUT_17_DATA_WIDTH = 32,
	parameter integer MEM_OUT_17_ADDR_WIDTH = 12,

	// User parameters ends
	// Do not modify the parameters beyond this line

	// Width of S_AXI data bus
	parameter integer C_S_AXI_DATA_WIDTH	= 32,
	// Width of S_AXI address bus
	parameter integer C_S_AXI_ADDR_WIDTH	= 9
)
(
	// Users to add ports here
	// Input Bram	
	output		[MEM_IN_0_ADDR_WIDTH-1:0] 	mem_in_0_addr1,
	output		 							mem_in_0_ce1,
	output		 							mem_in_0_we1,
	input 		[MEM_IN_0_DATA_WIDTH-1:0] 	mem_in_0_q1,
	output		[MEM_IN_0_DATA_WIDTH-1:0] 	mem_in_0_d1,
	
	output		[MEM_IN_1_ADDR_WIDTH-1:0] 	mem_in_1_addr1,
	output		 							mem_in_1_ce1,
	output		 							mem_in_1_we1,
	input 		[MEM_IN_1_DATA_WIDTH-1:0]	mem_in_1_q1,
	output		[MEM_IN_1_DATA_WIDTH-1:0] 	mem_in_1_d1,
	
	output		[MEM_IN_2_ADDR_WIDTH-1:0] 	mem_in_2_addr1,
	output		 							mem_in_2_ce1,
	output		 							mem_in_2_we1,
	input 		[MEM_IN_2_DATA_WIDTH-1:0] 	mem_in_2_q1,
	output		[MEM_IN_2_DATA_WIDTH-1:0] 	mem_in_2_d1,
	
	output		[MEM_IN_3_ADDR_WIDTH-1:0] 	mem_in_3_addr1,
	output		 							mem_in_3_ce1,
	output		 							mem_in_3_we1,
	input 		[MEM_IN_3_DATA_WIDTH-1:0]   mem_in_3_q1,
	output		[MEM_IN_3_DATA_WIDTH-1:0] 	mem_in_3_d1,
	
	output		[MEM_IN_4_ADDR_WIDTH-1:0] 	mem_in_4_addr1,
	output		 							mem_in_4_ce1,
	output		 							mem_in_4_we1,
	input 		[MEM_IN_4_DATA_WIDTH-1:0]   mem_in_4_q1,
	output		[MEM_IN_4_DATA_WIDTH-1:0] 	mem_in_4_d1,
	
	output		[MEM_IN_5_ADDR_WIDTH-1:0] 	mem_in_5_addr1,
	output		 							mem_in_5_ce1,
	output		 							mem_in_5_we1,
	input 		[MEM_IN_5_DATA_WIDTH-1:0]   mem_in_5_q1,
	output		[MEM_IN_5_DATA_WIDTH-1:0] 	mem_in_5_d1,
	
	output		[MEM_IN_6_ADDR_WIDTH-1:0] 	mem_in_6_addr1,
	output		 							mem_in_6_ce1,
	output		 							mem_in_6_we1,
	input 		[MEM_IN_6_DATA_WIDTH-1:0]   mem_in_6_q1,
	output		[MEM_IN_6_DATA_WIDTH-1:0] 	mem_in_6_d1,
	
	output		[MEM_IN_7_ADDR_WIDTH-1:0] 	mem_in_7_addr1,
	output		 							mem_in_7_ce1,
	output		 							mem_in_7_we1,
	input 		[MEM_IN_7_DATA_WIDTH-1:0]   mem_in_7_q1,
	output		[MEM_IN_7_DATA_WIDTH-1:0] 	mem_in_7_d1,
	
	output		[MEM_IN_8_ADDR_WIDTH-1:0] 	mem_in_8_addr1,
	output		 							mem_in_8_ce1,
	output		 							mem_in_8_we1,
	input 		[MEM_IN_8_DATA_WIDTH-1:0]   mem_in_8_q1,
	output		[MEM_IN_8_DATA_WIDTH-1:0] 	mem_in_8_d1,
	
	output		[MEM_IN_9_ADDR_WIDTH-1:0] 	mem_in_9_addr1,
	output		 							mem_in_9_ce1,
	output		 							mem_in_9_we1,
	input 		[MEM_IN_9_DATA_WIDTH-1:0]   mem_in_9_q1,
	output		[MEM_IN_9_DATA_WIDTH-1:0] 	mem_in_9_d1,

	output		[MEM_IN_10_ADDR_WIDTH-1:0] 	mem_in_10_addr1,
	output		 							mem_in_10_ce1,
	output		 							mem_in_10_we1,
	input 		[MEM_IN_10_DATA_WIDTH-1:0]  mem_in_10_q1,
	output		[MEM_IN_10_DATA_WIDTH-1:0] 	mem_in_10_d1,

	output		[MEM_IN_11_ADDR_WIDTH-1:0] 	mem_in_11_addr1,
	output		 							mem_in_11_ce1,
	output		 							mem_in_11_we1,
	input 		[MEM_IN_11_DATA_WIDTH-1:0]  mem_in_11_q1,
	output		[MEM_IN_11_DATA_WIDTH-1:0] 	mem_in_11_d1,

	output		[MEM_IN_12_ADDR_WIDTH-1:0] 	mem_in_12_addr1,
	output		 							mem_in_12_ce1,
	output		 							mem_in_12_we1,
	input 		[MEM_IN_12_DATA_WIDTH-1:0]  mem_in_12_q1,
	output		[MEM_IN_12_DATA_WIDTH-1:0] 	mem_in_12_d1,

	output		[MEM_IN_13_ADDR_WIDTH-1:0] 	mem_in_13_addr1,
	output		 							mem_in_13_ce1,
	output		 							mem_in_13_we1,
	input 		[MEM_IN_13_DATA_WIDTH-1:0]  mem_in_13_q1,
	output		[MEM_IN_13_DATA_WIDTH-1:0] 	mem_in_13_d1,

	output		[MEM_IN_14_ADDR_WIDTH-1:0] 	mem_in_14_addr1,
	output		 							mem_in_14_ce1,
	output		 							mem_in_14_we1,
	input 		[MEM_IN_14_DATA_WIDTH-1:0]  mem_in_14_q1,
	output		[MEM_IN_14_DATA_WIDTH-1:0] 	mem_in_14_d1,

	output		[MEM_IN_15_ADDR_WIDTH-1:0] 	mem_in_15_addr1,
	output		 							mem_in_15_ce1,
	output		 							mem_in_15_we1,
	input 		[MEM_IN_15_DATA_WIDTH-1:0]  mem_in_15_q1,
	output		[MEM_IN_15_DATA_WIDTH-1:0] 	mem_in_15_d1,
	
	// Output Bram
	output		[MEM_OUT_0_ADDR_WIDTH-1:0] 	mem_out_0_addr1,
	output		 							mem_out_0_ce1,
	output		 							mem_out_0_we1,
	input 		[MEM_OUT_0_DATA_WIDTH-1:0]  mem_out_0_q1,
	output		[MEM_OUT_0_DATA_WIDTH-1:0] 	mem_out_0_d1,

	output		[MEM_OUT_1_ADDR_WIDTH-1:0] 	mem_out_1_addr1,
	output		 							mem_out_1_ce1,
	output		 							mem_out_1_we1,
	input 		[MEM_OUT_1_DATA_WIDTH-1:0]  mem_out_1_q1,
	output		[MEM_OUT_1_DATA_WIDTH-1:0] 	mem_out_1_d1,

	output		[MEM_OUT_2_ADDR_WIDTH-1:0] 	mem_out_2_addr1,
	output		 							mem_out_2_ce1,
	output		 							mem_out_2_we1,
	input 		[MEM_OUT_2_DATA_WIDTH-1:0]  mem_out_2_q1,
	output		[MEM_OUT_2_DATA_WIDTH-1:0] 	mem_out_2_d1,

	output		[MEM_OUT_3_ADDR_WIDTH-1:0] 	mem_out_3_addr1,
	output		 							mem_out_3_ce1,
	output		 							mem_out_3_we1,
	input 		[MEM_OUT_3_DATA_WIDTH-1:0]  mem_out_3_q1,
	output		[MEM_OUT_3_DATA_WIDTH-1:0] 	mem_out_3_d1,

	output		[MEM_OUT_4_ADDR_WIDTH-1:0] 	mem_out_4_addr1,
	output		 							mem_out_4_ce1,
	output		 							mem_out_4_we1,
	input 		[MEM_OUT_4_DATA_WIDTH-1:0]  mem_out_4_q1,
	output		[MEM_OUT_4_DATA_WIDTH-1:0] 	mem_out_4_d1,

	output		[MEM_OUT_5_ADDR_WIDTH-1:0] 	mem_out_5_addr1,
	output		 							mem_out_5_ce1,
	output		 							mem_out_5_we1,
	input 		[MEM_OUT_5_DATA_WIDTH-1:0]  mem_out_5_q1,
	output		[MEM_OUT_5_DATA_WIDTH-1:0] 	mem_out_5_d1,

	output		[MEM_OUT_6_ADDR_WIDTH-1:0] 	mem_out_6_addr1,
	output		 							mem_out_6_ce1,
	output		 							mem_out_6_we1,
	input 		[MEM_OUT_6_DATA_WIDTH-1:0]  mem_out_6_q1,
	output		[MEM_OUT_6_DATA_WIDTH-1:0] 	mem_out_6_d1,

	output		[MEM_OUT_7_ADDR_WIDTH-1:0] 	mem_out_7_addr1,
	output		 							mem_out_7_ce1,
	output		 							mem_out_7_we1,
	input 		[MEM_OUT_7_DATA_WIDTH-1:0]  mem_out_7_q1,
	output		[MEM_OUT_7_DATA_WIDTH-1:0] 	mem_out_7_d1,

	output		[MEM_OUT_8_ADDR_WIDTH-1:0] 	mem_out_8_addr1,
	output		 							mem_out_8_ce1,
	output		 							mem_out_8_we1,
	input 		[MEM_OUT_8_DATA_WIDTH-1:0]  mem_out_8_q1,
	output		[MEM_OUT_8_DATA_WIDTH-1:0] 	mem_out_8_d1,

	output		[MEM_OUT_9_ADDR_WIDTH-1:0] 	mem_out_9_addr1,
	output		 							mem_out_9_ce1,
	output		 							mem_out_9_we1,
	input 		[MEM_OUT_9_DATA_WIDTH-1:0]  mem_out_9_q1,
	output		[MEM_OUT_9_DATA_WIDTH-1:0] 	mem_out_9_d1,

	output		[MEM_OUT_10_ADDR_WIDTH-1:0] mem_out_10_addr1,
	output		 							mem_out_10_ce1,
	output		 							mem_out_10_we1,
	input 		[MEM_OUT_10_DATA_WIDTH-1:0] mem_out_10_q1,
	output		[MEM_OUT_10_DATA_WIDTH-1:0] mem_out_10_d1,

	output		[MEM_OUT_11_ADDR_WIDTH-1:0] mem_out_11_addr1,
	output		 							mem_out_11_ce1,
	output		 							mem_out_11_we1,
	input 		[MEM_OUT_11_DATA_WIDTH-1:0] mem_out_11_q1,
	output		[MEM_OUT_11_DATA_WIDTH-1:0] mem_out_11_d1,

	output		[MEM_OUT_12_ADDR_WIDTH-1:0] mem_out_12_addr1,
	output		 							mem_out_12_ce1,
	output		 							mem_out_12_we1,
	input 		[MEM_OUT_12_DATA_WIDTH-1:0] mem_out_12_q1,
	output		[MEM_OUT_12_DATA_WIDTH-1:0] mem_out_12_d1,

	output		[MEM_OUT_13_ADDR_WIDTH-1:0] mem_out_13_addr1,
	output		 							mem_out_13_ce1,
	output		 							mem_out_13_we1,
	input 		[MEM_OUT_13_DATA_WIDTH-1:0] mem_out_13_q1,
	output		[MEM_OUT_13_DATA_WIDTH-1:0] mem_out_13_d1,

	output		[MEM_OUT_14_ADDR_WIDTH-1:0] mem_out_14_addr1,
	output		 							mem_out_14_ce1,
	output		 							mem_out_14_we1,
	input 		[MEM_OUT_14_DATA_WIDTH-1:0] mem_out_14_q1,
	output		[MEM_OUT_14_DATA_WIDTH-1:0] mem_out_14_d1,

	output		[MEM_OUT_15_ADDR_WIDTH-1:0] mem_out_15_addr1,
	output		 							mem_out_15_ce1,
	output		 							mem_out_15_we1,
	input 		[MEM_OUT_15_DATA_WIDTH-1:0] mem_out_15_q1,
	output		[MEM_OUT_15_DATA_WIDTH-1:0] mem_out_15_d1,

	output		[MEM_OUT_16_ADDR_WIDTH-1:0] mem_out_16_addr1,
	output		 							mem_out_16_ce1,
	output		 							mem_out_16_we1,
	input 		[MEM_OUT_16_DATA_WIDTH-1:0] mem_out_16_q1,
	output		[MEM_OUT_16_DATA_WIDTH-1:0] mem_out_16_d1,

	output		[MEM_OUT_17_ADDR_WIDTH-1:0] mem_out_17_addr1,
	output		 							mem_out_17_ce1,
	output		 							mem_out_17_we1,
	input 		[MEM_OUT_17_DATA_WIDTH-1:0] mem_out_17_q1,
	output		[MEM_OUT_17_DATA_WIDTH-1:0] mem_out_17_d1,
												
	input		[C_S_AXI_DATA_WIDTH-1:0]	fsm_status_reg_in,
	output		[C_S_AXI_DATA_WIDTH-1:0]	fsm_status_reg_out,

	// User ports ends
	// Do not modify the ports beyond this line

	// Global Clock Signal
	input wire  S_AXI_ACLK,
	// Global Reset Signal. This Signal is Activ1e LOW
	input wire  S_AXI_ARESETN,
	// Write address (issued by master, acceped 1by Slave)
	input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
	// Write channel Protection type. This signal indicates the
		// privilege and security level of the transaction, and whether
		// the transaction is a data access or an instruction access.
	input wire [2 : 0] S_AXI_AWPROT,
	// Write address valid. This signal indicates that the master signaling
		// valid write address and control information.
	input wire  S_AXI_AWVALID,
	// Write address ready. This signal indicates that the slave is ready
		// to accept an address and associated control signals.
	output wire  S_AXI_AWREADY,
	// Write data (issued by master, acceped by Slave) 
	input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
	// Write strobes. This signal indicates which byte lanes hold
		// valid data. There is one write strobe bit for each eight
		// bits of the write data bus.    
	input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
	// Write valid. This signal indicates that valid write
		// data and strobes are available.
	input wire  S_AXI_WVALID,
	// Write ready. This signal indicates that the slave
		// can accept the write data.
	output wire  S_AXI_WREADY,
	// Write response. This signal indicates the status
		// of the write transaction.
	output wire [1 : 0] S_AXI_BRESP,
	// Write response valid. This signal indicates that the channel
		// is signaling a valid write response.
	output wire  S_AXI_BVALID,
	// Response ready. This signal indicates that the master
		// can accept a write response.
	input wire  S_AXI_BREADY,
	// Read address (issued by master, acceped by Slave)
	input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
	// Protection type. This signal indicates the privilege
		// and security level of the transaction, and whether the
		// transaction is a data access or an instruction access.
	input wire [2 : 0] S_AXI_ARPROT,
	// Read address valid. This signal indicates that the channel
		// is signaling valid read address and control information.
	input wire  S_AXI_ARVALID,
	// Read address ready. This signal indicates that the slave is
		// ready to accept an address and associated control signals.
	output wire  S_AXI_ARREADY,
	// Read data (issued by slave)
	output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
	// Read response. This signal indicates the status of the
		// read transfer.
	output wire [1 : 0] S_AXI_RRESP,
	// Read valid. This signal indicates that the channel is
		// signaling the required read data.
	output wire  S_AXI_RVALID,
	// Read ready. This signal indicates that the master can
		// accept the read data and response information.
	input wire  S_AXI_RREADY

);

// AXI4LITE signals
reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
reg  	axi_awready;
reg  	axi_wready;
reg [1 : 0] 	axi_bresp;
reg  	axi_bvalid;
reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
reg  	axi_arready;
reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
reg [1 : 0] 	axi_rresp;
reg  	axi_rvalid;
reg  	axi_rvalid_d; // (lab12) delay 1 cycle from bram read

// Example-specific design signals
// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
// ADDR_LSB is used for addressing 32/64 bit registers/memories
// ADDR_LSB = 2 for 32 bits (n downto 2)
// ADDR_LSB = 3 for 64 bits (n downto 3)
localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
localparam integer OPT_MEM_ADDR_BITS = 6; // (lab16) modified 1 -> 3, because we use #16 reg
//----------------------------------------------
//-- Signals for user logic register space example
//------------------------------------------------
//-- Number of Slave Registers 16
//(lab13) Added regs from 4 to 16 to use for next lab
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_00;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_01;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_02;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_03;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_04;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_05;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_06;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_07;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_08;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_09;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_0a;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_0b;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_0c;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_0d;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_0e;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_0f;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_10;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_11;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_12;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_13;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_14;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_15;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_16;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_17;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_18;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_19;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_1a;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_1b;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_1c;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_1d;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_1e;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_1f;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_20;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_21;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_22;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_23;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_24; // Status In Register  (PL -> PS)
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_25; // Temp
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg_26; // Status Out Register (PS -> PL)

wire	 slv_reg_rden;
wire	 slv_reg_wren;
reg [C_S_AXI_DATA_WIDTH-1:0]	 reg_data_out;
integer	 byte_index;
reg	 aw_en;


// Addtional AXI Registers
always @( posedge S_AXI_ACLK )
begin
	if ( S_AXI_ARESETN == 1'b0 )
	begin
		slv_reg_24 <= 0;
	end 
	else
	begin
		slv_reg_24 <= fsm_status_reg_in;
	end 
end 
assign fsm_status_reg_out = slv_reg_26;

// I/O Connections assignments
assign S_AXI_AWREADY	= axi_awready;
assign S_AXI_WREADY	= axi_wready;
assign S_AXI_BRESP	= axi_bresp;
assign S_AXI_BVALID	= axi_bvalid;
assign S_AXI_ARREADY	= axi_arready;
assign S_AXI_RDATA	= axi_rdata;
assign S_AXI_RRESP	= axi_rresp;
//assign S_AXI_RVALID	= axi_rvalid;
assign S_AXI_RVALID	= axi_rvalid_d; // (lab12) delay 1 cycle from bram read
// Implement axi_awready generation
// axi_awready is asserted for one S_AXI_ACLK clock cycle when both
// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
// de-asserted when reset is low.

always @( posedge S_AXI_ACLK )
begin
	if ( S_AXI_ARESETN == 1'b0 )
	begin
		axi_awready <= 1'b0;
		aw_en <= 1'b1;
	end 
	else
	begin    
		if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
		begin
			// slave is ready to accept write address when 
			// there is a valid write address and write data
			// on the write address and data bus. This design 
			// expects no outstanding transactions. 
			axi_awready <= 1'b1;
			aw_en <= 1'b0;
		end
		else if (S_AXI_BREADY && axi_bvalid)
			begin
				aw_en <= 1'b1;
				axi_awready <= 1'b0;
			end
		else           
		begin
			axi_awready <= 1'b0;
		end
	end 
end       

// Implement axi_awaddr latching
// This process is used to latch the address when both 
// S_AXI_AWVALID and S_AXI_WVALID are valid. 

always @( posedge S_AXI_ACLK )
begin
	if ( S_AXI_ARESETN == 1'b0 )
	begin
		axi_awaddr <= 0;
	end 
	else
	begin    
		if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
		begin
			// Write Address latching 
			axi_awaddr <= S_AXI_AWADDR;
		end
	end 
end       

// Implement axi_wready generation
// axi_wready is asserted for one S_AXI_ACLK clock cycle when both
// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
// de-asserted when reset is low. 

always @( posedge S_AXI_ACLK )
begin
	if ( S_AXI_ARESETN == 1'b0 )
	begin
		axi_wready <= 1'b0;
	end 
	else
	begin    
		if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID && aw_en )
		begin
			// slave is ready to accept write data when 
			// there is a valid write address and write data
			// on the write address and data bus. This design 
			// expects no outstanding transactions. 
			axi_wready <= 1'b1;
		end
		else
		begin
			axi_wready <= 1'b0;
		end
	end 
end       

// Implement memory mapped register select and write logic generation
// The write data is accepted and written to memory mapped registers when
// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
// select byte enables of slave registers while writing.
// These registers are cleared when reset (active low) is applied.
// Slave register write enable is asserted when valid address and data are available
// and the slave is ready to accept the write address and write data.
assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

always @( posedge S_AXI_ACLK )
begin
	if ( S_AXI_ARESETN == 1'b0 )
	begin
		slv_reg_00 <= 0; // MEM_IN_ADDR_REG    
		slv_reg_01 <= 0; // MEM_IN_0_DATA_REG  
		slv_reg_02 <= 0; // MEM_IN_1_DATA_REG  
		slv_reg_03 <= 0; // MEM_IN_2_DATA_REG  
		slv_reg_04 <= 0; // MEM_IN_3_DATA_REG  
		slv_reg_05 <= 0; // MEM_IN_4_DATA_REG   
		slv_reg_06 <= 0; // MEM_IN_5_DATA_REG  
		slv_reg_07 <= 0; // MEM_IN_6_DATA_REG  
		slv_reg_08 <= 0; // MEM_IN_7_DATA_REG   
		slv_reg_09 <= 0; // MEM_IN_8_DATA_REG  
		slv_reg_0a <= 0; // MEM_IN_9_DATA_REG  
		slv_reg_0b <= 0; // MEM_IN_10_DATA_REG 
		slv_reg_0c <= 0; // MEM_IN_11_DATA_REG  
		slv_reg_0d <= 0; // MEM_IN_12_DATA_REG 
		slv_reg_0e <= 0; // MEM_IN_13_DATA_REG 
		slv_reg_0f <= 0; // MEM_IN_14_DATA_REG 
		slv_reg_10 <= 0; // MEM_IN_15_DATA_REG 
		slv_reg_11 <= 0; // MEM_OUT_ADDR_REG   
		slv_reg_12 <= 0; // MEM_OUT_0_DATA_REG 
		slv_reg_13 <= 0; // MEM_OUT_1_DATA_REG  
		slv_reg_14 <= 0; // MEM_OUT_2_DATA_REG  
		slv_reg_15 <= 0; // MEM_OUT_3_DATA_REG 
		slv_reg_16 <= 0; // MEM_OUT_4_DATA_REG 
		slv_reg_17 <= 0; // MEM_OUT_5_DATA_REG 
		slv_reg_18 <= 0; // MEM_OUT_6_DATA_REG 
		slv_reg_19 <= 0; // MEM_OUT_7_DATA_REG 
		slv_reg_1a <= 0; // MEM_OUT_8_DATA_REG 
		slv_reg_1b <= 0; // MEM_OUT_9_DATA_REG 
		slv_reg_1c <= 0; // MEM_OUT_10_DATA_REG
		slv_reg_1d <= 0; // MEM_OUT_11_DATA_REG
		slv_reg_1e <= 0; // MEM_OUT_12_DATA_REG
		slv_reg_1f <= 0; // MEM_OUT_13_DATA_REG
		slv_reg_20 <= 0; // MEM_OUT_14_DATA_REG
		slv_reg_21 <= 0; // MEM_OUT_15_DATA_REG
		slv_reg_22 <= 0; // MEM_OUT_16_DATA_REG
		slv_reg_23 <= 0; // MEM_OUT_17_DATA_REG
		// slv_reg_24 <= 0; // STATE_IN_REG     <- Read Only   
		slv_reg_25 <= 0; // Temp  
		slv_reg_26 <= 0; // STATE_OUT_REG   
	end 
	else begin
	if (slv_reg_wren)
		begin
		case ( axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
			6'h00:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 00
					slv_reg_00[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h01:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 01
					slv_reg_01[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h02:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 02
					slv_reg_02[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h03:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 03
					slv_reg_03[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h04:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 04
					slv_reg_04[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h05:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 05
					slv_reg_05[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h06:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 06
					slv_reg_06[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h07:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 07
					slv_reg_07[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h08:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 08
					slv_reg_08[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h09:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 09
					slv_reg_09[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h0a:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 0a
					slv_reg_0a[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h0b:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 0b
					slv_reg_0b[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h0c:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 0c
					slv_reg_0c[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h0d:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 0d
					slv_reg_0d[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h0e:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 0e
					slv_reg_0e[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h0f:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 0f
					slv_reg_0f[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h10:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 10
					slv_reg_10[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h11:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 11
					slv_reg_11[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h12:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 12
					slv_reg_12[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h13:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 13
					slv_reg_13[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h14:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 14
					slv_reg_14[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h15:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 15
					slv_reg_15[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h16:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 16
					slv_reg_16[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h17:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 17
					slv_reg_17[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h18:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 18
					slv_reg_18[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h19:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 19
					slv_reg_19[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h1a:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 1a
					slv_reg_1a[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h1b:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 1b
					slv_reg_1b[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h1c:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 1c
					slv_reg_1c[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h1d:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 1d
					slv_reg_1d[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h1e:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 1e
					slv_reg_1e[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h1f:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 1f
					slv_reg_1f[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h20:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 20
					slv_reg_20[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h21:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 21
					slv_reg_21[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h22:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 22
					slv_reg_22[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h23:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 23
					slv_reg_23[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			// 6'h24:
			// 	for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
			// 		if ( S_AXI_WSTRB[byte_index] == 1 ) begin
			// 		// Respective byte enables are asserted as per write strobes 
			// 		// Slave register 24
			// 		slv_reg_24[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
			// 		end  
			6'h25:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 25
					slv_reg_25[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			6'h26:
				for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
					if ( S_AXI_WSTRB[byte_index] == 1 ) begin
					// Respective byte enables are asserted as per write strobes 
					// Slave register 26
					slv_reg_26[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
					end  
			default : begin
						slv_reg_00 <= slv_reg_00; // MEM_IN_ADDR_REG    
						slv_reg_01 <= slv_reg_01; // MEM_IN_0_DATA_REG  
						slv_reg_02 <= slv_reg_02; // MEM_IN_1_DATA_REG  
						slv_reg_03 <= slv_reg_03; // MEM_IN_2_DATA_REG  
						slv_reg_04 <= slv_reg_04; // MEM_IN_3_DATA_REG  
						slv_reg_05 <= slv_reg_05; // MEM_IN_4_DATA_REG  
						slv_reg_06 <= slv_reg_06; // MEM_IN_5_DATA_REG  
						slv_reg_07 <= slv_reg_07; // MEM_IN_6_DATA_REG  
						slv_reg_08 <= slv_reg_08; // MEM_IN_7_DATA_REG  
						slv_reg_09 <= slv_reg_09; // MEM_IN_8_DATA_REG  
						slv_reg_0a <= slv_reg_0a; // MEM_IN_9_DATA_REG  
						slv_reg_0b <= slv_reg_0b; // MEM_IN_10_DATA_REG 
						slv_reg_0c <= slv_reg_0c; // MEM_IN_11_DATA_REG 
						slv_reg_0d <= slv_reg_0d; // MEM_IN_12_DATA_REG 
						slv_reg_0e <= slv_reg_0e; // MEM_IN_13_DATA_REG 
						slv_reg_0f <= slv_reg_0f; // MEM_IN_14_DATA_REG 
						slv_reg_10 <= slv_reg_10; // MEM_IN_15_DATA_REG 
						slv_reg_11 <= slv_reg_11; // MEM_OUT_ADDR_REG    
						slv_reg_12 <= slv_reg_12; // MEM_OUT_0_DATA_REG 
						slv_reg_13 <= slv_reg_13; // MEM_OUT_1_DATA_REG 
						slv_reg_14 <= slv_reg_14; // MEM_OUT_2_DATA_REG 
						slv_reg_15 <= slv_reg_15; // MEM_OUT_3_DATA_REG 
						slv_reg_16 <= slv_reg_16; // MEM_OUT_4_DATA_REG 
						slv_reg_17 <= slv_reg_17; // MEM_OUT_5_DATA_REG 
						slv_reg_18 <= slv_reg_18; // MEM_OUT_6_DATA_REG 
						slv_reg_19 <= slv_reg_19; // MEM_OUT_7_DATA_REG 
						slv_reg_1a <= slv_reg_1a; // MEM_OUT_8_DATA_REG 
						slv_reg_1b <= slv_reg_1b; // MEM_OUT_9_DATA_REG 
						slv_reg_1c <= slv_reg_1c; // MEM_OUT_10_DATA_REG
						slv_reg_1d <= slv_reg_1d; // MEM_OUT_11_DATA_REG
						slv_reg_1e <= slv_reg_1e; // MEM_OUT_12_DATA_REG
						slv_reg_1f <= slv_reg_1f; // MEM_OUT_13_DATA_REG
						slv_reg_20 <= slv_reg_20; // MEM_OUT_14_DATA_REG
						slv_reg_21 <= slv_reg_21; // MEM_OUT_15_DATA_REG
						slv_reg_22 <= slv_reg_22; // MEM_OUT_16_DATA_REG
						slv_reg_23 <= slv_reg_23; // MEM_OUT_17_DATA_REG
						slv_reg_24 <= slv_reg_24; // STATE_IN_REG       
						slv_reg_25 <= slv_reg_25; // TEMP_REG     
						slv_reg_26 <= slv_reg_26; // STATE_OUT_REG    
					end
		endcase
		end
	end
end    

// (lab12) AXI4-Lite Read / Write Condition 
wire clk = S_AXI_ACLK;
wire reset_n = S_AXI_ARESETN;

// (lab12) delay 1 cycle, read valid from memory
reg slv_reg_rden_d;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		axi_rvalid_d	<= 'd0;
		slv_reg_rden_d	<= 'd0;
	end else begin
		axi_rvalid_d	<= axi_rvalid;
		slv_reg_rden_d	<= slv_reg_rden;
	end 
end

//////////////////////////////////////// mem_in_0 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_0_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_0_axi_data = 'h004; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_0_addr_reg = S_AXI_WDATA;  // mem_in_0_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_0_data_reg = S_AXI_WDATA;  // mem_in_0_DATA_COUNT
wire mem_in_0_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_0_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_0_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_0_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_0_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_0_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_0_ADDR_WIDTH-1:0] mem_in_0_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_0_addr_cnt <= 0;  
	end else if (mem_in_0_addr_write_hit) begin
		mem_in_0_addr_cnt <= mem_in_0_addr_reg; 
	end else if (mem_in_0_data_write_hit || mem_in_0_data_read_hit) begin
		mem_in_0_addr_cnt <= mem_in_0_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_0_addr1 	= mem_in_0_addr_cnt[MEM_IN_0_ADDR_WIDTH-1:0]; 
assign mem_in_0_ce1		= mem_in_0_data_write_hit || mem_in_0_data_read_hit;
assign mem_in_0_we1		= mem_in_0_data_write_hit;
assign mem_in_0_d1		= mem_in_0_data_reg;

//////////////////////////////////////// mem_in_1 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_1_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_1_axi_data = 'h008; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_1_addr_reg = S_AXI_WDATA;  // mem_in_1_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_1_data_reg = S_AXI_WDATA;  // mem_in_1_DATA_COUNT
wire mem_in_1_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_1_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_1_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_1_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_1_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_1_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_1_ADDR_WIDTH-1:0] mem_in_1_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_1_addr_cnt <= 0;  
	end else if (mem_in_1_addr_write_hit) begin
		mem_in_1_addr_cnt <= mem_in_1_addr_reg; 
	end else if (mem_in_1_data_write_hit || mem_in_1_data_read_hit) begin
		mem_in_1_addr_cnt <= mem_in_1_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_1_addr1 	= mem_in_1_addr_cnt[MEM_IN_1_ADDR_WIDTH-1:0]; 
assign mem_in_1_ce1		= mem_in_1_data_write_hit || mem_in_1_data_read_hit;
assign mem_in_1_we1		= mem_in_1_data_write_hit;
assign mem_in_1_d1		= mem_in_1_data_reg;

//////////////////////////////////////// mem_in_2 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_2_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_2_axi_data = 'h00c; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_2_addr_reg = S_AXI_WDATA;  // mem_in_2_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_2_data_reg = S_AXI_WDATA;  // mem_in_2_DATA_COUNT
wire mem_in_2_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_2_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_2_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_2_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_2_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_2_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_2_ADDR_WIDTH-1:0] mem_in_2_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_2_addr_cnt <= 0;  
	end else if (mem_in_2_addr_write_hit) begin
		mem_in_2_addr_cnt <= mem_in_2_addr_reg; 
	end else if (mem_in_2_data_write_hit || mem_in_2_data_read_hit) begin
		mem_in_2_addr_cnt <= mem_in_2_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_2_addr1 	= mem_in_2_addr_cnt[MEM_IN_2_ADDR_WIDTH-1:0]; 
assign mem_in_2_ce1		= mem_in_2_data_write_hit || mem_in_2_data_read_hit;
assign mem_in_2_we1		= mem_in_2_data_write_hit;
assign mem_in_2_d1		= mem_in_2_data_reg;

//////////////////////////////////////// mem_in_3 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_3_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_3_axi_data = 'h010; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_3_addr_reg = S_AXI_WDATA;  // mem_in_3_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_3_data_reg = S_AXI_WDATA;  // mem_in_3_DATA_COUNT
wire mem_in_3_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_3_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_3_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_3_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_3_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_3_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_3_ADDR_WIDTH-1:0] mem_in_3_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_3_addr_cnt <= 0;  
	end else if (mem_in_3_addr_write_hit) begin
		mem_in_3_addr_cnt <= mem_in_3_addr_reg; 
	end else if (mem_in_3_data_write_hit || mem_in_3_data_read_hit) begin
		mem_in_3_addr_cnt <= mem_in_3_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_3_addr1 	= mem_in_3_addr_cnt[MEM_IN_3_ADDR_WIDTH-1:0]; 
assign mem_in_3_ce1		= mem_in_3_data_write_hit || mem_in_3_data_read_hit;
assign mem_in_3_we1		= mem_in_3_data_write_hit;
assign mem_in_3_d1		= mem_in_3_data_reg;

//////////////////////////////////////// mem_in_4 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_4_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_4_axi_data = 'h014; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_4_addr_reg = S_AXI_WDATA;  // mem_in_4_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_4_data_reg = S_AXI_WDATA;  // mem_in_4_DATA_COUNT
wire mem_in_4_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_4_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_4_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_4_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_4_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_4_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_4_ADDR_WIDTH-1:0] mem_in_4_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_4_addr_cnt <= 0;  
	end else if (mem_in_4_addr_write_hit) begin
		mem_in_4_addr_cnt <= mem_in_4_addr_reg; 
	end else if (mem_in_4_data_write_hit || mem_in_4_data_read_hit) begin
		mem_in_4_addr_cnt <= mem_in_4_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_4_addr1 	= mem_in_4_addr_cnt[MEM_IN_4_ADDR_WIDTH-1:0]; 
assign mem_in_4_ce1		= mem_in_4_data_write_hit || mem_in_4_data_read_hit;
assign mem_in_4_we1		= mem_in_4_data_write_hit;
assign mem_in_4_d1		= mem_in_4_data_reg;

//////////////////////////////////////// mem_in_5 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_5_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_5_axi_data = 'h018; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_5_addr_reg = S_AXI_WDATA;  // mem_in_5_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_5_data_reg = S_AXI_WDATA;  // mem_in_5_DATA_COUNT
wire mem_in_5_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_5_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_5_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_5_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_5_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_5_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_5_ADDR_WIDTH-1:0] mem_in_5_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_5_addr_cnt <= 0;  
	end else if (mem_in_5_addr_write_hit) begin
		mem_in_5_addr_cnt <= mem_in_5_addr_reg; 
	end else if (mem_in_5_data_write_hit || mem_in_5_data_read_hit) begin
		mem_in_5_addr_cnt <= mem_in_5_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_5_addr1 	= mem_in_5_addr_cnt[MEM_IN_5_ADDR_WIDTH-1:0]; 
assign mem_in_5_ce1		= mem_in_5_data_write_hit || mem_in_5_data_read_hit;
assign mem_in_5_we1		= mem_in_5_data_write_hit;
assign mem_in_5_d1		= mem_in_5_data_reg;

//////////////////////////////////////// mem_in_6 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_6_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_6_axi_data = 'h01c; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_6_addr_reg = S_AXI_WDATA;  // mem_in_6_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_6_data_reg = S_AXI_WDATA;  // mem_in_6_DATA_COUNT
wire mem_in_6_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_6_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_6_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_6_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_6_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_6_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_6_ADDR_WIDTH-1:0] mem_in_6_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_6_addr_cnt <= 0;  
	end else if (mem_in_6_addr_write_hit) begin
		mem_in_6_addr_cnt <= mem_in_6_addr_reg; 
	end else if (mem_in_6_data_write_hit || mem_in_6_data_read_hit) begin
		mem_in_6_addr_cnt <= mem_in_6_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_6_addr1 	= mem_in_6_addr_cnt[MEM_IN_6_ADDR_WIDTH-1:0]; 
assign mem_in_6_ce1		= mem_in_6_data_write_hit || mem_in_6_data_read_hit;
assign mem_in_6_we1		= mem_in_6_data_write_hit;
assign mem_in_6_d1		= mem_in_6_data_reg;

//////////////////////////////////////// mem_in_7 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_7_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_7_axi_data = 'h020; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_7_addr_reg = S_AXI_WDATA;  // mem_in_7_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_7_data_reg = S_AXI_WDATA;  // mem_in_7_DATA_COUNT
wire mem_in_7_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_7_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_7_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_7_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_7_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_7_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_7_ADDR_WIDTH-1:0] mem_in_7_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_7_addr_cnt <= 0;  
	end else if (mem_in_7_addr_write_hit) begin
		mem_in_7_addr_cnt <= mem_in_7_addr_reg; 
	end else if (mem_in_7_data_write_hit || mem_in_7_data_read_hit) begin
		mem_in_7_addr_cnt <= mem_in_7_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_7_addr1 	= mem_in_7_addr_cnt[MEM_IN_7_ADDR_WIDTH-1:0]; 
assign mem_in_7_ce1		= mem_in_7_data_write_hit || mem_in_7_data_read_hit;
assign mem_in_7_we1		= mem_in_7_data_write_hit;
assign mem_in_7_d1		= mem_in_7_data_reg;

//////////////////////////////////////// mem_in_8 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_8_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_8_axi_data = 'h024; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_8_addr_reg = S_AXI_WDATA;  // mem_in_8_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_8_data_reg = S_AXI_WDATA;  // mem_in_8_DATA_COUNT
wire mem_in_8_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_8_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_8_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_8_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_8_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_8_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_8_ADDR_WIDTH-1:0] mem_in_8_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_8_addr_cnt <= 0;  
	end else if (mem_in_8_addr_write_hit) begin
		mem_in_8_addr_cnt <= mem_in_8_addr_reg; 
	end else if (mem_in_8_data_write_hit || mem_in_8_data_read_hit) begin
		mem_in_8_addr_cnt <= mem_in_8_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_8_addr1 	= mem_in_8_addr_cnt[MEM_IN_8_ADDR_WIDTH-1:0]; 
assign mem_in_8_ce1		= mem_in_8_data_write_hit || mem_in_8_data_read_hit;
assign mem_in_8_we1		= mem_in_8_data_write_hit;
assign mem_in_8_d1		= mem_in_8_data_reg;

//////////////////////////////////////// mem_in_9 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_9_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_9_axi_data = 'h028; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_9_addr_reg = S_AXI_WDATA;  // mem_in_9_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_9_data_reg = S_AXI_WDATA;  // mem_in_9_DATA_COUNT
wire mem_in_9_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_9_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_9_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_9_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_9_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_9_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_9_ADDR_WIDTH-1:0] mem_in_9_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_9_addr_cnt <= 0;  
	end else if (mem_in_9_addr_write_hit) begin
		mem_in_9_addr_cnt <= mem_in_9_addr_reg; 
	end else if (mem_in_9_data_write_hit || mem_in_9_data_read_hit) begin
		mem_in_9_addr_cnt <= mem_in_9_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_9_addr1 	= mem_in_9_addr_cnt[MEM_IN_9_ADDR_WIDTH-1:0]; 
assign mem_in_9_ce1		= mem_in_9_data_write_hit || mem_in_9_data_read_hit;
assign mem_in_9_we1		= mem_in_9_data_write_hit;
assign mem_in_9_d1		= mem_in_9_data_reg;

//////////////////////////////////////// mem_in_10 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_10_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_10_axi_data = 'h02c; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_10_addr_reg = S_AXI_WDATA;  // mem_in_10_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_10_data_reg = S_AXI_WDATA;  // mem_in_10_DATA_COUNT
wire mem_in_10_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_10_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_10_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_10_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_10_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_10_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_10_ADDR_WIDTH-1:0] mem_in_10_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_10_addr_cnt <= 0;  
	end else if (mem_in_10_addr_write_hit) begin
		mem_in_10_addr_cnt <= mem_in_10_addr_reg; 
	end else if (mem_in_10_data_write_hit || mem_in_10_data_read_hit) begin
		mem_in_10_addr_cnt <= mem_in_10_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_10_addr1 	= mem_in_10_addr_cnt[MEM_IN_10_ADDR_WIDTH-1:0]; 
assign mem_in_10_ce1	= mem_in_10_data_write_hit || mem_in_10_data_read_hit;
assign mem_in_10_we1	= mem_in_10_data_write_hit;
assign mem_in_10_d1		= mem_in_10_data_reg;

//////////////////////////////////////// mem_in_11 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_11_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_11_axi_data = 'h030; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_11_addr_reg = S_AXI_WDATA;  // mem_in_11_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_11_data_reg = S_AXI_WDATA;  // mem_in_11_DATA_COUNT
wire mem_in_11_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_11_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_11_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_11_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_11_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_11_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_11_ADDR_WIDTH-1:0] mem_in_11_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_11_addr_cnt <= 0;  
	end else if (mem_in_11_addr_write_hit) begin
		mem_in_11_addr_cnt <= mem_in_11_addr_reg; 
	end else if (mem_in_11_data_write_hit || mem_in_11_data_read_hit) begin
		mem_in_11_addr_cnt <= mem_in_11_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_11_addr1 	= mem_in_11_addr_cnt[MEM_IN_11_ADDR_WIDTH-1:0]; 
assign mem_in_11_ce1	= mem_in_11_data_write_hit || mem_in_11_data_read_hit;
assign mem_in_11_we1	= mem_in_11_data_write_hit;
assign mem_in_11_d1		= mem_in_11_data_reg;

//////////////////////////////////////// mem_in_12 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_12_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_12_axi_data = 'h034; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_12_addr_reg = S_AXI_WDATA;  // mem_in_12_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_12_data_reg = S_AXI_WDATA;  // mem_in_12_DATA_COUNT
wire mem_in_12_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_12_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_12_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_12_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_12_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_12_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_12_ADDR_WIDTH-1:0] mem_in_12_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_12_addr_cnt <= 0;  
	end else if (mem_in_12_addr_write_hit) begin
		mem_in_12_addr_cnt <= mem_in_12_addr_reg; 
	end else if (mem_in_12_data_write_hit || mem_in_12_data_read_hit) begin
		mem_in_12_addr_cnt <= mem_in_12_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_12_addr1 	= mem_in_12_addr_cnt[MEM_IN_12_ADDR_WIDTH-1:0]; 
assign mem_in_12_ce1	= mem_in_12_data_write_hit || mem_in_12_data_read_hit;
assign mem_in_12_we1	= mem_in_12_data_write_hit;
assign mem_in_12_d1		= mem_in_12_data_reg;

//////////////////////////////////////// mem_in_13 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_13_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_13_axi_data = 'h038; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_13_addr_reg = S_AXI_WDATA;  // mem_in_13_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_13_data_reg = S_AXI_WDATA;  // mem_in_13_DATA_COUNT
wire mem_in_13_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_13_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_13_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_13_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_13_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_13_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_13_ADDR_WIDTH-1:0] mem_in_13_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_13_addr_cnt <= 0;  
	end else if (mem_in_13_addr_write_hit) begin
		mem_in_13_addr_cnt <= mem_in_13_addr_reg; 
	end else if (mem_in_13_data_write_hit || mem_in_13_data_read_hit) begin
		mem_in_13_addr_cnt <= mem_in_13_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_13_addr1 	= mem_in_13_addr_cnt[MEM_IN_13_ADDR_WIDTH-1:0]; 
assign mem_in_13_ce1	= mem_in_13_data_write_hit || mem_in_13_data_read_hit;
assign mem_in_13_we1	= mem_in_13_data_write_hit;
assign mem_in_13_d1		= mem_in_13_data_reg;

//////////////////////////////////////// mem_in_14 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_14_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_14_axi_data = 'h03c; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_14_addr_reg = S_AXI_WDATA;  // mem_in_14_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_14_data_reg = S_AXI_WDATA;  // mem_in_14_DATA_COUNT
wire mem_in_14_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_14_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_14_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_14_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_14_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_14_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_14_ADDR_WIDTH-1:0] mem_in_14_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_14_addr_cnt <= 0;  
	end else if (mem_in_14_addr_write_hit) begin
		mem_in_14_addr_cnt <= mem_in_14_addr_reg; 
	end else if (mem_in_14_data_write_hit || mem_in_14_data_read_hit) begin
		mem_in_14_addr_cnt <= mem_in_14_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_14_addr1 	= mem_in_14_addr_cnt[MEM_IN_14_ADDR_WIDTH-1:0]; 
assign mem_in_14_ce1	= mem_in_14_data_write_hit || mem_in_14_data_read_hit;
assign mem_in_14_we1	= mem_in_14_data_write_hit;
assign mem_in_14_d1		= mem_in_14_data_reg;

//////////////////////////////////////// mem_in_15 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_15_axi_addr = 'h000; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_in_15_axi_data = 'h040; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_15_addr_reg = S_AXI_WDATA;  // mem_in_15_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_in_15_data_reg = S_AXI_WDATA;  // mem_in_15_DATA_COUNT
wire mem_in_15_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_15_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_15_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_15_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_in_15_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_in_15_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_IN_15_ADDR_WIDTH-1:0] mem_in_15_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_in_15_addr_cnt <= 0;  
	end else if (mem_in_15_addr_write_hit) begin
		mem_in_15_addr_cnt <= mem_in_15_addr_reg; 
	end else if (mem_in_15_data_write_hit || mem_in_15_data_read_hit) begin
		mem_in_15_addr_cnt <= mem_in_15_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_in_15_addr1 	= mem_in_15_addr_cnt[MEM_IN_15_ADDR_WIDTH-1:0]; 
assign mem_in_15_ce1	= mem_in_15_data_write_hit || mem_in_15_data_read_hit;
assign mem_in_15_we1	= mem_in_15_data_write_hit;
assign mem_in_15_d1		= mem_in_15_data_reg;

//////////////////////////////////////// mem_out_0 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_0_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_0_axi_data = 'h048; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_0_addr_reg = S_AXI_WDATA;  // mem_out_0_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_0_data_reg = S_AXI_WDATA;  // mem_out_0_DATA_COUNT
wire mem_out_0_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_0_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_0_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_0_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_0_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_0_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_0_ADDR_WIDTH-1:0] mem_out_0_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_0_addr_cnt <= 0;  
	end else if (mem_out_0_addr_write_hit) begin
		mem_out_0_addr_cnt <= mem_out_0_addr_reg; 
	end else if (mem_out_0_data_write_hit || mem_out_0_data_read_hit) begin
		mem_out_0_addr_cnt <= mem_out_0_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_0_addr1 	= mem_out_0_addr_cnt[MEM_OUT_0_ADDR_WIDTH-1:0]; 
assign mem_out_0_ce1	= mem_out_0_data_write_hit || mem_out_0_data_read_hit;
assign mem_out_0_we1	= mem_out_0_data_write_hit;
assign mem_out_0_d1		= mem_out_0_data_reg;

//////////////////////////////////////// mem_out_1 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_1_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_1_axi_data = 'h04c; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_1_addr_reg = S_AXI_WDATA;  // mem_out_1_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_1_data_reg = S_AXI_WDATA;  // mem_out_1_DATA_COUNT
wire mem_out_1_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_1_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_1_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_1_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_1_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_1_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_1_ADDR_WIDTH-1:0] mem_out_1_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_1_addr_cnt <= 0;  
	end else if (mem_out_1_addr_write_hit) begin
		mem_out_1_addr_cnt <= mem_out_1_addr_reg; 
	end else if (mem_out_1_data_write_hit || mem_out_1_data_read_hit) begin
		mem_out_1_addr_cnt <= mem_out_1_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_1_addr1 	= mem_out_1_addr_cnt[MEM_OUT_1_ADDR_WIDTH-1:0]; 
assign mem_out_1_ce1	= mem_out_1_data_write_hit || mem_out_1_data_read_hit;
assign mem_out_1_we1	= mem_out_1_data_write_hit;
assign mem_out_1_d1		= mem_out_1_data_reg;

//////////////////////////////////////// mem_out_2 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_2_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_2_axi_data = 'h050; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_2_addr_reg = S_AXI_WDATA;  // mem_out_2_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_2_data_reg = S_AXI_WDATA;  // mem_out_2_DATA_COUNT
wire mem_out_2_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_2_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_2_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_2_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_2_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_2_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_2_ADDR_WIDTH-1:0] mem_out_2_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_2_addr_cnt <= 0;  
	end else if (mem_out_2_addr_write_hit) begin
		mem_out_2_addr_cnt <= mem_out_2_addr_reg; 
	end else if (mem_out_2_data_write_hit || mem_out_2_data_read_hit) begin
		mem_out_2_addr_cnt <= mem_out_2_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_2_addr1 	= mem_out_2_addr_cnt[MEM_OUT_2_ADDR_WIDTH-1:0]; 
assign mem_out_2_ce1	= mem_out_2_data_write_hit || mem_out_2_data_read_hit;
assign mem_out_2_we1	= mem_out_2_data_write_hit;
assign mem_out_2_d1		= mem_out_2_data_reg;

//////////////////////////////////////// mem_out_3 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_3_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_3_axi_data = 'h054; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_3_addr_reg = S_AXI_WDATA;  // mem_out_3_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_3_data_reg = S_AXI_WDATA;  // mem_out_3_DATA_COUNT
wire mem_out_3_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_3_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_3_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_3_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_3_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_3_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_3_ADDR_WIDTH-1:0] mem_out_3_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_3_addr_cnt <= 0;  
	end else if (mem_out_3_addr_write_hit) begin
		mem_out_3_addr_cnt <= mem_out_3_addr_reg; 
	end else if (mem_out_3_data_write_hit || mem_out_3_data_read_hit) begin
		mem_out_3_addr_cnt <= mem_out_3_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_3_addr1 	= mem_out_3_addr_cnt[MEM_OUT_3_ADDR_WIDTH-1:0]; 
assign mem_out_3_ce1	= mem_out_3_data_write_hit || mem_out_3_data_read_hit;
assign mem_out_3_we1	= mem_out_3_data_write_hit;
assign mem_out_3_d1		= mem_out_3_data_reg;

//////////////////////////////////////// mem_out_4 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_4_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_4_axi_data = 'h058; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_4_addr_reg = S_AXI_WDATA;  // mem_out_4_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_4_data_reg = S_AXI_WDATA;  // mem_out_4_DATA_COUNT
wire mem_out_4_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_4_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_4_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_4_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_4_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_4_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_4_ADDR_WIDTH-1:0] mem_out_4_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_4_addr_cnt <= 0;  
	end else if (mem_out_4_addr_write_hit) begin
		mem_out_4_addr_cnt <= mem_out_4_addr_reg; 
	end else if (mem_out_4_data_write_hit || mem_out_4_data_read_hit) begin
		mem_out_4_addr_cnt <= mem_out_4_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_4_addr1 	= mem_out_4_addr_cnt[MEM_OUT_4_ADDR_WIDTH-1:0]; 
assign mem_out_4_ce1	= mem_out_4_data_write_hit || mem_out_4_data_read_hit;
assign mem_out_4_we1	= mem_out_4_data_write_hit;
assign mem_out_4_d1		= mem_out_4_data_reg;

//////////////////////////////////////// mem_out_5 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_5_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_5_axi_data = 'h05c; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_5_addr_reg = S_AXI_WDATA;  // mem_out_5_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_5_data_reg = S_AXI_WDATA;  // mem_out_5_DATA_COUNT
wire mem_out_5_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_5_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_5_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_5_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_5_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_5_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_5_ADDR_WIDTH-1:0] mem_out_5_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_5_addr_cnt <= 0;  
	end else if (mem_out_5_addr_write_hit) begin
		mem_out_5_addr_cnt <= mem_out_5_addr_reg; 
	end else if (mem_out_5_data_write_hit || mem_out_5_data_read_hit) begin
		mem_out_5_addr_cnt <= mem_out_5_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_5_addr1 	= mem_out_5_addr_cnt[MEM_OUT_5_ADDR_WIDTH-1:0]; 
assign mem_out_5_ce1	= mem_out_5_data_write_hit || mem_out_5_data_read_hit;
assign mem_out_5_we1	= mem_out_5_data_write_hit;
assign mem_out_5_d1		= mem_out_5_data_reg;

//////////////////////////////////////// mem_out_6 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_6_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_6_axi_data = 'h060; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_6_addr_reg = S_AXI_WDATA;  // mem_out_6_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_6_data_reg = S_AXI_WDATA;  // mem_out_6_DATA_COUNT
wire mem_out_6_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_6_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_6_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_6_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_6_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_6_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_6_ADDR_WIDTH-1:0] mem_out_6_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_6_addr_cnt <= 0;  
	end else if (mem_out_6_addr_write_hit) begin
		mem_out_6_addr_cnt <= mem_out_6_addr_reg; 
	end else if (mem_out_6_data_write_hit || mem_out_6_data_read_hit) begin
		mem_out_6_addr_cnt <= mem_out_6_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_6_addr1 	= mem_out_6_addr_cnt[MEM_OUT_6_ADDR_WIDTH-1:0]; 
assign mem_out_6_ce1	= mem_out_6_data_write_hit || mem_out_6_data_read_hit;
assign mem_out_6_we1	= mem_out_6_data_write_hit;
assign mem_out_6_d1		= mem_out_6_data_reg;

//////////////////////////////////////// mem_out_7 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_7_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_7_axi_data = 'h064; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_7_addr_reg = S_AXI_WDATA;  // mem_out_7_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_7_data_reg = S_AXI_WDATA;  // mem_out_7_DATA_COUNT
wire mem_out_7_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_7_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_7_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_7_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_7_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_7_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_7_ADDR_WIDTH-1:0] mem_out_7_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_7_addr_cnt <= 0;  
	end else if (mem_out_7_addr_write_hit) begin
		mem_out_7_addr_cnt <= mem_out_7_addr_reg; 
	end else if (mem_out_7_data_write_hit || mem_out_7_data_read_hit) begin
		mem_out_7_addr_cnt <= mem_out_7_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_7_addr1 	= mem_out_7_addr_cnt[MEM_OUT_7_ADDR_WIDTH-1:0]; 
assign mem_out_7_ce1	= mem_out_7_data_write_hit || mem_out_7_data_read_hit;
assign mem_out_7_we1	= mem_out_7_data_write_hit;
assign mem_out_7_d1		= mem_out_7_data_reg;

//////////////////////////////////////// mem_out_8 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_8_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_8_axi_data = 'h068; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_8_addr_reg = S_AXI_WDATA;  // mem_out_8_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_8_data_reg = S_AXI_WDATA;  // mem_out_8_DATA_COUNT
wire mem_out_8_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_8_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_8_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_8_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_8_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_8_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_8_ADDR_WIDTH-1:0] mem_out_8_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_8_addr_cnt <= 0;  
	end else if (mem_out_8_addr_write_hit) begin
		mem_out_8_addr_cnt <= mem_out_8_addr_reg; 
	end else if (mem_out_8_data_write_hit || mem_out_8_data_read_hit) begin
		mem_out_8_addr_cnt <= mem_out_8_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_8_addr1 	= mem_out_8_addr_cnt[MEM_OUT_8_ADDR_WIDTH-1:0]; 
assign mem_out_8_ce1	= mem_out_8_data_write_hit || mem_out_8_data_read_hit;
assign mem_out_8_we1	= mem_out_8_data_write_hit;
assign mem_out_8_d1		= mem_out_8_data_reg;

//////////////////////////////////////// mem_out_9 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_9_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_9_axi_data = 'h06c; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_9_addr_reg = S_AXI_WDATA;  // mem_out_9_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_9_data_reg = S_AXI_WDATA;  // mem_out_9_DATA_COUNT
wire mem_out_9_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_9_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_9_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_9_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_9_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_9_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_9_ADDR_WIDTH-1:0] mem_out_9_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_9_addr_cnt <= 0;  
	end else if (mem_out_9_addr_write_hit) begin
		mem_out_9_addr_cnt <= mem_out_9_addr_reg; 
	end else if (mem_out_9_data_write_hit || mem_out_9_data_read_hit) begin
		mem_out_9_addr_cnt <= mem_out_9_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_9_addr1 	= mem_out_9_addr_cnt[MEM_OUT_9_ADDR_WIDTH-1:0]; 
assign mem_out_9_ce1	= mem_out_9_data_write_hit || mem_out_9_data_read_hit;
assign mem_out_9_we1	= mem_out_9_data_write_hit;
assign mem_out_9_d1		= mem_out_9_data_reg;

//////////////////////////////////////// mem_out_10 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_10_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_10_axi_data = 'h070; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_10_addr_reg = S_AXI_WDATA;  // mem_out_10_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_10_data_reg = S_AXI_WDATA;  // mem_out_10_DATA_COUNT
wire mem_out_10_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_10_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_10_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_10_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_10_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_10_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_10_ADDR_WIDTH-1:0] mem_out_10_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_10_addr_cnt <= 0;  
	end else if (mem_out_10_addr_write_hit) begin
		mem_out_10_addr_cnt <= mem_out_10_addr_reg; 
	end else if (mem_out_10_data_write_hit || mem_out_10_data_read_hit) begin
		mem_out_10_addr_cnt <= mem_out_10_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_10_addr1 = mem_out_10_addr_cnt[MEM_OUT_10_ADDR_WIDTH-1:0]; 
assign mem_out_10_ce1	= mem_out_10_data_write_hit || mem_out_10_data_read_hit;
assign mem_out_10_we1	= mem_out_10_data_write_hit;
assign mem_out_10_d1	= mem_out_10_data_reg;

//////////////////////////////////////// mem_out_11 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_11_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_11_axi_data = 'h074; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_11_addr_reg = S_AXI_WDATA;  // mem_out_11_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_11_data_reg = S_AXI_WDATA;  // mem_out_11_DATA_COUNT
wire mem_out_11_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_11_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_11_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_11_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_11_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_11_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_11_ADDR_WIDTH-1:0] mem_out_11_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_11_addr_cnt <= 0;  
	end else if (mem_out_11_addr_write_hit) begin
		mem_out_11_addr_cnt <= mem_out_11_addr_reg; 
	end else if (mem_out_11_data_write_hit || mem_out_11_data_read_hit) begin
		mem_out_11_addr_cnt <= mem_out_11_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_11_addr1 = mem_out_11_addr_cnt[MEM_OUT_11_ADDR_WIDTH-1:0]; 
assign mem_out_11_ce1	= mem_out_11_data_write_hit || mem_out_11_data_read_hit;
assign mem_out_11_we1	= mem_out_11_data_write_hit;
assign mem_out_11_d1	= mem_out_11_data_reg;

//////////////////////////////////////// mem_out_12 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_12_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_12_axi_data = 'h078; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_12_addr_reg = S_AXI_WDATA;  // mem_out_12_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_12_data_reg = S_AXI_WDATA;  // mem_out_12_DATA_COUNT
wire mem_out_12_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_12_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_12_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_12_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_12_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_12_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_12_ADDR_WIDTH-1:0] mem_out_12_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_12_addr_cnt <= 0;  
	end else if (mem_out_12_addr_write_hit) begin
		mem_out_12_addr_cnt <= mem_out_12_addr_reg; 
	end else if (mem_out_12_data_write_hit || mem_out_12_data_read_hit) begin
		mem_out_12_addr_cnt <= mem_out_12_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_12_addr1 = mem_out_12_addr_cnt[MEM_OUT_12_ADDR_WIDTH-1:0]; 
assign mem_out_12_ce1	= mem_out_12_data_write_hit || mem_out_12_data_read_hit;
assign mem_out_12_we1	= mem_out_12_data_write_hit;
assign mem_out_12_d1	= mem_out_12_data_reg;

//////////////////////////////////////// mem_out_13 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_13_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_13_axi_data = 'h07c; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_13_addr_reg = S_AXI_WDATA;  // mem_out_13_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_13_data_reg = S_AXI_WDATA;  // mem_out_13_DATA_COUNT
wire mem_out_13_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_13_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_13_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_13_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_13_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_13_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_13_ADDR_WIDTH-1:0] mem_out_13_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_13_addr_cnt <= 0;  
	end else if (mem_out_13_addr_write_hit) begin
		mem_out_13_addr_cnt <= mem_out_13_addr_reg; 
	end else if (mem_out_13_data_write_hit || mem_out_13_data_read_hit) begin
		mem_out_13_addr_cnt <= mem_out_13_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_13_addr1 = mem_out_13_addr_cnt[MEM_OUT_13_ADDR_WIDTH-1:0]; 
assign mem_out_13_ce1	= mem_out_13_data_write_hit || mem_out_13_data_read_hit;
assign mem_out_13_we1	= mem_out_13_data_write_hit;
assign mem_out_13_d1	= mem_out_13_data_reg;

//////////////////////////////////////// mem_out_14 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_14_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_14_axi_data = 'h080; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_14_addr_reg = S_AXI_WDATA;  // mem_out_14_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_14_data_reg = S_AXI_WDATA;  // mem_out_14_DATA_COUNT
wire mem_out_14_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_14_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_14_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_14_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_14_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_14_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_14_ADDR_WIDTH-1:0] mem_out_14_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_14_addr_cnt <= 0;  
	end else if (mem_out_14_addr_write_hit) begin
		mem_out_14_addr_cnt <= mem_out_14_addr_reg; 
	end else if (mem_out_14_data_write_hit || mem_out_14_data_read_hit) begin
		mem_out_14_addr_cnt <= mem_out_14_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_14_addr1 = mem_out_14_addr_cnt[MEM_OUT_14_ADDR_WIDTH-1:0]; 
assign mem_out_14_ce1	= mem_out_14_data_write_hit || mem_out_14_data_read_hit;
assign mem_out_14_we1	= mem_out_14_data_write_hit;
assign mem_out_14_d1	= mem_out_14_data_reg;

//////////////////////////////////////// mem_out_15 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_15_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_15_axi_data = 'h084; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_15_addr_reg = S_AXI_WDATA;  // mem_out_15_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_15_data_reg = S_AXI_WDATA;  // mem_out_15_DATA_COUNT
wire mem_out_15_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_15_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_15_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_15_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_15_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_15_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_15_ADDR_WIDTH-1:0] mem_out_15_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_15_addr_cnt <= 0;  
	end else if (mem_out_15_addr_write_hit) begin
		mem_out_15_addr_cnt <= mem_out_15_addr_reg; 
	end else if (mem_out_15_data_write_hit || mem_out_15_data_read_hit) begin
		mem_out_15_addr_cnt <= mem_out_15_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_15_addr1 = mem_out_15_addr_cnt[MEM_OUT_15_ADDR_WIDTH-1:0]; 
assign mem_out_15_ce1	= mem_out_15_data_write_hit || mem_out_15_data_read_hit;
assign mem_out_15_we1	= mem_out_15_data_write_hit;
assign mem_out_15_d1	= mem_out_15_data_reg;

//////////////////////////////////////// mem_out_16 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_16_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_16_axi_data = 'h088; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_16_addr_reg = S_AXI_WDATA;  // mem_out_16_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_16_data_reg = S_AXI_WDATA;  // mem_out_16_DATA_COUNT
wire mem_out_16_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_16_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_16_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_16_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_16_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_16_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);

// Address conunter to BRAM
reg	[MEM_OUT_16_ADDR_WIDTH-1:0] mem_out_16_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_16_addr_cnt <= 0;
	end else if (mem_out_16_addr_write_hit) begin
		mem_out_16_addr_cnt <= mem_out_16_addr_reg;
	end else if (mem_out_16_data_write_hit || mem_out_16_data_read_hit) begin
		mem_out_16_addr_cnt <= mem_out_16_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_16_addr1 = mem_out_16_addr_cnt[MEM_OUT_16_ADDR_WIDTH-1:0]; 
assign mem_out_16_ce1	= mem_out_16_data_write_hit || mem_out_16_data_read_hit;
assign mem_out_16_we1	= mem_out_16_data_write_hit;
assign mem_out_16_d1	= mem_out_16_data_reg;

//////////////////////////////////////// mem_out_17 ////////////////////////////////////////
// AXI4-Lite Read / Write Condition 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_17_axi_addr = 'h044; 
wire [C_S_AXI_ADDR_WIDTH-1:0]   mem_out_17_axi_data = 'h08c; 
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_17_addr_reg = S_AXI_WDATA;  // mem_out_17_ADDR_COUNT
wire [C_S_AXI_DATA_WIDTH-1:0]	mem_out_17_data_reg = S_AXI_WDATA;  // mem_out_17_DATA_COUNT
wire mem_out_17_addr_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_17_axi_addr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_17_data_write_hit = slv_reg_wren && (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_17_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);
wire mem_out_17_data_read_hit = slv_reg_rden && (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == mem_out_17_axi_data[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]);


// Address conunter to BRAM
reg	[MEM_OUT_17_ADDR_WIDTH-1:0] mem_out_17_addr_cnt;
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		mem_out_17_addr_cnt <= 0;  
	end else if (mem_out_17_addr_write_hit) begin
		mem_out_17_addr_cnt <= mem_out_17_addr_reg; 
	end else if (mem_out_17_data_write_hit || mem_out_17_data_read_hit) begin
		mem_out_17_addr_cnt <= mem_out_17_addr_cnt + 1;
	end
end

// Assgin Memory I/F
assign mem_out_17_addr1 = mem_out_17_addr_cnt[MEM_OUT_17_ADDR_WIDTH-1:0]; 
assign mem_out_17_ce1	= mem_out_17_data_write_hit || mem_out_17_data_read_hit;
assign mem_out_17_we1	= mem_out_17_data_write_hit;
assign mem_out_17_d1	= mem_out_17_data_reg;

// Implement write response logic generation
// The write response and response valid signals are asserted by the slave 
// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
// This marks the acceptance of address and indicates the status of 
// write transaction.

always @( posedge S_AXI_ACLK )
begin
	if ( S_AXI_ARESETN == 1'b0 )
	begin
		axi_bvalid  <= 0;
		axi_bresp   <= 2'b0;
	end 
	else
	begin    
		if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID)
		begin
			// indicates a valid write response is available
			axi_bvalid <= 1'b1;
			axi_bresp  <= 2'b0; // 'OKAY' response 
		end                   // work error responses in future
		else
		begin
			if (S_AXI_BREADY && axi_bvalid) 
			//check if bready is asserted while bvalid is high) 
			//(there is a possibility that bready is always asserted high)   
			begin
				axi_bvalid <= 1'b0; 
			end  
		end
	end
end   

// Implement axi_arready generation
// axi_arready is asserted for one S_AXI_ACLK clock cycle when
// S_AXI_ARVALID is asserted. axi_awready is 
// de-asserted when reset (active low) is asserted. 
// The read address is also latched when S_AXI_ARVALID is 
// asserted. axi_araddr is reset to zero on reset assertion.

always @( posedge S_AXI_ACLK )
begin
	if ( S_AXI_ARESETN == 1'b0 )
	begin
		axi_arready <= 1'b0;
		axi_araddr  <= 32'b0;
	end 
	else
	begin    
		if (~axi_arready && S_AXI_ARVALID)
		begin
			// indicates that the slave has acceped the valid read address
			axi_arready <= 1'b1;
			// Read address latching
			axi_araddr  <= S_AXI_ARADDR;
		end
		else
		begin
			axi_arready <= 1'b0;
		end
	end 
end       

// Implement axi_arvalid generation
// axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
// S_AXI_ARVALID and axi_arready are asserted. The slave registers 
// data are available on the axi_rdata bus at this instance. The 
// assertion of axi_rvalid marks the validity of read data on the 
// bus and axi_rresp indicates the status of read transaction.axi_rvalid 
// is deasserted on reset (active low). axi_rresp and axi_rdata are 
// cleared to zero on reset (active low).  
always @( posedge S_AXI_ACLK )
begin
	if ( S_AXI_ARESETN == 1'b0 )
	begin
		axi_rvalid <= 0;
		axi_rresp  <= 0;
	end 
	else
	begin    
		if (axi_arready && S_AXI_ARVALID && ~axi_rvalid)
		begin
			// Valid read data is available at the read data bus
			axi_rvalid <= 1'b1;
			axi_rresp  <= 2'b0; // 'OKAY' response
		end   
		else if (axi_rvalid && S_AXI_RREADY)
		begin
			// Read data is accepted by the master
			axi_rvalid <= 1'b0;
		end                
	end
end    

// (lab12) 
// Implement memory mapped register select and read logic generation
// Slave register read enable is asserted when valid address is available
// and the slave is ready to accept the read address.
assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
always @(*)
begin
		// Address decoding for reading registers
		case ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
		// Input Bram
		6'h00   : reg_data_out <= slv_reg_00;
		6'h01   : reg_data_out <= mem_in_0_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h02   : reg_data_out <= mem_in_1_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h03   : reg_data_out <= mem_in_2_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h04   : reg_data_out <= mem_in_3_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h05   : reg_data_out <= mem_in_4_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h06   : reg_data_out <= mem_in_5_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h07   : reg_data_out <= mem_in_6_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h08   : reg_data_out <= mem_in_7_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h09   : reg_data_out <= mem_in_8_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h0a   : reg_data_out <= mem_in_9_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h0b   : reg_data_out <= mem_in_10_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h0c   : reg_data_out <= mem_in_11_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h0d   : reg_data_out <= mem_in_12_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h0e   : reg_data_out <= mem_in_13_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h0f   : reg_data_out <= mem_in_14_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h10   : reg_data_out <= mem_in_15_q1[C_S_AXI_DATA_WIDTH-1:0];
		// Output Bram
		6'h11   : reg_data_out <= slv_reg_11;
		6'h12   : reg_data_out <= mem_out_0_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h13   : reg_data_out <= mem_out_1_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h14   : reg_data_out <= mem_out_2_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h15   : reg_data_out <= mem_out_3_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h16   : reg_data_out <= mem_out_4_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h17   : reg_data_out <= mem_out_5_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h18   : reg_data_out <= mem_out_6_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h19   : reg_data_out <= mem_out_7_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h1a   : reg_data_out <= mem_out_8_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h1b   : reg_data_out <= mem_out_9_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h1c   : reg_data_out <= mem_out_10_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h1d   : reg_data_out <= mem_out_11_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h1e   : reg_data_out <= mem_out_12_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h1f   : reg_data_out <= mem_out_13_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h20   : reg_data_out <= mem_out_14_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h21   : reg_data_out <= mem_out_15_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h22   : reg_data_out <= mem_out_16_q1[C_S_AXI_DATA_WIDTH-1:0];
		6'h23   : reg_data_out <= mem_out_17_q1[C_S_AXI_DATA_WIDTH-1:0];
		// State Signal
		6'h24   : reg_data_out <= slv_reg_24;
		6'h25   : reg_data_out <= slv_reg_25;
		6'h26   : reg_data_out <= slv_reg_26;
		endcase
end

// Output register or memory read data
always @( posedge S_AXI_ACLK )
begin
	if ( S_AXI_ARESETN == 1'b0 )
	begin
		axi_rdata  <= 0;
	end 
	else
	begin    
		// When there is a valid read address (S_AXI_ARVALID) with 
		// acceptance of read address by the slave (axi_arready), 
		// output the read dada 
		//if (slv_reg_rden)
		if (slv_reg_rden_d) // (lab12) 1 cycle delay, read valid from memory
		begin
			axi_rdata <= reg_data_out;     // register read data
		end   
	end
end    

endmodule
