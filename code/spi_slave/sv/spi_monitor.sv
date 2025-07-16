class spi_monitor extends uvm_monitor;
    `uvm_component_utils(spi_monitor)

    uvm_analysis_port #(spi_packet) spi_collect_port;

    function new (string name = "spi_monitor", uvm_component parent);
        super.new(name, parent);
        spi_collect_port = new("spi_collect_port", this);
    endfunction: new

    
    virtual spis_if vif;
    spi_packet spkt;
    int s_pkt;

    function void build_phase (uvm_phase phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING ...", UVM_LOW)
    endfunction: build_phase
    
    task run_phase (uvm_phase phase);
        if (vif == null)
        `uvm_fatal(get_type_name(), "SPI_SLAVE Monitor VIF is NULL in run_phase!")

        forever begin
            //@(negedge vif.ss_o);
            //@(posedge vif.sck_o);
            `uvm_info(get_type_name(), $sformatf("Waiting for next SPI packet... (s_pkt=%0d)", s_pkt), UVM_LOW)
            collect_mosi();
        end

    endtask: run_phase

    function void connect_phase (uvm_phase phase);
        if (!uvm_config_db#(virtual spis_if)::get(this, "", "vif", vif))
        `uvm_fatal("NOVIF", "VIF in SPI_SLAVE MONITOR is NOT SET")
    endfunction: connect_phase

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("SPI_MONITOR : MOSI Data_Packets Recieved : %0d", s_pkt), UVM_LOW)
    endfunction : report_phase


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////                        monitor_methods                                     ///////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    task collect_mosi();
        int i = 7;
        spkt = spi_packet::type_id::create("spkt", this);
        spkt.data_in = 0;

        //for (int i = 7; i >= 0; i--) begin
        repeat (8) begin
        @(posedge vif.sck_o);
        //`uvm_info(get_type_name(), $sformatf("SCK Tick  @%0t", $time), UVM_LOW)
            spkt.data_in[i] = vif.mosi_o;
            spkt.data_out[i] = vif.miso_i;
            i--;
        end

        #1;
        `uvm_info(get_type_name(), $sformatf("SPI_SLAVE MONITOR - DATA COLLECTED :\n%s", spkt.sprint()), UVM_LOW)
        s_pkt++;

        spi_collect_port.write(spkt);

    endtask: collect_mosi

endclass: spi_monitor