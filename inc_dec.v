`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2018 08:51:09 PM
// Design Name: 
// Module Name: inc_dec
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


module inc_dec(a, control, o);
    input [7:0]a;
    input [1:0]control;
    output logic [7:0]o;
    
    always_comb
    begin
        if(control == 2'd2)
            o = a + 1;
        else if(control == 2'd0)
            o = a - 1;
        else
            o = a;
    end
endmodule