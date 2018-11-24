`include"project.v"
module tbproject;
	reg[0:15] tinp0,tinp1;
	reg[0:5] topcode;
	wire [0:15] topt;
	alu fb(tinp0,tinp1,topcode,topt);
	initial begin
		$dumpfile("a.vcd");
		$dumpvars(0,tbproject);
	end
	initial begin
		tinp0 = 16'hdcf0;
		tinp1 = 16'hdcf1;
		topcode = 6'b100000;
		#5
		tinp0 = 16'h0001;
		tinp1 = 16'hdcf1;
		topcode = 6'b000011;
		#5
		tinp0 = 16'h0001;
		tinp1 = 16'hdcf1;
		topcode = 6'b010011;
		#5
		$finish;
	end
endmodule