`timescale 1ns / 1ns

// 按钮防抖
module key_debounce #(parameter DELAY_CNT = 'd1_000_000)    //50M时钟时的20ms计数值
(
    input  clk,           // 50MHz
    input  key_in,        // 按钮输入

    output  key_out       // 按钮输出
);

    // 缓存按钮输入，去亚稳态
    reg key_in_buf, key_in_buf0;
    always @(posedge clk ) begin
        key_in_buf0 <= key_in;
        key_in_buf <= key_in_buf0;
    end

    // 检测到按钮按下（低电平），则从0开始计数，直到DELAY_CNT-1，并保持；直到按钮松开，回到计数0
    reg [$clog2(DELAY_CNT) - 1:0] cnt;
    initial begin
        cnt = 'd0;
    end

    always @(posedge clk) begin
        if (key_in_buf) begin
            cnt <= 'd0;
        end else if (cnt == DELAY_CNT-1 ) begin
            cnt <= cnt;
        end else begin
            cnt <= cnt + 1'd1;
        end
    end
    assign key_out = (cnt > (DELAY_CNT>>1))? 1'b0 : 1'b1;

endmodule
