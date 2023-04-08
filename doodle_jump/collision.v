module  	collision(clk, rst, red, green, coll);
	input clk, rst;
	input		[7:0]red, green;
	output reg 	coll;
	wire temp;
	
	assign temp = ((red & green) != 8'b0) || coll ? 1 : 0;
	
	always@(posedge clk or posedge rst)begin
		if (rst)
			coll <= 1'b0;
		else 	
			coll <= temp;
	end
endmodule
