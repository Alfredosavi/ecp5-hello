//===========================================================
// Top Module: test PLL 125MHz with LED blink
//===========================================================

module top (
    input  wire osc25m, 
    input  wire button,
    output wire led
);

    wire clk_125mhz; // Clock 125 MHz
    wire pll_lock;

    // Instantiate PLL
    pll u_pll (
        /* input  wire clk_in,  */  .clk_in     (osc25m),
        /* output wire clk_out, */  .clk_out    (clk_125mhz),
        /* output wire pll_lock */  .pll_lock   (pll_lock)
    );


    //---------------------------------------------------------
    // LED blink logic: 5s ON / 5s OFF
    //---------------------------------------------------------
    reg [29:0] counter;
    reg led_state;

    // Reset signal: button OR PLL not locked
    wire reset_n = pll_lock & button; 

    always @(posedge clk_125mhz or negedge reset_n) begin
        if(!reset_n) begin
            counter <= 0;  // reset counter
            led_state <= 0;  // turn LED OFF
        end else begin
            if (counter == 625_000_000-1) begin
                counter <= 0;
                led_state <= ~led_state; // Toggle LED
            end else begin
                counter <= counter + 1;
            end
        end
    end

    assign led = ~led_state; // Led active low

endmodule
