class spi_monitor extends uvm_monitor;
    `uvm_component_utils(spi_monitor)

    function new (string name = "spi_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    
    virtual spis_if vif;
    spi_packet spkt;

    function void build_phase (uvm_phase phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING ...", UVM_LOW)
    endfunction: build_phase
    
    task run_phase (uvm_phase phase);
        forever begin
            collect_data();
        end
    endtask: run_phase

    task collect_data();
        @(posedge vif.sck_o);

        for (int i = 8; i > 0; i--) begin
            data_in[i] = vif.mosi;
        end

    endtask: collect_data

endclass: spi_monitor