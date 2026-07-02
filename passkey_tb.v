`timescale 1ns/1ps

module passkey_tb;

reg clk, rst, din, s;
wire y;

passkey uut (clk, rst, din, s, y);

always #5 clk = ~clk;

initial begin
    clk = 0; rst = 1; din = 0; s = 1;
    #20;
    rst = 0;

    s=0; din=1;  #10;
         din=1;  #10;
         din=1;  #10;
         din=1;  #10;
         din=1;  #10;
         din=1;  #10;
         din=1;  #10;
         din=1;  #10;

    s=1; din=1;  #10;
         din=1;  #10;
         din=1;  #10;
         din=1;  #10;
         din=1;  #10;
         din=1;  #10;
         din=1;  #10;
         din=1;  #10;
	
	#20;
	
    rst=1;  #10; rst=0;
    s=1; din=0;  #10;
         din=0;  #10;
         din=0;  #10;
         din=0;  #10;
         din=0;  #10;
         din=0;  #10;
         din=0;  #10;
         din=0;  #10;

    $finish;
end

endmodule
