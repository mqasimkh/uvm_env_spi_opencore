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

    task run_phase (uvm_phase phase);
        if (vif == null)
            `uvm_fatal(get_type_name(), "Monitor VIF is NULL in run_phase!")

        wait (vif.rst_i == 0);
            `uvm_info(get_type_name(), "RESET Deasserted — Starting MONITOR", UVM_LOW)

        //@(posedge vif.clk_i);
        forever begin
            @(posedge vif.clk_i);
            //@(posedge vif.ack_o);
            if (vif.cyc_i && vif.stb_i) begin
                `uvm_info(get_type_name(), $sformatf("@%0t: Valid Transaction Detected, ack_o=%b", $time, vif.ack_o), UVM_HIGH)
                wait (vif.ack_o == 1)
                `uvm_info(get_type_name(), $sformatf("@%0t: Acknowledgment Received", $time), UVM_HIGH)
                wpkt = wish_packet::type_id::create("wpkt", this);
                collect_packet(wpkt);
            end
        //@(posedge vif.clk_i);
        end
    endtask: run_phase

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("MONITOR : Wishbone Packets Collected : %0d", n_wpkt), UVM_LOW)
    endfunction : report_phase


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////                        monitor_methods                                     ///////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    task collect_packet(wish_packet wpkt);
        if (vif.we_i)
            wpkt.operation = WRITE;
        else
            wpkt.operation = READ;

        wpkt.adr_i = vif.adr_i;
        wpkt.dat_i = vif.dat_i;
        wpkt.dat_o = vif.dat_o;
        wpkt.cyc_i = vif.cyc_i;
        wpkt.stb_i = vif.stb_i;
        wpkt.we_i =  vif.we_i;

        `uvm_info(get_type_name(), $sformatf("Packet COLLECTED :\n%s", wpkt.sprint()), UVM_LOW)

        if (wpkt.operation == WRITE) begin
            $display("***************************************************************************************");
            $display("[WRITE] PACKET COLLECTED DETAILS: adr = %b | we_i = %b | dat_i = %b | ack_o = %b", wpkt.adr_i, wpkt.we_i, wpkt.dat_i, vif.ack_o);
            $display("***************************************************************************************");
            `uvm_info(get_type_name(), $sformatf("*** TRANSACTION # %0d COMPLETE ***", n_wpkt+1), UVM_LOW)
        end
        else if ((wpkt.operation == READ)) begin
            $display("***************************************************************************************");
            $display("[READ] PACKET COLLECTED DETAILS: adr = %b | we_i = %b | dat_o = %b | ack_o = %b", wpkt.adr_i, wpkt.we_i, wpkt.dat_o, vif.ack_o);
            $display("***************************************************************************************");
            `uvm_info(get_type_name(), $sformatf("*** TRANSACTION # %0d COMPLETE ***", n_wpkt+1), UVM_LOW)
        end
        n_wpkt++;
    endtask: collect_packet

endclass: wish_monitor