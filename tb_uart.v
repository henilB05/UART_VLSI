`timescale 1ns/1ps

module tb_uart;

reg clk;

reg rst;

reg tx_start;

reg [7:0] tx_data;

wire tx;

wire tx_done;

wire [7:0] rx_data;

wire rx_done;

uart_tx TX(

.clk(clk),

.rst(rst),

.tx_start(tx_start),

.tx_data(tx_data),

.tx(tx),

.tx_done(tx_done)

);

uart_rx RX(

.clk(clk),

.rst(rst),

.rx(tx),

.rx_data(rx_data),

.rx_done(rx_done)

);

always #5 clk=~clk;

initial

begin

clk=0;

rst=1;

tx_start=0;

#20;

rst=0;

tx_data=8'b10101010;

tx_start=1;

#10;

tx_start=0;

#200;

$finish;

end

initial

begin

$monitor("time=%0t tx=%b rx_done=%b rx_data=%b",

          $time,

          tx,

          rx_done,

          rx_data);

end

endmodule
