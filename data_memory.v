`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2018 12:39:22 AM
// Design Name: 
// Module Name: data_memory
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


module data_memory(clk, memread, memwrite, read_address, write_address, data_wr, data_re); // byte_en
    input clk, memread, memwrite;
    input [5:0]read_address, write_address;
    input [31:0]data_wr;
//    input byte_en;
    
    output logic [31:0]data_re;
        
    logic [7:0]data_mem[63:0];
    
//    wire [5:0] read_addr = {read_address[3], read_address[2], read_address[1], read_address[0], 1'b0, 1'b0};
//    wire [5:0] write_addr = {write_address[3], write_address[2], write_address[1], write_address[0], 1'b0, 1'b0};
    initial
    begin
        $readmemh("data.mem", data_mem, 0, 63);
    end
    
    always_comb
    begin
        if(memread && !memwrite)
            begin
//                if(byte_en)
//                begin
//                    case(read_address[1:0])
//                        2'b00: data_re = {24'd0, data_mem[read_address[5:2]][7:0]};
//                        2'b01: data_re = {24'd0, data_mem[read_address[5:2]][15:8]};
//                        2'b10: data_re = {24'd0, data_mem[read_address[5:2]][23:16]};
//                        2'b11: data_re = {24'd0, data_mem[read_address[5:2]][31:24]};
//                    endcase
//                end
//                else
                    data_re = {data_mem[read_address], data_mem[read_address + 6'd1], data_mem[read_address + 6'd2], data_mem[read_address + 6'd3]};
            end
        else
            data_re = 32'd0;
    end
    
    always_ff@(posedge clk)
    begin
        if(memwrite && !memread)
        begin
//            if(byte_en)
//            begin
//                case(write_address[1:0])
//                    2'b00: data_mem[write_address[5:2]][7:0] <= data_wr;
//                    2'b01: data_mem[write_address[5:2]][15:8] <= data_wr;
//                    2'b10: data_mem[write_address[5:2]][23:16] <= data_wr;
//                    2'b11: data_mem[write_address[5:2]][31:24] <= data_wr;
//                endcase
//            end
//            else
                {data_mem[write_address], data_mem[write_address + 6'd1], data_mem[write_address + 6'd2], data_mem[write_address + 6'd3]} <= data_wr;
        end
    end
endmodule