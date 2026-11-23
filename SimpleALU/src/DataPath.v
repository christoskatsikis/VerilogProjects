module DataPath(i_clk,i_rst,i_incrementMuxSelectA,i_incrementMuxSelectB,
    i_ALUop,i_Aload,i_Bload,i_newOp,o_led,o_dtInputNumber);
    input i_clk,i_rst;
    input [1:0]i_incrementMuxSelectA,i_incrementMuxSelectB;
    input [2:0]i_ALUop;
    input i_Aload,i_Bload,i_newOp; 
    output o_led;
    output [6:0]o_dtInputNumber;
    
    wire  [8:0] o_datapathALU;
    wire [6:0] datapathA,datapathB;
    
    assign o_led = !(o_datapathALU >=100);
    assign o_dtInputNumber = (o_datapathALU >=100)?
                             (o_datapathALU % 7'd100):
                             o_datapathALU[6:0];

    InputIncrement A(.i_clk(i_clk),.i_rst(i_rst),.i_load(i_Aload),.i_newOp(i_newOp),.i_muxSelect(i_incrementMuxSelectA),.o_num(datapathA));
    InputIncrement B(.i_clk(i_clk),.i_rst(i_rst),.i_load(i_Bload),.i_newOp(i_newOp),.i_muxSelect(i_incrementMuxSelectB),.o_num(datapathB));

    datapathALU ALU(.S(i_ALUop),.A(datapathA),.B(datapathB),.F(o_datapathALU));

    


endmodule