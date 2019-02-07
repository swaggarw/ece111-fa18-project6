`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2018 07:27:46 PM
// Design Name: 
// Module Name: alu_mips
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

module alu_mips(a, b, aluop, zero, result);
    input [31:0] a, b;
    input [2:0] aluop;
    
    output logic [31:0]result;
    output logic zero;
    
    always_comb
    begin
        case(aluop)
            3'b000: result = a + b;
            3'b001: result = a & b; 
            3'b010: result = a | b;
            3'b011: result = a - b;
            3'b100: result = a ^ b;
            default: result = 32'd0;
        endcase
        
        if(result == 32'd0)
            zero = 1;
        else
            zero = 0;
    end
endmodule`timescale 1ns / 1ps