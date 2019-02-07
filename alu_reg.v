`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2018 05:43:13 PM
// Design Name: 
// Module Name: alu_reg
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


module alu_reg(clk, reset, ready, e_c, e_p, m_c, m_p, e_c_out, e_p_out, m_c_out, m_p_out);
    input clk, reset, ready;
    input [7:0] e_c, e_p;
    input [24:0] m_c, m_p;
    
    output logic [7:0] e_c_out, e_p_out;
    output logic [24:0] m_c_out, m_p_out;
    
    always_ff@(posedge clk, posedge reset, posedge ready)
    begin
        if(reset)
        begin
            e_c_out <= 8'd0;
            e_p_out <= 8'd0;
            m_c_out <= 25'd0;
            m_p_out <= 25'd0;
        end
        
        else if(ready)
        begin
            e_c_out <= e_c;
            e_p_out <= e_p;
            m_c_out <= m_c;
            m_p_out <= m_p;
        end
        
        else
        begin
            e_c_out <= e_c_out;
            e_p_out <= e_p_out;
            m_c_out <= m_c_out;
            m_p_out <= m_p_out;
        end
    end
endmodule
