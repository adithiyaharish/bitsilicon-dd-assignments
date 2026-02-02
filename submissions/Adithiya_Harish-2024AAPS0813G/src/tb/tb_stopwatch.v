`timescale 1ns / 1ps

module tb_stopwatch;

    reg clk;
    reg rst_n;
    reg start;
    reg stop;
    reg reset;

    wire[7:0] minutes;
    wire[5:0] seconds;
    wire[1:0] status;

    stopwatch_top uut (
        .clk(clk), 
        .rst_n(rst_n), 
        .start(start), 
        .stop(stop), 
        .reset(reset), 
        .minutes(minutes), 
        .seconds(seconds), 
        .status(status)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 0;
        #20 rst_n = 1;

        start = 1; #10 start = 0;
        #300;

        stop = 1; #10 stop = 0;
        #100;

        start = 1; #10 start = 0;
        #100;

        reset = 1; #10 reset = 0;
        #50;

        $finish;
    end

endmodule