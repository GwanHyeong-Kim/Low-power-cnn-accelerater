module datapathUnit_IS#(parameter IS_mode_N=16)
(
    input IS_CLK,
    input IS_RSTN,
    input IS_clk_is_enable,
    input IS_enW_i,
    input IS_enI_i,
    input [511:0] IS_In_i, // 32*16
    output signed [31:0] IS_out //
);

    // Enable Weight
    reg IS_r_en_W;
    reg IS_r_enI_i;
 
  reg signed [31:0] IS_next_In_1, IS_next_In_2, IS_next_In_3, IS_next_In_4, IS_next_In_5, IS_next_In_6, IS_next_In_7, IS_next_In_8, IS_next_In_9, IS_next_In_a, IS_next_In_b, IS_next_In_c, IS_next_In_d, IS_next_In_e, IS_next_In_f, IS_next_In_F;



    // Entire Column Output
    reg signed [31:0] IS_out_col_11;
  

    // Valid Signal

    //Zero Signal for output Each MAC


    wire IS_Zero_11, IS_Zero_12, IS_Zero_13, IS_Zero_14, IS_Zero_15,IS_Zero_16, IS_Zero_17, IS_Zero_18, IS_Zero_19, IS_Zero_110,IS_Zero_111, IS_Zero_112, IS_Zero_113, IS_Zero_114, IS_Zero_115,IS_Zero_116;

    // Zero Signal for output Each MAC
wire IS_Out_Zero_11, IS_Out_Zero_12, IS_Out_Zero_13, IS_Out_Zero_14, IS_Out_Zero_15, IS_Out_Zero_16, IS_Out_Zero_17, IS_Out_Zero_18, IS_Out_Zero_19, IS_Out_Zero_110, IS_Out_Zero_111, IS_Out_Zero_112, IS_Out_Zero_113, IS_Out_Zero_114, IS_Out_Zero_115, IS_Out_Zero_116;

// en Signal for output Each MAC
wire IS_out_en_11, IS_out_en_12, IS_out_en_13, IS_out_en_14, IS_out_en_15, IS_out_en_16, IS_out_en_17, IS_out_en_18, IS_out_en_19, IS_out_en_110, IS_out_en_111, IS_out_en_112, IS_out_en_113, IS_out_en_114, IS_out_en_115, IS_out_en_116;

// Output Each MAC
wire signed [31:0] IS_out_11, IS_out_12, IS_out_13, IS_out_14, IS_out_15, IS_out_16, IS_out_17, IS_out_18, IS_out_19, IS_out_110, IS_out_111, IS_out_112, IS_out_113, IS_out_114, IS_out_115, IS_out_116;

// Next Mode-N Each MAC
wire [4:0] IS_next_N_11, IS_next_N_12, IS_next_N_13, IS_next_N_14, IS_next_N_15, IS_next_N_16, IS_next_N_17, IS_next_N_18, IS_next_N_19, IS_next_N_110, IS_next_N_111, IS_next_N_112, IS_next_N_113, IS_next_N_114, IS_next_N_115, IS_next_N_116;

// Global Output (16bits, 8bits)
wire signed [31:0] IS_out_1;

