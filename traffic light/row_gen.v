module row_gen(clk, rst, idx, row, idx_cnt);
	input clk, rst;
	input[6:0] idx;
	output[7:0] row;
	output[6:0] idx_cnt;
	reg[7:0] row;
	reg[6:0] idx_cnt;
	reg[2:0] cnt;
	always@(posedge clk or posedge rst) begin
		if(rst) begin
			row <= 8'b0000_0001;
			cnt <= 3'd0;
			idx_cnt <= 7'd0;
		end
		else begin
			row <={row[0],row[7:1]};
			cnt <= cnt + 1'b1; 
			idx_cnt <= idx + cnt;
		end
	end
endmodule
