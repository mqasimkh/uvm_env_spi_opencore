module tb_top;

  initial $timeformat(-9, 0, " ns", 6);

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import wish_pkg::*;
  `include "spi_env.sv"
  `include "spi_test.sv"

  logic clk;
  logic rst;

  initial clk = 0;
  always #5 clk = ~clk;

  //interface
  wish_if w_if(clk, rst);

  //instantiating DUT
  simple_spi dut (
    .clk_i(clk),      
    .rst_i(w_if.rst_i),      
    .cyc_i(w_if.cyc_i),        
    .stb_i(w_if.stb_i),         
    .adr_i(w_if.adr_i),         
    .we_i(w_if.we_i),         
    .dat_i(w_if.dat_i),        
    .dat_o(w_if.dat_o),        
    .ack_o(w_if.ack_o),         
    .inta_o(w_if.inta_o),    

    .sck_o(),        
    .ss_o(),     
    .mosi_o(),       
    .miso_i()      
  );

  //clock generation
  initial begin
    rst = 0;
    #10;
    rst = 1;
  end

  //config db set vif
  initial begin
    uvm_config_db#(virtual wish_if)::set(null,"*", "vif", w_if);
    run_test("spi_test");
  end

  initial begin
    w_if.cyc_i  = 0;
    w_if.stb_i  = 0;
    w_if.we_i   = 0;
    w_if.adr_i  = 0;
    w_if.dat_i  = 0;
  end

endmodule: tb_top