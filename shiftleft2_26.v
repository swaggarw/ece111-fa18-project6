`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2018 08:51:57 PM
// Design Name: 
// Module Name: shiftleft2_26
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


module shiftleft2_26(a, b, c);
    input [25:0] a;
    input [3:0] b;
    
    output [31:0] c;
    
    logic [27:0] d; // Shift left 2 intermediate value
    
    assign d = (({2'b00, a}) << 2'd2);
    
    assign c = {b, d};
endmodule