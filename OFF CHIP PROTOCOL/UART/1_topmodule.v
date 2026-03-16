//topmodule 
module topmodule(input clk,rst,en,input [7:0]data_in,output reg [7:0]data_out);
wire tx_en,rx_en;
wire tx_wire;
baud_gen  uut1(.clk(clk),.rst(rst),.tx_en(tx_en),.rx_en(rx_en));
tx  uut2(.clk(clk),.en(en),.tx_en(tx_en),.rst(rst),.data_in(data_in),.tx(tx_wire)); 
  rx uut3(.clk(clk),.rx(tx_wire),.rx_en(rx_en),.rst(rst),.data_in(data_in),.data_out(data_out));
endmodule
