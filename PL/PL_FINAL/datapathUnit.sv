module datapathUnit #(parameter mode_N=16)
(
    input CLK,
    input RSTN,
    input clk_ws_enable,
    input enW_i,
    input enI_i,
    input [511:0] In_i,
    output signed [31:0] out_fin_1,
    output signed [31:0] out_fin_2,
    output signed [31:0] out_fin_3,
    output signed [31:0] out_fin_4
);

    // Enable Input
    reg r_enI_i;
    reg r_en_w1,r_en_w2,r_en_w3,r_en_w4;


    always @(posedge CLK or negedge RSTN) begin
        if (!RSTN) begin
            next_In_1 <= 0; 
            next_In_2 <= 0; 
            next_In_3 <= 0; 
            next_In_4 <= 0; 
            next_In_5 <= 0; 
            next_In_6 <= 0; 
            next_In_7 <= 0; 
            next_In_8 <= 0; 
            next_In_9 <= 0; 
            next_In_a <= 0; 
            next_In_b <= 0; 
            next_In_c <= 0; 
            next_In_d <= 0; 
            next_In_e <= 0; 
            next_In_f <= 0; 
            next_In_F <= 0;
            r_enI_i <= 1'b0;
            r_en_w1 <= 0;
            r_en_w2 <= 0;
            r_en_w3 <= 0;
            r_en_w4 <= 0;
        end
        else if (clk_ws_enable)begin
            if (enI_i == 1'b1) begin //INPUT ?��?���?
                next_In_1 <= In_i[511:480]; 
                next_In_2 <= In_i[479:448]; 
                next_In_3 <= In_i[447:416]; 
                next_In_4 <= In_i[415:384]; 
                next_In_5 <= In_i[383:352]; 
                next_In_6 <= In_i[351:320]; 
                next_In_7 <= In_i[319:288]; 
                next_In_8 <= In_i[287:256]; 
                next_In_9 <= In_i[255:224]; 
                next_In_a <= In_i[223:192]; 
                next_In_b <= In_i[191:160]; 
                next_In_c <= In_i[159:128]; 
                next_In_d <= In_i[127:96];  
                next_In_e <= In_i[95:64];   
                next_In_f <= In_i[63:32];   
                next_In_F <= In_i[31:0];    
                r_enI_i <= 1'b1;
                r_en_w1 <= 0;
                r_en_w2 <= 0;
                r_en_w3 <= 0;
                r_en_w4 <= 0;
            end
            else if (enW_i == 1'b1) begin //Weight�? �??���?
                r_en_w1 <=1;
                r_en_w2 <= r_en_w1;
                r_en_w3 <= r_en_w2;
                r_en_w4 <= r_en_w3;
                next_In_1 <=  In_i[511:480];
                next_In_2 <=  In_i[479:448];
                next_In_3 <=  In_i[447:416];
                next_In_4 <=  In_i[415:384];
                next_In_5 <=  In_i[383:352];
                next_In_6 <=  In_i[351:320];
                next_In_7 <=  In_i[319:288];
                next_In_8 <=  In_i[287:256];
                next_In_9 <=  In_i[255:224];
                next_In_a <=  In_i[223:192];
                next_In_b <=  In_i[191:160];
                next_In_c <=  In_i[159:128];
                next_In_d <=  In_i[127:96]; 
                next_In_e <=  In_i[95:64];  
                next_In_f <=  In_i[63:32];  
                next_In_F <=  In_i[31:0];   
                r_enI_i <= 0;
            end
            else begin
            r_enI_i <= 0;
            r_en_w1 <= 0;
            r_en_w2 <= 0;
            r_en_w3 <= 0;
            r_en_w4 <= 0;
            end
        end
    end

    // Entire Column Output
    reg signed [31:0] out_col_12, out_col_13, out_col_14, out_col_15;
    reg signed [31:0] out_col_23, out_col_24, out_col_25;
    reg signed [31:0] out_col_34, out_col_35;
    reg signed [31:0] out_col_45;

    // Global Output (16bits, 8bits)
    wire signed [31:0] out_1, out_2, out_3, out_4;


    
  

    //Zero Signal for output Each MAC
    wire Zero_11, Zero_12, Zero_13, Zero_14, Zero_15, Zero_16, Zero_17, Zero_18, Zero_19, Zero_1a, Zero_1b, Zero_1c, Zero_1d, Zero_1e, Zero_1f, Zero_1F;
    wire Zero_21, Zero_22, Zero_23, Zero_24, Zero_25, Zero_26, Zero_27, Zero_28, Zero_29, Zero_2a, Zero_2b, Zero_2c, Zero_2d, Zero_2e, Zero_2f, Zero_2F;
    wire Zero_31, Zero_32, Zero_33, Zero_34, Zero_35, Zero_36, Zero_37, Zero_38, Zero_39, Zero_3a, Zero_3b, Zero_3c, Zero_3d, Zero_3e, Zero_3f, Zero_3F;
    wire Zero_41, Zero_42, Zero_43, Zero_44, Zero_45, Zero_46, Zero_47, Zero_48, Zero_49, Zero_4a, Zero_4b, Zero_4c, Zero_4d, Zero_4e, Zero_4f, Zero_4F;


    //Zero Signal for output Each MAC
    wire out_Zero_11, out_Zero_12, out_Zero_13, out_Zero_14, out_Zero_15, out_Zero_16, out_Zero_17, out_Zero_18, out_Zero_19, out_Zero_1a, out_Zero_1b, out_Zero_1c, out_Zero_1d, out_Zero_1e, out_Zero_1f, out_Zero_1F;    
    wire out_Zero_21, out_Zero_22, out_Zero_23, out_Zero_24, out_Zero_25, out_Zero_26, out_Zero_27, out_Zero_28, out_Zero_29, out_Zero_2a, out_Zero_2b, out_Zero_2c, out_Zero_2d, out_Zero_2e, out_Zero_2f, out_Zero_2F;    
    wire out_Zero_31, out_Zero_32, out_Zero_33, out_Zero_34, out_Zero_35, out_Zero_36, out_Zero_37, out_Zero_38, out_Zero_39, out_Zero_3a, out_Zero_3b, out_Zero_3c, out_Zero_3d, out_Zero_3e, out_Zero_3f, out_Zero_3F;    
    wire out_Zero_41, out_Zero_42, out_Zero_43, out_Zero_44, out_Zero_45, out_Zero_46, out_Zero_47, out_Zero_48, out_Zero_49, out_Zero_4a, out_Zero_4b, out_Zero_4c, out_Zero_4d, out_Zero_4e, out_Zero_4f, out_Zero_4F;    


    //en Signal for output Each MAC
    wire out_en_11, out_en_12, out_en_13, out_en_14, out_en_15, out_en_16, out_en_17, out_en_18, out_en_19, out_en_1a, out_en_1b, out_en_1c, out_en_1d, out_en_1e, out_en_1f, out_en_1F;
    wire out_en_21, out_en_22, out_en_23, out_en_24, out_en_25, out_en_26, out_en_27, out_en_28, out_en_29, out_en_2a, out_en_2b, out_en_2c, out_en_2d, out_en_2e, out_en_2f, out_en_2F;
    wire out_en_31, out_en_32, out_en_33, out_en_34, out_en_35, out_en_36, out_en_37, out_en_38, out_en_39, out_en_3a, out_en_3b, out_en_3c, out_en_3d, out_en_3e, out_en_3f, out_en_3F;
    wire out_en_41, out_en_42, out_en_43, out_en_44, out_en_45, out_en_46, out_en_47, out_en_48, out_en_49, out_en_4a, out_en_4b, out_en_4c, out_en_4d, out_en_4e, out_en_4f, out_en_4F;
   

   

    // Output Each MAC
    wire signed [31:0] out_11, out_12, out_13, out_14, out_15, out_16, out_17, out_18, out_19, out_1a, out_1b, out_1c, out_1d, out_1e, out_1f, out_1F;
    wire signed [31:0] out_21, out_22, out_23, out_24, out_25, out_26, out_27, out_28, out_29, out_2a, out_2b, out_2c, out_2d, out_2e, out_2f, out_2F;
    wire signed [31:0] out_31, out_32, out_33, out_34, out_35, out_36, out_37, out_38, out_39, out_3a, out_3b, out_3c, out_3d, out_3e, out_3f, out_3F;
    wire signed [31:0] out_41, out_42, out_43, out_44, out_45, out_46, out_47, out_48, out_49, out_4a, out_4b, out_4c, out_4d, out_4e, out_4f, out_4F;


    // Next Mode-N Each MAC
    wire [4:0] next_N_11, next_N_12, next_N_13, next_N_14, next_N_15, next_N_16, next_N_17, next_N_18, next_N_19, next_N_1a, next_N_1b, next_N_1c, next_N_1d, next_N_1e, next_N_1f, next_N_1F;
    wire [4:0] next_N_21, next_N_22, next_N_23, next_N_24, next_N_25, next_N_26, next_N_27, next_N_28, next_N_29, next_N_2a, next_N_2b, next_N_2c, next_N_2d, next_N_2e, next_N_2f, next_N_2F;
    wire [4:0] next_N_31, next_N_32, next_N_33, next_N_34, next_N_35, next_N_36, next_N_37, next_N_38, next_N_39, next_N_3a, next_N_3b, next_N_3c, next_N_3d, next_N_3e, next_N_3f, next_N_3F;
    wire [4:0] next_N_41, next_N_42, next_N_43, next_N_44, next_N_45, next_N_46, next_N_47, next_N_48, next_N_49, next_N_4a, next_N_4b, next_N_4c, next_N_4d, next_N_4e, next_N_4f, next_N_4F;
  

    // Next Input Each MAC
    reg signed [31:0] next_In_1, next_In_2, next_In_3, next_In_4, next_In_5, next_In_6, next_In_7, next_In_8, next_In_9, next_In_a, next_In_b, next_In_c, next_In_d, next_In_e, next_In_f, next_In_F;
    wire signed [31:0] next_In_11, next_In_12, next_In_13, next_In_14, next_In_15, next_In_16, next_In_17, next_In_18, next_In_19, next_In_1a, next_In_1b, next_In_1c, next_In_1d, next_In_1e, next_In_1f, next_In_1F;
    wire signed [31:0] next_In_21, next_In_22, next_In_23, next_In_24, next_In_25, next_In_26, next_In_27, next_In_28, next_In_29, next_In_2a, next_In_2b, next_In_2c, next_In_2d, next_In_2e, next_In_2f, next_In_2F;
    wire signed [31:0] next_In_31, next_In_32, next_In_33, next_In_34, next_In_35, next_In_36, next_In_37, next_In_38, next_In_39, next_In_3a, next_In_3b, next_In_3c, next_In_3d, next_In_3e, next_In_3f, next_In_3F;
    wire signed [31:0] next_In_41, next_In_42, next_In_43, next_In_44, next_In_45, next_In_46, next_In_47, next_In_48, next_In_49, next_In_4a, next_In_4b, next_In_4c, next_In_4d, next_In_4e, next_In_4f, next_In_4F;

    // Next Row Enable Each MAC
    wire next_en_row_11, next_en_row_12, next_en_row_13, next_en_row_14, next_en_row_15, next_en_row_16, next_en_row_17, next_en_row_18, next_en_row_19, next_en_row_1a, next_en_row_1b, next_en_row_1c, next_en_row_1d, next_en_row_1e, next_en_row_1f, next_en_row_1F;
    wire next_en_row_21, next_en_row_22, next_en_row_23, next_en_row_24, next_en_row_25, next_en_row_26, next_en_row_27, next_en_row_28, next_en_row_29, next_en_row_2a, next_en_row_2b, next_en_row_2c, next_en_row_2d, next_en_row_2e, next_en_row_2f, next_en_row_2F;
    wire next_en_row_31, next_en_row_32, next_en_row_33, next_en_row_34, next_en_row_35, next_en_row_36, next_en_row_37, next_en_row_38, next_en_row_39, next_en_row_3a, next_en_row_3b, next_en_row_3c, next_en_row_3d, next_en_row_3e, next_en_row_3f, next_en_row_3F;
    wire next_en_row_41, next_en_row_42, next_en_row_43, next_en_row_44, next_en_row_45, next_en_row_46, next_en_row_47, next_en_row_48, next_en_row_49, next_en_row_4a, next_en_row_4b, next_en_row_4c, next_en_row_4d, next_en_row_4e, next_en_row_4f, next_en_row_4F;
 



    // Make Column Output
    always @(posedge CLK or negedge RSTN) begin
        if (!RSTN) begin
            out_col_12 <= 31'h00;
            out_col_13 <= 31'h00;
            out_col_14 <= 31'h00;
            out_col_15 <= 31'h00;
            out_col_23 <= 31'h00;
            out_col_24 <= 31'h00;
            out_col_25 <= 31'h00;
            out_col_34 <= 31'h00;
            out_col_35 <= 31'h00;
            out_col_45 <= 31'h00;
        end
        else begin
        if (clk_ws_enable) begin
            out_col_12 <= out_1;
            out_col_13 <= out_col_12;
            out_col_14 <= out_col_13;
            out_col_15 <= out_col_14;
            out_col_23 <= out_2;
            out_col_24 <= out_col_23;
            out_col_25 <= out_col_24;
            out_col_34 <= out_3;
            out_col_35 <= out_col_34;
            out_col_45 <= out_4;
        end
        else begin
            out_col_12 <= 31'h00;
            out_col_13 <= 31'h00;
            out_col_14 <= 31'h00;
            out_col_15 <= 31'h00;
            out_col_23 <= 31'h00;
            out_col_24 <= 31'h00;
            out_col_25 <= 31'h00;
            out_col_34 <= 31'h00;
            out_col_35 <= 31'h00;
            out_col_45 <= 31'h00;
        end
        end
    end



    // Instantiate Row 1
    singleMAC MAC11 (CLK, RSTN,clk_ws_enable, r_en_w1, r_enI_i,  mode_N,    32'h0,  next_In_1, out_11, next_In_11, next_N_11, Zero_11, next_en_row_11,out_Zero_11, out_en_11);
    singleMAC MAC12 (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_11, next_N_11, out_11, next_In_2, out_12, next_In_12, next_N_12,  Zero_12, next_en_row_12, out_Zero_12, out_en_12);
    singleMAC MAC13 (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_12, next_N_12, out_12, next_In_3, out_13, next_In_13, next_N_13,  Zero_13, next_en_row_13, out_Zero_13, out_en_13);
    singleMAC MAC14 (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_13, next_N_13, out_13, next_In_4, out_14, next_In_14, next_N_14,  Zero_14, next_en_row_14, out_Zero_14, out_en_14);
    singleMAC MAC15 (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_14, next_N_14, out_14, next_In_5, out_15, next_In_15, next_N_15,  Zero_15, next_en_row_15, out_Zero_15, out_en_15);
    singleMAC MAC16 (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_15, next_N_15, out_15, next_In_6, out_16, next_In_16, next_N_16,  Zero_16, next_en_row_16, out_Zero_16, out_en_16);
    singleMAC MAC17 (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_16, next_N_16, out_16, next_In_7, out_17, next_In_17, next_N_17,  Zero_17, next_en_row_17, out_Zero_17, out_en_17);
    singleMAC MAC18 (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_17, next_N_17, out_17, next_In_8, out_18, next_In_18, next_N_18,  Zero_18, next_en_row_18, out_Zero_18, out_en_18);
    singleMAC MAC19 (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_18, next_N_18, out_18, next_In_9, out_19, next_In_19, next_N_19,  Zero_19, next_en_row_19, out_Zero_19, out_en_19);
    singleMAC MAC1a (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_19, next_N_19, out_19, next_In_a, out_1a, next_In_1a, next_N_1a,  Zero_1a, next_en_row_1a, out_Zero_1a, out_en_1a);
    singleMAC MAC1b (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_1a, next_N_1a, out_1a, next_In_b, out_1b, next_In_1b, next_N_1b,  Zero_1b, next_en_row_1b, out_Zero_1b, out_en_1b);
    singleMAC MAC1c (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_1b, next_N_1b, out_1b, next_In_c, out_1c, next_In_1c, next_N_1c,  Zero_1c, next_en_row_1c, out_Zero_1c, out_en_1c);
    singleMAC MAC1d (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_1c, next_N_1c, out_1c, next_In_d,  out_1d, next_In_1d, next_N_1d, Zero_1d, next_en_row_1d, out_Zero_1d, out_en_1d);
    singleMAC MAC1e (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_1d, next_N_1d, out_1d, next_In_e,  out_1e, next_In_1e, next_N_1e, Zero_1e, next_en_row_1e, out_Zero_1e, out_en_1e);
    singleMAC MAC1f (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_1e, next_N_1e, out_1e, next_In_f,  out_1f, next_In_1f, next_N_1f, Zero_1f, next_en_row_1f, out_Zero_1f, out_en_1f);
    singleMAC MAC1F (CLK, RSTN,clk_ws_enable, r_en_w1, !Zero_1f, next_N_1f, out_1f, next_In_F,  out_1F, next_In_1F, next_N_1F, Zero_1F, next_en_row_1F, out_Zero_1F, out_en_1F);


    // Instantiate Row 2
    singleMAC MAC21 (CLK, RSTN,clk_ws_enable, r_en_w2, next_en_row_11,  mode_N,  32'h0000, next_In_11, out_21, next_In_21, next_N_21, Zero_21, next_en_row_21, out_Zero_21, out_en_21);
    singleMAC MAC22 (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_21, next_N_21, out_21, next_In_12, out_22, next_In_22, next_N_22,   Zero_22, next_en_row_22, out_Zero_22, out_en_22);
    singleMAC MAC23 (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_22, next_N_22, out_22, next_In_13, out_23, next_In_23, next_N_23,   Zero_23, next_en_row_23, out_Zero_23, out_en_23);
    singleMAC MAC24 (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_23, next_N_23, out_23, next_In_14, out_24, next_In_24, next_N_24,   Zero_24, next_en_row_24, out_Zero_24, out_en_24);
    singleMAC MAC25 (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_24, next_N_24, out_24, next_In_15, out_25, next_In_25, next_N_25,   Zero_25, next_en_row_25, out_Zero_25, out_en_25);
    singleMAC MAC26 (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_25, next_N_25, out_25, next_In_16, out_26, next_In_26, next_N_26,   Zero_26, next_en_row_26, out_Zero_26, out_en_26);
    singleMAC MAC27 (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_26, next_N_26, out_26, next_In_17, out_27, next_In_27, next_N_27,   Zero_27, next_en_row_27, out_Zero_27, out_en_27);
    singleMAC MAC28 (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_27, next_N_27, out_27, next_In_18, out_28, next_In_28, next_N_28,   Zero_28, next_en_row_28, out_Zero_28, out_en_28);
    singleMAC MAC29 (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_28, next_N_28, out_28, next_In_19, out_29, next_In_29, next_N_29,   Zero_29, next_en_row_29, out_Zero_29, out_en_29);
    singleMAC MAC2a (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_29, next_N_29, out_29, next_In_1a, out_2a, next_In_2a, next_N_2a,   Zero_2a, next_en_row_2a, out_Zero_2a, out_en_2a);
    singleMAC MAC2b (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_2a, next_N_2a, out_2a, next_In_1b, out_2b, next_In_2b, next_N_2b,   Zero_2b, next_en_row_2b, out_Zero_2b, out_en_2b);
    singleMAC MAC2c (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_2b, next_N_2b, out_2b, next_In_1c, out_2c, next_In_2c, next_N_2c,   Zero_2c, next_en_row_2c, out_Zero_2c, out_en_2c);
    singleMAC MAC2d (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_2c, next_N_2c, out_2c, next_In_1d, out_2d, next_In_2d, next_N_2d,   Zero_2d, next_en_row_2d, out_Zero_2d, out_en_2d);
    singleMAC MAC2e (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_2d, next_N_2d, out_2d,   next_In_1e, out_2e, next_In_2e, next_N_2e, Zero_2e, next_en_row_2e, out_Zero_2e, out_en_2e);
    singleMAC MAC2f (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_2e, next_N_2e, out_2e,   next_In_1f, out_2f, next_In_2f, next_N_2f, Zero_2f, next_en_row_2f,  out_Zero_2f, out_en_2f);
    singleMAC MAC2F (CLK, RSTN,clk_ws_enable, r_en_w2, !Zero_2f, next_N_2f, out_2f,   next_In_1F, out_2F, next_In_2F, next_N_2F, Zero_2F, next_en_row_2F, out_Zero_2F, out_en_2F);

    // Instantiate Row 3
    singleMAC MAC31 (CLK, RSTN,clk_ws_enable, r_en_w3, next_en_row_21, mode_N, 32'h0000,   next_In_21, out_31, next_In_31, next_N_31, Zero_31, next_en_row_31, out_Zero_31, out_en_31);
    singleMAC MAC32 (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_31, next_N_31, out_31,  next_In_22, out_32, next_In_32, next_N_32, Zero_32, next_en_row_32, out_Zero_32, out_en_32);
    singleMAC MAC33 (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_32, next_N_32, out_32,  next_In_23, out_33, next_In_33, next_N_33, Zero_33, next_en_row_33, out_Zero_33, out_en_33);
    singleMAC MAC34 (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_33, next_N_33, out_33,  next_In_24, out_34, next_In_34, next_N_34, Zero_34, next_en_row_34, out_Zero_34, out_en_34);
    singleMAC MAC35 (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_34, next_N_34, out_34,  next_In_25, out_35, next_In_35, next_N_35, Zero_35, next_en_row_35, out_Zero_35, out_en_35);
    singleMAC MAC36 (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_35, next_N_35, out_35,  next_In_26, out_36, next_In_36, next_N_36, Zero_36, next_en_row_36, out_Zero_36, out_en_36);
    singleMAC MAC37 (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_36, next_N_36, out_36,  next_In_27, out_37, next_In_37, next_N_37, Zero_37, next_en_row_37, out_Zero_37, out_en_37);
    singleMAC MAC38 (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_37, next_N_37, out_37,  next_In_28, out_38, next_In_38, next_N_38, Zero_38, next_en_row_38, out_Zero_38, out_en_38);
    singleMAC MAC39 (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_38, next_N_38, out_38,  next_In_29, out_39, next_In_39, next_N_39, Zero_39, next_en_row_39, out_Zero_39, out_en_39);
    singleMAC MAC3a (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_39, next_N_39, out_39,  next_In_2a, out_3a, next_In_3a, next_N_3a, Zero_3a, next_en_row_3a, out_Zero_3a, out_en_3a);
    singleMAC MAC3b (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_3a, next_N_3a, out_3a,  next_In_2b, out_3b, next_In_3b, next_N_3b, Zero_3b, next_en_row_3b, out_Zero_3b, out_en_3b);
    singleMAC MAC3c (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_3b, next_N_3b, out_3b,  next_In_2c, out_3c, next_In_3c, next_N_3c, Zero_3c, next_en_row_3c, out_Zero_3c, out_en_3c);
    singleMAC MAC3d (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_3c, next_N_3c, out_3c,  next_In_2d, out_3d, next_In_3d, next_N_3d, Zero_3d, next_en_row_3d, out_Zero_3d, out_en_3d);
    singleMAC MAC3e (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_3d, next_N_3d, out_3d,  next_In_2e, out_3e, next_In_3e, next_N_3e, Zero_3e, next_en_row_3e, out_Zero_3e, out_en_3e);
    singleMAC MAC3f (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_3e, next_N_3e, out_3e,  next_In_2f, out_3f, next_In_3f, next_N_3f, Zero_3f, next_en_row_3f, out_Zero_3f, out_en_3f);
    singleMAC MAC3F (CLK, RSTN,clk_ws_enable, r_en_w3, !Zero_3f, next_N_3f, out_3f,  next_In_2F, out_3F, next_In_3F, next_N_3F, Zero_3F, next_en_row_3F, out_Zero_3F, out_en_3F);
    
    // Instantiate Row 4
    singleMAC MAC41 (CLK, RSTN,clk_ws_enable, r_en_w4, next_en_row_31, mode_N, 32'h0000,  next_In_31, out_41, next_In_41, next_N_41,  Zero_41, next_en_row_41,out_Zero_41, out_en_41);
    singleMAC MAC42 (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_41, next_N_41, out_41, next_In_32, out_42, next_In_42, next_N_42,  Zero_42, next_en_row_42, out_Zero_42, out_en_42);
    singleMAC MAC43 (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_42, next_N_42, out_42,  next_In_33, out_43, next_In_43, next_N_43, Zero_43, next_en_row_43, out_Zero_43, out_en_43);
    singleMAC MAC44 (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_43, next_N_43, out_43, next_In_34, out_44, next_In_44, next_N_44,  Zero_44, next_en_row_44, out_Zero_44, out_en_44);
    singleMAC MAC45 (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_44, next_N_44, out_44, next_In_35, out_45, next_In_45, next_N_45,  Zero_45, next_en_row_45, out_Zero_45, out_en_45);
    singleMAC MAC46 (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_45, next_N_45, out_45, next_In_36, out_46, next_In_46, next_N_46,  Zero_46, next_en_row_46, out_Zero_46, out_en_46);
    singleMAC MAC47 (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_46, next_N_46, out_46, next_In_37, out_47, next_In_47, next_N_47,  Zero_47, next_en_row_47, out_Zero_47, out_en_47);
    singleMAC MAC48 (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_47, next_N_47, out_47, next_In_38, out_48, next_In_48, next_N_48,  Zero_48, next_en_row_48, out_Zero_48, out_en_48);
    singleMAC MAC49 (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_48, next_N_48, out_48, next_In_39, out_49, next_In_49, next_N_49,  Zero_49, next_en_row_49, out_Zero_49, out_en_49);
    singleMAC MAC4a (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_49, next_N_49, out_49, next_In_3a, out_4a, next_In_4a, next_N_4a,  Zero_4a, next_en_row_4a, out_Zero_4a, out_en_4a);
    singleMAC MAC4b (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_4a, next_N_4a, out_4a, next_In_3b, out_4b, next_In_4b, next_N_4b,  Zero_4b, next_en_row_4b, out_Zero_4b, out_en_4b);
    singleMAC MAC4c (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_4b, next_N_4b, out_4b, next_In_3c, out_4c, next_In_4c, next_N_4c,  Zero_4c, next_en_row_4c, out_Zero_4c, out_en_4c);
    singleMAC MAC4d (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_4c, next_N_4c, out_4c, next_In_3d, out_4d, next_In_4d, next_N_4d,  Zero_4d, next_en_row_4d, out_Zero_4d, out_en_4d);
    singleMAC MAC4e (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_4d, next_N_4d, out_4d, next_In_3e, out_4e, next_In_4e, next_N_4e,  Zero_4e, next_en_row_4e, out_Zero_4e, out_en_4e);
    singleMAC MAC4f (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_4e, next_N_4e, out_4e, next_In_3f, out_4f, next_In_4f, next_N_4f,  Zero_4f, next_en_row_4f,out_Zero_4f, out_en_4f);
    singleMAC MAC4F (CLK, RSTN,clk_ws_enable, r_en_w4, !Zero_4f, next_N_4f, out_4f, next_In_3F, out_4F, next_In_4F, next_N_4F, Zero_4F, next_en_row_4F, out_Zero_4F, out_en_4F);
    

   
    // Set Global Output
    
    assign out_1 = (out_Zero_1F&& out_en_1F) ? out_1F :32'h0000;

    assign out_2 = (out_Zero_2F&& out_en_2F) ? out_2F : 32'h0000;

    assign out_3 = (out_Zero_3F&& out_en_3F) ? out_3F : 32'h0000;

    assign out_4 = (out_Zero_4F&& out_en_4F) ? out_4F : 32'h0000;

    // Assign Output
    assign out_fin_1 = out_col_15;
    assign out_fin_2 = out_col_25;
    assign out_fin_3 = out_col_35;
    assign out_fin_4 = out_col_45;


endmodule