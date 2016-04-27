module VGAWrapper(master_clk, DAC_clk, VGA_R, VGA_G, VGA_B, VGA_hSync, VGA_vSync, blank_n, resetn, IRDA_RXD, playerXPosition, playerYPosition, enemyXPosition, enemyYPosition, bulletXPosition, bulletYPosition, processor_clock, start, left, right, stop, shoot, enemyBulletXPosition, enemyBulletYPosition, bulletX2Position, bulletY2Position, win, lose);
	
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
	//input start;
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
	
	input [9:0] enemyBulletXPosition;
	input [8:0] enemyBulletYPosition;
	
	input [9:0] bulletX2Position;
	input [8:0] bulletY2Position;
	
	input win, lose;
	
	reg [9:0] enemyBulletX;
	reg [8:0] enemyBulletY;
	reg enemyBullet;
	
	reg bullet2;
	
	reg [9:0] bullet2X;
	reg [8:0] bullet2Y;
	//output update_clock;
	output processor_clock;
	//output timerInterrupt;
	//assign timerInterrupt = update;
	
	wire startShoot;
	
	
	//inputFix fixShoot(processor_clock, resetn, startShoot, shoot);
	assign shoot = startShoot;
	assign start = sendStart;
	
	//inputFix fixStart(processor_clock, resetn, sendStart, start);
	//assign update_clock = update;
		
	
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

	//kbInput kbIn(VGA_clk, hex_data[19:16], pos);
	wire [2:0] direction;
	output start;
	output left, right, shoot, stop;
	assign left = direction[0];
	assign right = direction[1];
	assign stop = direction[2];
	
	//wire [2:0] unlatchedDirection; Need to latch with a DFF at processor's clock frequency?
	//wire unlatchedShoot;
	wire sendStart;
	kbInput hexKeybord(hex_data[19:16], direction, startShoot, sendStart);
	//kbInput hexKeybord(hex_data[19:16], unlatchedDirection, unlatchedShoot);
	
	processorClk getProcessorClock(master_clk, processor_clock);
	
	wire [9:0] xPos, xEPos, xBPos;
	wire [8:0] yPos, yEPos, yBPos;
	
	wire [9:0] xEBPos;
	wire [8:0] yEBPos;
	
	wire [9:0] xB2Pos;
	wire [8:0] yB2Pos;
	
	assign xPos = playerXPosition;
	assign yPos = playerYPosition;
	assign xEPos = enemyXPosition;
	assign yEPos = enemyYPosition;
	assign xBPos = bulletXPosition;
	assign yBPos = bulletYPosition;
	
	assign xEBPos = enemyBulletXPosition;
	assign yEBPos = enemyBulletYPosition;
	
	assign xB2Pos = bulletX2Position;
	assign yB2Pos = bulletY2Position;
	
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
		
		enemyBulletX = xEBPos;
		enemyBulletY = yEBPos;
		
		bullet2X = xB2Pos;
		bullet2Y = yB2Pos;
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
		
		enemyBullet = ((xCount > enemyBulletX && xCount < enemyBulletX+10) && (yCount > enemyBulletY && yCount < enemyBulletY+10));
		bullet2 = ((xCount > bullet2X && xCount < bullet2X+10) && (yCount > bullet2Y && yCount < bullet2Y+10));
	end

	always@(posedge VGA_clk)
	begin	
		playerHead = (xCount > playerX && xCount < playerX+10) && (yCount > playerY && yCount < playerY+10);
		player = playerBody || playerHead;
		enemyHead = (xCount > enemyX && xCount < enemyX+10) && (yCount > enemyY && yCount < enemyY+10);
		enemy = enemyBody || enemyHead;
	end
	
																	
	//assign R = (displayArea && enemy);
	assign R = (displayArea && (enemy || enemyBullet)) || lose;
	//assign G = (displayArea && (bullet || playerHead || enemyHead));
	assign G = (displayArea && (bullet || playerHead || enemyHead || enemyBullet || bullet2)) || win; // Red + Green = Yellow
	assign B = (displayArea && (player || border || bullet2));//---------------------------------------------------------------Added border
	always@(posedge VGA_clk)
	begin
		VGA_R = {8{R}};
		VGA_G = {8{G}};
		VGA_B = {8{B}};
	end 

