`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2018 07:40:56 PM
// Design Name: 
// Module Name: control_logic
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


module control_logic(opcode, instr_rem, funct, fpu_alu_out_en, regdst, jump, branch, memread, memtoreg, aluop, memwrite, alusrc, regwrite, fpu_regwrite, fpu_re_en, fpu_wr_en, fpu_op, fpu_regdst, fpu_alu_en, stop); // byte_en);
    input [5:0] opcode;
    input [5:0] funct;
    input [19:0] instr_rem; //Remaining bits of instruction
    input fpu_alu_out_en;
    
    output logic regdst, memread, jump, branch, memtoreg, memwrite, alusrc, regwrite, fpu_regwrite, fpu_re_en, fpu_wr_en, fpu_op, fpu_regdst, fpu_alu_en, stop; // byte_en;
    output logic [2:0] aluop;
        
    always_comb
    begin
        regdst = 0;
        jump = 0;
        branch = 0;
        memread = 0;
        memtoreg = 0;
        aluop = 3'b000;
        memwrite = 0;
        alusrc = 0;
        regwrite = 0;
        stop = 0;
        fpu_regwrite = 0;
        fpu_re_en = 0; // Reading from FPU Regfile into Data Memory at 1 and from MIPS Regfile at 0
        fpu_wr_en = 0; // Writing to FPU Regfile from Data Memory at 0 and from FPU at 1
        fpu_op = 0;
        fpu_regdst = 0;
        fpu_alu_en = 0;
//        byte_en = 0;
        
        if(opcode == 6'd0)
        begin
            if(funct == 6'b100000)              // Add
            begin
                regdst = 1;
//                jump = 0;
//                branch = 0;
//                memread = 0;
//                memtoreg = 0;
                aluop = 3'b000;
//                memwrite = 0;
//                alusrc = 0;
                regwrite = 1;
            end
            else if(funct == 6'b100100)         // AND
            begin
                regdst = 1;
//                jump = 0;
//                branch = 0;
//                memread = 0;
//                memtoreg = 0;
                aluop = 3'b001;
//                memwrite = 0;
//                alusrc = 0;
                regwrite = 1;
            end
            else if(funct == 6'b100101)         // OR
            begin
                regdst = 1;
//                jump = 0;
//                branch = 0;
//                memread = 0;
//                memtoreg = 0;
                aluop = 3'b010;
//                memwrite = 0;
//                alusrc = 0;
                regwrite = 1;
            end
            else if(funct == 6'b100010)         // SUB
            begin
                regdst = 1;
//                jump = 0;
//                branch = 0;
//                memread = 0;
//                memtoreg = 0;
                aluop = 3'b011;
//                memwrite = 0;
//                alusrc = 0;
                regwrite = 1;
            end
            else if({instr_rem, funct} == 26'd0) // Stop Incrementing PC
            begin
                stop = 1;
            end
            else // if(funct == 6'b010110)  ::  // XOR 
            begin
                regdst = 1;
//                jump = 0;
//                branch = 0;
//                memread = 0;
//                memtoreg = 0;
                aluop = 3'b100;         // XOR ALUOP = 100
//                memwrite = 0;
//                alusrc = 0;
                regwrite = 1;
            end

        end
        else if(opcode == 6'b000010) // Jump
        begin
            jump = 1;
        end
        else if(opcode == 6'b000100) // Branch
        begin
            branch = 1;
            aluop = 3'b011;
            alusrc = 0;
        end
        else if(opcode == 6'b001000) // ADDI
        begin
            aluop = 3'b000;
            alusrc = 1;
            regwrite = 1;
        end
        else if(opcode == 6'b100011) //LW
        begin
            memtoreg = 1;
            aluop = 3'b000;
            alusrc = 1;
            regwrite = 1;
            memread = 1;
        end
//        else if(opcode == 6'b100100) // LB
//        begin
//            memread = 1;
//            memtoreg = 1;
//            aluop = 2'b00;
//            alusrc = 1;
//            regwrite = 1;
//            byte_en = 1;            
//        end
//        else if(opcode == 6'b101000) // SB
//        begin
//            memwrite = 1;
//            aluop = 2'b00; //Addition
//            alusrc = 1; 
//            byte_en = 1;           
//        end
        else if(opcode == 6'b101011) // SW
        begin
            memwrite = 1;
            aluop = 3'b000; //Addition
            alusrc = 1;
        end
        else if(opcode == 6'b01_0001) // FPU Addition Operation
        begin
            //if(funct == 6'b000000)
            //begin
            fpu_op = 0;
            fpu_regdst = 1;
            fpu_regwrite = 1;
            fpu_wr_en = 1;
            fpu_alu_en = 1;

            if(fpu_alu_out_en)
            begin
                fpu_alu_en = 0;
                stop = 0;
            end
            else
            begin
//                fpu_alu_en = 1;
                stop = 1;
            end
        end
        else if(opcode == 6'b110001) // LWC1
        begin
            memtoreg = 1;
            aluop = 3'b000;
            alusrc = 1;
            fpu_regwrite = 1;
            memread = 1;
//            fpu_wr_en = 1;
        end
        else if(opcode == 6'b111001) // SWC1
        begin
            memwrite = 1;
            aluop = 3'b000; //Addition
            alusrc = 1;
            fpu_re_en = 1;
        end
        else
        begin
            regdst = 0;
            jump = 0;
            branch = 0;
            memread = 0;
            memtoreg = 0;
            aluop = 2'b00;
            memwrite = 0;
            alusrc = 0;
            regwrite = 0;            
        end
    end
endmodule