module VGAWrapper(start, master_clk, DAC_clk, VGA_R, VGA_G, VGA_B, VGA_hSync, VGA_vSync, blank_n, resetn, IRDA_RXD, playerXPosition, playerYPosition, enemyXPosition, enemyYPosition, bulletXPosition, bulletYPosition, processor_clock, left, right, stop, shoot);
	
	input master_clk;//, KB_clk;//, data; //50MHz
	//input [3:0] data;
	input resetn;
	input IRDA_RXD;
	output reg [7:0]VGA_R, VGA_G, VGA_B;  //Red, Green, Blue VGA signals
	output VGA_hSync, VGA_vSync, DAC_clk, blank_n; //Horizontal and Vertical sync signals
	wire [9:0] xCount; //x pixel
	wire [9:0] yCount; //y pixel
	wire [9:0]rand_X;
	wire [8:0]rand_Y;
	wire displayArea; //is it in the active display area?
	wire VGA_clk; //25 MHz
	wire R;
	wire G;
	wire B;
	//wire [9:0] pos; // USE IN PLACE OF SWITCHES LATER
	reg game_over;
	reg border;
	reg [6:0] size;
	input start;
	reg [9:0] playerX;
	reg [8:0] playerY;
	reg playerHead;
	reg playerBody;
	reg playerBodyOne;
	reg playerBodyTwo;
	reg playerBodyThree;
	reg player;
	reg [9:0] enemyX;
	reg [8:0] enemyY;
	reg enemyHead;
	reg enemyBody;
	reg enemyBodyOne;
	reg enemyBodyTwo;
	reg enemyBodyThree;
	reg enemy;
	reg [9:0] bulletX;
	reg [8:0] bulletY;
	reg bullet;
	wire update, data_ready;//, reset;
	wire [31:0] hex_data;
	integer maxSize = 16;
	
	input [9:0] playerXPosition, enemyXPosition, bulletXPosition;
	input [8:0] playerYPosition, enemyYPosition, bulletYPosition;
	
	//output update_clock;
	output processor_clock;
	//wire nextShoot;
	wire startShoot;
	
	//assign update_clock = update;
	
	//assign nextShoot = startShoot & ~shoot;
	
	//myDFFE latchShot(nextShoot, processor_clock, resetn, 1'b1, shoot);	
	inputFix fixShoot(processor_clock, resetn, startShoot, shoot);
	
	
	IR_RECEIVE u1(
					///clk 50MHz////
					.iCLK(master_clk), 
					//reset          
					.iRST_n(resetn),        
					//IRDA code input
					.iIRDA(IRDA_RXD), 
					//read command      
					//.iREAD(data_read),
					//data ready      					
					.oDATA_READY(data_ready),
					//decoded data 32bit
					.oDATA(hex_data)        
					);
	clk_reduce reduce1(master_clk, VGA_clk); //Reduces 50MHz clock to 25MHz
	VGA_gen gen1(VGA_clk, xCount, yCount, displayArea, VGA_hSync, VGA_vSync, blank_n);//Generates xCount, yCount and horizontal/vertical sync signals	
	randomGrid rand1(VGA_clk, rand_X, rand_Y);
	//kbInput kbIn(VGA_clk, hex_data[19:16], pos);
	wire [2:0] direction;
	output left, right, shoot, stop;
	assign left = direction[0];
	assign right = direction[1];
	assign stop = direction[2];
	
	//wire [2:0] unlatchedDirection; Need to latch with a DFF at processor's clock frequency?
	//wire unlatchedShoot;
	
	kbInput hexKeybord(hex_data[19:16], direction, startShoot);
	//kbInput hexKeybord(hex_data[19:16], unlatchedDirection, unlatchedShoot);
	
	processorClk getProcessorClock(master_clk, processor_clock);
	
	wire [9:0] xPos, xEPos, xBPos;
	wire [8:0] yPos, yEPos, yBPos;
	 
	assign xPos = playerXPosition;
	assign yPos = playerYPosition;
	assign xEPos = enemyXPosition;
	assign yEPos = enemyYPosition;
	assign xBPos = bulletXPosition;
	assign yBPos = bulletYPosition;
	
	updateClk UPDATE(master_clk, update);
	assign DAC_clk = VGA_clk;
	//
	always @(posedge VGA_clk)//---------------------------------------------------------------Added border function
	begin
		border <= (((xCount >= 0) && (xCount < 11) || (xCount >= 630) && (xCount < 641)) || ((yCount >= 0) && (yCount < 11) || (yCount >= 470) && (yCount < 481)));
	end
	
	always@(posedge update)
	begin
		playerX = xPos;
		playerY = yPos;
		enemyX = xEPos;
		enemyY = yEPos;
		bulletX = xBPos;
		bulletY = yBPos;
	end
	
		
	always@(posedge VGA_clk)
	begin				
		playerBodyOne = ((xCount > playerX+10 && xCount < playerX+20) && (yCount > playerY && yCount < playerY+10));
		playerBodyTwo = ((xCount > playerX-10 && xCount < playerX) && (yCount > playerY && yCount < playerY+10));
		playerBodyThree = ((xCount > playerX && xCount < playerX+10) && (yCount > playerY-10 && yCount < playerY));
		playerBody = playerBodyOne || playerBodyTwo || playerBodyThree;
		enemyBodyOne = ((xCount > enemyX+10 && xCount < enemyX+20) && (yCount > enemyY && yCount < enemyY+10));
		enemyBodyTwo = ((xCount > enemyX-10 && xCount < enemyX) && (yCount > enemyY && yCount < enemyY+10));
		enemyBodyThree = ((xCount > enemyX && xCount < enemyX+10) && (yCount > enemyY+10 && yCount < enemyY+20));
		enemyBody = enemyBodyOne || enemyBodyTwo || enemyBodyThree;
		bullet = ((xCount > bulletX && xCount < bulletX+10) && (yCount > bulletY && yCount < bulletY+10));
	end

	always@(posedge VGA_clk)
	begin	
		playerHead = (xCount > playerX && xCount < playerX+10) && (yCount > playerY && yCount < playerY+10);
		player = playerBody || playerHead;
		enemyHead = (xCount > enemyX && xCount < enemyX+10) && (yCount > enemyY && yCount < enemyY+10);
		enemy = enemyBody || enemyHead;
	end
																	
	assign R = (displayArea && enemy);
	assign G = (displayArea && (bullet || playerHead || enemyHead));
	assign B = (displayArea && (player || border));//---------------------------------------------------------------Added border
	always@(posedge VGA_clk)
	begin
		VGA_R = {8{R}};
		VGA_G = {8{G}};
		VGA_B = {8{B}};
	end 