endmodule


module VGA_gen(VGA_clk, xCount, yCount, displayArea, VGA_hSync, VGA_vSync, blank_n);

	input VGA_clk;
	output reg [9:0]xCount, yCount; 
	output reg displayArea;  
	output VGA_hSync, VGA_vSync, blank_n;

	reg p_hSync, p_vSync; 
	
	integer porchHF = 640; //start of horizntal front porch
	integer syncH = 655;//start of horizontal sync
	integer porchHB = 747; //start of horizontal back porch
	integer maxH = 793; //total length of line.

	integer porchVF = 480; //start of vertical front porch 
	integer syncV = 490; //start of vertical sync
	integer porchVB = 492; //start of vertical back porch
	integer maxV = 525; //total rows. 

	always@(posedge VGA_clk)
	begin
		if(xCount === maxH)
			xCount <= 0;
		else
			xCount <= xCount + 1;
	end
	// 93sync, 46 bp, 640 display, 15 fp
	// 2 sync, 33 bp, 480 display, 10 fp
	always@(posedge VGA_clk)
	begin
		if(xCount === maxH)
		begin
			if(yCount === maxV)
				yCount <= 0;
			else
			yCount <= yCount + 1;
		end
	end
	
	always@(posedge VGA_clk)
	begin
		displayArea <= ((xCount < porchHF) && (yCount < porchVF)); 
	end

	always@(posedge VGA_clk)
	begin
		p_hSync <= ((xCount >= syncH) && (xCount < porchHB)); 
		p_vSync <= ((yCount >= syncV) && (yCount < porchVB)); 
	end
 
	assign VGA_vSync = ~p_vSync; 
	assign VGA_hSync = ~p_hSync;
	assign blank_n = displayArea;
endmodule



module processorClk(master_clk, processor_clock);
	input master_clk;
	output reg processor_clock;
	reg [20:0]count;	

	always@(posedge master_clk)
	begin
		count <= count + 1;
		if(count == 59258)
		begin
			processor_clock <= ~processor_clock;
			count <= 0;
		end	
	end
endmodule



module kbInput(data, direction, shoot, started);
	input [3:0] data;
	output reg [2:0] direction;
	output reg shoot;
	
	wire [3:0] code;
	assign code = data;
	
	output reg started;
	
	always@(code)
	begin
		if(code == 4'h4)
			begin
			direction <= 3'd1; // Move left, {001}
			shoot <= 1'b0;
			started <= 1'b0;
			end
		else if(code == 4'h5)
			begin
			//direction <= direction;
			direction <= 3'd4;
			shoot <= 1'b1;
			started <= 1'b0;
			//code <= 4'b0;
			end
		else if(code == 4'h6)
			begin
			direction <= 3'd2; // Move right, {010}
			shoot <= 1'b0;
			started <= 1'b0;
			end
		else if(code == 4'h2)
			begin
			direction <= 3'd4; // Stop, {100}
			shoot <= 1'b0;
			started <= 1'b0;
			end
		else if(code == 4'h8)
			begin
			started <= 1'b1;
			shoot <= 1'b0;
			direction <= 3'd4;
			end
		else 
			begin
			direction <= direction; 
			shoot <= 1'b0;
			started <= 1'b0;
			end
	end		
endmodule

module clk_reduce(master_clk, VGA_clk);

	input master_clk; //50MHz clock
	output reg VGA_clk; //25MHz clock
	reg q;

	always@(posedge master_clk)
	begin
		q <= ~q; 
		VGA_clk <= q;
	end
endmodule

module updateClk(master_clk, update);
	input master_clk;
	output reg update;
	reg [21:0]count;	

	always@(posedge master_clk)
	begin
		count <= count + 1;
		if(count == 1777777)
		begin
			update <= ~update;
			count <= 0;
		end	
	end
endmodule
