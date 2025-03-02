`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/14 17:59:25
// Design Name: 
// Module Name: Add1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Add1(
    input clk,
    input cal,
    input [23:0] fp8Binary1, // 符号位(1)+指数位(4)+尾数位(19)
    input [23:0] fp8Binary2,
    // input [4:0] e_bit1, // e_bit1 (4位)
    input [4:0] m_bit1, // m_bit1 动态位宽，范围1到19
    input [4:0] m_bit2, // m_bit2 动态位宽，范围1到19
    // input [3:0] bias1,  // 固定为15
    // input [4:0] e_bit2, // e_bit2 (4位)
    // input [3:0] bias2,  // 固定为15
    output reg [4:0] result_bias, //  bias输出信息
    output reg [4:0] output_m_bits, //
    output reg  [3:0]result_exp, // 指数输出信息
    output reg  [18:0]result_man, // 尾数输出信息
    output reg  sign_result, // 符号输出信息
    output reg  [18:0]time_period // 时间输出信息
);

    // 参数配置
    parameter e_bit1=4;
    parameter bias1=15;
    parameter e_bit2=4;
    parameter bias2=15;
    parameter e_bias=15;
 
    //查找表配置
    reg [4:0] M1B2_0_0[1:0][1:0];  
    reg [4:0] M1B2_0_1[1:0][1:0];  
    reg [4:0] M1B2_0_2[1:0][1:0];  
    reg [4:0] M1B2_0_3[1:0][1:0];  
    reg [4:0] M1B2_1_0[1:0][1:0];  
    reg [4:0] M1B2_1_1[1:0][1:0];  
    reg [4:0] M1B2_1_2[1:0][1:0];  
    reg [4:0] M1B2_1_3[1:0][1:0];

    // 提取符号、指数和尾数
    reg signBit1, signBit2;
    reg [3:0] exponentBits1, exponentBits2;
    reg  [18:0]fractionBits1, fractionBits2;
    reg [23:0] result;
    reg [3:0] exponent1,exponent2;
    reg [3:0] exponent_result;
    reg [18:0] fraction1, fraction2;
    reg [18:0] fraction_result;
    reg [22:0] result_bin;//最多23位
    reg [4:0] result_m_bit;

    reg [4:0] e_diff;
    reg [18:0]max_m_bit;
    reg [23:0]tempfp8Binary;
    reg sign;
    reg  [18:0]cnt_period=0;
    reg  [18:0]cnt_period_temp=0;



    initial begin
        // 初始化M1B2_0_0 (2x2)
        M1B2_0_0[0][0] = 2;  M1B2_0_0[0][1] = 3;
        M1B2_0_0[1][0] = 2;  M1B2_0_0[1][1] = 3;

        // 初始化M1B2_0_1 (2x2)
        M1B2_0_1[0][0] = 1;  M1B2_0_1[0][1] = 2;
        M1B2_0_1[1][0] = 1;  M1B2_0_1[1][1] = 2;

        // 初始化M1B2_0_2 (2x2)
        M1B2_0_2[0][0] = 1;  M1B2_0_2[0][1] = 1;
        M1B2_0_2[1][0] = 1;  M1B2_0_2[1][1] = 1;

        // 初始化M1B2_0_3 (2x2)
        M1B2_0_3[0][0] = 0;  M1B2_0_3[0][1] = 0;
        M1B2_0_3[1][0] = 0;  M1B2_0_3[1][1] = 1;

        // 初始化M1B2_1_0 (2x2)
        M1B2_1_0[0][0] = 12;  M1B2_1_0[0][1] = 27;
        M1B2_1_0[1][0] = 12;  M1B2_1_0[1][1] = 27;

        // 初始化M1B2_1_1 (2x2)
        M1B2_1_1[0][0] = 28;  M1B2_1_1[0][1] = 26;
        M1B2_1_1[1][0] = 28;  M1B2_1_1[1][1] = 30;

        // 初始化M1B2_1_2 (2x2)
        M1B2_1_2[0][0] = 29;  M1B2_1_2[0][1] = 29;
        M1B2_1_2[1][0] = 29;  M1B2_1_2[1][1] = 30;

        // 初始化M1B2_1_3 (2x2)
        M1B2_1_3[0][0] = 30;  M1B2_1_3[0][1] = 29;
        M1B2_1_3[1][0] = 30;  M1B2_1_3[1][1] = 31;


    end
reg wea;
reg [5:0] dina_M2B2;
reg [6:0] dina_M3B2;
reg [7:0] dina_M4B2;
reg [8:0] dina_M5B2;
reg [9:0] dina_M6B2;
reg [10:0] dina_M7B2;
reg [11:0] dina_M8B2;
//
reg [5:0] douta_M2B2;
reg [6:0] douta_M3B2;
reg [7:0] douta_M4B2;
reg [8:0] douta_M5B2;
reg [9:0] douta_M6B2;
reg [10:0] douta_M7B2;
reg [11:0] douta_M8B2;
//
reg [6:0] addra_M2B2;
reg [7:0] addra_M3B2;
reg [8:0] addra_M4B2;
reg [9:0] addra_M5B2;
reg [11:0] addra_M6B2;
reg [12:0] addra_M7B2;
reg [13:0] addra_M8B2;

blk_mem_gen_0 M2B2 (
  .clka(clk),    // input wire clka
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra_M2B2),  // input wire [6 : 0] addra
  .dina(dina_M2B2),    // input wire [5 : 0] dina
  .douta(douta_M2B2)  // output wire [5 : 0] douta
);
blk_mem_gen_1 M3B2 (
  .clka(clk),    // input wire clka
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra_M3B2),  // input wire [7 : 0] addra
  .dina(dina_M3B2),    // input wire [6 : 0] dina
  .douta(douta_M3B2)  // output wire [6 : 0] douta
);
blk_mem_gen_2 M4B2 (
  .clka(clk),    // input wire clka
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra_M4B2),  // input wire [8 : 0] addra
  .dina(dina_M4B2),    // input wire [7 : 0] dina
  .douta(douta_M4B2)  // output wire [7 : 0] douta
);
blk_mem_gen_3 M5B2 (
  .clka(clk),    // input wire clka
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra_M5B2),  // input wire [9 : 0] addra
  .dina(dina_M5B2),    // input wire [8 : 0] dina
  .douta(douta_M5B2)  // output wire [8 : 0] douta
);
blk_mem_gen_4 M6B2(
  .clka(clk),    // input wire clka
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra_M6B2),  // input wire [11 : 0] addra
  .dina(dina_M6B2),    // input wire [9 : 0] dina
  .douta(douta_M6B2)  // output wire [9 : 0] douta
);
blk_mem_gen_5 M7B2 (
  .clka(clk),    // input wire clka
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra_M7B2),  // input wire [12 : 0] addra
  .dina(dina_M7B2),    // input wire [10 : 0] dina
  .douta(douta_M7B2)  // output wire [10 : 0] douta
);
blk_mem_gen_6 M8B2 (
  .clka(clk),    // input wire clka
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra_M8B2),  // input wire [13 : 0] addra
  .dina(dina_M8B2),    // input wire [11 : 0] dina
  .douta(douta_M8B2)  // output wire [11 : 0] douta
);




    always @(posedge clk) begin
        if (cnt_period == 1000000-1) begin
        cnt_period <=0;
        end else begin
        cnt_period <= cnt_period + 1;
        end

    end

    always @(posedge cal) begin
        cnt_period_temp = cnt_period;
        // 提取符号、指数和尾数(e_diff>=0)更大的为exponent1、fraction1
        if(fp8Binary1[22:19]>=fp8Binary2[22:19]) begin
        signBit1 = fp8Binary1[23];
        exponentBits1 = fp8Binary1[22:19];
        signBit2 = fp8Binary2[23];
        exponentBits2 = fp8Binary2[22:19];
        fractionBits1=fp8Binary1[18:0];
        fractionBits2=fp8Binary2[18:0];
        end
        else begin
        signBit1 = fp8Binary2[23];
        exponentBits1 = fp8Binary2[22:19];     
        signBit2 = fp8Binary1[23];
        exponentBits2 = fp8Binary1[22:19];
        fractionBits1=fp8Binary2[18:0];
        fractionBits2=fp8Binary1[18:0];
        end
        // 计算指数和尾数的值
        exponent1 = exponentBits1 - bias1;
        exponent2 = exponentBits2 - bias2;

        e_diff = exponent1 - exponent2;
        max_m_bit = (m_bit1 > m_bit2) ? m_bit1 : m_bit2;
        result_m_bit = max_m_bit;
        //移位对齐操作
        fractionBits1 = fractionBits1 << (max_m_bit - m_bit1);
        fractionBits2 = fractionBits2 << (max_m_bit - m_bit2);

        //确定最终的计算结果
        if (signBit1 == signBit2) begin
            sign_result = signBit1;
        end
        else begin
            //% 如果符号位不同，则比较指数位
            if (exponent1 == exponent2) begin
                //% 如果指数位相同，则比较小数位
                if (fractionBits1 == fractionBits2) begin
                    sign_result = 0;
                end
                else if (fractionBits1 > fractionBits2) begin
                    sign_result = signBit1;
                end
                else begin
                    sign_result = signBit2;
                end
            end
            else  begin
                sign_result = signBit1;
            end
        end

        // 确定是找加法查找表还是减法查找表
        if (signBit1 == signBit2) begin
            sign=0;
        end else begin
            sign=1;
        end



        //M1B2
        if(max_m_bit == 1) begin         
            if (sign==0) begin // 加法查找
            case (e_diff)
                5'd0:case (fractionBits2-fractionBits1)
                    19'd0: result_bin= M1B2_0_0[0][0]+fractionBits1;
                    19'd1: result_bin = M1B2_0_0[0][1]+fractionBits1;
                    default result_bin = M1B2_0_0[1][1]+fractionBits2;
                    endcase
                5'd1:case (fractionBits2-fractionBits1)
                    19'd0: result_bin= M1B2_0_1[0][0]+fractionBits1;
                    19'd1: result_bin = M1B2_0_1[0][1]+fractionBits1;
                    default: result_bin = M1B2_0_1[1][1]+fractionBits2;
                    endcase
                5'd2:case (fractionBits2-fractionBits1)
                    19'd0: result_bin= M1B2_0_2[0][0]+fractionBits1;
                    19'd1: result_bin = M1B2_0_2[0][1]+fractionBits1;
                    default: result_bin = M1B2_0_2[1][1]+fractionBits2;
                endcase
                5'd3:case (fractionBits2-fractionBits1)
                    19'd0: result_bin = M1B2_0_3[0][0]+fractionBits1;
                    19'd1: result_bin= M1B2_0_3[0][1]+fractionBits1;
                    default: result_bin = M1B2_0_3[1][1]+fractionBits2;
                endcase
            endcase
            exponent_result=exponent1+result_bin[4:1]+e_bias;
                if(exponent_result>3) begin
                    result_bias=bias1 - (exponent_result-3);
                    exponent_result = 3;
                    result[4:1] = exponent_result;
                    result[0]=result_bin[0];
                    result[23:6] = 18'b0;
                end else begin
                    result_bias=bias1;
                    result[4:1] = exponent_result;
                    result[0]=result_bin[0];
                    result[23:6] = 18'b0;
                end
            end
            if (sign==1) begin // 减法查找
            case (e_diff)
                5'd0:case (fractionBits2-fractionBits1)
                    19'd0: result_bin = M1B2_1_0[0][0]+fractionBits1;
                    19'd1: result_bin= M1B2_1_0[0][1]+fractionBits1;
                    default: result_bin = M1B2_1_0[1][1]+fractionBits2;
                    endcase
                5'd1:case (fractionBits2-fractionBits1)
                    19'd0: result_bin = M1B2_1_1[0][0]+fractionBits1;
                    19'd1: result_bin = M1B2_1_1[0][1]+fractionBits1;
                    default: result_bin = M1B2_1_1[1][1]+fractionBits2;
                    endcase
                5'd2:case (fractionBits2-fractionBits1)
                    19'd0: result_bin = M1B2_1_2[0][0]+fractionBits1;
                    19'd1: result_bin = M1B2_1_2[0][1]+fractionBits1;
                    default: result_bin = M1B2_1_2[1][1]+fractionBits2;
                endcase
                5'd3:case (fractionBits2-fractionBits1)
                    19'd0: result_bin = M1B2_0_3[0][0]+fractionBits1;
                    19'd1: result_bin = M1B2_0_3[0][1]+fractionBits1;
                    default: result_bin = M1B2_0_3[1][1]+fractionBits2;
                endcase
            endcase
            exponent_result=exponent1+result_bin[4:1]+e_bias-bias1;
                if(exponent_result>3) begin
                    result_bias=bias1 - (exponent_result-3);
                    exponent_result = 3;
                    result[4:1] = exponent_result;
                    result[0]=result_bin[0];
                    result[23:6] = 18'b0;
                end else if (exponent_result< 0) begin
                    result_bias=bias1 - (exponent_result-0);
                    exponent_result = 0;
                    if (result_bin[0] == 0) begin
                        result_bias = result_bias + 1;
                        exponent_result = 1;
                    end
                    result[4:1] = exponent_result;
                    result[0]=result_bin[0];
                    result[23:6] = 18'b0;
                end
                else if (exponent_result == 0) begin 
                    if  (result_bin[0] == 0) begin
                        result_bias = result_bias + 1;
                        exponent_result = 1;
                    end
                    result[4:1] = exponent_result;
                    result[0]=result_bin[0];
                    result[23:6] = 18'b0;
                end else begin
                    result_bias=bias1;
                    result[4:1] = exponent_result;
                    result[0]=result_bin[0];
                    result[23:6] = 18'b0;
                end
            end
      end else if (max_m_bit == 2) begin
            if (sign==0) begin // 加法查找
                    //  $display("yse,max_m_bit == 2");
                    //  $display("M2B2_0_0[0][0]=",M2B2[0][0][0][0]);      
                    if (fractionBits2>=fractionBits1) begin
                            addra_M2B2 = (e_diff<<3)+fractionBits2-fractionBits1-1;
                            result_bin=douta_M2B2+fractionBits1;
                        end else begin
                            addra_M2B2 = (e_diff<<3)+fractionBits1-fractionBits2-1+4;
                            result_bin=douta_M2B2+fractionBits2;
                        end
                    // $display("result_bin=",result_bin);
                end else begin // 减法查找
                if(fractionBits2>=fractionBits1) begin
                        addra_M2B2 = 40+(e_diff<<3)+fractionBits2-fractionBits1-1;
                        result_bin=douta_M2B2+fractionBits1;
                end else begin
                        addra_M2B2 = 40+(e_diff<<3)+fractionBits1-fractionBits2-1+4;
                        result_bin=douta_M2B2+fractionBits2;
                end
            end 
      end else if (max_m_bit == 3) begin
            if (sign==0) begin // 加法查找
                if(fractionBits2>=fractionBits1) begin
                        addra_M3B2 = (e_diff<<4)+fractionBits2-fractionBits1-1;
                        result_bin=douta_M3B2+fractionBits1;
                end else begin
                        addra_M3B2 = (e_diff<<4)+fractionBits1-fractionBits2-1+8;
                        result_bin=douta_M3B2+fractionBits2;
                end 
                end else begin // 减法查找
                if(fractionBits2>=fractionBits1) begin
                        addra_M3B2 = 96+(e_diff<<4)+fractionBits2-fractionBits1-1;
                        result_bin=douta_M3B2+fractionBits1;
                end else begin
                        addra_M3B2 = 96+(e_diff<<4)+fractionBits1-fractionBits2-1+8;
                        result_bin=douta_M3B2+fractionBits2;
                end
                end 
        end else if (max_m_bit == 4) begin
                if (sign==0) begin // 加法查找
                    if(fractionBits2>=fractionBits1) begin
                        addra_M4B2 = (e_diff<<5)+fractionBits2-fractionBits1-1;
                        result_bin=douta_M4B2+fractionBits1;
                    end else begin
                        addra_M4B2 = (e_diff<<5)+fractionBits1-fractionBits2-1+16;
                        result_bin=douta_M4B2+fractionBits2;
                    end 
                end else begin // 减法查找
                    if(fractionBits2>=fractionBits1) begin
                        addra_M4B2 = 224+(e_diff<<5)+fractionBits2-fractionBits1-1;
                        result_bin=douta_M4B2+fractionBits1;
                    end else begin
                        addra_M4B2 = 224+(e_diff<<5)+fractionBits1-fractionBits2-1+16;
                        result_bin=douta_M4B2+fractionBits2;
                        end
                    end
        end else if (max_m_bit == 5) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                addra_M5B2 = (e_diff<<6)+fractionBits2-fractionBits1-1;
                                result_bin=douta_M5B2+fractionBits1;
                        end else begin
                                addra_M5B2 = (e_diff<<6)+fractionBits1-fractionBits2-1+32;
                                result_bin=douta_M5B2+fractionBits2;    
                        end 
                    end else begin // 减法查找
                        if(fractionBits2>=fractionBits1) begin
                                addra_M5B2 = 512+(e_diff<<6)+fractionBits2-fractionBits1-1;
                                result_bin=douta_M5B2+fractionBits1;
                        end else begin
                                addra_M5B2 = 512+(e_diff<<6)+fractionBits1-fractionBits2-1+32;
                                result_bin=douta_M5B2+fractionBits2;
                    end
                    end
        end else if (max_m_bit == 6) begin
                if (sign==0) begin // 加法查找
                    if(fractionBits2>=fractionBits1) begin
                            addra_M6B2 = (e_diff<<7)+fractionBits2-fractionBits1-1;
                            result_bin=douta_M6B2+fractionBits1;
                    end else begin
                            addra_M6B2 = (e_diff<<7)+fractionBits1-fractionBits2-1+64;
                            result_bin=douta_M6B2+fractionBits2;
                    end 
                end else begin // 减法查找
                        if(fractionBits2>=fractionBits1) begin
                                addra_M6B2 = 1152+(e_diff<<7)+fractionBits2-fractionBits1-1;
                                result_bin=douta_M6B2+fractionBits1;
                        end  else begin
                               addra_M6B2 = 1152+(e_diff<<7)+fractionBits1-fractionBits2-1+64;
                                result_bin=douta_M6B2+fractionBits2;
                        end
                    end
        end else if (max_m_bit == 7) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                addra_M7B2 = (e_diff<<8)+fractionBits2-fractionBits1-1;
                                 result_bin=douta_M7B2+fractionBits1;
                        end else begin
                                addra_M7B2 = (e_diff<<8)+fractionBits1-fractionBits2-1+128;
                                 result_bin=douta_M7B2+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                addra_M7B2 = 2560+(e_diff<<8)+fractionBits2-fractionBits1-1;
                                result_bin=douta_M7B2+fractionBits1;
                            end else begin
                                addra_M7B2 = 2560+(e_diff<<8)+fractionBits1-fractionBits2-1+128;
                                result_bin=douta_M7B2+fractionBits2;
                            end
                        end
        end else if (max_m_bit == 8) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                               addra_M8B2 = (e_diff<<9)+fractionBits2-fractionBits1-1;
                                result_bin=douta_M8B2+fractionBits1;
                        end else begin
                                addra_M8B2 = (e_diff<<9)+fractionBits1-fractionBits2-1+256;
                                 result_bin=douta_M8B2+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                addra_M8B2 = 5632+(e_diff<<9)+fractionBits2-fractionBits1-1;
                                result_bin=douta_M8B2+fractionBits1;
                            end else begin
                                addra_M8B2 = 5632+(e_diff<<9)+fractionBits1-fractionBits2-1+256;
                                result_bin=douta_M8B2+fractionBits2;
                            end
                        end
        end 

        if (2+max_m_bit>=e_diff) begin
        // $display("yse,the last way");
            if(sign==0) begin // 加法结果
                exponent_result=exponent1+result_bin[max_m_bit+:4]+e_bias;//起始位为max_m_bit，宽度为4
                if(exponent_result>3) begin
                    result_bias=bias1 - (exponent_result-3);
                    exponent_result = 3;
                    result[max_m_bit+:4] = exponent_result;
                    fraction_result = result_bin-(result_bin[max_m_bit+:4]<<max_m_bit);
                $display("result_bin=",result_bin);
                end else begin
                    result_bias=bias1;
                    result[max_m_bit+:4] = exponent_result;
                   fraction_result = result_bin-(result_bin[max_m_bit+:4]<<max_m_bit);
                end
            end else begin // 减法结果
            exponent_result=exponent1+result_bin[max_m_bit+:4]+e_bias-bias1;
            if(exponent_result>3) begin
                result_bias=bias1 - (exponent_result-3);
                exponent_result = 3;
                result[max_m_bit+:4] = exponent_result;
                fraction_result = result_bin-(result_bin[max_m_bit+:4]<<max_m_bit);
            end else if (exponent_result< 0) begin
                result_bias=bias1 - (exponent_result-0);
                exponent_result = 0;
                if (result_bin-(result_bin[max_m_bit+:4]<<max_m_bit)== 0) begin
                    result_bias = result_bias + 1;
                    exponent_result = 1;
                end
                result[max_m_bit+:4] = exponent_result;
                fraction_result = result_bin-(result_bin[max_m_bit+:4]<<max_m_bit);
            end
            else if (exponent_result == 0) begin 
                if  (result_bin-(result_bin[max_m_bit+:4]<<max_m_bit)== 0) begin
                    result_bias = result_bias + 1;
                    exponent_result = 1;
                end
                result[max_m_bit+:4] = exponent_result;
                fraction_result = result_bin-(result_bin[max_m_bit+:4]<<max_m_bit);
            end else begin
                result_bias=bias1;
                result[max_m_bit+:4] = exponent_result;
                fraction_result = result_bin-(result_bin[max_m_bit+:4]<<max_m_bit);
            end
            end
        result_exp=exponent_result;
        result_man=fraction_result;
        output_m_bits=max_m_bit;
        time_period=cnt_period-cnt_period_temp;
        end else begin
            result_exp=exponentBits1;
            result_man=fractionBits1;
            output_m_bits=max_m_bit;
            result_bias=bias1;
            time_period=cnt_period-cnt_period_temp;
        end
    end
endmodule


