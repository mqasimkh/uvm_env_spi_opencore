class spi_driver extends uvm_driver #(spi_packet);
    `uvm_component_utils(spi_driver)

    function new (string name = "spi_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING ...", UVM_LOW)
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            checking_packets(req);
            seq_item_port.item_done(req);
        end
    endtask: run_phase

    task checking_packets(spi_packet req);
        `uvm_info(get_type_name(), $sformatf("Packet is \n%s", req.sprint()), UVM_LOW)
    endtask: checking_packets

endclass: spi_driver