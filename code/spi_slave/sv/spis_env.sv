class spis_env extends uvm_env;
    `uvm_component_utils(spis_env)

    function new (string name = "spis_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    spi_agent agent;

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        agent = spi_agent::type_id::create("agent", this);
    endfunction: build_phase

endclass: spis_env