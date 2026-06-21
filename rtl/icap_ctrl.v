`timescale 1ns/1ps
module icap_ctrl (
    input  clk,
    input  rst,
    input  swap_btn,
    output reg swap_level
);
    reg [19:0] db_cnt;
    reg        btn_sync0, btn_sync1;
    reg        btn_clean, btn_clean_prev;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            btn_sync0      <= 0;
            btn_sync1      <= 0;
            db_cnt         <= 0;
            btn_clean      <= 0;
            btn_clean_prev <= 0;
            swap_level     <= 0;
        end else begin
            btn_sync0 <= swap_btn;
            btn_sync1 <= btn_sync0;
            if (btn_sync1 == btn_clean)
                db_cnt <= 0;
            else begin
                db_cnt <= db_cnt + 1;
                if (db_cnt == 20'hFFFFF)
                    btn_clean <= btn_sync1;
            end
            btn_clean_prev <= btn_clean;
            if (btn_clean & ~btn_clean_prev)
                swap_level <= ~swap_level;
        end
    end
endmodule
