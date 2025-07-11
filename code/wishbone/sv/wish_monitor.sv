class wish_monitor extends uvm_monitor;
    `uvm_component_utils(wish_monitor)

    function new (string name = "wish_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    wish_packet wpkt;
    int n_wpkt;
    virtual wish_if vif;

    function void build_phase (uvm_phase phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING ...", UVM_LOW)
    endfunction: build_phase
    
    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Running Simulation ...", UVM_LOW);
    endfunction: start_of_simulation_phase

    function void connect_phase (uvm_phase phase);
        if (!uvm_config_db#(virtual wish_if)::get(this, "", "vif", vif))
        `uvm_fatal("NOVIF", "VIF in MONITOR is NOT SET")
    endfunction: connect_phase

    // task run_phase (uvm_phase phase);
    //     forever begin
    //         wpkt = wish_packet::type_id::create("wpkt", this);
    //         `uvm_info(get_type_name(), $sformatf("Packet COLLECTED :\n%s", wpkt.sprint()), UVM_LOW)
    //         n_wpkt++;
    //     end
    // endtask: run_phase

    // function void report_phase(uvm_phase phase);
    //     `uvm_info(get_type_name(), $sformatf("MONITOR : Wishbone Packets Collected : %0d", n_wpkt), UVM_LOW)
    // endfunction : report_phase

endclass: wish_monitor