// Jonás López Mesa - Teno González Dos Santos
//módulo de camino de datos
module microc(input wire clk, reset, s_inc, s_inm, we3, input wire [2:0] op, output wire z, output wire [5:0] opcode);

wire [9:0] mux1_o, pc_o, sum_o;
wire [7:0] mux2_o, r1_o, r2_o, alu_o; 
wire [15:0] datos;

mux2 #(10) multiplexor1(datos[15:6], sum_o, s_inc, mux1_o);
sum sumador(10'b0000000001, pc_o, sum_o);
registro #(10) PC(clk, reset, mux1_o, pc_o);
memprog memoria_programa(clk, pc_o, datos);
regfile banco_reg(clk, we3, datos[7:4], datos[11:8], datos[15:12], mux2_o, r1_o, r2_o);
mux2 #(8) multiplexor2(alu_o, datos[11:4], s_inm, mux2_o);
alu alu1(r1_o, r2_o, op, alu_o, z);

endmodule
