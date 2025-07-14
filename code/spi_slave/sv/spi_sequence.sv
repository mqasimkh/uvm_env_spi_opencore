class spi_sequence extends uvm_sequence#(spi_packet);
    `uvm_object_utils(spi_sequence)

    function new (string name = "spi_sequence");
        super.new(name);
    endfunction: new

    function void build_phase (uvm_phase phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING ...", UVM_LOW)
    endfunction: build_phase

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "OBJECTION RAISED", UVM_MEDIUM)
    end
  endtask : pre_body

  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "OBJECTION DROPPED", UVM_MEDIUM)
    end
  endtask : post_body

endclass: spi_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                         test_sequence                                      //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class test_sequence_spi extends spi_sequence;
    `uvm_object_utils(test_sequence_spi)

    function new (string name = "test_sequence_spi");
        super.new(name);
    endfunction: new

    task body();
      `uvm_info(get_type_name(), "Running Sequence test_write_seq ...", UVM_LOW)

      `uvm_create(req)
      req.data_out = 8'b1110101;
      `uvm_send(req)

      `uvm_create(req)
      req.data_out = 8'hFF;
      `uvm_send(req)

      `uvm_create(req)
      req.data_out = 8'hFF;
      `uvm_send(req)

    endtask: body

endclass: test_sequence_spi