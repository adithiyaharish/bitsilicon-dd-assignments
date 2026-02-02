VERILATOR = verilator
CXX = g++

RTL_DIR = ../rtl
OBJ_DIR = obj_dir

TOP_MODULE = stopwatch_top
VERILOG_SOURCES = $(RTL_DIR)/stopwatch_top.v \
                  $(RTL_DIR)/control_fsm.v \
                  $(RTL_DIR)/seconds_counter.v \
                  $(RTL_DIR)/minutes_counter.v
CPP_SOURCE = main.cpp

VERILATOR_FLAGS = -Wall -Wno-EOFNEWLINE --cc --exe --build -j 4 -CFLAGS "-std=c++17"

.PHONY: all run clean

all: $(OBJ_DIR)/V$(TOP_MODULE)

$(OBJ_DIR)/V$(TOP_MODULE): $(VERILOG_SOURCES) $(CPP_SOURCE)
	$(VERILATOR) $(VERILATOR_FLAGS) -I$(RTL_DIR) $(VERILOG_SOURCES) $(CPP_SOURCE)

run: all
	@echo "--- Running Software Co-Design Simulation ---"
	./$(OBJ_DIR)/V$(TOP_MODULE)

clean:
	rm -rf $(OBJ_DIR)