module traffic_top(clk, rst, day_night, light_led, led_com, seg7_out, seg7_sel, row, column_green, column_red);
	input	clk;
	input	rst;
	input	day_night;
	output [5:0] light_led;
	output led_com;
	output [2:0] seg7_sel;
	output [6:0] seg7_out;
	output [7:0] row, column_green, column_red;
	wire led_com;
	wire clk_cnt_dn, clk_fst, clk_sel, clk_led, clk_change;
	wire [7:0] g1_cnt;
	wire [7:0] g2_cnt;
	wire [3:0] count_out;	
	wire[6:0] idx, idx_cnt;
	wire[7:0] column_out;
	wire [2:0] mode;
	wire [2:0] seg7_sel1, seg7_sel2;
	
	assign led_com= 1'b1;
	assign count_out = day_night ? (light_led[5] == 1'b0) ? (seg7_sel == 3'b101) ? g1_cnt[3:0] : g1_cnt[7:4] : 
	(seg7_sel == 3'b101) ? g2_cnt[3:0] : g2_cnt[7:4] : 8'b0;
	assign column_green = day_night ? (mode == 3'd2 || mode == 3'd1 || mode == 3'd0) ? column_out : 8'b0 : column_out;
	assign column_red = day_night ? (mode == 3'd1 || mode == 3'd0) ? 8'b0 : column_out : column_out;
	
	freq_div#(23) M0(clk, rst, clk_cnt_dn);
	freq_div#(21) M1(clk, rst, clk_fst);
	freq_div#(20) M11(clk, rst, clk_walk);
	freq_div#(19) M12(clk, rst, clk_run);
	freq_div#(15) M2(clk, rst, clk_sel);
	freq_div#(10) M10(clk, rst, clk_led);
	traffic M3 (clk_fst, clk_cnt_dn, rst, day_night, g1_cnt, g2_cnt, light_led, mode);
	bcd_to_seg7 M4 (count_out, seg7_out);
	seg7_select #(2) M13(clk_sel, rst, seg7_sel1);
	seg7_select #(4) M14(clk_sel, rst, seg7_sel2);
	assign seg7_sel = day_night ? seg7_sel1 : seg7_sel2;
	assign clk_change = (mode == 3'd1) ? clk_run : clk_walk;
	idx_gen M6 (clk_change, rst, day_night, mode, idx);
	row_gen M7 (clk_led, rst, idx, row, idx_cnt);
	rom_char M8 (idx_cnt, column_out);
endmodule

