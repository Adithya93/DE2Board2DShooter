module ClockAdapter(processor_clk, update_clk, reset, must_update);
	input processor_clk, update_clk, reset;
	output must_update;

	wire nextUpdate;

	assign nextUpdate = update_clk & ~must_update; // Ensures high for only 1 cycle

	myDFFE catchUpdate(nextUpdate, processor_clk, reset, 1'b1, must_update);

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
