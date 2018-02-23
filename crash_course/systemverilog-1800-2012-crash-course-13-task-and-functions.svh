task static mytask1 (output int x, input logic y);
  ...
endtask

task automatic mytask2;
  output x;
  input y;
  int x;
  logic y;
  ...
endtask: mytask2

class a;
  extern task lights_out(inout int x);
  pure virtual task lights(input int unsigned x);
endclass: a

module traffic_lights;
  logic clock, red, amber, green;
  parameter on = 1, off = 0, red_tics = 350,
  amber_tics = 30, green_tics = 200;
  // initialize colors
  initial red = off;
  initial amber = off;
  initial green = off;

  always begin: sequence_to_control_the_lights
    red = on; // turn red light on
    light(red, red_tics); // and wait.
    green = on; // turn green light on
    light(green, green_tics); // and wait.
    amber = on; // turn amber light on
    light(amber, amber_tics); // and wait.
  end: sequence_to_control_the_lights
  // task to wait for 'tics' positive edge clocks
  // before turning 'color' light off
  task light (output color, input [31:0] tics);
    repeat (tics) @ (posedge clock);
    color = off; // turn light off.
  endtask: light

  always begin: waveform_for_the_clock
    #100 clock = 0;
    #100 clock = 1;
  end: waveform_for_the_clock
endmodule: traffic_lights

// define the function
function automatic integer factorial (input [31:0] operand);
  if (operand >= 2)
  factorial = factorial (operand - 1) * operand;
  else
  factorial = 1;
endfunction: factorial

function integer clogb2 (input [31:0] value);
  value = value - 1;
  for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
  value = value >> 1;
endfunction

function user_integer clogb2 (input [31:0] value);
  value = value - 1;
  for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
  value = value >> 1;
endfunction

function integer a::clogb2 (input [31:0] value);
  value = value - 1;
  for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
  value = value >> 1;
endfunction

function user_integer a::clogb2 (input [31:0] value);
  value = value - 1;
  for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
  value = value >> 1;
endfunction


function user_integer_t clogb2 (input [31:0] value);
  value = value - 1;
  for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
  value = value >> 1;
endfunction

function automatic bit watch_for_zero( IntClass p );
  fork
    forever @p.a begin: Forever_block
      if ( p.a == 0 ) $display ("Unexpected zero");
    end: Forever_block
  join_none
  return ( p.a == 0 );
endfunction
endfunction

function automatic int crc( ref byte packet [1000:1] );
  for( int j= 1; j <= 1000; j++ ) begin
    crc ^= packet[j];
  end
endfunction

function automatic user_int crc( ref byte packet [1000:1] );
  for( int j= 1; j <= 1000; j++ ) begin
    crc ^= packet[j];
  end
endfunction

task automatic show ( const ref byte data [] );
  for ( int j = 0; j < data.size ; j++ )
  $display( data[j] ); // data can be read but not written
endtask

class external_wrapper;
  extern protected virtual function user_integer_t send(int value);

  extern protected virtual function user_integer send(int value);

  extern protected virtual function int send(int value);
endclass: external_wrapper

virtual class C#(parameter DECODE_W, parameter ENCODE_W = $clog2(DECODE_W));

  static function logic [ENCODE_W-1:0] ENCODER_f (input logic [DECODE_W-1:0] DecodeIn);
    ENCODER_f = '0;
    for (int i=0; i<DECODE_W; i++) begin
      if(DecodeIn[i]) begin
        ENCODER_f = i[ENCODE_W-1:0];
        break;
      end
    end
  endfunction

  static function logic [DECODE_W-1:0]
    DECODER_f (input logic [ENCODE_W-1:0] EncodeIn);
    DECODER_f = '0;
    DECODER_f[EncodeIn] = 1'b1;
  endfunction
endclass

task a::f1 ();
  int i;
  int unsigned m_i;
endtask: a::f1

function user_int a::f1 ();
  int i;
  int unsigned m_i;
endfunction: a::f1
