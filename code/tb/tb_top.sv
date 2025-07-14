module tb_top;

  initial $timeformat(-9, 0, " ns", 6);

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import wish_pkg::*;
  import spi_pkg::*;
  `include "top_env.sv"
  `include "top_test.sv"

  logic clk;
  logic rst;
  //bit ss_o;


  initial clk = 0;
  always #5 clk = ~clk;

  //interface
  wish_if w_if(clk, rst);
  spis_if s_if();

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

    .sck_o(s_if.sck_o),        
    .ss_o(s_if.ss_o),     
    .mosi_o(s_if.mosi_o),       
    .miso_i(s_if.miso_i)      
  );

  //clock generation
  initial begin
    rst = 1;
    #10;
    rst = 0;
  end

  //config db set vif
  initial begin
    uvm_config_db#(virtual wish_if)::set(null,"uvm_test_top.spi.wishbone.*", "vif", w_if);
    uvm_config_db#(virtual spis_if)::set(null,"uvm_test_top.spi.spi_slave.*", "vif", s_if);
    run_test("top_test");
  end

  initial begin
    w_if.cyc_i  = 0;
    w_if.stb_i  = 0;
    w_if.we_i   = 0;
    w_if.adr_i  = 0;
    w_if.dat_i  = 0;
  end

endmodule: tb_top