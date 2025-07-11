module tb_top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wish_pkg::*;
    import spi_pkg::*;
    `include "spi_env.sv"
    `include "spi_test.sv"

initial begin
     run_test("spi_test");
end

endmodule: tb_top