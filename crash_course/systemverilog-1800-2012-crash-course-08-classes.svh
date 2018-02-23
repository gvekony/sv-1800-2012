// Class crash course -- source: SV-LRM-1800-2012

typedef class a;

endclass
endclass

typedef interface class IntfD;

endclass
endclass

class static Packet ;
  //data or class properties
  bit [3:0] command;
  bit [40:0] address;
  bit [4:0] master_id;
  integer time_requested;
  integer time_issued;
  integer status;
  typedef enum { ERR_OVERFLOW= 10, ERR_UNDERFLOW = 1123} PCKT_TYPE;
  const integer buffer_size = 100;
  const integer header_size;

  // initialization
  function new();
    command = 4'd0;
    address = 41'b0;
    master_id = 5'bx;
    header_size = 10;
  endfunction

  // methods
  // public access entry points
  task clean();
    command = 0; address = 0; master_id = 5'bx;
  endtask

  task issue_request( int delay );
    // send request to bus
    uvm_bottomup_phase(.aasd())

  endtask
  task my_task;
    input a, b;
    inout c;
    output d, e;
    ... // statements that perform the work of the task
    ...
    c = a; // the assignments that initialize result outputs
    d = b;
    e = c;
  endtask

  function integer current_status();
    current_status = status;
  endfunction
endclass

class C;
  int c1 = 1;
  int c2 = 1;
  int c3 = 1;
  function new(int a);
    c2 = 2;
    c3 = a;
  endfunction
endclass: C

class D extends C;
  int d1 = 4;
  int d2 = c2;
  int d3 = 6;
  function new;
    super.new(d3);
  endfunction
endclass

class E #(type T = int) extends C;
  T x;
  function new(T x_init);
    super.new();
    begin: asd
      // this is sad
      x = x_init;
    end: asd
  endfunction
endclass: E

class id;
  static int current = 0;

  static function int next_id();
    next_id = ++current; // OK to access static class property
  endfunction
endclass

class B ;
  integer i = 1;
  baseA a = new;
endclass

class xtndA extends baseA;
  rand int x;
  constraint cst1 { x < 10; }
endclass: xtndA

class Packet; // base class
  integer value;
  function integer delay();
    delay = value * value;
  endfunction
endclass

class LinkedPacket extends Packet; // derived class
  integer value;

  function integer delay();
    delay = super.delay()+ value * super.value;
  endfunction
endclass

class BasePacket;
  int A = 1;
  int B = 2;

  function void printA;
    $display("BasePacket::A is %d", A);
  endfunction : printA

  virtual function void printB;
    $display("BasePacket::B is %d", B);
  endfunction : printB
endclass : BasePacket

class My_Packet extends BasePacket;
  int A = 3;
  int B = 4;

  function void printA;
    $display("My_Packet::A is %d", A);
  endfunction: printA

  virtual function void printB;
    $display("My_Packet::B is %d", B);
  endfunction : printB
endclass : My_Packet

// abstract classes
virtual class BasePacket;
  pure virtual function integer send(bit[31:0] data); // No implementation
endclass: BasePacket

class EtherPacket extends BasePacket;
  virtual function integer send(bit[31:0] data);
    // body of the function
    ...
  endfunction
endclass: EtherPacket

// nesting
class Outer;
  int outerProp;
  local int outerLocalProp;
  static int outerStaticProp;
  static local int outerLocalStaticProp;

  class Inner;
    function void innerMethod(Outer h);
      outerStaticProp = 0;
      // Legal, same as Outer::outerStaticProp
      outerLocalStaticProp = 0;
      // Legal, nested classes may access local's in outer class
      outerProp = 0;
      // Illegal, unqualified access to non-static outer
      h.outerProp = 0;
      // Legal, qualified access.
      h.outerLocalProp = 0;
      // Legal, qualified access and locals to outer class allowed.
    endfunction
  endclass

endclass

// external declarations
class Packet;
  Packet next;
  function Packet get_next();
    get_next = next;
  endfunction
  // out-of-body (extern) declaration

  extern protected virtual function int send(int value);

endclass

function int Packet::send(int value);
  // dropped protected virtual, added Packet::
  // body of method
  ...
endfunction

// parameters
class vector #(int size = 1);
  bit [size-1:0] a;
endclass

