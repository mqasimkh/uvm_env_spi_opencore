package wish_pkg;

    //typedef uvm_config_db#(virtual wish_if) wish_vif_config;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "wish_packet.sv"
    `include "wish_sequence.sv"
    `include "wish_sequencer.sv"
    `include "wish_driver.sv"
    `include "wish_monitor.sv"
    `include "wish_agent.sv"
    `include "wish_env.sv"

endpackage: wish_pkg