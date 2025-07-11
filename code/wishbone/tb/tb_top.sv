interface wish_if(input bit clk);
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

endinterface: wish_if

module tb_top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wish_pkg::*;
    `include "spi_env.sv"
    `include "spi_test.sv"

  bit clk;

  initial clk = 0;
  always #5 clk = ~clk;

wish_if w_if(clk);

initial begin
     uvm_config_db#(virtual wish_if)::set(null,"*", "vif", w_if);
    run_test("spi_test");
end

endmodule: tb_top