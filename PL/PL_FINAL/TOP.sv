module TOP #
(
   // (lab10) Users to add parameters here
   parameter CNT_BIT = 31,

   // (lab13) Users to add parameters here
   parameter integer MEM_IN_0_DATA_WIDTH = 32,
   parameter integer MEM_IN_0_ADDR_WIDTH = 10,
   parameter integer MEM_IN_0_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_1_DATA_WIDTH = 32,
   parameter integer MEM_IN_1_ADDR_WIDTH = 10,
   parameter integer MEM_IN_1_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_2_DATA_WIDTH = 32,
   parameter integer MEM_IN_2_ADDR_WIDTH = 10,
   parameter integer MEM_IN_2_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_3_DATA_WIDTH = 32,
   parameter integer MEM_IN_3_ADDR_WIDTH = 10,
   parameter integer MEM_IN_3_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_4_DATA_WIDTH = 32,
   parameter integer MEM_IN_4_ADDR_WIDTH = 10,
   parameter integer MEM_IN_4_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_5_DATA_WIDTH = 32,
   parameter integer MEM_IN_5_ADDR_WIDTH = 10,
   parameter integer MEM_IN_5_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_6_DATA_WIDTH = 32,
   parameter integer MEM_IN_6_ADDR_WIDTH = 10,
   parameter integer MEM_IN_6_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_7_DATA_WIDTH = 32,
   parameter integer MEM_IN_7_ADDR_WIDTH = 10,
   parameter integer MEM_IN_7_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_8_DATA_WIDTH = 32,
   parameter integer MEM_IN_8_ADDR_WIDTH = 10,
   parameter integer MEM_IN_8_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_9_DATA_WIDTH = 32,
   parameter integer MEM_IN_9_ADDR_WIDTH = 10,
   parameter integer MEM_IN_9_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_10_DATA_WIDTH = 32,
   parameter integer MEM_IN_10_ADDR_WIDTH = 10,
   parameter integer MEM_IN_10_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_11_DATA_WIDTH = 32,
   parameter integer MEM_IN_11_ADDR_WIDTH = 10,
   parameter integer MEM_IN_11_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_12_DATA_WIDTH = 32,
   parameter integer MEM_IN_12_ADDR_WIDTH = 10,
   parameter integer MEM_IN_12_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_13_DATA_WIDTH = 32,
   parameter integer MEM_IN_13_ADDR_WIDTH = 10,
   parameter integer MEM_IN_13_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_14_DATA_WIDTH = 32,
   parameter integer MEM_IN_14_ADDR_WIDTH = 10,
   parameter integer MEM_IN_14_MEM_DEPTH  = 1024,
   parameter integer MEM_IN_15_DATA_WIDTH = 32,
   parameter integer MEM_IN_15_ADDR_WIDTH = 10,
   parameter integer MEM_IN_15_MEM_DEPTH  = 1024,

   // Output Bram
   parameter integer MEM_OUT_0_DATA_WIDTH = 32,
   parameter integer MEM_OUT_0_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_0_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_1_DATA_WIDTH = 32,
   parameter integer MEM_OUT_1_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_1_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_2_DATA_WIDTH = 32,
   parameter integer MEM_OUT_2_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_2_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_3_DATA_WIDTH = 32,
   parameter integer MEM_OUT_3_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_3_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_4_DATA_WIDTH = 32,
   parameter integer MEM_OUT_4_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_4_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_5_DATA_WIDTH = 32,
   parameter integer MEM_OUT_5_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_5_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_6_DATA_WIDTH = 32,
   parameter integer MEM_OUT_6_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_6_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_7_DATA_WIDTH = 32,
   parameter integer MEM_OUT_7_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_7_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_8_DATA_WIDTH = 32,
   parameter integer MEM_OUT_8_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_8_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_9_DATA_WIDTH = 32,
   parameter integer MEM_OUT_9_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_9_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_10_DATA_WIDTH = 32,
   parameter integer MEM_OUT_10_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_10_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_11_DATA_WIDTH = 32,
   parameter integer MEM_OUT_11_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_11_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_12_DATA_WIDTH = 32,
   parameter integer MEM_OUT_12_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_12_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_13_DATA_WIDTH = 32,
   parameter integer MEM_OUT_13_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_13_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_14_DATA_WIDTH = 32,
   parameter integer MEM_OUT_14_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_14_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_15_DATA_WIDTH = 32,
   parameter integer MEM_OUT_15_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_15_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_16_DATA_WIDTH = 32,
   parameter integer MEM_OUT_16_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_16_MEM_DEPTH  = 1024,
   parameter integer MEM_OUT_17_DATA_WIDTH = 32,
   parameter integer MEM_OUT_17_ADDR_WIDTH = 10,
   parameter integer MEM_OUT_17_MEM_DEPTH  = 1024,

   // User parameters ends
   // Do not modify the parameters beyond this line


   // Parameters of Axi Slave Bus Interface S00_AXI
   parameter integer C_S00_AXI_DATA_WIDTH   = 32,
   parameter integer C_S00_AXI_ADDR_WIDTH   = 9
)
(
   // Users to add ports here

   // User ports ends
   // Do not modify the ports beyond this line


   // Ports of Axi Slave Bus Interface S00_AXI
   input wire  s00_axi_aclk,
   input wire  s00_axi_aresetn,
   input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
   input wire [2 : 0] s00_axi_awprot,
   input wire  s00_axi_awvalid,
   output wire  s00_axi_awready,
   input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
   input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
   input wire  s00_axi_wvalid,
   output wire  s00_axi_wready,
   output wire [1 : 0] s00_axi_bresp,
   output wire  s00_axi_bvalid,
   input wire  s00_axi_bready,
   input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
   input wire [2 : 0] s00_axi_arprot,
   input wire  s00_axi_arvalid,
   output wire  s00_axi_arready,
   output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
   output wire [1 : 0] s00_axi_rresp,
   output wire  s00_axi_rvalid,
   input wire  s00_axi_rready,
    input [3:0] dp_switch,
    output [3:0] check_led
);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
wire [MEM_IN_0_ADDR_WIDTH-1:0]       mem_in_0_addr1;
wire                         mem_in_0_ce1;
wire                         mem_in_0_we1;
wire [MEM_IN_0_DATA_WIDTH-1:0]       mem_in_0_q1;
wire [MEM_IN_0_DATA_WIDTH-1:0]       mem_in_0_d1;

wire [MEM_IN_1_ADDR_WIDTH-1:0]       mem_in_1_addr1;
wire                         mem_in_1_ce1;
wire                         mem_in_1_we1;
wire [MEM_IN_1_DATA_WIDTH-1:0]      mem_in_1_q1;
wire [MEM_IN_1_DATA_WIDTH-1:0]       mem_in_1_d1;

wire [MEM_IN_2_ADDR_WIDTH-1:0]       mem_in_2_addr1;
wire                         mem_in_2_ce1;
wire                         mem_in_2_we1;
wire [MEM_IN_2_DATA_WIDTH-1:0]       mem_in_2_q1;
wire [MEM_IN_2_DATA_WIDTH-1:0]       mem_in_2_d1;

wire [MEM_IN_3_ADDR_WIDTH-1:0]       mem_in_3_addr1;
wire                         mem_in_3_ce1;
wire                         mem_in_3_we1;
wire [MEM_IN_3_DATA_WIDTH-1:0]      mem_in_3_q1;
wire [MEM_IN_3_DATA_WIDTH-1:0]       mem_in_3_d1;

