`define PS7

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


  wire clk_div;


  divider #(50000000) divider (
    .clk_in(clk_bufg),
    .clk_out(clk_div)
  );

  wire [7:0] ram_data_out;
  wire [7:0] data_in;

  wire reset_A;

  bram bram (
    .clk_in(clk_div),
    .en_A(1),
    .we_A(1),
    .en_B(0),
    .we_B(0),
    .addr_B(0),
    .data_in_B(0),
    .reset_A(reset_A),
    .reset_B(0),
    .data_out_B(),
    .addr_A({8'b0, counter[3:0]}),
    .data_in_A(data_in),
    .data_out_A(ram_data_out)
  );

  wire en_counter;
  wire count_direction;
  reg [3:0] counter = 0;
  reg set = 1;
  reg [3:0] counter_out;

  assign leds_4bits_tri_o = ram_data_out[3:0];
  assign arduino_gpio_tri_io = {11'b0, set, counter_out, ram_data_out[3:0]};

  assign data_in = {4'b0, counter[0], counter[1], counter[2], counter[3]};
  assign reset_A = ~set;
  assign en_counter =
`ifdef PS7data_out
      ~emio_gpio_o[0] &
`endif
      sws_2bits_tri_i[0];

  assign count_direction =
`ifdef PS7
      ~emio_gpio_o[1] &
`endif
      sws_2bits_tri_i[1];

  always @(posedge clk_div) begin
    if (en_counter) begin
      counter <= counter + (count_direction ? 1 : -1);

      if (counter == 4'b1111) begin
        set <= ~set;
      end

      counter_out <= counter;

    end
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
