
//TIMER slave1
module TIMER #(parameter ADDR=16,DATA=8)(input pwrite,penable,pclk,preset_n,input [1:0]psel,input [ADDR-1:0]paddr,input [DATA-1:0]pwdata,output reg [DATA-1:0]prdata,output reg  pready);
reg [DATA-1:0]mem[0:15];
always@(posedge pclk or negedge preset_n)
begin
 if(!preset_n)
   prdata<=0;
 else begin
   pready<=0;
   if(psel==2'b1 && penable)
   begin
     pready<=1;
     if(pwrite)
        mem[paddr[3:0]]<=pwdata;
     else
        prdata<=mem[paddr[3:0]];
   end 
   end
 end
endmodule
