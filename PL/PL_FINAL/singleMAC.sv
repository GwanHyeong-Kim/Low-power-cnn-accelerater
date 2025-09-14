module singleMAC (
   input CLK,
   input RSTN,
   input clk_ws_enable,
   input enW_i,
   input enI_i,
   input [4:0] mode_N, // mode_N = 16
   input signed [31:0] before_Out,
   input signed [31:0] In_i, 
   output signed [31:0] out,
   output signed [31:0] next_In,
   output [4:0] next_mode_N,
   output Zero,
   output next_en_row,
   output out_Zero,
   output out_en
);

   reg signed [31:0] r_out;
   reg signed [31:0] r_mul;
   reg signed [31:0] r_add;
   reg signed [31:0] AB_reg1;
   reg signed [3:0] r_Weight_i;
   reg signed [31:0] r_In_i;

   reg [4:0] r_mode_N_0;
   reg [4:0] r_mode_N_1;
   reg [4:0] r_mode_N_2;

   reg En_reg0;
   reg En_reg1;
   reg En_reg2;


   // Initialize Weight
   always @(posedge CLK or negedge RSTN) begin
      if (~RSTN) begin
         r_Weight_i <= 8'h00;
      end
      else begin
         if (clk_ws_enable &&enW_i == 1'b1) begin
            r_Weight_i <= In_i[3:0]; //r_Weight_i에 weight가 저장됨. 
         end
         else begin
            r_Weight_i <= r_Weight_i;
         end
      end
   end

   // Pipe Reg0
   always @(posedge CLK or negedge RSTN) begin
      if (~RSTN) begin
         En_reg0 <= 1'b0;
         r_In_i <= 32'h0;
         r_mode_N_0 <= 5'h0;
      end
      else begin
         if (clk_ws_enable &&enI_i == 1'b1) begin
            En_reg0 <= 1'b1;
            r_In_i <= In_i;
            r_mode_N_0 <= mode_N - 1'b1;
         end
         else begin
            En_reg0 <= 1'b0;
            r_In_i <= 32'h0;
            r_mode_N_0 <= 5'h0;
         end
      end
   end

   // MUL
  always @(*) begin
   r_mul = 32'h000000;
        if (En_reg0) begin
            if (r_Weight_i[3] == 1'b1) begin
                r_mul = -(r_In_i << r_Weight_i[2:0]);
            end
            else begin
                r_mul = (r_In_i << r_Weight_i[2:0]);
            end
        end
        else begin
            r_mul = 32'h000000;
        end
    end

   // Pipe Reg1
   always @(posedge CLK or negedge RSTN) begin
      if (~RSTN) begin
         En_reg1 <= 1'b0;
         AB_reg1 <= 32'h0000;
         r_mode_N_1 <= 5'h0;
      end
      else begin
         if (clk_ws_enable &&En_reg0 == 1'b1) begin
            En_reg1 <= 1'b1;
            AB_reg1 <= r_mul;
            r_mode_N_1 <= r_mode_N_0;
         end
         else begin
            En_reg1 <= 1'b0;
            AB_reg1 <= 32'h0000;
            r_mode_N_1 <= 5'h0;
         end
      end
   end

   // ADD
   always @(*) begin
         r_add = 32'h0000;
         if (En_reg1 == 1'b1) begin
            r_add = AB_reg1 + before_Out;
         end
         else begin
            r_add = 32'h0000;
         end
      end


   // Pipe Reg2
   always @(posedge CLK or negedge RSTN) begin
      if (~RSTN) begin
         En_reg2 <= 1'b0;
         r_out <= 32'h0000;
         r_mode_N_2 <= 5'h0;
      end
      else begin
         if (clk_ws_enable &&En_reg1 == 1'b1) begin
            En_reg2 <= 1'b1;
            r_out <= r_add;
            r_mode_N_2 <= r_mode_N_1;
         end
         else begin
            En_reg2 <= 1'b0;
            r_out <= 32'h0000;
            r_mode_N_2 <= 5'h0;
         end
      end
   end

   assign out = r_out;
   assign Zero = (r_mode_N_0 == 5'b00000);
   assign out_Zero = (r_mode_N_2 == 5'b00000);
   assign next_In = (enW_i==1)? r_Weight_i : r_In_i;
   assign next_mode_N = r_mode_N_0;
   assign next_en_row = En_reg0;
   assign out_en = En_reg2;

endmodule