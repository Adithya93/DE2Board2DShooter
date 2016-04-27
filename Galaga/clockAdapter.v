module clockAdapter(processor_clk, update_clk, reset, must_update);
	input processor_clk, update_clk, reset;
	output must_update;

	wire nextUpdate;

	assign nextUpdate = update_clk & ~must_update; // Ensures high for only 1 cycle

	myDFFE catchUpdate(nextUpdate, processor_clk, reset, 1'b1, must_update);

endmodule


