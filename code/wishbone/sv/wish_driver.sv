class wish_driver extends uvm_driver #(wish_packet);
    `uvm_component_utils(wish_driver)

    function new (string name = "wish_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual wish_if vif;

    function void build_phase (uvm_phase phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING ...", UVM_LOW)
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            checking_packets(req);
            seq_item_port.item_done(req);
        end
    endtask: run_phase

    function void connect_phase (uvm_phase phase);
        if (!uvm_config_db#(virtual wish_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "VIF in DRIVER is NOT SET")
    endfunction: connect_phase

    task checking_packets(wish_packet req);
        `uvm_info(get_type_name(), $sformatf("Packet SENT: \n%s", req.sprint()), UVM_LOW)
    endtask: checking_packets

endclass: wish_driver