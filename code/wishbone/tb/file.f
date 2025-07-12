-timescale 1ns/100ps

//incl all dir's
-incdir ../sv
-incdir ../tb
-incdir ../../spi_core

//uvc dir and if
../sv/wish_pkg.sv
../sv/wish_if.sv

//dut
../../spi_core/fifo4.v
../../spi_core/simple_spi_top.v

//tb_top
tb_top.sv

// +UVM_TESTNAME
+UVM_VERBOSITY=UVM_HIGH