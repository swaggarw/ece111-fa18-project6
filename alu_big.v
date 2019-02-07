`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2018 05:25:00 PM
// Design Name: 
// Module Name: alu_big
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


module alu_big(a, b, asign, bsign, op, csign, c);
    input [23:0]a, b;
    input asign, bsign, op;
    output logic [24:0]c;
    output logic csign;
    
    logic overflow = 0;
            logic [24:0] am, bm = 25'd0;
            logic [24:0] cm = 25'd0;
            
            always_comb
                begin
                    case(op)
                        0:
                        begin
                            if(asign == bsign)
                            begin
                                c = a + b;
                                csign = asign;
                            end
                            else if(asign > bsign)
                                if(b >= a)
                                begin
                                    csign = bsign;
                                    c = b - a;
                                end
                                else
                                begin
                                    csign = asign;
                                    c = a - b;
                                end
                            else
                            begin
                                if(a >= b)
                                begin
                                    csign = asign;
                                    c = a - b;
                                end
                                else
                                begin
                                    csign = bsign;
                                    c = b - a;
                                end
                            end   
                        end
                        1:
                        begin
                            if(asign == bsign)
                            begin
                                if (a > b)
                                begin
                                    csign = asign;
                                    c = a - b;
                                end
                                else if(b > a)
                                begin
                                    csign = bsign;
                                    c = b - a;
                                end
                                else
                                begin
                                    csign = 0;
                                    c = 23'd0;
                                end
                            end
                            else
                            begin
                                csign = asign;
                                c = a + b;
                            end
                        end
                    endcase
                end

endmodule