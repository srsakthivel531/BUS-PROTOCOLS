module tb;
parameter ADDR = 16,DATA = 8;
reg pclk, preset_n,transfer,r_w;
reg [ADDR-1:0]paddr;
 wire [DATA-1:0]prdata;
  topmodule #(ADDR,DATA) DUT(pclk,preset_n,transfer,r_w,paddr,prdata);
initial begin 
  pclk=0;
forever #5 pclk = ~pclk;
end 
initial
begin
transfer = 0;preset_n = 1; paddr=16'b0;
 #10preset_n = 0;
// write timer
#10transfer = 1;r_w = 1;     
#20 transfer = 0;
// read timer
#20 transfer=1;r_w=0;
 // write uart
#10 paddr=16'b01;transfer = 1;r_w = 1;     
#20 transfer = 0;
// read  uart
#20 transfer=1;r_w=0;
#50 $finish;
end
  initial begin 
    $dumpfile("file.vcd");
    $dumpvars(0,tb);
  end 
endmodule