wire [MEM_IN_4_ADDR_WIDTH-1:0]       mem_in_4_addr1;
wire                         mem_in_4_ce1;
wire                         mem_in_4_we1;
wire [MEM_IN_4_DATA_WIDTH-1:0]      mem_in_4_q1;
wire [MEM_IN_4_DATA_WIDTH-1:0]       mem_in_4_d1;

wire [MEM_IN_5_ADDR_WIDTH-1:0]       mem_in_5_addr1;
wire                         mem_in_5_ce1;
wire                         mem_in_5_we1;
wire [MEM_IN_5_DATA_WIDTH-1:0]      mem_in_5_q1;
wire [MEM_IN_5_DATA_WIDTH-1:0]       mem_in_5_d1;

wire [MEM_IN_6_ADDR_WIDTH-1:0]       mem_in_6_addr1;
wire                         mem_in_6_ce1;
wire                         mem_in_6_we1;
wire [MEM_IN_6_DATA_WIDTH-1:0]      mem_in_6_q1;
wire [MEM_IN_6_DATA_WIDTH-1:0]       mem_in_6_d1;

wire [MEM_IN_7_ADDR_WIDTH-1:0]       mem_in_7_addr1;
wire                         mem_in_7_ce1;
wire                         mem_in_7_we1;
wire [MEM_IN_7_DATA_WIDTH-1:0]      mem_in_7_q1;
wire [MEM_IN_7_DATA_WIDTH-1:0]       mem_in_7_d1;

wire [MEM_IN_8_ADDR_WIDTH-1:0]       mem_in_8_addr1;
wire                         mem_in_8_ce1;
wire                         mem_in_8_we1;
wire [MEM_IN_8_DATA_WIDTH-1:0]      mem_in_8_q1;
wire [MEM_IN_8_DATA_WIDTH-1:0]       mem_in_8_d1;

wire [MEM_IN_9_ADDR_WIDTH-1:0]       mem_in_9_addr1;
wire                         mem_in_9_ce1;
wire                         mem_in_9_we1;
wire [MEM_IN_9_DATA_WIDTH-1:0]      mem_in_9_q1;
wire [MEM_IN_9_DATA_WIDTH-1:0]       mem_in_9_d1;

wire [MEM_IN_10_ADDR_WIDTH-1:0]    mem_in_10_addr1;
wire                         mem_in_10_ce1;
wire                         mem_in_10_we1;
wire [MEM_IN_10_DATA_WIDTH-1:0]     mem_in_10_q1;
wire [MEM_IN_10_DATA_WIDTH-1:0]    mem_in_10_d1;

wire [MEM_IN_11_ADDR_WIDTH-1:0]    mem_in_11_addr1;
wire                         mem_in_11_ce1;
wire                         mem_in_11_we1;
wire [MEM_IN_11_DATA_WIDTH-1:0]     mem_in_11_q1;
wire [MEM_IN_11_DATA_WIDTH-1:0]    mem_in_11_d1;

wire [MEM_IN_12_ADDR_WIDTH-1:0]    mem_in_12_addr1;
wire                         mem_in_12_ce1;
wire                         mem_in_12_we1;
wire [MEM_IN_12_DATA_WIDTH-1:0]     mem_in_12_q1;
wire [MEM_IN_12_DATA_WIDTH-1:0]    mem_in_12_d1;

wire [MEM_IN_13_ADDR_WIDTH-1:0]    mem_in_13_addr1;
wire                         mem_in_13_ce1;
wire                         mem_in_13_we1;
wire [MEM_IN_13_DATA_WIDTH-1:0]     mem_in_13_q1;
wire [MEM_IN_13_DATA_WIDTH-1:0]    mem_in_13_d1;

wire [MEM_IN_14_ADDR_WIDTH-1:0]    mem_in_14_addr1;
wire                         mem_in_14_ce1;
wire                         mem_in_14_we1;
wire [MEM_IN_14_DATA_WIDTH-1:0]     mem_in_14_q1;
wire [MEM_IN_14_DATA_WIDTH-1:0]    mem_in_14_d1;

wire [MEM_IN_15_ADDR_WIDTH-1:0]    mem_in_15_addr1;
wire                         mem_in_15_ce1;
wire                         mem_in_15_we1;
wire [MEM_IN_15_DATA_WIDTH-1:0]    mem_in_15_q1;
wire [MEM_IN_15_DATA_WIDTH-1:0]    mem_in_15_d1;

// Output Bram
wire [MEM_OUT_0_ADDR_WIDTH-1:0]    mem_out_0_addr1;
wire                         mem_out_0_ce1;
wire                         mem_out_0_we1;
wire [MEM_OUT_0_DATA_WIDTH-1:0]    mem_out_0_q1;
wire [MEM_OUT_0_DATA_WIDTH-1:0]    mem_out_0_d1;

wire [MEM_OUT_1_ADDR_WIDTH-1:0]    mem_out_1_addr1;
wire                         mem_out_1_ce1;
wire                         mem_out_1_we1;
wire [MEM_OUT_1_DATA_WIDTH-1:0]    mem_out_1_q1;
wire [MEM_OUT_1_DATA_WIDTH-1:0]    mem_out_1_d1;

wire [MEM_OUT_2_ADDR_WIDTH-1:0]    mem_out_2_addr1;
wire                         mem_out_2_ce1;
wire                         mem_out_2_we1;
wire [MEM_OUT_2_DATA_WIDTH-1:0]    mem_out_2_q1;
wire [MEM_OUT_2_DATA_WIDTH-1:0]    mem_out_2_d1;

wire [MEM_OUT_3_ADDR_WIDTH-1:0]    mem_out_3_addr1;
wire                         mem_out_3_ce1;
wire                         mem_out_3_we1;
wire [MEM_OUT_3_DATA_WIDTH-1:0]    mem_out_3_q1;
wire [MEM_OUT_3_DATA_WIDTH-1:0]    mem_out_3_d1;

wire [MEM_OUT_4_ADDR_WIDTH-1:0]    mem_out_4_addr1;
wire                         mem_out_4_ce1;
wire                         mem_out_4_we1;
wire [MEM_OUT_4_DATA_WIDTH-1:0]    mem_out_4_q1;
wire [MEM_OUT_4_DATA_WIDTH-1:0]    mem_out_4_d1;

wire [MEM_OUT_5_ADDR_WIDTH-1:0]    mem_out_5_addr1;
wire                         mem_out_5_ce1;
wire                         mem_out_5_we1;
wire [MEM_OUT_5_DATA_WIDTH-1:0]    mem_out_5_q1;
wire [MEM_OUT_5_DATA_WIDTH-1:0]    mem_out_5_d1;

wire [MEM_OUT_6_ADDR_WIDTH-1:0]    mem_out_6_addr1;
wire                         mem_out_6_ce1;
wire                         mem_out_6_we1;
wire [MEM_OUT_6_DATA_WIDTH-1:0]    mem_out_6_q1;
wire [MEM_OUT_6_DATA_WIDTH-1:0]    mem_out_6_d1;

