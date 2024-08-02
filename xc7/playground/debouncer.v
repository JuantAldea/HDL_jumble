module debouncer(
                 input clk,
                 input  in,
                 output reg out = 0
                 );
   reg [3:0]            counter = 0;

   always @(posedge clk) begin
      if (in) begin
         counter <= counter + 1;
         out <= out | counter == 4'hf;
      end else begin
         counter <= 0;
         out <= 0;
      end
   end
endmodule // debouncer
