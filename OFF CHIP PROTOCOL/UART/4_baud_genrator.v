//baud genrator 
module baud_gen(input clk,rst,output tx_en,rx_en);
  reg [8:0]count_tx;
  reg [4:0]count_rx;
always@(posedge clk or posedge rst)begin
    if(rst)begin
      count_tx<=0;
      count_rx<=0;
    end 
    else begin
      if(count_tx==434)
        count_tx<=0;
      else 
        count_tx<=count_tx+1;
    end
  end 
    always@(posedge clk)begin
      if(count_rx==27)
        count_rx<=0;
      else
        count_rx<=count_rx+1;
    end 
assign tx_en=(count_tx==0)?1'b1:1'b0;
assign rx_en=(count_rx==0)?1'b1:1'b0;
endmodule
