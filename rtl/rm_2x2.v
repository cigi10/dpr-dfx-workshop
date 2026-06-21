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
    reg [15:0] m00_0,m00_1;
    reg [15:0] m01_0,m01_1;
    reg [15:0] m10_0,m10_1;
    reg [15:0] m11_0,m11_1;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            m00_0<=0; m00_1<=0;
            m01_0<=0; m01_1<=0;
            m10_0<=0; m10_1<=0;
            m11_0<=0; m11_1<=0;
        end else begin
            m00_0<=a00*b00; m00_1<=a01*b10;
            m01_0<=a00*b01; m01_1<=a01*b11;
            m10_0<=a10*b00; m10_1<=a11*b10;
            m11_0<=a10*b01; m11_1<=a11*b11;
        end
    end
    reg [17:0] c00_r,c01_r,c10_r,c11_r;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            c00_r<=0; c01_r<=0;
            c10_r<=0; c11_r<=0;
        end else begin
            c00_r <= ({2'b00, m00_0} + {2'b00, m00_1});
            c01_r <= ({2'b00, m01_0} + {2'b00, m01_1});
            c10_r <= ({2'b00, m10_0} + {2'b00, m10_1});
            c11_r <= ({2'b00, m11_0} + {2'b00, m11_1});
        end
    end
    assign c00=c00_r; assign c01=c01_r;
    assign c10=c10_r; assign c11=c11_r;
    assign c02=18'd0;
    assign c12=18'd0;
    assign c20=18'd0; assign c21=18'd0; assign c22=18'd0;
endmodule
