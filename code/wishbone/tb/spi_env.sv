class spi_env extends uvm_env;
    `uvm_component_utils(spi_env)

    function new (string name = "spi_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    wish_env wishbone;

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        wishbone = wish_env::type_id::create("wishbone", this);
        `uvm_info(get_type_name(), "BUILD PHASE OF RUNNING ...", UVM_LOW)
    endfunction: build_phase

endclass: spi_env