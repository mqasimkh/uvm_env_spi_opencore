class spi_test extends uvm_test;
    `uvm_component_utils(spi_test)

    function new (string name = "spi_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    spi_env spi;

    function void build_phase (uvm_phase phase);
        //uvm_config_wrapper::set(this, "spi.wishbone.agent.sequencer.run_phase","default_sequence",test_sequence::get_type());
        super.build_phase(phase);
        spi = spi_env::type_id::create("spi", this);
        `uvm_info(get_type_name(), "BUILD PHASE OF RUNNING ...", UVM_LOW)
    endfunction: build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction: end_of_elaboration_phase

endclass: spi_test