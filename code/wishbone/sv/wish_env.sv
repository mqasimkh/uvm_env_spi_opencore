class wish_env extends uvm_env;
    `uvm_component_utils(wish_env)

    function new (string name = "wish_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    wish_agent agent;

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        agent = wish_agent::type_id::create("agent", this);
    endfunction: build_phase

endclass: wish_env