`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2018 10:25:40 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(clk, reset, d, diff, big_alu_in, m_round, e_round, en, c_emux, m1_mux, m2_mux, sr_ctrl, bigalu_mux, 
                    e_mux, inc_dec_ctrl, shiftbi_ctrl, round_ctrl, out, ready_alu, ready_out, out_final);
    input clk, reset;
    
    input [7:0] diff;
    input [1:0] big_alu_in;
    input [1:0] m_round;
    input [7:0] e_round;
    input d;
    input en;
    output logic out_final;
    
    output logic [7:0]sr_ctrl;
    output logic c_emux, m1_mux, m2_mux, bigalu_mux, e_mux, round_ctrl, out;
    output logic ready_alu, ready_out;
    
    output logic [1:0]inc_dec_ctrl, shiftbi_ctrl; // 00 for dec/leftshift, 01 for nothing, 10 for inc/rightshift
    
    logic [2:0]state, nextstate;
    
    parameter s0 = 2'd0;
    parameter s4 = 2'd1;
    parameter s5 = 2'd2;
    parameter s6 = 2'd3;
    
    always_ff@(posedge clk, posedge reset)
    begin
        if(reset)
            state <= s0;
        else if(en)
            state <= nextstate;
    end
    
    always_comb
    begin
        ready_alu = 0;
        ready_out = 0;
        m1_mux = 0;
        m2_mux = 0;
        bigalu_mux = 0;
        e_mux = 0;
        inc_dec_ctrl = 2'd1;
        shiftbi_ctrl = 2'd1;
        round_ctrl = 0;
        out = 0;
        nextstate = 3'd0;
        out = 0;
        c_emux = d;
        if(d == 0)
        begin
            m1_mux = 1;
            m2_mux = 0;
        end
        else
        begin
            m1_mux = 0;
            m2_mux = 1;
        end
        
        sr_ctrl = diff;        
        
        case(state)
            s0:
            begin
                ready_alu = 1;
                nextstate = s4;
            end
            s4:
            begin
                ready_out = 1;
                ready_alu = 0;
                e_mux = 0;
                bigalu_mux = 0;
                if((big_alu_in[1] == 0) && (big_alu_in[0] == 0))
                begin
                    shiftbi_ctrl = 2'd0;
                    inc_dec_ctrl = 2'd0;
                end
                else if(big_alu_in[1] == 1)
                begin
                    shiftbi_ctrl = 2'd2;
                    inc_dec_ctrl = 2'd2;
                end
                else
                begin
                    shiftbi_ctrl = 2'd1;
                    inc_dec_ctrl = 2'd1;
                end
                                
                //Rounding logic here:
                
                if(shiftbi_ctrl == 2'd2)
                round_ctrl = 1;
                else
                    round_ctrl = 0;
                    nextstate = s5;
            end
            
            s5:
            begin
                ready_alu = 1;
                ready_out = 0;
                if(e_round == 8'd255)
                begin
                    nextstate = s0;
                    out = 1;
                end
                else if(m_round[1] == 1)
                    nextstate = s6;
                else if(m_round[0] == 0)
                    nextstate = s6;
                else
                begin
                    out = 1;
                    nextstate = s0;
                end
            end
            
            s6:
            begin
                ready_alu = 0;
                ready_out = 1;
                e_mux = 1;
                bigalu_mux = 1;
                if((big_alu_in[1] == 0) && (big_alu_in[0] == 0))
                begin
                    shiftbi_ctrl = 2'd0;
                    inc_dec_ctrl = 2'd0;
                end
                else if(big_alu_in[1] == 1)
                begin
                    shiftbi_ctrl = 2'd2;
                    inc_dec_ctrl = 2'd2;
                end
                else
                begin
                    shiftbi_ctrl = 2'd1;
                    inc_dec_ctrl = 2'd1;
                end
                                
                //Rounding logic here:
                
                if(shiftbi_ctrl == 2'd2)
                round_ctrl = 1;
                else
                    round_ctrl = 0;
                nextstate = s5;
            end
            
//            s7:
//            begin
//                ready_alu = 0;
//                nextstate = s0;
//                out_final = 1;
//                out = 0;
//            end
        endcase
    end
    
    always_ff@(posedge clk)
    begin
        if(out)
            out_final <= 1;
        else
            out_final <= 0;
    end
endmodule