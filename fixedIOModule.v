
module inputController(clock, reset, start, inleft, inright, inshoot, instop, speedData, shootData, resetSpeedNextNext, resetShootNextNext, ioInterrupt); // modify such that reading of speed/shoot resets it
	input clock, reset;
	input inleft, inright, inshoot, instop; // active-high pulses from push-buttons
	output [31:0] speedData; // will latch last value until stop is pressed
	output shootData; // will be a 1 from press of shoot till press of stop
	output ioInterrupt;
	//input start;
	//input resetSpeedNext, resetShootNext;
	input resetSpeedNextNext, resetShootNextNext;
	
	input start;
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
	//assign moveRight = 32'b1;
	assign moveRight = 32'd20; // Try adjusting
	assign moveLeft = 32'hFFFFFFEC;
	assign stopMoving = 32'b0;
	
	wire nextShot;
	wire [31:0] nextSpeed;
	wire [2:0] pulses;
	
	assign pulses = {stop, right, left};
	
	assign speedWriteEnable = left | right | stop;
	assign shootWriteEnable = shoot | stop; // Temp : Need to press stop after shoot to stop shooting
	
	assign nextShot = shoot ? 1'b1 : 1'b0;
	
	wire resetSpeedNext, resetShootNext;
	wire resetSpeed, resetShoot;
	
	wire oldInterrupt, newInterrupt;
	
	// TRY SAME LATCHING STRATEGY FOR SHOOT AS FOR START
	wire oldShoot, newShoot, shouldShoot;
	myDFFE latchNewShot(shoot, clock, reset, 1'b1, newShoot);
	myDFFE latchOldShot(newShoot, clock, reset, 1'b1, oldShoot);
	assign shouldShoot = (newShoot ^ oldShoot) ? shoot : 1'b0;
	
	
	//myDFFE resetNextSpeed0(resetSpeedNext, ~clock, reset, 1'b1, resetSpeed0);
	//myDFFE resetNextShoot0(resetShootNext, ~clock, reset, 1'b1, resetShoot0);
	myDFFE resetNextNextSpeed(resetSpeedNextNext, ~clock, reset, 1'b1, resetSpeedNext);
	myDFFE resetNextNextShoot(resetShootNextNext, ~clock, reset, 1'b1, resetShootNext);
	
	myDFFE resetNextSpeed(resetSpeedNext, ~clock, reset, 1'b1, resetSpeed);
	myDFFE resetNextShoot(resetShootNext, ~clock, reset, 1'b1, resetShoot);
	
	// 8-1 MUX for nextSpeed: 0 for stop, 1 for right, -1 for left
	eightOneMux chooseSpeed(stopMoving, moveLeft, moveRight, moveRight, stopMoving, stopMoving, stopMoving, stopMoving, pulses, nextSpeed);
	
	Register32 latchButton(clock, speedWriteEnable, nextSpeed, reset & resetSpeed, speedData);
		
	// Use counter to latch shoot signal for number of cycles equal to instructions in loop 
	// TRY TOGGLING CLOCK
	myDFFE latchFinalShot(shouldShoot, clock, reset & resetShoot, shouldShoot, shootData); // SAFE?
	// TRY SAME LATCHING STRATEGY AS MENTIONED ABOVE
	//myDFFE latchShot(nextShot, clock, reset & resetShoot, shootWriteEnable, shootData);
	
	myDFFE latchNewInterrupt(start, clock, reset, 1'b1, newInterrupt);
	myDFFE latchOldInterrupt(newInterrupt, clock, reset, 1'b1, oldInterrupt);
	assign ioInterrupt = (oldInterrupt ^ newInterrupt) ? start : 1'b0;

endmodule
