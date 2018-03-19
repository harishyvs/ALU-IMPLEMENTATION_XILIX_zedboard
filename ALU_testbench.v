`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10.11.2017 01:25:27
// Design Name:
// Module Name: test_bench
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module test_bench();
reg [1:0] a;
reg [1:0] b;
reg [2:0] s;
reg clk=0;
wire [3:0] f;
always
begin
#1 clk=~clk;
end
initial
begin
a=2'b10;
b=2'b00;
s=3'b000;
//$display("sub");
#10
a=2'b01;
b=2'b10;
s=3'b001;
#10
a=2'b11;
b=2'b11;
s=3'b010;
#10
a=2'b10;
b=2'b10;
s=3'b011;
#10
a=2'b01;
b=2'b00;
s=3'b100;
#10
a=2'b11;
b=2'b01;
s=3'b101;
#10
a=2'b10;
b=2'b11;
s=3'b110;
#10
a=2'b01;
b=2'b10;
s=3'b100;
end
alu a1(a,b,s,clk,f);

endmodule
