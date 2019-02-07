`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2018 10:59:28 PM
// Design Name: 
// Module Name: instructionmem_8
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


module instructionmem_8(memread, read_address, instruction_re);
    
    input memread;
    
    input [5:0]read_address;
        
    output logic [31:0]instruction_re;

//    logic [7:0]instruction_re0, instruction_re1, instruction_re2, instruction_re3;
        
    logic [7:0]instruction_mem[63:0];    
    
    //    wire [5:0] read_addr = {read_address[3], read_address[2], read_address[1], read_address[0], 1'b0, 1'b0};
    //    wire [5:0] write_addr = {write_address[3], write_address[2], write_address[1], write_address[0], 1'b0, 1'b0};
    
    initial
    begin
        $readmemh("instr.mem", instruction_mem, 0, 63);
    end
    
    always_comb
    begin
        if(~memread)
            {instruction_re} = 
            {instruction_mem[read_address], instruction_mem[read_address + 6'd1], instruction_mem[read_address + 6'd2], instruction_mem[read_address + 6'd3]};
        else
            {instruction_re} = 32'hFFFFFFFF;
    end
endmodule