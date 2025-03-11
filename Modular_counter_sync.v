module Modular_counter_sync
#(parameter MODULE=9)
(
    input clk, enable, reset, increment, increment2,  // Aggiunto 'increment'
    output reg [3:0] count,
    output carry
);

    // Incrementa il contatore quando 'increment' è attivo
    always @ (posedge clk or posedge reset )
    begin
        if (reset)
            count <= 4'b0000;  // Il reset azzera il contatore
        else if (increment)
				begin
					if (count == MODULE) 
						count <= 4'b0000;  // Azzeramento quando raggiunge il valore massimo del modulo
					else 
                  count <= count + 4'b0001; // Incrementa il contatore se 'increment' è attivo
				end
		  else if (increment2) 
				begin
					if (count == MODULE) 
                  count <= 4'b0000;  // Azzeramento quando raggiunge il valore massimo del modulo
					else 
                  count <= count + 4'b0001; // Incrementa il contatore se 'increment' è attivo
				end
        else 
        begin
            if (enable == 1'b1)
                if (count == MODULE) 
                    count <= 4'b0000;  // Azzeramento quando raggiunge il valore massimo del modulo
                else 
                    count <= count + 4'b0001;  // Incrementa normalmente
        end
    end

    // Logica per il carry
    assign carry = (count == MODULE) & (enable | increment | increment2);

endmodule
