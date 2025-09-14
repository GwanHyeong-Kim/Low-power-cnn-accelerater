module BRAM_CONTROLLER (
 input CLK,
 input RSTN,
 input [6:0] STATE_IN,
//////////////////////////////OUTPUT BRAM////////////////////////////////////
 output reg OB_CE0, OB_CE1, OB_CE2, OB_CE3, OB_CE4,
 output reg OB_WE0, OB_WE1, OB_WE2, OB_WE3, OB_WE4,
 output reg [9:0] OB_ADDR,
 // OUTPUT BRAM?????? WRITE?? ??? ?????? ??? ???.
 output reg[31:0] OB_D[3:0],
 // OUTPUT_BRAM?????? READ?? ???? ??? ?????? ??? ??????. 
 input [31:0] OB_Q0, OB_Q1, OB_Q2, OB_Q3, OB_Q4, 
//////////////////////////////INPUT_BRAM/////////////////////////////////////
 output reg IB_CE, IB_WE,
 output reg [9:0] IB_ADDR,
 // INPUT BRAM?????? READ?? ??? ?????? ??? ??? ????. 
 output reg [31:0] IB_D [15:0], 
 // INPUT BRAM?????? REEAD?? ??? ?????? ??? ???.
 input [31:0] IB_Q [15:0], //!@#$
////////////////////////////////////PEARRAY///////////////////////////////
 output reg EN_W, EN_I, //PE_array?? ?????? ??? 
 output reg [31:0] PE_INPUT_DATA[15:0], //!@#$
 output reg [6:0] STATE_OUT,
 input [31:0] PE_OUT[3:0],
 input [3:0] dp_switch,
 output check_led_1,
 output check_led_2,
 output check_led_3,
 output check_led_4); // 
//////////////////////////////////STATE////////////////////////////////////
parameter 
    IDLE = 0,
    // Layer 1
    L1_INPUT_BRAM = 1, //PS???? INPUT BRAM?? WEIGHT, IMANGE DATA ?????? ???
    L1_EN_0 = 2, //PE_array?? en_w?? ????? weight 4???? 4clk?? ????? ??? en_w?? ????
    L1_CAL_0= 3, //PE_array?? en_i?? ????? input_bram?? ????? input?? ?????? ????? ??? ???-> valid????? ???? ????? ????? AXI4 LITE register?? ???? state(4)?? ????. 
    // Layer 2
    L2_INPUT_BRAM = 4, // PS???? layer1?? ??? 4???? col2im, maxpooling, relu, im2col??? ?? input?? weight?? input bram?? ??????? ???
    L2_EN_0  = 5,
    L2_CAL_0 = 6,
    L2_EN_1  = 7,
    L2_CAL_1 = 8,
    L2_EN_2  = 9,
    L2_CAL_2 = 10,
    L2_EN_3  = 11,
    L2_CAL_3 = 12,
    L2_EN_4  = 13,
    L2_CAL_4 = 14,
    L2_EN_5  = 15,
    L2_CAL_5 = 16,
    L2_EN_6  = 17,
    L2_CAL_6 = 18,
    L2_EN_7  = 19,
    L2_CAL_7 = 20,

    // Layer 3
    L3_INPUT_BRAM = 21, // PS???? layer2?? ??? 4???? col2im, maxpooling, relu, im2col??? ?? input?? weight?? input bram?? ??????? ???
    L3_EN_0   = 22,
    L3_CAL_0  = 23,
    L3_EN_1   = 24,
    L3_CAL_1  = 25,
    L3_EN_2   = 26,
    L3_CAL_2  = 27,
    L3_EN_3   = 28,
    L3_CAL_3  = 29,
    L3_EN_4   = 30,
    L3_CAL_4  = 31,
    L3_EN_5   = 32,
    L3_CAL_5  = 33,
    L3_EN_6   = 34,
    L3_CAL_6  = 35,
    L3_EN_7   = 36,
    L3_CAL_7  = 37,
    L3_EN_8   = 38,
    L3_CAL_8  = 39,
    L3_EN_9   = 40,
    L3_CAL_9  = 41,
    L3_EN_10  = 42,
    L3_CAL_10 = 43,
    L3_EN_11  = 44,
    L3_CAL_11 = 45,
    L3_EN_12  = 46,
    L3_CAL_12 = 47,
    L3_EN_13  = 48,
    L3_CAL_13 = 49,
    L3_EN_14  = 50,
    L3_CAL_14 = 51,
    L3_EN_15  = 52,
    L3_CAL_15 = 53,
    L3_EN_16  = 54,
    L3_CAL_16 = 55,
    L3_EN_17  = 56,
    L3_CAL_17 = 57,
    L3_EN_18  = 58,
    L3_CAL_18 = 59,
    L3_EN_19  = 60,
    L3_CAL_19 = 61,
    L3_EN_20  = 62,
    L3_CAL_20 = 63,
    L3_EN_21  = 64,
    L3_CAL_21 = 65,
    L3_EN_22  = 66,
    L3_CAL_22 = 67,
    L3_EN_23  = 68,
    L3_CAL_23 = 69,
    L3_EN_24  = 70,
    L3_CAL_24 = 71,
    L3_EN_25  = 72,
    L3_CAL_25 = 73,
    L3_EN_26  = 74,
    L3_CAL_26 = 75,
    L3_EN_27  = 76,
    L3_CAL_27 = 77,
    L3_EN_28  = 78,
    L3_CAL_28 = 79,
    L3_EN_29  = 80,
    L3_CAL_29 = 81,
    L3_EN_30  = 82,
    L3_CAL_30 = 83,
    L3_EN_31  = 84,
    L3_CAL_31 = 85,
    //L4
    L4_INPUT_BRAM = 86, //BRAM?? INPUT,WEIGHT?????? ??????
    L4_EN_0   = 87, //IS???? EN_I?? ???? ????
    L4_CAL_0  = 88; // 
