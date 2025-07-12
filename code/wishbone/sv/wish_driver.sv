class wish_driver extends uvm_driver #(wish_packet);
    `uvm_component_utils(wish_driver)

    function new (string name = "wish_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual wish_if vif;
    int n_wpkt;

    function void build_phase (uvm_phase phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING ...", UVM_LOW)
    endfunction: build_phase

    task run_phase(uvm_phase phase);

        if (vif == null)
        `uvm_fatal(get_type_name(), "Driver VIF is NULL in run_phase!")

        forever begin
            @(negedge vif.clk_i);
            seq_item_port.get_next_item(req);
            checking_packets(req);
            //#5ns;
            @(posedge vif.clk_i);
            seq_item_port.item_done(req);
        end
    endtask: run_phase

    function void connect_phase (uvm_phase phase);
        if (!uvm_config_db#(virtual wish_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "VIF in DRIVER is NOT SET")
    endfunction: connect_phase

    task checking_packets(wish_packet req);
            vif.adr_i = req.adr_i;
            vif.dat_i = req.dat_i;

            req.cyc_i = 1;
            req.stb_i = 1;

            vif.cyc_i = req.cyc_i;
            vif.stb_i = req.stb_i;

        `uvm_info(get_type_name(), $sformatf("Packet SENT: \n%s", req.sprint()), UVM_LOW)
        n_wpkt++;
    endtask: checking_packets

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("DRIVER : Wishbone Packets SENT : %0d", n_wpkt), UVM_LOW)
    endfunction : report_phase

endclass: wish_driver