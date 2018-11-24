`include"lib.v"

module alu (input wire[0:15] inp0,inp1, input wire [0:5] opcode, output wire[0:15] opt);
	wire [0:15] lshift,rshift,shift,slt;
	wire slt1;
	blshifter b0(inp0,opcode,lshift);
	brshifter b1(inp0,opcode,rshift);
	shifter b2(lshift,rshift,opcode,shift);
	fas16 b3(opcode,inp0,inp1,slt1);
	assign slt = (slt1 == 0)?16'h0000:16'h0001;
	assign opt = (opcode[0] == 0)?shift:slt;
endmodule

module fas16(input wire [0:5] op, input wire [15:0] i0, i1,output wire opt);

	wire [15:0] carry,out;
	add_sub_slice a0( i0[0] , i1[0] , op , out[0], op[0], carry[0]);
	add_sub_slice a1( i0[1] , i1[1] , op, out[1], carry[0], carry[1]);
	add_sub_slice a2( i0[2] , i1[2] , op, out[2], carry[1], carry[2]);
	add_sub_slice a3( i0[3] , i1[3] , op, out[3], carry[2], carry[3]);
	add_sub_slice a4( i0[4] , i1[4] , op, out[4], carry[3], carry[4]);
	add_sub_slice a5( i0[5] , i1[5] , op, out[5], carry[4], carry[5]);
	add_sub_slice a6( i0[6] , i1[6] , op, out[6], carry[5], carry[6]);
	add_sub_slice a7( i0[7] , i1[7] , op, out[7], carry[6], carry[7]);
	add_sub_slice a8( i0[8] , i1[8] , op, out[8], carry[7], carry[8]);
	add_sub_slice a9( i0[9] , i1[9] , op, out[9], carry[8], carry[9]);
	add_sub_slice a10( i0[10] , i1[10] , op, out[10], carry[9], carry[10]);
	add_sub_slice a11( i0[11] , i1[11] , op, out[11], carry[10], carry[11]);
	add_sub_slice a12( i0[12] , i1[12] , op, out[12], carry[11], carry[12]);
	add_sub_slice a13( i0[13] , i1[13] , op, out[13], carry[12], carry[13]);
	add_sub_slice a14( i0[14] , i1[14] , op, out[14], carry[13], carry[14]);
	add_sub_slice a15( i0[15] , i1[15] , op, out[15], carry[14], carry[15]);
	assign opt = out[15];
endmodule

module fad(a,b,c,sum,carry);
	input a,b,c;
	output  sum,carry;
	assign sum = a^b^c;
	assign carry = (a&b)|(b&c)|(c&a);
endmodule

module add_sub_slice(a ,b , op, sum, c, carry);
	input [0:5] op;
	input a,b,c;
	output sum,carry;
	wire b_updated;
	xor2 my_xor2(b ,op[0] , b_updated);
	fad my_fad(a, b_updated, c, sum, carry);
endmodule

module shifter(input wire[0:15] lshift,rshift,input wire [0:5] opcode, output wire[0:15] opt);
	mux2 m00(lshift[0],rshift[0],opcode[1],opt[0]);
	mux2 m01(lshift[1],rshift[1],opcode[1],opt[1]);
	mux2 m02(lshift[2],rshift[2],opcode[1],opt[2]);
	mux2 m03(lshift[3],rshift[3],opcode[1],opt[3]);
	mux2 m04(lshift[4],rshift[4],opcode[1],opt[4]);
	mux2 m05(lshift[5],rshift[5],opcode[1],opt[5]);
	mux2 m06(lshift[6],rshift[6],opcode[1],opt[6]);
	mux2 m07(lshift[7],rshift[7],opcode[1],opt[7]);
	mux2 m08(lshift[8],rshift[8],opcode[1],opt[8]);
	mux2 m09(lshift[9],rshift[9],opcode[1],opt[9]);
	mux2 m10(lshift[10],rshift[10],opcode[1],opt[10]);
	mux2 m11(lshift[11],rshift[11],opcode[1],opt[11]);
	mux2 m12(lshift[12],rshift[12],opcode[1],opt[12]);
	mux2 m13(lshift[13],rshift[13],opcode[1],opt[13]);
	mux2 m14(lshift[14],rshift[14],opcode[1],opt[14]);
	mux2 m15(lshift[15],rshift[15],opcode[1],opt[15]);
endmodule

module blshifter(input wire[0:15] inp, input wire [0:5] opcode, output wire[0:15] opt);
	wire[0:15] t1,t2,t3;
	mux2 m00(inp[0],inp[1],opcode[5],t1[0]);
	mux2 m01(inp[1],inp[2],opcode[5],t1[1]);
	mux2 m02(inp[2],inp[3],opcode[5],t1[2]);
	mux2 m03(inp[3],inp[4],opcode[5],t1[3]);
	mux2 m04(inp[4],inp[5],opcode[5],t1[4]);
	mux2 m05(inp[5],inp[6],opcode[5],t1[5]);
	mux2 m06(inp[6],inp[7],opcode[5],t1[6]);
	mux2 m07(inp[7],inp[8],opcode[5],t1[7]);
	mux2 m08(inp[8],inp[9],opcode[5],t1[8]);
	mux2 m09(inp[9],inp[10],opcode[5],t1[9]);
	mux2 m10(inp[10],inp[11],opcode[5],t1[10]);
	mux2 m11(inp[11],inp[12],opcode[5],t1[11]);
	mux2 m12(inp[12],inp[13],opcode[5],t1[12]);
	mux2 m13(inp[13],inp[14],opcode[5],t1[13]);
	mux2 m14(inp[14],inp[15],opcode[5],t1[14]);
	mux2 m15(inp[15],inp[0],opcode[5],t1[15]);


	mux2 m16(t1[0],t1[2],opcode[4],t2[0]);
	mux2 m17(t1[1],t1[3],opcode[4],t2[1]);
	mux2 m18(t1[2],t1[4],opcode[4],t2[2]);
	mux2 m19(t1[3],t1[5],opcode[4],t2[3]);
	mux2 m20(t1[4],t1[6],opcode[4],t2[4]);
	mux2 m21(t1[5],t1[7],opcode[4],t2[5]);
	mux2 m22(t1[6],t1[8],opcode[4],t2[6]);
	mux2 m23(t1[7],t1[9],opcode[4],t2[7]);
	mux2 m24(t1[8],t1[10],opcode[4],t2[8]);
	mux2 m25(t1[9],t1[11],opcode[4],t2[9]);
	mux2 m26(t1[10],t1[12],opcode[4],t2[10]);
	mux2 m27(t1[11],t1[13],opcode[4],t2[11]);
	mux2 m28(t1[12],t1[14],opcode[4],t2[12]);
	mux2 m29(t1[13],t1[15],opcode[4],t2[13]);
	mux2 m30(t1[14],t1[0],opcode[4],t2[14]);
	mux2 m31(t1[15],t1[1],opcode[4],t2[15]);

	mux2 m32(t2[0],t2[4],opcode[3],t3[0]);
	mux2 m33(t2[1],t2[5],opcode[3],t3[1]);
	mux2 m34(t2[2],t2[6],opcode[3],t3[2]);
	mux2 m35(t2[3],t2[7],opcode[3],t3[3]);
	mux2 m36(t2[4],t2[8],opcode[3],t3[4]);
	mux2 m37(t2[5],t2[9],opcode[3],t3[5]);
	mux2 m38(t2[6],t2[10],opcode[3],t3[6]);
	mux2 m39(t2[7],t2[11],opcode[3],t3[7]);
	mux2 m40(t2[8],t2[12],opcode[3],t3[8]);
	mux2 m41(t2[9],t2[13],opcode[3],t3[9]);
	mux2 m42(t2[10],t2[14],opcode[3],t3[10]);
	mux2 m43(t2[11],t2[15],opcode[3],t3[11]);
	mux2 m44(t2[12],t2[0],opcode[3],t3[12]);
	mux2 m45(t2[13],t2[1],opcode[3],t3[13]);
	mux2 m46(t2[14],t2[2],opcode[3],t3[14]);
	mux2 m47(t2[15],t2[3],opcode[3],t3[15]);

	mux2 m48(t3[0],t3[8],opcode[2],opt[0]);
	mux2 m49(t3[1],t3[9],opcode[2],opt[1]);
	mux2 m50(t3[2],t3[10],opcode[2],opt[2]);
	mux2 m51(t3[3],t3[11],opcode[2],opt[3]);
	mux2 m52(t3[4],t3[12],opcode[2],opt[4]);
	mux2 m53(t3[5],t3[13],opcode[2],opt[5]);
	mux2 m54(t3[6],t3[14],opcode[2],opt[6]);
	mux2 m55(t3[7],t3[15],opcode[2],opt[7]);
	mux2 m56(t3[8],t3[0],opcode[2],opt[8]);
	mux2 m57(t3[9],t3[1],opcode[2],opt[9]);
	mux2 m58(t3[10],t3[2],opcode[2],opt[10]);
	mux2 m59(t3[11],t3[3],opcode[2],opt[11]);
	mux2 m60(t3[12],t3[4],opcode[2],opt[12]);
	mux2 m61(t3[13],t3[5],opcode[2],opt[13]);
	mux2 m62(t3[14],t3[6],opcode[2],opt[14]);
	mux2 m63(t3[15],t3[7],opcode[2],opt[15]);

endmodule

module brshifter(input wire[0:15] inp, input wire[0:5] opcode,output wire [0:15] opt);
	wire[0:15] t1,t2,t3;
	mux2 m00(inp[0],inp[15],opcode[5],t1[0]);
	mux2 m01(inp[1],inp[0],opcode[5],t1[1]);
	mux2 m02(inp[2],inp[1],opcode[5],t1[2]);
	mux2 m03(inp[3],inp[2],opcode[5],t1[3]);
	mux2 m04(inp[4],inp[3],opcode[5],t1[4]);
	mux2 m05(inp[5],inp[4],opcode[5],t1[5]);
	mux2 m06(inp[6],inp[5],opcode[5],t1[6]);
	mux2 m07(inp[7],inp[6],opcode[5],t1[7]);
	mux2 m08(inp[8],inp[7],opcode[5],t1[8]);
	mux2 m09(inp[9],inp[8],opcode[5],t1[9]);
	mux2 m10(inp[10],inp[9],opcode[5],t1[10]);
	mux2 m11(inp[11],inp[10],opcode[5],t1[11]);
	mux2 m12(inp[12],inp[11],opcode[5],t1[12]);
	mux2 m13(inp[13],inp[12],opcode[5],t1[13]);
	mux2 m14(inp[14],inp[13],opcode[5],t1[14]);
	mux2 m15(inp[15],inp[14],opcode[5],t1[15]);


	mux2 m16(t1[0],t1[14],opcode[4],t2[0]);
	mux2 m17(t1[1],t1[15],opcode[4],t2[1]);
	mux2 m18(t1[2],t1[0],opcode[4],t2[2]);
	mux2 m19(t1[3],t1[1],opcode[4],t2[3]);
	mux2 m20(t1[4],t1[2],opcode[4],t2[4]);
	mux2 m21(t1[5],t1[3],opcode[4],t2[5]);
	mux2 m22(t1[6],t1[4],opcode[4],t2[6]);
	mux2 m23(t1[7],t1[5],opcode[4],t2[7]);
	mux2 m24(t1[8],t1[6],opcode[4],t2[8]);
	mux2 m25(t1[9],t1[7],opcode[4],t2[9]);
	mux2 m26(t1[10],t1[8],opcode[4],t2[10]);
	mux2 m27(t1[11],t1[9],opcode[4],t2[11]);
	mux2 m28(t1[12],t1[10],opcode[4],t2[12]);
	mux2 m29(t1[13],t1[11],opcode[4],t2[13]);
	mux2 m30(t1[14],t1[12],opcode[4],t2[14]);
	mux2 m31(t1[15],t1[13],opcode[4],t2[15]);


	mux2 m32(t2[0],t2[12],opcode[3],t3[0]);
	mux2 m33(t2[1],t2[13],opcode[3],t3[1]);
	mux2 m34(t2[2],t2[14],opcode[3],t3[2]);
	mux2 m35(t2[3],t2[15],opcode[3],t3[3]);
	mux2 m36(t2[4],t2[0],opcode[3],t3[4]);
	mux2 m37(t2[5],t2[1],opcode[3],t3[5]);
	mux2 m38(t2[6],t2[2],opcode[3],t3[6]);
	mux2 m39(t2[7],t2[3],opcode[3],t3[7]);
	mux2 m40(t2[8],t2[4],opcode[3],t3[8]);
	mux2 m41(t2[9],t2[5],opcode[3],t3[9]);
	mux2 m42(t2[10],t2[6],opcode[3],t3[10]);
	mux2 m43(t2[11],t2[7],opcode[3],t3[11]);
	mux2 m44(t2[12],t2[8],opcode[3],t3[12]);
	mux2 m45(t2[13],t2[9],opcode[3],t3[13]);
	mux2 m46(t2[14],t2[10],opcode[3],t3[14]);
	mux2 m47(t2[15],t2[11],opcode[3],t3[15]);


	mux2 m48(t3[0],t2[8],opcode[2],opt[0]);
	mux2 m49(t3[1],t3[9],opcode[2],opt[1]);
	mux2 m50(t3[2],t3[10],opcode[2],opt[2]);
	mux2 m51(t3[3],t3[11],opcode[2],opt[3]);
	mux2 m52(t3[4],t3[12],opcode[2],opt[4]);
	mux2 m53(t3[5],t3[13],opcode[2],opt[5]);
	mux2 m54(t3[6],t3[14],opcode[2],opt[6]);
	mux2 m55(t3[7],t3[15],opcode[2],opt[7]);
	mux2 m56(t3[8],t3[0],opcode[2],opt[8]);
	mux2 m57(t3[9],t3[1],opcode[2],opt[9]);
	mux2 m58(t3[10],t3[2],opcode[2],opt[10]);
	mux2 m59(t3[11],t3[3],opcode[2],opt[11]);
	mux2 m60(t3[12],t3[4],opcode[2],opt[12]);
	mux2 m61(t3[13],t3[5],opcode[2],opt[13]);
	mux2 m62(t3[14],t3[6],opcode[2],opt[14]);
	mux2 m63(t3[15],t3[7],opcode[2],opt[15]);

endmodule