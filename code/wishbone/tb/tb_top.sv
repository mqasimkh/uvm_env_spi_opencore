module tb_top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wish_pkg::*;
    `include "spi_env.sv"
    `include "spi_test.sv"

    wish_packet w1;
    bit ok;

initial begin
    w1 = new ("w1");
   
    repeat(5) begin
        ok = w1.randomize();
        assert (ok) else $display("Randomization Failed");
        w1.print();
    end

     run_test("spi_test");
end

endmodule: tb_top