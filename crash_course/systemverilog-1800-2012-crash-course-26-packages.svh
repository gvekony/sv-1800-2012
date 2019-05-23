package ComplexPkg;
  typedef struct {
    shortreal i, r;
  } Complex;

  function Complex add(Complex a, b);
    add.r = a.r + b.r;
    add.i = a.i + b.i;
  endfunction

  function Complex mul(Complex a, b);
    mul.r = (a.r * b.r) - (a.i * b.i);
    mul.i = (a.r * b.i) + (a.i * b.r);
  endfunction
endpackage : ComplexPkg

package p;
  typedef enum { FALSE, TRUE } bool_t;
endpackage

package q;
  typedef enum { ORIGINAL, FALSE } teeth_t;
endpackage

module top1 ;
  import p::*;
  import q::teeth_t;
  export *::*;

  teeth_t myteeth;

  initial begin
    myteeth = q:: FALSE; // OK:
    myteeth = FALSE; // ERROR: Direct reference to FALSE refers to the
  end // FALSE enumeration literal imported from p
endmodule

package p;
  int x;
endpackage

package p2;
  int x;
endpackage

module top;
  import p::*; // line 1
  if (1) begin : b
    initial x = 1; // line 2
    import p2::*; // line 3
  end
endmodule

package A;
  typedef struct {
    bit [ 7:0] opcode;
    bit [23:0] addr;
  } instruction_t;
endpackage: A

package B;
  typedef enum bit {FALSE, TRUE} boolean_t;
endpackage: B

/*  known bug  */
module M import A::instruction_t, B::*;
  #(WIDTH = 32)
  (
    input [WIDTH-1:0] data,
    input instruction_t a,
    output [WIDTH-1:0] result,
    output boolean_t OK
  );
  ...
endmodule: M

package p1;
  int x, y;
endpackage

package p2;
  import p1::x;
  export p1::*; // exports p1::x as the name "x";
  // p1::x and p2::x are the same declaration
endpackage

package p3;
  import p1::*;
  import p2::*;
  export p2::*;
endpackage: p3
