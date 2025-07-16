class spi_driver extends uvm_driver #(spi_packet);
    `uvm_component_utils(spi_driver)

    function new (string name = "spi_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual spis_if vif;
    spi_packet spkt;
    int s_pkt;

    function void build_phase (uvm_phase phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING ...", UVM_LOW)
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        if (vif == null)
            `uvm_fatal(get_type_name(), "SPI_SLAVE Driver VIF is NULL in run_phase!")

        forever begin
            //@(negedge vif.ss_o);
            send_miso();
        end

    endtask: run_phase

    function void connect_phase (uvm_phase phase);
        if (!uvm_config_db#(virtual spis_if)::get(this, "", "vif", vif))
        `uvm_fatal("NOVIF", "VIF in SPI_SLAVE DRIVER is NOT SET")
    endfunction: connect_phase

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("SPI_DRIVER : MISO Data_Packets Sent : %0d", s_pkt), UVM_LOW)
    endfunction : report_phase

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////                          driver_method                                     ///////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    task send_miso();
        seq_item_port.get_next_item(req);
        //req.data_out = 8'hFF;
        for (int i = 7; i >= 0; i--) begin
            @(posedge vif.sck_o);
            vif.miso_i = req.data_out[i];
        end

        seq_item_port.item_done();

         `uvm_info(get_type_name(), $sformatf("SPI_SLAVE DRIVER :\n%s", req.sprint()), UVM_LOW)
        s_pkt++;
    endtask: send_miso

endclass: spi_driver