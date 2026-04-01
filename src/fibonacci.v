module fibonacci_8bit (
    input clk,
    output reg [7:0] fib
);

// Trabajar desde aquí
reg [7:0] prev;      // almacena el número anterior

initial begin
    prev = 8'd1;     // primer anterior (F(-1) imaginario para generar F(0)=0 y F(1)=1)
    fib  = 8'd0;     // primer número de la serie
end

always @(posedge clk) begin
    prev <= fib;          // el anterior pasa a ser el actual actual
    fib  <= prev + fib;   // nuevo actual = anterior_anterior + actual_anterior
end
// Hasta aquí, no modificar fuera de este segmento

endmodule


/* 
 * Testbench para módulo fibonacci_8bit
*/
module main;
  // Señales del testbench
  reg clk;
  wire [7:0] fib;

  // Instancia del DUT (Device Under Test)
  fibonacci_8bit uut (
      .clk(clk),
      .fib(fib)
  );

  // Generación de clock (periodo = 10 unidades)
  initial begin
      clk = 0;
      forever #5 clk = ~clk;
  end

  // Simulación
  initial begin
      $display("fib");
      $monitor("%d", fib);

      // correr simulación un tiempo
      #140;

      $display("Fin simulacion");
      $finish;
  end
endmodule