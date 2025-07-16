
class mcsequence extends uvm_sequence;
    `uvm_object_utils(mcsequence)
    `uvm_declare_p_sequencer(mcsequencer)

    test_write_seq wish_write;
    test_sequence_spi wpi_write;

    function new (string name = "mcsequence");
        super.new(name);
    endfunction: new

    task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
    // in UVM1.2, get starting phase from method
        phase = get_starting_phase();
    `else
        phase = starting_phase;
    `endif
    if (phase != null) begin
        phase.raise_objection(this, get_type_name());
        `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
    endtask : pre_body

    virtual task body();
    super.body();
    `uvm_info(get_type_name(), "Executing mcsequence sequence", UVM_LOW)
    fork
        `uvm_do_on(wish_write, p_sequencer.wish)
        `uvm_do_on(wpi_write, p_sequencer.spi)
    join
    endtask: body

    task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
    // in UVM1.2, get starting phase from method
        phase = get_starting_phase();
    `else
        phase = starting_phase;
    `endif
    if (phase != null) begin
        phase.drop_objection(this, get_type_name());
        `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
    endtask : post_body

endclass: mcsequence

//---------------------------------------------------------------------------
//                          sequence
//---------------------------------------------------------------------------

class write_test extends mcsequence;

endclass: write_test