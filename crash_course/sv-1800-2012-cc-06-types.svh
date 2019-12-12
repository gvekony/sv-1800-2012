module wrapper();

  // user-defined data type T
  typedef struct {
    real field1;
    bit field2;
  } T;

  // user-defined resolution function Tsum
  function automatic T Tsum (input T driver[]);
    Tsum.field1 = 0.0;
    foreach (driver[i])
    Tsum.field1 += driver[i].field1;
  endfunction

  nettype T wT; // an unresolved nettype wT whose data type is T
  // a nettype wTsum whose data type is T and
  // resolution function is Tsum
  nettype T wTsum with Tsum;
  // user-defined data type TR
  typedef real TR[5];
  // an unresolved nettype wTR whose data type
  // is an array of real
  nettype TR wTR;
  // declare another name nettypeid2 for nettype wTsum
  nettype wTsum nettypeid2;

  // typedefs

  interface intf_i;
    typedef int data_t;
  endinterface

  module sub(intf_i p);
    typedef p.data_t my_data_t;
    my_data_t data;
    // type of 'data' will be int when connected to interface above
  endmodule

  // Correct: IDLE=0, XX='x, S1=1, S2=2
  enum integer {IDLE, XX='x, S1='b01, S2='b10} state, next;
  // Syntax error: IDLE=0, XX='x, S1=??, S2=??
  enum integer {IDLE, XX='x, S1, S2} state, next;
  // Correct declaration - bronze and gold are unsized
  enum bit [3:0] {bronze='h3, silver, gold='h5} medal2;
  // Correct declaration - bronze and gold sizes are redundant
  enum bit [3:0] {bronze=4'h3, silver, gold=4'h5} medal3;
  // Error in the bronze and gold member declarations
  enum bit [3:0] {bronze=5'h13, silver, gold=3'h5} medal4;

  // matching and equivalent
  typedef bit node; // 'bit' and 'node' are matching types
  typedef type1 type2; // 'type1' and 'type2' are matching types

  struct packed {int A; int B;} AB1, AB2; // AB1, AB2 have matching types
  struct packed {int A; int B;} AB3; // the type of AB3 does

  typedef bit signed [7:0] BYTE; // matches the byte type
  typedef bit signed [0:7] ETYB; // does not match the byte type

  typedef byte MEM_BYTES [256];
  typedef bit signed [7:0] MY_MEM_BYTES [256]; // MY_MEM_BYTES matches
  // MEM_BYTES
  typedef logic [1:0] [3:0] NIBBLES;
  typedef logic [7:0] MY_BYTE; // MY_BYTE and NIBBLES are not matching types
  typedef logic MD_ARY [][2:0];
  typedef logic MD_ARY_TOO [][0:2]; // Does not match MD_ARY

  typedef byte signed MY_CHAR; // MY_CHAR matches the byte type

  typedef bit signed [7:0] BYTE; // equivalent to the byte type
  typedef struct packed signed {bit[3:0] a, b;} uint8;
  // equivalent to the byte type
  bit [9:0] A [0:5];
  bit [size-1:0] A [value-2:5];
  bit [1:10] B [6];
  typedef bit [10:1] uint10;
  uint10 C [6:1]; // A, B and C have equivalent types
  typedef int anint [0:0]; // anint is not type equivalent to int

  // Illegal conversion from 24-bit struct to 32 bit int - compile time error
  struct {bit[7:0] a; shortint b;} a;
  int b = int'(a);
  // Illegal conversion from 20-bit struct to int (32 bits) - run time error
  struct {bit a[$]; shortint b;} a = {{1,2,3,4},67};
  int b = int'(a);
  // Illegal conversion from int (32 bits) to struct dest_t (25 or 33 bits),
  // compile time error
  typedef struct {byte a[$]; bit b;} dest_t;
  int a;
  dest_t b = dest_t'(a);


  this.member.function();
  module testmodule();
    this.member.function();
  endmodule

  // structures
  struct { bit [7:0] opcode; bit [23:0] addr; }IR; // anonymous structure
  // defines variable IR
  IR.opcode = 1; // set field in IR.
  typedef struct {
    bit [7:0] opcode;
    bit [23:0] addr;
  } instruction_t; // named structure type
  instruction_t IR; // define variable

  struct packed signed {
    int a;
    shortint b;
    byte c;
    bit [7:0] d;
  } pack1; // signed, 2-state

  struct packed unsigned {
    time a;
    integer b;
    logic [31:0] c;
  } pack2; // unsigned, 4-state

  typedef union { int i; shortreal f; } num; // named union type
  num n;
  n.f = 0.0; // set n in floating point format
  typedef struct {
    bit isfloat;
    union { int i; shortreal f; } n; // anonymous union type
  } tagged_t; // named structure

  typedef union packed { // default unsigned
    s_atmcell acell;
    bit [423:0] bit_slice;
    bit [52:0][7:0] byte_slice;
  } u_atmcell;

  const'(x)
  $cast(ax, int)
endmodule: wrapper

virtual class C#(parameter type T = logic, parameter SIZE = 1);
  typedef logic [SIZE-1:0] t_vector;
  typedef T t_array [SIZE-1:0];
  typedef struct {
    t_vector m0 [2*SIZE-1:0];
    t_array m1;
  } t_struct;
endclass

//---
package p1;
  typedef struct {int A;} t_1;
endpackage

typedef struct {int A;} t_2;

module sub();
  import p1::t_1;
  parameter type t_3 = int;
  parameter type t_4 = int;

  typedef struct {int A;} t_5;

  t_1 v1; t_2 v2; t_3 v3; t_4 v4; t_5 v5;
endmodule

module top();
  typedef struct {int A;} t_6;

  sub #(.t_3(t_6)) s1 ();
  sub #(.t_3(t_6)) s2 ();

  initial begin
    s1.v1 = s2.v1; // legal - both types from package p1 (rule 8)
    s1.v2 = s2.v2; // legal - both types from $unit (rule 4)
    s1.v3 = s2.v3; // legal - both types from top (rule 2)
    s1.v4 = s2.v4; // legal - both types are int (rule 1)
    s1.v5 = s2.v5; // illegal - types from s1 and s2 (rule 4)
  end
endmodule
//---

module wrapper();
  string SA[10], qs[$];
  int IA[int], qi[$];
  // Find all items greater than 5
  qi = IA.find( x ) with (x.find>5);
  qi = IA.find(x); // shall be an error
  // Find indices of all items equal to 3
  qi = IA.find_index with ( item == 3 );
  // Find first item equal to Bob
  qs = SA.find_first with ( item == "Bob" );
  // Find last item equal to Henry
  qs = SA.find_last( y ) with ( y == "Henry" );
  // Find index of last item greater than Z
  qi = SA.find_last_index( s ) with ( s > "Z" );
  // Find smallest item
  qi = IA.min;
  // Find string with largest numerical value
  qs = SA.max with ( item.atoi );
  // Find all unique string elements
  qs = SA.unique;
  // Find all unique strings in lowercase
  qs = SA.unique( s ) with ( s.tolower );

  string s[] = { "hello", "sad", "world" };
  s.reverse; // s becomes { "world", "sad", "hello" };
  int q[$] = { 4, 5, 3, 1 };
  q.sort; // q becomes { 1, 3, 4, 5 }

  struct { byte red, green, blue; } c [512];
  c.sort with ( item.red ); // sort c using the red field only
  c.sort( x ) with ( {x.blue, x.green} ); // sort by blue then green

  byte b[] = { 1, 2, 3, 4 };
  int y;
  y = b.sum ; // y becomes 10 => 1 + 2 + 3 + 4
  y = b.product ; // y becomes 24 => 1 * 2 * 3 * 4
  y = b.xor with ( item + 4 ); // y becomes 12 => 5 ^ 6 ^ 7 ^ 8
  logic [7:0] m [2][2] = '{ '{5, 10}, '{15, 20} };
  int y;
  y = m.sum with (item.sum with (item)); // y becomes 50 => 5+10+15+20
  logic bit_arr_t [1024];
  int y;
  y = bit_arr_t.sum with ( int'(item) ); // forces result to be 32-bit

  int arr[];
  int q[$];
  ...
  // find all items equal to their position (index)
  q = arr.find with ( item == item.index );
endmodule