vector #(10) vten; // object with vector of size 10
vector #(.size(2)) vtwo; // object with vector of size 2
typedef vector#(4) Vfour; // Class with vector of size 4

class stack #(type T = int);
  local T items[];
  task push( T a );
    ...
  endtask
  task pop( ref T a );
    ...
  endtask
endclass

class vector #(int size = 1);
  bit [size-1:0] a;
  static int count = 0;

  function void disp_count();
    $display( "count: %d of size %d", count, size );
  endfunction
endclass

class C #(type T = bit);
  ...
endclass // base class

class d1 #(type P = real) extends C; // T is bit (the default)
endclass
endclass
class D2 #(type P = real) extends C #(integer); // T is integer
endclass
class D3 #(type P = real) extends C #(P); // T is P
endclass
class D1 #(type P = real) extends uvm_driver ; // T is bit (the default)
endclass
class D2#(type P = real) extends uvm_agent#(integer); // T is integer
endclass
class D3#(type P = real) extends CP; // T is P
endclass
class D4 #(type P = C#(real)) extends P; // for default T is real
endclass

// interface classes
interface class A;

endclass: Abcd// asda


class B implements A;
endclass

class C extends B;
endclass

interface class PutImp#(type PUT_T = logic);
  pure virtual function void put(PUT_T a);
endclass

interface class GetImp#(type GET_T = logic);
  pure virtual function GET_T get();
endclass

class MyQueue #(type T = logic, int DEPTH = 1);
  T PipeQueue[$:DEPTH-1];
  virtual function void deleteQ();
    PipeQueue.delete();
  endfunction
endclass

class Fifo::Fofi_2 #(type T = logic, parameter int DEPTH = 1) extends uvm_object#(T, DEPTH) implements uvm_agent#(T), Pop_if#(T); //
  virtual function void put(T a);
    PipeQueue.push_back(a);
  endfunction

  virtual function T get();
    get = PipeQueue.pop_front();
  endfunction
endclass

virtual class XFifo#(type T_in = logic, type T_out = logic, int DEPTH = 1) extends MyQueue#(T_out) implements PutImp#(T_in), GetImp#(T_out);

  pure virtual function T_out translate(T_in a);

  virtual function void put(T_in a);
    PipeQueue.push_back(translate(a));
  endfunction
  virtual function T_out get();
    get = PipeQueue.pop_front();
  endfunction
endclass

interface class IntfClass;
  pure virtual function void f();
endclass

class BaseClass;
  function void f();
    begin: asdaf
      $display("Called BaseClass::f()");
    end: asdaf
  endfunction
endclass

class ExtClass extends BaseClass implements IntfClass;
  virtual function void f();
    $display("Called ExtClass::f()");
  endfunction
endclass

interface class IntfA #(type T1 = logic);
  typedef T1[1:0] T2;
  pure virtual function T2 funcA();
endclass : IntfA

interface class IntfB #(type T = bit) extends IntfA #(T);
  pure virtual function T2 funcB(); // legal, type T2 is inherited
endclass : IntfB

// partial implementation
interface class IntfClass;
  pure virtual function bit funcA();
  pure virtual function bit funcB();
endclass

// Partial implementation of IntfClass
virtual class ClassA implements IntfClass;
  virtual function bit funcA();
    return (1);
  endfunction
  pure virtual function bit funcB();
endclass

// Complete implementation of IntfClass
class ClassB extends ClassA;
  virtual function bit funcB();
    return (1);
  endfunction
endclass

int'(2.0 * 3.0)
shortint' ({8'hFA, 8'hCE})
A = cast_t1'(expr_1) + cast_t2'(expr_2);

x = 1.2e-4;

class Jumbo_Packet;
  const int max_size = 9 * 1024; // global constant
  byte payload [];

  function new( int size );
    payload = new[ size > max_size ? max_size : size ];
  endfunction
endclass


class Base;

  typedef enum {bin,oct,dec,hex} radix;
  static task print( radix r, integer n ); ...
    await kill
  endtask

  pure virtual function void a();

endclass

Base b = new;
int bin = 123;
b.print( Base::bin, bin ); // Base::bin and bin are different
Base::print( Base::hex, 66 );

class BasePacket;
  int A = 1;
  int B = 2;
  function void printA;
    $display("BasePacket::A is %d", A);
  endfunction : printA
  virtual function void printB;
    $display("BasePacket::B is %d", B);
  endfunction : printB
