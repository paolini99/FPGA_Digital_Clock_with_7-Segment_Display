module ClockDividerSimple(
    input wire clk,       // Clock principale
    input wire reset,     // Reset sincrono
    output reg clk_out    // Clock diviso
);
    parameter DIVISOR = 10000; // Valore del divisore (per ottenere 100 Hz da 1 MHz)

    reg [31:0] count; // Contatore, abbastanza grande per il valore del divisore

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            clk_out <= 0;
        end else if (count == (DIVISOR - 1)) begin
            count <= 0;
            clk_out <= ~clk_out; // Alterna il clock di uscita
        end else begin
            count <= count + 1;
        end
    end
endmodule
