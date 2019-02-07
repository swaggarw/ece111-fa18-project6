`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2018 05:14:59 PM
// Design Name: 
// Module Name: mux2x1_23b
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


module mux2x1_24b(a, b, s, o);
    input [23:0] a, b;
    input s;
    
    output logic [23:0]o;
    
    assign o = s ? b : a;
    
endmodule