///////////////////////////////////////////////////////////////////////////
 wire [3:0] led;
 reg [6:0] C_STATE, N_STATE, PREV_STATE;
 reg [9:0] ADDR_COUNTER;
 
 assign check_led_1 = led[0];
 assign check_led_2 = led[1];
 assign check_led_3 = led[2];
 assign check_led_4 = led[3];

 assign led = (dp_switch == 0)  ? 4'b1111 : 
              (dp_switch == 1)  ? C_STATE[3:0] : 
              (dp_switch == 2)  ? N_STATE[3:0] : 
              (dp_switch == 3)  ? { 1'b0, C_STATE[6:4] } : 
              (dp_switch == 4)  ? STATE_OUT[3:0] : 
              (dp_switch == 5)  ? { 1'b0, STATE_OUT[6:4] } : 
              (dp_switch == 6)  ? { 1'b0, N_STATE[6:4] } : 
              (dp_switch == 7)  ? 4'b1111 : 
              (dp_switch == 8)  ? STATE_IN[3:0] : 
              (dp_switch == 9)  ? { 1'b0, STATE_IN[6:4] } : 
              (dp_switch == 10) ? 4'b1111 : 
              (dp_switch == 11) ? 4'b1111 : 
              (dp_switch == 12) ? 4'b1111 : 
              (dp_switch == 13) ? 4'b1111 : 
              (dp_switch == 14) ? 4'b1111 : 
              (C_STATE < L1_INPUT_BRAM) ? 4'b0000:
              (C_STATE < L2_INPUT_BRAM) ? 4'b0001:
              (C_STATE < L3_INPUT_BRAM) ? 4'b0010:
              (C_STATE < L4_INPUT_BRAM) ? 4'b0100:
              4'b1000;

 always @(posedge CLK, negedge RSTN)begin
    if(!RSTN)begin
       PREV_STATE <= IDLE;
       C_STATE <= IDLE;
       ADDR_COUNTER <= 0;
    end
    else begin
       PREV_STATE <= C_STATE;
       C_STATE <= N_STATE;
       if (C_STATE != PREV_STATE) begin
             // STATE?? ????? ??? ????
             ADDR_COUNTER <= 0;
       end
       else begin
          ADDR_COUNTER <= ADDR_COUNTER + 1;
       end
    end
 end

/////////////////////////////CASE_OUT//////////////////////////////////////////
 always@(*)begin
    case(C_STATE)
    IDLE : begin
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       IB_CE      = 0;  IB_WE      = 0; IB_ADDR   = 0; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       EN_W =0; EN_I =0;
       if(STATE_IN == 7'd1)begin
          N_STATE = L1_INPUT_BRAM;
          STATE_OUT = IDLE;
       end
       else begin
          N_STATE = IDLE;
          STATE_OUT = IDLE;
       end
    end

// Layer 1
    L1_INPUT_BRAM: begin   //1
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       IB_CE      = 0;  IB_WE      = 0; IB_ADDR   = 0; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       EN_W =0; EN_I =0;

       if(STATE_IN == 7'd2)begin
          N_STATE = L1_EN_0;
          STATE_OUT = L1_INPUT_BRAM;
       end

       else begin
          N_STATE = L1_INPUT_BRAM;
          STATE_OUT = L1_INPUT_BRAM;
       end
    end
    L1_EN_0: begin  //2
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       /*IB_CE  = 0;*/ IB_WE      = 0;/* IB_ADDR   = ADDR_COUNTER;*/ IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?? ?????? 0??. 
       //??????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
       //????????? ?? ???? ?? ???? ??? ?? ????. 
       /*EN_W =0;*/EN_I =0;
       if(ADDR_COUNTER == 0) begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L1_EN_0;
          STATE_OUT = L1_EN_0 ;
          IB_ADDR   = ADDR_COUNTER;        
       end
       else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L1_EN_0;
          STATE_OUT = L1_EN_0;
          IB_ADDR   = ADDR_COUNTER;        
       end
       else if( ADDR_COUNTER == 4) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L1_CAL_0;
          STATE_OUT = L1_EN_0;         
       end 
       else if(ADDR_COUNTER == 5)begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L1_CAL_0;
          STATE_OUT = L1_EN_0;
          IB_ADDR   = ADDR_COUNTER-1;               
       end
       else if (ADDR_COUNTER >5 && OB_ADDR ==0) begin
          EN_W   =0;
          IB_CE    =0;            
          N_STATE = L1_EN_0;
          STATE_OUT = L1_EN_0;
       end
    end
    L1_CAL_0: begin //3
       /*OB_CE0      = 0;*/  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE0      = 0;*/ OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       /*OB_ADDR0  = 0;*/
       OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
       // INPUT_BRAM???? ?????? ???? ????? ??? ?????? ??? 4CLK?? INPUT BRAM???? weight?? ????? ???? 625 CLK?? INPUT BRAM???? PEARRAY?? INPUT?? ????. 
       /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+4; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       //??????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       //????????? ?? ???? ?? ???? ??? ?? ????. 
       EN_W =0; /*EN_I =0;*/
       
       if (C_STATE != PREV_STATE) begin
          OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=0;IB_CE=0; N_STATE = L1_CAL_0 ;STATE_OUT = L1_CAL_0;
       end  
       else if (ADDR_COUNTER < 24) begin 
          OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L1_CAL_0 ;STATE_OUT = L1_CAL_0;
       end 
       else if (ADDR_COUNTER >= 24 && ADDR_COUNTER < 625) begin // ??? ???? ??????? OUT_BRAM?? ???? 
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER-24 ;EN_I=1;IB_CE=1; N_STATE = L1_CAL_0; STATE_OUT = L1_CAL_0;
       end
       else if (ADDR_COUNTER >= 625 && ADDR_COUNTER < 640) begin //EN_I?? ???? 
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER-24 ;EN_I=0;IB_CE=1; N_STATE = L1_CAL_0; STATE_OUT = L1_CAL_0;
       end
       else if (ADDR_COUNTER >= 640 && ADDR_COUNTER < 649) begin 
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER-24 ;EN_I=0;IB_CE=0; N_STATE = L1_CAL_0; STATE_OUT = L1_CAL_0;
       end
       else begin
          OB_CE0=0;OB_WE0=0;OB_ADDR=ADDR_COUNTER-24;EN_I=0;IB_CE=0;
          N_STATE =   L2_INPUT_BRAM;
          STATE_OUT = L1_CAL_0;
       end
    end
    // Layer 2 
    L2_INPUT_BRAM: begin //4
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       IB_CE      = 0;  IB_WE      = 0; IB_ADDR   = 0; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       EN_W =0; EN_I =0;

       if(STATE_IN == 7'd5)begin
          N_STATE = L2_EN_0;
          STATE_OUT = L2_INPUT_BRAM;
       end
       else begin
          N_STATE = L2_INPUT_BRAM;
          STATE_OUT = L2_INPUT_BRAM;
       end
    end  
    L2_EN_0  : begin //5
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       /*IB_CE  = 0;*/ IB_WE      = 0; /*IB_ADDR   = ADDR_COUNTER;*/ IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D???     ?? 0???. 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       /*EN_W =0;*/EN_I =0;
    if(ADDR_COUNTER == 0) begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_EN_0;
          STATE_OUT = L2_EN_0 ;
          IB_ADDR   = ADDR_COUNTER;
       end
       else if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_EN_0;
          STATE_OUT = L2_EN_0 ;  
          IB_ADDR   = ADDR_COUNTER;      
       end
       else if( ADDR_COUNTER ==4) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_CAL_0;
          STATE_OUT = L2_EN_0;    
          IB_ADDR   = ADDR_COUNTER;     
       end 
       else if(ADDR_COUNTER == 5)begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_CAL_0;
          STATE_OUT = L2_EN_0;   
          IB_ADDR   = ADDR_COUNTER-1;            
       end
       else if (ADDR_COUNTER >5 ) begin
          EN_W   =0;
          IB_CE    =1;            
          N_STATE = L2_EN_0;
          STATE_OUT = L2_EN_0;
       end
    end
    L2_CAL_0 :  begin // 6
       /*OB_CE0      = 0;*/  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE0      = 0;*/ OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       /*OB_ADDR0  = 0;*/
       OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
       // INPUT_BRAM?????? ?????????        ????? ????? ???     ?   4CLK?? INPUT BRAM?????? weight??     ?? ????? 625 CLK?? INPUT BRAM?????? PEARRAY??? INPUT???     . 
       /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER + 5; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       EN_W =0; /*EN_I =0;*/
       
       if (C_STATE != PREV_STATE) begin
          OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=0;IB_CE=0; N_STATE = L2_CAL_0 ;STATE_OUT = L2_CAL_0;
       end   
       else if (ADDR_COUNTER < 23) begin //?   ????????? ??????      ??
          OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L2_CAL_0 ;STATE_OUT = L2_CAL_0;
       end 
       else if (ADDR_COUNTER >= 23 && ADDR_COUNTER < 81) begin // ?   ????????? ?????????? OUT_BRAM??     
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER-23 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_0; STATE_OUT = L2_CAL_0;
       end
       else if (ADDR_COUNTER >= 81 && ADDR_COUNTER < 95) begin //EN_I??     
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER-23 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_0; STATE_OUT = L2_CAL_0;
       end
       else if (ADDR_COUNTER >= 95 && ADDR_COUNTER < 104) begin //IB_CE      640?? ?? ??????    ????
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER-23 ;EN_I=0;IB_CE=0; N_STATE = L2_CAL_0; STATE_OUT = L2_CAL_0;
       end
       else begin //OUTPUT BRAM ?? ??? ?????????? 0?????, ???????????? ????
          OB_CE0=0;OB_WE0=0;OB_ADDR=ADDR_COUNTER-23 ;EN_I=0;IB_CE=0;
          N_STATE =   L2_EN_1;
          STATE_OUT = L2_CAL_0;
       end
    end
    L2_EN_1  :  begin //7
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       /*IB_CE  = 0;*/ IB_WE      = 0; /*IB_ADDR   = ADDR_COUNTER + 100;*/ IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D???     ?? 0???. 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       /*EN_W =0;*/EN_I =0;
       if(ADDR_COUNTER == 0) begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_EN_1;
          STATE_OUT = L2_EN_1 ;
          IB_ADDR   = ADDR_COUNTER + 100;
       end
       else if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_EN_1;
          STATE_OUT = L2_EN_1 ;
          IB_ADDR   = ADDR_COUNTER + 100;         
       end
       else if( ADDR_COUNTER ==4) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_CAL_1;
          STATE_OUT = L2_EN_1;
          IB_ADDR   = ADDR_COUNTER + 100;          
       end 
       else if(ADDR_COUNTER == 5)begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_CAL_1;
          STATE_OUT = L2_EN_1; 
          IB_ADDR   = ADDR_COUNTER + 99;               
       end
       else if (ADDR_COUNTER >5) begin
          EN_W   =0;
          IB_CE    =1;            
          N_STATE = L2_EN_1;
          STATE_OUT = L2_EN_1;
       end
    end
    L2_CAL_1 :   begin //8
       /*OB_CE0      = 0;*/  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE0      = 0;*/ OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       /*OB_ADDR0  = 0;*/
       OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
       // INPUT_BRAM?????? ?????????        ????? ????? ???     ?   4CLK?? INPUT BRAM?????? weight??     ?? ????? 625 CLK?? INPUT BRAM?????? PEARRAY??? INPUT???     . 
       /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER + 105; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   =  0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       EN_W =0; /*EN_I =0;*/
       
       if (C_STATE != PREV_STATE) begin
       OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=0;IB_CE=0; N_STATE = L2_CAL_1 ;STATE_OUT = L2_CAL_1;
       end   
       else if ( ADDR_COUNTER < 23) begin 
          OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L2_CAL_1 ;STATE_OUT = L2_CAL_1;
       end 
       else if (ADDR_COUNTER >= 23 && ADDR_COUNTER < 81) begin
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER+58 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_1; STATE_OUT = L2_CAL_1;
       end
       else if (ADDR_COUNTER >= 81 && ADDR_COUNTER < 95) begin
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER+58 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_1; STATE_OUT = L2_CAL_1;
       end
       else if (ADDR_COUNTER >= 95 && ADDR_COUNTER < 104) begin
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER+58 ;EN_I=0;IB_CE=0; N_STATE = L2_CAL_1; STATE_OUT = L2_CAL_1;
       end
       else begin
          OB_CE0=0;OB_WE0=0;OB_ADDR=ADDR_COUNTER+58 ;EN_I=0;IB_CE=0;
          N_STATE =   L2_EN_2;
          STATE_OUT = L2_CAL_1;
       end
    end
    L2_EN_2  :   begin //9
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       /*IB_CE  = 0;*/ IB_WE      = 0; /*IB_ADDR   = ADDR_COUNTER+200;*/ IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D???     ?? 0???. 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       /*EN_W =0;*/EN_I =0;
       if(ADDR_COUNTER ==0) begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_EN_2;
          STATE_OUT = L2_EN_2 ;
          IB_ADDR   = ADDR_COUNTER+200;
       end
       else if(ADDR_COUNTER >0 && ADDR_COUNTER <=3) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_EN_2;
          STATE_OUT = L2_EN_2 ;
          IB_ADDR   = ADDR_COUNTER+200;   
       end
       else if( ADDR_COUNTER == 4) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_CAL_2;
          STATE_OUT = L2_EN_2;
          IB_ADDR   = ADDR_COUNTER+200;        
       end 
       else if(ADDR_COUNTER == 5)begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_CAL_2;
          STATE_OUT = L2_EN_2;
          IB_ADDR   = ADDR_COUNTER+199;               
       end
       else if (ADDR_COUNTER >5) begin
          EN_W   =0;
          IB_CE    =1;            
          N_STATE = L2_EN_2;
          STATE_OUT = L2_EN_2;
       end


    end
    L2_CAL_2 :    begin // 10
       /*OB_CE0      = 0;*/ OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE0      = 0;*/OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       /*OB_ADDR  = 0;*/
       OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
       // INPUT_BRAM?????? ?????????        ????? ????? ???     ?   4CLK?? INPUT BRAM?????? weight??     ?? ????? 625 CLK?? INPUT BRAM?????? PEARRAY??? INPUT???     . 
       /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+205; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       EN_W =0; /*EN_I =0;*/
       
 
       if (C_STATE != PREV_STATE) begin
       OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=0;IB_CE=0; N_STATE = L2_CAL_2 ;STATE_OUT = L2_CAL_2;
       end
       else if (ADDR_COUNTER < 23) begin 
          OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L2_CAL_2 ;STATE_OUT = L2_CAL_2;
       end 
       else if (ADDR_COUNTER >= 23 && ADDR_COUNTER < 81) begin // ?   ????????? ?????????? OUT_BRAM??     
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER+139 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_2; STATE_OUT = L2_CAL_2;
       end
       else if (ADDR_COUNTER >= 81 && ADDR_COUNTER < 95) begin //EN_I??     
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER+139 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_2; STATE_OUT = L2_CAL_2;
       end
       else if (ADDR_COUNTER >= 95 && ADDR_COUNTER < 104) begin //IB_CE      640?? ?? ??????    ????
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER+139 ;EN_I=0;IB_CE=0; N_STATE = L2_CAL_2; STATE_OUT = L2_CAL_2;
       end
       else begin 
          OB_CE0=0;OB_WE0=0;OB_ADDR=ADDR_COUNTER+139 ;EN_I=0;IB_CE=0;
          N_STATE =   L2_EN_3;
          STATE_OUT = L2_CAL_2;
       end
    end
    L2_EN_3  :   begin //11
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       /*IB_CE  = 0;*/ IB_WE      = 0; /*IB_ADDR   = ADDR_COUNTER+306;*/ IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D???     ?? 0???. 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       /*EN_W =0;*/EN_I =0;
       if(ADDR_COUNTER ==0) begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_EN_3;
          STATE_OUT = L2_EN_3 ;
          IB_ADDR   = ADDR_COUNTER+300;
       end
       else if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_EN_3;
          STATE_OUT = L2_EN_3 ;
          IB_ADDR   = ADDR_COUNTER+300;      
       end
       else if( ADDR_COUNTER == 4) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_CAL_3;
          STATE_OUT = L2_EN_3;
          IB_ADDR   = ADDR_COUNTER+300;         
       end 
       else if(ADDR_COUNTER == 5)begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_CAL_3;
          STATE_OUT = L2_EN_3;
          IB_ADDR   = ADDR_COUNTER+299;              
       end
       else if (ADDR_COUNTER >5) begin
          EN_W   =0;
          IB_CE    =1;            
          N_STATE = L2_EN_3;
          STATE_OUT = L2_EN_3;
       end
    end
    L2_CAL_3 :     begin // 12
       /*OB_CE0      = 0;*/ OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE0      = 0;*/OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       /*OB_ADDR  = 0;*/
       OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
       // INPUT_BRAM?????? ?????????        ????? ????? ???     ?   4CLK?? INPUT BRAM?????? weight??     ?? ????? 625 CLK?? INPUT BRAM?????? PEARRAY??? INPUT???     . 
       /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+305; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       EN_W =0; /*EN_I =0;*/
       
       if (C_STATE != PREV_STATE) begin
       OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=0;IB_CE=0; N_STATE = L2_CAL_3 ;STATE_OUT = L2_CAL_3;
       end
       else if (ADDR_COUNTER < 23) begin 
          OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L2_CAL_3 ;STATE_OUT = L2_CAL_3;
       end 
       else if (ADDR_COUNTER >= 23 && ADDR_COUNTER < 81) begin // ?   ????????? ?????????? OUT_BRAM??     
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER+220 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_3; STATE_OUT = L2_CAL_3;
       end
       else if (ADDR_COUNTER >= 81 && ADDR_COUNTER < 95) begin //EN_I??     
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER+220 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_3; STATE_OUT = L2_CAL_3;
       end
       else if (ADDR_COUNTER >= 95 && ADDR_COUNTER < 104) begin //IB_CE      640?? ?? ??????    ????
          OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER+220 ;EN_I=0;IB_CE=0; N_STATE = L2_CAL_3; STATE_OUT = L2_CAL_3;
       end
       else begin //OUTPUT BRAM ?? ??? ?????????? 0?????, ???????????? ????
          OB_CE0=0;OB_WE0=0;OB_ADDR=ADDR_COUNTER+220 ;EN_I=0;IB_CE=0;
          N_STATE =   L2_EN_4;
          STATE_OUT = L2_CAL_3;
       end
    end
    L2_EN_4  :    begin //13
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       /*IB_CE  = 0;*/ IB_WE      = 0; /*IB_ADDR   = ADDR_COUNTER+400;*/ IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D???     ?? 0???. 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       /*EN_W =0;*/EN_I =0;
       if(ADDR_COUNTER ==0) begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_EN_4;
          STATE_OUT = L2_EN_4 ;
          IB_ADDR   = ADDR_COUNTER+400; 
       end
       else if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_EN_4;
          STATE_OUT = L2_EN_4 ;
          IB_ADDR   = ADDR_COUNTER+400;      
       end
       else if( ADDR_COUNTER == 4) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_CAL_4;
          STATE_OUT = L2_EN_4;
          IB_ADDR   = ADDR_COUNTER+400;         
       end 
       else if(ADDR_COUNTER == 5)begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_CAL_4;
          STATE_OUT = L2_EN_4;
          IB_ADDR   = ADDR_COUNTER+399;               
       end
       else if (ADDR_COUNTER >5) begin
          EN_W   =0;
          IB_CE    =1;            
          N_STATE = L2_EN_4;
          STATE_OUT = L2_EN_4;
       end
    end
    L2_CAL_4 :   begin // 14
       OB_CE0      = 0;  /*OB_CE1      = 0;*/ OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0 ;/* OB_WE1      = 0;*/ OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       /*OB_ADDR  = 0;*/
       OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
       // INPUT_BRAM?????? ?????????        ????? ????? ???     ?   4CLK?? INPUT BRAM?????? weight??     ?? ????? 625 CLK?? INPUT BRAM?????? PEARRAY??? INPUT???     . 
       /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+405; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       EN_W =0; /*EN_I =0;*/
       
       if (C_STATE != PREV_STATE) begin
       OB_CE1=0; OB_WE1=0; OB_ADDR = 0;EN_I=0;IB_CE=0; N_STATE = L2_CAL_4 ;STATE_OUT = L2_CAL_4;
       end
       else if (ADDR_COUNTER < 23) begin 
          OB_CE1=0; OB_WE1=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L2_CAL_4 ;STATE_OUT = L2_CAL_4;
       end 
       else if (ADDR_COUNTER >= 23 && ADDR_COUNTER < 81) begin // ?   ????????? ?????????? OUT_BRAM??     
          OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER-23 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_4; STATE_OUT = L2_CAL_4;
       end
       else if (ADDR_COUNTER >= 81 && ADDR_COUNTER < 95) begin //EN_I??     
          OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER-23 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_4; STATE_OUT = L2_CAL_4;
       end
       else if (ADDR_COUNTER >= 95 && ADDR_COUNTER < 104) begin //IB_CE      640?? ?? ??????    ????
          OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER-23 ;EN_I=0;IB_CE=0; N_STATE = L2_CAL_4; STATE_OUT = L2_CAL_4;
       end
       else begin //OUTPUT BRAM ?? ??? ?????????? 0?????, ???????????? ????
          OB_CE1=0;OB_WE1=0;OB_ADDR=ADDR_COUNTER-23 ;EN_I=0;IB_CE=0;
          N_STATE =   L2_EN_5;
          STATE_OUT = L2_CAL_4;
       end
    end
    L2_EN_5  :   begin //15
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       /*IB_CE  = 0;*/ IB_WE      = 0; /*IB_ADDR   = ADDR_COUNTER+500;*/ IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D???     ?? 0???. 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       /*EN_W =0;*/EN_I =0;
       if(ADDR_COUNTER ==0) begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_EN_5;
          STATE_OUT = L2_EN_5 ;
          IB_ADDR   = ADDR_COUNTER+500; 
       end
       if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_EN_5;
          STATE_OUT = L2_EN_5 ;
          IB_ADDR   = ADDR_COUNTER+500;        
       end
       else if( ADDR_COUNTER == 4) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_CAL_5;
          STATE_OUT = L2_EN_5;
          IB_ADDR   = ADDR_COUNTER+500;       
       end 
       else if(ADDR_COUNTER == 5)begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_CAL_5;
          STATE_OUT = L2_EN_5;
          IB_ADDR   = ADDR_COUNTER+499;               
       end
       else if (ADDR_COUNTER > 5)begin
          EN_W   =0;
          IB_CE    =1;            
          N_STATE = L2_EN_5;
          STATE_OUT = L2_EN_5;
       end
    end
    L2_CAL_5 :    begin // 16
       OB_CE0      = 0;  /*OB_CE1      = 0;*/ OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0 ;/* OB_WE1      = 0;*/ OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       /*OB_ADDR  = 0;*/
       OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
       // INPUT_BRAM?????? ?????????        ????? ????? ???     ?   4CLK?? INPUT BRAM?????? weight??     ?? ????? 625 CLK?? INPUT BRAM?????? PEARRAY??? INPUT???     . 
       /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+505; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       EN_W =0; /*EN_I =0;*/
       
       //??? ?  ?    ???? ??????: OB_CE0, OB_WE0, OB_ADDR0(??? 3????????? ?   20?????? ????? ?????? ON????? 644???????     . ), IB_CE,EN_I(??? ????????? ?   ?   625 CLK?????     ??????.)
       
       if (C_STATE != PREV_STATE) begin
       OB_CE1=0; OB_WE1=0; OB_ADDR = 0;EN_I=0;IB_CE=0; N_STATE = L2_CAL_5 ;STATE_OUT = L2_CAL_5;
       end
       else if (ADDR_COUNTER < 23) begin
          OB_CE1=0; OB_WE1=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L2_CAL_5 ;STATE_OUT = L2_CAL_5;
       end 
       else if (ADDR_COUNTER >= 23 && ADDR_COUNTER < 81) begin // ?   ????????? ?????????? OUT_BRAM??     
          OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER+58 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_5; STATE_OUT = L2_CAL_5;
       end
       else if (ADDR_COUNTER >= 81 && ADDR_COUNTER < 95) begin //EN_I??     
          OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER+58 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_5; STATE_OUT = L2_CAL_5;
       end
       else if (ADDR_COUNTER >= 95 && ADDR_COUNTER < 104) begin //IB_CE      640?? ?? ??????    ????
          OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER+58 ;EN_I=0;IB_CE=0; N_STATE = L2_CAL_5; STATE_OUT = L2_CAL_5;
       end
       else if(ADDR_COUNTER >=105 && OB_ADDR > 0)begin //OUTPUT BRAM ?? ??? ?????????? 0?????, ???????????? ????
          OB_CE1=0;OB_WE1=0;OB_ADDR=ADDR_COUNTER+58 ;EN_I=0;IB_CE=0;
          N_STATE =   L2_EN_6;
          STATE_OUT = L2_CAL_5;
       end
    end
    L2_EN_6  :   begin
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       /*IB_CE  = 0;*/ IB_WE      = 0; /*IB_ADDR   = ADDR_COUNTER+600;*/ IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D???     ?? 0???. 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       /*EN_W =0;*/EN_I =0;
       if(ADDR_COUNTER ==0) begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_EN_6;
          STATE_OUT = L2_EN_6 ;
          IB_ADDR   = ADDR_COUNTER+600; 
       end
       if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_EN_6;
          STATE_OUT = L2_EN_6 ;
          IB_ADDR   = ADDR_COUNTER+600;       
       end
       else if( ADDR_COUNTER == 4) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_CAL_6;
          STATE_OUT = L2_EN_6;
          IB_ADDR   = ADDR_COUNTER+600;       
       end 
       else if(ADDR_COUNTER == 5)begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_CAL_6;
          STATE_OUT = L2_EN_6;
          IB_ADDR   = ADDR_COUNTER+599;               
       end
       else if (ADDR_COUNTER >5 && OB_ADDR ==0) begin
          EN_W   =0;
          IB_CE    =1;            
          N_STATE = L2_EN_6;
          STATE_OUT = L2_EN_6;
       end
    end
    L2_CAL_6 :     begin //
       OB_CE0      = 0;  /*OB_CE1      = 0;*/ OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0 ;/* OB_WE1      = 0;*/ OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       /*OB_ADDR  = 0;*/
       OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
       // INPUT_BRAM?????? ?????????        ????? ????? ???     ?   4CLK?? INPUT BRAM?????? weight??     ?? ????? 625 CLK?? INPUT BRAM?????? PEARRAY??? INPUT???     . 
       /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+605; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       EN_W =0; /*EN_I =0;*/

       if (C_STATE != PREV_STATE) begin
       OB_CE1=0; OB_WE1=0; OB_ADDR = 0;EN_I=0;IB_CE=0; N_STATE = L2_CAL_6 ;STATE_OUT = L2_CAL_6;
       end
       else if (ADDR_COUNTER < 23) begin
          OB_CE1=0; OB_WE1=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L2_CAL_6 ;STATE_OUT = L2_CAL_6;
       end 
       else if (ADDR_COUNTER >= 23 && ADDR_COUNTER < 81) begin // ?   ????????? ?????????? OUT_BRAM??     
          OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER+139 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_6; STATE_OUT = L2_CAL_6;
       end
       else if (ADDR_COUNTER >= 81 && ADDR_COUNTER < 95) begin //EN_I??     
          OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER+139 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_6; STATE_OUT = L2_CAL_6;
       end
       else if (ADDR_COUNTER >= 95 && ADDR_COUNTER < 104) begin //IB_CE      640?? ?? ??????    ????
          OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER+139 ;EN_I=0;IB_CE=0; N_STATE = L2_CAL_6; STATE_OUT = L2_CAL_6;
       end
       else begin //OUTPUT BRAM ?? ??? ?????????? 0?????, ???????????? ????
          OB_CE1=0;OB_WE1=0;OB_ADDR=ADDR_COUNTER+139 ;EN_I=0;IB_CE=0;
          N_STATE =   L2_EN_7;
          STATE_OUT = L2_CAL_6;;
       end
    end
    L2_EN_7  :    begin
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       /*IB_CE  = 0;*/ IB_WE      = 0; /*IB_ADDR   = ADDR_COUNTER+700;*/ IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D???     ?? 0???. 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       /*EN_W =0;*/EN_I =0;
       if(ADDR_COUNTER ==0) begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_EN_7;
          STATE_OUT = L2_EN_7 ;
          IB_ADDR   = ADDR_COUNTER+700; 
       end
       if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_EN_7;
          STATE_OUT = L2_EN_7 ;
          IB_ADDR   = ADDR_COUNTER+700;       
       end
       else if( ADDR_COUNTER == 4) begin
          EN_W   =1;
          IB_CE    =1;    
          N_STATE = L2_CAL_7;
          STATE_OUT = L2_EN_7;
          IB_ADDR   = ADDR_COUNTER+700;         
       end 
       else if(ADDR_COUNTER == 5)begin
          EN_W   =0;
          IB_CE    =1;    
          N_STATE = L2_CAL_7;
          STATE_OUT = L2_EN_7;
          IB_ADDR   = ADDR_COUNTER+699;               
       end
       else if (ADDR_COUNTER >5 && OB_ADDR ==0) begin
          EN_W   =0;
          IB_CE    =0;            
          N_STATE = L2_EN_7;
          STATE_OUT = L2_EN_7;
       end
    end
    L2_CAL_7 :     begin //
       OB_CE0      = 0;  /*OB_CE1      = 0;*/ OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0 ;/* OB_WE1      = 0;*/ OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       /*OB_ADDR  = 0;*/
       OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
       // INPUT_BRAM?????? ?????????        ????? ????? ???     ?   4CLK?? INPUT BRAM?????? weight??     ?? ????? 625 CLK?? INPUT BRAM?????? PEARRAY??? INPUT???     . 
       /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+705; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       //???  ????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       //???   ?????? ?? ?????? ???   ??   ?? ??? ??????. 
       EN_W =0; /*EN_I =0;*/
       
       if (C_STATE != PREV_STATE) begin
       OB_CE1=0; OB_WE1=0; OB_ADDR = 0;EN_I=0;IB_CE=0; N_STATE = L2_CAL_7 ;STATE_OUT = L2_CAL_7;
       end
       else if (ADDR_COUNTER < 23) begin
          OB_CE1=0; OB_WE1=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L2_CAL_7 ;STATE_OUT = L2_CAL_7;
       end 
       else if (ADDR_COUNTER >= 23 && ADDR_COUNTER < 81) begin // ?   ????????? ?????????? OUT_BRAM??     
          OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER+220 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_7; STATE_OUT = L2_CAL_7;
       end
       else if (ADDR_COUNTER >= 81 && ADDR_COUNTER < 95) begin //EN_I??     
          OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER+220 ;EN_I=1;IB_CE=1; N_STATE = L2_CAL_7; STATE_OUT = L2_CAL_7;
       end
       else if (ADDR_COUNTER >= 95 && ADDR_COUNTER < 104) begin //IB_CE      640?? ?? ??????    ????
          OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER+220 ;EN_I=0;IB_CE=0; N_STATE = L2_CAL_7; STATE_OUT = L2_CAL_7;
       end
       else begin //OUTPUT BRAM ?? ??? ?????????? 0?????, ???????????? ????
          OB_CE1=0;OB_WE1=0;OB_ADDR=ADDR_COUNTER+220 ;EN_I=0;IB_CE=0;
          N_STATE =   L3_INPUT_BRAM;
          STATE_OUT = L2_CAL_7;
       end
    end  
                   // Layer 3
       L3_INPUT_BRAM :  begin //21
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          IB_CE      = 0;  IB_WE      = 0; IB_ADDR   = 0; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          EN_W =0; EN_I =0;

          if(STATE_IN == 7'd22)begin
             N_STATE = L3_EN_0;
             STATE_OUT = L3_INPUT_BRAM;
          end
          else begin
             N_STATE = L3_INPUT_BRAM;
             STATE_OUT = L3_INPUT_BRAM;
          end
       end  
       L3_EN_0   :  begin //22
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;
          if(PREV_STATE != C_STATE)begin
             EN_W = 0;
             IB_CE = 0;
             N_STATE = L3_EN_0;
             STATE_OUT = L3_EN_0;
             IB_ADDR   = ADDR_COUNTER;
          end
          else if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_0;
             STATE_OUT = L3_EN_0 ;
             IB_ADDR   = ADDR_COUNTER;
          end
          else if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_0;
             STATE_OUT = L3_EN_0 ; 
             IB_ADDR   = ADDR_COUNTER;       
          end
          else if( ADDR_COUNTER ==4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_0;
             STATE_OUT = L3_EN_0;   
             IB_ADDR   = ADDR_COUNTER;      
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_0;
             STATE_OUT = L3_EN_0;    
             IB_ADDR   = ADDR_COUNTER-1;           
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_0;
             STATE_OUT = L3_EN_0;
          end

       end

       L3_CAL_0  :  begin //23
          /*OB_CE0      = 0;*/  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE0      = 0;*/ OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+4; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/   
          
          //?��기서 바꿔줘야?�� ?��?��: OB_CE0, OB_WE0, OB_ADDR0(?�� 3?��?��?�� 처음 20?��?�� �???�� ?��?�� ON?���?? 644�???���?? 꺼짐. ), IB_CE,EN_I(?�� ?��?��?�� 처음 처음 625 CLK?���?? 켜져?��?��.)
          // if (ADDR_COUNTER < 1) begin // ?��?��1개이�??�?? 1번만 enable_I켜줌
             //out_bram enable?��?�� 0?���?? ?��?�� 
             //  OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L3_CAL_0 ;STATE_OUT = L3_CAL_0;
          // end
          if(PREV_STATE != C_STATE)begin
             OB_CE0=0;OB_WE0=0;OB_ADDR=0 ;EN_I=0; IB_CE=0; N_STATE = L3_CAL_0; STATE_OUT = L3_CAL_0;
          end 
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE0=0;OB_WE0=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_0; STATE_OUT = L3_CAL_0;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE0=0;OB_WE0=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_0; STATE_OUT = L3_CAL_0;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER-24;EN_I=0;IB_CE=0; N_STATE = L3_CAL_0; STATE_OUT = L3_CAL_0;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE0=0;OB_WE0=0 ;OB_ADDR=ADDR_COUNTER-24 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_1; STATE_OUT = L3_CAL_0;
          end
       end
       L3_EN_1   :   begin //24
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+20; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_1;
             STATE_OUT = L3_EN_1 ;
          end
          else if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_1;
             STATE_OUT = L3_EN_1 ;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_1;
             STATE_OUT = L3_EN_1;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_1;
             STATE_OUT = L3_EN_1;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_1;
             STATE_OUT = L3_EN_1;
          end
       end

       L3_CAL_1  :   begin //25
          /*OB_CE0      = 0;*/  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE0      = 0;*/ OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+24; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          //?��기서 바꿔줘야?�� ?��?��: OB_CE0, OB_WE0, OB_ADDR0(?�� 3?��?��?�� 처음 20?��?�� �???�� ?��?�� ON?���?? 644�???���?? 꺼짐. ), IB_CE,EN_I(?�� ?��?��?�� 처음 처음 625 CLK?���?? 켜져?��?��.)
          // if (ADDR_COUNTER < 1) begin // ?��?��1개이�??�?? 1번만 enable_I켜줌
             //out_bram enable?��?�� 0?���?? ?��?�� 
             //  OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L3_CAL_1 ;STATE_OUT = L3_CAL_1;
          // end
          if(PREV_STATE != C_STATE)begin
             OB_CE0=0;OB_WE0=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_1; STATE_OUT = L3_CAL_1;
          end 
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE0=0;OB_WE0=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_1; STATE_OUT = L3_CAL_1;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE0=0;OB_WE0=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_1; STATE_OUT = L3_CAL_1;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER-23;EN_I=0;IB_CE=0; N_STATE = L3_CAL_1; STATE_OUT = L3_CAL_1;
          end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE0=0;OB_WE0=0 ;OB_ADDR=ADDR_COUNTER-23 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_2; STATE_OUT = L3_CAL_1;
          end
       end
       L3_EN_2   :   begin //26
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+40; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_2;
             STATE_OUT = L3_EN_2 ;
          end
          else if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_2;
             STATE_OUT = L3_EN_2 ;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_2;
             STATE_OUT = L3_EN_2;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_2;
             STATE_OUT = L3_EN_2;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_2;
             STATE_OUT = L3_EN_2;
          end
       end
       L3_CAL_2  :   begin //27
          /*OB_CE0      = 0;*/  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE0      = 0;*/ OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+44; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          
          //?��기서 바꿔줘야?�� ?��?��: OB_CE0, OB_WE0, OB_ADDR0(?�� 3?��?��?�� 처음 20?��?�� �???�� ?��?�� ON?���?? 644�???���?? 꺼짐. ), IB_CE,EN_I(?�� ?��?��?�� 처음 처음 625 CLK?���?? 켜져?��?��.)
       //   if (ADDR_COUNTER < 1) begin // ?��?��1개이�??�?? 1번만 enable_I켜줌
             //out_bram enable?��?�� 0?���?? ?��?�� 
             //  OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L3_CAL_2 ;STATE_OUT = L3_CAL_2;
          // end 
          if(PREV_STATE != C_STATE)begin
             OB_CE0=0;OB_WE0=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_2; STATE_OUT = L3_CAL_2;
          end 
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE0=0;OB_WE0=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_2; STATE_OUT = L3_CAL_2;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE0=0;OB_WE0=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_2; STATE_OUT = L3_CAL_2;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER-22;EN_I=0;IB_CE=0; N_STATE = L3_CAL_2; STATE_OUT = L3_CAL_2;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE0=0;OB_WE0=0 ;OB_ADDR=ADDR_COUNTER-22 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_3; STATE_OUT = L3_CAL_2;
          end
       end
       L3_EN_3   :   begin//28
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+60; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;


          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_3;
             STATE_OUT = L3_EN_3 ;
          end
          else if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_3;
             STATE_OUT = L3_EN_3 ;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_3;
             STATE_OUT = L3_EN_3;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_3;
             STATE_OUT = L3_EN_3;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_3;
             STATE_OUT = L3_EN_3;
          end
       end
       L3_CAL_3  :    begin //29
          /*OB_CE0      = 0;*/  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE0      = 0;*/ OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+64; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          
          //?��기서 바꿔줘야?�� ?��?��: OB_CE0, OB_WE0, OB_ADDR0(?�� 3?��?��?�� 처음 20?��?�� �???�� ?��?�� ON?���?? 644�???���?? 꺼짐. ), IB_CE,EN_I(?�� ?��?��?�� 처음 처음 625 CLK?���?? 켜져?��?��.)
       //   if (ADDR_COUNTER < 1) begin // ?��?��1개이�??�?? 1번만 enable_I켜줌
             //out_bram enable?��?�� 0?���?? ?��?�� 
             //  OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L3_CAL_3 ;STATE_OUT = L3_CAL_3;
          // end
          if(PREV_STATE != C_STATE)begin
             OB_CE0=0;OB_WE0=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_3; STATE_OUT = L3_CAL_3;
          end 
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE0=0;OB_WE0=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_3; STATE_OUT = L3_CAL_3;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE0=0;OB_WE0=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_3; STATE_OUT = L3_CAL_3;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER-21;EN_I=0;IB_CE=0; N_STATE = L3_CAL_3; STATE_OUT = L3_CAL_3;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE0=0;OB_WE0=0 ;OB_ADDR=ADDR_COUNTER-21 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_4; STATE_OUT = L3_CAL_3;
          end
       end
       L3_EN_4   :   begin//30
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+80; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_4;
             STATE_OUT = L3_EN_4 ;
          end
          else if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_4;
             STATE_OUT = L3_EN_4 ;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_4;
             STATE_OUT = L3_EN_4;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_4;
             STATE_OUT = L3_EN_4;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_4;
             STATE_OUT = L3_EN_4;
          end
       end
       L3_CAL_4  :    begin //31
          /*OB_CE0      = 0;*/  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE0      = 0;*/ OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+84; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          
          //?��기서 바꿔줘야?�� ?��?��: OB_CE0, OB_WE0, OB_ADDR0(?�� 3?��?��?�� 처음 20?��?�� �???�� ?��?�� ON?���?? 644�???���?? 꺼짐. ), IB_CE,EN_I(?�� ?��?��?�� 처음 처음 625 CLK?���?? 켜져?��?��.)
       //   if (ADDR_COUNTER < 1) begin // ?��?��1개이�??�?? 1번만 enable_I켜줌
             //out_bram enable?��?�� 0?���?? ?��?�� 
             //  OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L3_CAL_4 ;STATE_OUT = L3_CAL_4;
          // end
          if(PREV_STATE != C_STATE)begin
             OB_CE0=0;OB_WE0=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_4; STATE_OUT = L3_CAL_4;
          end 
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE0=0;OB_WE0=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_4; STATE_OUT = L3_CAL_4;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE0=0;OB_WE0=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_4; STATE_OUT = L3_CAL_4;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE0=1;OB_WE0=1;OB_ADDR=ADDR_COUNTER-20;EN_I=0;IB_CE=0; N_STATE = L3_CAL_4; STATE_OUT = L3_CAL_4;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE0=0;OB_WE0=0 ;OB_ADDR=ADDR_COUNTER-20 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_5; STATE_OUT = L3_CAL_4;
          end
       end
       L3_EN_5   :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+100; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

 

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_5;
             STATE_OUT = L3_EN_5 ;
          end
          else if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_5;
             STATE_OUT = L3_EN_5 ;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_5;
             STATE_OUT = L3_EN_5;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_5;
             STATE_OUT = L3_EN_5;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_5;
             STATE_OUT = L3_EN_5;
          end
       end
       L3_CAL_5  :      begin //
          /*OB_CE0      = 0;*/ OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE0      = 0;*/ OB_WE1      = 0;OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+104; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          
          //?��기서 바꿔줘야?�� ?��?��: OB_CE0, OB_WE0, OB_ADDR0(?�� 3?��?��?�� 처음 20?��?�� �???�� ?��?�� ON?���?? 644�???���?? 꺼짐. ), IB_CE,EN_I(?�� ?��?��?�� 처음 처음 625 CLK?���?? 켜져?��?��.)
       //   if (ADDR_COUNTER < 1) begin // ?��?��1개이�??�?? 1번만 enable_I켜줌
             //out_bram enable?��?�� 0?���?? ?��?�� 
             //   OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L3_CAL_5 ;STATE_OUT = L3_CAL_5;
          // end
          if(PREV_STATE != C_STATE)begin
             OB_CE0=0;OB_WE0=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_5; STATE_OUT = L3_CAL_5;
          end  
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE0=0; OB_WE0=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_5; STATE_OUT = L3_CAL_5;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE0=0; OB_WE0=0;;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_5; STATE_OUT = L3_CAL_5;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE0=1; OB_WE0=1;OB_ADDR=ADDR_COUNTER-19;EN_I=0;IB_CE=0; N_STATE = L3_CAL_5; STATE_OUT = L3_CAL_5;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE0=0; OB_WE0=0;OB_ADDR=ADDR_COUNTER-19 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_6; STATE_OUT = L3_CAL_5;
          end
       end
       L3_EN_6   :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+120; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_6;
             STATE_OUT = L3_EN_6 ;
          end
          else if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_6;
             STATE_OUT = L3_EN_6 ;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_6;
             STATE_OUT = L3_EN_6;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_6;
             STATE_OUT = L3_EN_6;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_6;
             STATE_OUT = L3_EN_6;
          end
       end
       L3_CAL_6  :      begin //
          /*OB_CE0      = 0;*/ OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE0      = 0;*/ OB_WE1      = 0;OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+124; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          
          //?��기서 바꿔줘야?�� ?��?��: OB_CE0, OB_WE0, OB_ADDR0(?�� 3?��?��?�� 처음 20?��?�� �???�� ?��?�� ON?���?? 644�???���?? 꺼짐. ), IB_CE,EN_I(?�� ?��?��?�� 처음 처음 625 CLK?���?? 켜져?��?��.)
       //   if (ADDR_COUNTER < 1) begin // ?��?��1개이�??�?? 1번만 enable_I켜줌
             //out_bram enable?��?�� 0?���?? ?��?�� 
             //   OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L3_CAL_6 ;STATE_OUT = L3_CAL_6;
          // end
          if(PREV_STATE != C_STATE)begin
             OB_CE0=0;OB_WE0=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_6; STATE_OUT = L3_CAL_6;
          end  
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE0=0; OB_WE0=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_6; STATE_OUT = L3_CAL_6;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE0=0; OB_WE0=0;;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_6; STATE_OUT = L3_CAL_6;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE0=1; OB_WE0=1;OB_ADDR=ADDR_COUNTER-18;EN_I=0;IB_CE=0; N_STATE = L3_CAL_6; STATE_OUT = L3_CAL_6;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE0=0; OB_WE0=0;OB_ADDR=ADDR_COUNTER-18 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_7; STATE_OUT = L3_CAL_6;
          end
       end
       L3_EN_7   :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+140; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;


          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_7;
             STATE_OUT = L3_EN_7 ;
          end
          else if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_7;
             STATE_OUT = L3_EN_7 ;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_7;
             STATE_OUT = L3_EN_7;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_7;
             STATE_OUT = L3_EN_7;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_7;
             STATE_OUT = L3_EN_7;
          end
       end
       L3_CAL_7  :      begin //
          /*OB_CE0      = 0;*/ OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE0      = 0;*/ OB_WE1      = 0;OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+144; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          
          //?��기서 바꿔줘야?�� ?��?��: OB_CE0, OB_WE0, OB_ADDR0(?�� 3?��?��?�� 처음 20?��?�� �???�� ?��?�� ON?���?? 644�???���?? 꺼짐. ), IB_CE,EN_I(?�� ?��?��?�� 처음 처음 625 CLK?���?? 켜져?��?��.)
       //   if (ADDR_COUNTER < 1) begin // ?��?��1개이�??�?? 1번만 enable_I켜줌
             //out_bram enable?��?�� 0?���?? ?��?�� 
             //   OB_CE0=0; OB_WE0=0; OB_ADDR = 0;EN_I=1;IB_CE=1; N_STATE = L3_CAL_7 ;STATE_OUT = L3_CAL_7;
          // end 
          if(PREV_STATE != C_STATE)begin
             OB_CE0=0;OB_WE0=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_7; STATE_OUT = L3_CAL_7;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE0=0; OB_WE0=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_7; STATE_OUT = L3_CAL_7;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE0=0; OB_WE0=0;;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_7; STATE_OUT = L3_CAL_7;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE0=1; OB_WE0=1;OB_ADDR=ADDR_COUNTER-17;EN_I=0;IB_CE=0; N_STATE = L3_CAL_7; STATE_OUT = L3_CAL_7;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE0=0; OB_WE0=0;OB_ADDR=ADDR_COUNTER-17 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_8; STATE_OUT = L3_CAL_7;
          end
       end
       L3_EN_8   :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+160; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;
          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_8;
             STATE_OUT = L3_EN_8 ;
          end
          else if(ADDR_COUNTER > 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_8;
             STATE_OUT = L3_EN_8;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_8;
             STATE_OUT = L3_EN_8;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_8;
             STATE_OUT = L3_EN_8;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_8;
             STATE_OUT = L3_EN_8;
          end
       end
       L3_CAL_8  :   begin //
          /*OB_CE1      = 0;*/  OB_CE0      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE1      = 0;*/ OB_WE0      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+164; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/           
          //?��기서 바꿔줘야?�� ?��?��: OB_CE0, OB_WE0, OB_ADDR0(?�� 3?��?��?�� 처음 20?��?�� �???�� ?��?�� ON?���?? 644�???���?? 꺼짐. ), IB_CE,EN_I(?�� ?��?��?�� 처음 처음 625 CLK?���?? 켜져?��?��.)
          if(PREV_STATE != C_STATE)begin
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_8; STATE_OUT = L3_CAL_8;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_8; STATE_OUT = L3_CAL_8;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE1=0;OB_WE1=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_8; STATE_OUT = L3_CAL_8;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER-24;EN_I=0;IB_CE=0; N_STATE = L3_CAL_8; STATE_OUT = L3_CAL_8;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE1=0;OB_WE1=0 ;OB_ADDR=ADDR_COUNTER-24 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_9; STATE_OUT = L3_CAL_8;
          end
       end
       L3_EN_9   :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+180; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;
          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_9;
             STATE_OUT = L3_EN_9 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_9;
             STATE_OUT = L3_EN_9;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_9;
             STATE_OUT = L3_EN_9;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_9;
             STATE_OUT = L3_EN_9;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_9;
             STATE_OUT = L3_EN_9;
          end
       end
       L3_CAL_9  :   begin //
          /*OB_CE1      = 0;*/  OB_CE0      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE1      = 0;*/ OB_WE0      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+184; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          
          //?��기서 바꿔줘야?�� ?��?��: OB_CE0, OB_WE0, OB_ADDR0(?�� 3?��?��?�� 처음 20?��?�� �???�� ?��?�� ON?���?? 644�???���?? 꺼짐. ), IB_CE,EN_I(?�� ?��?��?�� 처음 처음 625 CLK?���?? 켜져?��?��.)
          if(PREV_STATE != C_STATE)begin
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_9; STATE_OUT = L3_CAL_9;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_9; STATE_OUT = L3_CAL_9;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_9; STATE_OUT = L3_CAL_9;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER-23;EN_I=0;IB_CE=0; N_STATE = L3_CAL_9; STATE_OUT = L3_CAL_9;
          end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE1=0;OB_WE1=0 ;OB_ADDR=ADDR_COUNTER-23 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_10; STATE_OUT = L3_CAL_9;
          end
       end
       L3_EN_10  :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+200; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;
          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_10;
             STATE_OUT = L3_EN_10 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_10;
             STATE_OUT = L3_EN_10;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_10;
             STATE_OUT = L3_EN_10;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_10;
             STATE_OUT = L3_EN_10;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_10;
             STATE_OUT = L3_EN_10;
          end
       end
       L3_CAL_10 :    begin //
          /*OB_CE1      = 0;*/  OB_CE0      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE1      = 0;*/ OB_WE0      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+204; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          
          //?��기서 바꿔줘야?�� ?��?��: OB_CE0, OB_WE0, OB_ADDR0(?�� 3?��?��?�� 처음 20?��?�� �???�� ?��?�� ON?���?? 644�???���?? 꺼짐. ), IB_CE,EN_I(?�� ?��?��?�� 처음 처음 625 CLK?���?? 켜져?��?��.)
          if(PREV_STATE != C_STATE)begin
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_10; STATE_OUT = L3_CAL_10;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_10; STATE_OUT = L3_CAL_10;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE1=0;OB_WE1=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_10; STATE_OUT = L3_CAL_10;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER-22;EN_I=0;IB_CE=0; N_STATE = L3_CAL_10; STATE_OUT = L3_CAL_10;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE1=0;OB_WE1=0 ;OB_ADDR=ADDR_COUNTER-22 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_11; STATE_OUT = L3_CAL_10;
          end
       end
       L3_EN_11  :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+220; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_11;
             STATE_OUT = L3_EN_11 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_11;
             STATE_OUT = L3_EN_11;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_11;
             STATE_OUT = L3_EN_11;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_11;
             STATE_OUT = L3_EN_11;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_11;
             STATE_OUT = L3_EN_11;
          end
       end
       L3_CAL_11 :     begin //
          /*OB_CE1      = 0;*/  OB_CE0      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE1      = 0;*/ OB_WE0      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+224; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_11; STATE_OUT = L3_CAL_11;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_11; STATE_OUT = L3_CAL_11;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE1=0;OB_WE1=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_11; STATE_OUT = L3_CAL_11;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER-21;EN_I=0;IB_CE=0; N_STATE = L3_CAL_11; STATE_OUT = L3_CAL_11;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE1=0;OB_WE1=0 ;OB_ADDR=ADDR_COUNTER-21 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_12; STATE_OUT = L3_CAL_11;
          end
       end
       L3_EN_12  :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+240; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;
          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_12;
             STATE_OUT = L3_EN_12 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_12;
             STATE_OUT = L3_EN_12;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_12;
             STATE_OUT = L3_EN_12;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_12;
             STATE_OUT = L3_EN_12;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_12;
             STATE_OUT = L3_EN_12;
          end
       end
       L3_CAL_12 :      begin //
          /*OB_CE1      = 0;*/  OB_CE0      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE1      = 0;*/ OB_WE0      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+244; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_12; STATE_OUT = L3_CAL_12;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_12; STATE_OUT = L3_CAL_12;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE1=0;OB_WE1=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_12; STATE_OUT = L3_CAL_12;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER-20;EN_I=0;IB_CE=0; N_STATE = L3_CAL_12; STATE_OUT = L3_CAL_12;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE1=0;OB_WE1=0 ;OB_ADDR=ADDR_COUNTER-20 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_13; STATE_OUT = L3_CAL_12;
          end
       end
       L3_EN_13  :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+260; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_13;
             STATE_OUT = L3_EN_13 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_13;
             STATE_OUT = L3_EN_13;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_13;
             STATE_OUT = L3_EN_13;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_13;
             STATE_OUT = L3_EN_13;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_13;
             STATE_OUT = L3_EN_13;
          end
       end
       L3_CAL_13 :      begin //
          /*OB_CE1      = 0;*/  OB_CE0      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE1      = 0;*/ OB_WE0      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+264; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_13; STATE_OUT = L3_CAL_13;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_13; STATE_OUT = L3_CAL_13;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE1=0;OB_WE1=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_13; STATE_OUT = L3_CAL_13;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER-19;EN_I=0;IB_CE=0; N_STATE = L3_CAL_13; STATE_OUT = L3_CAL_13;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE1=0;OB_WE1=0 ;OB_ADDR=ADDR_COUNTER-19 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_14; STATE_OUT = L3_CAL_13;
          end
       end
       L3_EN_14  :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+280; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_14;
             STATE_OUT = L3_EN_14 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_14;
             STATE_OUT = L3_EN_14;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_14;
             STATE_OUT = L3_EN_14;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_14;
             STATE_OUT = L3_EN_14;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_14;
             STATE_OUT = L3_EN_14;
          end
       end
       L3_CAL_14 :      begin //
          /*OB_CE1      = 0;*/  OB_CE0      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE1      = 0;*/ OB_WE0      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+284; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_14; STATE_OUT = L3_CAL_14;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_14; STATE_OUT = L3_CAL_14;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE1=0;OB_WE1=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_14; STATE_OUT = L3_CAL_14;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER-18;EN_I=0;IB_CE=0; N_STATE = L3_CAL_14; STATE_OUT = L3_CAL_14;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE1=0;OB_WE1=0 ;OB_ADDR=ADDR_COUNTER-18 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_15; STATE_OUT = L3_CAL_14;
          end
       end
       L3_EN_15  :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+300; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_15;
             STATE_OUT = L3_EN_15 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_15;
             STATE_OUT = L3_EN_15;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_15;
             STATE_OUT = L3_EN_15;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_15;
             STATE_OUT = L3_EN_15;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_15;
             STATE_OUT = L3_EN_15;
          end
       end
       L3_CAL_15 :      begin //
          /*OB_CE1      = 0;*/  OB_CE0      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE1      = 0;*/ OB_WE0      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+304; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_15; STATE_OUT = L3_CAL_15;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_15; STATE_OUT = L3_CAL_15;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE1=0;OB_WE1=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_15; STATE_OUT = L3_CAL_15;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER-17;EN_I=0;IB_CE=0; N_STATE = L3_CAL_15; STATE_OUT = L3_CAL_15;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE1=0;OB_WE1=0 ;OB_ADDR=ADDR_COUNTER-17 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_16; STATE_OUT = L3_CAL_15;
          end
       end
       L3_EN_16  :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+320; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_16;
             STATE_OUT = L3_EN_16 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_16;
             STATE_OUT = L3_EN_16;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_16;
             STATE_OUT = L3_EN_16;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_16;
             STATE_OUT = L3_EN_16;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_16;
             STATE_OUT = L3_EN_16;
          end
       end
       L3_CAL_16 :      begin //
          /*OB_CE2      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE2      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+324; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_16; STATE_OUT = L3_CAL_16;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_16; STATE_OUT = L3_CAL_16;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE2=0;OB_WE2=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_16; STATE_OUT = L3_CAL_16;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE2=1;OB_WE2=1;OB_ADDR=ADDR_COUNTER-24;EN_I=0;IB_CE=0; N_STATE = L3_CAL_16; STATE_OUT = L3_CAL_16;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE2=0;OB_WE2=0 ;OB_ADDR=ADDR_COUNTER-24 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_17; STATE_OUT = L3_CAL_16;
          end
       end
       L3_EN_17  :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+340; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_17;
             STATE_OUT = L3_EN_17 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_17;
             STATE_OUT = L3_EN_17;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_17;
             STATE_OUT = L3_EN_17;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_17;
             STATE_OUT = L3_EN_17;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_17;
             STATE_OUT = L3_EN_17;
          end
       end
       L3_CAL_17 :      begin //
          /*OB_CE2      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE2      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+344; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_17; STATE_OUT = L3_CAL_17;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_17; STATE_OUT = L3_CAL_17;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE2=0;OB_WE2=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_17; STATE_OUT = L3_CAL_17;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE2=1;OB_WE2=1;OB_ADDR=ADDR_COUNTER-23;EN_I=0;IB_CE=0; N_STATE = L3_CAL_17; STATE_OUT = L3_CAL_17;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE2=0;OB_WE2=0 ;OB_ADDR=ADDR_COUNTER-23 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_18; STATE_OUT = L3_CAL_17;
          end
       end
       L3_EN_18  :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+360; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_18;
             STATE_OUT = L3_EN_18 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_18;
             STATE_OUT = L3_EN_18;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_18;
             STATE_OUT = L3_EN_18;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_18;
             STATE_OUT = L3_EN_18;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_18;
             STATE_OUT = L3_EN_18;
          end
       end
       L3_CAL_18 :      begin //
          /*OB_CE2      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE2      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+364; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_18; STATE_OUT = L3_CAL_18;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_18; STATE_OUT = L3_CAL_18;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE2=0;OB_WE2=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_18; STATE_OUT = L3_CAL_18;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE2=1;OB_WE2=1;OB_ADDR=ADDR_COUNTER-22;EN_I=0;IB_CE=0; N_STATE = L3_CAL_18; STATE_OUT = L3_CAL_18;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE2=0;OB_WE2=0 ;OB_ADDR=ADDR_COUNTER-22 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_19; STATE_OUT = L3_CAL_18;
          end
       end
       L3_EN_19  :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+380; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_19;
             STATE_OUT = L3_EN_19 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_19;
             STATE_OUT = L3_EN_19;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_19;
             STATE_OUT = L3_EN_19;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_19;
             STATE_OUT = L3_EN_19;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_19;
             STATE_OUT = L3_EN_19;
          end
       end
       L3_CAL_19 :      begin //
          /*OB_CE2      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE2      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+384; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
       if(PREV_STATE != C_STATE)begin
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_19; STATE_OUT = L3_CAL_19;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_19; STATE_OUT = L3_CAL_19;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE2=0;OB_WE2=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_19; STATE_OUT = L3_CAL_19;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE2=1;OB_WE2=1;OB_ADDR=ADDR_COUNTER-21; EN_I=0;IB_CE=0; N_STATE = L3_CAL_19; STATE_OUT = L3_CAL_19;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE2=0;OB_WE2=0 ;OB_ADDR=ADDR_COUNTER-21 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_20; STATE_OUT = L3_CAL_19;
          end
       end
       L3_EN_20  :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+400; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_20;
             STATE_OUT = L3_EN_20 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_20;
             STATE_OUT = L3_EN_20;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_20;
             STATE_OUT = L3_EN_20;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_20;
             STATE_OUT = L3_EN_20;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_20;
             STATE_OUT = L3_EN_20;
          end
       end
       L3_CAL_20 :      begin //
          /*OB_CE2      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE2      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+404; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_20; STATE_OUT = L3_CAL_20;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_20; STATE_OUT = L3_CAL_20;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE2=0;OB_WE2=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_20; STATE_OUT = L3_CAL_20;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE2=1;OB_WE2=1;OB_ADDR=ADDR_COUNTER-20; EN_I=0;IB_CE=0; N_STATE = L3_CAL_20; STATE_OUT = L3_CAL_20;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE2=0;OB_WE2=0 ;OB_ADDR=ADDR_COUNTER-20 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_21; STATE_OUT = L3_CAL_20;
          end
       end
       L3_EN_21  :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+420; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_21;
             STATE_OUT = L3_EN_21 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_21;
             STATE_OUT = L3_EN_21;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_21;
             STATE_OUT = L3_EN_21;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_21;
             STATE_OUT = L3_EN_21;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_21;
             STATE_OUT = L3_EN_21;
          end
       end
       L3_CAL_21 :      begin //
          /*OB_CE2      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE2      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+424; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_21; STATE_OUT = L3_CAL_21;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_21; STATE_OUT = L3_CAL_21;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE2=0;OB_WE2=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_21; STATE_OUT = L3_CAL_21;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE2=1;OB_WE2=1;OB_ADDR=ADDR_COUNTER-19; EN_I=0;IB_CE=0; N_STATE = L3_CAL_21; STATE_OUT = L3_CAL_21;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE2=0;OB_WE2=0 ;OB_ADDR=ADDR_COUNTER-19 ;EN_I=0;IB_CE=0; N_STATE = L3_EN_22; STATE_OUT = L3_CAL_21;
          end
       end
       L3_EN_22  :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+440; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_22;
             STATE_OUT = L3_EN_22 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_22;
             STATE_OUT = L3_EN_22;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_22;
             STATE_OUT = L3_EN_22;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_22;
             STATE_OUT = L3_EN_22;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_22;
             STATE_OUT = L3_EN_22;
          end
       end
       L3_CAL_22 :      begin //
          /*OB_CE2      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE2      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+444; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_22; STATE_OUT = L3_CAL_22;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_22; STATE_OUT = L3_CAL_22;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE2=0;OB_WE2=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_22; STATE_OUT = L3_CAL_22;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE2=1;OB_WE2=1;OB_ADDR=ADDR_COUNTER-18; EN_I=0;IB_CE=0; N_STATE = L3_CAL_22; STATE_OUT = L3_CAL_22;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE2=0;OB_WE2=0 ;OB_ADDR=ADDR_COUNTER-18; EN_I=0;IB_CE=0; N_STATE = L3_EN_23; STATE_OUT = L3_CAL_22;
          end
       end
       L3_EN_23  :   begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+460; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_23;
             STATE_OUT = L3_EN_23 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_23;
             STATE_OUT = L3_EN_23;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_23;
             STATE_OUT = L3_EN_23;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_23;
             STATE_OUT = L3_EN_23;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_23;
             STATE_OUT = L3_EN_23;
          end
       end
       L3_CAL_23 :      begin //
          /*OB_CE2      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE3      = 0; OB_CE4      = 0; /*OB_WE2      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+464; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_23; STATE_OUT = L3_CAL_23;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE2=0;OB_WE2=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_23; STATE_OUT = L3_CAL_23;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE2=0;OB_WE2=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_23; STATE_OUT = L3_CAL_23;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE2=1;OB_WE2=1;OB_ADDR=ADDR_COUNTER-17; EN_I=0;IB_CE=0; N_STATE = L3_CAL_23; STATE_OUT = L3_CAL_23;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE2=0;OB_WE2=0 ;OB_ADDR=ADDR_COUNTER-17; EN_I=0;IB_CE=0; N_STATE = L3_EN_24; STATE_OUT = L3_CAL_23;
          end
       end
       L3_EN_24  :    begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+480; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_24;
             STATE_OUT = L3_EN_24 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_24;
             STATE_OUT = L3_EN_24;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_24;
             STATE_OUT = L3_EN_24;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_24;
             STATE_OUT = L3_EN_24;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_24;
             STATE_OUT = L3_EN_24;
          end
       end
       L3_CAL_24 :      begin //
          /*OB_CE3      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE2      = 0; OB_CE4      = 0; /*OB_WE3      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+484; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_24; STATE_OUT = L3_CAL_24;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_24; STATE_OUT = L3_CAL_24;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE3=0;OB_WE3=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_24; STATE_OUT = L3_CAL_24;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE3=1;OB_WE3=1;OB_ADDR=ADDR_COUNTER-24; EN_I=0;IB_CE=0; N_STATE = L3_CAL_24; STATE_OUT = L3_CAL_24;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE3=0;OB_WE3=0 ;OB_ADDR=ADDR_COUNTER-24; EN_I=0;IB_CE=0; N_STATE = L3_EN_25; STATE_OUT = L3_CAL_24;
          end
       end
       L3_EN_25  :    begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+500; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_25;
             STATE_OUT = L3_EN_25 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_25;
             STATE_OUT = L3_EN_25;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_25;
             STATE_OUT = L3_EN_25;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_25;
             STATE_OUT = L3_EN_25;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_25;
             STATE_OUT = L3_EN_25;
          end
       end
       L3_CAL_25 :      begin //
          /*OB_CE3      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE2      = 0; OB_CE4      = 0; /*OB_WE3      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+504; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_25; STATE_OUT = L3_CAL_25;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_25; STATE_OUT = L3_CAL_25;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE3=0;OB_WE3=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_25; STATE_OUT = L3_CAL_25;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE3=1;OB_WE3=1;OB_ADDR=ADDR_COUNTER-23; EN_I=0;IB_CE=0; N_STATE = L3_CAL_25; STATE_OUT = L3_CAL_25;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE3=0;OB_WE3=0 ;OB_ADDR=ADDR_COUNTER-23; EN_I=0;IB_CE=0; N_STATE = L3_EN_26; STATE_OUT = L3_CAL_25;
          end
       end
       L3_EN_26  :    begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+520; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_26;
             STATE_OUT = L3_EN_26 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_26;
             STATE_OUT = L3_EN_26;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_26;
             STATE_OUT = L3_EN_26;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_26;
             STATE_OUT = L3_EN_26;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_26;
             STATE_OUT = L3_EN_26;
          end
       end
       L3_CAL_26 :      begin //
          /*OB_CE3      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE2      = 0; OB_CE4      = 0; /*OB_WE3      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+524; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_26; STATE_OUT = L3_CAL_26;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_26; STATE_OUT = L3_CAL_26;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE3=0;OB_WE3=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_26; STATE_OUT = L3_CAL_26;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE3=1;OB_WE3=1;OB_ADDR=ADDR_COUNTER-22; EN_I=0;IB_CE=0; N_STATE = L3_CAL_26; STATE_OUT = L3_CAL_26;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE3=0;OB_WE3=0 ;OB_ADDR=ADDR_COUNTER-22; EN_I=0;IB_CE=0; N_STATE = L3_EN_27; STATE_OUT = L3_CAL_26;
          end
       end
       L3_EN_27  :    begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+540; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_27;
             STATE_OUT = L3_EN_27 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_27;
             STATE_OUT = L3_EN_27;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_27;
             STATE_OUT = L3_EN_27;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_27;
             STATE_OUT = L3_EN_27;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_27;
             STATE_OUT = L3_EN_27;
          end
       end
       L3_CAL_27 :      begin //
          /*OB_CE3      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE2      = 0; OB_CE4      = 0; /*OB_WE3      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+544; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_27; STATE_OUT = L3_CAL_27;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_27; STATE_OUT = L3_CAL_27;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE3=0;OB_WE3=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_27; STATE_OUT = L3_CAL_27;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE3=1;OB_WE3=1;OB_ADDR=ADDR_COUNTER-21; EN_I=0;IB_CE=0; N_STATE = L3_CAL_27; STATE_OUT = L3_CAL_27;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE3=0;OB_WE3=0 ;OB_ADDR=ADDR_COUNTER-21; EN_I=0;IB_CE=0; N_STATE = L3_EN_28; STATE_OUT = L3_CAL_27;
          end
       end
       L3_EN_28  :    begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+560; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_28;
             STATE_OUT = L3_EN_28 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_28;
             STATE_OUT = L3_EN_28;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_28;
             STATE_OUT = L3_EN_28;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_28;
             STATE_OUT = L3_EN_28;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_28;
             STATE_OUT = L3_EN_28;
          end
       end
       L3_CAL_28 :      begin //
          /*OB_CE3      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE2      = 0; OB_CE4      = 0; /*OB_WE3      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+564; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_28; STATE_OUT = L3_CAL_28;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_28; STATE_OUT = L3_CAL_28;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE3=0;OB_WE3=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_28; STATE_OUT = L3_CAL_28;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE3=1;OB_WE3=1;OB_ADDR=ADDR_COUNTER-20; EN_I=0;IB_CE=0; N_STATE = L3_CAL_28; STATE_OUT = L3_CAL_28;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE3=0;OB_WE3=0 ;OB_ADDR=ADDR_COUNTER-20; EN_I=0;IB_CE=0; N_STATE = L3_EN_29; STATE_OUT = L3_CAL_28;
          end
       end
       L3_EN_29  :    begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+580; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_29;
             STATE_OUT = L3_EN_29 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_29;
             STATE_OUT = L3_EN_29;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_29;
             STATE_OUT = L3_EN_29;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_29;
             STATE_OUT = L3_EN_29;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_29;
             STATE_OUT = L3_EN_29;
          end
       end
       L3_CAL_29 :      begin //
          /*OB_CE3      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE2      = 0; OB_CE4      = 0; /*OB_WE3      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+584; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_29; STATE_OUT = L3_CAL_29;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_29; STATE_OUT = L3_CAL_29;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE3=0;OB_WE3=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_29; STATE_OUT = L3_CAL_29;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE3=1;OB_WE3=1;OB_ADDR=ADDR_COUNTER-19; EN_I=0;IB_CE=0; N_STATE = L3_CAL_29; STATE_OUT = L3_CAL_29;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE3=0;OB_WE3=0 ;OB_ADDR=ADDR_COUNTER-19; EN_I=0;IB_CE=0; N_STATE = L3_EN_30; STATE_OUT = L3_CAL_29;
          end
       end
       L3_EN_30  :    begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+600; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_30;
             STATE_OUT = L3_EN_30 ;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_30;
             STATE_OUT = L3_EN_30;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_30;
             STATE_OUT = L3_EN_30;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_30;
             STATE_OUT = L3_EN_30;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_30;
             STATE_OUT = L3_EN_30;
          end
       end
       L3_CAL_30 :      begin //
          /*OB_CE3      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE2      = 0; OB_CE4      = 0; /*OB_WE3      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+604; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_30; STATE_OUT = L3_CAL_30;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_30; STATE_OUT = L3_CAL_30;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE3=0;OB_WE3=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_30; STATE_OUT = L3_CAL_30;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE3=1;OB_WE3=1;OB_ADDR=ADDR_COUNTER-18; EN_I=0;IB_CE=0; N_STATE = L3_CAL_30; STATE_OUT = L3_CAL_30;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE3=0;OB_WE3=0 ;OB_ADDR=ADDR_COUNTER-18; EN_I=0;IB_CE=0; N_STATE = L3_EN_31; STATE_OUT = L3_CAL_30;
          end
       end
       L3_EN_31  :     begin
          OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
          OB_ADDR  = 0;
          OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
          /*IB_CE  = 0;*/ IB_WE      = 0; IB_ADDR   = ADDR_COUNTER+620; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?�� 무조�?? 0?��. 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          /*EN_W =0;*/EN_I =0;

          if(ADDR_COUNTER == 0) begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_EN_31;
             STATE_OUT = L3_EN_31;
          end
          else if(ADDR_COUNTER >= 0 && ADDR_COUNTER <=3) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_EN_31;
             STATE_OUT = L3_EN_31;        
          end
          else if( ADDR_COUNTER == 4) begin
             EN_W   =1;
             IB_CE    =1;    
             N_STATE = L3_CAL_31;
             STATE_OUT = L3_EN_31;         
          end 
          else if(ADDR_COUNTER == 5)begin
             EN_W   =0;
             IB_CE    =1;    
             N_STATE = L3_CAL_31;
             STATE_OUT = L3_EN_31;               
          end
          else begin
             EN_W   =0;
             IB_CE    =0;            
             N_STATE = L3_EN_31;
             STATE_OUT = L3_EN_31;
          end
       end
       L3_CAL_31 :      begin //
          /*OB_CE3      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE2      = 0; OB_CE4      = 0; /*OB_WE3      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE4      = 0; 
          /*OB_ADDR0  = 0;*/
          OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
          // INPUT_BRAM?��?�� ?��?��?�� 값을 빼�??�� ?���?? ?��문에 처음 4CLK?? INPUT BRAM?��?�� weight�?? 빼우�?? ?���?? 625 CLK?? INPUT BRAM?��?�� PEARRAY?�� INPUT?�� 빼옴. 
          /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER+624; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
          IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
          //?��기�??�� 
          PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
          PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
          PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
          PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
          //?��기까�???�� �?? ?��?�� ?�� 까�? 바�? ?�� ?��?��. 
          EN_W =0; /*EN_I =0;*/
          if(PREV_STATE != C_STATE)begin
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=0;IB_CE=0; N_STATE = L3_CAL_31; STATE_OUT = L3_CAL_31;
          end
          else if (ADDR_COUNTER >= 0 && ADDR_COUNTER < 17) begin // ?��?��1개들?��?���?? 15?��?�� IB_CE꺼버�??
             OB_CE3=0;OB_WE3=0;OB_ADDR=0 ;EN_I=1;IB_CE=1; N_STATE = L3_CAL_31; STATE_OUT = L3_CAL_31;
          end
          else if (ADDR_COUNTER >= 17 && ADDR_COUNTER < 24) begin //처음 ?��?��?��?��?�� ?��?�� 15번만 OUT_BRAM켜둠
             OB_CE3=0;OB_WE3=0;OB_ADDR=0;EN_I=0;IB_CE=0; N_STATE = L3_CAL_31; STATE_OUT = L3_CAL_31;
          end
          else if ( ADDR_COUNTER>=24 && ADDR_COUNTER <25) begin // OUTPUT?��?���?? ?��?��?���??�?? 켜줌
             OB_CE3=1;OB_WE3=1;OB_ADDR=ADDR_COUNTER-17; EN_I=0;IB_CE=0; N_STATE = L3_CAL_31; STATE_OUT = L3_CAL_31;
       end
          else  begin //OUTPUT BRAM �?? ?�� ?��?���??�?? 0?���??, ?��?��?��?�� �??�??
             OB_CE3=0;OB_WE3=0 ;OB_ADDR=ADDR_COUNTER-17; EN_I=0;IB_CE=0; N_STATE = L4_INPUT_BRAM; STATE_OUT = L3_CAL_31;
          end
       end

    //L4
    L4_INPUT_BRAM :    begin
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       IB_CE      = 0;  IB_WE      = 0; IB_ADDR   = 0; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       EN_W =0; EN_I =0;

       if(STATE_IN == 7'd87)begin
          N_STATE = L4_EN_0;
          STATE_OUT = L4_INPUT_BRAM;
       end
       else begin
          N_STATE = L4_INPUT_BRAM;
          STATE_OUT = L4_INPUT_BRAM;
       end
 
    end  
    L4_EN_0  :     begin
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       /*IB_CE  = 0;*/ IB_WE      = 0; IB_D[0]= 0; IB_D[1] = 0; IB_D[2] = 0; IB_D[3] = 0; IB_D[4] = 0; IB_D[5] = 0; IB_D[6] = 0; IB_D[7] = 0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; // IB_D?? ?????? 0??. 
       //??????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15];          
       //????????? ?? ???? ?? ???? ??? ?? ????. 
       EN_W =0;/*EN_I =0;*/

       if(ADDR_COUNTER == 0) begin
          EN_I   =0;
          IB_CE    =1;    
          N_STATE = L4_EN_0;
          STATE_OUT = L4_EN_0;
          IB_ADDR   = ADDR_COUNTER;        
       end
       else if( ADDR_COUNTER == 1) begin
          EN_I   =1;
          IB_CE    =1;    
          N_STATE = L4_CAL_0;
          STATE_OUT = L4_EN_0; 
          IB_ADDR   = ADDR_COUNTER;         
       end 
       else if(ADDR_COUNTER == 2)begin
          EN_I   =0;
          IB_CE    =1;    
          N_STATE = L4_CAL_0;
          STATE_OUT = L4_EN_0;
          IB_ADDR   = ADDR_COUNTER-1;             
       end
       else if(ADDR_COUNTER > 2)begin
          EN_I   =0;
          IB_CE    =0;            
          N_STATE = L4_EN_0;
          STATE_OUT = L4_EN_0;
       end
    end
    L4_CAL_0 :       begin //
       /*OB_CE4      = 0;*/  OB_CE0      = 0; OB_CE1     = 0; OB_CE2      = 0; OB_CE3      = 0; /*OB_WE4      = 0;*/ OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; 
       /*OB_ADDR0  = 0;*/
       OB_D[0]  = PE_OUT[0];  OB_D[1]  = PE_OUT[1]; OB_D[2]  = PE_OUT[2]; OB_D[3]  = PE_OUT[3];
       // INPUT_BRAM???? ?????? ???? ????? ??? ?????? ??? 4CLK?? INPUT BRAM???? weight?? ????? ???? 625 CLK?? INPUT BRAM???? PEARRAY?? INPUT?? ????. 
       /*IB_CE      = 0;*/  IB_WE     = 0; IB_ADDR   = ADDR_COUNTER; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       //??????? 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       //????????? ?? ???? ?? ???? ??? ?? ????. 
       /*EN_W =0;*/ EN_I =0;
       if (C_STATE != PREV_STATE) begin
       OB_CE1=0; OB_WE1=0; OB_ADDR = 0;EN_W=0;IB_CE=0; N_STATE = L4_CAL_0 ;STATE_OUT = L4_CAL_0;
       end
       else if (ADDR_COUNTER < 2) begin // ???10?????? 10???? enable_W????
          //out_bram enable??? 0???? ???? 
          OB_CE1=0; OB_WE1=0; OB_ADDR = 0;EN_W=0;IB_CE=1; N_STATE = L4_CAL_0 ;STATE_OUT = L4_CAL_0;
       end 
       else if (ADDR_COUNTER >= 2 && ADDR_COUNTER < 22) begin // ???10???????? 15??? IB_CE??????
          OB_CE1=0;OB_WE1=0;OB_ADDR=0 ;EN_W=1;IB_CE=1; N_STATE = L4_CAL_0; STATE_OUT = L4_CAL_0;
       end
       else if (ADDR_COUNTER >= 22 && ADDR_COUNTER < 27) begin //??? ???????? ???? 15???? OUT_BRAM???
          OB_CE1=1;OB_WE1=1; OB_ADDR=ADDR_COUNTER-22; EN_W=1;IB_CE=1; N_STATE = L4_CAL_0; STATE_OUT = L4_CAL_0;
       end
       else if ( ADDR_COUNTER>=27 && ADDR_COUNTER <35) begin // OUTPUT?????? ???????? ????
          OB_CE1=1;OB_WE1=1;OB_ADDR=ADDR_COUNTER-22;EN_W=0;IB_CE=0; N_STATE = L4_CAL_0; STATE_OUT = L4_CAL_0;
       end
       else  begin //OUTPUT BRAM ?? ?? ??????? 0????, ??????? ????
          OB_CE1=0;OB_WE1=0 ;OB_ADDR=ADDR_COUNTER-22 ;EN_W=0;IB_CE=0; N_STATE = IDLE; STATE_OUT = L4_CAL_0;
       end
    end
    default:begin
       OB_CE0      = 0;  OB_CE1      = 0; OB_CE2     = 0; OB_CE3      = 0; OB_CE4      = 0; OB_WE0      = 0; OB_WE1      = 0; OB_WE2      = 0; OB_WE3      = 0; OB_WE4      = 0; 
       OB_ADDR  = 0;
       OB_D[0]  = 0;  OB_D[1]  = 0; OB_D[2]  = 0; OB_D[3]  = 0;
       IB_CE      = 0;  IB_WE      = 0; IB_ADDR   = 0; IB_D[0]    = 0; IB_D[1]    = 0; IB_D[2]   = 0; IB_D[3]   = 0; IB_D[4]  = 0; IB_D[5]  =0; IB_D[6]  =0; IB_D[7]  =0; 
       IB_D[8]   = 0;  IB_D[9]   = 0; IB_D[10]  = 0; IB_D[11]   = 0; IB_D[12]   = 0; IB_D[13]  = 0; IB_D[14]  = 0; IB_D[15] = 0; 
       PE_INPUT_DATA[0] = IB_Q[0];  PE_INPUT_DATA[1] = IB_Q[1]; PE_INPUT_DATA[2] = IB_Q[2];  PE_INPUT_DATA[3]  = IB_Q[3]; 
       PE_INPUT_DATA[4] = IB_Q[4];  PE_INPUT_DATA[5] = IB_Q[5]; PE_INPUT_DATA[6] = IB_Q[6];  PE_INPUT_DATA[7]  = IB_Q[7];
       PE_INPUT_DATA[8] = IB_Q[8];  PE_INPUT_DATA[9] = IB_Q[9]; PE_INPUT_DATA[10]= IB_Q[10]; PE_INPUT_DATA[11] = IB_Q[11];
       PE_INPUT_DATA[12] =IB_Q[12]; PE_INPUT_DATA[13] =IB_Q[13];PE_INPUT_DATA[14]= IB_Q[14]; PE_INPUT_DATA[15] = IB_Q[15]; 
       EN_W =0; EN_I =0;
          N_STATE = IDLE;
          STATE_OUT = IDLE;
       end
    endcase
 end
//////////////////////////////////////////////////////////////////////////////////

endmodule 
