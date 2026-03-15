//top module 
module topmodule(input clk,rst,en,input [7:0]data_in,output reg [7:0]data_out);
wire sclk,ss,miso,mosi;
master uut1(.clk(clk),.rst(rst),.en(en),.miso(miso),.data_in(data_in),.sclk(sclk),.ss(ss),.mosi(mosi));
slave  uut2(.sclk(sclk),.rst(rst),.mosi(mosi),.ss(ss),.miso(miso),.data_out(data_out));
endmodule
