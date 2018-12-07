// Sign extender
module signextend(input wire [15:0] inputVal, output wire [31:0] outputVal);

    assign outputVal = { {16{inputVal[15]}}, inputVal };

endmodule

// 32-bit 2 to 1 Multiplexer
module twotoonemux(input wire [31:0] input1, input wire [31:0] input2, input wire sel, output wire [31:0] outputval);

    assign outputval = (sel == 0) ? input1 : input2;

endmodule

// 5-bit 2 to 1 Multiplexer
module twotoonemux_5bit(input wire [4:0] input1, input wire [4:0] input2, input wire sel, output wire [4:0] outputval);

    assign outputval = (sel == 0) ? input1 : input2;

endmodule

// Arithmetic Logic Unit
module alu(input wire [31:0] op1,input wire [31:0] op2,input wire [3:0] ctrl,output wire [31:0] result);

	assign result = (ctrl == 4'b0000) ? (op1 & op2) : ((ctrl == 4'b0001) ? (op1 | op2) : 
		((ctrl == 4'b0010) ? (op1 + op2) : ((ctrl == 4'b0110) ? (op1 - op2) : 
		((ctrl == 4'b0111) ? ((op1 < op2) ? 1 : 0) : ((ctrl == 4'b1100) ? (~(op1 | op2)) : (op1 + op2)) ) ) ) );

endmodule

// ALU Control
module alucontrol(input wire [5:0] func, input wire [1:0] aluOp, output wire [3:0] aluctrl);
   always @(aluOp)
    begin
    case(func)
    32: aluctrl = 2;
    34: aluctrl = 3;
    36: aluctrl = 0;
    37: aluctrl = 1;
    default: aluctrl = 2;
    end

                   
endmodule

// Register File
module registerfile(input wire rst, input wire [4:0] readReg1, input wire [4:0] readReg2, input wire [4:0] writeReg, 
    input wire [31:0] writeData, input wire regWrite, output reg [31:0] readData1, output reg [31:0] readData2);

    // Register file
    reg [31:0] register[31:0];

    integer i;

    always @(posedge rst)
    begin
        for(i=0;i<32;i=i+1)
        begin
            register[i] = 0;
        end
    end

    always @(readReg1)
    begin
        readData1 = register[readReg1];
    end

    always @(readReg2)
    begin
        readData2 = register[readReg2];
    end

    always @(posedge regWrite)
    begin
    	if(writeReg != 0)
        	register[writeReg] = writeData;
    end

endmodule

// Data Memory
module datamem(input wire rst, input wire [6:0] memAddr, input wire memRead, input wire memWrite, 
    input wire [31:0] writeData, output reg [31:0] readData);

    // Memory
    reg [31:0] memory[127:0];

    integer i;

    always @(posedge rst)
    begin
        for(i=0;i<128;i=i+1)
        begin
            memory[i] = 0;
        end
    end

    always @(posedge memRead)
    begin
        readData = memory[memAddr];
    end

    always @(posedge memWrite)
    begin
        memory[memAddr] = writeData;
    end

endmodule

// FSM portion of Control Path (RegWrite, MemRead, MemWrite)
module controlpathfsm(input wire rst, input wire clk, input wire newInstruction, input wire [5:0] opcode, 
                        output reg _RegWrite, output reg _MemRead, output reg _MemWrite);

endmodule

// Combinational logic portion of Control Path (MemToReg, RegDst, ALUSrc, ALUOp)
module controlpathcomb(input wire [5:0] opcode, output wire _MemToReg, 
                    output wire _RegDst, output wire _ALUSrc, output wire [1:0] _ALUOp);

    always @(*)
    begin 
        case(opcode)
        0: MemToReg = 0;  
        35:
        43:
    end

                    
endmodule

// The entire CPU without PC, instruction memory, and branch circuit
module mipscpu(input wire reset, input wire clock, input wire [31:0] instrword, input wire newinstr);


endmodule