endmodule

/***
module kbInput(data, direction, shoot, started);
	//input KB_clk;//, data;
	//input clock;
	input [3:0] data;
	//output reg [9:0] pos; 
	//wire [3:0] code;
	//reg [3:0] code;
	output reg [2:0] direction;
	output reg shoot;
	
	wire [3:0] code;
	assign code = data;
	
	output reg started;
	
	//wire latchShot;
	//wire [3:0] lastCode;
	
	//always@(posedge clock or code)
	//always@(posedge clock)
	//always@(posedge clock or code)
	//begin
	//if (~posedge clock) // code must have changed
	always@(code)
	begin
		if(code == 4'h4)
			begin
			direction <= 3'd1; // Move left, {001}
			shoot <= 1'b0;
			end
		else if(code == 4'h5)
			begin
			//direction <= direction;
			direction <= 3'd4;
			shoot <= 1'b1;
			//code <= 4'b0;
			end
		else if(code == 4'h6)
			begin
			direction <= 3'd2; // Move right, {010}
			shoot <= 1'b0;
			end
		else if(code == 4'h2)
			begin
			direction <= 3'd4; // Stop, {100}
			shoot <= 1'b0;
			end
		else if(code == 4'h0)
			begin
			started <= 1'b1;
			end
		else 
			begin
			direction <= direction; 
			shoot <= 1'b0;
			end
	end		
endmodule
***/

module inputFix(clock, resetn, newInput, finalOutput);
	input newInput, clock, resetn;
	//output fixedOutput;
	//wire fixedOutput;
	output finalOutput;
	//output lastInput;
	wire lastInput;
	//output lastlastInput;
	wire lastlastInput;
	//wire lastInput;
	wire changed;
	wire changed2;
	
	myDFFE latchLast(newInput, clock, resetn, 1'b1, lastInput);
	
	myDFFE latchLast2(lastInput, clock, resetn, 1'b1, lastlastInput);
	
	assign changed = lastInput ^ newInput;
	
	assign changed2 = lastlastInput ^ lastInput;
	
	//assign fixedOutput = changed ? newInput : 1'b0;
	
	assign finalOutput = (changed | changed2) ? newInput : 1'b0; 

endmodule



module processorClk(master_clk, processor_clock);
	input master_clk;
	output reg processor_clock;
	reg [20:0]count;	

	always@(posedge master_clk)
	begin
		count <= count + 1;
		if(count == 355550)
		begin
			processor_clock <= ~processor_clock;
			count <= 0;
		end	
	end
endmodule





//////////////////////////////////////////////////////////////////////////////////////////////////////


