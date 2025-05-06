`timescale 1ns / 1ps

module tb_riscv_sc;
//cpu testbench

reg clk;
reg start;
wire [31:0]ALUResult, inst, PC_out,
writeData,readData;
wire [31:0]SrcA;       
wire [31:0]SrcB,Result;
wire [3:0]ALUCtl;
wire branch;
wire jump;
wire memRead;
wire [1:0]resultSRC;
wire [1:0] ALUOp;
wire memWrite;
wire ALUSrc;
wire regWrite;


wire PCSrc;


SingleCycleCPU riscv_DUT(clk,
    start,ALUResult, inst, PC_out,
    writeData,readData,
    SrcA,
    SrcB,Result,
    ALUCtl,
    branch,
    jump,
    memRead,
    resultSRC,
    ALUOp,
    memWrite,
    ALUSrc,
    regWrite,
    PCSrc
    );

initial
	forever #5 clk = ~clk;

initial begin
	clk = 0;
	start = 0;
	#10 start = 1;
 
	#200 $finish;

end

endmodule
