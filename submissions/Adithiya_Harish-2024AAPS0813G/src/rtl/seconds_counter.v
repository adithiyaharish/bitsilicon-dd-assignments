module seconds_counter (
    input  wire clk,
    input  wire rst_n,
    input  wire clear,
    input  wire enable,
    output reg[5:0] seconds,
    output reg overflow_tick
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            seconds <= 6'd0;
            overflow_tick <= 1'b0;
        end
        else if (clear) begin
            seconds <= 6'd0;
            overflow_tick <= 1'b0;
        end
        else if (enable) begin
            if (seconds == 6'd59) begin
                seconds <= 6'd0;
                overflow_tick <= 1'b1;
            end 
            else begin
                seconds <= seconds + 1'b1;
                overflow_tick <= 1'b0;
            end
        end
        else begin
            overflow_tick <= 1'b0;
        end
    end
endmodule
