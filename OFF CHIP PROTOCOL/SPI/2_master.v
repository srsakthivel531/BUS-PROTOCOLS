//master 
module master(input clk,rst,en,miso,input [7:0]data_in,output reg sclk,ss,mosi);
reg [7:0]shift_reg;
reg [3:0]count;reg [1:0]state,nxt_state;
parameter IDLE=2'b00,LOAD=2'b01,TRANSMIT=2'b10,STOP=2'b11;
always@(posedge clk or posedge rst)
    begin 
      if(rst) 
        state<=IDLE;
      else 
        state<=nxt_state;
    end 
always@(*)begin
   case(state)
      IDLE:begin
        if(en)
          nxt_state=LOAD;
         else
           nxt_state=IDLE;
      end
       LOAD:begin
         nxt_state=TRANSMIT;
       end 
       TRANSMIT:begin
         if(count==8)
           nxt_state=STOP;
         else 
           nxt_state=TRANSMIT;
       end 
         STOP:begin 
           nxt_state=IDLE;
         end 
         default:nxt_state=IDLE;
   endcase
 end 
 always@(posedge clk or posedge rst)begin
   if(rst)
     begin
          sclk<=0;
          ss<=1;
          count<=0;
          shift_reg<=0;
          mosi<=0;
    end 
   else 
   begin
     case(state)
          IDLE:begin
            ss<=1;
            sclk<=0;
          end 
          LOAD:begin
             ss<=0;
             shift_reg<=data_in;
             count<=0;
          end
          TRANSMIT:begin
            ss<=0;
            sclk<=~sclk;

            if(sclk==0) 
            begin
              mosi<=shift_reg[7];
              shift_reg<={shift_reg[6:0],miso};
              count<=count+1;
            end 
          end 
        STOP:begin
            ss<=1;
            sclk<=0;
            count<=0;
          end          
     endcase
   end 
 end 
endmodule 
