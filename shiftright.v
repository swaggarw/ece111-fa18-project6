`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2018 05:18:35 PM
// Design Name: 
// Module Name: shiftright
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


module shiftright(a, sbits, o);
    input [23:0]a;
    input [7:0]sbits;
    
    output logic [23:0]o;
    
    assign o = (a >> sbits);
endmodule
