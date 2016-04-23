module simpleCount(count, clock, reset, enable);
	input clock, reset, enable;
	//output done;
	output [2:0] count;
	
	
	wire d0, q0, d1, q1, d2, q2;
	wire restart;
		
	assign d0 = ~q0;
	assign d1 = q1 ^ q0;
	assign d2 = (q2 & (~(q1&q0))) | (~q2 & q1 & q0);
	assign restart = reset | (q2 & q0);	
	
	DFFE S0(.d(d0), .clk(clock), .clrn(~restart), .ena(enable), .q(q0));
	DFFE S1(.d(d1), .clk(clock), .clrn(~restart), .ena(enable), .q(q1));
	DFFE S2(.d(d2), .clk(clock), .clrn(~restart), .ena(enable), .q(q2));
	
	//assign done = q2;
	assign count = {q2, q1, q0};

endmodule
