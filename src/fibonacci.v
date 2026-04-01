module tt_um_fibonacci (
    input  wire [7:0] ui_in,    // Entradas de usuario (no usadas)
    output wire [7:0] uo_out,   // Salidas hacia pines
    input  wire [7:0] uio_in,   // Pines bidireccionales de entrada (no usados)
    output wire [7:0] uio_out,  // Pines bidireccionales de salida (no usados)
    output wire [7:0] uio_oe,   // Habilitación de salida bidireccional (no usada)
    input  wire       ena,      // Enable (no usado directamente)
    input  wire       clk,      // Clock principal
    input  wire       rst_n     // Reset activo en bajo
);

    reg [7:0] fib;
    reg [7:0] prev;

    // Lógica principal
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            prev <= 8'd1;
            fib  <= 8'd0;
        end else begin
            prev <= fib;
            fib  <= prev + fib;
        end
    end

    // Conectar la salida de Fibonacci a los 8 pines de salida
    assign uo_out = fib;

    // No usamos pines bidireccionales
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // Evitar warnings por señales no usadas
    wire _unused = &{ena, ui_in, uio_in, 1'b0};

endmodule