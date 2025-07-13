class spi_packet extends uvm_sequence_item;

    bit [7:0] data_in;
    bit [7:0] data_out;
    bit miso;
    bit mosi;

    `uvm_object_utils_begin(spi_packet)
        `uvm_field_int(data_in, UVM_ALL_ON)
        `uvm_field_int(data_out, UVM_ALL_ON)
    `uvm_object_utils_end

    function new (string name ="spi_packet");
        super.new(name);
    endfunction: new

endclass: spi_packet