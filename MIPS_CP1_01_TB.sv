`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2018 11:40:25 PM
// Design Name: 
// Module Name: MIPS_01_TB
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


module MIPS_CP1_01_TB();

    logic   clk, rst;
    logic y;
    
    MIPS_CP1_01 mips1(clk, rst, y);
        
    always
        #30 clk = ~clk;
        
    initial
    begin
        clk = 0;
        rst = 1;
        #35 rst = 0;
    end
    
endmodule
