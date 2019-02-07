`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2018 09:19:57 PM
// Design Name: 
// Module Name: rounding
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

module rounding(m, e, om, oe, control);
    input [24:0]m;
    input [7:0]e;
    input control;
    
    output logic [24:0]om;
    output logic [7:0]oe;
    
    always_comb
    begin
        if(control)
        begin    
            if(m[0] == 1'b1)
            begin
                om = (m + 1);
             end
             else
                om = m;
        end
        else
        begin
            om = m;
        end
        oe = e;
    end
endmodule