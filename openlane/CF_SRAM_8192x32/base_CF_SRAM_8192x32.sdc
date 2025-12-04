create_clock -name wb_clk_i -period 20.0 [get_ports wb_clk_i]
set_clock_uncertainty 0.25 [get_clocks wb_clk_i]
set_input_delay 1.0 -clock wb_clk_i [all_inputs]
set_output_delay 1.0 -clock wb_clk_i [all_outputs]

