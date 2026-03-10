module master #(parameter ADDR=16,DATA=8)(input pclk,preset_n,transfer,r_w,pready,input [DATA-1:0]prdata,input [DATA-1:0]write_data,output reg [DATA-1:0]pwdata,input [ADDR-1:0]paddr,output reg penable,pwrite,output reg [1:0]psel);
parameter IDLE=2'b00,SETUP=2'b01,ACCESS=2'b10;
  reg [1:0]state,next_state;
always @(posedge pclk or negedge preset_n)
begin
 if(!preset_n)
   state<=IDLE;
 else
   state<=next_state;
end
 always @(*)
begin
 case(state)
IDLE :
   begin
     if(transfer)
       next_state=SETUP;
     else
       next_state=IDLE;
   end
SETUP :
   begin
     next_state=ACCESS;
   end
ACCESS :
   begin
     if(pready)
     begin
      if(transfer)
      next_state=SETUP;
      else
       next_state=IDLE;
     end
     else
       next_state=ACCESS;
   end
default :
  next_state=IDLE;
endcase
end
 always @(*)
begin
penable=0;
case(state)
IDLE:
   begin
     penable=0;
   end
SETUP:
   begin
    case(paddr[ADDR-1:ADDR-2])
       2'b00:psel=2'b01;
       2'b01:psel=2'b10;
       default:psel=2'b00;
     endcase
    if(r_w)
     begin
       pwrite=1;
       pwdata=write_data;
     end
     else
       pwrite=0;
end
ACCESS:
   begin
     penable=1;
   end
endcase
end
endmodule 
