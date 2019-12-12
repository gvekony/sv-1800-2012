interface simple_bus; // Define the interface
  logic req, gnt;
  logic [7:0] addr, data;
  logic [1:0] mode;
  logic start, rdy;
endinterface: simple_bus

interface static i2;
  wire a, b, c, d;
  modport master (input a, b, output c, d);
  modport slave (output a, b, input c, d);
endinterface

interface i2;
  wire a, b, c, d;
  modport master (input a, b, output c, d);
  modport slave (output a, b, input c, d);
endinterface: i2

interface simple_bus (input logic clk); // Define the interface
  logic req, gnt;
  logic [7:0] addr, data;
  logic [1:0] mode;
  logic start, rdy;

  bufif1 b1();

  modport slave (
    input req, addr, mode, start, clk,
    output gnt, rdy,
    ref data
  );

  modport master (
    input gnt, rdy, clk,
    output req, addr, mode, start,
    ref data
  );

endinterface: simple_bus

interface A_Bus( input logic clk );
  wire req, gnt;
  wire [7:0] addr, data;
  clocking sb @(posedge clk);
    input gnt;
    output req, addr;
    inout data;

    property p1;
      req ##[1:3] gnt;
    endproperty
  endclocking

  modport DUT (
    input clk, req, addr, // Device under test modport
    output gnt,
    inout data
  );

  modport STB (
    clocking sb
  ); // synchronous testbench modport

  modport TB (
    input gnt, // asynchronous testbench modport
    output req, addr,
    inout data
  );

endinterface

interface static simple_bus (input logic clk); // Define the interface
  logic req, gnt;
  logic [7:0] addr, data;
  logic [1:0] mode;
  logic start, rdy;

  task masterRead(input logic [7:0] raddr); // masterRead method
    ...
  endtask: masterRead

  task slaveRead; // slaveRead method
    ...
  endtask: slaveRead

endinterface: simple_bus

interface simple_bus (input logic clk); // Define the interface
  modport slave (input req, addr, mode, start, clk,
    output gnt, rdy,
    ref data,
    import slaveRead, slaveWrite,
    export slaveWrite, slaveRead
  );
endinterface: simple_bus

interface ebus_i;
  integer I; // reference to I not allowed through modport mp
  typedef enum {Y,N} choice;
  choice Q;

  localparam True = 1;

  modport mp(input Q);
endinterface

module Top;
  ebus_i ebus ();
  sub s1 (ebus.mp);
endmodule

module sub(interface.mp i);
  typedef i.choice yes_no; // import type from interface
  yes_no P;
  assign P = i.Q; // refer to Q with a port reference
  initial
    Top.ebus.Q = i.True; // refer to Q with a hierarchical reference
  initial
    Top.ebus.I = 0; // referring to i.I would not be legal because
endmodule
