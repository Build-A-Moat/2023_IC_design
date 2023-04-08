module	move(clk, clk_left_right, reset, coll, keycode, ver, hor, coll_rst, bias, map_move);
	input 	reset, clk, clk_left_right, coll;
	input 	[5:0] keycode, bias;
	output 	[7:0] ver, hor;
	output reg coll_rst;
	output reg [5:0] map_move;
	reg		[7:0] ver;
	reg 		[2:0] count;
	wire		left, right, up, down;

	assign 	left  = ~keycode[1] & keycode[2];
	assign 	right =  keycode[1] & keycode[2];
	
	shift S1(left, right, reset, hor, clk_left_right); //left & right
	//shift S2(up, down, reset, ver, clk); //up & down
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count <= 3'b100;
			ver <= 8'b0000_0010;
			coll_rst <= 1'b0;
			map_move <= 4'd8;
		end
		else begin 
			if (coll) begin 
				count <= 3'b001;
				ver <= {ver[0], ver[7:1]};
				coll_rst <= 1'b1;
				case(ver)
					8'b0000_0001  	:map_move <= bias + 4'd7;            
					8'b0000_0010	:map_move <= bias + 4'd6; 
					8'b0000_0100	:map_move <= bias + 4'd5;
					8'b0000_1000	:map_move <= bias + 4'd4;
					8'b0001_0000	:map_move <= bias + 4'd3;
					8'b0010_0000	:map_move <= bias + 4'd2;
					8'b0100_0000	:map_move <= bias + 4'd1;
					8'b1000_0000	:map_move <= bias + 4'd0;
				default	: map_move <= bias + 4'd0;
			endcase
			end
			else if (count < 3'b011) begin
				count <= count + 1'b1;
				ver <= {ver[0], ver[7:1]};
				coll_rst <= 1'b0;
			end
			else begin
				//ver <= {ver[6:0], ver[7]};//下降	
				ver <= ver * 2;
				if (ver == 8'b0)
					map_move <= 4'b0;
				coll_rst <= 1'b0;
			end
		end
	end
endmodule
