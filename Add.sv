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
    input [23:0] fp8Binary1, // 符号位(1)+指数位(4)+尾数位(19)
    input [23:0] fp8Binary2,
    // input [4:0] e_bit1, // e_bit1 (4位)
    input [18:0] m_bit1, // m_bit1 动态位宽，范围1到19
    input [18:0] m_bit2, // m_bit2 动态位宽，范围1到19
    // input [3:0] bias1,  // 固定为15
    // input [4:0] e_bit2, // e_bit2 (4位)
    input  [5:0] M2B2[1:0][4:0][1:0][3:0],
    input  [6:0] M3B2[1:0][5:0][1:0][7:0],
    //
    input  [7:0] M4B2[1:0][6:0][1:0][1:0],
    input  [8:0] M5B2[1:0][7:0][1:0][1:0],
    input  [9:0] M6B2[1:0][8:0][1:0][1:0],
    input  [10:0] M7B2[1:0][9:0][1:0][1:0],
    input  [11:0] M8B2[1:0][10:0][1:0][1:0],
    input  [12:0] M9B2[1:0][11:0][1:0][1:0],
    input  [13:0] M10B2[1:0][12:0][1:0][1:0],
    input  [14:0] M11B2[1:0][13:0][1:0][1:0],
    input  [15:0] M12B2[1:0][14:0][1:0][1:0],
    input  [16:0] M13B2[1:0][15:0][1:0][1:0],
    input  [17:0] M14B2[1:0][16:0][1:0][1:0],
    input  [18:0] M15B2[1:0][17:0][1:0][1:0],
    input  [19:0] M16B2[1:0][18:0][1:0][1:0],
    input  [20:0] M17B2[1:0][19:0][1:0][1:0],
    input  [21:0] M18B2[1:0][20:0][1:0][1:0],
    input  [22:0] M19B2[1:0][21:0][1:0][1:0],
    //  input  [7:0] M4B2[1:0][6:0][1:0][15:0],
    // input  [8:0] M5B2[1:0][7:0][1:0][31:0],
    // input  [9:0] M6B2[1:0][8:0][1:0][63:0],
    // input  [10:0] M7B2[1:0][9:0][1:0][127:0],
    // input  [11:0] M8B2[1:0][10:0][1:0][255:0],
    // input  [12:0] M9B2[1:0][11:0][1:0][511:0],
    // input  [13:0] M10B2[1:0][12:0][1:0][1023:0],
    // input  [14:0] M11B2[1:0][13:0][1:0][2047:0],
    // input  [15:0] M12B2[1:0][14:0][1:0][4095:0],
    // input  [16:0] M13B2[1:0][15:0][1:0][8191:0],
    // input  [17:0] M14B2[1:0][16:0][1:0][16383:0],
    // input  [18:0] M15B2[1:0][17:0][1:0][32767:0],
    // input  [19:0] M16B2[1:0][18:0][1:0][65535:0],
    // input  [20:0] M17B2[1:0][19:0][1:0][131071:0],
    // input  [21:0] M18B2[1:0][20:0][1:0][262143:0],
    // input  [22:0] M19B2[1:0][21:0][1:0][524287:0],
    
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
    reg [18:0] result_m_bit;

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
    always @(posedge clk) begin
        if (cnt_period == 1000000-1) begin
        cnt_period <=0;
        end else begin
        cnt_period <= cnt_period + 1;
        end

    end

    always @(*) begin
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
                            result_bin=M2B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                            result_bin=M2B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end
                    // $display("result_bin=",result_bin);
                end else begin // 减法查找
                if(fractionBits2>=fractionBits1) begin
                        result_bin=M2B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                end else begin
                        result_bin=M2B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                end
            end 
      end else if (max_m_bit == 3) begin
            if (sign==0) begin // 加法查找
                if(fractionBits2>=fractionBits1) begin
                        result_bin=M3B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                    // $display("fractionBits2-fractionBits1=",fractionBits2-fractionBits1);
                end else begin
                        result_bin=M3B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                end
            end else begin // 减法查找
                if(fractionBits2>=fractionBits1) begin
                        result_bin=M3B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                end else begin
                        result_bin=M3B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                end
            end 
        end else if (max_m_bit == 4) begin
                if (sign==0) begin // 加法查找
                    if(fractionBits2>=fractionBits1) begin
                            result_bin=M4B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                    end else begin
                            result_bin=M4B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                    end 
                end else begin // 减法查找
                    if(fractionBits2>=fractionBits1) begin
                            result_bin=M4B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                    end else begin
                            result_bin=M4B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                                end
                    end
        end else if (max_m_bit == 5) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M5B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M5B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end 
                    end else begin // 减法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M5B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M5B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end
                    end
        end else if (max_m_bit == 6) begin
                if (sign==0) begin // 加法查找
                    if(fractionBits2>=fractionBits1) begin
                            result_bin=M6B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                    end else begin
                            result_bin=M6B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                    end 
                end else begin // 减法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M6B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end  else begin
                                result_bin=M6B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end
                    end
        end else if (max_m_bit == 7) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M7B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M7B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                    result_bin=M7B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                            end else begin
                                    result_bin=M7B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                            end
                        end
        end else if (max_m_bit == 8) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M8B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M8B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                    result_bin=M8B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                            end else begin
                                    result_bin=M8B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                            end
                        end
        end else if (max_m_bit == 9) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M9B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M9B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                    result_bin=M9B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                            end else begin
                                    result_bin=M9B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                            end
                        end
        end else if (max_m_bit == 10) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M10B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M10B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                    result_bin=M10B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                            end else begin
                                    result_bin=M10B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                            end
                        end
        end else if (max_m_bit == 11) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M11B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M11B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                    result_bin=M11B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                            end else begin
                                    result_bin=M11B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                            end
                        end
        end else if (max_m_bit == 12) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M12B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M12B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                    result_bin=M12B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                            end else begin
                                    result_bin=M12B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                            end
                    end
        end else if (max_m_bit == 13) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M13B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M13B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                    result_bin=M13B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                            end else begin
                                    result_bin=M13B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                            end
                        end
        end else if (max_m_bit == 14) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M14B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M14B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                    result_bin=M14B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                            end else begin
                                    result_bin=M14B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                            end
                    end
        end else if (max_m_bit == 15) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M15B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M15B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                    result_bin=M15B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                            end else begin
                                    result_bin=M15B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                            end
                        end
        end else if (max_m_bit == 16) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M16B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M16B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                    result_bin=M16B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                            end else begin
                                    result_bin=M16B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                            end
                        end
        end else if (max_m_bit == 17) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M17B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M17B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                    result_bin=M17B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                            end else begin
                                    result_bin=M17B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                            end
                    end
        end else if (max_m_bit == 18) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M18B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M18B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                    result_bin=M18B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                            end else begin
                                    result_bin=M18B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                            end
                        end
        end else if (max_m_bit == 19) begin
                    if (sign==0) begin // 加法查找
                        if(fractionBits2>=fractionBits1) begin
                                result_bin=M19B2[0][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                        end else begin
                                result_bin=M19B2[0][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
                        end 
                    end else begin // 减法查找
                            if(fractionBits2>=fractionBits1) begin
                                    result_bin=M19B2[1][e_diff][0][fractionBits2-fractionBits1]+fractionBits1;
                            end else begin
                                    result_bin=M19B2[1][e_diff][1][fractionBits1-fractionBits2]+fractionBits2;
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
                // $display("result_bin=",result_bin);
                // $display("result_bin[max_m_bit+:4]",result_bin[max_m_bit+:4]);
                // $display("fraction_result =",fraction_result);
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
        // $display("result =",result);
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