wire [MEM_OUT_7_ADDR_WIDTH-1:0]    mem_out_7_addr1;
wire                         mem_out_7_ce1;
wire                         mem_out_7_we1;
wire [MEM_OUT_7_DATA_WIDTH-1:0]    mem_out_7_q1;
wire [MEM_OUT_7_DATA_WIDTH-1:0]    mem_out_7_d1;

wire [MEM_OUT_8_ADDR_WIDTH-1:0]    mem_out_8_addr1;
wire                         mem_out_8_ce1;
wire                         mem_out_8_we1;
wire [MEM_OUT_8_DATA_WIDTH-1:0]    mem_out_8_q1;
wire [MEM_OUT_8_DATA_WIDTH-1:0]    mem_out_8_d1;

wire [MEM_OUT_9_ADDR_WIDTH-1:0]    mem_out_9_addr1;
wire                         mem_out_9_ce1;
wire                         mem_out_9_we1;
wire [MEM_OUT_9_DATA_WIDTH-1:0]    mem_out_9_q1;
wire [MEM_OUT_9_DATA_WIDTH-1:0]    mem_out_9_d1;

wire [MEM_OUT_10_ADDR_WIDTH-1:0]    mem_out_10_addr1;
wire                         mem_out_10_ce1;
wire                         mem_out_10_we1;
wire [MEM_OUT_10_DATA_WIDTH-1:0]    mem_out_10_q1;
wire [MEM_OUT_10_DATA_WIDTH-1:0]    mem_out_10_d1;

wire [MEM_OUT_11_ADDR_WIDTH-1:0]    mem_out_11_addr1;
wire                         mem_out_11_ce1;
wire                         mem_out_11_we1;
wire [MEM_OUT_11_DATA_WIDTH-1:0]    mem_out_11_q1;
wire [MEM_OUT_11_DATA_WIDTH-1:0]    mem_out_11_d1;

wire [MEM_OUT_12_ADDR_WIDTH-1:0]    mem_out_12_addr1;
wire                         mem_out_12_ce1;
wire                         mem_out_12_we1;
wire [MEM_OUT_12_DATA_WIDTH-1:0]    mem_out_12_q1;
wire [MEM_OUT_12_DATA_WIDTH-1:0]    mem_out_12_d1;

wire [MEM_OUT_13_ADDR_WIDTH-1:0]    mem_out_13_addr1;
wire                         mem_out_13_ce1;
wire                         mem_out_13_we1;
wire [MEM_OUT_13_DATA_WIDTH-1:0]    mem_out_13_q1;
wire [MEM_OUT_13_DATA_WIDTH-1:0]    mem_out_13_d1;

wire [MEM_OUT_14_ADDR_WIDTH-1:0]    mem_out_14_addr1;
wire                         mem_out_14_ce1;
wire                         mem_out_14_we1;
wire [MEM_OUT_14_DATA_WIDTH-1:0]    mem_out_14_q1;
wire [MEM_OUT_14_DATA_WIDTH-1:0]    mem_out_14_d1;

wire [MEM_OUT_15_ADDR_WIDTH-1:0]    mem_out_15_addr1;
wire                         mem_out_15_ce1;
wire                         mem_out_15_we1;
wire [MEM_OUT_15_DATA_WIDTH-1:0]    mem_out_15_q1;
wire [MEM_OUT_15_DATA_WIDTH-1:0]    mem_out_15_d1;

wire [MEM_OUT_16_ADDR_WIDTH-1:0]    mem_out_16_addr1;
wire                         mem_out_16_ce1;
wire                         mem_out_16_we1;
wire [MEM_OUT_16_DATA_WIDTH-1:0]    mem_out_16_q1;
wire [MEM_OUT_16_DATA_WIDTH-1:0]    mem_out_16_d1;

wire [MEM_OUT_17_ADDR_WIDTH-1:0]    mem_out_17_addr1;
wire                         mem_out_17_ce1;
wire                         mem_out_17_we1;
wire [MEM_OUT_17_DATA_WIDTH-1:0]    mem_out_17_q1;
wire [MEM_OUT_17_DATA_WIDTH-1:0]    mem_out_17_d1;

wire [C_S00_AXI_DATA_WIDTH-1:0]      fsm_status_reg_in;  // Write Status to PL
wire [C_S00_AXI_DATA_WIDTH-1:0]      fsm_status_reg_out; // Read Status from PS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
wire OB_CE0,OB_CE1,OB_CE2,OB_CE3,OB_CE4; //?   ?
wire OB_WE0,OB_WE1,OB_WE2,OB_WE3,OB_WE4; //?   ?
wire [9:0] OB_ADDR;  //?   ?
wire [31:0] OB_D[3:0]; //0,1,2,3?? pe_array output ?   ?  결해 ??   layer1?   ? ? 4 ?

