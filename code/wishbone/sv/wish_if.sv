interface wish_if(input logic clk, input logic rst);

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