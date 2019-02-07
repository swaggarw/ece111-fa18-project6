//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2018 08:41:18 PM
// Design Name: 
// Module Name: alu_pc
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


module alu_pc(pc, stop, pcnext);
    input [31:0] pc;
    input stop;
    
    output [31:0] pcnext;
    
    assign pcnext = (stop ? pc : (pc + 32'd4));
endmodule