`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2018 09:07:09 PM
// Design Name: 
// Module Name: mux2x1_25
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


module mux2x1_25b(a, b, s, o);
    input [24:0]a, b;
    input s;
    
    output logic [24:0]o;
    
    assign o = (s ? b : a);
endmodule