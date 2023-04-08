module light_cnt_dn_20 (clk, rst, enable, cnt);
	input clk, rst, enable;
	output [7:0] cnt;
	reg [7:0] cnt;
	always@(posedge clk or posedge rst) begin
	if(rst)
		cnt = 8'b0; // initial state
	else if(enable)  // 0 -> 29 -> 24 -> ... -> 1 -> 0 -> 29
		if(cnt == 8'b0)
			 cnt = 8'b00100000;  // 29
		else if(cnt[3:0] == 4'd0) begin // 20 -> 19, 10 -> 09
			if (cnt[5] == 1'b1)
				cnt = 8'b00011001;
			else if (cnt[4] == 1'b1)
				cnt = 8'b00001001;
		end
		else
			cnt <= cnt - 1;  // 19 -> 18, 18 -> 17, 17 -> 16, …
	else cnt = 8'b0;	
	end
endmodule