wire IB_CE,IB_WE; //?   ?
wire [9:0] IB_ADDR; //?   ?
// wire [31:0] IB_D [15:0];  0?   ? ?  ?   ?
wire EN_W,EN_I;
wire [31:0] PE_INPUT_DATA[15:0];
wire [6:0] STATE_IN; // PS to PL
wire [6:0] STATE_OUT; // PL to PS
assign STATE_IN = fsm_status_reg_out[6:0];
assign fsm_status_reg_in = {{(C_S00_AXI_DATA_WIDTH-7){1'b0}}, STATE_OUT};

//wire [31:0] OB_Q0,OB_Q1,OB_Q2,OB_Q3,OB_Q4;// ?  ?  ?  ?  
wire [31:0] IB_Q[15:0]; //INPUT BRAM OUTPUT
wire [31:0] PE_OUT[3:0];

///////////////////////////////INPUT_BRAM?  WIRE ?  줄것//////////////
wire [31:0] q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15; //INPUT BRAM ?  ?  ?    ??  ?   ? ?  거 ??  ? ?  쳐서 511:?   ? 보내?   ?  ?   ?
wire [31:0] OUT1,OUT2,OUT3,OUT4;
wire [31:0] OUT_IS;
wire [511:0] In_i;

wire [31:0] q_in[15:0];
assign q_in[0]= q0;
assign q_in[1]= q1;
assign q_in[2]= q2;
assign q_in[3]= q3;
assign q_in[4]= q4;
assign q_in[5]= q5;
assign q_in[6]= q6;
assign q_in[7]= q7;
assign q_in[8]= q8;
assign q_in[9]= q9;
assign q_in[10]= q10;
assign q_in[11]= q11;
assign q_in[12]= q12;
assign q_in[13]= q13;
assign q_in[14]= q14;
assign q_in[15]= q15;

assign In_i = {PE_INPUT_DATA[0],PE_INPUT_DATA[1],PE_INPUT_DATA[2],PE_INPUT_DATA[3],PE_INPUT_DATA[4],PE_INPUT_DATA[5],PE_INPUT_DATA[6],PE_INPUT_DATA[7],PE_INPUT_DATA[8],PE_INPUT_DATA[9],PE_INPUT_DATA[10],PE_INPUT_DATA[11],PE_INPUT_DATA[12],PE_INPUT_DATA[13],PE_INPUT_DATA[14],PE_INPUT_DATA[15]};
assign PE_OUT[0] = (STATE_OUT <= 85)? OUT1: OUT_IS;
assign PE_OUT[1] = OUT2;
assign PE_OUT[2] = OUT3;
assign PE_OUT[3] = OUT4;

assign clk_is_enable = (STATE_OUT > 85);
assign clk_ws_enable = (STATE_OUT <= 85);


datapathUnit DATAPATH_UNIT (
    .CLK          (s00_axi_aclk), // ?  ?  ?   메인 ?  ?   ?  ?  
    .clk_ws_enable(clk_ws_enable), // Enable ?  ?   추 ?
    .RSTN         (s00_axi_aresetn),
    .In_i         (In_i),
    .enW_i        (EN_W),
    .enI_i        (EN_I),
    .out_fin_1    (OUT1),
    .out_fin_2    (OUT2),
    .out_fin_3    (OUT3),
    .out_fin_4    (OUT4)
);


datapathUnit_IS DATAPATH_UNIT_IS (
    .IS_CLK          (s00_axi_aclk), // ?  ?  ?   메인 ?  ?   ?  ?  
    .IS_clk_is_enable(clk_is_enable), // Enable ?  ?   추 ?
    .IS_RSTN         (s00_axi_aresetn),
    .IS_enW_i        (EN_W),
    .IS_enI_i        (EN_I),
    .IS_In_i         (In_i),   
    .IS_out          (OUT_IS)
);


BRAM_CONTROLLER BRAM_CONTROLLER (/*AUTOINST*/
    // Outputs
    .OB_CE0      (OB_CE0), //OUTPUT_BRAM enable
    .OB_CE1      (OB_CE1), //OUTPUT_BRAM enable
    .OB_CE2      (OB_CE2), //OUTPUT_BRAM enable
    .OB_CE3      (OB_CE3), //OUTPUT_BRAM enable
    .OB_CE4      (OB_CE4), //OUTPUT_BRAM enable
    .OB_WE0      (OB_WE0), //OUTPUT_BRAM WRITE ENABLE
    .OB_WE1      (OB_WE1), //OUTPUT_BRAM WRITE ENABLE
    .OB_WE2      (OB_WE2), //OUTPUT_BRAM WRITE ENABLE
    .OB_WE3      (OB_WE3), //OUTPUT_BRAM WRITE ENABLE
    .OB_WE4      (OB_WE4), //OUTPUT_BRAM WRITE ENABLE
    .OB_ADDR      (OB_ADDR), //OUTPUT_BRAM ADDRESS?   ?  결해 ?  OUTPUT BRAM 0,1,2,3
    .OB_D      (OB_D),// OB_D0[0]?? PE_OUT[0],OB_D0[1]?? PE_OUT[1],OB_D0[2]?? PE_OUT[2],OB_D0[3]?? PE_OUT[3]
    //.OB_D1      (OB_D1),// OB_D1[0]?? PE_OUT[0],OB_D1[1]?? PE_OUT[1],OB_D1[2]?? PE_OUT[2],OB_D1[3]?? PE_OUT[3]
    //.OB_D2      (OB_D2),// ?  ?   ?  ?  
    //.OB_D3      (OB_D3),//
    //.OB_D4      (OB_D4),// 마 ? ? ?  ?  ?  ?   40비트?   ? ? 32비트?   ???  ?   ? ?  ??8비트 ???  ?   1개따 ?
    .IB_CE      (IB_CE), //CE?    ? INPUT_BRAM ce0?   ?   ?
    .IB_WE      (IB_WE), //WE?    ? INPUT_BRAM ce0?   ?   ?
    .IB_ADDR      (IB_ADDR), ////  ? INPUT_BRAM CE0?   ?   ?
    .IB_D      (), //
    .EN_W      (EN_W),
    .EN_I      (EN_I),
    .PE_INPUT_DATA (PE_INPUT_DATA),
    .STATE_OUT      (STATE_OUT),
    // Inputs
    .CLK      (s00_axi_aclk),
    .RSTN      (s00_axi_aresetn),
    .STATE_IN   (STATE_IN),
    .OB_Q0      (),
    .OB_Q1      (),
    .OB_Q2      (),
    .OB_Q3      (),
    .OB_Q4      (),
    .IB_Q       (q_in),
    .PE_OUT      (PE_OUT),
    .dp_switch     (dp_switch),
    .check_led_1   (check_led[0]),
    .check_led_2   (check_led[1]),
    .check_led_3   (check_led[2]),
    .check_led_4   (check_led[3])
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_0_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_0_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_0_MEM_DEPTH)
) u_mem_in_0 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q0), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_0_addr1), 
    .ce1        (mem_in_0_ce1), 
    .we1        (mem_in_0_we1),
    .q1         (mem_in_0_q1), 
    .d1         (mem_in_0_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_1_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_1_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_1_MEM_DEPTH)
) u_mem_in_1 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q1), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_1_addr1), 
    .ce1        (mem_in_1_ce1), 
    .we1        (mem_in_1_we1),
    .q1         (mem_in_1_q1), 
    .d1         (mem_in_1_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_2_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_2_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_2_MEM_DEPTH)
) u_mem_in_2 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q2), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_2_addr1), 
    .ce1        (mem_in_2_ce1), 
    .we1        (mem_in_2_we1),
    .q1         (mem_in_2_q1), 
    .d1         (mem_in_2_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_3_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_3_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_3_MEM_DEPTH)
) u_mem_in_3 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q3), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_3_addr1), 
    .ce1        (mem_in_3_ce1), 
    .we1        (mem_in_3_we1),
    .q1         (mem_in_3_q1), 
    .d1         (mem_in_3_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_4_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_4_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_4_MEM_DEPTH)
) u_mem_in_4 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q4), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_4_addr1), 
    .ce1        (mem_in_4_ce1), 
    .we1        (mem_in_4_we1),
    .q1         (mem_in_4_q1), 
    .d1         (mem_in_4_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_5_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_5_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_5_MEM_DEPTH)
) u_mem_in_5 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q5), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_5_addr1), 
    .ce1        (mem_in_5_ce1), 
    .we1        (mem_in_5_we1),
    .q1         (mem_in_5_q1), 
    .d1         (mem_in_5_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_6_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_6_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_6_MEM_DEPTH)
) u_mem_in_6 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q6), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_6_addr1), 
    .ce1        (mem_in_6_ce1), 
    .we1        (mem_in_6_we1),
    .q1         (mem_in_6_q1), 
    .d1         (mem_in_6_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_7_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_7_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_7_MEM_DEPTH)
) u_mem_in_7 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q7), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_7_addr1), 
    .ce1        (mem_in_7_ce1), 
    .we1        (mem_in_7_we1),
    .q1         (mem_in_7_q1), 
    .d1         (mem_in_7_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_8_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_8_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_8_MEM_DEPTH)
) u_mem_in_8 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q8), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_8_addr1), 
    .ce1        (mem_in_8_ce1), 
    .we1        (mem_in_8_we1),
    .q1         (mem_in_8_q1), 
    .d1         (mem_in_8_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_9_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_9_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_9_MEM_DEPTH)
) u_mem_in_9 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q9), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_9_addr1), 
    .ce1        (mem_in_9_ce1), 
    .we1        (mem_in_9_we1),
    .q1         (mem_in_9_q1), 
    .d1         (mem_in_9_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_10_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_10_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_10_MEM_DEPTH)
) u_mem_in_10 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q10), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_10_addr1), 
    .ce1        (mem_in_10_ce1), 
    .we1        (mem_in_10_we1),
    .q1         (mem_in_10_q1), 
    .d1         (mem_in_10_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_11_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_11_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_11_MEM_DEPTH)
) u_mem_in_11 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q11), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_11_addr1), 
    .ce1        (mem_in_11_ce1), 
    .we1        (mem_in_11_we1),
    .q1         (mem_in_11_q1), 
    .d1         (mem_in_11_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_12_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_12_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_12_MEM_DEPTH)
) u_mem_in_12 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q12), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_12_addr1), 
    .ce1        (mem_in_12_ce1), 
    .we1        (mem_in_12_we1),
    .q1         (mem_in_12_q1), 
    .d1         (mem_in_12_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_13_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_13_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_13_MEM_DEPTH)
) u_mem_in_13 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q13), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_13_addr1), 
    .ce1        (mem_in_13_ce1), 
    .we1        (mem_in_13_we1),
    .q1         (mem_in_13_q1), 
    .d1         (mem_in_13_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_14_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_14_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_14_MEM_DEPTH)
) u_mem_in_14 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q14), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_14_addr1), 
    .ce1        (mem_in_14_ce1), 
    .we1        (mem_in_14_we1),
    .q1         (mem_in_14_q1), 
    .d1         (mem_in_14_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_IN_15_DATA_WIDTH), 
    .AWIDTH   (MEM_IN_15_ADDR_WIDTH), 
    .MEM_SIZE (MEM_IN_15_MEM_DEPTH)
) u_mem_in_15 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (IB_ADDR), 
    .ce0        (IB_CE), 
    .we0        (IB_WE), 
    .q0         (q15), 
    .d0         (), 
    // Bram for PS
    .addr1      (mem_in_15_addr1), 
    .ce1        (mem_in_15_ce1), 
    .we1        (mem_in_15_we1),
    .q1         (mem_in_15_q1), 
    .d1         (mem_in_15_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_0_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_0_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_0_MEM_DEPTH)
    ) u_mem_out_0 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE0), 
    .we0        (OB_WE0), 
    .q0         (), 
    .d0         (OB_D[0]), 
    // Bram for PS
    .addr1      (mem_out_0_addr1), 
    .ce1        (mem_out_0_ce1), 
    .we1        (mem_out_0_we1),
    .q1         (mem_out_0_q1), 
    .d1         (mem_out_0_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_1_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_1_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_1_MEM_DEPTH)
    ) u_mem_out_1 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE0), 
    .we0        (OB_WE0), 
    .q0         (), 
    .d0         (OB_D[1]), 
    // Bram for PS
    .addr1      (mem_out_1_addr1), 
    .ce1        (mem_out_1_ce1), 
    .we1        (mem_out_1_we1),
    .q1         (mem_out_1_q1), 
    .d1         (mem_out_1_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_2_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_2_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_2_MEM_DEPTH)
    ) u_mem_out_2 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE0), 
    .we0        (OB_WE0), 
    .q0         (), 
    .d0         (OB_D[2]), 
    // Bram for PS
    .addr1      (mem_out_2_addr1), 
    .ce1        (mem_out_2_ce1), 
    .we1        (mem_out_2_we1),
    .q1         (mem_out_2_q1), 
    .d1         (mem_out_2_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_3_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_3_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_3_MEM_DEPTH)
    ) u_mem_out_3 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE0), 
    .we0        (OB_WE0), 
    .q0         (), 
    .d0         (OB_D[3]), 
    // Bram for PS
    .addr1      (mem_out_3_addr1), 
    .ce1        (mem_out_3_ce1), 
    .we1        (mem_out_3_we1),
    .q1         (mem_out_3_q1), 
    .d1         (mem_out_3_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_4_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_4_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_4_MEM_DEPTH)
    ) u_mem_out_4 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE1), 
    .we0        (OB_WE1), 
    .q0         (), 
    .d0         (OB_D[0]), 
    // Bram for PS
    .addr1      (mem_out_4_addr1), 
    .ce1        (mem_out_4_ce1), 
    .we1        (mem_out_4_we1),
    .q1         (mem_out_4_q1), 
    .d1         (mem_out_4_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_5_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_5_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_5_MEM_DEPTH)
    ) u_mem_out_5 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE1), 
    .we0        (OB_WE1), 
    .q0         (), 
    .d0         (OB_D[1]), 
    // Bram for PS
    .addr1      (mem_out_5_addr1), 
    .ce1        (mem_out_5_ce1), 
    .we1        (mem_out_5_we1),
    .q1         (mem_out_5_q1), 
    .d1         (mem_out_5_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_6_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_6_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_6_MEM_DEPTH)
    ) u_mem_out_6 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE1), 
    .we0        (OB_WE1), 
    .q0         (), 
    .d0         (OB_D[2]), 
    // Bram for PS
    .addr1      (mem_out_6_addr1), 
    .ce1        (mem_out_6_ce1), 
    .we1        (mem_out_6_we1),
    .q1         (mem_out_6_q1), 
    .d1         (mem_out_6_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_7_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_7_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_7_MEM_DEPTH)
    ) u_mem_out_7 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE1), 
    .we0        (OB_WE1), 
    .q0         (), 
    .d0         (OB_D[3]), 
    // Bram for PS
    .addr1      (mem_out_7_addr1), 
    .ce1        (mem_out_7_ce1), 
    .we1        (mem_out_7_we1),
    .q1         (mem_out_7_q1), 
    .d1         (mem_out_7_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_8_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_8_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_8_MEM_DEPTH)
    ) u_mem_out_8 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE2), 
    .we0        (OB_WE2), 
    .q0         (), 
    .d0         (OB_D[0]), 
    // Bram for PS
    .addr1      (mem_out_8_addr1), 
    .ce1        (mem_out_8_ce1), 
    .we1        (mem_out_8_we1),
    .q1         (mem_out_8_q1), 
    .d1         (mem_out_8_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_9_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_9_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_9_MEM_DEPTH)
    ) u_mem_out_9 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE2), 
    .we0        (OB_WE2), 
    .q0         (), 
    .d0         (OB_D[1]), 
    // Bram for PS
    .addr1      (mem_out_9_addr1), 
    .ce1        (mem_out_9_ce1), 
    .we1        (mem_out_9_we1),
    .q1         (mem_out_9_q1), 
    .d1         (mem_out_9_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_10_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_10_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_10_MEM_DEPTH)
    ) u_mem_out_10 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE2), 
    .we0        (OB_WE2), 
    .q0         (), 
    .d0         (OB_D[2]), 
    // Bram for PS
    .addr1      (mem_out_10_addr1), 
    .ce1        (mem_out_10_ce1), 
    .we1        (mem_out_10_we1),
    .q1         (mem_out_10_q1), 
    .d1         (mem_out_10_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_11_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_11_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_11_MEM_DEPTH)
    ) u_mem_out_11 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE2), 
    .we0        (OB_WE2), 
    .q0         (), 
    .d0         (OB_D[3]), 
    // Bram for PS
    .addr1      (mem_out_11_addr1), 
    .ce1        (mem_out_11_ce1), 
    .we1        (mem_out_11_we1),
    .q1         (mem_out_11_q1), 
    .d1         (mem_out_11_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_12_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_12_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_12_MEM_DEPTH)
    ) u_mem_out_12 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE3), 
    .we0        (OB_WE3), 
    .q0         (), 
    .d0         (OB_D[0]), 
    // Bram for PS
    .addr1      (mem_out_12_addr1), 
    .ce1        (mem_out_12_ce1), 
    .we1        (mem_out_12_we1),
    .q1         (mem_out_12_q1), 
    .d1         (mem_out_12_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_13_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_13_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_13_MEM_DEPTH)
    ) u_mem_out_13 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE3), 
    .we0        (OB_WE3), 
    .q0         (), 
    .d0         (OB_D[1]), 
    // Bram for PS
    .addr1      (mem_out_13_addr1), 
    .ce1        (mem_out_13_ce1), 
    .we1        (mem_out_13_we1),
    .q1         (mem_out_13_q1), 
    .d1         (mem_out_13_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_14_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_14_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_14_MEM_DEPTH)
    ) u_mem_out_14 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE3), 
    .we0        (OB_WE3), 
    .q0         (), 
    .d0         (OB_D[2]), 
    // Bram for PS
    .addr1      (mem_out_14_addr1), 
    .ce1        (mem_out_14_ce1), 
    .we1        (mem_out_14_we1),
    .q1         (mem_out_14_q1), 
    .d1         (mem_out_14_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_15_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_15_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_15_MEM_DEPTH)
    ) u_mem_out_15 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE3), 
    .we0        (OB_WE3), 
    .q0         (), 
    .d0         (OB_D[3]), 
    // Bram for PS
    .addr1      (mem_out_15_addr1), 
    .ce1        (mem_out_15_ce1), 
    .we1        (mem_out_15_we1),
    .q1         (mem_out_15_q1), 
    .d1         (mem_out_15_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_16_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_16_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_16_MEM_DEPTH)
    ) u_mem_out_16 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE4), 
    .we0        (OB_WE4), 
    .q0         (), 
    .d0         (OB_D[0]), 
    // Bram for PS
    .addr1      (mem_out_16_addr1), 
    .ce1        (mem_out_16_ce1), 
    .we1        (mem_out_16_we1),
    .q1         (mem_out_16_q1), 
    .d1         (mem_out_16_d1)
);

