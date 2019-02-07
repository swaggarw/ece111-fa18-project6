`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2018 10:12:34 PM
// Design Name: 
// Module Name: output_reg
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


module output_reg(clk, ready, reset, signin, ie, im, sign, e, m);
    input clk, ready, reset;
    
    input signin;
    input [7:0]ie;
    input [24:0]im;
    
    output logic sign;
    output logic [7:0]e;
    output logic [24:0]m;
    
    always_ff@(posedge clk)
    begin
        if(reset)
        begin
            sign <= 0;
            e <= 8'd0;
            m <= 25'd0;
        end
        else if(ready)
        begin
            sign <= signin;
            e <= ie;
            m <= im;
        end
        else
        begin
            sign <= sign;
            e <= e;
            m <= m;
        end
    end
endmodule