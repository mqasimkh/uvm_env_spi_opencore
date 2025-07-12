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
            //send_packets(req);
            //#5ns;
            if (req.operation == READ)
                read_tr(req);
            else if (req.operation == WRITE)
                write_tr(req);
            else
                idle_tr(req);
            @(posedge vif.clk_i);
            seq_item_port.item_done(req);
        end
    endtask: run_phase

    function void connect_phase (uvm_phase phase);
        if (!uvm_config_db#(virtual wish_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "VIF in DRIVER is NOT SET")
    endfunction: connect_phase

    task send_packets(wish_packet req);
            vif.adr_i = req.adr_i;
            vif.dat_i = req.dat_i;

            req.cyc_i = 1;
            req.stb_i = 1;

            vif.cyc_i = req.cyc_i;
            vif.stb_i = req.stb_i;

        `uvm_info(get_type_name(), $sformatf("Packet SENT: \n%s", req.sprint()), UVM_LOW)
        n_wpkt++;
    endtask: send_packets


    task read_tr (wish_packet req);
        vif.adr_i = req.adr_i;
        //vif.dat_i = req.dat_i;
        req.cyc_i = 1;
        req.stb_i = 1;
        req.we_i = 0;
        vif.cyc_i = req.cyc_i;
        vif.stb_i = req.stb_i;
        vif.we_i = req.we_i;
        `uvm_info(get_type_name(), $sformatf("READ Packet SENT: \n%s", req.sprint()), UVM_LOW)
            n_wpkt++;
    endtask: read_tr

    task write_tr (wish_packet req);
        vif.adr_i = req.adr_i;
        vif.dat_i = req.dat_i;
        req.cyc_i = 1;
        req.stb_i = 1;
        req.we_i = 1;
        vif.cyc_i = req.cyc_i;
        vif.stb_i = req.stb_i;
        vif.we_i = req.we_i;
        `uvm_info(get_type_name(), $sformatf("WRITE Packet SENT: \n%s", req.sprint()), UVM_LOW)
            n_wpkt++;
    endtask: write_tr

    task idle_tr (wish_packet req);
        vif.adr_i = req.adr_i;
        vif.dat_i = req.dat_i;
        req.cyc_i = 1;
        req.stb_i = 1;
        vif.cyc_i = req.cyc_i;
        vif.stb_i = req.stb_i;
        `uvm_info(get_type_name(), $sformatf("IDLE Packet SENT: \n%s", req.sprint()), UVM_LOW)
            n_wpkt++;
    endtask: idle_tr

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("DRIVER : Wishbone Packets SENT : %0d", n_wpkt), UVM_LOW)
    endfunction : report_phase

endclass: wish_driver