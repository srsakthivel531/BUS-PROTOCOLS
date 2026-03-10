//top module 
module topmodule #(parameter ADDR=16, DATA=8)(input pclk,input preset_n,input transfer,input r_w,input [ADDR-1:0]paddr,input [DATA-1:0]write_data);
wire penable,pwrite,pready,pready_timer,pready_uart;
wire [1:0]psel;
wire[DATA-1:0]prdata_timer,prdata_uart,prdata,pwdata;
// MASTER
master #(ADDR,DATA) M1(.pclk(pclk),.preset_n(preset_n),.transfer(transfer),.r_w(r_w),
.pready(pready),.prdata(prdata),.write_data(write_data),.pwdata(pwdata),.paddr(paddr),.penable(penable),.pwrite(pwrite),.psel(psel));
// TIMER 
TIMER #(ADDR,DATA) S1(.pwrite(pwrite),.penable(penable),.pclk(pclk),.preset_n(preset_n),.psel(psel),.paddr(paddr),.pwdata(pwdata),.prdata(prdata_timer),.pready(pready_timer));
// UART 
UART #(ADDR,DATA) S2(.pwrite(pwrite),.penable(penable),.pclk(pclk),.preset_n(preset_n),.psel(psel),.paddr(paddr),.pwdata(pwdata),.prdata(prdata_uart),.pready(pready_uart));
assign prdata = (psel==2'b1)?prdata_timer :
    (psel==2'b10)?prdata_uart : 0;
assign pready = (psel==2'b1) ? pready_timer :
    (psel==2'b10) ? pready_uart : 0;
endmodule
