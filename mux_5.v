`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2018 08:47:58 PM
// Design Name: 
// Module Name: mux_5
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


module mux_5(a, b, s, c);
    input [4:0] a, b;
    input s;
    
    output [4:0] c;
    
    assign c = (s ? b : a);
endmodule`timescale 1ns / 1ps