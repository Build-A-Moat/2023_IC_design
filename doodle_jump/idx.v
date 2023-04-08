module 	idx(clk, reset, idx, row);
	input		 reset, clk;
	output reg	[2:0]idx;
	output reg	[7:0]row;
	always@(posedge clk or posedge reset) begin
		if(reset) begin
			idx<=3'b000;
			row<=8'b1000_0000;
		end
		else begin
			idx<=idx+3'b001;
			row<={row[0],row[7:1]};
		end
	end
endmodule
