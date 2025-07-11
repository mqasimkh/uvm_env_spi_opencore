class spi_env extends uvm_env;
    `uvm_component_utils(spi_env)

    function new (string name = "spi_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "BUILD PHASE OF UVM_ENV RUNNING", UVM_LOW)
    endfunction: build_phase

endclass: spi_env