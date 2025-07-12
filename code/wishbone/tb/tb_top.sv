interface wish_if(input bit clk, input bit rst);
  logic clk_i;
  logic rst_i;
  logic cyc_i;         
  logic stb_i;         
  logic [2:0] adr_i;    
  logic we_i;  
  logic [7:0] dat_i; 
  logic [7:0] dat_o;     
  logic ack_o;   
  logic inta_o;

  assign clk_i = clk;
  assign rst_i = rst;

endinterface: wish_if

module tb_top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wish_pkg::*;
    `include "spi_env.sv"
    `include "spi_test.sv"

  bit clk;
  bit rst;

  initial clk = 0;
  always #5 clk = ~clk;

wish_if w_if(clk, rst);

simple_spi dut (
  .clk_i(w_if.clk_i),      
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

initial begin
  rst = 0;
  #10;
  rst = 1;
end

initial begin
     uvm_config_db#(virtual wish_if)::set(null,"*", "vif", w_if);
    run_test("spi_test");
end

endmodule: tb_top