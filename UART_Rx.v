module uart_rx(

input clk,
input rst,

input rx,

output reg [7:0] rx_data,

output reg rx_done

);

parameter IDLE=0;

parameter START=1;

parameter DATA=2;

parameter STOP=3;

reg [1:0] state;

reg [2:0] bit_index;

always @(posedge clk or posedge rst)

begin

if(rst)

begin

state <= IDLE;

rx_done <= 0;

bit_index <= 0;

rx_data <= 0;

end

else

begin

case(state)

IDLE:

begin

rx_done <= 0;

if(rx==0)

state <= START;

end

START:

begin

bit_index <= 0;

state <= DATA;

end

DATA:

begin

rx_data[bit_index] <= rx;

if(bit_index==7)

state <= STOP;

else

bit_index <= bit_index+1;

end

STOP:

begin

rx_done <= 1;

state <= IDLE;

end

endcase

end

end

endmodule
