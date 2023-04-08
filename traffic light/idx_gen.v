module idx_gen(clk, rst, day_night, mode, idx);
	input clk, rst, day_night;
	input [2:0] mode;
	output [6:0] idx;
	reg [6:0] idx;
	always@(posedge clk or posedge rst) begin
		if (rst)
			idx <= 7'd0;
		else if (day_night == 3'd1) begin
			if (mode == 3'd0 || mode == 3'd1) begin
				if (idx == 7'd72)
					idx <= 7'd16;
				else
					idx <= idx + 7'd08;	
			end 
			else if (mode == 3'd2)begin
				if (idx != 7'd0)
					idx <= 7'd0;
				else
					idx <= idx + 7'd08;	
			end
			else 
				idx <= 7'd8;
		end	
		else 
			begin
				if (idx != 7'd0)
					idx <= 7'd0;
				else
					idx <= idx + 7'd08;	
			end		
			
		
		/*if (rst)
			idx <= 7'd0;
		else if (idx == 7'd56)
			idx <= 7'd0;
		else
			idx <= idx + 7'd08;*/
	end
endmodule
