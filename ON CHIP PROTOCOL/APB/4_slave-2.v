//UART SLAVE2
module UART #(parameter ADDR=16,DATA=8)(input pwrite,penable,pclk,preset_n,input [1:0]psel,input [ADDR-1:0]paddr,input [DATA-1:0]pwdata,output reg [DATA-1:0]prdata,output reg pready);
reg [DATA-1:0]mem[0:15];
always@(posedge pclk or negedge preset_n)
begin
 if(!preset_n)
    pready<=0;
else if(psel==2'b01 && penable)
    pready<=1;
else
    pready<=0;
end
always@(posedge pclk)
begin
 if(psel==2'b01)
 begin
   if(penable)
   begin
     if(pwrite)
        mem[paddr[3:0]]<=pwdata;
     else
        prdata<=mem[paddr[3:0]];
   end
 end
end
endmodule
