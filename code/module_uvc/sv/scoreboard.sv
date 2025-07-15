class spi_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(spi_scoreboard)

    function new (string name = "spi_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    
endclass: scoreboard