wire mynet ;
assign (strong1, pull0) mynet = enable;

module adder (sum_out, carry_out, carry_in, ina, inb);
  output [3:0] sum_out;
  output carry_out;
  input [3:0] ina, inb;
  input carry_in;

  wire carry_out, carry_in;
  wire [3:0] sum_out, ina, inb;

  assign {carry_out, sum_out} = ina + inb + carry_in;
endmodule

module select_bus(busout, bus0, bus1, bus2, bus3, enable, s);
  parameter n = 16;
  parameter Zee = 16'bz;

  output [1:n] busout;
  input [1:n] bus0, bus1, bus2, bus3;
  input enable;
  input [1:2] s;

  tri [1:n] data; // net declaration
  // net declaration with continuous assignment
  tri [1:n] busout = enable ? data : Zee;
  // assignment statement with four continuous assignments
  assign
    data = (s == 0) ? bus0 : Zee,
    data = (s == 1) ? bus1 : Zee,
    data = (s == 2) ? bus2 : Zee,
    data = (s == 3) ? bus3 : Zee;
endmodule

wire #10ns wireA;

rega = 0;
rega[3] = 1; // a bit-select
rega[3:5] = 7; // a part-select
mema[address] = 8'hff; // assignment to a mem element
{carry, acc} = rega + regb; // a concatenation

always @(posedge c) begin
  a <= b; // evaluates, schedules,
  b <= a; // and executes in two steps
end

module dff (q, d, clear, preset, clock);
  output q;
  input d, clear, preset, clock;
  logic q;

  always @(clear or preset)
    if (!clear)
      assign q = 0;
    else if (!preset)
      assign q = 1;
    else
      deassign q;

  always @(posedge clock)
    q = d;
endmodule

module test;
  logic a, b, c, d;
  wire e;
  and and1 (e, a, b, c);
  initial begin
    $monitor("%d d=%b,e=%b", $stime, d, e);
    assign d = a & b & c;
    a = 1;
    b = 0;
    c = 1;
    #10;
    force d = (a | b | c);
    force e = (a | b | c);
    #10;
    release d;
    release e;
    #10 $finish;
  end
endmodule

var int A[N] = '{default:1};
var integer i = '{31:1, 23:1, 15:1, 8:1, default:0};
typedef struct {real r, th;} C;
var C x = '{th:PI/2.0, r:1.0};
var real y [0:1] = '{0.0, 1.1}, z [0:9] = '{default: 3.1416};

module mod1;
  typedef struct {
    int x;
    int y;
  } st;

  st s1;
  int k = 1;
  initial begin
    #1 s1 = '{1, 2+k}; // by position
    #1 $display( s1.x, s1.y);
    #1 s1 = '{x:2, y:3+k}; // by name
    #1 $display( s1.x, s1.y);
    #1 $finish;
  end
endmodule

module byte_rip (inout wire [31:0] W, inout wire [7:0] LSB, MSB);
  alias W[7:0] = LSB;
  alias W[31:24] = MSB;
endmodule
