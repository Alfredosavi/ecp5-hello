//===========================================================
// PLL Module: 25 MHz input -> 125 MHz output
// Using EHXPLLL (ECP5 FPGA)
//===========================================================

module pll (
    input  wire clk_in,    // 25 MHz input clock
    output wire clk_out,   // 125 MHz output clock
    output wire pll_lock   // PLL lock status
);

    wire clkfb;

    // Instantiate EHXPLLL
    EHXPLLL #(
        .CLKI_DIV(1),               // Input clock divider
        .CLKFB_DIV(5),              // Feedback clock multiplier
        .CLKOP_DIV(5),             // Output clock divider (125 MHz)
        .CLKOP_ENABLE("ENABLED"),   // Enable main output
        .CLKOS_ENABLE("DISABLED"),  // Disable secondary outputs
        .CLKOS2_ENABLE("DISABLED"),
        .CLKOS3_ENABLE("DISABLED"),
        .FEEDBK_PATH("CLKOP")       // Internal feedback path
    ) pll_inst (
        .CLKI(clk_in),
        .CLKFB(clkfb),
        .CLKOP(clk_out),
        .LOCK(pll_lock),
        .RST(1'b0)
    );

    // Connect feedback loop
    assign clkfb = clk_out;

endmodule
