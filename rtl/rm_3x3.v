module matrix_rm (
    input        clk,
    input        rst,
    input  [7:0] a00,a01,a02,
    input  [7:0] a10,a11,a12,
    input  [7:0] a20,a21,a22,
    input  [7:0] b00,b01,b02,
    input  [7:0] b10,b11,b12,
    input  [7:0] b20,b21,b22,
    output [17:0] c00,c01,c02,
    output [17:0] c10,c11,c12,
    output [17:0] c20,c21,c22
);
    reg [15:0] m00_0,m00_1,m00_2;
    reg [15:0] m01_0,m01_1,m01_2;
    reg [15:0] m02_0,m02_1,m02_2;
    reg [15:0] m10_0,m10_1,m10_2;
    reg [15:0] m11_0,m11_1,m11_2;
    reg [15:0] m12_0,m12_1,m12_2;
    reg [15:0] m20_0,m20_1,m20_2;
    reg [15:0] m21_0,m21_1,m21_2;
    reg [15:0] m22_0,m22_1,m22_2;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            m00_0<=0;m00_1<=0;m00_2<=0;
            m01_0<=0;m01_1<=0;m01_2<=0;
            m02_0<=0;m02_1<=0;m02_2<=0;
            m10_0<=0;m10_1<=0;m10_2<=0;
            m11_0<=0;m11_1<=0;m11_2<=0;
            m12_0<=0;m12_1<=0;m12_2<=0;
            m20_0<=0;m20_1<=0;m20_2<=0;
            m21_0<=0;m21_1<=0;m21_2<=0;
            m22_0<=0;m22_1<=0;m22_2<=0;
        end else begin
            m00_0<=a00*b00; m00_1<=a01*b10; m00_2<=a02*b20;
            m01_0<=a00*b01; m01_1<=a01*b11; m01_2<=a02*b21;
            m02_0<=a00*b02; m02_1<=a01*b12; m02_2<=a02*b22;
            m10_0<=a10*b00; m10_1<=a11*b10; m10_2<=a12*b20;
            m11_0<=a10*b01; m11_1<=a11*b11; m11_2<=a12*b21;
            m12_0<=a10*b02; m12_1<=a11*b12; m12_2<=a12*b22;
            m20_0<=a20*b00; m20_1<=a21*b10; m20_2<=a22*b20;
            m21_0<=a20*b01; m21_1<=a21*b11; m21_2<=a22*b21;
            m22_0<=a20*b02; m22_1<=a21*b12; m22_2<=a22*b22;
        end
    end
    reg [17:0] c00_r,c01_r,c02_r;
    reg [17:0] c10_r,c11_r,c12_r;
    reg [17:0] c20_r,c21_r,c22_r;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            c00_r<=0;c01_r<=0;c02_r<=0;
            c10_r<=0;c11_r<=0;c12_r<=0;
            c20_r<=0;c21_r<=0;c22_r<=0;
        end else begin
            c00_r<=m00_0+m00_1+m00_2;
            c01_r<=m01_0+m01_1+m01_2;
            c02_r<=m02_0+m02_1+m02_2;
            c10_r<=m10_0+m10_1+m10_2;
            c11_r<=m11_0+m11_1+m11_2;
            c12_r<=m12_0+m12_1+m12_2;
            c20_r<=m20_0+m20_1+m20_2;
            c21_r<=m21_0+m21_1+m21_2;
            c22_r<=m22_0+m22_1+m22_2;
        end
    end
    assign c00=c00_r; assign c01=c01_r; assign c02=c02_r;
    assign c10=c10_r; assign c11=c11_r; assign c12=c12_r;
    assign c20=c20_r; assign c21=c21_r; assign c22=c22_r;
endmodule
