// Jonás López Mesa - Teno González Dos Santos
// Testbench para camino de datos
`timescale 1 ns / 10 ps //Directiva que fija la unidad de tiempo de simulación y el del paso de simulacion
module microc_tb;

//declaracion de señales
reg test_reset, test_clk, test_s_inc, test_s_inm, test_we3;
wire [5:0] test_opcode;
reg [2:0]test_op;
wire test_z;

//instancia del modulo a testear
microc microc1(test_clk, test_reset, test_s_inc, test_s_inm, test_we3, test_op[2:0], test_z, test_opcode);

//Reloj
always
begin
test_clk=1;
#20;
test_clk=0;
#60;
end


initial 
begin
  $monitor("test_clk=%0d test_reset=%d test_s_inc=%d test_s_inm=%d test_we3=%d test_op=%d test_z=%d test_opcode=%d", test_clk, test_reset, test_s_inc, test_s_inm, test_we3, test_op, test_z, test_opcode);
  $dumpfile("cam_dat_tb.vcd");
  $dumpvars;
   
   test_reset=0;
   #20;

//Avanza una instrucción y realiza la instrucción de carga de cte. inmediata en un registro
   test_s_inc='b1;
   test_we3='b1;
   test_op='b000;
   test_s_inm='b1;
   #40

//Instrucción de salto y luego, guarda la cte inmediata de la sig. intrucc. en un registro
   test_s_inc='b0;
   test_we3='b1;
   test_op='b000;
   test_s_inm='b1;
   #40


//Instrucción de op. aritmética o lógica guardada en registro
   test_we3='b1;
   test_op='b001;
   test_s_inc='b1;
   test_s_inm='b0;
   #40
   


  //fin simulación
  $finish;
end

endmodule