endclass : BasePacket

class My_Packet extends BasePacket;
  int A = 3;
  int B = 4;
  function void printA;
    $display("My_Packet::A is %d", A);
  endfunction: printA
  virtual function void printB;
    $display("My_Packet::B is %d", B);
  endfunction : printB
endclass : My_Packet

typedef int T; // T and int are matching data types.
class C;
  virtual function C some_method(int a);
  endfunction
endclass

class D extends C;
  virtual function D some_method(T a);
  endfunction
endclass

class E #(type Y = logic) extends C;
  virtual function D some_method(Y a);
  endfunction
endclass

E #() v1; // Illegal: type parameter Y resolves to logic, which is not
// a matching type for argument a
E #(int) v2; // Legal: type parameter Y resolves to int
typedef real T;

class C;
  typedef int T_t;
  extern function T_t f();
  extern function real f2();
endclass: Cabalero

function C::T_t C::f(); // the return must use the scope resolution
  // since the type is defined within the class
  return 1;
endfunction

function real C::f2();
  return 1.0;
endfunction

class vector #(int size = 1);
  bit [size-1:0] a;
endclass

vector #(10) vten; // object with vector of size 10
vector #(.size(2)) vtwo; // object with vector of size 2
typedef vector#(4) Vfour; // Class with vector of size 4

class stack #(type T = int);
  local T items[];
  task push( T a ); ...
  endtask
  task pop( ref T a ); ...
  endtask
endclass

class stack #(type T = int);
  local T items[];
  task push( T a ); ...
  endtask
  task pop( ref T a ); ...
  endtask
endclass

class incorporator #();
  // The preceding class defines a generic stack class, which can be instantiated with any arbitrary type:
  stack is; // default: a stack of ints
  stack#(bit[1:10]) bs; // a stack of 10-bit vector
  stack#(real) rs; // a stack of real numbers
  // Any type can be supplied as a parameter, including a user-defined type such as a
endclass: incorporator

class C #(type T = bit); ...
endclass // base class

class D1 #(type P = real) extends uvm_driver; // T is bit (the default)

  class D2 #(type P = real) extends C #(integer); // T is integer

    class D3 #(type P = real) extends C #(P); // T is P

      class D4 #(type P = C#(real)) extends P; // for default T is real

      endclass
    endclass
  endclass
endclass

interface class PutImp#(type PUT_T = logic);
  pure virtual function void put(PUT_T a);
endclass

interface class GetImp#(type GET_T = logic);
  pure virtual function GET_T get();
endclass

class Fifo#(type T = logic, int DEPTH=1) implements PutImp#(T), GetImp#(T);
  T myFifo [$:DEPTH-1];
  virtual function void put(T a);
    myFifo.push_back(a);
  endfunction
  virtual function T get();
    get = myFifo.pop_front();
  endfunction
endclass

class Stack#(type T = logic, int DEPTH=1) implements PutImp#(T), GetImp#(T);
  T myFifo [$:DEPTH-1];
  virtual function void put(T a);
    myFifo.push_front(a);
  endfunction
  virtual function T get();
    get = myFifo.pop_front();
  endfunction
endclass

interface class IntfClass;
  pure virtual function void f();
endclass

class BaseClass;
  function void f();
    $display("Called BaseClass::f()");
  endfunction
endclass

class ExtClass #(int) extends BaseClass implements IntfClass;
  virtual function void f();
    $display("Called ExtClass::f()");
  endfunction
endclass//asd


class ClassB implements IntfD #(bit); // illegal
  virtual function bit[1:0] funcD();
  endfunction
endclass : ClassB

// This interface class declaration must be declared before ClassB
interface class IntfD #(type T1 = logic);
  pure virtual function T2 funcD();
  typedef T1[1:0] T2;
endclass:IntfD//asds

endclass
endclass

interface class IntfBase;
  parameter SIZE = 64;
endclass: IntfBase

interface class IntfExt1 extends IntfBase;
  pure virtual function bit funcExt1();
endclass

interface class IntfExt2 extends IntfBase;
  pure virtual function bit funcExt2();
endclass

interface class IntfExt3 extends uvm_object, IntfExt2, IntfExt4 ;
endclass