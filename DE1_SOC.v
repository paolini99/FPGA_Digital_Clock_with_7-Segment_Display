//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module DE1_SOC(
	//////////// CLOCK //////////
	input CLOCK2_50,
	input CLOCK3_50,
	input CLOCK4_50,
	input CLOCK_50,

	//////////// SEG7 //////////
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2,
	output [6:0] HEX3,
	output [6:0] HEX4,
	output [6:0] HEX5,

	//////////// KEY //////////
	input [3:0] KEY,

	//////////// LED //////////
	output [9:0] LEDR,

	//////////// SW //////////
	input [9:0] SW,

	//////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
	inout [35:0] GPIO1GPIO
);

	//=======================================================
	//  REG/WIRE declarations
	//=======================================================

	// Segnale di temporizzazione
	wire [31:0] valori;       // Contatore per generare temporizzazione
	wire slow_clk;            // Segnale di clock lento per secondi
	wire slow_cron;            // Segnale di clock lento per i centesimi di secondo
	
	// Assegnazione reset, stop e resume dai KEY
	wire reset = ~KEY[0];      // Pulsante reset associato a KEY[0]
	wire increment = ~KEY[1];      // Pulsante reset associato a KEY[1]
	wire increment2 = ~KEY[2];      // Pulsante reset associato a KEY[0]
	wire selector = SW[0];
	
	// Instanza del contatore binario per creare un clock più lento
	binary_counter divisore(
		.clk(CLOCK_50),
		.count(valori)
	);

	// Genera un impulso al raggiungimento di un valore nel contatore
	assign slow_clk = valori[25]; // Frequenza circa 1 Hz
	assign slow_cron = valori[19]; // Frequenza circa 1 Hz
	assign LEDR[0] = slow_clk;    // Indica il clock lento sui LED
   assign LEDR[1] = slow_cron;    // Indica il clock dei centisimi sui LED

	//=======================================================
	//  Instanza del modulo Counter_and_Visual
	//=======================================================
	
	Counter_and_Visual contatore_visual(
		.clk(slow_clk),
		.clk_100Hz(slow_cron),
		.res(reset),
		.inc(increment),
		.inc2(increment2),
		.sel(selector),
		.SEG0(HEX0),
		.SEG1(HEX1),
		.SEG2(HEX2),
		.SEG3(HEX3),
		.SEG4(HEX4),
		.SEG5(HEX5)
	);

endmodule

//=======================================================
//  Modulo Binary Counter per generare clock lento senza enable e reset
//=======================================================

module binary_counter
#(parameter WIDTH=32)
(
	input clk,
	output reg [WIDTH-1:0] count
);

	// Incremento del contatore a ogni impulso di clock
	always @ (posedge clk)
	begin
		count <= count + 1;
	end

endmodule

