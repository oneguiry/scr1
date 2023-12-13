module scr1_tb_log_cmd(
    input logic [`SCR1_XLEN-1:0] csr_mstatus_local,
    input logic [SCR1_CSR_COUNTERS_WIDTH-1:0] csr_mcycle_local,
    input logic [`SCR1_XLEN-1:0] pc_local
);

always_ff @(posedge scr1_top_tb_ahb.i_top.i_imem_ahb.clk) begin
    if (scr1_top_tb_ahb.i_top.i_imem_ahb.imem_resp == 2'b01) begin
        // valid data from ahb router
        if (
            (scr1_top_tb_ahb.i_top.i_core_top.i_pipe_top.i_pipe_ifu.ifu2idu_instr_o[6 : 0] == 7'b0110011) |
            (scr1_top_tb_ahb.i_top.i_core_top.i_pipe_top.i_pipe_ifu.ifu2idu_instr_o[14 : 12] == 3'b110)
        ) begin
            // detect and command
            $display("Detect OR command");
            $display("mstatus=0x%0h", csr_mstatus_local);
            $display("mcycle=0x%0h", csr_mcycle_local);
            $display("pc=0x%0h", pc_local);   
        end
    end
end

endmodule   