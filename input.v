module input_decimal(
    input [3:0] sw,              // �����4λ����ֵ
    input button_up,           
    input button_down,           
    input clk,                   // ʱ���ź�
    input rst,                   // ��λ�ź�
    output reg [23:0] int_val_6, // �����������
    output reg [23:0] frac_val_6, // С���������
    output reg [3:0] sign        // ���Ų������
);

// ����һ��52λ�ļĴ��������ڴ洢��ǰֵ
reg [51:0] decimal=52'h0_000000_000000;           // �洢���ݵļĴ���

// ��button_up����ʱ����sw[3:0]����decimal��ִ������
always @(posedge button_up) begin
        decimal[3:0] <= sw;  // �洢��ǰ��sw[3:0]��decimal[3:0]
        decimal <= decimal << 4; // ��λ
end

always @(posedge button_up) begin
        decimal <= decimal >> 4; // ��λ
end

// ��decimal���Ϊ���š��������ֺ�С������
always @(posedge clk) begin
    if (rst) begin
        int_val_6 <= 24'b0;
        frac_val_6 <= 24'b0;
        sign <= 4'b0;
    end else begin
        sign <= decimal[51:48];       // ����λ
        int_val_6 <= decimal[47:24];  // ��������
        frac_val_6 <= decimal[23:0];  // С������
    end
end

endmodule
