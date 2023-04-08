module 	mix(ver, hor, row, red);
	input		[7:0]ver, hor, row;
	output 	[7:0]red;

	assign 	red = (row == ver) ? hor : 8'b0;

endmodule