// Weight Shift
always @(posedge IS_CLK or negedge IS_RSTN) begin
    if (!IS_RSTN) begin
        IS_r_en_W    <= 0;
        IS_r_enI_i   <= 0;
        IS_next_In_1 <= 0; 
        IS_next_In_2 <= 0; 
        IS_next_In_3 <= 0; 
        IS_next_In_4 <= 0; 
        IS_next_In_5 <= 0; 
        IS_next_In_6 <= 0; 
        IS_next_In_7 <= 0; 
        IS_next_In_8 <= 0; 
        IS_next_In_9 <= 0; 
        IS_next_In_a <= 0; 
        IS_next_In_b <= 0; 
        IS_next_In_c <= 0; 
        IS_next_In_d <= 0; 
        IS_next_In_e <= 0; 
        IS_next_In_f <= 0; 
        IS_next_In_F <= 0;
    end
    else if (IS_clk_is_enable) begin
        if (IS_enW_i == 1'b1) begin
            IS_next_In_1 <=  IS_In_i[483:480];
            IS_next_In_2 <=  IS_In_i[451:448];
            IS_next_In_3 <=  IS_In_i[419:416];
            IS_next_In_4 <=  IS_In_i[387:384];
            IS_next_In_5 <=  IS_In_i[355:352];
            IS_next_In_6 <=  IS_In_i[323:320];
            IS_next_In_7 <=  IS_In_i[291:288];
            IS_next_In_8 <=  IS_In_i[259:256];
            IS_next_In_9 <=  IS_In_i[227:224];
            IS_next_In_a <=  IS_In_i[195:192];
            IS_next_In_b <=  IS_In_i[163:160];
            IS_next_In_c <=  IS_In_i[131:128];
            IS_next_In_d <=  IS_In_i[99:96];
            IS_next_In_e <=  IS_In_i[67:64];
            IS_next_In_f <=  IS_In_i[63:32];
            IS_next_In_F <=  IS_In_i[3:0];
            IS_r_en_W <= 1'b1;
            IS_r_enI_i <= 0;
        end
        else if (IS_enI_i == 1'b1) begin
            IS_next_In_1 <= IS_In_i[511:480]; 
            IS_next_In_2 <= IS_In_i[479:448]; 
            IS_next_In_3 <= IS_In_i[447:416]; 
            IS_next_In_4 <= IS_In_i[415:384]; 
            IS_next_In_5 <= IS_In_i[383:352]; 
            IS_next_In_6 <= IS_In_i[351:320]; 
            IS_next_In_7 <= IS_In_i[319:288]; 
            IS_next_In_8 <= IS_In_i[287:256]; 
            IS_next_In_9 <= IS_In_i[255:224]; 
            IS_next_In_a <= IS_In_i[223:192]; 
            IS_next_In_b <= IS_In_i[191:160]; 
            IS_next_In_c <= IS_In_i[159:128]; 
            IS_next_In_d <= IS_In_i[127:96]; 
            IS_next_In_e <= IS_In_i[95:64]; 
            IS_next_In_f <= IS_In_i[63:32]; 
            IS_next_In_F <= IS_In_i[31:0];
            IS_r_enI_i     <= 1;
            IS_r_en_W      <= 0;
        end
        else begin
            IS_r_en_W  <= 0;
            IS_r_enI_i <= 0;
        end
    end
end

// Make Column Output
always @(posedge IS_CLK or negedge IS_RSTN) begin
    if (!IS_RSTN) begin
        IS_out_col_11 <= 0;
    end
    else begin
        if (IS_clk_is_enable) begin
            IS_out_col_11 <= IS_out_1;
        end
        else begin
            IS_out_col_11 <= 0;
        end
    end
end

// Instantiate Row 1   
singleMAC_IS MAC11  (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, IS_r_en_W,        IS_mode_N,     40'b0,   IS_next_In_1, IS_out_11,  IS_next_N_11,  IS_Zero_11, IS_Out_Zero_11,   IS_out_en_11);
singleMAC_IS MAC12  (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_11,      IS_next_N_11,  IS_out_11,  IS_next_In_2, IS_out_12,  IS_next_N_12,  IS_Zero_12, IS_Out_Zero_12,   IS_out_en_12);
singleMAC_IS MAC13  (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_12,      IS_next_N_12,  IS_out_12,  IS_next_In_3, IS_out_13,  IS_next_N_13,  IS_Zero_13, IS_Out_Zero_13,   IS_out_en_13);
singleMAC_IS MAC14  (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_13,      IS_next_N_13,  IS_out_13,  IS_next_In_4, IS_out_14,  IS_next_N_14,  IS_Zero_14, IS_Out_Zero_14,   IS_out_en_14);
singleMAC_IS MAC15  (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_14,      IS_next_N_14,  IS_out_14,  IS_next_In_5, IS_out_15,  IS_next_N_15,  IS_Zero_15, IS_Out_Zero_15,   IS_out_en_15);
singleMAC_IS MAC16  (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_15,      IS_next_N_15,  IS_out_15,  IS_next_In_6, IS_out_16,  IS_next_N_16,  IS_Zero_16, IS_Out_Zero_16,   IS_out_en_16);
singleMAC_IS MAC17  (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_16,      IS_next_N_16,  IS_out_16,  IS_next_In_7, IS_out_17,  IS_next_N_17,  IS_Zero_17, IS_Out_Zero_17,   IS_out_en_17);
singleMAC_IS MAC18  (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_17,      IS_next_N_17,  IS_out_17,  IS_next_In_8, IS_out_18,  IS_next_N_18,  IS_Zero_18, IS_Out_Zero_18,   IS_out_en_18);
singleMAC_IS MAC19  (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_18,      IS_next_N_18,  IS_out_18,  IS_next_In_9, IS_out_19,  IS_next_N_19,  IS_Zero_19, IS_Out_Zero_19,   IS_out_en_19);
singleMAC_IS MAC110 (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_19,      IS_next_N_19,  IS_out_19,  IS_next_In_a, IS_out_110, IS_next_N_110, IS_Zero_110,IS_Out_Zero_110, IS_out_en_110);
singleMAC_IS MAC111 (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_110,     IS_next_N_110, IS_out_110, IS_next_In_b, IS_out_111, IS_next_N_111, IS_Zero_111,IS_Out_Zero_111, IS_out_en_111);
singleMAC_IS MAC112 (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_111,     IS_next_N_111, IS_out_111, IS_next_In_c, IS_out_112, IS_next_N_112, IS_Zero_112,IS_Out_Zero_112, IS_out_en_112);
singleMAC_IS MAC113 (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_112,     IS_next_N_112, IS_out_112, IS_next_In_d, IS_out_113, IS_next_N_113, IS_Zero_113,IS_Out_Zero_113, IS_out_en_113);
singleMAC_IS MAC114 (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_113,     IS_next_N_113, IS_out_113, IS_next_In_e, IS_out_114, IS_next_N_114, IS_Zero_114,IS_Out_Zero_114, IS_out_en_114);
singleMAC_IS MAC115 (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_114,     IS_next_N_114, IS_out_114, IS_next_In_f, IS_out_115, IS_next_N_115, IS_Zero_115,IS_Out_Zero_115, IS_out_en_115);
singleMAC_IS MAC116 (IS_CLK, IS_RSTN, IS_clk_is_enable, IS_r_enI_i, !IS_Zero_115,     IS_next_N_115, IS_out_115, IS_next_In_F, IS_out_116, IS_next_N_116, IS_Zero_116,IS_Out_Zero_116, IS_out_en_116);

// Set Global Output
assign IS_out_1 = (IS_Out_Zero_116 && IS_out_en_116) ? IS_out_116 : 32'b0;

// Assign Output
assign IS_out = IS_out_col_11;

endmodule