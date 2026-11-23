module InputIncrement(i_clk,i_rst,i_load,i_newOp,i_muxSelect,o_num);
    input i_clk,i_rst,i_load,i_newOp;
    input [1:0] i_muxSelect;
    output[6:0] o_num;

    parameter add_1 = 7'd1;
    parameter add_5 = 7'd5;
    parameter add_10 = 7'd10;


    reg [6:0] register;
    reg [6:0] next_register;

    assign o_num = register;
    
    always@(register or i_muxSelect)begin
        case(i_muxSelect)
            2'd0: next_register = register + add_1;
            2'd1: next_register = register + add_5;
            2'd2: next_register = register + add_10;
            default: next_register = register;
        endcase
        if(next_register >=100) next_register = 7'd0;
    end
    

    always@(posedge i_clk or posedge i_rst)begin
        if(i_rst)
            register <= 7'd0;
        else if(i_newOp)
            register <= 7'd0;
        else if (i_load)
            register <= next_register;
    end
    

endmodule