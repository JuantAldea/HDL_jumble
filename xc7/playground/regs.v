module regs (
    input wire clk_in,
    input wire we,
    input wire rst,
    input wire [3:0] w_addr,
    input wire [7:0] w_data,
    input wire [3:0] r_addr_A,
    input wire [3:0] r_addr_B,
    output wire [7:0] r_data_A,
    output wire [7:0] r_data_B
);
  (* ram_style = "distributed" *) reg [7:0] v[16];

  integer i;
  initial begin
    for (i = 0; i < 16; i = i + 1) begin
      v[i] = 0;
    end
  end

  always @(posedge clk_in) begin
    if (we) begin
      v[w_addr] <= rst ? 0 : w_data;
    end
  end

  assign r_data_A = v[r_addr_A];
  assign r_data_B = v[r_addr_B];

endmodule
