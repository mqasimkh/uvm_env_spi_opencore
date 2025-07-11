module tb_top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wish_pkg::*;
    `include "spi_env.sv"
    `include "spi_test.sv"

    wish_packet w1;
    bit ok;

initial begin
     run_test("spi_test");
end

endmodule: tb_top