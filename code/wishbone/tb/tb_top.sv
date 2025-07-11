interface wish_if();
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
endinterface: wish_if

module tb_top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wish_pkg::*;
    `include "spi_env.sv"
    `include "spi_test.sv"

virtual wish_if vif;

initial begin
     uvm_config_db#(virtual wish_if)::set(null,"*", "vif", vif);
    run_test("spi_test");
end

endmodule: tb_top