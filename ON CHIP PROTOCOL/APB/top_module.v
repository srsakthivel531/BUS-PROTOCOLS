//top module 
module topmodule #(parameter ADDR=16, DATA=8)(input pclk,input preset_n,input transfer,input r_w,input [ADDR-1:0]paddr,output reg [DATA-1:0]prdata);
wire [DATA-1:0]pwdata;
wire penable,pwrite,pready;
wire [1:0] psel;
// MASTER
master #(ADDR,DATA) M1(.pclk(pclk),.preset_n(preset_n),.transfer(transfer),.r_w(r_w),
.pready(pready),.prdata(prdata),.pwdata(pwdata),.paddr(paddr),.penable(penable),
.pwrite(pwrite),.psel(psel));
// TIMER 
  TIMER #(ADDR,DATA) S1(.pwrite(pwrite),.penable(penable),.pclk(pclk),.preset_n(preset_n),.psel(psel),.paddr(paddr),.pwdata(pwdata));
// UART 
UART #(ADDR,DATA) S2(.pwrite(pwrite),.penable(penable),.pclk(pclk),
.preset_n(preset_n),.psel(psel),.paddr(paddr),.pwdata(pwdata));
endmodule
