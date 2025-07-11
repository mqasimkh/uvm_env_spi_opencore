class wish_sequencer extends uvm_sequencer;
    `uvm_component_utils(wish_sequencer)

    function new (string name = "wish_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING ...", UVM_LOW)
    endfunction: build_phase

endclass: wish_sequencer