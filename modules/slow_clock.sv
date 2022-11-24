module slow_clock (
	input wire fastclock,
	input wire reset,
	output reg slowclock
);
	// 1. Registers/Flip-flops
	reg [1:0] count;	
	wire [1:0] dinputs;

	always @(posedge fastclock or posedge reset)
	begin
		if (reset)
			count <= 2'b00;
		else
			count <= dinputs;
	end

	// 2. Combinational Logic that maps from 
		// inputs + current state -> next state
	assign dinputs = (count == 2'b10) ? 2'b00 : count + 1;
	
	// 3. Combinational Logic that maps from
		// Mealy: inputs + current state -> output
		// Moore: current state -> output
	assign slowclock = (count == 2'b00) ? 1'b1 : 1'b0;
endmodule
