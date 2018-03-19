`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09.11.2017 22:57:21
// Design Name:
// Module Name: adder
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


module adder(input a , input b ,output  sum,output  cout);
assign sum=a^b;
assign cout = a&b;
endmodule




module fulladder(input x, input y,input cin,output wire c_out,output wire sum_out );
wire carry1;
wire carry2;
wire sum1;
assign c_out =  carry1 | carry2;
adder a1(.a(x),.b(y),.sum(sum1),.cout(carry1));
adder a2(.a(sum1),.b(cin),.sum(sum_out),.cout(carry2));
endmodule


module multiplier(input [1:0] a,input [1:0] b,output [3:0]f );
assign f[0]=a[0]&b[0];
assign k1=a[0]&b[1];
assign k2=a[1]&b[0];
assign k3=a[1]&b[1];
parameter l=2'b00;
wire p;
fulladder s1(.x(k1),.y(k2),.cin(0),.c_out(p),.sum_out(f[1]));
fulladder s2(.x(k3),.y(l),.cin(p),.c_out(f[3]),.sum_out(f[2]));
endmodule

module ripple(input [1:0] p,input [1:0] q,input c_in,output [3:0] sum_out);
wire take1;
assign sum_out[3]=0;
fulladder f1(.x(p[0]),.y(q[0]),.cin(c_in),.c_out(take1),.sum_out(sum_out[0]));
fulladder f2(.x(p[1]),.y(q[1]),.cin(take1),.c_out(sum_out[2]),.sum_out(sum_out[1]));
endmodule



module subt(input [1:0]a,input [1:0]b,output [3:0]f );
assign f[3]=0;
wire h,j,g;
fulladder f1(.x(a[0]), .y(~b[0]),.cin(1),.c_out(h),.sum_out(f[0]) );
fulladder f2(.x(a[1]), .y(~b[1]),.cin(h),.c_out(j),.sum_out(f[1]) );
fulladder f3(.x(0),.y(1),.cin(j),.c_out(g),.sum_out(f[2]) );
endmodule


module alu(input wire [1:0] a,input wire [1:0] b,input wire [2:0] s,input clk,output reg [3:0] f);
wire  [3:0] c ;
wire [3:0] d ;
wire [3:0] e;
`define andl 0
`define xorl 1
`define orl 2
`define nandl 3
`define mult 4
`define adder  5
`define subt 6
multiplier m1(.a(a),.b(b),.f(c));
ripple r1(.p(a),.q(b),.c_in(0),.sum_out(d));
subt s8(.a(a),.b(b),.f(e));
always  @ (posedge clk)
begin
f=0;
case(s)
        `andl:
            begin
            f[0] <= a[0]&b[0];
            f[1] <= a[1]&b[1];
            f[2]<=0;
            f[3]<=0;
            //f=a&b;
            end
        `xorl:
            begin
            f[0] = a[0]^b[0];
            f[1] = a[1]^b[1];
            f[2]=0;
            f[3]=0;
            //f=a^b;
            end
         `orl:
            begin
            f[0]= a[0] | b[0];
            f[1] =a[1] | b[1];
            f[2]=0;
            f[3]=0;
            //f=a|b;
            end
           `nandl:
             begin
                  f[0] = ~(a[0]&b[0]);
                  f[1] = ~(a[1]&b[1]);
                  f[2]=0;
                  f[3]=0;
                        //f=~(a&b);
             end
            `mult:
                  begin
                        f<=c;
                    end
            `adder:
                     begin
                             f<=d;
                    end
            `subt:
                    begin
                            f<=e;
                    end
endcase
end
endmodule
