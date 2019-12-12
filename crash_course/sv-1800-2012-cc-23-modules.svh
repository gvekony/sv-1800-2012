module mh1 (input var int in1,
  input var shortreal in2,
  output tagged_st out);
  ...
  assign
  always_ff @(posedge clk) begin
  end
endmodule:a::mh1

module mh2 (input var int in1,
  input var shortreal in2,
  output tagged_st out);
  ...
endmodule: mh2::a
endmodule
/*  */
module a;
endmodule//
module b;
endmodule: b//
module c;
endmodule


module test(a,b,c,d,e,f,g,h);
  input [7:0] a; // no explicit net declaration - net is unsigned
  input [7:0] b; //
  input signed [7:0] c;
  input signed [7:0] d; // no explicit net declaration - net is signed
  output [7:0] e; // no explicit net declaration - net is unsigned
  output [7:0] f;
  output signed [7:0] g;
  output signed [7:0] h; // no explicit net declaration - net is signed
  wire signed [7:0] b; // port b inherits signed attribute from net decl.
  wire [7:0] c; // net c inherits signed attribute from port
  logic signed [7:0] f;// port f inherits signed attribute from logic decl.
  logic [7:0] g; // logic g inherits signed attribute from port
endmodule

module cpuMod(interface d, interface j);
  ...
endmodule//comment2
interface a;
endinterface//
module bus_conn (
  output logic [7:0] dataout,
  input [7:0] datain = My_DataIn
  );
  module as::cpuMod(interface d, interface j);
    ...
    module cpuMod(interface b, interface i);
      ...
    endmodule: as::labelled_output

    interface nested_if();
      ...
      module aa::nested_mod();
      endmodule: aa::nested_mod

    endinterface: a::nested_if

  endmodule: as::asdaf
  assign dataout = datain;
endmodule: asd::asd
endmodule

function a();
endfunction: b::a

module generic_decoder #(num_code_bits = 3, localparam num_out_bits = 1 << num_code_bits)
  (input [num_code_bits-1:0] A, output reg [num_out_bits-1:0] Y);
endmodule

$root();

module dff_flat(input d, ck, pr, clr, output q, nq);
  wire q1, nq1, q2, nq2;
  nand g1b (nq1, d, clr, q1);
  nand g1a (q1, ck, nq2, nq1);
  nand g2b (nq2, ck, clr, q2);
  nand g2a (q2, nq1, pr, nq2);
  nand g3a (q, nq2, clr, nq);
  nand g3b (nq, q1, pr, q);
endmodule

extern module m (.*);
extern module static a #(parameter size= 8, parameter type TP = logic [7:0])(input [size:0] a, output TP b);

module top ();
  wire [8:0] a;
  logic [7:0] b;
  wire c, d;
  m mm (.*);
  a aa (.*);
  .*
endmodule

module m1 (a,b);
  real r1,r2;
  parameter [2:0] A = 3'h2;
  parameter B = 3'h2;
  initial begin
  r1 = A;
  r2 = B;
  $display("r1 is %f r2 is %f",r1,r2);
  end
endmodule: m1

module m2;
  wire a,b;
  defparam f1.A = 3.1415;
  defparam f1.B = 3.1415;
  m1 f1(a,b);
endmodule: m2

// Example of binding a program instance to a module:
bind cpu fpu_props fpu_rules_1(
  .clk(b),
  .rst(c)
);
