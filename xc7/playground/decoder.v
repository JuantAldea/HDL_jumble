module decoder (
    input [15:0] instruction
);
  wire [3:0] nibble0, nibble1, nibble2, nibble3;

  //  assign {nibble0, nibble1, nibble2, nibble3 } = instruction;
  assign nibble0 = instruction[15:12];
  assign nibble1 = instruction[11:8];
  assign nibble2 = instruction[7:4];
  assign nibble3 = instruction[3:0];


  always @* begin
  //always_comb begin
    casez (nibble0)
      4'h0: begin
      end
      4'h1: begin
      end
      4'h2: begin
      end
      4'h3: begin
      end
      4'h4: begin
      end
      4'h5: begin
      end
      4'h6: begin
      end
      4'h7: begin
      end
      4'h8: begin
      end
      4'h9: begin
      end
      4'hA: begin

      end
      4'hB: begin

      end
      4'hC: begin

      end
      4'hD: begin

      end
      4'hE: begin

      end
      4'hF: begin

      end

      default: begin

      end


    endcase  // case (instruction)
  end


endmodule  // decoder
