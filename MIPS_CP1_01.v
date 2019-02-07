`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2018 12:35:00 AM
// Design Name: 
// Module Name: MIPS_CP1_01
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


module MIPS_CP1_01(clk, rst, y);
    input   clk, rst;
    output y;
    
    logic [31:0] pcout, iout, iin, alumux, datamux, branchmux, jumpmux, pcnext, regout1, regout2,
                 fp_regout1, fp_regout2, sign_out, alu_out, data_out, shiftbranchout, shiftjumpout,
                 branchadderout, fp_out, fpu_regfile_wr, datamem_wr;
    logic [4:0] imux;
    logic [4:0] imux_fp;
    
    logic regdst, memread, jump, branch, instrwrite, memtoreg, memwrite, alusrc, regwrite, zero;
    logic fpu_alu_out_en; // Input to Control Logic coming from FPU
    logic fpu_regwrite, fpu_re_en, fpu_wr_en, fpu_op, fpu_regdst, fpu_alu_en; // Outputs from control logic for Co-Processor Operations
    logic [2:0] aluop;
    logic branchselect;
    logic byte_en;
    logic stop;
    logic out_final;
    
    pc_reg pc1(clk, rst, jumpmux, pcout);

    instructionmem_8 im1(1'b0, pcout[5:0], iout);
    
    control_logic cl1(iout[31:26], iout[25:6], iout[5:0], fpu_alu_out_en, regdst, jump, branch, memread, memtoreg, aluop, memwrite, alusrc, regwrite, 
                                                                  fpu_regwrite, fpu_re_en, fpu_wr_en, fpu_op, fpu_regdst, fpu_alu_en, stop); // byte_en);
    
    mux_5 mux5_1(iout[20:16], iout[15:11], regdst, imux);
    
    mux_5 mux5_2(iout[20:16], iout[10:6], fpu_regdst, imux_fp);
    
    regfile regfile1(clk, regwrite, 1'b0, iout[25:21], iout[20:16], imux, regout1, regout2, datamux);
    
    mux_32 mux_32_fpu_regfile(datamux, fp_out, fpu_wr_en, fpu_regfile_wr);
    
    fpu_regfile fpu_regfile1(clk, fpu_regwrite, 1'b0, iout[15:11], iout[20:16], imux_fp, fp_regout1, fp_regout2, fpu_regfile_wr);
    
    fp_01 fpu1(clk, rst, fpu_op, fp_regout1, fp_regout2, fpu_alu_en, fp_out, fpu_alu_out_en);
    
    sign_ext signext1(iout[15:0], sign_out);
    
    mux_32 mux32_1(regout2, sign_out, alusrc, alumux);
    
    alu_mips alu_main(regout1, alumux, aluop, zero, alu_out);
    
    mux_32 mux_32_data(regout2, fp_regout2, fpu_re_en, datamem_wr);
    
    data_memory data_mem1(clk, memread, memwrite, alu_out[5:0], alu_out[5:0], datamem_wr, data_out); // byte_en
    
    mux_32 mux32_data(alu_out, data_out, memtoreg, datamux);
    
    alu_pc alupc1(pcout, stop, pcnext);
    
    shiftleft2_26 shiftleft2_26_1(iout[25:0], pcnext[31:28], shiftjumpout);
    
    shiftleft2_32 shiftleft2_32_1(sign_out, shiftbranchout);
    
    adder_branch adder_branch1(pcnext, shiftbranchout, branchadderout);
    
    mux_32 mux_32_branch(pcnext, branchadderout, branchselect, branchmux);
    
    mux_32 mux_32_jump(branchmux, shiftjumpout, jump, jumpmux);
    
    and and_branch(branchselect, branch, zero);
    
    assign y = ^(data_out);

endmodule