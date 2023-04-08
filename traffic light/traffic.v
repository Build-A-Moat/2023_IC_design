module traffic (clk_fst, clk_cnt_dn, rst, day_night, g1_cnt, g2_cnt, light_led, mode);
	input clk_fst, clk_cnt_dn, rst, day_night;
	output [5:0] light_led;
	output [7:0] g1_cnt;
	output [7:0] g2_cnt;
	output [2:0] mode;
	wire g1_en, g2_en;
	wire [7:0] g1_cnt;
	wire [7:0] g2_cnt;
	ryg_ctl M0(clk_fst, clk_cnt_dn, rst, day_night, g1_cnt, g2_cnt, g1_en, g2_en, light_led, mode);
	light_cnt_dn_20 M1(clk_cnt_dn, rst, g1_en, g1_cnt); // for light 1
	light_cnt_dn_20 M2(clk_cnt_dn, rst, g2_en, g2_cnt); // for light 2 
endmodule
