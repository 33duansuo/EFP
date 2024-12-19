module input_decimal(
    input [3:0] sw,              // 输入的4位开关值
    input button_up,           
    input button_down,           
    input clk,                   // 时钟信号
    input rst,                   // 复位信号
    output reg [23:0] int_val_6, // 整数部分输出
    output reg [23:0] frac_val_6, // 小数部分输出
    output reg [3:0] sign        // 符号部分输出
);

// 定义一个52位的寄存器，用于存储当前值
reg [51:0] decimal=52'h0_000000_000000;           // 存储数据的寄存器

// 当button_up触发时，将sw[3:0]存入decimal并执行左移
always @(posedge button_up) begin
        decimal[3:0] <= sw;  // 存储当前的sw[3:0]到decimal[3:0]
        decimal <= decimal << 4; // 进位
end

always @(posedge button_up) begin
        decimal <= decimal >> 4; // 进位
end

// 将decimal拆分为符号、整数部分和小数部分
always @(posedge clk) begin
    if (rst) begin
        int_val_6 <= 24'b0;
        frac_val_6 <= 24'b0;
        sign <= 4'b0;
    end else begin
        sign <= decimal[51:48];       // 符号位
        int_val_6 <= decimal[47:24];  // 整数部分
        frac_val_6 <= decimal[23:0];  // 小数部分
    end
end

endmodule
