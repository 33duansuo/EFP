`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/13 17:00:00
// Design Name: Add1 Testbench
// Module Name: Add1_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Testbench for Add1 module
// 
//////////////////////////////////////////////////////////////////////////////////

module Add1_tb;

    // Inputs
    reg [23:0] fp8Binary1;
    reg [23:0] fp8Binary2;
    reg [18:0] m_bit1;
    reg [18:0] m_bit2;

//    reg [4:0] M1B2[1:0][3:0][1:0][1:0];
    reg [5:0] M2B2[1:0][4:0][1:0][3:0];
    reg [6:0] M3B2[1:0][5:0][1:0][7:0];
    //表格太大了，导不进去
    reg [7:0] M4B2[1:0][6:0][1:0][1:0];
    reg [8:0] M5B2[1:0][7:0][1:0][1:0];
    reg [9:0] M6B2[1:0][8:0][1:0][1:0];
    reg [10:0] M7B2[1:0][9:0][1:0][1:0];
    reg [11:0] M8B2[1:0][10:0][1:0][1:0];
    reg [12:0] M9B2[1:0][11:0][1:0][1:0];
    reg [13:0] M10B2[1:0][12:0][1:0][1:0];
    reg [14:0] M11B2[1:0][13:0][1:0][1:0];
    reg [15:0] M12B2[1:0][14:0][1:0][1:0];
    reg [16:0] M13B2[1:0][15:0][1:0][1:0];
    reg [17:0] M14B2[1:0][16:0][1:0][1:0];
    reg [18:0] M15B2[1:0][17:0][1:0][1:0];
    reg [19:0] M16B2[1:0][18:0][1:0][1:0];
    reg [20:0] M17B2[1:0][19:0][1:0][1:0];
    reg [21:0] M18B2[1:0][20:0][1:0][1:0];
    reg [22:0] M19B2[1:0][21:0][1:0][1:0];
    reg  result_sign;
    reg  [3:0]e_binary;
    reg  [18:0] m_binary;
    reg  [4:0]m_bit_num;
    reg  [3:0]input_expont1;
    reg  [18:0]input_frac1;
    reg  [3:0]input_expont2;
    reg  [18:0]input_frac2;
    reg  input_sign1;
    reg  input_sign2;
    reg [18:0]clk;
    reg [18:0]time_used=0;





    // Outputs
    wire [23:0] data;
    wire [4:0] bias;

    // Instantiate the Add1 module
    Add1 uut (
        .clk(clk),
        .fp8Binary1(fp8Binary1),
        .fp8Binary2(fp8Binary2),
        .m_bit1(m_bit1),
        .m_bit2(m_bit2),
        .M2B2(M2B2),
        .M3B2(M3B2),
        .M4B2(M4B2),
        .M5B2(M5B2),
        .M6B2(M6B2),
        .M7B2(M7B2),
        .M8B2(M8B2),
        .M9B2(M9B2),
        .M10B2(M10B2),
        .M11B2(M11B2),
        .M12B2(M12B2),
        .M13B2(M13B2),
        .M14B2(M14B2),
        .M15B2(M15B2),
        .M16B2(M16B2),
        .M17B2(M17B2),
        .M18B2(M18B2),
        .M19B2(M19B2),
        .sign_result(result_sign),
        .result_bias(bias),
        .result_exp(e_binary),
        .result_man(m_binary),
        .output_m_bits(m_bit_num),
        .time_period(time_used)
    );
    initial begin  
        clk = 0;  
        forever  
            #(5) clk = ~clk;  
    end  


    // Test cases
    initial begin
                //读取数据到数??
//        $readmemh("D:/Tiaocup/EFP_add/M1B2_0_0.txt", M1B2[0][0]);
//        $readmemh("D:/Tiaocup/EFP_add/M1B2_0_1.txt", M1B2[0][1]);
//        $readmemh("D:/Tiaocup/EFP_add/M1B2_0_2.txt", M1B2[0][2]);
//        $readmemh("D:/Tiaocup/EFP_add/M1B2_0_3.txt", M1B2[0][3]);
//        $readmemh("D:/Tiaocup/EFP_add/M1B2_1_0.txt", M1B2[1][0]);
//        $readmemh("D:/Tiaocup/EFP_add/M1B2_1_1.txt", M1B2[1][1]);
//        $readmemh("D:/Tiaocup/EFP_add/M1B2_1_2.txt", M1B2[1][2]);
//        $readmemh("D:/Tiaocup/EFP_add/M1B2_1_3.txt", M1B2[1][3]);      
        $readmemh("D:/Tiaocup/EFP_add/M2B2_0_0.txt", M2B2[0][0]);
        $readmemh("D:/Tiaocup/EFP_add/M2B2_0_1.txt", M2B2[0][1]);
        $readmemh("D:/Tiaocup/EFP_add/M2B2_0_2.txt", M2B2[0][2]);
        $readmemh("D:/Tiaocup/EFP_add/M2B2_0_3.txt", M2B2[0][3]);
        $readmemh("D:/Tiaocup/EFP_add/M2B2_0_4.txt", M2B2[0][4]);
        $readmemh("D:/Tiaocup/EFP_add/M2B2_1_0.txt", M2B2[1][0]);
        $readmemh("D:/Tiaocup/EFP_add/M2B2_1_1.txt", M2B2[1][1]);
        $readmemh("D:/Tiaocup/EFP_add/M2B2_1_2.txt", M2B2[1][2]);
        $readmemh("D:/Tiaocup/EFP_add/M2B2_1_3.txt", M2B2[1][3]);
        $readmemh("D:/Tiaocup/EFP_add/M2B2_1_4.txt", M2B2[1][4]);
        //M3B2
        $readmemh("D:/Tiaocup/EFP_add/M3B2_0_0.txt", M3B2[0][0]);
        $readmemh("D:/Tiaocup/EFP_add/M3B2_0_1.txt", M3B2[0][1]);
        $readmemh("D:/Tiaocup/EFP_add/M3B2_0_2.txt", M3B2[0][2]);
        $readmemh("D:/Tiaocup/EFP_add/M3B2_0_3.txt", M3B2[0][3]);
        $readmemh("D:/Tiaocup/EFP_add/M3B2_0_4.txt", M3B2[0][4]);
        $readmemh("D:/Tiaocup/EFP_add/M2B2_0_5.txt", M2B2[0][5]);
        $readmemh("D:/Tiaocup/EFP_add/M3B2_1_0.txt", M3B2[1][0]);
        $readmemh("D:/Tiaocup/EFP_add/M3B2_1_1.txt", M3B2[1][1]);
        $readmemh("D:/Tiaocup/EFP_add/M3B2_1_2.txt", M3B2[1][2]);
        $readmemh("D:/Tiaocup/EFP_add/M3B2_1_3.txt", M3B2[1][3]);
        $readmemh("D:/Tiaocup/EFP_add/M3B2_1_4.txt", M3B2[1][4]);
        $readmemh("D:/Tiaocup/EFP_add/M3B2_1_5.txt", M3B2[1][5]);
        // //M4B2
        // $readmemh("D:/Tiaocup/EFP_add/M4B2_0_0.txt", M4B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M4B2_0_1.txt", M4B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M4B2_0_2.txt", M4B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M4B2_0_3.txt", M4B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M4B2_0_4.txt", M4B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M4B2_0_5.txt", M4B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M3B2_0_6.txt", M4B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M4B2_1_0.txt", M4B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M4B2_1_1.txt", M4B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M4B2_1_2.txt", M4B2[1][2]);   
        // $readmemh("D:/Tiaocup/EFP_add/M4B2_1_3.txt", M4B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M4B2_1_4.txt", M4B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M4B2_1_5.txt", M4B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M4B2_1_6.txt", M4B2[1][6]);
        // //M5B2
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_0_0.txt", M5B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_0_1.txt", M5B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_0_2.txt", M5B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_0_3.txt", M5B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_0_4.txt", M5B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_0_5.txt", M5B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_0_6.txt", M5B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_0_7.txt", M5B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_1_0.txt", M5B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_1_1.txt", M5B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_1_2.txt", M5B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_1_3.txt", M5B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_1_4.txt", M5B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_1_5.txt", M5B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_1_6.txt", M5B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M5B2_1_7.txt", M5B2[1][7]);
        // //M6B2
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_0_0.txt", M6B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_0_1.txt", M6B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_0_2.txt", M6B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_0_3.txt", M6B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_0_4.txt", M6B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_0_5.txt", M6B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_0_6.txt", M6B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_0_7.txt", M6B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_0_8.txt", M6B2[0][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_1_0.txt", M6B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_1_1.txt", M6B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_1_2.txt", M6B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_1_3.txt", M6B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_1_4.txt", M6B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_1_5.txt", M6B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_1_6.txt", M6B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_1_7.txt", M6B2[1][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M6B2_1_8.txt", M6B2[1][8]);
        // //M7B2
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_0_0.txt", M7B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_0_1.txt", M7B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_0_2.txt", M7B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_0_3.txt", M7B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_0_4.txt", M7B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_0_5.txt", M7B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_0_6.txt", M7B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_0_7.txt", M7B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_0_8.txt", M7B2[0][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_0_9.txt", M7B2[0][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_1_0.txt", M7B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_1_1.txt", M7B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_1_2.txt", M7B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_1_3.txt", M7B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_1_4.txt", M7B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_1_5.txt", M7B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_1_6.txt", M7B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_1_7.txt", M7B2[1][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_1_8.txt", M7B2[1][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M7B2_1_9.txt", M7B2[1][9]);
        // //M8B2
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_0_0.txt", M8B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_0_1.txt", M8B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_0_2.txt", M8B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_0_3.txt", M8B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_0_4.txt", M8B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_0_5.txt", M8B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_0_6.txt", M8B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_0_7.txt", M8B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_0_8.txt", M8B2[0][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_0_9.txt", M8B2[0][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_0_10.txt", M8B2[0][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_1_0.txt", M8B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_1_1.txt", M8B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_1_2.txt", M8B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_1_3.txt", M8B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_1_4.txt", M8B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_1_5.txt", M8B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_1_6.txt", M8B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_1_7.txt", M8B2[1][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_1_8.txt", M8B2[1][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_1_9.txt", M8B2[1][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M8B2_1_10.txt", M8B2[1][10]);
        // //M9B2
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_0_0.txt", M9B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_0_1.txt", M9B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_0_2.txt", M9B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_0_3.txt", M9B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_0_4.txt", M9B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_0_5.txt", M9B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_0_6.txt", M9B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_0_7.txt", M9B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_0_8.txt", M9B2[0][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_0_9.txt", M9B2[0][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_0_10.txt", M9B2[0][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_0_11.txt", M9B2[0][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_1_0.txt", M9B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_1_1.txt", M9B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_1_2.txt", M9B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_1_3.txt", M9B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_1_4.txt", M9B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_1_5.txt", M9B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_1_6.txt", M9B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_1_7.txt", M9B2[1][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_1_8.txt", M9B2[1][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_1_9.txt", M9B2[1][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_1_10.txt", M9B2[1][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M9B2_1_11.txt", M9B2[1][11]);
        // //M10B2
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_0_0.txt", M10B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_0_1.txt", M10B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_0_2.txt", M10B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_0_3.txt", M10B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_0_4.txt", M10B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_0_5.txt", M10B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_0_6.txt", M10B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_0_7.txt", M10B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_0_8.txt", M10B2[0][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_0_9.txt", M10B2[0][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_0_10.txt", M10B2[0][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_0_11.txt", M10B2[0][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_0_12.txt", M10B2[0][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_1_0.txt", M10B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_1_1.txt", M10B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_1_2.txt", M10B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_1_3.txt", M10B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_1_4.txt", M10B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_1_5.txt", M10B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_1_6.txt", M10B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_1_7.txt", M10B2[1][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_1_8.txt", M10B2[1][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_1_9.txt", M10B2[1][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_1_10.txt", M10B2[1][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_1_11.txt", M10B2[1][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M10B2_1_12.txt", M10B2[1][12]);
        // //M11B2
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_0_0.txt", M11B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_0_1.txt", M11B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_0_2.txt", M11B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_0_3.txt", M11B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_0_4.txt", M11B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_0_5.txt", M11B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_0_6.txt", M11B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_0_7.txt", M11B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_0_8.txt", M11B2[0][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_0_9.txt", M11B2[0][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_0_10.txt", M11B2[0][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_0_11.txt", M11B2[0][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_0_12.txt", M11B2[0][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_0_13.txt", M11B2[0][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_1_0.txt", M11B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_1_1.txt", M11B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_1_2.txt", M11B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_1_3.txt", M11B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_1_4.txt", M11B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_1_5.txt", M11B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_1_6.txt", M11B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_1_7.txt", M11B2[1][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_1_8.txt", M11B2[1][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_1_9.txt", M11B2[1][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_1_10.txt", M11B2[1][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_1_11.txt", M11B2[1][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_1_12.txt", M11B2[1][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M11B2_1_13.txt", M11B2[1][13]);
        // //M12B2
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_0.txt", M12B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_1.txt", M12B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_2.txt", M12B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_3.txt", M12B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_4.txt", M12B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_5.txt", M12B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_6.txt", M12B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_7.txt", M12B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_8.txt", M12B2[0][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_9.txt", M12B2[0][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_10.txt", M12B2[0][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_11.txt", M12B2[0][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_12.txt", M12B2[0][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_13.txt", M12B2[0][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_0_14.txt", M12B2[0][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_0.txt", M12B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_1.txt", M12B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_2.txt", M12B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_3.txt", M12B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_4.txt", M12B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_5.txt", M12B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_6.txt", M12B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_7.txt", M12B2[1][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_8.txt", M12B2[1][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_9.txt", M12B2[1][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_10.txt", M12B2[1][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_11.txt", M12B2[1][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_12.txt", M12B2[1][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_13.txt", M12B2[1][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M12B2_1_14.txt", M12B2[1][14]);
        // //M13B2
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_0.txt", M13B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_1.txt", M13B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_2.txt", M13B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_3.txt", M13B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_4.txt", M13B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_5.txt", M13B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_6.txt", M13B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_7.txt", M13B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_8.txt", M13B2[0][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_9.txt", M13B2[0][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_10.txt", M13B2[0][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_11.txt", M13B2[0][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_12.txt", M13B2[0][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_13.txt", M13B2[0][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_14.txt", M13B2[0][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_0_15.txt", M13B2[0][15]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_0.txt", M13B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_1.txt", M13B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_2.txt", M13B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_3.txt", M13B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_4.txt", M13B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_5.txt", M13B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_6.txt", M13B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_7.txt", M13B2[1][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_8.txt", M13B2[1][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_9.txt", M13B2[1][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_10.txt", M13B2[1][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_11.txt", M13B2[1][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_12.txt", M13B2[1][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_13.txt", M13B2[1][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_14.txt", M13B2[1][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M13B2_1_15.txt", M13B2[1][15]);
        // //M14B2
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_0.txt", M14B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_1.txt", M14B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_2.txt", M14B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_3.txt", M14B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_4.txt", M14B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_5.txt", M14B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_6.txt", M14B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_7.txt", M14B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_8.txt", M14B2[0][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_9.txt", M14B2[0][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_10.txt", M14B2[0][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_11.txt", M14B2[0][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_12.txt", M14B2[0][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_13.txt", M14B2[0][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_14.txt", M14B2[0][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_15.txt", M14B2[0][15]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_0_16.txt", M14B2[0][16]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_0.txt", M14B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_1.txt", M14B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_2.txt", M14B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_3.txt", M14B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_4.txt", M14B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_5.txt", M14B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_6.txt", M14B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_7.txt", M14B2[1][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_8.txt", M14B2[1][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_9.txt", M14B2[1][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_10.txt", M14B2[1][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_11.txt", M14B2[1][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_12.txt", M14B2[1][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_13.txt", M14B2[1][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_14.txt", M14B2[1][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_15.txt", M14B2[1][15]);
        // $readmemh("D:/Tiaocup/EFP_add/M14B2_1_16.txt", M14B2[1][16]);
        // //M15B2
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_0.txt", M15B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_1.txt", M15B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_2.txt", M15B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_3.txt", M15B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_4.txt", M15B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_5.txt", M15B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_6.txt", M15B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_7.txt", M15B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_8.txt", M15B2[0][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_9.txt", M15B2[0][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_10.txt", M15B2[0][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_11.txt", M15B2[0][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_12.txt", M15B2[0][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_13.txt", M15B2[0][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_14.txt", M15B2[0][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_15.txt", M15B2[0][15]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_16.txt", M15B2[0][16]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_0_17.txt", M15B2[0][17]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_0.txt", M15B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_1.txt", M15B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_2.txt", M15B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_3.txt", M15B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_4.txt", M15B2[1][4]); 
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_5.txt", M15B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_6.txt", M15B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_7.txt", M15B2[1][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_8.txt", M15B2[1][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_9.txt", M15B2[1][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_10.txt", M15B2[1][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_11.txt", M15B2[1][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_12.txt", M15B2[1][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_13.txt", M15B2[1][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_14.txt", M15B2[1][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_15.txt", M15B2[1][15]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_16.txt", M15B2[1][16]);
        // $readmemh("D:/Tiaocup/EFP_add/M15B2_1_17.txt", M15B2[1][17]);
        // //M16B2
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_0.txt", M16B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_1.txt", M16B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_2.txt", M16B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_3.txt", M16B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_4.txt", M16B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_5.txt", M16B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_6.txt", M16B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_7.txt", M16B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_8.txt", M16B2[0][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_9.txt", M16B2[0][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_10.txt", M16B2[0][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_11.txt", M16B2[0][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_12.txt", M16B2[0][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_13.txt", M16B2[0][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_14.txt", M16B2[0][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_15.txt", M16B2[0][15]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_16.txt", M16B2[0][16]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_17.txt", M16B2[0][17]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_0_18.txt", M16B2[0][18]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_0.txt", M16B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_1.txt", M16B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_2.txt", M16B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_3.txt", M16B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_4.txt", M16B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_5.txt", M16B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_6.txt", M16B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_7.txt", M16B2[1][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_8.txt", M16B2[1][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_9.txt", M16B2[1][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_10.txt", M16B2[1][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_11.txt", M16B2[1][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_12.txt", M16B2[1][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_13.txt", M16B2[1][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_14.txt", M16B2[1][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_15.txt", M16B2[1][15]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_16.txt", M16B2[1][16]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_17.txt", M16B2[1][17]);
        // $readmemh("D:/Tiaocup/EFP_add/M16B2_1_18.txt", M16B2[1][18]);
        // //M17B2
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_0.txt", M17B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_1.txt", M17B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_2.txt", M17B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_3.txt", M17B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_4.txt", M17B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_5.txt", M17B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_6.txt", M17B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_7.txt", M17B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_8.txt", M17B2[0][8]); 
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_9.txt", M17B2[0][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_10.txt", M17B2[0][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_11.txt", M17B2[0][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_12.txt", M17B2[0][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_13.txt", M17B2[0][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_14.txt", M17B2[0][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_15.txt", M17B2[0][15]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_16.txt", M17B2[0][16]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_17.txt", M17B2[0][17]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_18.txt", M17B2[0][18]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_0_19.txt", M17B2[0][19]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_0.txt", M17B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_1.txt", M17B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_2.txt", M17B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_3.txt", M17B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_4.txt", M17B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_5.txt", M17B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_6.txt", M17B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_7.txt", M17B2[1][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_8.txt", M17B2[1][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_9.txt", M17B2[1][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_10.txt", M17B2[1][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_11.txt", M17B2[1][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_12.txt", M17B2[1][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_13.txt", M17B2[1][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_14.txt", M17B2[1][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_15.txt", M17B2[1][15]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_16.txt", M17B2[1][16]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_17.txt", M17B2[1][17]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_18.txt", M17B2[1][18]);
        // $readmemh("D:/Tiaocup/EFP_add/M17B2_1_19.txt", M17B2[1][19]);
        // //M18B2
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_0.txt", M18B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_1.txt", M18B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_2.txt", M18B2[0][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_3.txt", M18B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_4.txt", M18B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_5.txt", M18B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_6.txt", M18B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_7.txt", M18B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_8.txt", M18B2[0][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_9.txt", M18B2[0][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_10.txt", M18B2[0][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_11.txt", M18B2[0][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_12.txt", M18B2[0][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_13.txt", M18B2[0][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_14.txt", M18B2[0][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_15.txt", M18B2[0][15]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_16.txt", M18B2[0][16]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_17.txt", M18B2[0][17]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_18.txt", M18B2[0][18]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_19.txt", M18B2[0][19]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_0_20.txt", M18B2[0][20]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_0.txt", M18B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_1.txt", M18B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_2.txt", M18B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_3.txt", M18B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_4.txt", M18B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_5.txt", M18B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_6.txt", M18B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_7.txt", M18B2[1][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_8.txt", M18B2[1][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_9.txt", M18B2[1][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_10.txt", M18B2[1][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_11.txt", M18B2[1][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_12.txt", M18B2[1][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_13.txt", M18B2[1][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_14.txt", M18B2[1][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_15.txt", M18B2[1][15]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_16.txt", M18B2[1][16]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_17.txt", M18B2[1][17]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_18.txt", M18B2[1][18]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_19.txt", M18B2[1][19]);
        // $readmemh("D:/Tiaocup/EFP_add/M18B2_1_20.txt", M18B2[1][20]);
        // //M19B2
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_0.txt", M19B2[0][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_1.txt", M19B2[0][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_2.txt", M19B2[0][2]); 
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_3.txt", M19B2[0][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_4.txt", M19B2[0][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_5.txt", M19B2[0][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_6.txt", M19B2[0][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_7.txt", M19B2[0][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_8.txt", M19B2[0][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_9.txt", M19B2[0][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_10.txt", M19B2[0][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_11.txt", M19B2[0][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_12.txt", M19B2[0][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_13.txt", M19B2[0][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_14.txt", M19B2[0][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_15.txt", M19B2[0][15]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_16.txt", M19B2[0][16]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_17.txt", M19B2[0][17]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_18.txt", M19B2[0][18]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_19.txt", M19B2[0][19]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_20.txt", M19B2[0][20]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_0_21.txt", M19B2[0][21]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_0.txt", M18B2[1][0]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_1.txt", M18B2[1][1]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_2.txt", M18B2[1][2]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_3.txt", M18B2[1][3]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_4.txt", M18B2[1][4]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_5.txt", M18B2[1][5]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_6.txt", M18B2[1][6]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_7.txt", M18B2[1][7]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_8.txt", M18B2[1][8]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_9.txt", M18B2[1][9]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_10.txt", M18B2[1][10]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_11.txt", M18B2[1][11]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_12.txt", M18B2[1][12]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_13.txt", M18B2[1][13]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_14.txt", M18B2[1][14]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_15.txt", M18B2[1][15]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_16.txt", M18B2[1][16]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_17.txt", M18B2[1][17]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_18.txt", M18B2[1][18]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_19.txt", M18B2[1][19]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_20.txt", M18B2[1][20]);
        // $readmemh("D:/Tiaocup/EFP_add/M19B2_1_21.txt", M18B2[1][21]);

        #10
        // Test case 1: Two positive numbers with similar exponents
        input_sign1 = 1'b0;
        input_expont1 = 4'b0111;
        input_frac1 = 4;
        m_bit1 = 3;  // 1 bits for the fraction part
        input_sign2 = 1'b1;
        input_expont2 = 4'b0111;
        input_frac2 = 0;
        m_bit2 = 2; 
        fp8Binary1[23] = input_sign1;
        fp8Binary1[22:19] = input_expont1;
        fp8Binary1[18:0] = input_frac1;
        fp8Binary2[23] = input_sign2;
        fp8Binary2[22:19] = input_expont2;
        fp8Binary2[18:0] = input_frac2;
        // Call the function to add the two numbers
        #10;  // Wait for the result
        $display("Test case 1:sign = %b,exp= %b,man= %b, m_bit_num= %d,bias = %d", result_sign,e_binary,m_binary[2:0] , m_bit_num,bias);
        $display("Test case 1:time_used = %d",time_used);
        
        
        
    end

endmodule

