module stopwatch_top (
    input  wire clk,
    input  wire rst_n,   // active-low reset
    input  wire start,
    input  wire stop,
    input  wire reset,
    output wire[7:0] minutes,
    output wire[5:0] seconds,
    output wire[1:0] status
);

    wire count_en;
    wire clear_timers;
    wire overflow;

    control_fsm u_fsm (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .stop(stop),
        .reset(reset),
        .count_en(count_en),
        .clear_timers(clear_timers),
        .status(status)
    );

    seconds_counter u_seconds (
        .clk(clk),
        .rst_n(rst_n),
        .clear(clear_timers),
        .enable(count_en),
        .seconds(seconds),
        .overflow_tick(overflow)
    );

    minutes_counter u_minutes (
        .clk(clk),
        .rst_n(rst_n),
        .clear(clear_timers),
        .enable(overflow),
        .minutes(minutes)
    );

endmodule
