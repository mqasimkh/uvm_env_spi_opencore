class mcsequencer extends uvm_sequencer;
    `include "mcsequence.sv"
    `uvm_component_utils(mcsequencer)

    wish_sequencer wish;
    spi_sequencer spi;

    function new (string name = "mcsequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Running Simulation ...", UVM_HIGH);
    endfunction: start_of_simulation_phase

endclass