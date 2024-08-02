module bram (
    input wire clk_in,
    input wire en_A,
    input wire en_B,
    input wire we_A,
    input wire we_B,
    input wire reset_A,
    input wire reset_B,
    input wire [11:0] addr_A,
    input wire [11:0] addr_B,
    input wire [7:0] data_in_A,
    input wire [7:0] data_in_B,
    output reg [7:0] data_out_A,
    output reg [7:0] data_out_B
);

  (* ram_style = "block" *) reg [7:0] ram[4096];

  integer i;
  initial begin
    for (i = 0; i < 4096; i = i + 1) begin
      ram[i] = 5;
    end
  end

  always @(posedge clk_in) begin
    if (en_A) begin
      data_out_A <= ram[addr_A];
      if (we_A) begin
        ram[addr_A] <= reset_A ? 0 : data_in_A;
      end
    end
  end

  always @(posedge clk_in) begin
    if (en_B) begin
      data_out_B <= ram[addr_B];
      if (we_B) begin
        ram[addr_B] <= reset_B ? 0 : data_in_B;
      end
    end
  end
endmodule
