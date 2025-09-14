module singleMAC_IS
(
   input IS_CLK,
   input IS_RSTN,
   input IS_clk_is_enable,
   input IS_enI_i, //input
   input IS_enW_i, // weight
   input [4:0] IS_mode_N,
   input signed [31:0] IS_before_Out,
   input signed [31:0] IS_In_i,
   output signed [31:0] IS_out,
   output [4:0] IS_next_mode_N,
   output IS_Zero,
   output IS_out_Zero,
   output IS_out_en
);

   reg signed [31:0] IS_r_out;
   reg signed [31:0] IS_r_mul;
   reg signed [31:0] IS_r_add;
   reg signed [31:0] IS_AB_reg1;
   reg signed [31:0] IS_r_In_i;
   reg signed [3:0] IS_r_Weight_i;

   reg [4:0] IS_r_mode_N_0;
   reg [4:0] IS_r_mode_N_1;
   reg [4:0] IS_r_mode_N_2;

   reg IS_En_reg0;
   reg IS_En_reg1;
   reg IS_En_reg2;

   // Initialize Input Input Stationary
   always @(posedge IS_CLK or negedge IS_RSTN) begin
      if (!IS_RSTN) begin
         IS_r_In_i <= 31'h00;
      end
      else begin
       if (IS_clk_is_enable && IS_enI_i == 1'b1) begin
            IS_r_In_i <= IS_In_i;
         end
      else begin
         IS_r_In_i <= IS_r_In_i;
         end
      end
   end

   // Pipe Reg0
   always @(posedge IS_CLK or negedge IS_RSTN) begin
      if (!IS_RSTN) begin
         IS_En_reg0 <= 1'b0;
         IS_r_Weight_i <= 4'h0;
         IS_r_mode_N_0 <= 5'h0;
      end
      else begin
         if (IS_clk_is_enable && IS_enW_i == 1'b1) begin
            IS_En_reg0 <= 1'b1;
            IS_r_Weight_i <= IS_In_i[3:0];
            IS_r_mode_N_0 <= IS_mode_N - 1'b1;
         end
         else begin
            IS_En_reg0 <= 1'b0;
            IS_r_Weight_i <= 4'h0;
            IS_r_mode_N_0 <= 5'h0;
         end
      end
   end

   // MUL
  always @(*) begin
   IS_r_mul = 32'h000000;
        if (IS_En_reg0) begin
            if (IS_r_Weight_i[3] == 1'b1) begin
                IS_r_mul = -(IS_r_In_i << IS_r_Weight_i[2:0]);
            end
            else begin
                IS_r_mul = (IS_r_In_i << IS_r_Weight_i[2:0]);
            end
        end
        else begin
            IS_r_mul = 32'h000000;
        end
    end


   // Pipe Reg1
   always @(posedge IS_CLK or negedge IS_RSTN) begin
      if (!IS_RSTN) begin
         IS_En_reg1 <= 1'b0;
         IS_AB_reg1 <= 32'h0000;
         IS_r_mode_N_1 <= 5'h0;
      end
      else begin
         if (IS_clk_is_enable && IS_En_reg0 == 1'b1) begin
            IS_En_reg1 <= 1'b1;
            IS_AB_reg1 <= IS_r_mul;
            IS_r_mode_N_1 <= IS_r_mode_N_0;
         end
         else begin
            IS_En_reg1 <= 1'b0;
            IS_AB_reg1 <= 32'h0000;
            IS_r_mode_N_1 <= 5'h0;
         end
      end
   end

   // ADD comb
   always @(*) begin
         IS_r_add = 32'h0000;
         if (IS_En_reg1) begin
            IS_r_add = IS_AB_reg1 + IS_before_Out;
         end
         else begin
            IS_r_add = 32'h0000;
         end
      end

   // Pipe Reg2
   always @(posedge IS_CLK or negedge IS_RSTN) begin
      if (!IS_RSTN) begin
         IS_En_reg2 <= 1'b0;
         IS_r_out <= 32'h0000;
         IS_r_mode_N_2 <= 4'h0;
      end
      else begin
         if (IS_clk_is_enable && IS_En_reg1 == 1'b1) begin
            IS_En_reg2 <= 1'b1;
            IS_r_out <= IS_r_add;
            IS_r_mode_N_2 <= IS_r_mode_N_1;
         end
         else begin
            IS_En_reg2 <= 1'b0;
            IS_r_out <= 32'h0000;
            IS_r_mode_N_2 <= 5'h0;
         end
      end
   end

   assign IS_out = IS_r_out;
   assign IS_Zero = (IS_r_mode_N_0 == 5'b0000);
   assign IS_out_Zero = (IS_r_mode_N_2 == 5'b000);
   assign IS_next_mode_N = IS_r_mode_N_0;
   assign IS_out_en = IS_En_reg2;

endmodule
