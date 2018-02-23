//  systemverilog crash course #1
pure virtual function static void asdafasdaf();
extern virtual function void aqwerasd();
pure virtual function automatic void asdaf();

Example 1: Unsized literal constant numbers
659 // is a decimal number
'h 837FF // is a hexadecimal number
'o7460 // is an octal number
4af // is illegal (hexadecimal format requires 'h)
Example 2: Sized literal constant numbers
4'b1001 // is a 4-bit binary number
5 'D 3 // is a 5-bit decimal number
3'b01x // is a 3-bit number with the least
// significant bit unknown
12'hx // is a 12-bit unknown number
16'hz // is a 16-bit high-impedance number
Example 3: Using sign with literal constant numbers
8 'd -6 // this is illegal syntax
-8 'd 6 // this defines the two's complement of 6,
// held in 8 bits—equivalent to -(8'd 6)
4 'shf // this denotes the 4-bit number '1111', to
// be interpreted as a 2's complement number,
// or '-1'. This is equivalent to -4'h 1
-4 'sd15 // this is equivalent to -(-4'd 1), or '0001'
16'sd? // the same as 16'sbz
Example 4: Automatic left padding of literal constant numbers
logic [11:0] a, b, c, d;
logic [84:0] e, f, g;
initial begin
a = 'h x; // yields xxx
Copyright © 2013 IEEE. All rights reserved.
b = 'h 3x; // yields 03x
c = 'h z3; // yields zz3
d = 'h 0z3; // yields 0z3
e = 'h5; // yields {82{1'b0},3'b101}
f = 'hx; // yields {85{1'hx}}
g = 'hz; // yields {85{1'hz}}
end


virtual function void a();
endfunction: a
function void lorem_ipsum();
endfunction: lorem_ipsum
virtual task static tasky_task();
endtask
virtual function bit[31:0] a();
endfunction: a

function void a();
endfunction: a
function void a();
  for(int i=1; i<120; i++);
endfunction: a

for(int i=1; i<120; i++)

interface a(input bit[31:0] data);
endinterface:a

interface class fw_agent_if extends fw_base_if;
endclass: fw_base_if

class fw_agent_parent extends uvm_component implements fw_agent_if;
endclass: fw_agent_parent

virtual class d;
  // pure constraint test;
endclass

class D2 extends B2;
  rand int x;
  constraint d { soft y inside {[5:9]} ; }
  constraint e ; /* d1 */
  rand D1 p1;
  rand B1 p2;
  rand D1 p3;
  constraint f { soft p1.x < p2.x ; }
  constraint A2 { disable soft x; } // discard soft constraints
endclass

module my_module(
    input clk,    // Clock
    input logic clk_en, // Clock Enable
    input rst_n,  // Asynchronous reset active low;
    my_interface.master my_if  ,// interface
    input my_pkg::my_type_in din,
    input [7:0] ctrl,          // Control
    output reg [15:0] testbus     ,
    output my_pkg::my_type_out dout // output data
  );

  logic [3:0] cnt;      // counter
  logic [15:0] test; // tests comment

  reg [4:0] reg0;
  logic [15:0] t1,t2,t3;
  my_pkg::my_type data0;

  /*  constraints  */
  constraint proto1;
  extern static constraint proto2;
  pure static constraint my_module::proto3;

  constraint my_module::proto2{
    x inside {1, 0, 3};
  }
  constraint c { s -> d == 0; }
  constraint order { solve s before d; }

//------------------------------------------------------------------------------
//  Process alignment
//------------------------------------------------------------------------------

always_ff @(posedge clk or negedge rst_n)
if(~rst_n)
dout <= 0;
else if(clk_en) begin
  dout <= ~dout;
  testbus <= ctrl[3:0];
end

// case align
always_comb begin : proc_comb
  case(my_if.sel)
    16: test = din[16]; // blabla
    7: test = din[7];
    3: begin
      case(cnt[1:0])
        0 : test = 4'h0;
        1 : test = 5 + test; // test
        2 : test = 6 - test;// blabl
        default : test = test[0] ? test : 4'b0000;
      endcase
    end
    4 :
    if(test) begin
      test = test - 1;
    end else begin
      test = cnt;
    end
    default : test = ctrl; // default case
    endcase
  end

// test more indentation level
  always_ff @(posedge rst_n ) begin : proc_
    if(clk) begin
      test <= 0;
      testbus <= 0;
      cnt <= 4'h0;
    end else begin
      if(clk_en)
      if(test[0])
      if(test[1]) begin
        cnt <= 0;
        if(test[2])
        cnt <= 4'h2; // splitception o0
      end
      else begin
        testbus <= cnt;
        if(cnt[16])
        cnt <= cnt + 1;
      end
    end
  end

// Test module instantiation with and without param
  my_submodule i_sub   (
    .i0(din),
    .in1(my_pkg::test'(ctrl)),
    .clk_en(clk_en),
    .output_data(test)
  );

  my_submodule i_sub_ast(.*);

// test split statement: align on ( or =
  always @(ctrl, test, din, my_if.field0,
    cnt,  my_if.field1, dout)
// line Comment
  testbus = ((ctrl[0] == 1'b1) && my_if.field0) ? my_pkg::testbus_value0    :
  ((ctrl[1] == 1'b1) && my_if.field1) ? my_pkg::testbus_value1    :
  ((ctrl[2] == 1'b1) && dout[4]) ? cnt    :
  my_pkg::testbus_default                           ;

  assign test = ctrl[7:0]; // assign_comment
  assign cnt = test + 4;

  assign testbus = {cnt,test};

  my_param_submodule #(
    .PARAM0(1),
    .P4(my_pkg::P4)
  ) i_param_sub  (
    .input_0(din[1:0]),
    .in1(ctrl[7:0]),
    .clk_en(clk_en),
    .output_data(cnt[15:10])
  );

// Function: abs
// Returns absolute value of integer
  function integer abs(input integer value);
    if (value >=0 ) begin
      return value;
    end
    else
    return -value;
  endfunction : abs

  function a_test();
  endfunction: a_test

endmodule
