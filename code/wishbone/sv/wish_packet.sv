typedef enum {READ, WRITE, IDLE} op_t;

class wish_packet extends uvm_sequence_item;

    rand bit [7:0] dat_i;
    rand bit [1:0] adr_i;
    bit [7:0] dat_o;
    randc op_t operation;

    bit clk_i;
    bit rst_i;
    bit cyc_i;
    bit stb_i;
    bit we_i;

    bit inta_o;
    bit ack_o;

    `uvm_object_utils_begin(wish_packet)
        `uvm_field_enum(op_t, operation, UVM_ALL_ON)
        `uvm_field_int(adr_i, UVM_ALL_ON)
        `uvm_field_int(dat_i, UVM_ALL_ON)
        
        // `uvm_field_int(clk_i, UVM_ALL_ON)
        // `uvm_field_int(rst_i, UVM_ALL_ON)
        // `uvm_field_int(cyc_i, UVM_ALL_ON)
        `uvm_field_int(stb_i, UVM_ALL_ON)
        `uvm_field_int(we_i, UVM_ALL_ON)

        // `uvm_field_int(inta_o, UVM_ALL_ON)
        // `uvm_field_int(ack_o, UVM_ALL_ON)
        // `uvm_field_int(dat_o, UVM_ALL_ON)
        
    `uvm_object_utils_end

    function new (string name ="wish_packet");
        super.new(name);
    endfunction: new

endclass: wish_packet