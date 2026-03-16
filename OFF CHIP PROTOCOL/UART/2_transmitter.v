module tx(input clk,en,tx_en,rst,input [7:0]data_in,output reg tx);
reg [7:0]shift_reg_TX;
reg [3:0]count_T;
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
        if(en)
          nxt_state=START;
        else 
          nxt_state=IDLE;
      end 
        START:begin
          if(tx_en)
          nxt_state=DATA;
        else 
          nxt_state=START;
      end 
        DATA:begin
          if(tx_en && count_T==7)
          nxt_state=STOP;
        else 
          nxt_state=DATA;
      end 
       STOP:begin
         if(tx_en)
          nxt_state=IDLE;
        else 
          nxt_state=STOP;
      end 
      default:nxt_state=IDLE;
    endcase
  end 
  always@(posedge clk or posedge rst)begin
    if(rst)begin
      count_T<=0;
      shift_reg_TX<=0;
    end 
    else begin
      case(state)
        IDLE:begin
          if(en)begin
            shift_reg_TX<=data_in;
            count_T<=0;
        end 
        end 
        START:begin
          if(tx_en)begin
            tx<=1'b0;
            count_T<=0;
          end 
        end 
        DATA:begin
          if(tx_en)begin
            shift_reg_TX<=shift_reg_TX >> 1'b1;
            tx<=shift_reg_TX[0];
            count_T<=count_T+1;
        end 
        end 
        STOP:begin
          if(tx_en)begin
            tx<=1'b1;
            count_T<=0;
          end 
        end 
      endcase
    end 
  end 
endmodule 
