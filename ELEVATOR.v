`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:02:20 02/26/2022 
// Design Name: 
// Module Name:    ELEVATOR 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////


////////////////// Four Floors Elevator Machine /////////////////////
module ELEVATOR(clk,rst,ra,rb,rc,rd,floor);
input clk , rst;
input ra,rb,rc,rd;//Request from related floors A B C D
output [1:0]floor;
wire [1:0]floor;
parameter A=0,B=1,C=2,D=3;
reg [1:0]state;
reg dir;
parameter UP=0 ,DO=1;
// State Declaration
always @(posedge clk or posedge rst)
begin 
	if(rst) state <=A;
	else begin
		case(state)
		A: case(1)
			ra: state<=A;
			rb: state<=B;
			rc: state<=C;
			rd: state<=D;
			endcase
		B: case(dir)
			UP: case(1)
				rb: state<=B;
				rc: state<=C;
				rd: state<=D;
				ra: state<=A;
				endcase
			DO: case(1)
				rb: state<=B;
				ra: state<=A;
				rc: state<=C;
				rd: state<=D;
				endcase
			endcase
		C: case(dir)
			UP: case(1)
				rc: state<=C;
				rd: state<=D;
				rb: state<=B;
				ra: state<=A;
				endcase
			DO: case(1)
				rb: state<=B;
				ra: state<=A;
				rc: state<=C;
				rd: state<=D;
				endcase
			endcase
		D: case(dir)
			rd: state<=D;
			rc: state<=C;
			rb: state<=B;
			ra: state<=A;
				endcase
		endcase
end
end

//Function Woked in Related State
always @(posedge clk or posedge rst)
begin
	if(rst) dir<=A;
	else begin
	case (state)
	A: case(1)
		ra: dir <= UP;
		rb: dir <= UP;
		rc: dir <= UP;
		rd: dir <= DO;
		endcase
	B: case(dir)
		UP :case(1)
			rb: dir <= UP;
			rc: dir <= UP;
			rd: dir <= DO;
			ra: dir <= UP;
			endcase
		DO :case(1)
			rb: dir <= DO;
			ra: dir <= UP;
			rc: dir <= UP;
			rd: dir <= DO;
			endcase
		endcase
	C: case(dir)
		UP :case(1)
			rc: dir <= UP;
			rd: dir <= DO;
			rb: dir <= DO;
			ra: dir <= UP;
			endcase
		DO :case(1)
			rc: dir <= DO;
			rb: dir <= DO;
			ra: dir <= UP;
			rd: dir <= DO;
			endcase
		endcase
	D: case(1)
		rd: dir <= DO;
		rc: dir <= UP;
		rb: dir <= UP;
		ra: dir <= DO;
		endcase
	endcase

end
end
assign floor=state;


endmodule
