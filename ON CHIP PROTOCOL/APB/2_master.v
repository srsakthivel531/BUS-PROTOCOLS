module master #(parameter ADDR=16 ,DATA=8 )(input pclk,preset_n,transfer,r_w,pready,input [DATA-1:0]prdata,output reg [DATA-1:0]pwdata,output reg [ADDR-1:0]paddr,output reg penable,pwrite,output reg [1:0]psel);
parameter IDLE=2'b00,SETUP=2'b01,ACCESS=2'b10;
reg [1:0]state;
always@(posedge pclk or negedge preset_n)
begin
 if(!preset_n)
   state<=IDLE;
 else
 begin
  case(state)
 IDLE:
  begin
    if(transfer)
       state<=SETUP;
    else
       state<=IDLE;
  end
 SETUP:
  begin
    state<=ACCESS;
    penable<=0;
    case(paddr[ADDR-15:0])
      2'b00: psel<=2'b00;
      2'b01: psel<=2'b01;
      default: psel<=2'b00;
    endcase
  if(r_w)
    begin
      pwrite<=1;
      pwdata<=8'd65;
    end
    else
      pwrite<=0;
  end
ACCESS:
  begin
    penable<=1;
    if(pready)
    begin
      if(transfer)
        state<=SETUP;
      else
        state<=IDLE;
    end
    else
      state<=ACCESS;
  end
endcase
 end
end
endmodule
