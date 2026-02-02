module control_fsm (
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    input  wire stop,
    input  wire reset,
    output reg count_en,
    output reg clear_timers,
    output reg  [1:0] status        // 00: IDLE, 01: RUNNING, 10: PAUSED
);

    localparam IDLE    = 2'b00;
    localparam RUNNING = 2'b01;
    localparam PAUSED  = 2'b10;

    reg [1:0] current_state, next_state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;
        count_en = 1'b0;
        clear_timers = 1'b0;
        status = current_state;

        case (current_state)
            IDLE: begin
                clear_timers = 1'b1;
                if (start) begin
                    next_state = RUNNING;
                end
            end

            RUNNING: begin
                count_en = 1'b1;
                if (reset) begin
                    next_state = IDLE;
                end
                else if (stop) begin
                    next_state = PAUSED;
                end
            end

            PAUSED: begin
                if (reset) begin
                    next_state = IDLE;
                end
                else if (start) begin
                    next_state = RUNNING;
                end
            end
            
            default: next_state = IDLE;
        endcase
    end
endmodule
