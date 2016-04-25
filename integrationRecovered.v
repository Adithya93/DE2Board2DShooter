module skeletonRecovered(	master_clk, resetn, IRDA_RXD,/*ps2_clock, ps2_data,*/debug_word, debug_addr, 
					leds, lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon, 	
					seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8, outclock, readingPos, testPC, start, VGA_R, VGA_G, VGA_B, VGA_hSync, VGA_vSync, DAC_clk, blank_n, playerXPosition, bulletXPosition, bulletYPosition, RegWriteData, speedData, shootData, readingBulletX, readingBulletY, processor_clock, enemyBulletXPosition, enemyBulletYPosition, readingEnemyBulletX, readingEnemyBulletY, win, lose);

	//input 			inclock, resetn;
	input resetn;
	
	//inout 			ps2_data, ps2_clock;
	input master_clk;
	wire inclock;
	//assign inclock = master_clk;
	//assign inclock = update_clock;
	
	output 			lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon;
	output 	[7:0] 	leds, lcd_data;
	output 	[6:0] 	seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;
	output 	[31:0] 	debug_word;
	output  [11:0]  debug_addr;
	
	wire			clock;
	wire			lcd_write_en;
	wire 	[31:0]	lcd_write_data;
	wire	[7:0]	ps2_key_data;
	wire			ps2_key_pressed;
	wire	[7:0]	ps2_out;	

	
	// PROJECT : FOR TESTING OF INPUT (MAY BE EVENTUALLY REPLACED BY KEYBOARD AND PS2CONTROLLER)
	
	//input left, right, stop, shoot;
	wire left, right, stop, shoot;
	//output left, right, stop, shoot;
	
	//input start;
	output start;
	input IRDA_RXD;

	//input left2, right2, up, down;
	
	// FOR DEBUGGING
	output outclock, readingPos;
	//output [2:0] testPC;
	output [4:0] testPC;
	//output [31:0] toVGA;
	output [9:0] playerXPosition, bulletXPosition;
	output [8:0] bulletYPosition;
	output [31:0] RegWriteData;
	//output [2:0] RegWriteDSel;
	output [31:0] speedData;
	output shootData;
	output readingBulletX, readingBulletY;
	output processor_clock;
	
	output [9:0] enemyBulletXPosition;
	output [8:0] enemyBulletYPosition;
	output readingEnemyBulletX, readingEnemyBulletY;
	output win, lose;
	
	wire [7:0] displayScore;
	
	/***
	output gotShootSignal;
	
	output bulletSpeed, bulletSpeed2, bulletSpeed3;
	
	output sanityCheck;
	
	output sanityCheck2;
	
	output regFileInput;
	
	output updateBulletSpeed;
	output checkSel;
	output checkSel2;
	output updateBulletSpeed2;
	output [1:0] RegWriteDSel;
	output [31:0] allOtherData;
	***/
	
	/***
	
	output lessThan, shouldBranch;
	
	output [31:0] ALUInput1, ALUInput2, ALUOutput;
	
	output [31:0] RS2Val, chosenALUInB; 
	output [1:0] ALUIn2Bypass;
	output [4:0] RS2;
	output [4:0] RD;
	output RegWE;
	output [4:0] MWOp;
	output multRDY;
	***/
	
	
	output [7:0] VGA_R, VGA_G, VGA_B;  //Red, Green, Blue VGA signals
	output VGA_hSync, VGA_vSync, DAC_clk, blank_n; //Horizontal and Vertical sync signals
	
	/***
	output [31:0] RS1Val, RS2Val, RDVal;
	output [31:0] speedData;
	output [2:0] finalNextPCSel;
	output [31:0] iMemAddr, FDIns, DXIns, XMIns, MWIns;
	output [2:0] RegWriteDSel;
	output [31:0] ALUOutput;
	output [1:0] ALUIn1Bypass, ALUIn2Bypass;
	***/	
	
	// clock divider (by 5, i.e., 10 MHz)
	
	//pll div(inclock,clock);
	
	// UNCOMMENT FOLLOWING LINE AND COMMENT ABOVE LINE TO RUN AT 50 MHz
	//assign clock = inclock;
	
	// your processor
	
	//assign inclock = update_clock; // Uncomment when using DE2 board
	assign inclock = master_clk;
	//wire processor_clock;
	//processor myprocessor(inclock, ~resetn, ps2_key_pressed, ps2_out, lcd_write_en, lcd_write_data, debug_word, debug_addr, left, right, stop, shoot, leds, outclock, readingPos, testPC, playerXPosition, playerYPosition, bulletXPosition, bulletYPosition, enemyXPosition, enemyYPosition, RegWriteData, RegWriteDSel, speedData, shootData, readingBulletX, readingBulletY);
	processorRecovered myprocessor(processor_clock, ~resetn, ps2_key_pressed, ps2_out, lcd_write_en, lcd_write_data, debug_word, debug_addr, start, left, right, stop, shoot, leds, outclock, readingPos, testPC, playerXPosition, playerYPosition, bulletXPosition, bulletYPosition, enemyXPosition, enemyYPosition, displayScore, RegWriteData, speedData, shootData, readingBulletX, readingBulletY, enemyBulletXPosition, enemyBulletYPosition, readingEnemyBulletX, readingEnemyBulletY, win, lose);

	
	// keyboard controller
	//PS2_Interface myps2(clock, resetn, ps2_clock, ps2_data, ps2_key_data, ps2_key_pressed, ps2_out);
	
	// lcd controller
	//lcd mylcd(clock, ~resetn, lcd_write_en, lcd_write_data[7:0], lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon);
	
	// example for sending ps2 data to the first two seven segment displays
	Hexadecimal_To_Seven_Segment hex1(displayScore[3:0], seg1);
	Hexadecimal_To_Seven_Segment hex2(displayScore[7:4], seg2);
	
	// the other seven segment displays are currently set to 0
	//Hexadecimal_To_Seven_Segment hex3(4'b0, seg3);
	//Hexadecimal_To_Seven_Segment hex4(4'b0, seg4);
	//Hexadecimal_To_Seven_Segment hex5(4'b0, seg5);
	//Hexadecimal_To_Seven_Segment hex6(4'b0, seg6);
	//Hexadecimal_To_Seven_Segment hex7(4'b0, seg7);
	//Hexadecimal_To_Seven_Segment hex8(4'b0, seg8);
	
	// some LEDs that you could use for debugging if you wanted
	//assign leds = 8'b00101011;
	
	//wire master_clk;
	//assign master_clk = inclock;
	
	//Snake testvGA(start, master_clk, KB_clk, data, DAC_clk, VGA_R, VGA_G, VGA_B, VGA_hSync, VGA_vSync, blank_n, up, left, down, right, toVGA, update_clock);
	wire update_clock;
	wire [9:0] playerXPosition, enemyXPosition, bulletXPosition;
	wire [8:0] playerYPosition, enemyYPosition, bulletYPosition;
	
	wire [9:0] enemyBulletXPosition;
	wire [8:0] enemyBulletYPosition;
//	VGAWrapper testVGA(start, master_clk, KB_clk, data, DAC_clk, VGA_R, VGA_G, VGA_B, VGA_hSync, VGA_vSync, blank_n, resetn, IRDA_RXD, playerXPosition, playerYPosition, enemyXPosition, enemyYPosition, bulletXPosition, bulletYPosition, update_clock);
// VGAWrapper(start, master_clk, KB_clk, data, DAC_clk, VGA_R, VGA_G, VGA_B, VGA_hSync, VGA_vSync, blank_n, resetn, IRDA_RXD, playerXPosition, playerYPosition, enemyXPosition, enemyYPosition, bulletXPosition, bulletYPosition);	
//	VGAWrapper testVGA(start, master_clk, DAC_clk, VGA_R, VGA_G, VGA_B, VGA_hSync, VGA_vSync, blank_n, resetn, IRDA_RXD, playerXPosition, playerYPosition, enemyXPosition, enemyYPosition, bulletXPosition, bulletYPosition, processor_clock, left, right, stop, shoot);
	VGAWrapperRecovered testVGA(master_clk, DAC_clk, VGA_R, VGA_G, VGA_B, VGA_hSync, VGA_vSync, blank_n, resetn, IRDA_RXD, playerXPosition, playerYPosition, enemyXPosition, enemyYPosition, bulletXPosition, bulletYPosition, processor_clock, start, left, right, stop, shoot, enemyBulletXPosition, enemyBulletYPosition, win, lose);
	
endmodule

