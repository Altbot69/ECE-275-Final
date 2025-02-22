module ball 
#(
	parameter BALL_SIZE = 10,
	parameter RIGHT_BOUNDARY = 637,
	parameter LEFT_BOUNDARY = 3,
	parameter TOP_BOUNDARY = 3,
	parameter BOTTOM_BOUNDARY = 477
)

(
	input wire clk, 
	input wire reset,
	// TODO: Add in paddle inputs and respective collision calculations
	output reg score_right,
	output reg score_left,
	output reg signed [10:0] ball_pos_x,
	output reg signed [10:0] ball_pos_y
);
	// these all have +1 bit from the original design for the sign bit
	reg signed [2:0] v_x;
	reg signed [2:0] v_y;
	reg signed [2:0] next_v_x;
	reg signed [2:0] next_v_y;

	reg signed [10:0] pos_x;
	reg signed [10:0] pos_y;
	reg signed [10:0] next_pos_x;
	reg signed [10:0] next_pos_y;

	/* these are just to pass the score condition from the procedural
	 * blocks to the output */
	reg left_collision;
	reg right_collision;

	// update state
	always @(posedge clk or posedge reset) 
	begin
		if (reset) 
		begin
			pos_x <= 11'd320;
			pos_y <= 11'd240;
			v_x <= 3'd1;
			v_y <= 3'd3;
		end

		else
		begin
			pos_x <= next_pos_x;
			pos_y <= next_pos_y;
			v_x <= next_v_x;
			v_y <= next_v_y;
		end
	end

	// inputs + state -> next state
	always @(pos_x, pos_y, v_x, v_y)  
	begin
		if ((pos_y + v_y) <= TOP_BOUNDARY) 	// top collision
		begin
			next_v_y <= -v_y;
			next_v_x <= v_x;
			next_pos_y <= TOP_BOUNDARY + 11'd1;
			next_pos_x <= pos_x + v_x;
			left_collision <= 1'b0;
			right_collision <= 1'b0;
		end

		else if ((pos_y + v_y) >= (BOTTOM_BOUNDARY - BALL_SIZE)) // bottom collision 
		begin
			next_v_y <= -v_y;
			next_v_x <= v_x;
			next_pos_y <= BOTTOM_BOUNDARY - 11'd1 - BALL_SIZE;
			next_pos_x <= pos_x + v_x;
			left_collision <= 1'b0;
			right_collision <= 1'b0;
		end

		/* the next two conditions only need to flip the score bits
		 * as once the score module has updated it will reset the rest of the
		 * modules, including this one */
		else if ((pos_x + v_x) >= (RIGHT_BOUNDARY - BALL_SIZE)) // right collision
			right_collision <= 1'b1;
		else if ((pos_x + v_x + BALL_SIZE) <= LEFT_BOUNDARY) // left collision
			left_collision <= 1'b1;

		else  // no collision
		begin
			next_v_y <= v_y;
			next_v_x <= v_x;
			next_pos_x <= pos_x + v_x;
			next_pos_y <= pos_y + v_y;
			left_collision <= 1'b0;
			right_collision <= 1'b0;
		end
	end

	// inputs + state -> output
	assign ball_pos_x = pos_x;
	assign ball_pos_y = pos_y;
	assign score_right = right_collision;
	assign score_left = left_collision;
endmodule
