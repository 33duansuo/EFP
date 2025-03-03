`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/27 19:06:42
// Design Name: 
// Module Name: top
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


module top(
    input clk
    );

 // Inputs
    reg [23:0] fp8Binary1;
    reg [23:0] fp8Binary2;
    reg [4:0] m_bit1;
    reg [4:0] m_bit2;
    reg  result_sign;
    reg  [3:0]e_binary;
    reg  [18:0] m_binary;
    reg  [4:0]m_bit_num;
    reg  [4:0]bias;
    reg  [3:0]input_expont1;
    reg  [18:0]input_frac1;
    reg  [3:0]input_expont2;
    reg  [18:0]input_frac2;
    reg  [18:0] time_used;
    reg  sure_cal;
    reg  input_sign1;
    reg  input_sign2;
    
vio_0 vio_instance (
    .clk(clk),                // input wire clk
    .probe_in0(result_sign),    // input wire [0 : 0] probe_in0
    .probe_in1(e_binary),    // input wire [3 : 0] probe_in1
    .probe_in2(m_binary),    // input wire [18 : 0] probe_in2
    .probe_in3(m_bit_num),    // input wire [4 : 0] probe_in3
    .probe_in4(bias),    // input wire [4 : 0] probe_in4
    .probe_in5(time_used),    // input wire [18 : 0] probe_in5
    .probe_out0(input_sign1),  // output wire [0 : 0] probe_out0
    .probe_out1(input_sign2),  // output wire [0 : 0] probe_out1
    .probe_out2(input_expont1),  // output wire [3 : 0] probe_out2
    .probe_out3(input_expont2),  // output wire [3 : 0] probe_out3
    .probe_out4(input_frac1),  // output wire [18 : 0] probe_out4
    .probe_out5(input_frac2),  // output wire [18 : 0] probe_out5
    .probe_out6(m_bit1),  // output wire [4 : 0] probe_out6
    .probe_out7(m_bit2),  // output wire [4 : 0] probe_out7
    .probe_out8(sure_cal)  // output wire [0 : 0] probe_out8
    );
    
    
    
Add1 uut (
        .clk(clk),
        .fp8Binary1(fp8Binary1),
        .fp8Binary2(fp8Binary2),
        .m_bit1(m_bit1),
        .m_bit2(m_bit2),
        .sign_result(result_sign),
        .result_bias(bias),
        .result_exp(e_binary),
        .result_man(m_binary),
        .result_m_bit(m_bit_num),
        .time_period(time_used)
    );

    initial begin
        input_sign1 = 1'b0;
        input_expont1 = 4'b0111;
        input_frac1 = 4;
        m_bit1 = 3;  // 1 bits for the fraction part
        input_sign2 = 1'b0;
        input_expont2 = 4'b0111;
        input_frac2 = 0;
        m_bit2 = 2; 
        fp8Binary1[23] = input_sign1;
        fp8Binary1[22:19] = input_expont1;
        fp8Binary1[18:0] = input_frac1;
        fp8Binary2[23] = input_sign2;
        fp8Binary2[22:19] = input_expont2;
        fp8Binary2[18:0] = input_frac2;

    end


   always @(posedge clk) begin
        fp8Binary1[23] = input_sign1;
        fp8Binary1[22:19] = input_expont1;
        fp8Binary1[18:0] = input_frac1;
        fp8Binary2[23] = input_sign2;
        fp8Binary2[22:19] = input_expont2;
        fp8Binary2[18:0] = input_frac2;
        end
endmodule