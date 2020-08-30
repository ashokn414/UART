
module baud_rate_gen(input wire clk_50m,
		     output wire rxclk_en,
		     output wire txclk_en);

parameter RX_A = 50000000 / (115200 * 16);  //frequency coefficient or divide ratio of receiver
parameter TX_A = 50000000 / 115200;  //frequency coefficient or divide ratio of the transmitter
reg [4:0] rx_acc = 0;         //initialize counter of rx_frequency coefficient with zero
reg [8:0] tx_acc = 0;         //initialize the counter of tx_frequency coefficient with zero

assign rxclk_en = (rx_acc == 5'd0); 
assign txclk_en = (tx_acc == 9'd0);

//counter implementation at the receiver with this frequency coefficient

always @(posedge clk_50m) begin
	if (rx_acc >= RX_A)  //if counter of the receiver is full then reset it to the zero value
		rx_acc <= 0;
	else
		rx_acc <= rx_acc + 5'd1;  // otherwise increment
end
//counter implementation at the transmitter with this frequency coefficient
always @(posedge clk_50m) begin
	if (tx_acc >= TX_A)
		tx_acc <= 0;
	else
		tx_acc <= tx_acc + 9'b1;
end

endmodule
