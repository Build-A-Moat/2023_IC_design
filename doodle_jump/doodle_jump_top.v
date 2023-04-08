module 	doodle_jump_top(clk, row, red, green, column, sel, rst);

	input 		rst, clk;     		
	input 		[2:0]column;		
	output	[7:0]red, row, green;	
			//D7,D6,A9,C9,A8,C8,C11,B11
			//T22,R21,C6,B6,B5,A5,B7,A7
			//A10,B10,A13,A12,B12,D12,A15,A14
	output 	[2:0]sel;			//AA13,AB12,Y16
	wire 		clk_div, press, press_valid, coll, state, clk_idx, clk_test, clk_coll, coll_rst;
	wire 		[3:0] keycode, scan_code;
	wire		[5:0] addr, map_move, bias;
	wire		[2:0] idx;
	wire		[7:0] hor, ver;
	
	assign 	addr = idx + map_move;

	assign bias = map_move;
	
	key_decode 	M1 (sel, column, press, scan_code);
	key_buf6 	M2 (clk_idx, rst, press_valid, scan_code, keycode);
	debounce_ctl M3 (clk_idx, rst, press, press_valid);
	count6  	M4 (clk_idx, rst, sel);
	move		M5 (clk_slow, clk_idx,rst, coll, keycode, ver, hor, coll_rst, bias, map_move);

	freq_div#(13) 	M11 (clk, rst, clk_idx);
   freq_div#(19) 	M12 (clk, rst, clk_slow);
	map		M7 (addr,green);
	idx		M8 (clk_idx, rst, idx, row);
	mix		M9 (ver, hor, row, red);
	collision 	M10 (clk_idx, rst || coll_rst, red, green, coll);
endmodule

