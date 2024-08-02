module alu (
//            input clk,
            input [7:0]      x,
            input [7:0]      y,
            input [3:0]       operation,
            output reg [7:0] out,
            output reg        carry
);


   localparam ALU_ASSIGN = 4'h0;
   localparam ALU_OR = 4'h1;
   localparam ALU_AND = 4'h2;
   localparam ALU_XOR = 4'h3;
   localparam ALU_ADD = 4'h4;
   localparam ALU_SUB_X_Y = 4'h5;
   localparam ALU_SHIFT_RIGHT = 4'h6;
   localparam ALU_SUB_Y_X = 4'h7;
   localparam ALU_SHIFT_LEFT = 4'hf;

   always @* begin
   //always_comb begin
      case (operation)
        ALU_ASSIGN: begin
           out = y;
           carry = 1'b0;
        end
        ALU_OR: begin
           out = x | y;
           carry = 1'b0;
        end
        ALU_AND: begin
           out = x & y;
           carry = 1'b0;
        end
        ALU_XOR: begin
           out = x ^ y;
           carry = 1'b0;
        end
        ALU_ADD: begin
           {carry, out} = x + y;
        end
        ALU_SUB_X_Y: begin
           out = x - y;
           carry = x >= y;
        end
        ALU_SHIFT_LEFT: begin
           carry = x[7];
           out = x << 1;
        end
        ALU_SUB_Y_X: begin
           out = y - x;
           carry = y >= x;
        end
        ALU_SHIFT_RIGHT: begin
           carry = x[0];
           out = x >> 1;
        end
        default: begin
           carry = 0;
           out = 0;
        end
      endcase // case (operation)
    end
endmodule // ALU
