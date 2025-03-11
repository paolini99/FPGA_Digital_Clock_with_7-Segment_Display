module Counter_sync_hours(
    clk,            // Clock input per incrementare il contatore
    res,            // Segnale di reset per riportare il contatore a zero
	 inc,
	 inc2,
    DIG0, DIG1,     // Output delle cifre del contatore (secondi da meno a più significativi)
    DIG2, DIG3,     // Output delle cifre del contatore (minuti)
    DIG4, DIG5      // Output delle cifre del contatore (ore)
);

input wire clk;            // Clock di ingresso
input wire res;            // Segnale di reset asincrono attivo alto
input wire inc;            // Segnale di incremento
input wire inc2;            // Segnale di incremento
output wire [3:0] DIG0;    // Prima cifra del contatore (unità dei secondi)
output wire [3:0] DIG1;    // Seconda cifra del contatore (decine dei secondi)
output wire [3:0] DIG2;    // Prima cifra del contatore per i minuti (unità dei minuti)
output wire [3:0] DIG3;    // Seconda cifra del contatore per i minuti (decine dei minuti)
output wire [3:0] DIG4;    // Prima cifra del contatore per le ore (unità delle ore)
output wire [3:0] DIG5;    // Seconda cifra del contatore per le ore (decine delle ore)

// Segnali per il carry tra i contatori modulari
wire SYNTHESIZED_WIRE_1;
wire SYNTHESIZED_WIRE_2;
wire SYNTHESIZED_WIRE_3;
wire SYNTHESIZED_WIRE_4;
wire SYNTHESIZED_WIRE_5;
wire reset_hours;

// Variabile di abilitazione del conteggio
reg enable_counter = 1'b1;

// Logica per il reset delle ore
assign reset_hours = (DIG5 == 1 && DIG4 == 3);

// Logica per abilitare o disabilitare il conteggio in modo asincrono
always @(*) begin
    if (res)
        enable_counter = 1'b1;  // Resetta e abilita il conteggio
end

// Contatore dei secondi (unità e decine)
Modular_counter_sync b2v_inst0 (
    .clk(clk),
    .enable(enable_counter), 
    .reset(res),
    .carry(SYNTHESIZED_WIRE_1), 
    .count(DIG0)
);
defparam b2v_inst0.MODULE = 9; // Conta da 0 a 9 per le unità dei secondi

Modular_counter_sync b2v_inst1 (
    .clk(clk), 
    .enable(SYNTHESIZED_WIRE_1), 
    .reset(res), 
    .carry(SYNTHESIZED_WIRE_2), 
    .count(DIG1)
);
defparam b2v_inst1.MODULE = 5; // Conta da 0 a 5 per le decine dei secondi

// Contatore dei minuti (unità e decine)
Modular_counter_sync b2v_inst2 (
    .clk(clk), 
    .enable(SYNTHESIZED_WIRE_2), 
    .reset(res), 
	 .increment2(inc2),
    .carry(SYNTHESIZED_WIRE_3), 
    .count(DIG2)
);
defparam b2v_inst2.MODULE = 9; // Conta da 0 a 9 per le unità dei minuti

Modular_counter_sync b2v_inst3 (
    .clk(clk), 
    .enable(SYNTHESIZED_WIRE_3), 
    .reset(res), 
    .carry(SYNTHESIZED_WIRE_4), 
    .count(DIG3)
);
defparam b2v_inst3.MODULE = 5; // Conta da 0 a 5 per le decine dei minuti

// Contatore delle ore (unità)
Modular_counter_sync b2v_inst4 (
    .clk(clk), 
    .enable(SYNTHESIZED_WIRE_4), 
    .reset(res | reset_hours), // Resetta quando reset_hours è attivo
	 .increment(inc),
    .carry(SYNTHESIZED_WIRE_5), 
    .count(DIG4)
);
defparam b2v_inst4.MODULE = 9; // Conta da 0 a 9 per le unità delle ore

// Contatore delle ore (decine)
Modular_counter_sync b2v_inst5 (
    .clk(clk), 
    .enable(SYNTHESIZED_WIRE_5), 
    .reset(res | reset_hours), // Resetta quando reset_hours è attivo
    .count(DIG5)
);
defparam b2v_inst5.MODULE = 1; // Conta da 0 a 2 per le decine delle ore

endmodule
