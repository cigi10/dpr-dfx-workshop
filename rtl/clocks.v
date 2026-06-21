`timescale 1ns/1ps
module clocks (
    input  clk_in,
    input  rst,
    output clk_out
);
    wire clkfbout, clkfbout_buf, clkout0;
    MMCME2_ADV #(
        .BANDWIDTH          ("OPTIMIZED"),
        .CLKOUT4_CASCADE    ("FALSE"),
        .COMPENSATION       ("ZHOLD"),
        .STARTUP_WAIT       ("FALSE"),
        .DIVCLK_DIVIDE      (1),
        .CLKFBOUT_MULT_F    (10.000),
        .CLKFBOUT_PHASE     (0.000),
        .CLKOUT0_DIVIDE_F   (10.000),
        .CLKOUT0_PHASE      (0.000),
        .CLKOUT0_DUTY_CYCLE (0.500),
        .CLKIN1_PERIOD      (10.000)
    ) mmcm_inst (
        .CLKFBOUT   (clkfbout),
        .CLKOUT0    (clkout0),
        .CLKFBIN    (clkfbout_buf),
        .CLKIN1     (clk_in),
        .CLKIN2     (1'b0),
        .CLKINSEL   (1'b1),
        .DADDR      (7'h0),
        .DCLK       (1'b0),
        .DEN        (1'b0),
        .DI         (16'h0),
        .DWE        (1'b0),
        .PSCLK      (1'b0),
        .PSEN       (1'b0),
        .PSINCDEC   (1'b0),
        .PWRDWN     (1'b0),
        .RST        (rst),
        .DO         (),
        .DRDY       (),
        .PSDONE     (),
        .LOCKED     (),
        .CLKFBOUTB  (),
        .CLKOUT0B   (),
        .CLKOUT1    (), .CLKOUT1B(),
        .CLKOUT2    (), .CLKOUT2B(),
        .CLKOUT3    (), .CLKOUT3B(),
        .CLKOUT4    (),
        .CLKOUT5    (),
        .CLKOUT6    (),
        .CLKINSTOPPED(),
        .CLKFBSTOPPED()
    );
    BUFG clkfb_buf  (.O(clkfbout_buf), .I(clkfbout));
    BUFG clkout_buf (.O(clk_out),      .I(clkout0));
endmodule
