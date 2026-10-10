module scan_chain2_tb;
reg RESET,CLK,SE,SI;
reg[1:0]D;
wire[1:0]Q;
wire SO;

scan_chain2 dut(
    .CLK(CLK),
    .RESET(RESET),
    .SE(SE),
    .SI(SI),
    .D(D),
    .Q(Q),
    .SO(SO)
);

always #5 CLK = ~CLK;

initial begin
    $dumpfile("scan_chain2.vcd");
    $dumpvars(0,scan_chain2_tb);
end 

initial begin
        CLK   = 0;
        RESET = 1;
        SE    = 0;
        SI    = 0;
        D     = 2'b00;

        #12;
        RESET = 0;

       
        @(negedge CLK);
        SE = 0;
        D = 2'b10;

        @(posedge CLK);
        #1;
        $display("Functional: D=%b Q=%b SO=%b", D, Q, SO);

        @(negedge CLK);
        SE = 1;
        SI = 1;

        @(posedge CLK);
        #1;
        $display("Scan 1: SI=%b Q=%b SO=%b", SI, Q, SO);

        @(negedge CLK);
        SI = 0;

        @(posedge CLK);
        #1;
        $display("Scan 2: SI=%b Q=%b SO=%b", SI, Q, SO);

        $display("Simulation Finished!");
        $finish;
    end

endmodule