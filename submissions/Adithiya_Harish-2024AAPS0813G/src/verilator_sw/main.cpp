#include <iostream>
#include <iomanip>
#include "verilated.h"
#include "Vstopwatch_top.h"

Vstopwatch_top* top;

void tick(int cycles) {
    for (int i = 0; i < cycles; i++) {
        top->clk = 0;
        top->eval();
        top->clk = 1;
        top->eval();
    }
}

void print_status() {
    std::cout << "Time: " 
              << std::setfill('0') << std::setw(2) << (int)top->minutes << ":"
              << std::setfill('0') << std::setw(2) << (int)top->seconds 
              << " | Status: " << (int)top->status 
              << std::endl;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    top = new Vstopwatch_top;

    top->rst_n = 0;
    top->start = 0;
    top->stop = 0;
    top->reset = 0;
    tick(5);
    top->rst_n = 1;
    
    print_status();

    top->start = 1;
    tick(1);
    top->start = 0;

    std::cout << "Waiting for 65 cycles..." << std::endl;
    tick(65);       
    print_status();

    top->stop = 1;
    tick(1);
    top->stop = 0;
    
    tick(5);
    print_status();


    top->start = 1;
    tick(1);
    top->start = 0;


    top->reset = 1;
    tick(1);
    top->reset = 0;
    tick(1);
    
    print_status();

    std::cout << "End of Program" << std::endl;

    delete top;
    return 0;
}