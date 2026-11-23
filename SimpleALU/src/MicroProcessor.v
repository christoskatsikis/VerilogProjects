module MicroProcessor(i_clk,i_rst,i_buttons,o_dtInputNumber,o_led,o_operationFlag,o_additionFlag,o_substractionFlag);
    input i_clk,i_rst;
    input [3:0] i_buttons;
    output [6:0] o_dtInputNumber;
    output o_led;
    output o_operationFlag,o_additionFlag,o_substractionFlag;

    wire [2:0] mp_ALUop;
    wire [1:0] mp_incrementMuxSelectA,mp_incrementMuxSelectB;
    wire mp_Aload,mp_Bload,mp_newOp;

    DataPath DP(.i_clk(i_clk),
                .i_rst(i_rst),
                .i_incrementMuxSelectA(mp_incrementMuxSelectA),
                .i_incrementMuxSelectB(mp_incrementMuxSelectB),
                .i_ALUop(mp_ALUop),
                .i_Aload(mp_Aload),
                .i_Bload(mp_Bload),
                .i_newOp(mp_newOp),
                .o_dtInputNumber(o_dtInputNumber),
                .o_led(o_led));

    ControlUnit CU(.i_clk(i_clk),
                   .i_rst(i_rst),
                   .i_buttons(i_buttons),
                   .o_incrementMuxSelectA(mp_incrementMuxSelectA),
                   .o_incrementMuxSelectB(mp_incrementMuxSelectB),
                   .o_ALUop(mp_ALUop),
                   .o_Aload(mp_Aload),.o_Bload(mp_Bload),
                   .o_newOp(mp_newOp),
                   .o_operationFlag(o_operationFlag),
                   .o_additionFlag(o_additionFlag),
                   .o_substractionFlag(o_substractionFlag));

endmodule