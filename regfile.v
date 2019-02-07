`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2018 02:52:19 AM
// Design Name: 
// Module Name: regfile
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


module regfile(clk, regwrite, regread, read_address1, read_address2, write_address, reg_re1, reg_re2, reg_wr);
    input clk, regwrite, regread;
    input [4:0] read_address1, read_address2, write_address;
    input [31:0] reg_wr;
    
    output logic [31:0] reg_re1, reg_re2;
    
    logic [31:0] regfile_mem[31:0];
    
    initial
    begin
        $readmemh("regfile.mem", regfile_mem);
    end
    
    always_comb
    begin
        if(~regread)
            begin         
                reg_re1 <= regfile_mem[read_address1];
                reg_re2 <= regfile_mem[read_address2];
            end
        else
            begin
                reg_re1 <= 32'd0;
                reg_re2 <= 32'd0;
            end
    end
    
    always_ff@(posedge clk)
    begin
        if(regwrite)
            regfile_mem[write_address] <= reg_wr;
    end
endmodule