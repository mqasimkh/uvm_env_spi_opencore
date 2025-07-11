class spi_agent extends uvm_agent;
    `uvm_component_utils(spi_agent)

    function new (string name = "spi_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    spi_driver driver;
    spi_monitor monitor;
    spi_sequencer sequencer;

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        driver = spi_driver::type_id::create("spi_driver", this);
        monitor = spi_monitor::type_id::create("spi_monitor", this);
        sequencer = spi_sequencer::type_id::create("spi_sequencer", this);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING ...", UVM_LOW)
    endfunction: build_phase

    function void connect_phase (uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction: connect_phase

endclass: spi_agent