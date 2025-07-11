typedef enum {READ, WRITE, IDLE} op_t;

class spi_packet extends uvm_sequence_item;

    bit [7:0] miso;
    bit [7:0] mosi;
    randc op_t operation;

    `uvm_object_utils_begin(spi_packet)
        `uvm_field_enum(op_t, operation, UVM_ALL_ON)
        `uvm_field_int(miso, UVM_ALL_ON)
        `uvm_field_int(mosi, UVM_ALL_ON)
    `uvm_object_utils_end

    function new (string name ="spi_packet");
        super.new(name);
    endfunction: new

endclass: spi_packet