true_sync_dpbram # (
    .DWIDTH   (MEM_OUT_17_DATA_WIDTH), 
    .AWIDTH   (MEM_OUT_17_ADDR_WIDTH), 
    .MEM_SIZE (MEM_OUT_17_MEM_DEPTH)
    ) u_mem_out_17 (
    .clk        (s00_axi_aclk), 
    // Bram for PL
    .addr0      (OB_ADDR), 
    .ce0        (OB_CE4), 
    .we0        (OB_WE4), 
    .q0         (), 
    .d0         (OB_D[1]), 
    // Bram for PS
    .addr1      (mem_out_17_addr1), 
    .ce1        (mem_out_17_ce1), 
    .we1        (mem_out_17_we1),
    .q1         (mem_out_17_q1), 
    .d1         (mem_out_17_d1)
);

// Instantiation of Axi Bus Interface S00_AXI
myip_v1_0 # ( 
    .CNT_BIT(CNT_BIT),
    
    .MEM_IN_0_DATA_WIDTH(MEM_IN_0_DATA_WIDTH),
    .MEM_IN_0_ADDR_WIDTH(MEM_IN_0_ADDR_WIDTH),
    .MEM_IN_1_DATA_WIDTH(MEM_IN_1_DATA_WIDTH),
    .MEM_IN_1_ADDR_WIDTH(MEM_IN_1_ADDR_WIDTH),
    .MEM_IN_2_DATA_WIDTH(MEM_IN_2_DATA_WIDTH),
    .MEM_IN_2_ADDR_WIDTH(MEM_IN_2_ADDR_WIDTH),
    .MEM_IN_3_DATA_WIDTH(MEM_IN_3_DATA_WIDTH),
    .MEM_IN_3_ADDR_WIDTH(MEM_IN_3_ADDR_WIDTH),
    .MEM_IN_4_DATA_WIDTH(MEM_IN_4_DATA_WIDTH),
    .MEM_IN_4_ADDR_WIDTH(MEM_IN_4_ADDR_WIDTH),
    .MEM_IN_5_DATA_WIDTH(MEM_IN_5_DATA_WIDTH),
    .MEM_IN_5_ADDR_WIDTH(MEM_IN_5_ADDR_WIDTH),
    .MEM_IN_6_DATA_WIDTH(MEM_IN_6_DATA_WIDTH),
    .MEM_IN_6_ADDR_WIDTH(MEM_IN_6_ADDR_WIDTH),
    .MEM_IN_7_DATA_WIDTH(MEM_IN_7_DATA_WIDTH),
    .MEM_IN_7_ADDR_WIDTH(MEM_IN_7_ADDR_WIDTH),
    .MEM_IN_8_DATA_WIDTH(MEM_IN_8_DATA_WIDTH),
    .MEM_IN_8_ADDR_WIDTH(MEM_IN_8_ADDR_WIDTH),
    .MEM_IN_9_DATA_WIDTH(MEM_IN_9_DATA_WIDTH),
    .MEM_IN_9_ADDR_WIDTH(MEM_IN_9_ADDR_WIDTH),
    .MEM_IN_10_DATA_WIDTH(MEM_IN_10_DATA_WIDTH),
    .MEM_IN_10_ADDR_WIDTH(MEM_IN_10_ADDR_WIDTH),
    .MEM_IN_11_DATA_WIDTH(MEM_IN_11_DATA_WIDTH),
    .MEM_IN_11_ADDR_WIDTH(MEM_IN_11_ADDR_WIDTH),
    .MEM_IN_12_DATA_WIDTH(MEM_IN_12_DATA_WIDTH),
    .MEM_IN_12_ADDR_WIDTH(MEM_IN_12_ADDR_WIDTH),
    .MEM_IN_13_DATA_WIDTH(MEM_IN_13_DATA_WIDTH),
    .MEM_IN_13_ADDR_WIDTH(MEM_IN_13_ADDR_WIDTH),
    .MEM_IN_14_DATA_WIDTH(MEM_IN_14_DATA_WIDTH),
    .MEM_IN_14_ADDR_WIDTH(MEM_IN_14_ADDR_WIDTH),
    .MEM_IN_15_DATA_WIDTH(MEM_IN_15_DATA_WIDTH),
    .MEM_IN_15_ADDR_WIDTH(MEM_IN_15_ADDR_WIDTH),

    .MEM_OUT_0_DATA_WIDTH(MEM_OUT_0_DATA_WIDTH),
    .MEM_OUT_0_ADDR_WIDTH(MEM_OUT_0_ADDR_WIDTH),
    .MEM_OUT_1_DATA_WIDTH(MEM_OUT_1_DATA_WIDTH),
    .MEM_OUT_1_ADDR_WIDTH(MEM_OUT_1_ADDR_WIDTH),
    .MEM_OUT_2_DATA_WIDTH(MEM_OUT_2_DATA_WIDTH),
    .MEM_OUT_2_ADDR_WIDTH(MEM_OUT_2_ADDR_WIDTH),
    .MEM_OUT_3_DATA_WIDTH(MEM_OUT_3_DATA_WIDTH),
    .MEM_OUT_3_ADDR_WIDTH(MEM_OUT_3_ADDR_WIDTH),
    .MEM_OUT_4_DATA_WIDTH(MEM_OUT_4_DATA_WIDTH),
    .MEM_OUT_4_ADDR_WIDTH(MEM_OUT_4_ADDR_WIDTH),
    .MEM_OUT_5_DATA_WIDTH(MEM_OUT_5_DATA_WIDTH),
    .MEM_OUT_5_ADDR_WIDTH(MEM_OUT_5_ADDR_WIDTH),
    .MEM_OUT_6_DATA_WIDTH(MEM_OUT_6_DATA_WIDTH),
    .MEM_OUT_6_ADDR_WIDTH(MEM_OUT_6_ADDR_WIDTH),
    .MEM_OUT_7_DATA_WIDTH(MEM_OUT_7_DATA_WIDTH),
    .MEM_OUT_7_ADDR_WIDTH(MEM_OUT_7_ADDR_WIDTH),
    .MEM_OUT_8_DATA_WIDTH(MEM_OUT_8_DATA_WIDTH),
    .MEM_OUT_8_ADDR_WIDTH(MEM_OUT_8_ADDR_WIDTH),
    .MEM_OUT_9_DATA_WIDTH(MEM_OUT_9_DATA_WIDTH),
    .MEM_OUT_9_ADDR_WIDTH(MEM_OUT_9_ADDR_WIDTH),
    .MEM_OUT_10_DATA_WIDTH(MEM_OUT_10_DATA_WIDTH),
    .MEM_OUT_10_ADDR_WIDTH(MEM_OUT_10_ADDR_WIDTH),
    .MEM_OUT_11_DATA_WIDTH(MEM_OUT_11_DATA_WIDTH),
    .MEM_OUT_11_ADDR_WIDTH(MEM_OUT_11_ADDR_WIDTH),
    .MEM_OUT_12_DATA_WIDTH(MEM_OUT_12_DATA_WIDTH),
    .MEM_OUT_12_ADDR_WIDTH(MEM_OUT_12_ADDR_WIDTH),
    .MEM_OUT_13_DATA_WIDTH(MEM_OUT_13_DATA_WIDTH),
    .MEM_OUT_13_ADDR_WIDTH(MEM_OUT_13_ADDR_WIDTH),
    .MEM_OUT_14_DATA_WIDTH(MEM_OUT_14_DATA_WIDTH),
    .MEM_OUT_14_ADDR_WIDTH(MEM_OUT_14_ADDR_WIDTH),
    .MEM_OUT_15_DATA_WIDTH(MEM_OUT_15_DATA_WIDTH),
    .MEM_OUT_15_ADDR_WIDTH(MEM_OUT_15_ADDR_WIDTH),
    .MEM_OUT_16_DATA_WIDTH(MEM_OUT_16_DATA_WIDTH),
    .MEM_OUT_16_ADDR_WIDTH(MEM_OUT_16_ADDR_WIDTH),
    .MEM_OUT_17_DATA_WIDTH(MEM_OUT_17_DATA_WIDTH),
    .MEM_OUT_17_ADDR_WIDTH(MEM_OUT_17_ADDR_WIDTH),

    .C_S00_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
    .C_S00_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
) myip_v1_0_inst (
    // Users to add ports here
    .mem_in_0_addr1(mem_in_0_addr1),
    .mem_in_0_ce1(mem_in_0_ce1),
    .mem_in_0_we1(mem_in_0_we1),
    .mem_in_0_q1(mem_in_0_q1),
    .mem_in_0_d1(mem_in_0_d1),
    .mem_in_1_addr1(mem_in_1_addr1),
    .mem_in_1_ce1(mem_in_1_ce1),
    .mem_in_1_we1(mem_in_1_we1),
    .mem_in_1_q1(mem_in_1_q1),
    .mem_in_1_d1(mem_in_1_d1),
    .mem_in_2_addr1(mem_in_2_addr1),
    .mem_in_2_ce1(mem_in_2_ce1),
    .mem_in_2_we1(mem_in_2_we1),
    .mem_in_2_q1(mem_in_2_q1),
    .mem_in_2_d1(mem_in_2_d1),
    .mem_in_3_addr1(mem_in_3_addr1),
    .mem_in_3_ce1(mem_in_3_ce1),
    .mem_in_3_we1(mem_in_3_we1),
    .mem_in_3_q1(mem_in_3_q1),
    .mem_in_3_d1(mem_in_3_d1),
    .mem_in_4_addr1(mem_in_4_addr1),
    .mem_in_4_ce1(mem_in_4_ce1),
    .mem_in_4_we1(mem_in_4_we1),
    .mem_in_4_q1(mem_in_4_q1),
    .mem_in_4_d1(mem_in_4_d1),
    .mem_in_5_addr1(mem_in_5_addr1),
    .mem_in_5_ce1(mem_in_5_ce1),
    .mem_in_5_we1(mem_in_5_we1),
    .mem_in_5_q1(mem_in_5_q1),
    .mem_in_5_d1(mem_in_5_d1),
    .mem_in_6_addr1(mem_in_6_addr1),
    .mem_in_6_ce1(mem_in_6_ce1),
    .mem_in_6_we1(mem_in_6_we1),
    .mem_in_6_q1(mem_in_6_q1),
    .mem_in_6_d1(mem_in_6_d1),
    .mem_in_7_addr1(mem_in_7_addr1),
    .mem_in_7_ce1(mem_in_7_ce1),
    .mem_in_7_we1(mem_in_7_we1),
    .mem_in_7_q1(mem_in_7_q1),
    .mem_in_7_d1(mem_in_7_d1),
    .mem_in_8_addr1(mem_in_8_addr1),
    .mem_in_8_ce1(mem_in_8_ce1),
    .mem_in_8_we1(mem_in_8_we1),
    .mem_in_8_q1(mem_in_8_q1),
    .mem_in_8_d1(mem_in_8_d1),
    .mem_in_9_addr1(mem_in_9_addr1),
    .mem_in_9_ce1(mem_in_9_ce1),
    .mem_in_9_we1(mem_in_9_we1),
    .mem_in_9_q1(mem_in_9_q1),
    .mem_in_9_d1(mem_in_9_d1),
    .mem_in_10_addr1(mem_in_10_addr1),
    .mem_in_10_ce1(mem_in_10_ce1),
    .mem_in_10_we1(mem_in_10_we1),
    .mem_in_10_q1(mem_in_10_q1),
    .mem_in_10_d1(mem_in_10_d1),
    .mem_in_11_addr1(mem_in_11_addr1),
    .mem_in_11_ce1(mem_in_11_ce1),
    .mem_in_11_we1(mem_in_11_we1),
    .mem_in_11_q1(mem_in_11_q1),
    .mem_in_11_d1(mem_in_11_d1),
    .mem_in_12_addr1(mem_in_12_addr1),
    .mem_in_12_ce1(mem_in_12_ce1),
    .mem_in_12_we1(mem_in_12_we1),
    .mem_in_12_q1(mem_in_12_q1),
    .mem_in_12_d1(mem_in_12_d1),
    .mem_in_13_addr1(mem_in_13_addr1),
    .mem_in_13_ce1(mem_in_13_ce1),
    .mem_in_13_we1(mem_in_13_we1),
    .mem_in_13_q1(mem_in_13_q1),
    .mem_in_13_d1(mem_in_13_d1),
    .mem_in_14_addr1(mem_in_14_addr1),
    .mem_in_14_ce1(mem_in_14_ce1),
    .mem_in_14_we1(mem_in_14_we1),
    .mem_in_14_q1(mem_in_14_q1),
    .mem_in_14_d1(mem_in_14_d1),
    .mem_in_15_addr1(mem_in_15_addr1),
    .mem_in_15_ce1(mem_in_15_ce1),
    .mem_in_15_we1(mem_in_15_we1),
    .mem_in_15_q1(mem_in_15_q1),
    .mem_in_15_d1(mem_in_15_d1),

    .mem_out_0_addr1(mem_out_0_addr1),
    .mem_out_0_ce1(mem_out_0_ce1),
    .mem_out_0_we1(mem_out_0_we1),
    .mem_out_0_q1(mem_out_0_q1),
    .mem_out_0_d1(mem_out_0_d1),
    .mem_out_1_addr1(mem_out_1_addr1),
    .mem_out_1_ce1(mem_out_1_ce1),
    .mem_out_1_we1(mem_out_1_we1),
    .mem_out_1_q1(mem_out_1_q1),
    .mem_out_1_d1(mem_out_1_d1),
    .mem_out_2_addr1(mem_out_2_addr1),
    .mem_out_2_ce1(mem_out_2_ce1),
    .mem_out_2_we1(mem_out_2_we1),
    .mem_out_2_q1(mem_out_2_q1),
    .mem_out_2_d1(mem_out_2_d1),
    .mem_out_3_addr1(mem_out_3_addr1),
    .mem_out_3_ce1(mem_out_3_ce1),
    .mem_out_3_we1(mem_out_3_we1),
    .mem_out_3_q1(mem_out_3_q1),
    .mem_out_3_d1(mem_out_3_d1),
    .mem_out_4_addr1(mem_out_4_addr1),
    .mem_out_4_ce1(mem_out_4_ce1),
    .mem_out_4_we1(mem_out_4_we1),
    .mem_out_4_q1(mem_out_4_q1),
    .mem_out_4_d1(mem_out_4_d1),
    .mem_out_5_addr1(mem_out_5_addr1),
    .mem_out_5_ce1(mem_out_5_ce1),
    .mem_out_5_we1(mem_out_5_we1),
    .mem_out_5_q1(mem_out_5_q1),
    .mem_out_5_d1(mem_out_5_d1),
    .mem_out_6_addr1(mem_out_6_addr1),
    .mem_out_6_ce1(mem_out_6_ce1),
    .mem_out_6_we1(mem_out_6_we1),
    .mem_out_6_q1(mem_out_6_q1),
    .mem_out_6_d1(mem_out_6_d1),
    .mem_out_7_addr1(mem_out_7_addr1),
    .mem_out_7_ce1(mem_out_7_ce1),
    .mem_out_7_we1(mem_out_7_we1),
    .mem_out_7_q1(mem_out_7_q1),
    .mem_out_7_d1(mem_out_7_d1),
    .mem_out_8_addr1(mem_out_8_addr1),
    .mem_out_8_ce1(mem_out_8_ce1),
    .mem_out_8_we1(mem_out_8_we1),
    .mem_out_8_q1(mem_out_8_q1),
    .mem_out_8_d1(mem_out_8_d1),
    .mem_out_9_addr1(mem_out_9_addr1),
    .mem_out_9_ce1(mem_out_9_ce1),
    .mem_out_9_we1(mem_out_9_we1),
    .mem_out_9_q1(mem_out_9_q1),
    .mem_out_9_d1(mem_out_9_d1),
    .mem_out_10_addr1(mem_out_10_addr1),
    .mem_out_10_ce1(mem_out_10_ce1),
    .mem_out_10_we1(mem_out_10_we1),
    .mem_out_10_q1(mem_out_10_q1),
    .mem_out_10_d1(mem_out_10_d1),
    .mem_out_11_addr1(mem_out_11_addr1),
    .mem_out_11_ce1(mem_out_11_ce1),
    .mem_out_11_we1(mem_out_11_we1),
    .mem_out_11_q1(mem_out_11_q1),
    .mem_out_11_d1(mem_out_11_d1),
    .mem_out_12_addr1(mem_out_12_addr1),
    .mem_out_12_ce1(mem_out_12_ce1),
    .mem_out_12_we1(mem_out_12_we1),
    .mem_out_12_q1(mem_out_12_q1),
    .mem_out_12_d1(mem_out_12_d1),
    .mem_out_13_addr1(mem_out_13_addr1),
    .mem_out_13_ce1(mem_out_13_ce1),
    .mem_out_13_we1(mem_out_13_we1),
    .mem_out_13_q1(mem_out_13_q1),
    .mem_out_13_d1(mem_out_13_d1),
    .mem_out_14_addr1(mem_out_14_addr1),
    .mem_out_14_ce1(mem_out_14_ce1),
    .mem_out_14_we1(mem_out_14_we1),
    .mem_out_14_q1(mem_out_14_q1),
    .mem_out_14_d1(mem_out_14_d1),
    .mem_out_15_addr1(mem_out_15_addr1),
    .mem_out_15_ce1(mem_out_15_ce1),
    .mem_out_15_we1(mem_out_15_we1),
    .mem_out_15_q1(mem_out_15_q1),
    .mem_out_15_d1(mem_out_15_d1),
    .mem_out_16_addr1(mem_out_16_addr1),
    .mem_out_16_ce1(mem_out_16_ce1),
    .mem_out_16_we1(mem_out_16_we1),
    .mem_out_16_q1(mem_out_16_q1),
    .mem_out_16_d1(mem_out_16_d1),
    .mem_out_17_addr1(mem_out_17_addr1),
    .mem_out_17_ce1(mem_out_17_ce1),
    .mem_out_17_we1(mem_out_17_we1),
    .mem_out_17_q1(mem_out_17_q1),
    .mem_out_17_d1(mem_out_17_d1),
    .fsm_status_reg_in(fsm_status_reg_in),
    .fsm_status_reg_out(fsm_status_reg_out),

    .s00_axi_aclk   (s00_axi_aclk   ),
    .s00_axi_aresetn(s00_axi_aresetn),
    .s00_axi_awaddr   (s00_axi_awaddr   ),
    .s00_axi_awprot   (s00_axi_awprot   ),
    .s00_axi_awvalid(s00_axi_awvalid),
    .s00_axi_awready(s00_axi_awready),
    .s00_axi_wdata   (s00_axi_wdata   ),
    .s00_axi_wstrb   (s00_axi_wstrb   ),
    .s00_axi_wvalid   (s00_axi_wvalid   ),
    .s00_axi_wready   (s00_axi_wready   ),
    .s00_axi_bresp   (s00_axi_bresp   ),
    .s00_axi_bvalid   (s00_axi_bvalid   ),
    .s00_axi_bready   (s00_axi_bready   ),
    .s00_axi_araddr   (s00_axi_araddr   ),
    .s00_axi_arprot   (s00_axi_arprot   ),
    .s00_axi_arvalid(s00_axi_arvalid),
    .s00_axi_arready(s00_axi_arready),
    .s00_axi_rdata   (s00_axi_rdata   ),
    .s00_axi_rresp   (s00_axi_rresp   ),
    .s00_axi_rvalid   (s00_axi_rvalid   ),
    .s00_axi_rready   (s00_axi_rready   )
);


endmodule // TOP
