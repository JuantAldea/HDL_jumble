//`define PS7

module BUFG(
  input wire I,
  output wire O
);

assign O = I;

endmodule

module top (
    input wire clk,
    output wire [3:0] leds_4bits_tri_o,
    output wire [19:0] arduino_gpio_tri_io,
    input wire [1:0] sws_2bits_tri_i
);

  wire clk_bufg;
  BUFG BUFG (
      .I(clk),
      .O(clk_bufg)
  );

  wire en_counter;
  wire count_direction;
  reg [31:0] counter = 0;

  assign leds_4bits_tri_o = counter[27:24];
  assign arduino_gpio_tri_io = {5'h0, counter[27:13]};

  assign en_counter =
`ifdef PS7
      ~emio_gpio_o[0] &
`endif
      sws_2bits_tri_i[0];

  assign count_direction =
`ifdef PS7
      ~emio_gpio_o[1] &
`endif
      sws_2bits_tri_i[1];

  always @(posedge clk_bufg) begin
    if (en_counter)
      if (count_direction) counter <= counter + 1;
      else counter <= counter - 1;
  end


`ifdef PS7
  // The PS7
  wire [63:0] emio_gpio_o;
  wire [63:0] emio_gpio_t;
  wire [63:0] emio_gpio_i;

  (* KEEP, DONT_TOUCH *)
  PS7 PS7 (
      .EMIOGPIOO (emio_gpio_o),
      .EMIOGPIOTN(emio_gpio_t),
      .EMIOGPIOI (emio_gpio_i)
  );

`endif

endmodule
