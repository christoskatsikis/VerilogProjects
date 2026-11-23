module driver_Button #(
    parameter P_DEADLY_PERIOD = 'd5_000_000
)(
    input  i_clk,
    input  i_rst,
    input  i_button,
    output o_pulse
);

    // 2^23 = 8.388.608 > 5.000.000, αλλά 24 bit για περιθώριο
    reg [23:0] r_cnt;
    reg        r_pulse;
    reg        r_button_sync;
    reg        r_button_sync2;

    assign o_pulse = r_pulse;

    // Συγχρονιστής 2 flip-flops
    always @(posedge i_clk or posedge i_rst) begin
        if (i_rst) begin
            r_button_sync  <= 1'b0;
            r_button_sync2 <= 1'b0;
        end else begin
            r_button_sync  <= i_button;
            r_button_sync2 <= r_button_sync;
        end
    end

    // Debounce: μέτρηση κύκλων που το κουμπί μένει πατημένο
    // Ο μετρητής σταματά στο P_DEADLY_PERIOD
    always @(posedge i_clk or posedge i_rst) begin
        if (i_rst)
            r_cnt <= 24'd0;
        else if (!r_button_sync2)
            r_cnt <= 24'd0;
        else if (r_cnt >= P_DEADLY_PERIOD)
            r_cnt <= r_cnt;
        else
            r_cnt <= r_cnt + 1'b1;
    end

    // Παλμός ενός κύκλου: μόνο καθώς ο μετρητής περνά από την τιμή-στόχο
    always @(posedge i_clk or posedge i_rst) begin
        if (i_rst)
            r_pulse <= 1'b0;
        else
            r_pulse <= (r_cnt == P_DEADLY_PERIOD - 1);
    end

endmodule