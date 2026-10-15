`timescale 1ns / 1ps

module vedic32x32_power_tb;

    reg  [31:0] A;
    reg  [31:0] B;
    reg         ground;

    wire [63:0] Prod;
    wire        overflow;

    // Instantiate the multiplier and connect every port.
    vedic32x32 DUT (
        .A(A),
        .B(B),
        .Prod(Prod),
        .ground(ground),
        .overflow(overflow)
    );

    initial begin
        $dumpfile("vedic32x32_power.vcd");
        $dumpvars(0, vedic32x32_power_tb);

        // Initial condition
        A = 32'h00000000;
        B = 32'h00000000;
        ground = 1'b0;
        #20;

        // Representative operand patterns
        A = 32'h00000444; B = 32'h00000444; #50;
        A = 32'h00004445; B = 32'h00004445; #50;
        A = 32'h00001136; B = 32'h00001136; #50;
        A = 32'h00003202; B = 32'h00003202; #50;
        A = 32'h00000009; B = 32'h00000009; #50;

        // Additional patterns to exercise more internal transitions
        A = 32'hFFFFFFFF; B = 32'h00000001; #50;
        A = 32'hAAAAAAAA; B = 32'h55555555; #50;
        A = 32'h12345678; B = 32'h9ABCDEF0; #50;
        A = 32'h00000000; B = 32'hFFFFFFFF; #50;
        A = 32'hFFFFFFFF; B = 32'hFFFFFFFF; #50;

        $finish;
    end

    initial begin
        $monitor("time=%0t A=%h B=%h Prod=%h overflow=%b",
                 $time, A, B, Prod, overflow);
    end

endmodule
