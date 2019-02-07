`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2018 04:56:00 PM
// Design Name: 
// Module Name: alu_small
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


module alu_small(e1, e2, d, diff);
    input [7:0]e1, e2;
    output logic d;
    output logic [7:0]diff;
    
    always_comb
        begin
        d = 0;
        diff = 8'd0;
        if(e1 >= e2)
        begin
            d = 0;
            diff = e1 - e2;
        end
        else if (e1 < e2)
        begin
            d = 1;
            diff = e2 - e1;
        end
    end
endmodule