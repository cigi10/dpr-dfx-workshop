`timescale 1ns/1ps
module top (
    input        clk,
    input        rst_n,
    input        swap_btn,
    output [3:0] led,
    output       led_rm
);
    wire gclk, rst;
    assign rst = rst_n;

    clocks U_clocks (
        .clk_in  (clk),
        .rst     (rst),
        .clk_out (gclk)
    );

    reg [31:0] count;
    always @(posedge gclk or posedge rst)
        if (rst) count <= 0;
        else     count <= count + 1;
    wire [7:0] stim_a = count[15:8];
    wire [7:0] stim_b = count[23:16];

    wire [17:0] c00, c01, c02;
    wire [17:0] c10, c11, c12;
    wire [17:0] c20, c21, c22;

    (* DONT_TOUCH = "TRUE" *)
    matrix_rm inst_rp (
        .clk(gclk), .rst(rst),
        .a00(stim_a), .a01(stim_a), .a02(stim_a),
        .a10(stim_a), .a11(stim_a), .a12(stim_a),
        .a20(stim_a), .a21(stim_a), .a22(stim_a),
        .b00(stim_b), .b01(stim_b), .b02(stim_b),
        .b10(stim_b), .b11(stim_b), .b12(stim_b),
        .b20(stim_b), .b21(stim_b), .b22(stim_b),
        .c00(c00), .c01(c01), .c02(c02),
        .c10(c10), .c11(c11), .c12(c12),
        .c20(c20), .c21(c21), .c22(c22)
    );

    reg [31:0] count_d1, count_d2;
    always @(posedge gclk or posedge rst) begin
        if (rst) begin
            count_d1 <= 0; count_d2 <= 0;
        end else begin
            count_d1 <= count; count_d2 <= count_d1;
        end
    end
    wire [7:0] stim_a_d2 = count_d2[15:8];
    wire [7:0] stim_b_d2 = count_d2[23:16];

    wire [15:0] ab_d2      = stim_a_d2 * stim_b_d2;
    wire [17:0] expect_2x2 = {2'b00,ab_d2} + {2'b00,ab_d2};
    wire [17:0] expect_3x3 = {2'b00,ab_d2} + {2'b00,ab_d2} + {2'b00,ab_d2};
    wire        stim_ok    = (stim_a_d2 != 8'd0) && (stim_b_d2 != 8'd0);
    wire        match_2x2  = (c00 == expect_2x2);
    wire        match_3x3  = (c00 == expect_3x3);

    reg rm_is_2x2, rm_is_3x3, rm_fail;
    always @(posedge gclk or posedge rst) begin
        if (rst) begin
            rm_is_2x2 <= 0; rm_is_3x3 <= 0; rm_fail <= 0;
        end else if (stim_ok) begin
            rm_is_2x2 <= match_2x2  && !match_3x3;
            rm_is_3x3 <= match_3x3  && !match_2x2;
            rm_fail   <= !match_2x2 && !match_3x3;
        end
    end

    wire swap_level;
    icap_ctrl U_icap (
        .clk        (gclk),
        .rst        (rst),
        .swap_btn   (swap_btn),
        .swap_level (swap_level)
    );

    reg        swap_level_d;
    reg [24:0] stretch_cnt;
    reg        swap_flash;
    always @(posedge gclk or posedge rst) begin
        if (rst) begin
            swap_level_d <= 0; stretch_cnt <= 0; swap_flash <= 0;
        end else begin
            swap_level_d <= swap_level;
            if (swap_level != swap_level_d) begin
                stretch_cnt <= 25'h1FFFFFF;
                swap_flash  <= 1'b1;
            end else if (stretch_cnt != 0) begin
                stretch_cnt <= stretch_cnt - 1'b1;
                swap_flash  <= 1'b1;
            end else begin
                swap_flash <= 1'b0;
            end
        end
    end

    vio_0 U_vio (
        .clk       (gclk),
        .probe_in0 (swap_level)
    );

    assign led[3] = rm_is_3x3;
    assign led[2] = rm_is_2x2;
    assign led[1] = rm_fail;
    assign led[0] = swap_flash;
    assign led_rm = swap_level;
endmodule
