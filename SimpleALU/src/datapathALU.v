module datapathALU(
    input [2:0] S,
    input [6:0] A, B,
    output reg [8:0] F
);

    always @ (S or A or B) begin
        case (S)
            2'd0: F=A;
            2'd1: F=B;
            2'd2: F=A+B;
            2'd3: F=A-B;
            default F=A;
        endcase
    end
endmodule