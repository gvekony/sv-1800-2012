module asd();

  clocking ck1 @(posedge clk);
    default input #1step output negedge; // legal
    // outputs driven on the negedge clk
    input ... ;
    output ... ;
  endclocking

  clocking ck2 @(clk); // no edge specified!
    default input #1step output negedge; // legal
    input ... ;
    output ... ;
  endclocking:ck2

  clocking bus @(posedge clock1);
    default input #10ns output #2ns;
    input data, ready, enable = top.mem1.enable;
    output negedge ack;
    input #1step addr;
  endclocking

  clocking dram @(clk);
    input #1ps address;
    input #5 output #6 data;
  endclocking

  program test(input phi1, input [15:0] data, output logic write,
    input phi2, inout [8:1] cmd, input enable
    );
    reg [8:1] cmd_reg;

    clocking cd1 @(posedge phi1);
      input data;
      output write;
      input state = top.cpu1.state;
    endclocking

    clocking cd2 @(posedge phi2);
      input #2 output #4ps cmd;
      input enable;
    endclocking

    initial begin
      // program begins here
      ...
      // user can access cd1.data , cd2.cmd , etc…
    end

    assign cmd = enable ? cmd_reg: 'x;
  endprogram

  interface bus_A (input clk);
    logic [15:0] data;
    logic write;
    modport test (input data, output write);
    modport dut (output data, input write);
  endinterface

  program test(input logic clk, input logic [15:0] data);
    default clocking bus @(posedge clk);
      inout data;
    endclocking

    initial begin
      ## 5;
      if (bus.data == 10)
      ## 1;
      else
      ...
    end
  endprogram

  module processor ();
    clocking busA @(posedge clk1); ...
    endclocking
    clocking busB @(negedge clk2); ...
    endclocking

    module cpu( interface y );
      default clocking busA ;

      initial begin
        ## 5; // use busA => (posedge clk1)
        ...
      end
    endmodule
  endmodule

  module subsystem1;
    logic subclk1;
    global clocking sub_sys1 @(subclk1);
      int i;
    endclocking
    // ...
    common_sub common();
  endmodule

  module top;
    subsystem1 sub1();
    subsystem2 sub2();
  endmodule

  module subsystem1;
    logic subclk1;
    global clocking sub_sys1 @(subclk1);
      // ...
    endclocking
    common_sub common();
  endmodule

  module subsystem2;
    logic subclk2;
    global clocking sub_sys2 @(subclk2);
      // ...
      common_sub common();
    endclocking
  endmodule

  module common_sub;
    always @($global_clock) begin
      // ...
    end
  endmodule

  module top;
    logic a, b, c, clk;
    global clocking top_clocking @(clk);
    endclocking
    // ...
    property p1(req, ack);
      @($global_clock) req |=> ack;
    endproperty

    property p2(req, ack, interrupt);
      @($global_clock) accept_on(interrupt) p1(req, ack);
    endproperty: p2

    my_checker check(
    p2(a, b, c),
    @$global_clock a[*1:$] ##1 b
    );
  endmodule

  checker my_checker(property p, sequence s);
    logic checker_clk;
    global clocking checker_clocking @(checker_clk);

      // ...
    endclocking
    assert property (p);
    cover property (s);
  endchecker

  bus.data[3:0] <= 4'h5; // drive data in Re-NBA region of the current cycle
  ##1 bus.data <= 8'hz; // wait 1 default clocking cycle, then drive data
  ##2; bus.data <= 2; // wait 2 default clocking cycles, then drive data
  bus.data <= ##2 r; // remember the value of r and then drive
  // data 2 (bus) cycles later
  bus.data <= #4 r; // error: regular intra-assignment delay not allowed
  // in synchronous drives

  module m;
    bit a = 1'b1;
    default clocking cb @(posedge clk);
      output a;
    endclocking

    initial begin
      ## 1;
      cb.a <= 1'b0;
      @(x); // x is triggered by reactive stimulus running in same time step
      cb.a <= 1'b1;
    end
  endmodule

  reg j;

  clocking pe @(posedge clk);
    output j;
  endclocking

  clocking ne @(negedge clk);
    output j;
  endclocking

endmodule