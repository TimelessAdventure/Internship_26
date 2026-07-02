`timescale 1ns/1ps

module passkey(
    input clk, rst, din, s,
    output reg y
);

localparam LOAD_KEY  = 2'b00;
localparam LOAD_PASS = 2'b01;
localparam COMPARE   = 2'b10;

reg [1:0] state;
reg [2:0] bit_cnt;
reg [7:0] store;
reg [7:0] enter;

always @(posedge clk) begin
    if (rst) begin
        state    <= LOAD_PASS;
        bit_cnt  <= 0;
        enter <= 8'b0;
        y        <= 0;
    end else begin
        case (state)

            LOAD_KEY: begin
                store <= {din, store[7:1]};
                bit_cnt <= bit_cnt + 1;
                if (bit_cnt == 7) begin
                    bit_cnt <= 0;
                    state   <= LOAD_PASS;
                end
            end

            LOAD_PASS: begin
                if (~s) begin
                    state   <= LOAD_KEY;
                    bit_cnt <= 0;
                end else begin
                    enter <= {din, enter[7:1]};
                    bit_cnt  <= bit_cnt + 1;
                    if (bit_cnt == 7) begin
                        bit_cnt <= 0;
                        state   <= COMPARE;
                    end
                end
            end

            COMPARE: begin
                y     <= (store == enter) ? 1 : 0;
                state <= LOAD_PASS;
            end

        endcase
    end
end
endmodule
