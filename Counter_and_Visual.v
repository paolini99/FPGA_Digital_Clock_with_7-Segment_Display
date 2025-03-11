module Counter_and_Visual(
    clk,
	 clk_100Hz,
    res,
    inc,
    inc2,
    sel,        // Nuovo segnale di selezione
    SEG0,
    SEG1,
    SEG2,
    SEG3,
    SEG4,
    SEG5
);

input wire clk;
input wire clk_100Hz;
input wire res;
input wire inc;
input wire inc2;
input wire sel;           // Segnale di selezione per scegliere tra ore e minuti
output wire [6:0] SEG0;
output wire [6:0] SEG1;
output wire [6:0] SEG2;
output wire [6:0] SEG3;
output wire [6:0] SEG4;
output wire [6:0] SEG5;

wire [3:0] SYNTHESIZED_WIRE_0;
wire [3:0] SYNTHESIZED_WIRE_1;
wire [3:0] SYNTHESIZED_WIRE_2;
wire [3:0] SYNTHESIZED_WIRE_3;
wire [3:0] SYNTHESIZED_WIRE_4;
wire [3:0] SYNTHESIZED_WIRE_5;

wire [3:0] DIG0_hours, DIG1_hours, DIG2_hours, DIG3_hours, DIG4_hours, DIG5_hours;
wire [3:0] DIG0_min, DIG1_min, DIG2_min, DIG3_min, DIG4_min, DIG5_min;

// Modulo Counter_sync_hours
Counter_sync_hours b2v_inst_hours(
    .clk(clk),
    .res(res && !sel),
    .inc(inc),
    .inc2(inc2),
    .DIG0(DIG0_hours),
    .DIG1(DIG1_hours),
    .DIG2(DIG2_hours),
    .DIG3(DIG3_hours),
    .DIG4(DIG4_hours),
    .DIG5(DIG5_hours)
);



// Connettere il nuovo clock al modulo Counter_sync_cron
Counter_sync_cron b2v_inst_min (
    .clk(clk_100Hz),
    .res(res && sel),
    .inc(inc),
    .inc2(inc2),
    .sel(sel),
    .DIG0(DIG0_min),
    .DIG1(DIG1_min),
    .DIG2(DIG2_min),
    .DIG3(DIG3_min),
    .DIG4(DIG4_min),
    .DIG5(DIG5_min)
);


// Multiplexer per selezionare tra ore e minuti
assign SYNTHESIZED_WIRE_0 = sel ? DIG0_min : DIG0_hours;
assign SYNTHESIZED_WIRE_1 = sel ? DIG1_min : DIG1_hours;
assign SYNTHESIZED_WIRE_2 = sel ? DIG2_min : DIG2_hours;
assign SYNTHESIZED_WIRE_3 = sel ? DIG3_min : DIG3_hours;
assign SYNTHESIZED_WIRE_4 = sel ? DIG4_min : DIG4_hours;
assign SYNTHESIZED_WIRE_5 = sel ? DIG5_min : DIG5_hours;

// Collegamento ai moduli SEG7_LUT
SEG7_LUT b2v_inst1(
    .clk(clk_100Hz),
    .iDIG(SYNTHESIZED_WIRE_0),
    .oSEG(SEG0)
);

SEG7_LUT b2v_inst2(
    .clk(clk_100Hz),
    .iDIG(SYNTHESIZED_WIRE_1),
    .oSEG(SEG1)
);

SEG7_LUT b2v_inst3(
    .clk(clk_100Hz),
    .iDIG(SYNTHESIZED_WIRE_2),
    .oSEG(SEG2)
);

SEG7_LUT b2v_inst4(
    .clk(clk_100Hz),
    .iDIG(SYNTHESIZED_WIRE_3),
    .oSEG(SEG3)
);

SEG7_LUT b2v_inst5(
    .clk(clk_100Hz),
    .iDIG(SYNTHESIZED_WIRE_4),
    .oSEG(SEG4)
);

SEG7_LUT2 b2v_inst6(
    .clk(clk_100Hz),
    .iDIG(SYNTHESIZED_WIRE_5),
    .oSEG(SEG5)
);



endmodule

