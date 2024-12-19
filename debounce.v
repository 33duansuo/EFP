`timescale 1ns / 1ns

// ��ť����
module key_debounce #(parameter DELAY_CNT = 'd1_000_000)    //50Mʱ��ʱ��20ms����ֵ
(
    input  clk,           // 50MHz
    input  key_in,        // ��ť����

    output  key_out       // ��ť���
);

    // ���水ť���룬ȥ����̬
    reg key_in_buf, key_in_buf0;
    always @(posedge clk ) begin
        key_in_buf0 <= key_in;
        key_in_buf <= key_in_buf0;
    end

    // ��⵽��ť���£��͵�ƽ�������0��ʼ������ֱ��DELAY_CNT-1�������֣�ֱ����ť�ɿ����ص�����0
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
