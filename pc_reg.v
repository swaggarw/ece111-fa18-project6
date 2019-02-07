//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2018 09:37:16 PM
// Design Name: 
// Module Name: pc_reg
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


module pc_reg(clk, rst, pcin, pcout);
    input clk, rst;
    input [31:0] pcin;
    output logic [31:0] pcout;
    
    always_ff@(posedge clk)
    begin
        if(rst)
            pcout <= 32'd0;
        else
            pcout <= pcin;
    end
endmodule