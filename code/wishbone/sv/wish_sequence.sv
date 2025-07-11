class wish_sequence extends uvm_sequence;
    `uvm_object_utils(wish_sequence)

    function new (string name = "wish_sequence");
        super.new(name);
    endfunction: new

    function void build_phase (uvm_phase phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING ...", UVM_LOW)
    endfunction: build_phase

endclass: wish_sequence