module CompleteCircuit(i_realClk,i_rst,i_buttons,o_digitalTube,o_sel,o_led);
    input i_realClk,i_rst;
    input wire [3:0] i_buttons;
    output [6:0] o_digitalTube;
    output o_sel,o_led;

    wire tick;
    wire operationFlag,substractionFlag,additionFlag;
    wire [6:0]dtInputNumber;
    wire led;
    wire [3:0] buttonPulse;
    
    assign o_led = (i_rst)?1'b1:led;
    

    driver_DigitalTube  DIGITALTUBE(.i_clk(i_realClk),
                                   .i_rst(i_rst),
                                   .i_operationFlag(operationFlag),
                                   .i_additionFlag(additionFlag),
                                   .i_substractionFlag(substractionFlag),
                                   .i_dtInputNumber(dtInputNumber),
                                   .o_digitalTube(o_digitalTube),
                                   .o_sel(o_sel));
    MicroProcessor     MP(.i_clk(i_realClk),
                          .i_rst(i_rst),
                          .i_buttons(buttonPulse),
                          .o_dtInputNumber(dtInputNumber),
                          .o_led(led),
                          .o_operationFlag(operationFlag),
                          .o_additionFlag(additionFlag),
                          .o_substractionFlag(substractionFlag));

    driver_Button #(.P_DEADLY_PERIOD(500_000)) BUTTON_0(.i_clk(i_realClk),
                           .i_rst(i_rst),
                           .i_button(~i_buttons[3]),
                           .o_pulse(buttonPulse[3]));
    driver_Button #(.P_DEADLY_PERIOD(500_000)) BUTTON_1(.i_clk(i_realClk),
                           .i_rst(i_rst),
                           .i_button(~i_buttons[2]),
                           .o_pulse(buttonPulse[2]));
    driver_Button #(.P_DEADLY_PERIOD(500_000)) BUTTON_2(.i_clk(i_realClk),
                           .i_rst(i_rst),
                           .i_button(~i_buttons[1]),
                           .o_pulse(buttonPulse[1]));
    driver_Button #(.P_DEADLY_PERIOD(500_000)) BUTTON_3(.i_clk(i_realClk),
                           .i_rst(i_rst),
                           .i_button(~i_buttons[0]),
                           .o_pulse(buttonPulse[0]));
endmodule