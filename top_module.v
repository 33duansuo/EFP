`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SEU
// Engineer: Renjun Duan
// 
// Create Date: 2024/12/18 9:46:45
// Design Name: 
// Module Name: TOP
// Project Name: 
// Target Devices: 
// Tool Versions: vivado 2023.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module top_module(
//    input [3:0] sw,              
    input button_up,           
    input button_down,
    input button_center,         
    input clk,                   
    input rst, 
    input [2:0]E,
    input [2:0]M,                     
    output wire [7:0] efp_output
);
wire [23:0] int_val_6=24'h000013;   
wire [23:0] frac_val_6=24'h003000;
wire [3:0] sign=4'h0; 
wire [15:0] clk_cnt; 
wire [15:0] out_clk_cnt;   
wire button_up_reg;      
wire button_down_reg;    
wire button_center_reg;
wire [51:0]efp_to_decimal_value;  

key_debounce #(
        .DELAY_CNT(1000000)  // 20ms 50MHz
    ) key_debounce_inst (
        .clk(clk),          
        .key_in(button_up),     
        .key_out(button_up_reg)    
    );
key_debounce #(
        .DELAY_CNT(1000000)  
    ) key_debounce_inst1 (
        .clk(clk),           
        .key_in(button_down),    
        .key_out(button_down_reg)    
    );
key_debounce #(
        .DELAY_CNT(1000000)  
    ) key_debounce_inst2 (
        .clk(clk),           
        .key_in(button_center),     
        .key_out(button_center_reg)    
    );
// // 实例化 input_decimal 模块
// input_decimal u_input_decimal (
//     .sw(sw),                   // 连接开关输入
//     .button_up(button_up),     // 连接按钮上升输入
//     .button_down(button_down), // 连接按钮下降输入
//     .clk(clk),                 // 连接时钟信号
//     .rst(rst),                 // 连接复位信号
//     .int_val_6(int_val_6),       // 连接整数部分输出
//     .frac_val_6(frac_val_6),     // 连接小数部分输出
//     .sign(sign)                // 连接符号部分输出
// );
// 实例化 decimal_to_efp 模块
decimal_to_efp u_decimal_to_efp (
    .int_val_6(int_val_6),    // 连接整数输入
    .frac_val_6(frac_val_6),  // 连接小数输入
    .sign(sign),               // 连接符号输入
    .clk(clk),                 // 连接时钟信号
    .rst(rst),                 // 连接复位信号
    .button(button_center_reg),           // 连接按钮输入
    .E(E),                     // 连接E输入
    .M(M),                     // 连接M输入
    .efp_output(efp_output),   // 连接EFP输出
    .out_clk_cnt(out_clk_cnt), // 连接输出时钟周期
    .clk_cnt(clk_cnt)          // 连接总时钟周期
);

 efp8_to_decimal u_efp8_to_decimal(
    .clk(clk),           // 时钟信号
    .E(E),               // E 输入
    .M(M),               // M 输入
    .efp8(efp_output),   // EFP8 输入
    .decimal_value(efp_to_decimal_value) // 输出的十进制结果
);

vio_0 your_instance_name (
  .clk(clk),              // input wire clk
  .probe_in0(int_val_6),  // input wire [23 : 0] probe_in0
  .probe_in1(frac_val_6),  // input wire [23 : 0] probe_in1
  .probe_in2(sign),  // input wire [3 : 0] probe_in2
  .probe_in3(efp_output),  // input wire [7 : 0] probe_in3
  .probe_in4(out_clk_cnt),  // input wire [15 : 0] probe_in4
  .probe_in5(E),  // input wire [2 : 0] probe_in5
  .probe_in6(M),  // input wire [2 : 0] probe_in6
  .probe_in7(efp_to_decimal_value)  // input wire [51 : 0] probe_in7
);





endmodule