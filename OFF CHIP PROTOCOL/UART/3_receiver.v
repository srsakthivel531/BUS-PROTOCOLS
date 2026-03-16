//receiver 
module rx(input clk,rx,rx_en,rst,input [7:0]data_in,output reg [7:0]data_out);
reg [7:0]shift_reg_RX;
reg [3:0]count_R;
reg [1:0]state,nxt_state;
parameter IDLE=2'b00,START=2'b01,DATA=2'b10,STOP=2'b11;
  always@(posedge clk or posedge rst)begin
    if(rst)
      state<=IDLE;
    else 
      state<=nxt_state;
  end 
  always@(*)begin
    case(state)
      IDLE:begin
        if(rx==0)
          nxt_state=START;
        else 
          nxt_state=IDLE;
      end 
        START:begin
          if(rx_en)
          nxt_state=DATA;
        else 
          nxt_state=START;
      end 
        DATA:begin
          if(rx_en && count_R==10)
          nxt_state=STOP;
        else 
          nxt_state=DATA;
      end 
       STOP:begin
         if(rx_en)
          nxt_state=IDLE;
        else 
          nxt_state=STOP;
      end 
      default:nxt_state=IDLE;
    endcase
 end 
 always@(posedge clk or posedge rst)begin
    if(rst)begin
      count_R<=0;
      shift_reg_RX<=0;
    end 
    else begin
      case(state)
        IDLE:begin
          if(rx_en)     
          count_R<=0;        
         end 
        START:begin
          if(rx_en)
            count_R<=0; 
        end 
        DATA:begin
          if(rx_en)begin
            shift_reg_RX<={rx,shift_reg_RX[7:1]};         
            count_R<=count_R+1;
        end 
        end 
        STOP:begin
          if(rx_en)begin
            data_out<=shift_reg_RX;
            count_R<=0;
          end 
        end 
      endcase
    end 
  end 
endmodule
