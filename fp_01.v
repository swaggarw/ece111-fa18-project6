`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2018 06:10:50 PM
// Design Name: 
// Module Name: fpu
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


module fp_01(
    input           clk, reset,
    input           op,
    input           [31:0]a, b,
    input           en,
    output logic    [31:0]c,
    output logic out_final
    );
    
    logic [32:0]ain, bin;
    logic [7:0]diff, sr_ctrl, m_round, e_round, e1out, e2out, muxe_out, e1out_sm, e_c_out, e_p_out, mux_e_norm_out,
                inc_dec_out, round_out_e, e_fpu_out;
                
    logic [23:0] sr_out;
    
    logic [23:0] mux1_m1_out, mux1_m2_out, mux2_m1_out, mux2_m2_out, mux1_out, mux2_out, mux3_out, mux4_out, m1_out_sm, m2_out_sm;;
    
    logic [24:0]shiftbi_out;
    
    logic [1:0] shiftbi_ctrl, inc_dec_ctrl;
    
    logic d, c_emux, m1_mux, m2_mux, bigalu_mux,
          e_mux, round_ctrl, out, ready_alu, ready_out, out_sign, sign_fpu_out;
          
    logic [24:0]bigalu_out, m_c_out, m_p_out, mux25b1_out, round_out_m;
    
    logic [24:0]m_fpu_out;
    
//    logic out_en;
//    
    logic out_en;
    

    control_unit cu1(clk, reset, d, diff, bigalu_out[24:23], m_fpu_out[24:23], e_fpu_out, en, c_emux, m1_mux, m2_mux, sr_ctrl, bigalu_mux,
                    e_mux, inc_dec_ctrl, shiftbi_ctrl, round_ctrl, out_en, ready_alu, ready_out, out_final);
    
    
    alu_small alu1(a[30:23], b[30:23], d, diff);
    
    mux2x1 mux_e(a[30:23], b[30:23], d, muxe_out);
    
    mux2x1_24b mux_m1({1'b1, a[22:0]}, {1'b1, b[22:0]}, m1_mux, mux1_out);
    mux2x1_24b mux_m2({1'b1, a[22:0]}, {1'b1, b[22:0]}, m2_mux, mux2_out);
    
    shiftright sr1(mux1_out, sr_ctrl, sr_out);
    
    mux2x1_24b mux_m3(sr_out, mux2_out, m1_mux, mux3_out);
    mux2x1_24b mux_m4(sr_out, mux2_out, m2_mux, mux4_out);
        
    alu_big alu15(mux3_out, mux4_out, a[31], b[31], op, out_sign, bigalu_out);
    
    alu_reg alureg1(clk, reset, ready_alu, muxe_out, e_fpu_out, bigalu_out, m_fpu_out, e_c_out, e_p_out, m_c_out, m_p_out);    
    
    mux2x1 mux_e_norm(e_c_out, e_p_out, e_mux, mux_e_norm_out);
    
    mux2x1_25b mux25b1(m_c_out, m_p_out, bigalu_mux, mux25b1_out);
    
    inc_dec incdec1(mux_e_norm_out, inc_dec_ctrl, inc_dec_out);
    
    shiftbi shiftbi1(mux25b1_out, shiftbi_ctrl, shiftbi_out);
    
    rounding rounding1(shiftbi_out, inc_dec_out, round_out_m, round_out_e, round_ctrl);
    
    output_reg output1(clk, ready_out, reset, out_sign, round_out_e, round_out_m, sign_fpu_out, e_fpu_out, m_fpu_out);
    
    output_ans outputfinal(clk, reset, out_en, sign_fpu_out, m_fpu_out[22:0], e_fpu_out, c[31], c[30:23], c[22:0]);
endmodule