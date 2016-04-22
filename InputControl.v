module inputController(clock, reset, inleft, inright, inshoot, instop, speedData, shootData); // For Single player using push-buttons
	input clock, reset;
	input inleft, inright, inshoot, instop; // active-high pulses from push-buttons
	output [31:0] speedData; // will latch last value until stop is pressed
	output shootData; // will be a 1 from press of shoot till press of stop
	
	//input start;
	
	wire left, right, stop, shoot;
	
	//assign left = ~inleft;
	//assign right = ~inright;
	//assign stop = ~instop;
	//assign shoot = ~inshoot;
   assign left = inleft;
	assign right = inright;
	assign stop = instop;
	assign shoot = inshoot;

	
	wire speedWriteEnable;
	wire shootWriteEnable;
	
	wire [31:0] moveRight, moveLeft, stopMoving;
	assign moveRight = 32'b1;
	assign moveLeft = {32{1'b1}};
	assign stopMoving = 32'b0;
	
	wire nextShot;
	wire [31:0] nextSpeed;
	wire [2:0] pulses;
	
	assign pulses = {stop, right, left};
	
	assign speedWriteEnable = left | right | stop;
	assign shootWriteEnable = shoot | stop; // Temp : Need to press stop after shoot to stop shooting
	
	assign nextShot = shoot ? 1'b1 : 1'b0;
	
	// 8-1 MUX for nextSpeed: 0 for stop, 1 for right, -1 for left
	eightOneMux chooseSpeed(stopMoving, moveLeft, moveRight, moveRight, stopMoving, stopMoving, stopMoving, stopMoving, pulses, nextSpeed);
	
	Register32 latchButton(clock, speedWriteEnable, nextSpeed, reset, speedData);
		
	// Use counter to latch shoot signal for number of cycles equal to instructions in loop 
	myDFFE latchShot(nextShot, clock, reset, shootWriteEnable, shootData);
	
endmodule
