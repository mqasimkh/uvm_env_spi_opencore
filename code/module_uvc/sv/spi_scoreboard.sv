class spi_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(spi_scoreboard)

    `uvm_analysis_imp_decl(_wish)
    `uvm_analysis_imp_decl(_spi)

    uvm_analysis_imp_wish #(wish_packet, spi_scoreboard) wish;
    uvm_analysis_imp_spi #(spi_packet, spi_scoreboard) spi;

    int received;
    int matched;
    int wrong;

    wish_packet wish_q[$];
    spi_packet spi_q[$];
    
    function new (string name = "spi_scoreboard", uvm_component parent);
        super.new(name, parent);
        wish = new("wish", this);
        spi = new ("spi", this);
    endfunction: new

////////////////////////////////////////////////////////////////////////
//                        write_wish
////////////////////////////////////////////////////////////////////////

    function void write_wish (input wish_packet wpkt);
        wish_packet wpkt_copy;
        $cast(wpkt_copy, wpkt.clone());
        if (wpkt_copy.adr_i == 3'b010) begin
            wish_q.push_back(wpkt_copy);
            `uvm_info(get_type_name(), $sformatf("Wishbone transaction added: dat_i = %0h, adr_i = %0b", wpkt_copy.dat_i, wpkt_copy.adr_i), UVM_LOW)
        end
        compare_transactions();
    endfunction: write_wish

////////////////////////////////////////////////////////////////////////
//                        write_spi
////////////////////////////////////////////////////////////////////////

    function void write_spi(input spi_packet spkt);
        spi_packet spkt_copy;
        $cast(spkt_copy, spkt.clone());
        spi_q.push_back(spkt_copy);
        `uvm_info(get_type_name(), $sformatf("SPI transaction added: data_in = %0h", spkt_copy.data_in), UVM_LOW)
        compare_transactions();
    endfunction: write_spi

////////////////////////////////////////////////////////////////////////
//                        check_transactions
////////////////////////////////////////////////////////////////////////

    function void compare_transactions();
        while (wish_q.size() > 0 && spi_q.size() > 0) begin
            wish_packet wpkt = wish_q.pop_front();
            spi_packet spkt = spi_q.pop_front();
            
            received++;
            `uvm_info(get_type_name(), $sformatf("Comparing: Wish dat_i = %0h, adr_i = %0b | SPI data_in = %0h", wpkt.dat_i, wpkt.adr_i, spkt.data_in), UVM_LOW)

            if (wpkt.adr_i == 3'b010) begin
                if (wpkt.dat_i == spkt.data_in) begin
                    `uvm_info(get_type_name(), "DATA MATCHED", UVM_LOW)
                    matched++;
                end
                else begin
                    `uvm_info(get_type_name(), $sformatf("DATA MISMATCH: Expected %0h, Got %0h", wpkt.dat_i, spkt.data_in), UVM_LOW)
                    wrong++;
                end
            end
        end
    endfunction: compare_transactions

////////////////////////////////////////////////////////////////////////
//                        report_phase
////////////////////////////////////////////////////////////////////////

    function void report_phase (uvm_phase phase);
        $display("===============================================================================================================================================");
        $display("                                                      SCOREBOARD REPORT                                                                        ");
        $display("===============================================================================================================================================");
        `uvm_info(get_type_name(), $sformatf("Total Packets Received\t:   %0d", received), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Total Packets Matched\t:   %0d", matched), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Total Packets Mis-Matched\t:   %0d", wrong), UVM_LOW)
        $display("------------------------------------------------------------------------------------------------------------------------------------------------");
    endfunction: report_phase

endclass: spi_scoreboard