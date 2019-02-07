`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2018 08:51:57 PM
// Design Name: 
// Module Name: shiftleft2_32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module shiftleft2_32(a, b);
    input [31:0] a;
    
    output [31:0] b;
    
    assign b = (a << 2'd2);
    
endmodule`timescale 1ns / 1ps