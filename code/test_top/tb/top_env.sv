class top_env extends uvm_env;
    `uvm_component_utils(top_env)

    function new (string name = "top_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    wish_env wishbone;
    spis_env spi_slave;
    spi_scoreboard scoreboard;

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        wishbone = wish_env::type_id::create("wishbone", this);
        spi_slave = spis_env::type_id::create("spi_slave", this);
        scoreboard = spi_scoreboard::type_id::create("spi_scoreboard", this);
        `uvm_info(get_type_name(), "BUILD PHASE OF RUNNING ...", UVM_LOW)
    endfunction: build_phase
    
    function void connect_phase (uvm_phase phase);
        wishbone.agent.monitor.wish_collect_port.connect(scoreboard.wish);
        spi_slave.agent.monitor.spi_collect_port.connect(scoreboard.spi);
    endfunction: connect_phase

endclass: top_env