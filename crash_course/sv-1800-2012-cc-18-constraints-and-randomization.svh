class Bus #( asd () );
  rand bit[15:0] addr;
  rand bit[31:0] data;

  extern constraint abc;
  
  pure static constraint Bus::asdasf;

  static constraint abc;

  constraint word_align {
    addr[1:0] == 2'b0;
  }
  
endclass

static constraint abc;

static constraint Bus::abc {
  
}

typedef enum {low, mid, high} AddrType;

class MyBus extends Bus;
  
  rand AddrType atype;

  constraint a {}

  constraint addr_range
  {
    (atype == low ) -> addr inside { [0 : 15] };
    (atype == mid ) -> addr inside { [16 : 127]};
    (atype == high) -> addr inside {[128 : 255]};
  }
endclass

task exercise_bus (MyBus bus);
  int res;
  // EXAMPLE 1: restrict to low addresses
  res = bus.randomize() with {atype == low;};
  // EXAMPLE 2: restrict to address between 10 and 20
  res = bus.randomize() with {10 <= addr && addr <= 20;};
  // EXAMPLE 3: restrict data values to powers-of-two
  res = bus.randomize() with {(data & (data - 1)) == 0;};
endtask

class MyXYPair extends XYPair;
  function void pre_randomize();
    super.pre_randomize();
    $display("Before randomize x=%0d, y=%0d", x, y);
  endfunction

  function void post_randomize();
    super.post_randomize();
    $display("After randomize x=%0d, y=%0d", x, y);
  endfunction
endclass

int success = p.randomize();

function bit gen_stim();
  bit success, rd_wr;
  success = randomize( addr, data, rd_wr ); // call std::randomize
  return rd_wr ;
endfunction


class packet;
  typedef struct {
    randc int addr = 1 + constant;
    int crc;
    rand byte data [] = {1,2,3,4};
  } header;

  rand header h1;
endclass

class C;
  rand int x;
  
  static constraint proto;

  constraint proto1; // implicit form
  extern constraint proto2; // explicit form


  rand byte a[5];
  rand byte b;
  rand byte excluded;
  constraint u { unique {b, a[2:3], excluded}; }
  constraint exclusion { excluded == 5; }

  mode == little -> len < 10;
  mode == big -> len > 100;

  constraint C1 { foreach ( A [ i ] ) A[i] inside {2,4,8,16}; }
  constraint c1 { A.size inside {[1:10]}; }
  constraint c2 { foreach ( A[ k ] ) (k < A.size - 1) -> A[k + 1] > A[k]; }

  rand bit [31:0] d;
  constraint c { s -> {d == 0;} }
  constraint order { solve s before d; }

endclass

constraint C::proto1 { x inside {-4, 5, 7}}; }
constraint C::proto2 { x >= 0; }

virtual class D;
  pure constraint test;

endclass


rand integer x, y, z;
constraint c1 {x inside {3, 5, [9:15], [24:32], [y:2*y], z};}
rand integer a, b, c;
constraint c2 {a inside {b, c};}
integer fives[4] = '{ 5, 10, 15, 20 };
rand integer v;
constraint c3 { v inside {fives}; }

x != 200;
x dist {100 := 1, 200 := 2, 300 := 5}

class Packet;
  rand int length;
  constraint deflt { soft length inside {32,1024}; }
endclass

class B;
  rand int x;
  constraint B1 { soft x == 5; }
  constraint B2 { 
    disable soft x; 
    soft x dist {5, 8};
  }
endclass

get_randstate();
set_randstate();
srandom();

randcase
  3 : x = 1;
  1 : x = 2;
  4 : x = 3;
endcase

randcase
  a + b : x = 1;
  a - b : x = 2;
  a ^ ~b : x = 3;
  12'b800 : x = 4;
endcase

randsequence( main )
  main : first second done ;
  first : add | dec ;
  second : pop | push ;
  done : { $display("done"); } ;
  add : { $display("add"); } ;
  dec : { $display("dec"); } ;
  pop : { $display("pop"); } ;
  push : { $display("push"); } ;
  rand join asd;
endsequence

randsequence()
  WRITE : SETUP DATA ;
  SETUP : { if( fifo_length >= max_length ) break; } COMMAND ;
  DATA : ...
endsequence

randsequence()
  TOP : P1 P2 ;
  P1 : A B C ;
  P2 : A { if( flag == 1 ) return; } B C ;
  A : { $display( "A" ); } ;
  B : { if( flag == 2 ) return; $display( "B" ); } ;
  C : { $display( "C" ); } ;
endsequence

int cnt;
...
randsequence( A )
  void A  : A1 A2;
  void A1 : { cnt = 1; } B repeat(5) C B
            { $display("c=%d, b1=%d, b2=%d", C, B[1], B[2]); }
            ;
  void A2 : if (cond) D(5) else D(20)
            { $display("d1=%d, d2=%d", D[1], D[2]); }
            ;
  int B   : C { return C;}
  | C C { return C[2]; }
  | C C C { return C[3]; }
  ;
  int C : { cnt = cnt + 1; return cnt; };
  int D (int prm) : { return prm; };
endsequence

function int[$] GenQueue(int low, int high);
  int[$] q;
  randsequence()
    TOP       : BOUND(low) LIST BOUND(high) ;
    LIST      : LIST ITEM := 8 { q = { q, ITEM }; }
              | ITEM := 2 { q = { q, ITEM }; }
    ;
    int ITEM  : { return $urandom_range( low, high ); } ;
    BOUND(int b) : { q = { q, b }; } ;
  endsequence
  GenQueue = q;
endfunction
