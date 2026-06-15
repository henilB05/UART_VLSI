module uart_tx(

input clk,
input rst,
input tx_start,
input [7:0] tx_data,

output reg tx,
output reg tx_done

);

parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

reg [1:0] state;

reg [2:0] bit_index;

always @(posedge clk or posedge rst)

begin

if(rst)

begin

state <= IDLE;

tx <= 1;

tx_done <= 0;

bit_index <= 0;

end

else

begin

case(state)

IDLE:

begin

tx <= 1;

tx_done <= 0;

if(tx_start)

state <= START;

end

START:

begin

tx <= 0;

bit_index <= 0;

state <= DATA;

end

DATA:

begin

tx <= tx_data[bit_index];

if(bit_index == 7)

state <= STOP;

else

bit_index <= bit_index + 1;

end

STOP:

begin

tx <= 1;

tx_done <= 1;

state <= IDLE;

end

endcase

end

end

endmodule
