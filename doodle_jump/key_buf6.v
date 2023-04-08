module key_buf6(clk, rst, press_valid, scan_code, keycode);
	input clk, rst, press_valid;
	input [3:0] scan_code;
	output [3:0] keycode;
	reg [3:0] keycode;
	always @(posedge clk or posedge rst) begin
		if(rst)
			keycode <= 4'b0;
		else
			keycode <= press_valid ? scan_code : 4'b0000;
	end
endmodule
