module count6(clk_sel, reset, sel);
	input clk_sel, reset;
	output [2:0] sel;
	reg [2:0] sel;
	always @(posedge clk_sel or posedge reset) begin
		if (reset)
			sel <= 3'b0;
		else if(sel == 3'b101)
			sel <= 3'b0;
		else
			sel <= sel + 1'b1;
	end
endmodule 