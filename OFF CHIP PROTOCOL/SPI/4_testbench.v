module spi_tb;
  reg clk,rst,en;
  reg [7:0]data_in;
  wire [7:0]data_out;
  topmodule uut(clk,rst,en,data_in,data_out);
  initial begin
    clk=1;
    forever #2 clk=~clk;
  end 
  initial begin
    rst=1;en=0;data_in=8'b0;
    #5 rst=0;en=1;data_in=8'b11111;
    #50 en=0;
    #150 $finish;
  end 
  initial begin
    $dumpfile("spi.vcd");
    $dumpvars(0,spi_tb);
  end 
endmodule   
