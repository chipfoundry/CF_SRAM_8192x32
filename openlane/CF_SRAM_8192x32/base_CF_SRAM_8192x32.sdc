create_clock -name wb_clk_i -period 25.0 [get_ports wb_clk_i]

# Clock non-idealities
set_propagated_clock [all_clocks]
set_clock_uncertainty 0.25 [get_clocks wb_clk_i]
set_max_transition 1.25 [current_design]
set_clock_transition 0.9 [get_clocks wb_clk_i]

# Maximum fanout
set_max_fanout 6 [current_design]

# Timing paths delays derate
set_timing_derate -early 0.97 [current_design]
set_timing_derate -late 1.03 [current_design]

# Reset input delay
set_input_delay [expr $::env(CLOCK_PERIOD) * 0.5] -clock [get_clocks wb_clk_i] [get_ports {wb_rst_i}]

# Multicycle paths
set_multicycle_path -setup 2 -through [get_ports {wbs_ack_o}]
set_multicycle_path -hold 1  -through [get_ports {wbs_ack_o}]
set_multicycle_path -setup 2 -through [get_ports {wbs_cyc_i}]
set_multicycle_path -hold 1  -through [get_ports {wbs_cyc_i}]
set_multicycle_path -setup 2 -through [get_ports {wbs_stb_i}]
set_multicycle_path -hold 1  -through [get_ports {wbs_stb_i}]

#------------------------------------------#
# Retrieved Constraints
#------------------------------------------#

# Clock source latency
set clk_max_latency 5.57
set clk_min_latency 4.65
set_clock_latency -source -max $clk_max_latency [get_clocks wb_clk_i]
set_clock_latency -source -min $clk_min_latency [get_clocks wb_clk_i]

# Clock input Transition
set clk_tran 0.61
set_input_transition $clk_tran [get_ports wb_clk_i]

# Input delays
set_input_delay -max 3.17 -clock [get_clocks wb_clk_i] [get_ports {wbs_sel_i[*]}]
set_input_delay -max 3.74 -clock [get_clocks wb_clk_i] [get_ports {wbs_we_i}]
set_input_delay -max 3.89 -clock [get_clocks wb_clk_i] [get_ports {wbs_adr_i[*]}]
set_input_delay -max 4.13 -clock [get_clocks wb_clk_i] [get_ports {wbs_stb_i}]
set_input_delay -max 4.61 -clock [get_clocks wb_clk_i] [get_ports {wbs_dat_i[*]}]
set_input_delay -max 4.74 -clock [get_clocks wb_clk_i] [get_ports {wbs_cyc_i}]
set_input_delay -min 0.79 -clock [get_clocks wb_clk_i] [get_ports {wbs_adr_i[*]}]
set_input_delay -min 1.04 -clock [get_clocks wb_clk_i] [get_ports {wbs_dat_i[*]}]
set_input_delay -min 1.19 -clock [get_clocks wb_clk_i] [get_ports {wbs_sel_i[*]}]
set_input_delay -min 1.65 -clock [get_clocks wb_clk_i] [get_ports {wbs_we_i}]
set_input_delay -min 1.69 -clock [get_clocks wb_clk_i] [get_ports {wbs_cyc_i}]
set_input_delay -min 1.86 -clock [get_clocks wb_clk_i] [get_ports {wbs_stb_i}]

# Input Transition
set_input_transition -max 0.14  [get_ports {wbs_we_i}]
set_input_transition -max 0.15  [get_ports {wbs_stb_i}]
set_input_transition -max 0.17  [get_ports {wbs_cyc_i}]
set_input_transition -max 0.18  [get_ports {wbs_sel_i[*]}]
set_input_transition -max 0.84  [get_ports {wbs_dat_i[*]}]
set_input_transition -max 0.92  [get_ports {wbs_adr_i[*]}]
set_input_transition -min 0.07  [get_ports {wbs_adr_i[*]}]
set_input_transition -min 0.07  [get_ports {wbs_dat_i[*]}]
set_input_transition -min 0.09  [get_ports {wbs_cyc_i}]
set_input_transition -min 0.09  [get_ports {wbs_sel_i[*]}]
set_input_transition -min 0.09  [get_ports {wbs_we_i}]
set_input_transition -min 0.15  [get_ports {wbs_stb_i}]

# Output delays
set_output_delay -max 3.62 -clock [get_clocks wb_clk_i] [get_ports {wbs_dat_o[*]}]
set_output_delay -max 8.41 -clock [get_clocks wb_clk_i] [get_ports {wbs_ack_o}]
set_output_delay -min 1.13 -clock [get_clocks wb_clk_i] [get_ports {wbs_dat_o[*]}]
set_output_delay -min 1.37 -clock [get_clocks wb_clk_i] [get_ports {wbs_ack_o}]

# Output loads
set_load 0.19 [all_outputs]
