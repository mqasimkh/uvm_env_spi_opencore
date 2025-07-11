class wish_agent extends uvm_agent;
    `uvm_component_utils(wish_agent)

    function new (string name = "wish_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    wish_driver driver;
    wish_monitor monitor;
    wish_sequencer sequencer;

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        driver = wish_driver::type_id::create("wish_driver", this);
        monitor = wish_monitor::type_id::create("wish_monitor", this);
        sequencer = wish_sequencer::type_id::create("sequencer", this);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING ...", UVM_LOW)
    endfunction: build_phase

    function void connect_phase (uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction: connect_phase

endclass: wish_agent