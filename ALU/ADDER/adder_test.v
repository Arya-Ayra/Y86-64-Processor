`timescale 1ns/10ps
`include "adder_64.v"

module adder_test;

reg signed [63:0] a;
reg signed [63:0] b;
reg [64:0] ans;

wire signed [63:0] sum;
wire overflow, carry;

adder_64 tt(
.a(a),
.b(b),
.sum(sum),
.overflow(overflow),
.carry(carry));

always @ (a or b) begin
    ans = a+b;
end

integer k,j,m=1;

initial begin

    $dumpfile("adder_test.vcd");
    $dumpvars(0,adder_test);
    $monitor($time,"\nA=%b\nB=%b\nSum=%b\nAns:%b\nOverflow=%b\n", a,b,sum,ans,overflow);
    
    a = 64'b1111111111111111111111111111111111111111111111111111111111111111;
    b = 64'b1111111111111111111111111111111111111111111111111111111111111111;

    #5;

    for(k = 0; k < 5; k = k + 1)
    begin
        b = 64'b1111111111111111111111111111111111111111111111111111111111111111;
        a=a-1;
        #5;
        for(j = 0; j < 5; j = j + 1)
        begin
            b = b-1;
            #5;
        end
        
    end
    a = 64'b0111111111111111111111111111111111111111111111111111111111111111;
    b = 64'b0111111111111111111111111111111111111111111111111111111111111111;
    #5;

    a = 64'b1000000000000000000000000000000000000000000000000000000000000001;
    b = 64'b1000000000000000000000000000000000000000000000000000000000000001;
    #5;
end
  
endmodule

