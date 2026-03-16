module uart_tb;
  reg clk,rst,en;
  reg [7:0]data_in;
 wire [7:0]data_out;
  topmodule uut(clk,rst,en,data_in,data_out);
  initial begin
    clk=1'b0;
    forever #10 clk=~clk;
  end 
  initial begin
    rst=1;en=0;data_in=8'b11111111;
    #5 rst=0;
   #2 en=1;
   #100000$finish;
  end 
  initial begin
    $dumpfile("UART.vcd");
    $dumpvars(0,uart_tb);
  end 
endmodule 
