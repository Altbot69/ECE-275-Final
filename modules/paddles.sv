// Include ball module here

module paddles (
	input wire clk,
	input wire reset,
	input button_up,
	input button_down,
	input reg [19:0] ball_state,
	input wire [9:0] player_paddle_x_position, //Can remain the same
	input wire [9:0] player_paddle_y_position, //This will be changeable given certain conditions
	input wire [9:0] ai_paddle_x_position, //Should remain the same
	input wire [9:0] ai_paddle_y_position, //This will be changeable given certain conditions
	output reg player_paddle,
	output reg ai_paddle
);
	player_paddle player(
		.clk(clk),
		.reset(reset),
		.button_up(button_up),
		.button_down(button_down),
		.paddle_state(player_paddle[9:0])
	);

	ai_paddle ai(
		.clk(clk),
		.reset(reset),
		.ball_state(ball_state),
		.paddle_state(paddle_state[19:10])
	);
endmodule

// Left paddle
module player_paddle(
	input wire clk,
	input wire reset,
	input button_up,
	input button_down,
	output reg [9:0] paddle_state
);
	// Looks at button inputs to move
	
	/* Idea code to get me started noted not perfect
	
	always @(posedge clk or posedge reset)
	begin
	if(button_up == pressed)
	
	player_paddle_y_position + some number
	else //no movment
	end
	
	*/
endmodule

// Right paddle
module ai_paddle(
	input wire clk,
	input wire reset,
	input reg [19:0] ball_state,
	output reg [9:0] paddle_state
);
	// Looks at ball state to move
	
	
	
	/* Idea code for the ai paddle to get me started noted not perfect
	
	 *For this the idea is that the ai slide "tracks" the ball position so it bounces
	 *In order to achieve this my idea is that this slide will track the y position of the boucing ball and try to track it
	 *So it will look something like this below
	 
	 if(ball_y_position > ai_paddle_y_position)
	 ai_paddle_y_position move up
	 else if(ball_y_position < ai_paddle_y_position)
	 ai_paddle_y_position move down
	
	The thing that would make this easier or harder is all dependant on the speed of the ai paddle
	
	*/
	
endmodule
