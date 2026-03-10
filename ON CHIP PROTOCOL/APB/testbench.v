module tb;
parameter ADDR = 16, DATA = 8;
reg pclk, preset_n,transfer,r_w;
reg [ADDR-1:0]paddr;
reg [DATA-1:0]write_data;
topmodule #(ADDR,DATA) DUT(pclk,preset_n,transfer,r_w,paddr,write_data);
initial begin 
  pclk=1;
forever #5 pclk=~pclk;
end 
initial
begin
transfer=0;preset_n = 0; r_w=0;paddr=16'h0000;
 #10 preset_n =1;
 //timer write
#10 paddr=16'h2000;write_data=8'hAA;r_w=1;transfer=1;
#10 transfer=0;
//timer read 
#30 paddr=16'h2000;r_w=0;transfer=1;
#10 transfer=0;
//uart write  
#30 paddr=16'h4000;write_data=8'h65;r_w=1;transfer=1;
#10 transfer=0;
//uart read
 #30 paddr=16'h4000;r_w=0;transfer=1;
#10 transfer=0;
//timer write
#30;paddr=16'h3000;write_data=8'h55;r_w=1;transfer=1;
#10 transfer=0;
//timer read
 #30;paddr=16'h3000;r_w=0;transfer=1;
#10 transfer=0;
#100 $finish;
end
initial begin 
    $dumpfile("file.vcd");
    $dumpvars(0,tb);
  end 
endmodule