module processorRecovered(inclock, INreset, ps2_key_pressed, ps2_out, lcd_write, lcd_data, debug_data, debug_addr, start, left, right, stop, shoot, leds, outclock, readingPos, testPC, playerXPosition, playerYPosition, bulletXPosition, bulletYPosition, enemyXPosition, enemyYPosition, displayScore, RegWriteData, speedData, shootData, readingBulletX, readingBulletY, enemyBulletXPosition, enemyBulletYPosition, readingEnemyBulletX, readingEnemyBulletY, win, lose);

	input 			inclock, INreset, ps2_key_pressed;
	input 	[7:0]	ps2_out;
	
	output 			lcd_write;
	output 	[31:0] 	lcd_data;
	
	// GRADER OUTPUTS - YOU MUST CONNECT TO YOUR DMEM
	output 	[31:0] 	debug_data;
	output	[11:0]	debug_addr;
	
	// FOR PROJECT - I/O TESTING
	input start, left, right, stop, shoot;
	output [7:0] leds;
	
	output win, lose;
	
	wire writingEndState;
	
	assign writingEndState = (MWIns[26] & MWIns[25] & MWIns[24] & MWIns[23] & ~MWIns[22]); // If writing to Register 30
	
	
	myDFFE setGoodOutcome(~RegWriteData[31], clock, reset, writingEndState, win);
	
	myDFFE setBadOutcome(RegWriteData[31], clock, reset, writingEndState, lose);
	
	// DEBUG
	output [31:0] RegWriteData;
	/***
	
	output gotShootSignal;
	
	assign gotShootSignal = shoot;
	
	
	output bulletSpeed;
	output bulletSpeed2;
	output bulletSpeed3;
	output regFileInput;
	output sanityCheck;
	output sanityCheck2;
	
	output updateBulletSpeed;
	output checkSel;
	output checkSel2;
	output updateBulletSpeed2;
	
	output [1:0] RegWriteDSel;
	output [31:0] allOtherData;
	***/
	
	// DEBUG WIRES, CAN BE REMOVED
	wire checkSel, updateBulletSpeed2, checkSel2, bulletSpeed, bulletSpeed2, bulletSpeed3, sanityCheck, sanityCheck2, regFileInput;
	
	wire isCorrectSel;
	assign isCorrectSel = RegWriteDSel[2] & ~RegWriteDSel[1] & RegWriteDSel[0];
	
	myDFFE latchCorrectSel(isCorrectSel & extendedShootData[0], clock, reset, updateBulletSpeed, checkSel);
	myDFFE latchCorrectSel2(isCorrectSel & extendedShootData[0], ~clock, reset, updateBulletSpeed2, checkSel2);
	
	/***
	output [31:0] RS2Val;
	
	output [31:0] chosenALUInB;
	
	output [1:0] ALUIn2Bypass;
	
	output [4:0] RS2;
	
	output [4:0] RD;
	
	output RegWE;
	
	output [4:0] MWOp;
	output multRDY;
	
	assign MWOp = MWIns[31:27];
	assign multRDY = multDivResultRDY;
	
	wire [31:0] RS2Val;
	wire [31:0] chosenALUInB;
	wire [1:0] ALUIn2Bypass;
	***/
	
	wire updateBulletSpeed;
	//wire updateBulletSpeed2;
	
	assign updateBulletSpeed = (MWIns[31] & MWIns[30] & ~MWIns[29] & ~MWIns[28] & MWIns[27]);
	
	myDFFE latchBulletUpdate(updateBulletSpeed, clock, reset, 1'b1, updateBulletSpeed2);
	
	//myDFFE latchBulletSpeed(RegWriteData[0], clock, reset, updateBulletSpeed, bulletSpeed);
	myDFFE latchBulletSpeed(allOtherData[0], clock, reset, updateBulletSpeed, bulletSpeed);

	//myDFFE latchBulletSpeed2(RegWriteData[0], ~clock, reset, updateBulletSpeed, bulletSpeed2);
	//myDFFE latchBulletSpeed2(allOtherData[0], ~clock, reset, updateBulletSpeed, bulletSpeed2);
	myDFFE latchBulletSpeed2(RegWriteData[0], clock, reset, updateBulletSpeed | updateBulletSpeed2, bulletSpeed2);
	
	//myDFFE latchBulletSpeed3(bulletSpeed2, clock, reset, bulletSpeed2, bulletSpeed3);

	wire reset;
	
	assign reset = ~INreset; // Skeleton assumes processor is active-high but mine is active-low

	// TEMP - FOR INVERTED CLOCK
	wire clock;
	//assign clock = ~inclock;
	assign clock = inclock;
	
	// Output Coordinates to VGA
	//output [31:0] toVGA;
	wire [31:0] playerXCoords, playerYCoords, bulletXCoords, bulletYCoords, enemyXCoords, enemyYCoords, score;
	
	wire [31:0] enemyBulletXCoords, enemyBulletYCoords;
	// TO BE ASSIGNED
	
	//wire readingBulletX, readingBulletY,
	wire readingPlayerY;
	wire readingEnemyX, readingEnemyY, readingSCore;
	output readingBulletX, readingBulletY;
	
	output readingEnemyBulletX, readingEnemyBulletY;
	
	//assign toVGA = 
	output [9:0] playerXPosition, bulletXPosition, enemyXPosition;
	output [8:0] playerYPosition, bulletYPosition, enemyYPosition;
	output [9:0] enemyBulletXPosition;
	output [8:0] enemyBulletYPosition;
	output [7:0] displayScore;

		// TRY SWITCHING TO NEG CLOCK
		// WHEN THAT FAILS, TRY WIRING MWALUOUTPUT INSTEAD OF REGWRITEDATA
	Register32 playerXReg(~clock, readingPos, RegWriteData, reset, playerXCoords);
	//assign playerYCoords = 9'd400; // Change to register later
	Register32 playerYReg(~clock, readingPlayerY, RegWriteData, reset, playerYCoords);
	Register32 bulletXReg(~clock, readingBulletX, RegWriteData, reset, bulletXCoords);
	Register32 bulletYReg(~clock, readingBulletY, RegWriteData, reset, bulletYCoords);
	//Register32 enemyXReg(clock, readingEnemyX, RS1Val, reset, enemyXCoords);
	//assign enemyXCoords = 32'd300;// TEMP
	Register32 enemyXReg(~clock, readingEnemyX, RegWriteData, reset, enemyXCoords);
	Register32 enemyYReg(~clock, readingEnemyY, RegWriteData, reset, enemyYCoords);
	//Register32 enemyYReg(clock, readingEnemyY, RS1Val, reset, enemyYCoords);
	
	Register32 enemyBulletXReg(~clock, readingEnemyBulletX, RegWriteData, reset, enemyBulletXCoords);
	Register32 enemyBulletYReg(~clock, readingEnemyBulletY, RegWriteData, reset, enemyBulletYCoords);
	
	//assign enemyYCoords = 32'd550;// TEMP
	
	Register32 scoreReg(~clock, readingScore, MWALUOutput, reset, score);
	
	assign displayScore = score[7:0];
	
	
	//assign toVGA = xCoords;
	assign playerXPosition = playerXCoords[9:0];
	assign playerYPosition = playerYCoords[8:0];
	assign bulletXPosition = bulletXCoords[9:0];
	assign bulletYPosition = bulletYCoords[8:0];
	assign enemyXPosition = enemyXCoords[9:0];
	assign enemyYPosition = enemyYCoords[8:0];
	
	assign enemyBulletXPosition = enemyBulletXCoords[9:0];
	assign enemyBulletYPosition = enemyBulletYCoords[8:0];
	
	// DEBUG ONLY - remember to change to wire
	output outclock, readingPos;
	//output [2:0] testPC;
	output [4:0] testPC;
	assign outclock = clock;
	//assign testPC = FDPC[2:0];
	assign testPC = FDPC[4:0];
	/***
	output [31:0] RS1Val, RS2Val, RegWriteData;
	output [31:0] iMemAddr, FDIns, DXIns, XMIns, MWIns;
	output [31:0] ALUOutput;
	output [1:0] ALUIn1Bypass, ALUIn2Bypass;
	***/
	//output [31:0] imemAddr, instruction;
	//output [2:0] finalNextPCSel;
	//output [31:0] speedData;
	
	// your processor here
	//
	//wire [31:0] sxImm;
	
	wire loadStall;
	//output loadStall;
	//output [1:0] dataStructStall;
	wire [1:0] dataStructStall;
	//wire stallForBranch; // TEMP : EVENTUALLY REPLACE WITH PREDICTION AND FLUSHING
	//wire notStall;
	
	wire PCEnable;
	wire FDEnable;
	wire DXEnable;
	
	assign PCEnable = ~loadStall;
	assign FDEnable = ~loadStall;
	
	
	loadStallLogic myLoadStall(FDIns, DXIns, loadStall);
	//branchStall myBranchStall(FDIns, stallForBranch);
	//assign notStall = ~loadStall; // TEMP : NEED TO ACCOUNT FOR MULTDIV STALL AS WELL
	

	// DEBUG OUTPUTS - REMEMBER TO CONVERT BACK TO WIRE WHEN DONE
	//output [31:0] FDPC, DXPC, XMPC, MWPC;
	//output [31:0] FDIns, DXIns, XMIns, MWIns;
	//output [31:0] DXRS1Val, DXRS2Val;
	//output [31:0] XMALUOutput, XMRS2Val, MWALUOutput, MWMemData;

	// Pipeline Registers and their wires
	
	wire [31:0] FDPC, DXPC, XMPC, MWPC;
	wire [31:0] DXRS1Val, DXRS2Val;
	wire [31:0]	XMALUOutput, XMRS2Val, MWALUOutput, MWMemData;
	
	wire [31:0] FDIns, DXIns, RS1Val, RS2Val, ALUOutput, XMIns, MWIns;//, RegWriteData;
	wire [1:0] ALUIn1Bypass, ALUIn2Bypass;
		
	// Try inverted clock
	FDReg myFDReg(~clock, FDEnable, reset, inst, pcPlusOne, FDIns, FDPC); //pcPlusOne instead of iMemAddr
	//FDReg myFDReg(~clock, FDEnable, reset, inst, PC, FDIns, FDPC);
	DXReg myDXReg(~clock, 1'b1, reset, chosenDXInput, FDPC, RS1Val, RS2Val, DXIns, DXPC, DXRS1Val, DXRS2Val);
	XMReg myXMReg(~clock, 1'b1, reset, DXIns, DXPC, ALUOutput, chosenNextXMRS2Val, XMIns, XMPC, XMALUOutput, XMRS2Val);
	MWReg myMWReg(~clock, 1'b1, reset, chosenMWInput, XMPC, XMALUOutput, memRead, MWIns, MWPC, MWALUOutput, MWMemData);
	
	wire ALUOpBSel, memWE, RS2Sel, BNE, BLT, BEX;
	// wire RegWE;
	wire [1:0] nextPCSel;

	 wire [2:0] RegWriteDSel;
	 //output [2:0] RegWriteDSel;
	 
	//output [2:0] RegWriteDSel;
	
	//assign sxImm[31:17] = inst[16] ? {15{1'b1}} : {15{1'b0}};
	//assign sxImm[16:0] = inst[16:0];
	wire ioInterrupt;
	
	control insnDecoder(FDIns, DXIns, XMIns, MWIns, multDivResultRDY, multDivException, multDivRD, RegWE, ALUOpBSel, memWE, RS2Sel, RD, ALUOpcode, RegWriteDSel, nextPCSel, BNE, BLT, BEX, writeStatus, newSTATUS, hasPrediction, ioInterrupt);
	
	// adder for Absolute Address from Relative Address and branch-related hardware
	wire [31:0] sxAbsBranchAddr;
//	wire [11:0] absBranchAddr;
	wire [31:0] absBranchAddr;
	wire branchAddrOverflow;
	wire shouldBranch0, shouldBranch1, shouldBranch2, shouldBranch;
	
	// DEBUG ONLY
	//output shouldBranch;
	
	//wire STATUS;
	//wire [11:0] branchOrNext;
	//wire [31:0] branchOrNext;
	CLAdder getAddr(1'b0, DXPC, sxDXImm, sxAbsBranchAddr, branchAddrOverflow); // should connect to status
	assign absBranchAddr = sxAbsBranchAddr[11:0];
	//assign branchOrNext = shouldBranch ? absBranchAddr : DXPC;
	
	//assign branchOrNext = shouldBranch ? absBranchAddr : pcPlusOne;
	
	// DEPRECATED SINCE IT CAUSES JUMP TO GO THROUGH OVER BRANCH 
	//assign branchOrNext = shouldBranch ? absBranchAddr : PC;
	
	// NEED TO DEAL WITH EDGE CASE OF JUMP AFTER BRANCH! DON'T FORGET!!!
	//isBranch - select input is output of or gate of output of and gates that take isBranch and ALU outputs
	and BNETest(shouldBranch0, BNE, notEqual);
	and BLTest(shouldBranch1, BLT, ~lessThan & notEqual); // ALU DOES RS - RD, NEED TO FLIP
	and BEXTest(shouldBranch2, BEX, STATUS[0]);
	or branchTest(shouldBranch, shouldBranch0, shouldBranch1, shouldBranch2);


	// TO - DO : JUMP INSTRUCTIONS
	wire [31:0] normalJump, jr;
	
	assign normalJump[31:27] = FDPC[31:27];
	assign normalJump[26:0] = FDIns[26:0];
	
	// Incoroporate bypass logic for JR
	//assign jr = RS2Val;
	wire [1:0] jrSel;
	jrBypass jrSelector(FDIns, DXIns, XMIns, MWIns, jrSel);
	fourOneMux jumpTarget(RS2Val, DXPC, XMPC, MWPC, jrSel, jr);
	
	twoOneMux5 RS2Selector(FDIns[16:12], FDIns[26:22], RS2Sel, RS2); 
	
	
	//fourOneMux RegWriteDSelector(MWALUOutput, MWMemData, multDivVal, MWPC, RegWriteDSel, RegWriteData);
	// MODIFY RegWriteDSelector to be 8-1 MUX capable of accepting data from inputControl
	
	//eightOneMux RegWriteDSelector(MWALUOutput, MWMemData, multDivVal, MWPC, speedData, extendedShootData, speedData, extendedShootData, RegWriteDSel, RegWriteData);
	// CHANGE TO WIRE SPEED DIRECTLY INTO 2-1 MUX WITH
	wire [31:0] allOtherData;
	
	eightOneMux RegWriteDSelector(MWALUOutput, MWMemData, multDivVal, MWPC, speedData, extendedShootData, speedData, extendedShootData, RegWriteDSel, allOtherData);

	assign RegWriteData = (updateBulletSpeed | updateBulletSpeed2) ? extendedShootData : allOtherData;
	
	assign bulletSpeed3 = extendedShootData[0];
	
	//assign sanityCheck = bulletSpeed3 & updateBulletSpeed;
	// DEBUG ONLY
	myDFFE latchSanityCheck(bulletSpeed3 & updateBulletSpeed, clock, reset, updateBulletSpeed, sanityCheck);
	
	
	myDFFE latchSanityCheck2(bulletSpeed3 & updateBulletSpeed2, clock, reset, updateBulletSpeed2, sanityCheck2);
	
	myDFFE latchRegFileInput(RegWriteData[0], clock, reset, updateBulletSpeed, regFileInput);
	//assign regFileInput = RegWriteData[0];
	
	
	
	
	//fourOneMux12 nextPCSelector(branchOrNext, normalJump, jr, branchOrNext, nextPCSel, nextImemAddr);
	
	//fourOneMux nextPCSelector(branchOrNext, normalJump, jr, branchOrNext, nextPCSel, sxiMemAddr);
	wire [2:0] finalNextPCSel;
	
	// FOR DEBUG ONLY - REMEMBER TO CHANGE BACK
	//output [2:0] finalNextPCSel;
	
	wire [31:0] penultimateAddr;
	
	wire misPrediction;
	//output misPrediction;
	
	assign misPrediction = wasTaken ^ shouldBranch;
	assign finalNextPCSel[2] = shouldBranch & ~wasTaken; // Mis-Prediction : False Negative
	assign finalNextPCSel[1:0] = nextPCSel;
	//eightOneMux nextPCSelector(PC, normalJump, jr, PC, absBranchAddr, absBranchAddr, absBranchAddr, absBranchAddr, finalNextPCSel, sxiMemAddr);
	//eightOneMux nextPCSelector(pcOrPrediction, normalJump, jr, pcOrPrediction, absBranchAddr, absBranchAddr, absBranchAddr, absBranchAddr, finalNextPCSel, sxiMemAddr);
	eightOneMux nextPCSelector(pcOrPrediction, normalJump, jr, pcOrPrediction, absBranchAddr, absBranchAddr, absBranchAddr, absBranchAddr, finalNextPCSel, penultimateAddr);
	// Mis-Prediction : False Positive
	assign sxiMemAddr = (~shouldBranch & wasTaken) ? DXPC : penultimateAddr; 
	
	assign iMemAddr = sxiMemAddr[11:0];
	
	// Program Counter and its wires
	//wire [11:0] nextImemAddr;
	
	wire [31:0] nextPC;
	//output [31:0] nextPC; // Remember to change back!
	wire [31:0] PC;
	
	assign nextPC = pcPlusOne;
	
	//assign nextPC[11:0] = nextImemAddr;
	//assign nextPC[31:12] = {20{1'b0}}; // CAN BE CHANGED FOR FUTURE USE
	
	//assign iMemAddr = PC[11:0];
	
	//Register12 ProgramCounter(clock, notStall, nextImemAddr, reset, iMemAddr);
	// TRY NEG CLOCK FOR PC TO SYNC WITH PIPELINE REGS
	Register32 ProgramCounter(~clock, PCEnable, nextPC, reset, PC);
	
	// Branch Predictor
	
	wire [31:0] prediction;
	//output [31:0] prediction; // REMEMBER TO CHANGE BACK TO WIRE
	
	wire hasPrediction; // 1 if FDOpcode is branch; assigned by Control
	//output hasPrediction; // REMEMBER TO CHANGE BACK TO WIRE
	
	wire [31:0] pcOrPrediction;
	
	
	wire isTaken;
	//output isTaken;
	wire wasTaken;
	//output wasTaken;
	
	assign pcOrPrediction = hasPrediction ? prediction : PC;
	branchPredictor myPredictor(clock, reset, FDIns[31:27], FDPC, DXIns[31:27], shouldBranch, DXPC, absBranchAddr, prediction, isTaken);
	myDFFE latchDecision(isTaken, ~clock, reset, 1'b1, wasTaken); // 1 cycle delay to match up with branch insn going to DX reg
	
	
	
	// Adder for PC and its wires
	wire [31:0] sxiMemAddr, one;
	//assign sxiMemAddr[11:0] = iMemAddr;
	//assign sxiMemAddr[31:12] = {20{1'b0}};
	//assign sxiMemAddr = PC;
	assign one[31:1] = {30{1'b0}};
	assign one[0] = 1'b1;
	//wire [11:0] pcPlusOne;
	wire [31:0] pcPlusOne;
	wire pcOverflow;
	
	// MUX to select	
	CLAdder addOne(1'b0, sxiMemAddr, one, pcPlusOne, pcOverflow); // ignore isZero port of adder

	// RegFile and its Ports
	// REMEMBER TO CHANGE BACK TO WIRES LATER
	wire [4:0] RS1, RS2, RD;
	//output [4:0] RS1, RS2, RD;
	wire RegWE;
	//output RegWE;
	//wire [31:0] RS1Val, RS2Val, RegWriteData;
	//output [31:0] RS1Val, RS2Val;
	//output [31:0] RegWriteData;

	assign RS1 = FDIns[21:17];
	// Try inverted clock for Regfile
	// OR, TRY POSITIVE CLOCK SO THAT SAME CYCLE READ-AND-WRITE CAN BE DONE
	regfile myRegFile(clock, RegWE, reset, RD, RS1, RS2, RegWriteData, RS1Val, RS2Val);
		
		
	// STATUS REGISTER
	wire writeStatus;
	wire [31:0] newSTATUS;
	wire [31:0] STATUS;
	Register32 StatusReg(clock, writeStatus & ~misPrediction, newSTATUS, reset, STATUS); // If branch is being taken now, DON'T WRITE STATUS
		
	//ALU and its Ports
	
	wire [31:0] ALUInputA;
	//output [31:0] ALUInputA; // REMEMBER TO CHANGE
	wire [31:0] ALUInputB;
	//output [31:0] ALUInputB; // REMEMBER TO CHANGE
	
	//wire [2:0] ALUOpcode;
	wire [4:0] ALUOpcode;
	wire [4:0] ALUShiftAmt;
	
	//wire [31:0] ALUOutput;
	//output [31:0] ALUOutput;
	
	wire ALUoverflow;
	wire notEqual;
	//wire lessThan;
	// DEBUG ONLY, must change
	//output lessThan;
	wire lessThan;
	
	wire [31:0] sxDXImm;
	wire [31:0] chosenALUInB;
	
//	wire [1:0] ALUIn1Bypass, ALUIn2Bypass;
//	output [1:0] ALUIn1Bypass, ALUIn2Bypass;


	//output [1:0] ALUIn1Bypass, ALUIn2Bypass; // REMEMBER TO CHANGE BACK TO WIRE 
	
	
	wire MemDataBypass, XMRS2Sel;
	
	assign sxDXImm[16:0] = DXIns[16:0];
	//assign sxDXImm[31:17] = {15{1'b0}};
	assign sxDXImm[31:17] = DXIns[16] ? {15{1'b1}} : {15{1'b0}};
	
		// ALU Input Control
	twoOneMux ALUOpBSelector(DXRS2Val, sxDXImm, ALUOpBSel, chosenALUInB);

	// multDivControl and its ports
	wire multDivResultRDY, multDivInputRDY, multDivException;
	wire [4:0] multDivRD;
	wire [31:0] multDivVal;
	//wire [1:0] dataStructStall;
	wire warStall;
	
	// Use ALUInputA and ALUInputB in place of DXRS1Val and DXRS2Val to hitchhike on MX/WX bypass logic
	multDivControl myMultDivCTRL(clock, DXIns, ALUInputA, ALUInputB, reset, multDivVal, multDivRD, multDivResultRDY, multDivInputRDY, multDivException);
	
	multDivStalls multDivHazards(FDIns, XMIns, RS2Sel, multDivResultRDY, multDivInputRDY, multDivRD, dataStructStall, warStall);
	
	
	
	
	
		// Bypass MXes & Bypass Control
	bypassControl bpc(DXIns, XMIns, MWIns, ALUIn1Bypass, ALUIn2Bypass, MemDataBypass, XMRS2Sel);
	//fourOneMux ALUIn1Selector(DXRS1Val, XMALUOutput, MWALUOutput, DXRS1Val, ALUIn1Bypass, ALUInputA);
	//fourOneMux ALUIn1Selector(DXRS1Val, XMALUOutput, RegWriteData, DXRS1Val, ALUIn1Bypass, ALUInputA);
	
	// FOR PROJECT - INCLUDE EXTRA SELECT BIT TO INCORPORATE MX BYPASS FROM IO REG
	
	fourOneMux ALUIn1Selector(DXRS1Val, XMALUOutput, RegWriteData, XMALUOutput, ALUIn1Bypass, ALUInputA);
	//fourOneMux ALUIn2Selector(chosenALUInB, XMALUOutput, MWALUOutput, chosenALUInB, ALUIn2Bypass, ALUInputB);
	fourOneMux ALUIn2Selector(chosenALUInB, XMALUOutput, MWALUOutput, XMALUOutput, ALUIn2Bypass, ALUInputB);
	
	// DEBUG ONLY
	//output [31:0] ALUInput1, ALUInput2, ALUOutput;
	//wire [31:0] ALUInput1, ALUInput2, ALUOutput;
	//assign ALUInput1 = ALUInputA;
	//assign ALUInput2 = ALUInputB;
	
	//assign ALUOpcode = DXIns[6:2];
	assign ALUShiftAmt = DXIns[11:7];
	ALU myALU(ALUInputA, ALUInputB, ALUOpcode, ALUShiftAmt, ALUOutput, notEqual, lessThan, ALUoverflow);
	
	
	// IMem Ports
	
	wire [11:0] iMemAddr;
	wire [31:0] inst;
	//output [11:0] iMemAddr;
	//output [31:0] inst;
		
	// DMem Ports
	//wire [11:0] debug_addr;
	wire [31:0] memWrite;
	//wire memReadEnable;
	//wire memWE;
	
	wire [31:0] memRead;
	//output [31:0] memRead;
	
	assign debug_addr = XMALUOutput[11:0];
	
	// STALLS
	// HANDLE LOAD STALL - disable W/E for PC & FD, and insert noop into DX
	wire [31:0] chosenDXInput;
	wire [31:0] NOOP;
	
	assign NOOP = {32{1'b1}};
	//assign chosenDXInput = loadStall ? NOOP : FDIns;
	
	/*** DEPRECATED : USE PREDICT NOT TAKEN AND FLUSH IF NECESSARY INSTEAD
	// HANDLE BRANCH STALL - disable W/E for PC and insert noop into FD
	wire [31:0] chosenFDInput;
	assign chosenFDInput = stallForBranch ? NOOP : inst;
	***/
	
	// RECOVERY FROM BRANCH MIS-PREDICTION : FEED NOOP INTO DXREG if branch taken
	assign chosenDXInput = (misPrediction | loadStall | dataStructStall[0] | dataStructStall[1]) ? NOOP : FDIns;
	
	wire [31:0] chosenNextXMRS2Val;
	assign chosenNextXMRS2Val = XMRS2Sel ? RegWriteData : DXRS2Val;
	
	// HANDLE MULTDIV STALL
	// if data or structural hazard, disable W/E for PC & FD, insert NOOP into DX
	// Reflected in OR condition above
	
	// if WAR hazard, insert NOOP into MW
	wire [31:0] chosenMWInput;
	assign chosenMWInput = warStall ? NOOP : XMIns;
	
	
	// IO
	//wire [31:0] speedData;
	output [31:0] speedData;
	
	
	//wire shootData;
	output shootData;
	
	wire [31:0] extendedShootData;
	assign extendedShootData[31:1] = 31'd0;
	assign extendedShootData[0] = shootData;

	wire resetSpeed, resetShoot;
	assign resetSpeed = ~(MWIns[31] & MWIns[30] & ~MWIns[29] & ~MWIns[28] & ~MWIns[27]); // Reset speed one cycle after it has been read
	assign resetShoot = ~(MWIns[31] & MWIns[30] & ~MWIns[29] & ~MWIns[28] & MWIns[27]); // Reset shoot one cycle after it has been read
	
	inputController userInput(clock, reset, start, left, right, shoot, stop, speedData, shootData, resetSpeed, resetShoot, ioInterrupt);
	
	// FOR TESTING INPUT 
	
	assign leds[0] = ~speedData[0] & ~speedData[1]; // not moving
	assign leds[1] = speedData[0] & speedData[1]; // moving left
	assign leds[2] = speedData[0] & ~speedData[1]; // moving right
	assign leds[3] = shootData; // shooting
	
	// TEST POSITION COORDINATE UPDATE
	//wire readingPos;
	//assign readingPos = (~FDIns[31] & ~FDIns[30] & ~FDIns[29] & ~FDIns[28] & ~FDIns[27]) & (~FDIns[21] & ~FDIns[20] & ~FDIns[19] & ~FDIns[18] & FDIns[17]);
	// CONNECT RD wire to reading pos wires
	assign readingPos = ((~MWIns[31] & ~MWIns[30] & ~MWIns[29] & ~MWIns[28] & ~MWIns[27]) | (~MWIns[31] & ~MWIns[30] & MWIns[29] & ~MWIns[28] & MWIns[27])) & (~MWIns[26] & ~MWIns[25] & ~MWIns[24] & ~MWIns[23] & MWIns[22]);// RD of 1
	assign readingPlayerY = ((~MWIns[31] & ~MWIns[30] & ~MWIns[29] & ~MWIns[28] & ~MWIns[27]) | (~MWIns[31] & ~MWIns[30] & MWIns[29] & ~MWIns[28] & MWIns[27])) & (MWIns[26] & ~MWIns[25] & MWIns[24] & ~MWIns[23] & MWIns[22]);// RD of 21
	assign readingBulletX = ((~MWIns[31] & ~MWIns[30] & ~MWIns[29] & ~MWIns[28] & ~MWIns[27]) | (~MWIns[31] & ~MWIns[30] & MWIns[29] & ~MWIns[28] & MWIns[27])) & (~MWIns[26] & ~MWIns[25] & ~MWIns[24] & MWIns[23] & MWIns[22]); // RD of 3
	assign readingBulletY = ((~MWIns[31] & ~MWIns[30] & ~MWIns[29] & ~MWIns[28] & ~MWIns[27]) | (~MWIns[31] & ~MWIns[30] & MWIns[29] & ~MWIns[28] & MWIns[27])) & (~MWIns[26] & ~MWIns[25] & MWIns[24] & ~MWIns[23] & ~MWIns[22]); // RD of 4
	//assign readingEnemyX = 1'b0; // TO DO!
	assign readingEnemyX = ((~MWIns[31] & ~MWIns[30] & ~MWIns[29] & ~MWIns[28] & ~MWIns[27]) | (~MWIns[31] & ~MWIns[30] & MWIns[29] & ~MWIns[28] & MWIns[27])) & (~MWIns[26] & MWIns[25] & ~MWIns[24] & MWIns[23] & MWIns[22]); // RD of 11
	//assign readingEnemyY = 1'b0; // TO DO!
	assign readingEnemyY = ((~MWIns[31] & ~MWIns[30] & ~MWIns[29] & ~MWIns[28] & ~MWIns[27]) | (~MWIns[31] & ~MWIns[30] & MWIns[29] & ~MWIns[28] & MWIns[27])) & (~MWIns[26] & MWIns[25] & MWIns[24] & ~MWIns[23] & MWIns[22]);// RD of 13
	
	assign readingScore = (~MWIns[31] & ~MWIns[30] & MWIns[29] & ~MWIns[28] & MWIns[27]) & (MWIns[26] & MWIns[25] & ~MWIns[24] & MWIns[23] & ~MWIns[22]); // RD of 26
	
	
	assign readingEnemyBulletX = ((~MWIns[31] & ~MWIns[30] & ~MWIns[29] & ~MWIns[28] & ~MWIns[27]) | (~MWIns[31] & ~MWIns[30] & MWIns[29] & ~MWIns[28] & MWIns[27])) & (~MWIns[26] & MWIns[25] & MWIns[24] & MWIns[23] & ~MWIns[22]); // RD of 14
	assign readingEnemyBulletY = ((~MWIns[31] & ~MWIns[30] & ~MWIns[29] & ~MWIns[28] & ~MWIns[27]) | (~MWIns[31] & ~MWIns[30] & MWIns[29] & ~MWIns[28] & MWIns[27])) & (~MWIns[26] & MWIns[25] & MWIns[24] & MWIns[23] & MWIns[22]); // RD of 15
	
	myDFFE latchPos0(RS1Val[0], clock, reset, readingPos, leds[5]);
	myDFFE latchPos1(RS1Val[1], clock, reset, readingPos, leds[6]);
	myDFFE latchPos2(RS1Val[2], clock, reset, readingPos, leds[7]);

	//assign readingingBulletX = (~FDIns[31] & ~FDIns[30] & ~FDIns[29] & ~FDIns[28] & ~FDIns[27]) & (~FDIns[21] & ~FDIns[20] & ~FDIns[19] & ~FDIns[18] & FDIns[17]);
	
	
	//assign leds[5] = RS1Val[0];
	//assign leds[6] = RS1Val[1];
	//assign leds[7] = RS1Val[2];
	
	
	
	//////////////////////////////////////
	////// THIS IS REQUIRED FOR GRADING
	// CHANGE THIS TO ASSIGN YOUR DMEM WRITE ADDRESS ALSO TO debug_addr
	//assign debug_addr = (12'b000000000001);
	// CHANGE THIS TO ASSIGN YOUR DMEM DATA INPUT (TO BE WRITTEN) ALSO TO debug_data
	
	assign debug_data = MemDataBypass ? RegWriteData : XMRS2Val; // TO-DO : Need to consider multDiv also
	//assign debug
	////////////////////////////////////////////////////////////
	
		
	// You'll need to change where the dmem and imem read and write...
	
	//Try inverted clock or permanently high?
	// Positive clock to enable same-cycle write & read
	dmem mydmem(	.address	(debug_addr),
					.clock		(clock),
					//.clock	(1'b1),
					.data		(debug_data),
					.wren		(memWE),
					.q			(memRead) // change where output q goes...
	);
	
	imem myimem(.address			(iMemAddr),
					.clken		(1'b1),
					.clock		(clock),
					.q				(inst),
	); 
	
endmodule

module ALU(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;
   output [31:0] data_result;
   output isNotEqual, isLessThan;
	output overflow;
	
	wire[31:0] adderInput2;
	wire[31:0] adderVal;
	wire cout;
	wire[31:0] andVal;
	wire[31:0] orVal;
	wire[31:0] shiftVal;
	//wire overflow;
	wire isZero;
	
	// Decide whether to invert 2nd operand
	twoOneMux invertOrNot(data_operandB, ~data_operandB, ctrl_ALUopcode[0], adderInput2); 
	// Feed LSB of ctrl_ALUopcode into c0 of CLAdder
	CLAdder myAdder(ctrl_ALUopcode[0], data_operandA, adderInput2, adderVal, overflow, isZero);
	assign andVal = data_operandA & data_operandB;
	assign orVal = data_operandA | data_operandB;
	barrelShifter myShifter(data_operandA, ~ctrl_ALUopcode[0], ctrl_shiftamt, shiftVal);
	eightOneMux outputMX(adderVal, adderVal, andVal, orVal, shiftVal, shiftVal, 32'bz, 32'bz, ctrl_ALUopcode, data_result);
	//notEqual NEQ(adderVal, isNotEqual);
	assign isNotEqual = ~isZero;
	//assign isLessThan = adderVal[31];
	assign isLessThan = adderVal[31] ^ overflow;
endmodule

/***
module CLAdder(c0, a, b, sum, overflow, isZero);
	input c0;
	input [31:0] a, b;
	output [31:0] sum;
	output overflow;
	output isZero;
	wire firstZero;
	wire secondZero;
	wire thirdZero;
	wire fourthZero;
	wire c8, c16, c24;	
	wire G0, P0, P0C0, Cout0;
	wire G1, P1, P1C1, Cout1;
	wire G2, P2, P2C2, Cout2;
	wire G3, P3, P3C3, Cout3;
	wire cout;
	wire [2:0] miniOverflows;
	// Bits 7-0
	eightBitCLA bits07(c0, a[7:0], b[7:0], sum[7:0], G0, P0, miniOverflows[0], firstZero);
	and and0(P0C0, P0, c0);
	or or0(c8, P0C0, G0);
	
	// Bits 15-8
	eightBitCLA bits815(c8, a[15:8], b[15:8], sum[15:8], G1, P1, miniOverflows[1], secondZero);
	and and1(P1C1, P1, c8);
	or or1(c16, P1C1, G1);
	
	// Bits 23-16
	eightBitCLA bits1623(c16, a[23:16], b[23:16], sum[23:16], G2, P2, miniOverflows[2], thirdZero);
	and and2(P2C2, P2, c16);
	or or2(c24, P2C2, G2);
	
	// Bits 31-24
	eightBitCLA bits2431(c24, a[31:24], b[31:24], sum[31:24], G3, P3, overflow, fourthZero);
	and and3(P3C3, P3, c24);
	or or3(cout, P3C3, G3);
	
	assign isZero = firstZero & secondZero & thirdZero & fourthZero;
	
endmodule
module eightBitCLA(c0, a, b, sum, G, P, overflow, isZero);
	
	input [7:0] a, b;
	input c0;
	output [7:0] sum;
	output G, P, overflow;
	output isZero;
	wire [6:0] miniOverflows;
	
	wire c1, c2, c3, c4, c5, c6, c7;
	wire gen0, prop0, carryprop0, cout0;
	wire gen1, prop1, carryprop1, cout1;
	wire gen2, prop2, carryprop2, cout2;
	wire gen3, prop3, carryprop3, cout3;
	wire gen4, prop4, carryprop4, cout4;
	wire gen5, prop5, carryprop5, cout5;
	wire gen6, prop6, carryprop6, cout6;
	wire gen7, prop7, carryprop7, cout7;
	
	wire g6p7, g5p7p6, g4p7p6p5, g3p7p6p5p4, g2p7p6p5p4p3, g1p7p6p5p4p3p2, g0p7p6p5p4p3p2p1;
	
	// Bit 0
	oneBitCLA bit0(c0, a[0], b[0], sum[0], cout0, gen0, prop0, miniOverflows[0]);
	and and0(carryprop0, prop0, c0);
	or or0(c1, carryprop0, gen0);
	
	// Bit 1
	oneBitCLA bit1(c1, a[1], b[1], sum[1], cout1, gen1, prop1, miniOverflows[1]);
	and and1(carryprop1, prop1, c1);
	or or1(c2, carryprop1, gen1);
	
	// Bit 2
	oneBitCLA bit2(c2, a[2], b[2], sum[2], cout2, gen2, prop2, miniOverflows[2]);
	and and2(carryprop2, prop2, c2);
	or or2(c3, carryprop2, gen2);
	
	// Bit 3
	oneBitCLA bit3(c3, a[3], b[3], sum[3], cout3, gen3, prop3, miniOverflows[3]);
	and and3(carryprop3, prop3, c3);
	or or3(c4, carryprop3, gen3);
	
	// Bit 4
	oneBitCLA bit4(c4, a[4], b[4], sum[4], cout4, gen4, prop4, miniOverflows[4]);
	and and4(carryprop4, prop4, c4);
	or or4(c5, carryprop4, gen4);
	
	// Bit 5
	oneBitCLA bit5(c5, a[5], b[5], sum[5], cout5, gen5, prop5, miniOverflows[5]);
	and and5(carryprop5, prop5, c5);
	or or5(c6, carryprop5, gen5);
	
	// Bit 6
	oneBitCLA bit6(c6, a[6], b[6], sum[6], cout6, gen6, prop6, miniOverflows[6]);
	and and6(carryprop6, prop6, c6);
	or or6(c7, carryprop6, gen6);
	
	// Bit 7
	oneBitCLA bit7(c7, a[7], b[7], sum[7], cout7, gen7, prop7, overflow);
	
	// For G & P to next block
	and and7(g6p7, gen6, prop7);
	and and8(g5p7p6, gen5, prop7, prop6);
	and and9(g4p7p6p5, gen4, prop7, prop6, prop5);
	and and10(g3p7p6p5p4, gen3, prop7, prop6, prop5, prop4);
	and and11(g2p7p6p5p4p3, gen2, prop7, prop6, prop5, prop4, prop3);
	and and12(g1p7p6p5p4p3p2, gen1, prop7, prop6, prop5, prop4, prop3, prop2);
	and and13(g0p7p6p5p4p3p2p1, gen0, prop7, prop6, prop5, prop4, prop3, prop2, prop1);
	and and14(P, prop7, prop6, prop5, prop4, prop3, prop2, prop1, prop0); // Block-Level Propagate
	
	or or7(G, gen7, g6p7, g5p7p6, g4p7p6p5, g3p7p6p5p4, g2p7p6p5p4p3, g1p7p6p5p4p3p2, g0p7p6p5p4p3p2p1);
			
	assign isZero = ~(sum[0] | sum[1] | sum[2] | sum[3] | sum[4] | sum[5] | sum[6] | sum[7]);
	
endmodule
module oneBitCLA(c0, a, b, sum, cout, gen, prop, overflow);
	input a;
	input b;
	input c0;
	output sum;
	output cout;
	output gen;
	output prop;
	output overflow;
	wire axorb;
	wire carryprop;
	xor xor0(sum, a, b, c0);
	and and0(gen, a, b);
	or or0(prop, a, b);
	and and1(carryprop, prop, c0);
	or or1(cout, gen, carryprop);
	xor xor1(overflow, c0, cout);
endmodule
module eightOneMux(in1, in2, in3, in4, in5, in6, in7, in8, sel, out);
	input [31:0] in1;
	input [31:0] in2;
	input [31:0] in3;
	input [31:0] in4;
	input [31:0] in5;
	input [31:0] in6;
	input [31:0] in7;
	input [31:0] in8;
	input [2:0] sel;
	output [31:0] out;
	
	wire[31:0] out1;
	wire[31:0] out2;
	
	fourOneMux layer1(in1, in3, in5, in7, sel[2:1], out1);
	fourOneMux layer2(in2, in4, in6, in8, sel[2:1], out2);	
	twoOneMux final(out1, out2, sel[0], out);
	
endmodule
module fourOneMux(in1, in2, in3, in4, sel, out);
	input [31:0] in1;
	input [31:0] in2;
	input [31:0] in3;
	input [31:0] in4;
	input [1:0] sel;
	output [31:0] out;
	
	wire [31:0] out1;
	wire [31:0] out2;
	
	twoOneMux firstTwo(in1, in3, sel[1], out1);
	twoOneMux nextTwo(in2, in4, sel[1], out2);	
	twoOneMux best(out1, out2, sel[0], out);
	
endmodule
	
module notEqual(in, out);
	input [31:0] in;
	output out;
	
	wire w0, w1, w2, w3;
	or or0(w0, in[0], in[1], in[2], in[3], in[4], in[5],  in[6],  in[7]);
	or or1(w1, in[8], in[9], in[10], in[11], in[12], in[13],  in[14],  in[15]);
	or or2(w2, in[16], in[17], in[18], in[19], in[20], in[21],  in[22],  in[23]);
	or or3(w3, in[24], in[25], in[26], in[27], in[28], in[29],  in[30],  in[31]);
	or or4(out, w0, w1, w2, w3);
endmodule
module oneBitCLA(c0, a, b, sum, cout, gen, prop);
	input a;
	input b;
	input c0;
	output sum;
	output cout;
	output gen;
	output prop;
	wire axorb;
	wire carryprop;
	xor xor0(sum, a, b, c0);
	and and0(gen, a, b);
	or or0(prop, a, b);
	and and1(carryprop, prop, c0);
	or or1(cout, gen, carryprop);	
endmodule
***/

module barrelShifter(in, mode, shamt, shiftVal);
	input [31:0] in;
	input [4:0] shamt;
	input mode;
	output [31:0] shiftVal;
	
	wire [31:0] block1, block2, block3, block4;
	
	shiftBlock shift16(in, mode, shamt[4], 5'b10000, block1);
	shiftBlock shift8(block1, mode, shamt[3], 5'b01000, block2);
	shiftBlock shift4(block2, mode, shamt[2], 5'b00100, block3);
	shiftBlock shift2(block3, mode, shamt[1], 5'b00010, block4);
	shiftBlock shift1(block4, mode, shamt[0], 5'b00001, shiftVal);
	
endmodule


module shiftBlock(dataIn, mode, sel, amt, out);
	input [31:0] dataIn;
	input sel, mode;
	input [4:0] amt;
	output [31:0] out;
	
	wire [31:0] left;
	//wire [31:0] right;
	wire [62:0] right;
	wire [62:0] shiftedRight;
	wire [31:0] finalRight;
	
	assign right[31:0] = dataIn;
	assign right[62:32] = dataIn[31] ? {31{1'b1}} : {31{1'b0}};
	
	assign left = sel ? dataIn << amt : dataIn;
	assign shiftedRight = sel ? right >> amt : right;
	
	assign finalRight = shiftedRight[31:0];
	
	assign out = mode ? left : finalRight;

endmodule
/***
module twoOneMux(in1, in2, sel, out);
	input [31:0] in1;
	input [31:0] in2;
	input sel;
	output [31:0] out;
	
	assign out = sel? in2 : in1;
	
endmodule
***/		


module branchPredictor(clock, reset, FDOpcode, FDPC, DXOpcode, taken, RD, chosen, prediction, wasTaken);
	input clock, reset, taken;
	input [4:0] FDOpcode, DXOpcode, RD;
	input [31:0] FDPC, chosen;
	output wasTaken; // Represents whether latest branch instruction was taken, latches for 1 cycle
	output [31:0] prediction;
	
	wire WE, RE;
	wire [4:0] RS;
	wire shouldTake;
	wire [31:0] RDVal, RSVal;
	
	//assign FDOpcode = FDIns[31:27];
	assign RS = FDPC[4:0];
	
	// Write Enable if Branch is being Evaluated => DX.IR.OP == BNE, BLT OR BEX : {00010, 00110, 10110}
	assign WE = (~DXOpcode[4] & ~DXOpcode[3] & DXOpcode[1] & ~DXOpcode[0]) | (DXOpcode[4] & ~DXOpcode[3] & DXOpcode[2] & DXOpcode[1] & ~DXOpcode[0]);
	assign RE = (~FDOpcode[4] & ~FDOpcode[3] & FDOpcode[1] & ~FDOpcode[0]) | (FDOpcode[4] & ~FDOpcode[3] & FDOpcode[2] & FDOpcode[1] & ~FDOpcode[0]);
	assign RDVal = chosen;
	assign prediction = shouldTake ? RSVal : FDPC;

	satCounterFile satCounters(taken, clock, WE, reset, RD, RS, shouldTake);
	regfileModified branchTargets(clock, WE & taken, reset, RD, RS, RDVal, RSVal);
	
	//myDFFE lastDecision(shouldTake, clock, reset, RE, wasTaken); // Latch until next branch?
	myDFFE lastDecision(shouldTake & RE, clock, reset, 1'b1, wasTaken); // Latch for 1 instruction 
endmodule


module bypassControl(DXIns, XMIns, MWIns, ALUIn1Bypass, ALUIn2Bypass, MemDataBypass, XMRS2ValBypass);
	//DEPRECATED : THIS IS FROM FD, WRONG!input RDUsed // 0 if  RS2Val corresponds to RT, 1 if RD
	input [31:0] DXIns, XMIns, MWIns;
	
	output [1:0] ALUIn1Bypass, ALUIn2Bypass;
	// FOR PROJECT - EXTRA BYPASS ROUTE FROM IOReg to ALU for MX bypass
	//output [2:0] ALUIn1Bypass, ALUIn2Bypass;
	
	output MemDataBypass, XMRS2ValBypass;
	
	wire sameRDm, sameRDw;
	wire sameRSm, sameRSw;
	wire sameRTm, sameRTw;
	
	wire RDUsed;
	//output RDUsed;
	
	wire RTUsed;
	
	wire [4:0] DXopcode, XMopcode, MWopcode;
	wire [4:0] storeOpcode;
	wire xmChangesRD;
	wire mwChangesRD;
	wire dxIsStore;
	wire xmIsStore;
	wire mwIsStore;
	wire checkMemDataBypass;
	
	assign DXopcode = DXIns[31:27];
	assign XMopcode = XMIns[31:27];
	assign MWopcode = MWIns[31:27];
	
	assign storeOpcode = 5'b00111;
	// TO-DO : NEED TO CONSIDER WB PIPELINE REG OF MULT/DIV AS WELL!
	
	FiveBitEquals checkDXOp(DXopcode, storeOpcode, dxIsStore);
	FiveBitEquals checkXMOp(XMopcode, storeOpcode, xmIsStore);
	FiveBitEquals checkMWOp(MWopcode, storeOpcode, mwIsStore);
	
	
	/***
	// 01 => MX Bypass
	FiveBitEquals MXALUIn1(DXIns[21:17], XMIns[26:22], ALUIn1Bypass[0]);
	FiveBitEquals MXALUIn2(DXIns[16:12], XMIns[26:22], ALUIn2Bypass[0]);
	// 10 => WX Bypass
	FiveBitEquals WXALUIn1(DXIns[21:17], MWIns[26:22], ALUIn1Bypass[1]);
	FiveBitEquals WXALUIn2(DXIns[16:12], MWIns[26:22], ALUIn2Bypass[1]);
	
	// 1 => WM Bypass
	FiveBitEquals WM(XMIns[26:22], MWIns[26:22], MemDataBypass);
	***/
	
	// If XMIns is not bne, blt, jr or sw, then it changes its RD
	// Check that it is not any of {00010, 00100, 00110, 00111}	
	// Also check that RD is not 0 (Edge case since JAL has RD of 0 due to its implicit target)
	
	// UPDATE : REMOVE STORE FROM RDUsed, since it doesn't go into ALU and it's dealt separately
	//assign RDUsed = (~DXopcode[4] & ~DXopcode[3] & ~DXopcode[2] & DXopcode[1] & ~DXopcode[0]) | (~DXopcode[4] & ~DXopcode[3] & DXopcode[2] & ~DXopcode[1] & ~DXopcode[0]) | (~DXopcode[4] & ~DXopcode[3] & DXopcode[2] & DXopcode[1]);
	assign RDUsed = (~DXopcode[4] & ~DXopcode[3] & ~DXopcode[2] & DXopcode[1] & ~DXopcode[0]) | (~DXopcode[4] & ~DXopcode[3] & DXopcode[2] & ~DXopcode[1] & ~DXopcode[0]) | (~DXopcode[4] & ~DXopcode[3] & DXopcode[2] & DXopcode[1] & ~DXopcode[0]);	
	
	assign RTUsed = (~DXopcode[4] & ~DXopcode[3] & ~DXopcode[2] & ~DXopcode[1] & ~DXopcode[0]); // LAZY : INCLUDE SHIFT AS WELL FOR NOW
	// MX Bypass (DON'T INCLUDE THE IO{11000, 11001} instructions)
	assign xmChangesRD = ~((~XMopcode[4] & ~XMopcode[3] & ~XMopcode[2] & XMopcode[1] & ~XMopcode[0]) | (~XMopcode[4] & ~XMopcode[3] & XMopcode[2] & ~XMopcode[0]) | (~XMopcode[4] & ~XMopcode[3] & XMopcode[2] & XMopcode[1] & XMopcode[0]) | (XMopcode[4] & XMopcode[3] & ~XMopcode[2] & ~XMopcode[1])) & ((XMIns[26] | XMIns[25] | XMIns[24] | XMIns[23] | XMIns[22]));
	
	FiveBitEquals checkRDm(DXIns[26:22], XMIns[26:22], sameRDm);
	FiveBitEquals checkRSm(DXIns[21:17], XMIns[26:22], sameRSm);
	FiveBitEquals checkRTm(DXIns[16:12], XMIns[26:22], sameRTm);
	
	assign ALUIn1Bypass[0] = sameRSm & ~xmIsStore & xmChangesRD;
	assign ALUIn2Bypass[0] = ((sameRTm & RTUsed) | (sameRDm & RDUsed)) & ~xmIsStore & xmChangesRD;
	
	// WX Bypass
	assign mwChangesRD = ~((~MWopcode[4] & ~MWopcode[3] & ~MWopcode[2] & MWopcode[1] & ~MWopcode[0]) | (~MWopcode[4] & ~MWopcode[3] & MWopcode[2] & ~MWopcode[0]) | (~MWopcode[4] & ~MWopcode[3] & MWopcode[2] & MWopcode[1] & MWopcode[0])) & ((MWIns[26] | MWIns[25] | MWIns[24] | MWIns[23] | MWIns[22]));
	
	FiveBitEquals checkRDw(DXIns[26:22], MWIns[26:22], sameRDw);
	FiveBitEquals checkRSw(DXIns[21:17], MWIns[26:22], sameRSw);
	FiveBitEquals checkRTw(DXIns[16:12], MWIns[26:22], sameRTw);
	
	assign ALUIn1Bypass[1] = sameRSw & ~mwIsStore & mwChangesRD;
	//assign ALUIn2Bypass[1] = (sameRTw & ~RDUsed) | (sameRDw & RDUsed);
	assign ALUIn2Bypass[1] = ((sameRTw & RTUsed) | (sameRDw & RDUsed)) & ~mwIsStore & mwChangesRD;	
		
	// 1 => WX Bypass into XMRS2Val (Don't need to consider MX bypass into XMRS2Val?)
	assign XMRS2ValBypass = sameRDw & dxIsStore & mwChangesRD;
	
	
	// 1 => WM Bypass
	FiveBitEquals WM(XMIns[26:22], MWIns[26:22], checkMemDataBypass);
	
	assign MemDataBypass = checkMemDataBypass & mwChangesRD;
	
	
endmodule

module control(FDIns, DXIns, XMIns, MWIns, multDivResultRDY, multDivException, multDivRD, RegWE, ALUOpB, memWE, RS2Sel, RD, ALUOpcode, RegWriteD, nextPC, BNE, BLT, BEX, statusEnable, finalSTATUS, hasPrediction, must_update); // isBranch
	input [31:0] MWIns;
	//input [4:0] FDopcode, DXopcode, XMopcode;
	input [31:0] FDIns, DXIns, XMIns;
	input [4:0] multDivRD;
	input multDivResultRDY, multDivException;
	output RegWE, ALUOpB, memWE, RS2Sel, BNE, BLT, BEX; //isBranch
	//output [1:0] RegWriteD;
	output [2:0] RegWriteD; // Extra source of data for RDVal from inputControl
	output [1:0] nextPC;
	output [4:0] RD;
	output [4:0] ALUOpcode;
	

	
	output statusEnable; // Modify to allow clockAdapter to write to it
	//output [31:0] newSTATUS, hasPrediction; // newSTATUS will be 32'd1 if must_update
	output [31:0] finalSTATUS, hasPrediction; // newSTATUS will be 32'd1 if must_update
	input must_update;
	
	wire [31:0] newSTATUS;
	
	wire [4:0] FDopcode, DXopcode, XMopcode;
	assign FDopcode = FDIns[31:27];
	assign DXopcode = DXIns[31:27];
	assign XMopcode = XMIns[31:27];
	
	
	wire [4:0] MWopcode;
	assign MWopcode = MWIns[31:27];
	
	// {00101, 00111, 01000}
	assign ALUOpB = (~DXopcode[4] & ~DXopcode[3] & DXopcode[2] & DXopcode[0]) | (~DXopcode[4] & DXopcode[3] & ~DXopcode[2] & ~DXopcode[1] & ~DXopcode[0]);
	
	// {00000, 00101, 01000} in MWopcode for non mult-div R type
	// Any non-zero value in multDivOpcode for mult-div
	// JAL : 00011
	// FOR PROJECT : INCLUDE I/O instruction getSpeed (11000) and getShoot (11001)
	assign RegWE = (~MWopcode[4] & ~MWopcode[3] & ~MWopcode[2] & ~MWopcode[1] & ~MWopcode[0]) | (~MWopcode[4] & ~MWopcode[3] & MWopcode[2] & ~MWopcode[1] & MWopcode[0]) | (~MWopcode[4] & MWopcode[3] & ~MWopcode[2] & ~MWopcode[1] & ~MWopcode[0]) | RegWriteD[1] | (~MWopcode[4] & ~MWopcode[3] & ~MWopcode[2] & MWopcode[1] & MWopcode[0]) | (MWopcode[4] & MWopcode[3] & ~MWopcode[2] & ~MWopcode[1]);
	
	/*** WRONG, JUMP LOOKS AT FD! NOT MW!
	// 01 : {00001, 00011}; 10 : {00100}
	assign nextPC[0] = (~MWopcode[4] & ~MWopcode[3] & ~MWopcode[2] & ~MWopcode[1] & MWopcode[0]) | (~MWopcode[4] & ~MWopcode[3] & ~MWopcode[2] & MWopcode[1] & MWopcode[0]);
	assign nextPC[1] = ~MWopcode[4] & ~MWopcode[3] & MWopcode[2] & ~MWopcode[1] & ~MWopcode[0];
	***/
	// 01 : {00001, 00011}; 10 : {00100}
	assign nextPC[0] = (~FDopcode[4] & ~FDopcode[3] & ~FDopcode[2] & ~FDopcode[1] & FDopcode[0]) | (~FDopcode[4] & ~FDopcode[3] & ~FDopcode[2] & FDopcode[1] & FDopcode[0]);
	assign nextPC[1] = ~FDopcode[4] & ~FDopcode[3] & FDopcode[2] & ~FDopcode[1] & ~FDopcode[0];
	
	
	// {00010, 00110, 10110} DEPRECATED, EACH BRANCH HAS DIFFERENT CONDITION
	//assign isBranch = (~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & ~opcode[0]) | (~opcode[3] & opcode[2] & opcode[1] & ~opcode[0]);
	assign BNE = (~DXopcode[4] & ~DXopcode[3] & ~DXopcode[2] & DXopcode[1] & ~DXopcode[0]);
	assign BLT = (~DXopcode[4] & ~DXopcode[3] & DXopcode[2] & DXopcode[1] & ~DXopcode[0]);
	assign BEX = (DXopcode[4] & ~DXopcode[3] & DXopcode[2] & DXopcode[1] & ~DXopcode[0]);
	
	// {00111}
	assign memWE = (~XMopcode[4] & ~XMopcode[3] & XMopcode[2] & XMopcode[1] & XMopcode[0]);
	
	// 01 : {01000}; 10 : {opcode 00000 & ALUOpcode 0011x}, 11 : {00011} for JAL to choose PC + 1, 101: choose shootData
	assign RegWriteD[0] = (~MWopcode[4] & MWopcode[3] & ~MWopcode[2] & ~MWopcode[1] & ~MWopcode[0]) | (~MWopcode[4] & ~MWopcode[3] & ~MWopcode[2] & MWopcode[1] & MWopcode[0]) | (MWopcode[4] & MWopcode[3] & ~MWopcode[2] & ~MWopcode[1] & MWopcode[0]);
	//assign RegWriteD[1] = (~MWopcode[4] & ~MWopcode[3] & ~MWopcode[2] & ~MWopcode[1] & ~MWopcode[0]) & (~MWALUOpcode[4] & ~MWALUOpcode[3] & MWALUOpcode[2] & MWALUOpcode[1]);
	// As long as the writeback register of multDiv is not all zeros, should choose its output
	//assign RegWriteD[1] = (multDivIns[31] | multDivIns[30] | multDivIns[29] | multDivIns[28] | multDivIns[27]) | (~MWopcode[4] & ~MWopcode[3] & ~MWopcode[2] & MWopcode[1] & MWopcode[0]);
	
	assign RegWriteD[1] = multDivResultRDY | (~MWopcode[4] & ~MWopcode[3] & ~MWopcode[2] & MWopcode[1] & MWopcode[0]);
	//assign RegWriteD[1] = (~MWopcode[4] & ~MWopcode[3] & ~MWopcode[2] & MWopcode[1] & MWopcode[0]);
	
	// FOR PROJECT : 1xx : choose value from inputControl, for getSpeed (11000) and getShoot(11001) instructions
	assign RegWriteD[2] = (MWopcode[4] & MWopcode[3] & ~MWopcode[2] & ~MWopcode[1]);
	
	
	/*** DEPRECATED : jal handled with RegWE, RegWriteD, RD and nextPC[1] signals
	// {00011}
	assign writeRA = (~MWopcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0]);	
	***/
	
	// {00010, 00100, 00110, 00111}
	assign RS2Sel = (~FDopcode[4] & ~FDopcode[3] & ~FDopcode[2] & FDopcode[1] & ~FDopcode[0]) | (~FDopcode[4] & ~FDopcode[3] & FDopcode[2] & ~FDopcode[1] & ~FDopcode[0]) | (~FDopcode[4] & ~FDopcode[3] & FDopcode[2] & FDopcode[1]);
	
	// Read RD from Writeback, either MW or multDivOpcode (instruction of multDivWB)
	// If MWOpcode is jal, then RD = 31 and RegWriteD = PC + 1
	//assign RD = RegWriteD[1] ? multDivIns[26:22] : MWIns[26:22];
	wire [1:0] RDSel;
	assign RDSel[0] = RegWriteD[1];
	assign RDSel[1] = (~MWopcode[4] & ~MWopcode[3] & ~MWopcode[2] & MWopcode[1] & MWopcode[0]);
	fourOneMux5 RDSelector(MWIns[26:22], MWIns[26:22], multDivRD, {5{1'b1}}, RDSel, RD);
	
	// ALUOpcode : For R-type instructions, just DXIns[6:2]
	// For I-type instructions, add : {00111, 01000}; sub : {00010, 00110}
	wire [4:0] RtypeOpcode;
	wire [4:0] ItypeOpcode;
	
	assign RtypeOpcode = DXIns[6:2];
	assign ItypeOpcode[4:1] = {4{1'b0}};
	assign ItypeOpcode[0] = ~DXopcode[4] & ~DXopcode[3] & DXopcode[1] & ~DXopcode[0];
	assign ALUOpcode = (~DXopcode[4] & ~DXopcode[3] & ~DXopcode[2] & ~DXopcode[1] & ~DXopcode[0]) ? RtypeOpcode : ItypeOpcode;
	
	// Status enable only if setx in FD Reg OR multDivResultRDY (to write in exception)
	wire [31:0] setXStatus;
	wire [31:0] multDivStatus;
	wire settingX;
	assign settingX = FDopcode[4] & ~FDopcode[3] & FDopcode[2] & ~FDopcode[1] & FDopcode[0];
	assign setXStatus[26:0] = FDIns[26:0];
	assign setXStatus[31:27] = {5{1'b0}};
	assign multDivStatus[31:1] = {30{1'b0}};
	assign multDivStatus[0] = multDivException;
	
	wire [31:0] ioINTERRUPT;
	assign ioINTERRUPT = {32{1'b1}};
	//assign statusEnable = settingX | multDivException;
	// MODIFY TO INCLUDE HARDWARE INTERRUPT FROM I/O
	assign statusEnable = settingX | multDivException | must_update;
	assign newSTATUS = settingX ? setXStatus : multDivStatus;	// If setX and multDiv try to write status at same time, priority given to setX since it is most recent
	assign finalSTATUS = must_update ? ioINTERRUPT : newSTATUS; // HIGHEST PRIORITY TO HARDWARE INTERRUPT!
	// If FDOpcode is Branch, then hasPrediction
	assign hasPrediction = (~FDopcode[4] & ~FDopcode[3] & FDopcode[1] & ~FDopcode[0]) | (FDopcode[4] & ~FDopcode[3] & FDopcode[2] & FDopcode[1] & ~FDopcode[0]);
		
endmodule


module twoOneMux5(in1, in2, sel, out);
	input [4:0] in1;
	input [4:0] in2;
	input sel;
	output [4:0] out;	
	assign out = sel? in2 : in1;
endmodule
	
module fourOneMux12(in1, in2, in3, in4, sel, out);
	input [11:0] in1;
	input [11:0] in2;
	input [11:0] in3;
	input [11:0] in4;
	input [1:0] sel;
	output [11:0] out;
	
	wire [11:0] out1;
	wire [11:0] out2;
	
	twoOneMux firstTwo(in1, in3, sel[1], out1);
	twoOneMux nextTwo(in2, in4, sel[1], out2);	
	twoOneMux best(out1, out2, sel[0], out);
	
endmodule


module fourOneMux5(in1, in2, in3, in4, sel, out);
	input [4:0] in1;
	input [4:0] in2;
	input [4:0] in3;
	input [4:0] in4;
	input [1:0] sel;
	output [4:0] out;
	
	wire [4:0] out1;
	wire [4:0] out2;
	
	twoOneMux firstTwo(in1, in3, sel[1], out1);
	twoOneMux nextTwo(in2, in4, sel[1], out2);	
	twoOneMux best(out1, out2, sel[0], out);
	
endmodule 

	
module FiveBitEquals(in1, in2, out);
	input [4:0] in1, in2;
	output out;
	
	wire w0, w1, w2, w3, w4;
	
	xor xor0(w0, in1[0], in2[0]);
	xor xor1(w1, in1[1], in2[1]);
	xor xor2(w2, in1[2], in2[2]);
	xor xor3(w3, in1[3], in2[3]);
	xor xor4(w4, in1[4], in2[4]);
	nor result(out, w0, w1, w2, w3, w4);

endmodule

/******************************************************************************
 *                                                                            *
 * Module:       Hexadecimal_To_Seven_Segment                                 *
 * Description:                                                               *
 *      This module converts hexadecimal numbers for seven segment displays.  *
 *                                                                            *
 ******************************************************************************/

module Hexadecimal_To_Seven_Segment (
	// Inputs
	hex_number,

	// Bidirectional

	// Outputs
	seven_seg_display
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input		[3:0]	hex_number;

// Bidirectional

// Outputs
output		[6:0]	seven_seg_display;

/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/
// Internal Wires

// Internal Registers

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/


/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

assign seven_seg_display =
		({7{(hex_number == 4'h0)}} & 7'b1000000) |
		({7{(hex_number == 4'h1)}} & 7'b1111001) |
		({7{(hex_number == 4'h2)}} & 7'b0100100) |
		({7{(hex_number == 4'h3)}} & 7'b0110000) |
		({7{(hex_number == 4'h4)}} & 7'b0011001) |
		({7{(hex_number == 4'h5)}} & 7'b0010010) |
		({7{(hex_number == 4'h6)}} & 7'b0000010) |
		({7{(hex_number == 4'h7)}} & 7'b1111000) |
		({7{(hex_number == 4'h8)}} & 7'b0000000) |
		({7{(hex_number == 4'h9)}} & 7'b0010000) |
		({7{(hex_number == 4'hA)}} & 7'b0001000) |
		({7{(hex_number == 4'hB)}} & 7'b0000011) |
		({7{(hex_number == 4'hC)}} & 7'b1000110) |
		({7{(hex_number == 4'hD)}} & 7'b0100001) |
		({7{(hex_number == 4'hE)}} & 7'b0000110) |
		({7{(hex_number == 4'hF)}} & 7'b0001110); 

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/


endmodule

module jrBypass(FDIns, DXIns, XMIns, MWIns, jrSel);
	input [31:0] FDIns, DXIns, XMIns, MWIns;
	output [1:0] jrSel;
	
	wire [4:0] jrOpcode;
	wire [4:0] jalOpcode;
	
	wire [4:0] FDOpcode, DXOpcode, XMOpcode, MWOpcode;
	wire fdIsJr, dxIsJal, xmIsJal, mwIsJal;
	
	assign jrOpcode = 5'b00100;
	assign jalOpcode = 5'b00011;
	
	assign FDOpcode = FDIns[31:27];
	assign DXOpcode = DXIns[31:27];
	assign XMOpcode = XMIns[31:27];
	assign MWOpcode = MWIns[31:27];
	
	FiveBitEquals checkFD(jrOpcode, FDOpcode, fdIsJr);
	FiveBitEquals checkDX(jalOpcode, DXOpcode, dxIsJal);
	FiveBitEquals checkXM(jalOpcode, XMOpcode, xmIsJal);
	FiveBitEquals checkMW(jalOpcode, MWOpcode, mwIsJal);
	
	// 01 : DXPC; 10 : XMPC; 11 : MWPC; 
	assign jrSel[0] = fdIsJr & (dxIsJal | mwIsJal);
	assign jrSel[1] = fdIsJr & (xmIsJal | mwIsJal);

endmodule

module multDivControl(clock, ins, opA, opB, reset, result, writeReg, resultRDY, inputRDY, exception);
	input [31:0] ins; // Used to decipher whether mult or div and to figure RD
	input [31:0] opA, opB;
	input clock, reset;
	output [31:0] result;
	output [4:0] writeReg;
	output resultRDY, inputRDY, exception; // If multDiv is not inputRDY and new multDiv ins arrives,
										 // need to stall for structural hazard
	//output mult, div; // REMEMBER TO CHANGE BACK TO WIRE
	
	//wire [7:0] RDs [4:0]; // When pipelining multDiv
	wire [4:0] RD; // Must latch
	wire [4:0] op; 
	wire mult, div;
	assign op = ins[6:2];
	assign RD = ins[26:22];
	
	wire isRType;
	assign isRType = (~ins[31] & ~ins[30] & ~ins[29] & ~ins[28] & ~ins[27]);
	assign mult = (~op[4] & ~op[3] & op[2] & op[1] & ~op[0]) & isRType;
	assign div = (~op[4] & ~op[3] & op[2] & op[1] & op[0]) & isRType;
	
	
	wire [4:0] currentRD; // Latched version of RD
	wire [31:0] currentOpA, currentOpB; // Latched version of opA and opB
	
	// Need to latch value of mult/div with DFF
	/***
	wire multInProgress, oldOrNewMult, nextMult;
	wire divInProgress, oldOrNewDiv, nextDiv;
	***/
	
	wire multInProgress, divInProgress;
	//output multInProgress, divInProgress;
	
	/***
	assign oldOrNewMult = multInProgress | mult;
	assign nextMult = ~multRDY & oldOrNewMult;
	***/
	myDFFE latchMult(mult, clock, reset, mult | resultRDY, multInProgress);
	myDFFE latchDiv(div, clock, reset, div | resultRDY, divInProgress);
	
	// Latch RD - Invert its clock since it is reading mult | div which change on posEdge
	Register5 RDLatch(~clock, mult | div | inputRDY, RD, reset, currentRD);
	assign writeReg = currentRD;
	// Latch opA & opB
	assign currentOpA = opA; // Check if it works without latching
	assign currentOpB = opB;
	
	
	multDiv multDiv0(currentOpA, currentOpB, multInProgress, divInProgress, clock, result, exception, inputRDY, resultRDY);

endmodule

module multDivStalls(FDIns, XMIns, RDUsed, resultRDY, inputRDY, multDivRD, dataStructStall, warStall);
	input [31:0] FDIns, XMIns;
	input RDUsed, resultRDY, inputRDY;
	input [4:0] multDivRD; // When pipelined, change to input[7:0] multRDs [4:0]
	output [1:0] dataStructStall;
	output warStall;
	
	
	wire isRegZero;
	
	FiveBitEquals checkZero(multDivRD, {5{1'b0}}, isRegZero); // If multDivRD is 00000, then no multDiv is actually happening
	
	wire [4:0] RS, RT, RD;
	assign RS = FDIns[21:17];
	assign RT = FDIns[16:12];
	assign RD = FDIns[26:22];
	
	wire sameRS, sameRT, sameRD;
	wire dataHazard, structHazard, warHazard;
	
	// 01 => Data Hazard - Check FDIns, multRDs and multResultRDY
	FiveBitEquals checkRS(RS, multDivRD, sameRS);
	FiveBitEquals checkRT(RT, multDivRD, sameRT);
	FiveBitEquals checkRD(RD, multDivRD, sameRD);
	
	assign dataHazard = (sameRS | (sameRT & ~RDUsed) | (sameRD & RDUsed)) & ~resultRDY & ~inputRDY & ~isRegZero;
	
	// 10 => Structural Hazard - Check FDIns and multInputRDY
	wire FDisMultDiv;
	wire [4:0] op;
	assign op = FDIns[6:2];
	assign FDisMultDiv = ~op[4] & ~op[3] & op[2] & op[1];
	assign structHazard = FDisMultDiv & ~inputRDY & ~isRegZero;
	
	// 11 => WAR Hazard - Check XMIns, multRDs and multResultRDY
	wire [4:0] XMRD;
	wire sameWriteDest;
	assign XMRD = XMIns[26:22];
	FiveBitEquals checkXMRD(XMRD, multDivRD, sameWriteDest);
	assign warHazard = sameWriteDest & ~resultRDY & ~isRegZero & ~inputRDY; // Might be unstable for half a clock-cycle

	assign dataStructStall[0] = dataHazard;
	assign dataStructStall[1] = structHazard;
	
	assign warStall = warHazard;
	
endmodule

module FDReg(clock, enable, reset, nextInst, nextPC, Inst, PC);
	input clock, enable, reset;
	input [31:0] nextInst;
	//input [11:0] nextPC;
	input [31:0] nextPC;
	output [31:0] Inst;
	//output [11:0] PC;
	output [31:0] PC;
	
	//wire [31:0] nextPC32, PC32;
	//assign nextPC32[11:0] = nextPC;
	//assign nextPC32[31:12] = {20{1'b0}};
	//assign PC32[11:0] = PC;
	//assign PC32[31:12] = {20{1'b0}};
	
	Register32 PCReg(clock, enable, nextPC, reset, PC);
	//Register12 PCReg(clock, enable, nextPC, reset, PC);
	Register32 InsReg(clock, enable, nextInst, reset, Inst);
	
	//assign PC = PC32[11:0];
	
endmodule


module DXReg(clock, enable, reset, nextInst, nextPC, nextRS1Val, nextRS2Val, Inst, PC, RS1Val, RS2Val);
	input clock, enable, reset;
	input [31:0] nextInst, nextRS1Val, nextRS2Val;
	//input [11:0] nextPC;
	input [31:0] nextPC;
	output [31:0] Inst, RS1Val, RS2Val;
	//output [11:0] PC;
	output [31:0] PC;
	
	//wire [31:0] nextPC32, PC32;
	//assign nextPC32[11:0] = nextPC;
	//assign nextPC32[31:12] = {20{1'b0}};
	//assign PC32[11:0] = PC;
	//assign PC32[31:12] = {20{1'b0}};

	
	Register32 PCReg(clock, enable, nextPC, reset, PC);
	//Register12 PCReg(clock, enable, nextPC, reset, PC);
	Register32 RS1Reg(clock, enable, nextRS1Val, reset, RS1Val);
	Register32 RS2Reg(clock, enable, nextRS2Val, reset, RS2Val);
	Register32 InsReg(clock, enable, nextInst, reset, Inst);
	
	//assign PC = PC32[11:0];
	
endmodule

	
module XMReg(clock, enable, reset, nextInst, nextPC, nextALUOutput, nextRD, Inst, PC, ALUOutput, RD);
	input clock, enable, reset;
	//input [11:0] nextPC;
	input [31:0] nextPC;
	input [31:0] nextInst, nextALUOutput, nextRD;
	//output [11:0] PC;
	output [31:0] PC;
	output [31:0] Inst, ALUOutput, RD;
	
	//Register12 PCReg(clock, enable, nextPC, reset, PC);
	Register32 PCReg(clock, enable, nextPC, reset, PC);
	Register32 ALUReg(clock, enable, nextALUOutput, reset, ALUOutput);
	Register32 RDReg(clock, enable, nextRD, reset, RD);
	Register32 InsReg(clock, enable, nextInst, reset, Inst);

endmodule

	
module MWReg(clock, enable, reset, nextInst, nextPC, nextALUOutput, nextMemData, Inst, PC, ALUOutput, MemData);
	input clock, enable, reset;
	//input [11:0] nextPC;
	input [31:0] nextPC;
	input [31:0] nextInst, nextALUOutput, nextMemData;
	//output [11:0] PC;
	output [31:0] PC;
	output [31:0] Inst, ALUOutput, MemData;
	
	//Register12 PCReg(clock, enable, nextPC, reset, PC);
	Register32 PCReg(clock, enable, nextPC, reset, PC);
	Register32 ALUReg(clock, enable, nextALUOutput, reset, ALUOutput);
	Register32 MemReg(clock, enable, nextMemData, reset, MemData);
	Register32 InsReg(clock, enable, nextInst, reset, Inst);

endmodule

// megafunction wizard: %ALTPLL%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altpll 

// ============================================================
// File Name: pll.v
// Megafunction Name(s):
// 			altpll
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 9.1 Build 350 03/24/2010 SP 2 SJ Web Edition
// ************************************************************


//Copyright (C) 1991-2010 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module pll (
	inclk0,
	c0);

	input	  inclk0;
	output	  c0;

	wire [5:0] sub_wire0;
	wire [0:0] sub_wire4 = 1'h0;
	wire [0:0] sub_wire1 = sub_wire0[0:0];
	wire  c0 = sub_wire1;
	wire  sub_wire2 = inclk0;
	wire [1:0] sub_wire3 = {sub_wire4, sub_wire2};

	altpll	altpll_component (
				.inclk (sub_wire3),
				.clk (sub_wire0),
				.activeclock (),
				.areset (1'b0),
				.clkbad (),
				.clkena ({6{1'b1}}),
				.clkloss (),
				.clkswitch (1'b0),
				.configupdate (1'b0),
				.enable0 (),
				.enable1 (),
				.extclk (),
				.extclkena ({4{1'b1}}),
				.fbin (1'b1),
				.fbmimicbidir (),
				.fbout (),
				.fref (),
				.icdrclk (),
				.locked (),
				.pfdena (1'b1),
				.phasecounterselect ({4{1'b1}}),
				.phasedone (),
				.phasestep (1'b1),
				.phaseupdown (1'b1),
				.pllena (1'b1),
				.scanaclr (1'b0),
				.scanclk (1'b0),
				.scanclkena (1'b1),
				.scandata (1'b0),
				.scandataout (),
				.scandone (),
				.scanread (1'b0),
				.scanwrite (1'b0),
				.sclkout0 (),
				.sclkout1 (),
				.vcooverrange (),
				.vcounderrange ());
	defparam
		altpll_component.clk0_divide_by = 5,
		altpll_component.clk0_duty_cycle = 50,
		altpll_component.clk0_multiply_by = 2,
		altpll_component.clk0_phase_shift = "0",
		altpll_component.compensate_clock = "CLK0",
		altpll_component.inclk0_input_frequency = 20000,
		//altpll_component.intended_device_family = "Cyclone IV",
		altpll_component.lpm_hint = "CBX_MODULE_PREFIX=pll",
		altpll_component.lpm_type = "altpll",
		altpll_component.operation_mode = "NORMAL",
		altpll_component.port_activeclock = "PORT_UNUSED",
		altpll_component.port_areset = "PORT_UNUSED",
		altpll_component.port_clkbad0 = "PORT_UNUSED",
		altpll_component.port_clkbad1 = "PORT_UNUSED",
		altpll_component.port_clkloss = "PORT_UNUSED",
		altpll_component.port_clkswitch = "PORT_UNUSED",
		altpll_component.port_configupdate = "PORT_UNUSED",
		altpll_component.port_fbin = "PORT_UNUSED",
		altpll_component.port_inclk0 = "PORT_USED",
		altpll_component.port_inclk1 = "PORT_UNUSED",
		altpll_component.port_locked = "PORT_UNUSED",
		altpll_component.port_pfdena = "PORT_UNUSED",
		altpll_component.port_phasecounterselect = "PORT_UNUSED",
		altpll_component.port_phasedone = "PORT_UNUSED",
		altpll_component.port_phasestep = "PORT_UNUSED",
		altpll_component.port_phaseupdown = "PORT_UNUSED",
		altpll_component.port_pllena = "PORT_UNUSED",
		altpll_component.port_scanaclr = "PORT_UNUSED",
		altpll_component.port_scanclk = "PORT_UNUSED",
		altpll_component.port_scanclkena = "PORT_UNUSED",
		altpll_component.port_scandata = "PORT_UNUSED",
		altpll_component.port_scandataout = "PORT_UNUSED",
		altpll_component.port_scandone = "PORT_UNUSED",
		altpll_component.port_scanread = "PORT_UNUSED",
		altpll_component.port_scanwrite = "PORT_UNUSED",
		altpll_component.port_clk0 = "PORT_USED",
		altpll_component.port_clk1 = "PORT_UNUSED",
		altpll_component.port_clk2 = "PORT_UNUSED",
		altpll_component.port_clk3 = "PORT_UNUSED",
		altpll_component.port_clk4 = "PORT_UNUSED",
		altpll_component.port_clk5 = "PORT_UNUSED",
		altpll_component.port_clkena0 = "PORT_UNUSED",
		altpll_component.port_clkena1 = "PORT_UNUSED",
		altpll_component.port_clkena2 = "PORT_UNUSED",
		altpll_component.port_clkena3 = "PORT_UNUSED",
		altpll_component.port_clkena4 = "PORT_UNUSED",
		altpll_component.port_clkena5 = "PORT_UNUSED",
		altpll_component.port_extclk0 = "PORT_UNUSED",
		altpll_component.port_extclk1 = "PORT_UNUSED",
		altpll_component.port_extclk2 = "PORT_UNUSED",
		altpll_component.port_extclk3 = "PORT_UNUSED";


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ACTIVECLK_CHECK STRING "0"
// Retrieval info: PRIVATE: BANDWIDTH STRING "1.000"
// Retrieval info: PRIVATE: BANDWIDTH_FEATURE_ENABLED STRING "0"
// Retrieval info: PRIVATE: BANDWIDTH_FREQ_UNIT STRING "MHz"
// Retrieval info: PRIVATE: BANDWIDTH_PRESET STRING "Low"
// Retrieval info: PRIVATE: BANDWIDTH_USE_AUTO STRING "1"
// Retrieval info: PRIVATE: BANDWIDTH_USE_CUSTOM STRING "0"
// Retrieval info: PRIVATE: BANDWIDTH_USE_PRESET STRING "0"
// Retrieval info: PRIVATE: CLKBAD_SWITCHOVER_CHECK STRING "0"
// Retrieval info: PRIVATE: CLKLOSS_CHECK STRING "0"
// Retrieval info: PRIVATE: CLKSWITCH_CHECK STRING "1"
// Retrieval info: PRIVATE: CNX_NO_COMPENSATE_RADIO STRING "0"
// Retrieval info: PRIVATE: CREATE_CLKBAD_CHECK STRING "0"
// Retrieval info: PRIVATE: CREATE_INCLK1_CHECK STRING "0"
// Retrieval info: PRIVATE: CUR_DEDICATED_CLK STRING "c0"
// Retrieval info: PRIVATE: CUR_FBIN_CLK STRING "e0"
// Retrieval info: PRIVATE: DEVICE_SPEED_GRADE STRING "6"
// Retrieval info: PRIVATE: DIV_FACTOR0 NUMERIC "1"
// Retrieval info: PRIVATE: DUTY_CYCLE0 STRING "50.00000000"
// Retrieval info: PRIVATE: EFF_OUTPUT_FREQ_VALUE0 STRING "20.000000"
// Retrieval info: PRIVATE: EXPLICIT_SWITCHOVER_COUNTER STRING "0"
// Retrieval info: PRIVATE: EXT_FEEDBACK_RADIO STRING "0"
// Retrieval info: PRIVATE: GLOCKED_COUNTER_EDIT_CHANGED STRING "1"
// Retrieval info: PRIVATE: GLOCKED_FEATURE_ENABLED STRING "1"
// Retrieval info: PRIVATE: GLOCKED_MODE_CHECK STRING "0"
// Retrieval info: PRIVATE: GLOCK_COUNTER_EDIT NUMERIC "1048575"
// Retrieval info: PRIVATE: HAS_MANUAL_SWITCHOVER STRING "1"
// Retrieval info: PRIVATE: INCLK0_FREQ_EDIT STRING "50.000"
// Retrieval info: PRIVATE: INCLK0_FREQ_UNIT_COMBO STRING "MHz"
// Retrieval info: PRIVATE: INCLK1_FREQ_EDIT STRING "100.000"
// Retrieval info: PRIVATE: INCLK1_FREQ_EDIT_CHANGED STRING "1"
// Retrieval info: PRIVATE: INCLK1_FREQ_UNIT_CHANGED STRING "1"
// Retrieval info: PRIVATE: INCLK1_FREQ_UNIT_COMBO STRING "MHz"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: PRIVATE: INT_FEEDBACK__MODE_RADIO STRING "1"
// Retrieval info: PRIVATE: LOCKED_OUTPUT_CHECK STRING "0"
// Retrieval info: PRIVATE: LONG_SCAN_RADIO STRING "1"
// Retrieval info: PRIVATE: LVDS_MODE_DATA_RATE STRING "300.000"
// Retrieval info: PRIVATE: LVDS_MODE_DATA_RATE_DIRTY NUMERIC "0"
// Retrieval info: PRIVATE: LVDS_PHASE_SHIFT_UNIT0 STRING "deg"
// Retrieval info: PRIVATE: MIG_DEVICE_SPEED_GRADE STRING "Any"
// Retrieval info: PRIVATE: MIRROR_CLK0 STRING "0"
// Retrieval info: PRIVATE: MULT_FACTOR0 NUMERIC "1"
// Retrieval info: PRIVATE: NORMAL_MODE_RADIO STRING "1"
// Retrieval info: PRIVATE: OUTPUT_FREQ0 STRING "20.00000000"
// Retrieval info: PRIVATE: OUTPUT_FREQ_MODE0 STRING "1"
// Retrieval info: PRIVATE: OUTPUT_FREQ_UNIT0 STRING "MHz"
// Retrieval info: PRIVATE: PHASE_RECONFIG_FEATURE_ENABLED STRING "0"
// Retrieval info: PRIVATE: PHASE_RECONFIG_INPUTS_CHECK STRING "0"
// Retrieval info: PRIVATE: PHASE_SHIFT0 STRING "0.00000000"
// Retrieval info: PRIVATE: PHASE_SHIFT_STEP_ENABLED_CHECK STRING "0"
// Retrieval info: PRIVATE: PHASE_SHIFT_UNIT0 STRING "deg"
// Retrieval info: PRIVATE: PLL_ADVANCED_PARAM_CHECK STRING "0"
// Retrieval info: PRIVATE: PLL_ARESET_CHECK STRING "0"
// Retrieval info: PRIVATE: PLL_AUTOPLL_CHECK NUMERIC "1"
// Retrieval info: PRIVATE: PLL_ENA_CHECK STRING "0"
// Retrieval info: PRIVATE: PLL_ENHPLL_CHECK NUMERIC "0"
// Retrieval info: PRIVATE: PLL_FASTPLL_CHECK NUMERIC "0"
// Retrieval info: PRIVATE: PLL_FBMIMIC_CHECK STRING "0"
// Retrieval info: PRIVATE: PLL_LVDS_PLL_CHECK NUMERIC "0"
// Retrieval info: PRIVATE: PLL_PFDENA_CHECK STRING "0"
// Retrieval info: PRIVATE: PLL_TARGET_HARCOPY_CHECK NUMERIC "0"
// Retrieval info: PRIVATE: PRIMARY_CLK_COMBO STRING "inclk0"
// Retrieval info: PRIVATE: RECONFIG_FILE STRING "pll.mif"
// Retrieval info: PRIVATE: SACN_INPUTS_CHECK STRING "0"
// Retrieval info: PRIVATE: SCAN_FEATURE_ENABLED STRING "0"
// Retrieval info: PRIVATE: SELF_RESET_LOCK_LOSS STRING "0"
// Retrieval info: PRIVATE: SHORT_SCAN_RADIO STRING "0"
// Retrieval info: PRIVATE: SPREAD_FEATURE_ENABLED STRING "0"
// Retrieval info: PRIVATE: SPREAD_FREQ STRING "50.000"
// Retrieval info: PRIVATE: SPREAD_FREQ_UNIT STRING "KHz"
// Retrieval info: PRIVATE: SPREAD_PERCENT STRING "0.500"
// Retrieval info: PRIVATE: SPREAD_USE STRING "0"
// Retrieval info: PRIVATE: SRC_SYNCH_COMP_RADIO STRING "0"
// Retrieval info: PRIVATE: STICKY_CLK0 STRING "1"
// Retrieval info: PRIVATE: SWITCHOVER_COUNT_EDIT NUMERIC "1"
// Retrieval info: PRIVATE: SWITCHOVER_FEATURE_ENABLED STRING "1"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: USE_CLK0 STRING "1"
// Retrieval info: PRIVATE: USE_CLKENA0 STRING "0"
// Retrieval info: PRIVATE: USE_MIL_SPEED_GRADE NUMERIC "0"
// Retrieval info: PRIVATE: ZERO_DELAY_RADIO STRING "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: CLK0_DIVIDE_BY NUMERIC "5"
// Retrieval info: CONSTANT: CLK0_DUTY_CYCLE NUMERIC "50"
// Retrieval info: CONSTANT: CLK0_MULTIPLY_BY NUMERIC "2"
// Retrieval info: CONSTANT: CLK0_PHASE_SHIFT STRING "0"
// Retrieval info: CONSTANT: COMPENSATE_CLOCK STRING "CLK0"
// Retrieval info: CONSTANT: INCLK0_INPUT_FREQUENCY NUMERIC "20000"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altpll"
// Retrieval info: CONSTANT: OPERATION_MODE STRING "NORMAL"
// Retrieval info: CONSTANT: PORT_ACTIVECLOCK STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_ARESET STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_CLKBAD0 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_CLKBAD1 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_CLKLOSS STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_CLKSWITCH STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_CONFIGUPDATE STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_FBIN STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_INCLK0 STRING "PORT_USED"
// Retrieval info: CONSTANT: PORT_INCLK1 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_LOCKED STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_PFDENA STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_PHASECOUNTERSELECT STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_PHASEDONE STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_PHASESTEP STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_PHASEUPDOWN STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_PLLENA STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_SCANACLR STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_SCANCLK STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_SCANCLKENA STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_SCANDATA STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_SCANDATAOUT STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_SCANDONE STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_SCANREAD STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_SCANWRITE STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_clk0 STRING "PORT_USED"
// Retrieval info: CONSTANT: PORT_clk1 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_clk2 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_clk3 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_clk4 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_clk5 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_clkena0 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_clkena1 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_clkena2 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_clkena3 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_clkena4 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_clkena5 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_extclk0 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_extclk1 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_extclk2 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_extclk3 STRING "PORT_UNUSED"
// Retrieval info: USED_PORT: @clk 0 0 6 0 OUTPUT_CLK_EXT VCC "@clk[5..0]"
// Retrieval info: USED_PORT: @extclk 0 0 4 0 OUTPUT_CLK_EXT VCC "@extclk[3..0]"
// Retrieval info: USED_PORT: c0 0 0 0 0 OUTPUT_CLK_EXT VCC "c0"
// Retrieval info: USED_PORT: inclk0 0 0 0 0 INPUT_CLK_EXT GND "inclk0"
// Retrieval info: CONNECT: @inclk 0 0 1 0 inclk0 0 0 0 0
// Retrieval info: CONNECT: c0 0 0 0 0 @clk 0 0 1 0
// Retrieval info: CONNECT: @inclk 0 0 1 1 GND 0 0 0 0
// Retrieval info: GEN_FILE: TYPE_NORMAL pll.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL pll.ppf TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL pll.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL pll.cmp TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL pll.bsf TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL pll_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL pll_bb.v FALSE
// Retrieval info: LIB_FILE: altera_mf
// Retrieval info: CBX_MODULE_PREFIX: ON

/*****************************************************************************
 *                                                                           *
 * Module:       Altera_UP_PS2                                               *
 * Description:                                                              *
 *      This module communicates with the PS2 core.                          *
 *                                                                           *
 *****************************************************************************/

module PS2_Controller #(parameter INITIALIZE_MOUSE = 0) (
	// Inputs
	CLOCK_50,
	reset,

	the_command,
	send_command,

	// Bidirectionals
	PS2_CLK,					// PS2 Clock
 	PS2_DAT,					// PS2 Data

	// Outputs
	command_was_sent,
	error_communication_timed_out,

	received_data,
	received_data_en			// If 1 - new data has been received
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input			CLOCK_50;
input			reset;

input	[7:0]	the_command;
input			send_command;

// Bidirectionals
inout			PS2_CLK;
inout		 	PS2_DAT;

// Outputs
output			command_was_sent;
output			error_communication_timed_out;

output	[7:0]	received_data;
output		 	received_data_en;

wire [7:0] the_command_w;
wire send_command_w, command_was_sent_w, error_communication_timed_out_w;

generate
	if(INITIALIZE_MOUSE) begin
  		reg init_done;
	  		
		assign the_command_w = init_done ? the_command : 8'hf4;
		assign send_command_w = init_done ? send_command : (!command_was_sent_w && !error_communication_timed_out_w);
		assign command_was_sent = init_done ? command_was_sent_w : 0;
		assign error_communication_timed_out = init_done ? error_communication_timed_out_w : 1;
		

		
		always @(posedge CLOCK_50)
			if(reset) init_done <= 0;
			else if(command_was_sent_w) init_done <= 1;
		
	end else begin
		assign the_command_w = the_command;
		assign send_command_w = send_command;
		assign command_was_sent = command_was_sent_w;
		assign error_communication_timed_out = error_communication_timed_out_w;
	end
endgenerate

/*****************************************************************************
 *                           Constant Declarations                           *
 *****************************************************************************/
// states
localparam	PS2_STATE_0_IDLE			= 3'h0,
			PS2_STATE_1_DATA_IN			= 3'h1,
			PS2_STATE_2_COMMAND_OUT		= 3'h2,
			PS2_STATE_3_END_TRANSFER	= 3'h3,
			PS2_STATE_4_END_DELAYED		= 3'h4;

/*****************************************************************************
 *                 Internal wires and registers Declarations                 *
 *****************************************************************************/
// Internal Wires
wire			ps2_clk_posedge;
wire			ps2_clk_negedge;

wire			start_receiving_data;
wire			wait_for_incoming_data;

// Internal Registers
reg		[7:0]	idle_counter;

reg				ps2_clk_reg;
reg				ps2_data_reg;
reg				last_ps2_clk;

// State Machine Registers
reg		[2:0]	ns_ps2_transceiver;
reg		[2:0]	s_ps2_transceiver;

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/

always @(posedge CLOCK_50)
begin
	if (reset == 1'b1)
		s_ps2_transceiver <= PS2_STATE_0_IDLE;
	else
		s_ps2_transceiver <= ns_ps2_transceiver;
end

always @(*)
begin
	// Defaults
	ns_ps2_transceiver = PS2_STATE_0_IDLE;

    case (s_ps2_transceiver)
	PS2_STATE_0_IDLE:
		begin
			if ((idle_counter == 8'hFF) && 
					(send_command == 1'b1))
				ns_ps2_transceiver = PS2_STATE_2_COMMAND_OUT;
			else if ((ps2_data_reg == 1'b0) && (ps2_clk_posedge == 1'b1))
				ns_ps2_transceiver = PS2_STATE_1_DATA_IN;
			else
				ns_ps2_transceiver = PS2_STATE_0_IDLE;
		end
	PS2_STATE_1_DATA_IN:
		begin
			if ((received_data_en == 1'b1)/* && (ps2_clk_posedge == 1'b1)*/)
				ns_ps2_transceiver = PS2_STATE_0_IDLE;
			else
				ns_ps2_transceiver = PS2_STATE_1_DATA_IN;
		end
	PS2_STATE_2_COMMAND_OUT:
		begin
			if ((command_was_sent == 1'b1) ||
				(error_communication_timed_out == 1'b1))
				ns_ps2_transceiver = PS2_STATE_3_END_TRANSFER;
			else
				ns_ps2_transceiver = PS2_STATE_2_COMMAND_OUT;
		end
	PS2_STATE_3_END_TRANSFER:
		begin
			if (send_command == 1'b0)
				ns_ps2_transceiver = PS2_STATE_0_IDLE;
			else if ((ps2_data_reg == 1'b0) && (ps2_clk_posedge == 1'b1))
				ns_ps2_transceiver = PS2_STATE_4_END_DELAYED;
			else
				ns_ps2_transceiver = PS2_STATE_3_END_TRANSFER;
		end
	PS2_STATE_4_END_DELAYED:	
		begin
			if (received_data_en == 1'b1)
			begin
				if (send_command == 1'b0)
					ns_ps2_transceiver = PS2_STATE_0_IDLE;
				else
					ns_ps2_transceiver = PS2_STATE_3_END_TRANSFER;
			end
			else
				ns_ps2_transceiver = PS2_STATE_4_END_DELAYED;
		end	
	default:
			ns_ps2_transceiver = PS2_STATE_0_IDLE;
	endcase
end

/*****************************************************************************
 *                             Sequential logic                              *
 *****************************************************************************/

always @(posedge CLOCK_50)
begin
	if (reset == 1'b1)
	begin
		last_ps2_clk	<= 1'b1;
		ps2_clk_reg		<= 1'b1;

		ps2_data_reg	<= 1'b1;
	end
	else
	begin
		last_ps2_clk	<= ps2_clk_reg;
		ps2_clk_reg		<= PS2_CLK;

		ps2_data_reg	<= PS2_DAT;
	end
end

always @(posedge CLOCK_50)
begin
	if (reset == 1'b1)
		idle_counter <= 6'h00;
	else if ((s_ps2_transceiver == PS2_STATE_0_IDLE) &&
			(idle_counter != 8'hFF))
		idle_counter <= idle_counter + 6'h01;
	else if (s_ps2_transceiver != PS2_STATE_0_IDLE)
		idle_counter <= 6'h00;
end

/*****************************************************************************
 *                            Combinational logic                            *
 *****************************************************************************/

assign ps2_clk_posedge = 
			((ps2_clk_reg == 1'b1) && (last_ps2_clk == 1'b0)) ? 1'b1 : 1'b0;
assign ps2_clk_negedge = 
			((ps2_clk_reg == 1'b0) && (last_ps2_clk == 1'b1)) ? 1'b1 : 1'b0;

assign start_receiving_data		= (s_ps2_transceiver == PS2_STATE_1_DATA_IN);
assign wait_for_incoming_data	= 
			(s_ps2_transceiver == PS2_STATE_3_END_TRANSFER);

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

Altera_UP_PS2_Data_In PS2_Data_In (
	// Inputs
	.clk							(CLOCK_50),
	.reset							(reset),

	.wait_for_incoming_data			(wait_for_incoming_data),
	.start_receiving_data			(start_receiving_data),

	.ps2_clk_posedge				(ps2_clk_posedge),
	.ps2_clk_negedge				(ps2_clk_negedge),
	.ps2_data						(ps2_data_reg),

	// Bidirectionals

	// Outputs
	.received_data					(received_data),
	.received_data_en				(received_data_en)
);

Altera_UP_PS2_Command_Out PS2_Command_Out (
	// Inputs
	.clk							(CLOCK_50),
	.reset							(reset),

	.the_command					(the_command_w),
	.send_command					(send_command_w),

	.ps2_clk_posedge				(ps2_clk_posedge),
	.ps2_clk_negedge				(ps2_clk_negedge),

	// Bidirectionals
	.PS2_CLK						(PS2_CLK),
 	.PS2_DAT						(PS2_DAT),

	// Outputs
	.command_was_sent				(command_was_sent_w),
	.error_communication_timed_out	(error_communication_timed_out_w)
);

endmodule


module PS2_Interface(inclock, resetn, ps2_clock, ps2_data, ps2_key_data, ps2_key_pressed, last_data_received);

	input 			inclock, resetn;
	inout 			ps2_clock, ps2_data;
	output 			ps2_key_pressed;
	output 	[7:0] 	ps2_key_data;
	output 	[7:0] 	last_data_received;

	// Internal Registers
	reg			[7:0]	last_data_received;	
	
	always @(posedge inclock)
	begin
		if (resetn == 1'b0)
			last_data_received <= 8'h00;
		else if (ps2_key_pressed == 1'b1)
			last_data_received <= ps2_key_data;
	end
	
	PS2_Controller PS2 (.CLOCK_50 			(inclock),
						.reset 				(~resetn),
						.PS2_CLK			(ps2_clock),
						.PS2_DAT			(ps2_data),		
						.received_data		(ps2_key_data),
						.received_data_en	(ps2_key_pressed)
						);

endmodule

module multDiv(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_inputRDY, data_resultRDY);
   input [31:0] data_operandA;
   input [15:0] data_operandB;
   input ctrl_MULT, ctrl_DIV, clock;             
   output [31:0] data_result; 
   output data_exception, data_inputRDY, data_resultRDY;

	//output multEnable;
	//output divEnable;
	
	wire multEnable;
	wire divEnable;
	wire [31:0] mult_result;
	wire [31:0] div_result;
	wire mult_exception, mult_inputRDY, mult_resultRDY, div_exception, div_inputRDY, div_resultRDY;
	wire nextMultEnable;
	wire nextDivEnable;
	
	wire multEnabled;
	//output multEnabled;
	wire prevMultEnabled;
	//output prevMultEnabled;
	wire prevMultEnabled2;
	//output prevMultEnabled2;
	wire prevMultEnabled3;
	//output prevMultEnabled3;
	
	wire divEnabled;
	//output divEnabled;
	wire prevDivEnabled;
	//output prevDivEnabled;
	wire prevDivEnabled2;
	//output prevDivEnabled2;
	wire prevDivEnabled3;
	//output prevDivEnabled3;


	
	assign nextMultEnable = multEnabled | ctrl_MULT | prevMultEnabled | prevMultEnabled2 | prevMultEnabled3;
	assign nextDivEnable = divEnabled | ctrl_DIV | prevDivEnabled | prevDivEnabled2 | prevDivEnabled3;
	
	myDFFE catchMultEnable(.d(ctrl_MULT), .clk(~clock), .clrn(1'b1), .ena(1'b1), .q(prevMultEnabled));
	//DFFE multEnabler(nextMultEnable, clock, ~ctrl_DIV, ~ctrl_MULT, 1'b1, multEnable);
	//DFFE multEnabler(.d(nextMultEnable), .clk(clock), .clrn(~ctrl_DIV), .ena(1'b1), .q(multEnable));
	myDFFE catchMultEnable2(.d(prevMultEnabled), .clk(clock), .clrn(1'b1), .ena(1'b1), .q(prevMultEnabled2));
	myDFFE catchMultEnable3(.d(prevMultEnabled2), .clk(~clock), .clrn(1'b1), .ena(1'b1), .q(prevMultEnabled3));
	
	myDFFE multEnabler(.d(nextMultEnable), .clk(clock), .clrn(~ctrl_DIV), .ena(1'b1), .q(multEnabled));
	//DFFE divEnabler(nextDivEnable, clock, ~ctrl_MULT, ~ctrl_DIV, 1'b1, divEnable);
	//DFFE divEnabler(.d(nextDivEnable), .clk(clock), .clrn(~ctrl_MULT), .ena(1'b1), .q(divEnable));
	myDFFE catchDivEnable(.d(ctrl_DIV), .clk(~clock), .clrn(1'b1), .ena(1'b1), .q(prevDivEnabled));
	myDFFE catchDivEnable2(.d(ctrl_DIV), .clk(clock), .clrn(1'b1), .ena(1'b1), .q(prevDivEnabled2));
	myDFFE catchDivEnable3(.d(ctrl_DIV), .clk(~clock), .clrn(1'b1), .ena(1'b1), .q(prevDivEnabled3));
	
	myDFFE divEnabler(.d(nextDivEnable), .clk(clock), .clrn(~ctrl_MULT), .ena(1'b1), .q(divEnabled));
	
	assign multEnable = multEnabled | ctrl_MULT | prevMultEnabled | prevMultEnabled2 | prevMultEnabled3;
	assign divEnable = divEnabled | ctrl_DIV | prevDivEnabled | prevDivEnabled2 | prevDivEnabled3;
	
	tristate32 multResultTriState(mult_result, multEnable, data_result);
	tristate multExceptionTriState(mult_exception, multEnable, data_exception);
	tristate multInputRDYTriState(mult_inputRDY, multEnable, data_inputRDY);
	tristate multOutputRDYTriState(mult_resultRDY, multEnable, data_resultRDY);

	tristate32 divResultTriState(div_result, divEnable, data_result);
	tristate divExceptionTriState(div_exception, divEnable, data_exception);
	tristate divInputRDYTriState(div_inputRDY, divEnable, data_inputRDY);
	tristate divOutputRDYTriState(div_resultRDY, divEnable, data_resultRDY);
	
	//mult multiplier(data_operandA, data_operandB, ctrl_MULT, clock, mult_result, mult_exception, mult_inputRDY, mult_resultRDY);
	//multDebug multiplier(data_operandA, data_operandB, ctrl_MULT, clock, mult_result, mult_exception, mult_inputRDY, mult_resultRDY);
	finalMult multiplier(data_operandA, data_operandB, ctrl_MULT, clock, mult_result, mult_exception, mult_inputRDY, mult_resultRDY);
	//div divider(ctrl_DIV, data_operandA, data_operandB, clock, div_result, div_exception, div_inputRDY, div_resultRDY);
	divDebug divider(ctrl_DIV, data_operandA, data_operandB, clock, div_result, div_exception, div_inputRDY, div_resultRDY);
	
endmodule

module Register16(clock, wEn, writeIn, clr, readOut);
	input clock, wEn, clr;
	input [15:0] writeIn;
	output [15:0] readOut;
	
	genvar i;
	generate
		for(i = 0; i< 16 ; i = i + 1) begin : loop1
			myDFFE dff(.d(writeIn[i]), .clk(clock), .clrn(clr), .ena(wEn), .q(readOut[i]));
		end
	endgenerate
	
endmodule



module Register17(clock, wEn, writeIn, clr, readOut);
	input clock, wEn, clr;
	input [16:0] writeIn;
	output [16:0] readOut;
	
	genvar i;
	generate
		for(i = 0; i< 17 ; i = i + 1) begin : loop1
			myDFFE dff(.d(writeIn[i]), .clk(clock), .clrn(clr), .ena(wEn), .q(readOut[i]));
		end
	endgenerate
	
endmodule
	

module Register32(clock, wEn, writeIn, clr, readOut);
	input clock, wEn, clr;
	input [31:0] writeIn;
	output [31:0] readOut;
	
	genvar i;
	generate
		for(i = 0; i< 32 ; i = i + 1) begin : loop1
			myDFFE dff(.d(writeIn[i]), .clk(clock), .clrn(clr), .ena(wEn), .q(readOut[i]));
		end
	endgenerate
	
endmodule
	

module Register33(clock, wEn, writeIn, clr, readOut);
	input clock, wEn, clr;
	input [32:0] writeIn;
	output [32:0] readOut;
	
	genvar i;
	generate
		for(i = 0; i< 33 ; i = i + 1) begin : loop1
			myDFFE dff(.d(writeIn[i]), .clk(clock), .clrn(clr), .ena(wEn), .q(readOut[i]));
		end
	endgenerate
	
endmodule
	
/***
module shiftBlock(dataIn, mode, sel, amt, out);
	input [31:0] dataIn;
	input sel, amt, mode;
	output [31:0] out;
	
	wire [31:0] left;
	wire [31:0] right;
	
	assign left = sel ? dataIn << amt : dataIn;
	assign right = sel ? dataIn >> amt : dataIn;
	assign out = mode ? left : right;
endmodule
***/

module shiftBlock17(dataIn, mode, sel, amt, out);
	input [16:0] dataIn;
	input sel, mode;
	input [1:0] amt;
	output [16:0] out;
	
	wire [16:0] left;
	wire [16:0] right;
	
	assign left = sel ? dataIn << amt : dataIn;
	assign right = sel ? dataIn >> amt : dataIn;
	assign out = mode ? left : right;

endmodule

module shiftBlock32(dataIn, mode, sel, amt, out);
	input [31:0] dataIn;
	input sel, mode;
	input [1:0] amt;
	output [31:0] out;
	
	wire [31:0] left;
	wire [31:0] right;
	
	assign left = sel ? dataIn << amt : dataIn;
	assign right = sel ? dataIn >> amt : dataIn;
	assign out = mode ? left : right;

endmodule


module shiftForDiv(divisor, shamt);
	input [15:0] divisor;
	//output [31:0] shiftedDivisor;
	output [3:0] shamt;
	
	//assign shiftedDivisor[31] = 1'b0;
	
	wire oneHas, twoHas, threeHas, fourHas, fiveHas;
	wire[31:0] firstVal, secondVal, thirdVal, fourthVal, fifthVal;
	
	wire [31:0] adder1Input, adder2Input, adder3Input, adder4Input;
	
	wire [1:0] oneVal, twoVal, threeVal, fourVal, fiveVal;
	wire firstEnable, secondEnable, thirdEnable, fourthEnable, fifthEnable;
	assign firstEnable = oneHas;
	assign secondEnable = ~oneHas & twoHas;
	assign thirdEnable = ~oneHas & ~twoHas & threeHas;
	assign fourthEnable = ~oneHas & ~twoHas & ~threeHas & fourHas;
	assign fifthEnable = ~oneHas & ~twoHas & ~threeHas & ~fourHas & fiveHas;
	
	getPrefix3 first(divisor[14:12], oneVal, oneHas);
	getPrefix3 second(divisor[11:9], twoVal, twoHas);
	getPrefix3 third(divisor[8:6], threeVal, threeHas);
	getPrefix3 fourth(divisor[5:3], fourVal, fourHas);
	getPrefix3 fifth(divisor[2:0], fiveVal, fiveHas);

	assign adder1Input[31:2] = {30{1'b0}};
	assign adder1Input[1:0] = twoVal;
	
	assign adder2Input[31:2] = {30{1'b0}};
	assign adder2Input[1:0] = threeVal;
	
	assign adder3Input[31:2] = {30{1'b0}};
	assign adder3Input[1:0] = fourVal;
	
	assign adder4Input[31:2] = {30{1'b0}};
	assign adder4Input[1:0] = fiveVal;
	
	assign firstVal[31:2] = {30{1'b0}};
	assign firstVal[1:0] = oneVal;
	CLAdder forSecond(1'b0, adder1Input, 32'd3, secondVal);
	CLAdder forThird(1'b0, adder2Input, 32'd6, thirdVal);
	CLAdder forFourth(1'b0, adder3Input, 32'd9, fourthVal);
	CLAdder forFifth(1'b0, adder4Input, 32'd12, fifthVal);
	
	tristate4 fromFirst(firstVal[3:0], firstEnable, shamt);
	tristate4 fromSecond(secondVal[3:0], secondEnable, shamt);
	tristate4 fromThird(thirdVal[3:0], thirdEnable, shamt);
	tristate4 fromFourth(fourthVal[3:0], fourthEnable, shamt);
	tristate4 fromFifth(fifthVal[3:0], fifthEnable, shamt);
	
endmodule
	

module testZero(in, out);
	input [15:0] in;
	output out;	
	wire w0, w1, w2, w3;
	or or0(w0, in[0], in[1], in[2], in[3]);
	or or1(w1, in[4], in[5], in[6], in[7]);
	or or2(w2, in[8], in[9], in[10], in[11]);
	or or3(w3, in[12], in[13], in[14], in[15]);
	nor nor0(out, w0, w1, w2, w3);
endmodule


module tristate(data, oe, out);
	input data;
	input oe;
	output out;
	assign out = oe ? data : 1'bz;
endmodule


module tristate4(data, oe, out);
	input [3:0] data;
	input oe;
	output [3:0] out;
	assign out = oe ? data : 4'bz;
endmodule

module tristate32(data, oe, out);
	input [31:0] data;
	input oe;
	output [31:0] out;
	assign out = oe ? data : {32{1'bz}};
endmodule

/***
module barrelShifter(in, mode, shamt, shiftVal);
	input [31:0] in;
	input [4:0] shamt;
	input mode;
	output [31:0] shiftVal;
	
	wire [31:0] block1, block2, block3, block4;
	
	shiftBlock shift16(in, mode, shamt[4], 16, block1);
	shiftBlock shift8(block1, mode, shamt[3], 8, block2);
	shiftBlock shift4(block2, mode, shamt[2], 4, block3);
	shiftBlock shift2(block3, mode, shamt[1], 2, block4);
	shiftBlock shift1(block4, mode, shamt[0], 1, shiftVal);
	
endmodule
***/

module CLAdder(c0, a, b, sum, overflow, isZero);
	input c0;
	input [31:0] a, b;
	output [31:0] sum;
	output overflow;
	output isZero;
	wire firstZero;
	wire secondZero;
	wire thirdZero;
	wire fourthZero;

	wire c8, c16, c24;	
	wire G0, P0, P0C0, Cout0;
	wire G1, P1, P1C1, Cout1;
	wire G2, P2, P2C2, Cout2;
	wire G3, P3, P3C3, Cout3;
	wire cout;

	wire [2:0] miniOverflows;
	// Bits 7-0
	eightBitCLA bits07(c0, a[7:0], b[7:0], sum[7:0], G0, P0, miniOverflows[0], firstZero);
	and and0(P0C0, P0, c0);
	or or0(c8, P0C0, G0);
	
	// Bits 15-8
	eightBitCLA bits815(c8, a[15:8], b[15:8], sum[15:8], G1, P1, miniOverflows[1], secondZero);
	and and1(P1C1, P1, c8);
	or or1(c16, P1C1, G1);
	
	// Bits 23-16
	eightBitCLA bits1623(c16, a[23:16], b[23:16], sum[23:16], G2, P2, miniOverflows[2], thirdZero);
	and and2(P2C2, P2, c16);
	or or2(c24, P2C2, G2);
	
	// Bits 31-24
	eightBitCLA bits2431(c24, a[31:24], b[31:24], sum[31:24], G3, P3, overflow, fourthZero);
	and and3(P3C3, P3, c24);
	or or3(cout, P3C3, G3);
	
	assign isZero = firstZero & secondZero & thirdZero & fourthZero;
	
endmodule

module eightBitCLA(c0, a, b, sum, G, P, overflow, isZero);
	
	input [7:0] a, b;
	input c0;
	output [7:0] sum;
	output G, P, overflow;
	output isZero;
	wire [6:0] miniOverflows;
	
	wire c1, c2, c3, c4, c5, c6, c7;
	wire gen0, prop0, carryprop0, cout0;
	wire gen1, prop1, carryprop1, cout1;
	wire gen2, prop2, carryprop2, cout2;
	wire gen3, prop3, carryprop3, cout3;
	wire gen4, prop4, carryprop4, cout4;
	wire gen5, prop5, carryprop5, cout5;
	wire gen6, prop6, carryprop6, cout6;
	wire gen7, prop7, carryprop7, cout7;
	
	wire g6p7, g5p7p6, g4p7p6p5, g3p7p6p5p4, g2p7p6p5p4p3, g1p7p6p5p4p3p2, g0p7p6p5p4p3p2p1;
	
	// Bit 0
	oneBitCLA bit0(c0, a[0], b[0], sum[0], cout0, gen0, prop0, miniOverflows[0]);
	and and0(carryprop0, prop0, c0);
	or or0(c1, carryprop0, gen0);
	
	// Bit 1
	oneBitCLA bit1(c1, a[1], b[1], sum[1], cout1, gen1, prop1, miniOverflows[1]);
	and and1(carryprop1, prop1, c1);
	or or1(c2, carryprop1, gen1);
	
	// Bit 2
	oneBitCLA bit2(c2, a[2], b[2], sum[2], cout2, gen2, prop2, miniOverflows[2]);
	and and2(carryprop2, prop2, c2);
	or or2(c3, carryprop2, gen2);
	
	// Bit 3
	oneBitCLA bit3(c3, a[3], b[3], sum[3], cout3, gen3, prop3, miniOverflows[3]);
	and and3(carryprop3, prop3, c3);
	or or3(c4, carryprop3, gen3);
	
	// Bit 4
	oneBitCLA bit4(c4, a[4], b[4], sum[4], cout4, gen4, prop4, miniOverflows[4]);
	and and4(carryprop4, prop4, c4);
	or or4(c5, carryprop4, gen4);
	
	// Bit 5
	oneBitCLA bit5(c5, a[5], b[5], sum[5], cout5, gen5, prop5, miniOverflows[5]);
	and and5(carryprop5, prop5, c5);
	or or5(c6, carryprop5, gen5);
	
	// Bit 6
	oneBitCLA bit6(c6, a[6], b[6], sum[6], cout6, gen6, prop6, miniOverflows[6]);
	and and6(carryprop6, prop6, c6);
	or or6(c7, carryprop6, gen6);
	
	// Bit 7
	oneBitCLA bit7(c7, a[7], b[7], sum[7], cout7, gen7, prop7, overflow);
	
	// For G & P to next block
	and and7(g6p7, gen6, prop7);
	and and8(g5p7p6, gen5, prop7, prop6);
	and and9(g4p7p6p5, gen4, prop7, prop6, prop5);
	and and10(g3p7p6p5p4, gen3, prop7, prop6, prop5, prop4);
	and and11(g2p7p6p5p4p3, gen2, prop7, prop6, prop5, prop4, prop3);
	and and12(g1p7p6p5p4p3p2, gen1, prop7, prop6, prop5, prop4, prop3, prop2);
	and and13(g0p7p6p5p4p3p2p1, gen0, prop7, prop6, prop5, prop4, prop3, prop2, prop1);
	and and14(P, prop7, prop6, prop5, prop4, prop3, prop2, prop1, prop0); // Block-Level Propagate
	
	or or7(G, gen7, g6p7, g5p7p6, g4p7p6p5, g3p7p6p5p4, g2p7p6p5p4p3, g1p7p6p5p4p3p2, g0p7p6p5p4p3p2p1);
			
	assign isZero = ~(sum[0] | sum[1] | sum[2] | sum[3] | sum[4] | sum[5] | sum[6] | sum[7]);
	
endmodule


module oneBitCLA(c0, a, b, sum, cout, gen, prop, overflow);
	input a;
	input b;
	input c0;
	output sum;
	output cout;
	output gen;
	output prop;
	output overflow;
	wire axorb;
	wire carryprop;
	xor xor0(sum, a, b, c0);
	and and0(gen, a, b);
	or or0(prop, a, b);
	and and1(carryprop, prop, c0);
	or or1(cout, gen, carryprop);
	xor xor1(overflow, c0, cout);
endmodule

module correctShift(divisor, shiftedDivisor);
	input [15:0] divisor;
	output [31:0] shiftedDivisor;
	
	wire [3:0] extraShamt;
	
	wire [4:0] shamt;
	//output [4:0] shamt;
	
	wire [31:0] extendedDivisor;
	
	wire [31:0] extraShifted;
	//output [31:0] extraShifted;
	
	assign extendedDivisor[31:16] = {16{1'b0}};
	assign extendedDivisor[15:0] = divisor;
	assign shamt[4] = 1'b0;
	assign shamt[3:0] = extraShamt;
	
	
	shiftForDiv getShamt(divisor, extraShamt);	
	//barrelShifter shiftExtra(extendedDivisor, 1'b1, shamt, extraShifted);
	assign extraShifted = extendedDivisor << shamt;
	assign shiftedDivisor = extraShifted << 16;

endmodule


module counter8(done, count, clock, reset, enable);
	input clock, reset, enable;
	output [2:0] count;
	output done;
	
	// Add extra output bit and set done to MSB if necessary
	
	wire d0, q0, d1, q1, d2, q2;
		
	assign d0 = ~q0;
	assign d1 = q1 ^ q0;
	assign d2 = (q2 & (~(q1&q0))) | (~q2 & q1 & q0);
	//assign d3 = q0 & q1 & q2;
	
	dff_e S0(d0, clock, reset, enable, q0);
	dff_e S1(d1, clock, reset, enable, q1);
	dff_e S2(d2, clock, reset, enable, q2);
	//dff_e S3(d3, clock, reset, enable, done);
	
	assign count = {q2, q1, q0};	
	assign done = q2 & q1 & q0;
	//assign done = ~d0 & ~q2 & ~q1 & ~q0;
	//assign done = q3;

endmodule


module counter9(done, count, clock, reset, enable);
	input clock, reset, enable;
	output [2:0] count;
	output done;
	
	// Add extra output bit and set done to MSB if necessary
	
	wire d0, q0, d1, q1, d2, q2, d3, q3;
		
	assign d0 = ~q0;
	assign d1 = q1 ^ q0;
	assign d2 = (q2 & (~(q1&q0))) | (~q2 & q1 & q0);
	assign d3 = q2 & q1 & q0;
	//assign d3 = q0 & q1 & q2;
	
	dff_e S0(d0, clock, reset, enable, q0);
	dff_e S1(d1, clock, reset, enable, q1);
	dff_e S2(d2, clock, reset, enable, q2);
	dff_e S3(d3, clock, reset, enable, done);
	
	assign count = {q2, q1, q0};	
	//assign done = q2 & q1 & q0;
	//assign done = ~d0 & ~q2 & ~q1 & ~q0;
	//assign done = q3;

endmodule

module counter16(done, count, clock, reset, enable);
	input clock, reset, enable;
	output [3:0] count;
	output done;
	
	
	wire d0, q0, d1, q1, d2, q2, d3, q3, d4;
		
	assign d0 = ~q0;
	assign d1 = q1 ^ q0;
	assign d2 = q2 & (~(q1&q0)) | ~q2 & q1 & q0;
	assign d3 = (q0 & q1 & q2 & ~q3) | (q3 & ~(q2 & q1 & q0));
	assign d4 = q0 & q1 & q2 & q3;
	
	dff_e S0(d0, clock, reset, enable, q0);
	dff_e S1(d1, clock, reset, enable, q1);
	dff_e S2(d2, clock, reset, enable, q2);
	dff_e S3(d3, clock, reset, enable, q3);
	dff_e S4(d4, clock, reset, enable, done);
	
	assign count = {q3, q2, q1, q0};	

endmodule



module counter32(done, count, clock, reset, enable);
	input clock, reset, enable;
	output [4:0] count;
	output done;
	
	
	wire d0, q0, d1, q1, d2, q2, d3, q3, d4, q4, d5;
		
	assign d0 = ~q0;
	assign d1 = q1 ^ q0;
	assign d2 = q2 & (~(q1&q0)) | ~q2 & q1 & q0;
	assign d3 = (q0 & q1 & q2 & ~q3) | (q3 & ~(q2 & q1 & q0));
	assign d4 = (q0 & q1 & q2 & q3 & ~q4) | (q4 & ~(q3 & q2 & q1 & q0));
	assign d5 = q0 & q1 & q2 & q3 & q4;
	
	dff_e S0(d0, clock, reset, enable, q0);
	dff_e S1(d1, clock, reset, enable, q1);
	dff_e S2(d2, clock, reset, enable, q2);
	dff_e S3(d3, clock, reset, enable, q3);
	dff_e S4(d4, clock, reset, enable, q4);
	dff_e S5(d5, clock, reset, enable, done);
	
	assign count = {q4, q3, q2, q1, q0};	

endmodule



module dff_e (d, clk, rsn, ena, q);
	// port declaration
	input   d, clk, ena, rsn;
	output  q;
	reg     q;
	always @ (posedge clk or posedge rsn) begin
		  if (rsn)
			  //assign q = 1'b0;
			  q <= 1'b0;
	//enable
		  else if (ena)
			  //assign q = d;
			  q <= d;
	end
endmodule


module divDebug(ctrl_DIV, div_operandA, div_operandB, clock, div_result, div_exception, div_inputRDY, div_resultRDY);
	input ctrl_DIV;
	input [31:0] div_operandA;
	input [15:0] div_operandB;
	input clock;
	output [31:0] div_result;
	output div_exception;
	output div_inputRDY;
	output div_resultRDY;

	wire resetDiv;
	//output resetDiv;
	//output dividend;
	//output [31:0] divisor;
	//output [31:0] dividend;
	
	
	wire isZero;
	wire isZero2;
	wire [31:0] nextResult;
	
	wire [31:0] dividend;
	//output [31:0] dividend;
	
	wire [31:0] nextDividend;
	
	wire [31:0] divisor;
	//output [31:0] divisor;
	
	wire [31:0] nextDivisor;
	
	wire overflow;
	wire overflow2;
	wire lastOverflow;
	wire resultZero;
	
	wire [31:0] orInput1;
	wire [31:0] orInput2;
	wire [31:0] flippedDivisor;
	
	wire [31:0] diff;
	//output [31:0] diff;
	
	wire [30:0] zerosBuffer;
	
	wire notDiff0;
	//output notDiff0;
	

	//wire [3:0] count;
	//output [3:0] count;
	//output [4:0] count;
	
	wire [4:0] count;
	//output [4:0] count;
	
	wire [31:0] posResult;
	wire [31:0] negResult;
	wire mustInvert;
	
	wire [31:0] chosenDivisor;
	//output [31:0] chosenDivisor;
	
	wire [31:0] chosenDividend;
	//output [31:0] chosenDividend;
	
	wire [15:0] posSignExtend;
	wire [15:0] negSignExtend;
	wire [31:0] extendedDivisor;
	
	assign zerosBuffer = {31{1'b0}};
	assign posSignExtend = {16{1'b0}};
	assign negSignExtend = {16{1'b1}};
	wire [31:0] startDivisor;
	wire [31:0] testEnd;
	
	wire [31:0] extendedInitialDivisor;
	wire [31:0] flippedInitialDivisor;
	wire [31:0] flippedInitialDividend;
	
	wire notResetDiv;
	wire timeUp;
	wire done;
	wire stop;
	//output stop;
	wire counterReset;
	
	//output doneNext;
	wire doneNext;
	wire exception;
	wire validResult;
	wire divideByZero;
	
	wire clrResult;
	//output clrResult;
	
	//wire divStarted;
	//wire divStarted2;
	//wire divStarted3;
	
	//dff_e started(ctrl_DIV, ~clock, 1'b0, 1'b1, divStarted);
	//dff_e started2(divStarted, clock, 1'b0, 1'b1, divStarted2);
	//dff_e started3(divStarted2, ~clock, 1'b0, 1'b1, divStarted3);

	
	//wire resetReady;
	
	//testZero zeroTest(div_operandB, exception);
	//testZero zeroTest(div_operandB, div_exception);
	testZero zeroTest(div_operandB, divideByZero);
	assign div_exception = divideByZero & ~stop;
	
	//dff_e nextInterrupt(exception, clock, notResetDiv, 1'b1, div_exception);
	dff_e nextInterrupt(div_exception, clock, notResetDiv, 1'b1, exception);
	
	//assign stop = timeUp | div_resultRDY;
	dff_e clearNext(div_resultRDY, clock, notResetDiv, 1'b1, done);
	
	//dff_e counterResetter(div_resultRDY, clock, ); 
	
	wire counterStart;
	dff_e startCounter(ctrl_DIV, ~clock, ~ctrl_DIV, 1'b1, counterStart);
	//assign counterReset = ~ctrl_MULT;
	assign counterReset = ~counterStart;

	
	//assign counterReset = stop;
	//assign counterReset = ~ctrl_DIV;
	
	counter32 divCounter(timeUp, count, clock, counterReset, 1'b1);
	
	//assign stop = ctrl_DIV | done | timeUp | div_exception;
	//assign stop = ctrl_DIV | done | timeUp | div_exception | (~count[4] & ~count[3] & ~count[2] & ~count[1] & ~count[0] & ~divStarted & ~divStarted2 & ~divStarted3);
	
	//assign stop = ctrl_DIV | done | timeUp | exception | (~count[4] & ~count[3] & ~count[2] & ~count[1] & ~count[0] & ~divStarted & ~divStarted2 & ~divStarted3);
	
	wire justDone;
	//output justDone;
	wire stayDone;
	//output stayDone;
	wire isDone;
	wire justDone2;
	//output justDone2;
	
	//output isDone;
	
	dff_e checkDone(div_resultRDY, ~clock, ~ctrl_DIV, 1'b1, justDone);
	dff_e checkDone2(justDone, clock, ~ctrl_DIV, 1'b1, justDone2);
	assign stayDone = justDone | justDone2 | isDone;
	dff_e showDone(stayDone, clock, ~ctrl_DIV, 1'b1, isDone);
	
	assign stop = ~ctrl_DIV | isDone | timeUp;
	
	assign resetDiv = ~stop;
	//assign resetDiv = ~counterReset;
	
	assign clrResult =  ~counterReset;
	//assign clrResult = resetDiv;
	
	assign notResetDiv = stop;
	//assign notResetDiv = 1'b1;
	
	//assign startDivisor = div_operandB << 16;
	assign extendedInitialDivisor[31:16] = div_operandB[15] ? negSignExtend : posSignExtend;
	assign extendedInitialDivisor[15:0] = div_operandB;
	assign flippedInitialDivisor = ~extendedInitialDivisor;
	//assign flippedInitialDividend = ~div_operandA;
	wire [31:0] negInitialDivisor;
	wire [31:0] negInitialDividend;
	wire [31:0] flippedChosenStartDivisor;
	
	wire lameOverflow;
	wire shouldFail;
	wire lameOverflow2;
	wire zeroDividend;
	wire [31:0] chosenStartDivisor;
	wire [31:0] chosenStartDividend;
	
	CLAdder getNegDivisor(1'b1, {32{1'b0}}, flippedInitialDivisor, negInitialDivisor, lameOverflow, shouldFail);
	CLAdder getNegDividend(1'b1, {32{1'b0}}, ~div_operandA, negInitialDividend, lameOverflow2, zeroDividend);
	
	assign chosenStartDivisor = div_operandB[15] ? negInitialDivisor : div_operandB;
	assign chosenStartDividend = div_operandA[31] ? negInitialDividend : div_operandA;
	
	assign flippedChosenStartDivisor = ~chosenStartDivisor;
	//assign startDivisor = chosenStartDivisor << 16;
	correctShift initiateDivisor(chosenStartDivisor, startDivisor);
	
	assign chosenDividend = (~count[4] & ~count[3] & ~count[2] & ~count[1] & ~count[0]) ? chosenStartDividend : dividend;
	assign chosenDivisor = (~count[4] & ~count[3] & ~count[2] & ~count[1] & ~count[0]) ? startDivisor : divisor;
	
	//Register32 productReg(clock, 1'b1, nextResult, resetDiv, posResult);
	wire [31:0] chosenNextResult;
	assign chosenNextResult = (stayDone | div_resultRDY) ? posResult : nextResult;
	
	//Register32 productReg(clock, 1'b1, nextResult, clrResult, posResult);
	Register32 productReg(clock, 1'b1, chosenNextResult, clrResult, posResult);
	Register32 dividendReg(clock, 1'b1, nextDividend, resetDiv, dividend);
	Register32 divisorReg(clock, 1'b1, nextDivisor, resetDiv, divisor);
	
	shiftBlock32 divisorRightShift(chosenDivisor, 1'b0, 1'b1, 2'b01, nextDivisor);
	shiftBlock32 quotientLeftShift(posResult, 1'b1, 1'b1, 2'b01, orInput1);
	
	assign extendedDivisor = chosenDivisor;	
	assign flippedDivisor = ~extendedDivisor;
	
	CLAdder divSub(1'b1, chosenDividend, flippedDivisor, diff, overflow, isZero);
	
	//CLAdder checkEnd(1'b1, chosenDividend, flippedInitialDivisor, testEnd, overflow2, isZero2);
	//CLAdder checkEnd(1'b1, chosenDivisor, flippedInitialDivisor, testEnd, overflow2, isZero2);
	//CLAdder checkEnd(1'b1, divisor, flippedInitialDivisor, testEnd, overflow2, isZero2);
	//CLAdder checkEnd(1'b1, divisor, flippedChosenStartDivisor, testEnd, overflow2, isZero2);
	//CLAdder checkEnd(1'b1, chosenDivisor, flippedChosenStartDivisor, testEnd, overflow2, isZero2);
	CLAdder checkEnd(1'b1, nextDivisor, flippedChosenStartDivisor, testEnd, overflow2, isZero2);
	
	assign notDiff0 = ~diff[31];
	assign orInput2[31:1] = zerosBuffer;
	assign orInput2[0] = notDiff0;
	assign nextResult = orInput1 | orInput2;
	twoOneMux chooseDividend(chosenDividend, diff, notDiff0, nextDividend);
	
	//assign doneNext = testEnd[31] | count[4];
	//assign doneNext = (testEnd[31] | count[4]) & ~stop;
	//assign doneNext = (testEnd[31] | count[4]) & ~div_resultRDY;
	assign doneNext = (testEnd[31] | (count[4] & count[3] & count[2] & count[1] & count[0])) & ~div_resultRDY;
	
	//dff_e stopNext(doneNext, clock, notResetDiv, 1'b1, div_resultRDY);
	dff_e stopNext(doneNext, clock, notResetDiv, 1'b1, validResult);	
	
	assign div_resultRDY = validResult | div_exception;
	//assign div_inputRDY = div_resultRDY;
	assign div_inputRDY = div_resultRDY | stop;
	
	xor chooseResult(mustInvert, div_operandA[31], div_operandB[15]);
	CLAdder getNegResult(1'b1, {32{1'b0}}, ~posResult, negResult, lastOverflow, resultZero);
	assign div_result = mustInvert ? negResult : posResult;

	

endmodule


module finalMult(data_operandA, data_operandB, ctrl_MULT, clock, data_result, data_exception, data_inputRDY, data_resultRDY);
   input [31:0] data_operandA;
   input [15:0] data_operandB;
   input ctrl_MULT, clock;             
   output [31:0] data_result; 
   output data_exception, data_inputRDY, data_resultRDY;
		
	wire [2:0] count;
	//output [2:0] count;
	
	wire reset;
	//output reset;
	
	wire [16:0] initMultiplier;
	
	wire [16:0] nextMultiplier; // Extra bit added to act as implicit 0 for first iteration
	//output [16:0] nextMultiplier;
	
	wire [16:0] multiplier; // Extra bit added to act as implicit 0 for first iteration
	//output [16:0] multiplier;
	
	wire [31:0] nextMultiplicand;
	//output [31:0] nextMultiplicand;
	
	wire [31:0] multiplicand;
	//output [31:0] multiplicand;
	
	wire [31:0] twoMultiplicand;
	wire [31:0] negMultiplicand;
	wire [31:0] twoNegMultiplicand;
	
	wire [31:0] adderInput;
	//output [31:0] adderInput;
	
	wire [31:0] nextProduct;
	//output [31:0] nextProduct;
	
	wire isZero;
	wire cIn;
	
	wire [31:0] longCin;
	
	wire cOut;
	
	wire overflow;
	//output overflow;
	
	wire addOverflow;
	
	
	wire urgentException;
	wire nextException;
	//wire counterReset;
	wire zero;
	wire complete;
	
	wire [31:0] multiplicandShiftInput;
	//output [31:0] multiplicandShiftInput;

	wire [16:0] multiplierShiftInput;
	
	wire [2:0] controlSelectInput;
	//output [2:0] controlSelectInput;
	
	testZero zeroTest(data_operandB, isZero);
	assign initMultiplier[16:1] = data_operandB;
	assign initMultiplier[0] = 1'b0;
	
	wire counterReset;
	
	//wire justStarted;
	//wire justStarted2;
	//wire justStarted3;
	

	//dff_e started(ctrl_MULT, ~clock, 1'b0, 1'b1, justStarted);
	//dff_e started2(justStarted, clock, 1'b0, 1'b1, justStarted2);
	//dff_e started3(justStarted2, ~clock, 1'b0, 1'b1, justStarted3);

	//assign counterReset = ctrl_MULT | data_exception |  (~count[2] & ~count[1] & ~count[0] & ~justStarted & ~justStarted2 & ~justStarted3);
	//wire counterWait;
	wire counterStart;
	dff_e startCounter(ctrl_MULT, ~clock, ~ctrl_MULT, 1'b1, counterStart);
	//assign counterReset = ~ctrl_MULT;
	assign counterReset = ~counterStart;
	//assign counterReset = ~count[2] & ~count[1] & ~count[0] & ~ctrl_MULT;
	
	//assign reset = (~count[2] & ~count[1] & ~count[0]) ? 1'b0 : 1'b1;
	//assign reset = 1'b1;
	wire done;
	//assign counterReset = data_resultRDY ? 1'b1 : 1'b0;
	//assign counterReset = data_resultRDY ? 1'b0 : 1'b1;
	dff_e resetter(data_resultRDY, clock, 1'b0, 1'b1, done);
	assign reset = ~counterReset;
	
	//assign reset = ~(ctrl_MULT | done | data_exception);// | idle);// | data_resultRDY;
	//assign reset = ~counterReset;
	//assign reset = ctrl_MULT;
//	assign reset = 1'b1;

	//counter8 miterNum(data_resultRDY, count, clock, counterReset, 1'b1);
	
	//counter8 iterNum(complete, count, clock, counterReset, 1'b1);
	counter9 iterNum(complete, count, clock, counterReset, 1'b1);
	
	//assign data_resultRDY = complete | data_exception;
	assign data_resultRDY = complete;
	
	wire newException;
	//wire caughtException;
	//wire justOverflowed;
	wire oldException;
	wire hasOverflowed;
	
	assign hasOverflowed = oldException | newException | overflow;  
	
	dff_e catchException(overflow, ~clock, counterReset, 1'b1, newException);
	dff_e latchException(hasOverflowed, clock, counterReset, 1'b1, oldException);
	
	//assign multiplicandShiftInput = (~count[2] & ~count[1] & ~count[0]) ? data_operandA : multiplicand;
	assign multiplicandShiftInput = (~count[2] & ~count[1] & ~count[0] & ~complete) ? data_operandA : multiplicand;
	
	//assign multiplierShiftInput = (~count[2] & ~count[1] & ~count[0]) ? initMultiplier : multiplier;
	assign multiplierShiftInput = (~count[2] & ~count[1] & ~count[0] & ~complete) ? initMultiplier : multiplier;
	
	wire shift2Overflow;
	wire shift1Overflow;
	
	wire shiftOverflow;
	//output shiftOverflow;
	//output shiftOverflow2;
	wire shiftOverflow2;
	//wire nextShiftOverflow;
	//output prevShiftOverflow;
	wire prevShiftOverflow;
	
	assign shift2Overflow = ~((multiplicandShiftInput[31] & multiplicandShiftInput[30] & multiplicandShiftInput[29]) | (~multiplicandShiftInput[31] & ~multiplicandShiftInput[30] & ~multiplicandShiftInput[29]));
	//assign shift1Overflow = (~(multiplicandShiftInput[31] & multiplicandShiftInput[30])) | (~(~multiplicandShiftInput[31] & ~multiplicandShiftInput[30]));
	assign shift1Overflow = multiplicandShiftInput[31] ^ multiplicandShiftInput[30];
	assign shiftOverflow = shift1Overflow & ((~controlSelectInput[2] & controlSelectInput[1] & controlSelectInput[0]) | (controlSelectInput[2] & ~controlSelectInput[1] & ~controlSelectInput[0]));
	
	dff_e saveOverflow(shift2Overflow, clock, counterReset, 1'b1, prevShiftOverflow);
	//assign shiftOverflow2 = prevShiftOverflow & ((~controlSelectInput[2] & ~controlSelectInput[1] & controlSelectInput[0]) | (~controlSelectInput[2] & controlSelectInput[1] & ~controlSelectInput[0]) | (controlSelectInput[2] & ~controlSelectInput[1] & controlSelectInput[0]) | (controlSelectInput[2] & controlSelectInput[1] & ~controlSelectInput[0]));
	assign shiftOverflow2 = prevShiftOverflow & ~((controlSelectInput[2] & controlSelectInput[1] & controlSelectInput[0]) | (~controlSelectInput[2] & ~controlSelectInput[1] & ~controlSelectInput[0]));
	
	shiftBlock32 leftShift2(multiplicandShiftInput, 1'b1, 1'b1, 2'b10, nextMultiplicand);
	shiftBlock17 rightShift2(multiplierShiftInput, 1'b0, 1'b1, 2'b10, nextMultiplier);
	shiftBlock32 leftShift1(multiplicandShiftInput, 1'b1, 1'b1, 2'b01, twoMultiplicand);
	
	assign negMultiplicand = ~multiplicandShiftInput;
	assign twoNegMultiplicand = ~twoMultiplicand;
	
	//assign controlSelectInput = (~count[2] & ~count[1] & ~count[0]) ? initMultiplier[2:0] : multiplier[2:0];
	assign controlSelectInput = (~count[2] & ~count[1] & ~count[0] & ~complete) ? initMultiplier[2:0] : multiplier[2:0];
	
	eightOneMux control({32{1'b0}}, multiplicandShiftInput, multiplicandShiftInput, twoMultiplicand, twoNegMultiplicand, negMultiplicand, negMultiplicand, {32{1'b0}}, controlSelectInput, adderInput);
	//eightOneMux getCIn(1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, controlSelectInput, cIn);
	eightOneMux getCIn({32{1'b0}}, {32{1'b0}}, {32{1'b0}}, {32{1'b0}}, {32{1'b1}}, {32{1'b1}}, {32{1'b1}}, {32{1'b0}}, controlSelectInput, longCin);
	assign cIn = longCin[0];
	
	//CLAdder adder(cIn, data_result, adderInput, nextProduct, overflow, zero);
	CLAdder adder(cIn, data_result, adderInput, nextProduct, addOverflow, zero);
	
	//assign overflow = addOverflow | shiftOverflow;
	assign overflow = addOverflow | shiftOverflow | shiftOverflow2;
	
	
	Register17 multReg(clock, 1'b1, nextMultiplier, reset, multiplier);
	Register32 mpReg(clock, 1'b1, nextMultiplicand, reset, multiplicand);
	Register32 pReg(clock, 1'b1, nextProduct, reset, data_result);

	// Non-Pipelined Implementation
	
	//assign data_inputRDY = data_resultRDY | counterReset;	
	//assign data_inputRDY = ~ctrl_MULT; // Can add state-tracking to see if mult is done and assert accordingly
	assign data_inputRDY = counterReset;
	
	//assign data_exception = (ctrl_DIV & isZero) | overflow;
	//assign data_exception = overflow;
	//assign urgentException = overflow & count[2] & count[1] & count[0];
	assign urgentException = overflow & complete;
	//dff_e exceptionNext(overflow, clock, 1'b0, 1'b1, nextException);
	dff_e exceptionNext(overflow, clock, counterReset, 1'b1, nextException);
	//assign data_exception = urgentException | nextException;
	assign data_exception = urgentException | nextException | oldException;
	
endmodule


module getPrefix3(bits, val, hasOne);
	input [2:0] bits;
	output [1:0] val;
	output hasOne;
	
	assign hasOne = bits[2] | bits[1] | bits[0];
	
	assign val[1] = ~bits[2] & ~bits[1];
	assign val[0] = ~bits[2] & bits[1];


endmodule

module eightOneMux(in1, in2, in3, in4, in5, in6, in7, in8, sel, out);
	input [31:0] in1;
	input [31:0] in2;
	input [31:0] in3;
	input [31:0] in4;
	input [31:0] in5;
	input [31:0] in6;
	input [31:0] in7;
	input [31:0] in8;
	input [2:0] sel;
	output [31:0] out;
	
	wire[31:0] out1;
	wire[31:0] out2;
	
	fourOneMux layer1(in1, in3, in5, in7, sel[2:1], out1);
	fourOneMux layer2(in2, in4, in6, in8, sel[2:1], out2);	
	twoOneMux finalOne(out1, out2, sel[0], out);
	
endmodule

module fourOneMux(in1, in2, in3, in4, sel, out);
	input [31:0] in1;
	input [31:0] in2;
	input [31:0] in3;
	input [31:0] in4;
	input [1:0] sel;
	output [31:0] out;
	
	wire [31:0] out1;
	wire [31:0] out2;
	
	twoOneMux firstTwo(in1, in3, sel[1], out1);
	twoOneMux nextTwo(in2, in4, sel[1], out2);	
	twoOneMux best(out1, out2, sel[0], out);
	
endmodule

module twoOneMux(in1, in2, sel, out);
	input [31:0] in1;
	input [31:0] in2;
	input sel;
	output [31:0] out;	
	assign out = sel? in2 : in1;
endmodule

module myDFFE (d, clk, clrn, ena, q);

// port declaration

input   d, clk, ena, clrn;
output  q;
reg     q;

always @ (posedge clk or negedge clrn) begin

//asynchronous active-low reset
     if (~clrn)
        q = 1'b0;

//enable
     else if (ena)
        q = d;
end

endmodule

module decoder32(out, select, enable); 
	input [4:0] select; 
	input enable; 
	output [31:0] out;
	assign out = enable << select; 
endmodule

module regfile(clock, ctrl_writeEnable, ctrl_reset, ctrl_writeReg, ctrl_readRegA, ctrl_readRegB, data_writeReg, data_readRegA, data_readRegB);
   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;
   output [31:0] data_readRegA, data_readRegB;
   // For writing to Reg File
   wire [31:0] regWriteEnables;
		
   // From Registers to Output Bus
   wire [31:0] regOutputs[31:0] ;
   wire [31:0] oe1; // Output Enable for first set of tri-state buffers
   wire [31:0] oe2; // Output Enable for second set of tri-state buffers
   wire [31:0] outBus1[31:0]; // Result of passing regOutputs through first set of tri-state buffers
   wire [31:0] outBus2[31:0]; // Result of passing regOutputs through second set of tri-state buffers
	
	wire [31:0] actualRegWriteEnables;
   decoder32 writeEnDecoder(regWriteEnables, ctrl_writeReg, ctrl_writeEnable); // Write enable correct register
   assign actualRegWriteEnables[0] = 1'b0; // $r0 is write-disabled
	assign actualRegWriteEnables[31:1] = regWriteEnables[31:1];
	assign oe1 = 32'b1 << ctrl_readRegA; // Output enable correct Tri-State buffer for Output Bus 1
   assign oe2 = 32'b1 << ctrl_readRegB; // Output enable correct Tri-State buffer for Output Bus 2 
	
   genvar i;
   generate
   for(i = 0 ; i < 32 ; i = i + 1) begin : loop1
      Register32 REG(clock, actualRegWriteEnables[i], data_writeReg, ctrl_reset, regOutputs[i]);
      tristate32 bus1(regOutputs[i], oe1[i], data_readRegA);
      tristate32 bus2(regOutputs[i], oe2[i], data_readRegB);
      end
   endgenerate
	
endmodule

module regfileModified(clock, ctrl_writeEnable, ctrl_reset, ctrl_writeReg, ctrl_readReg, data_writeReg, data_readReg);
   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readReg;
   input [31:0] data_writeReg;
   output [31:0] data_readReg;
   // For writing to Reg File
   wire [31:0] regWriteEnables;
		
   // From Registers to Output Bus
   wire [31:0] regOutputs[31:0] ;
   wire [31:0] oe1; // Output Enable for first set of tri-state buffers
   //wire [31:0] oe2; // Output Enable for second set of tri-state buffers
   //wire [31:0] outBus1[31:0]; // Result of passing regOutputs through first set of tri-state buffers
   //wire [31:0] outBus2[31:0]; // Result of passing regOutputs through second set of tri-state buffers
		
   decoder32 writeEnDecoder(regWriteEnables, ctrl_writeReg, ctrl_writeEnable); // Write enable correct register
   assign oe1 = 32'b1 << ctrl_readReg; // Output enable correct Tri-State buffer for Output Bus 1
   //assign oe2 = 1 << ctrl_readRegB; // Output enable correct Tri-State buffer for Output Bus 2 
	
   genvar i;
	
   generate
   for(i = 0 ; i < 32 ; i = i + 1) begin : loop1
      Register32 REG(clock, regWriteEnables[i], data_writeReg, ctrl_reset, regOutputs[i]);
      tristate32 bus1(regOutputs[i], oe1[i], data_readReg);
      //tristate32 bus2(regOutputs[i], oe2[i], data_readRegB);
      end
   endgenerate
	
endmodule

/***
module tristate33(data, oe, out);
	input [32:0] data;
	input oe;
	output [32:0] out;
	assign out = oe ? data : {33{1'bz}};
endmodule
***/
module Register5(clock, wEn, writeIn, clr, readOut);
	input clock, wEn, clr;
	input [4:0] writeIn;
	output [4:0] readOut;
	
	genvar i;
	generate
		for(i = 0; i< 5 ; i = i + 1) begin : loop1
			myDFFE dff(.d(writeIn[i]), .clk(clock), .clrn(clr), .ena(wEn), .q(readOut[i]));
		end
	endgenerate
	
endmodule

module Register12(clock, wEn, writeIn, clr, readOut);
	input clock, wEn, clr;
	input [11:0] writeIn;
	output [11:0] readOut;
	
	genvar i;
	generate
		for(i = 0; i< 12 ; i = i + 1) begin : loop1
			myDFFE dff(.d(writeIn[i]), .clk(clock), .clrn(clr), .ena(wEn), .q(readOut[i]));
		end
	endgenerate
	
endmodule


module satCounter(taken, clock, WE, reset, shouldTake);
	input taken, clock, WE, reset;
	output shouldTake;
	
	wire y2, Y2, y1, Y1;
	
	myDFFE MSB(Y2, clock, reset, WE, y2);
	myDFFE LSB(Y1, clock, reset, WE, y1);
	
	assign Y2 = (~y2 & y1 & taken) | (y2 & (y1 | taken));
	assign Y1 = (~y1 & taken) | (y2 & ~(y1 ^ taken));
	assign shouldTake = y2;

endmodule

module satCounterFile(taken, clock, WE, reset, RD, RS, shouldTake);

	input taken, clock, WE, reset;
	input [4:0] RD, RS;
	output shouldTake;
	
	wire [31:0] WEs;
	wire [31:0] satOutputs;
	wire [31:0] oe;
	
	decoder32 WEDecoder(WEs, RD, WE); // Write enable correct register
   assign oe = 32'b1 << RS; // Output enable correct Tri-State buffer for Output Bus 1

	genvar i;	
   generate
   for(i = 0 ; i < 32 ; i = i + 1) begin : loop1
      satCounter sc(taken, clock, WEs[i], reset, satOutputs[i]);
      tristate32 bus1(satOutputs[i], oe[i], shouldTake);
      end
   endgenerate
	
endmodule


module loadStallLogic(FDIns, DXIns, stall);

	input [31:0] FDIns, DXIns;
	output stall;
	
	wire loadStall;
	//wire branchStall;
	
	wire [4:0] opcode;
	wire isLoad;
	
	wire rs1Load;
	wire rs2Load;
	
	assign opcode = FDIns[31:27];
	
	// STALL FOR LOAD
	assign isLoad = ~DXIns[31] & DXIns[30] & ~DXIns[29] & ~DXIns[28] & ~DXIns[27];
	// Cases where RT (Ins[16:12]) is not used
		// I-Type Instructions : {00010, 00101, 00110, 00111, 01000}
	wire iType;
	assign iType = (~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & ~opcode[0]) | (~opcode[4] & ~opcode[3] & opcode[2] & opcode[0]) | (~opcode[4] & ~opcode[3] & opcode[2] & opcode[1] & ~opcode[0]) | (~opcode[4] & opcode[3] & ~opcode[2] & ~opcode[1] & ~opcode[0]);
		// Shift Instructions : {00100, 00101}
	wire shift;
	assign shift = (~opcode[4] & ~opcode[3] & opcode[2] & ~opcode[1]);
		// J-Type Instructions : {00001, 00011, 00100, 10110, 10101}
	wire jump;
	assign jump = (~opcode[4] & ~opcode[3] & ~opcode[2] & ~opcode[1] & opcode[0]) | (~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0]) | (~opcode[4] & ~opcode[3] & opcode[2] & ~opcode[1] & ~opcode[0]) | (opcode[4] & ~opcode[3] & opcode[2] & opcode[1] & ~opcode[0]) | (opcode[4] & ~opcode[3] & opcode[2] & ~opcode[1] & opcode[0]);
	
	wire rs2Matters;
	assign rs2Matters = ~(iType | shift | jump);
	// Stall if data dependency after load - choose to stall ASAP
	FiveBitEquals stallLoadRS1(FDIns[21:17], DXIns[26:22], rs1Load);
	FiveBitEquals stallLoadRS2(FDIns[16:12], DXIns[26:22], rs2Load);
	
	assign loadStall = isLoad & (rs1Load | (rs2Load & rs2Matters));
	
	/*** DEPRECATED - LOAD AND BRANCH STALLS ARE TREATED DIFFERENTLY, CANNOT COMBINE
	// STALL FOR BRANCH RESOLUTION - TEMPORARY
		// Only if DXIns is branch : {00010, 00110, 10110}
	wire isBranch;
	//wire [4:0] DXOpcode;
	//assign DXOpcode = DXIns[31:27];
	assign isBranch = (~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & ~opcode[0]) | (~opcode[3] & opcode[2] & opcode[1] & ~opcode[0]);
	
	assign stall = loadStall | isBranch;
	***/
	assign stall = loadStall;
	
endmodule



/*** TRY NEW SHOOT STRATEGY
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
	myDFFE latchShot(nextShot, clock, reset & resetShoot, shootWriteEnable, shootData);
	myDFFE latchNewInterrupt(start, clock, reset, 1'b1, newInterrupt);
	myDFFE latchOldInterrupt(newInterrupt, clock, reset, 1'b1, oldInterrupt);
	assign ioInterrupt = oldInterrupt ^ newInterrupt;
endmodule
***/


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

