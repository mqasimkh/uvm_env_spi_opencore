-timescale 1ns/100ps

//incl all dir's
-incdir ../../wishbone/sv
-incdir ../../spi_slave/sv
-incdir ../tb
-incdir ../sv
-incdir ../../module_uvc/sv
-incdir ../../spi_core

//wishbone uvc
../../wishbone/sv/wish_pkg.sv
../../wishbone/sv/wish_if.sv

//spi_slave uvc
../../spi_slave/sv/spi_pkg.sv
../../spi_slave/sv/spis_if.sv

//dut
../../spi_core/fifo4.v
../../spi_core/simple_spi_top.v

tb_top.sv

// +UVM_TESTNAME
+UVM_VERBOSITY=UVM_HIGH