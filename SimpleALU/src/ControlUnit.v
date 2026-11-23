module ControlUnit(i_clk,i_rst,i_buttons,o_incrementMuxSelectA,o_incrementMuxSelectB,o_operationFlag,o_additionFlag,o_substractionFlag,o_ALUop,o_Aload,o_Bload,o_newOp);
    input i_clk,i_rst;
    input [3:0]i_buttons;
    output reg [1:0]o_incrementMuxSelectA,o_incrementMuxSelectB;
    output reg [2:0]o_ALUop;
    output reg o_Aload,o_Bload,o_newOp;
    output reg o_operationFlag,o_additionFlag,o_substractionFlag;

    
    parameter displayA = 0,
              add1_A = 1,
              add5_A = 2,
              add10_A = 3,
              displayB = 4,
              add1_B = 5,
              add5_B = 6,
              add10_B = 7,
              displayOP = 8,
              addition = 9,
              substraction = 10,
              displayAddition = 11,
              displaySubstraction = 12,
              resetRegisters = 13;
    
    reg [3:0] state;
    
    always@(posedge i_clk or posedge i_rst)begin
        if(i_rst)state <= displayA;
            
        else begin
            case(state)
                displayA: begin
                                case(i_buttons)
                                    //καθε 1 αντιπροσωπευει ενα πατημενο κουμπι του pmod απο 
                                    //αριστερα προς τα δεξια πχ 1000 σημαινει το πρωτο κουμπι 
                                    //πατημενο και τα αλλα 3 οχι
                                    4'b1000:state<=add1_A;
                                    4'b0100:state<=add5_A;
                                    4'b0010:state<=add10_A;
                                    4'b0001:state<=displayB;
                                    default:state<=displayA;
                                endcase
                          end
                add1_A,add5_A,add10_A: state<=displayA;

                displayB: begin
                                case(i_buttons)
                                    //καθε 1 αντιπροσωπευει ενα πατημενο κουμπι του pmod απο 
                                    //αριστερα προς τα δεξια πχ 1000 σημαινει το πρωτο κουμπι 
                                    //πατημενο και τα αλλα 3 οχι
                                    4'b1000:state<=add1_B;
                                    4'b0100:state<=add5_B;
                                    4'b0010:state<=add10_B;
                                    4'b0001:state<=displayOP;
                                    default:state<=displayB;
                                endcase
                          end
                add1_B,add5_B,add10_B: state<=displayB;
                displayOP: begin
                                case(i_buttons)
                                    4'b1000:state<=addition;
                                    4'b0100:state<=substraction;
                                    default:state<=displayOP;
                                endcase
                           end

                addition: begin
                            case(i_buttons)
                                4'b0100:state<=substraction;
                                4'b0001:state<=displayAddition;
                                default:state<=addition;
                            endcase
                          end
                substraction: begin
                            case(i_buttons)
                                4'b1000:state<=addition;
                                4'b0001:state<=displaySubstraction;
                                default:state<=substraction;
                            endcase
                          end
                displayAddition,displaySubstraction:begin
                                                       if(i_buttons == 4'b0001)state<=resetRegisters;
                                                       else state<=state;
                                                    end
                resetRegisters:state<=displayA;
            endcase
        end
            
    end
    
    always@(state)begin
        case(state)
            displayA:begin
                        o_incrementMuxSelectA = 2'bxx;
                        o_incrementMuxSelectB = 2'bxx;
                        o_ALUop = 3'd0;
                        o_Aload = 0;
                        o_Bload = 0;
                        o_newOp = 0;
                        o_operationFlag = 0;
                        o_additionFlag =0;
                        o_substractionFlag =0;
                     end
            add1_A:begin
                        o_incrementMuxSelectA = 2'b00;
                        o_incrementMuxSelectB = 2'bxx;
                        o_ALUop = 3'd0;
                        o_Aload = 1;
                        o_Bload = 0;
                        o_newOp = 0;
                        o_operationFlag = 0;
                        o_additionFlag =0;
                        o_substractionFlag =0;
                     end
            add5_A:begin
                        o_incrementMuxSelectA = 2'b01;
                        o_incrementMuxSelectB = 2'bxx;
                        o_ALUop = 3'd0;
                        o_Aload = 1;
                        o_Bload = 0;
                        o_newOp = 0;
                        o_operationFlag = 0;
                        o_additionFlag =0;
                        o_substractionFlag =0;
                     end
            add10_A:begin
                        o_incrementMuxSelectA = 2'b10;
                        o_incrementMuxSelectB = 2'bxx;
                        o_ALUop = 3'd0;
                        o_Aload = 1;
                        o_Bload = 0;
                        o_newOp = 0;
                        o_operationFlag = 0;
                        o_additionFlag =0;
                        o_substractionFlag =0;
                     end
            displayB:begin
                        o_incrementMuxSelectA = 2'bxx;
                        o_incrementMuxSelectB = 2'bxx;
                        o_ALUop = 3'd1;
                        o_Aload = 0;
                        o_Bload = 0;
                        o_newOp = 0;
                        o_operationFlag = 0;
                        o_additionFlag =0;
                        o_substractionFlag =0;
                     end
            add1_B:begin
                        o_incrementMuxSelectA = 2'bxx;
                        o_incrementMuxSelectB = 2'b00;
                        o_ALUop = 3'd1;
                        o_Aload = 0;
                        o_Bload = 1;
                        o_newOp = 0;
                        o_operationFlag = 0;
                        o_additionFlag =0;
                        o_substractionFlag =0;
                     end
            add5_B:begin
                        o_incrementMuxSelectA = 2'bxx;
                        o_incrementMuxSelectB = 2'b01;
                        o_ALUop = 3'd1;
                        o_Aload = 0;
                        o_Bload = 1;
                        o_newOp = 0;
                        o_operationFlag = 0;
                        o_additionFlag =0;
                        o_substractionFlag =0;
                     end
            add10_B:begin
                        o_incrementMuxSelectA = 2'bxx;
                        o_incrementMuxSelectB = 2'b10;
                        o_ALUop = 3'd1;
                        o_Aload = 0;
                        o_Bload = 1;
                        o_newOp = 0;
                        o_operationFlag = 0;
                        o_additionFlag =0;
                        o_substractionFlag =0;
                     end
            displayOP:begin
                        o_incrementMuxSelectA = 2'bxx;
                        o_incrementMuxSelectB = 2'bxx;
                        o_ALUop = 3'bxxx;
                        o_Aload = 0;
                        o_Bload = 0;
                        o_newOp = 0;
                        o_operationFlag = 1;
                        o_additionFlag =0;
                        o_substractionFlag =0;
                     end
            addition:begin
                        o_incrementMuxSelectA = 2'bxx;
                        o_incrementMuxSelectB = 2'bxx;
                        o_ALUop = 3'bxxx;
                        o_Aload = 0;
                        o_Bload = 0;
                        o_newOp = 0;
                        o_operationFlag = 0;
                        o_additionFlag =1;
                        o_substractionFlag =0;
                     end
            substraction:begin
                            o_incrementMuxSelectA = 2'bxx;
                            o_incrementMuxSelectB = 2'bxx;
                            o_ALUop = 3'bxxx;
                            o_Aload = 0;
                            o_Bload = 0;
                            o_newOp = 0;
                            o_operationFlag = 0;
                            o_additionFlag =0;
                            o_substractionFlag =1;
                         end
            displayAddition:begin
                                o_incrementMuxSelectA = 2'bxx;
                                o_incrementMuxSelectB = 2'bxx;
                                o_ALUop = 3'd2;
                                o_Aload = 0;
                                o_Bload = 0;
                                o_newOp = 0;
                                o_operationFlag = 0;
                                o_additionFlag =0;
                                o_substractionFlag =0;
                            end
            displaySubstraction:begin
                                    o_incrementMuxSelectA = 2'bxx;
                                    o_incrementMuxSelectB = 2'bxx;
                                    o_ALUop = 3'd3;
                                    o_Aload = 0;
                                    o_Bload = 0;
                                    o_newOp = 0;
                                    o_operationFlag = 0;
                                    o_additionFlag =0;
                                    o_substractionFlag =0;
                                end
            
            resetRegisters: begin
                                o_incrementMuxSelectA = 2'bxx;
                                o_incrementMuxSelectB = 2'bxx;
                                o_ALUop = 3'dx;
                                o_Aload = 0;
                                o_Bload = 0;
                                o_newOp = 1;
                                o_operationFlag = 0;
                                o_additionFlag =0;
                                o_substractionFlag =0;
                            end
            default :   begin
                            o_incrementMuxSelectA = 2'bxx;
                            o_incrementMuxSelectB = 2'bxx;
                            o_ALUop = 3'd0;
                            o_Aload = 0;
                            o_Bload = 0;
                            o_newOp = 0;
                            o_operationFlag = 0;
                            o_additionFlag =0;
                            o_substractionFlag =0;
                        end
        endcase
    end
    
endmodule