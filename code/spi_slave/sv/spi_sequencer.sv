class spi_sequencer extends uvm_sequencer#(spi_packet);
    `uvm_component_utils(spi_sequencer)

    function new (string name = "spi_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING ...", UVM_LOW)
    endfunction: build_phase

endclass: spi_sequencer