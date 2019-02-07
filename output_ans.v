`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2018 02:33:33 AM
// Design Name: 
// Module Name: output_ans
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


module output_ans(clk, reset, out, sign, m, e, signout, eout, mout);
    input clk, reset, out, sign;
    input [22:0]m;
    input [7:0]e;
    
    output logic signout;
    output logic [22:0] mout;
    output logic [7:0] eout;
//    output logic out_dis;
    
    always_ff@(posedge clk)
    begin
        if(reset)
        begin
            signout <= 0;
            mout <= 23'd0;
            eout <= 8'd0;
        end
        else if(out)
        begin
            signout <= sign;
            mout <= m;
            eout <= e;
        end
        else
        begin
            signout <= signout;
            mout <= mout;
            eout <= eout;
        end
    end
endmodule