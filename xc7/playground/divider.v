module divider
#(
    parameter CLK_FREQ_HZ = 50
)(
  input clk_in,
  output reg clk_out = 0
);

  reg[$clog2(CLK_FREQ_HZ)-1:0] counter = 0;

  always @(posedge clk_in) begin
    counter <= counter + 1;
    if (counter >= (CLK_FREQ_HZ - 1)) begin
      counter <= 0;
      clk_out <= !clk_out;
    end
  end
endmodule
