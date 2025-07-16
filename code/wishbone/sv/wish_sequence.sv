class wish_sequence extends uvm_sequence#(wish_packet);
    `uvm_object_utils(wish_sequence)

    function new (string name = "wish_sequence");
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
      //#450;
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "OBJECTION DROPPED", UVM_MEDIUM)
    end
  endtask : post_body

endclass: wish_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                         test_sequence-1                                      //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class test_sequence extends wish_sequence;
    `uvm_object_utils(test_sequence)

    function new (string name = "test_sequence");
        super.new(name);
    endfunction: new

    task body();
        `uvm_info(get_type_name(), "Running Sequence test_sequence ...", UVM_LOW)
        repeat(5) begin
            `uvm_do(req)
        end
    endtask: body

endclass: test_sequence

class write_full extends wish_sequence;
    `uvm_object_utils(write_full)

    function new (string name = "write_full");
        super.new(name);
    endfunction: new

    task body();
        `uvm_info(get_type_name(), "Running Sequence write_full ...", UVM_LOW)
        repeat(5) begin
          `uvm_create(req)
          req.operation = WRITE;
          req.adr_i = 3'b10;
          req.dat_i = 8'b111000011;
          `uvm_send(req)
        end
    endtask: body

endclass: write_full

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                         test_sequence-2                                    //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class test_write_seq extends wish_sequence;
  `uvm_object_utils(test_write_seq)

  function new (string name = "test_write");
    super.new(name);
  endfunction: new

  task body();
    `uvm_info(get_type_name(), "Running Sequence test_write_seq ...", UVM_LOW)
      // `uvm_create(req)
      // req.operation = WRITE;
      // req.adr_i = 3'b011;
      // req.dat_i = 8'b00000000;
      // `uvm_send(req)

      `uvm_create(req)
      req.operation = WRITE;
      req.adr_i = 3'b000;
      req.dat_i = 8'b11100000;
      `uvm_send(req)


       `uvm_create(req)
      req.operation = WRITE;
      req.adr_i = 3'b010;
      req.dat_i = 8'hA1;
      `uvm_send(req)

      `uvm_create(req)
      req.operation = WRITE;
      req.adr_i = 3'b010;
      req.dat_i = 8'hA2;
      `uvm_send(req)

      `uvm_create(req)
      req.operation = WRITE;
      req.adr_i = 3'b010;
      req.dat_i = 8'hA3;
      `uvm_send(req)

      `uvm_create(req)
      req.operation = WRITE;
      req.adr_i = 3'b010;
      req.dat_i = 8'hA4;
      `uvm_send(req)

      `uvm_create(req)
      req.operation = WRITE;
      req.adr_i = 3'b010;
      req.dat_i = 8'hA5;
      `uvm_send(req)

      #950;

      `uvm_create(req)
      req.operation = WRITE;
      req.adr_i = 3'b000;
      req.dat_i = 8'b10100000;
      `uvm_send(req)


      // `uvm_create(req)
      // req.operation = WRITE;
      // req.adr_i = 3'b000;
      // req.dat_i = 8'b00000000;
      // `uvm_send(req)

      // `uvm_create(req)
      // req.operation = WRITE;
      // req.adr_i = 3'b000;
      // req.dat_i = 8'b11100000;
      // `uvm_send(req)
      
      // `uvm_create(req)
      // req.operation = WRITE;
      // req.adr_i = 3'b010;
      // req.dat_i = 8'b00110011;
      // `uvm_send(req)
      
      // `uvm_create(req)
      // req.operation = WRITE;
      // req.adr_i = 3'b000;
      // req.dat_i = 8'b10100000;
      // `uvm_send(req)

      // `uvm_create(req)
      // req.operation = WRITE;
      // req.adr_i = 3'b10;
      // req.dat_i = 8'b10101010;
      // `uvm_send(req)

      // `uvm_create(req)
      // req.operation = WRITE;
      // req.adr_i = 3'b10;
      // req.dat_i = 8'b10101010;
      // `uvm_send(req)

      // `uvm_create(req)
      // req.operation = WRITE;
      // req.adr_i = 3'b10;
      // req.dat_i = 8'b10101010;
      // `uvm_send(req)

      // `uvm_create(req)
      // req.operation = WRITE;
      // req.adr_i = 3'b10;
      // req.dat_i = 8'b10101010;
      // `uvm_send(req)

      // `uvm_create(req)
      // req.operation = WRITE;
      // req.adr_i = 3'b10;
      // req.dat_i = 8'b10101010;
      // `uvm_send(req)

      // `uvm_create(req)
      // req.operation = IDLE;
      // req.adr_i = 3'b10;
      // `uvm_send(req)

      // `uvm_create(req)
      // req.operation = READ;
      // req.adr_i = 3'b00;
      // `uvm_send(req)

      // `uvm_create(req)
      // req.operation = WRITE;
      // req.adr_i = 3'b00;
      // req.dat_i = 8'b1101000;
      // `uvm_send(req)

      // `uvm_create(req)
      // req.operation = READ;
      // req.adr_i = 3'b00;
      // `uvm_send(req)

      // `uvm_create(req)
      // req.operation = WRITE;
      // req.adr_i = 3'b00;
      // req.dat_i = 8'b1101000;
      // `uvm_send(req)

      // `uvm_create(req)
      // req.operation = IDLE;
      // req.adr_i = 3'b10;
      // `uvm_send(req)

  endtask: body

endclass: test_write_seq