module 	shift(left, right, reset, out, clk);
	input 		left, right, reset, clk;
	output reg	[7:0]out;

	always@(posedge clk or posedge reset)begin
		if(reset)
			out <=8'b0000_0010;
		else if(left)
			out <= {out[0], out[7:1]};
		else if(right)
			out <= {out[6:0], out[7]};
		else
			out <=out;
	end
endmodule
