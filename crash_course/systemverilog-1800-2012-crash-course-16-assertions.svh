module abc();
  assert_f:
  assert(f) $info("passed");
  else $error("failed");

  assume_inputs:
  assume (in_a || in_b) $info("assumption holds");
  else $error("assumption does not hold");

  time t;

  always @(posedge clk)
  if (state == REQ)
  assert (req1 || req2)
  else begin
    t = $time;
    #5 $error("assert failed at time %0t", t);
  end

  assert #0 (expression) action_block;
  assert final (expression) action_block;

  function f(bit v);
    p: assert #0 (v);
    ...
  endfunction

  always_comb begin: myblk
    a = b || f(c);
  end

  always @(a or b) begin : b1
    a3: assert #0 (a == b) rptobj.success(0); else rptobj.error(0, a, b);
    #1;
    a4: assert #0 (a == b) rptobj.success(1); else rptobj.error(1, a, b);
  end : b1
endmodule

module dut(input logic clk, input logic a, input logic b);
  logic c;

  always_ff @(posedge clk)
  c <= b;

  a1: assert #0 (!(a & c)) $display("Pass"); else $display("Fail");
  a2: assert final (!(a & c)) $display("Pass"); else $display("Fail");
endmodule

module dut_two();
  global clocking @clk;
  endclocking
  ...
  assert    property(@$global_clock a);
  assume    property(@$global_clock a);
  cover     property(@$global_clock a);
  restrict  property(@$global_clock a);

  bit a;
  integer b;
  byte q[$];

  property p1;
    $rose(a) |-> q[0];
  endproperty: p1

  property p2;
    integer l_b;
    ($rose(a), l_b = b) |-> ##[3:10] q[l_b];
  endproperty

  bit count[2:0];
  realtime t;
  initial count = 0;
  always @(posedge clk) begin
    if (count == 0) t = $realtime; //capture t in a procedural context
    count++;
  end

  property p1;
    @(posedge clk)
    count == 7 |-> $realtime – t < 50.5;
  endproperty

  property p2;
    realtime l_t;

    @(posedge clk)
    (count == 0, l_t = $realtime) ##1 (count == 7)[->1] |->
    $realtime – l_t < 50.5;
  endproperty

  and intersect or first_match throughout within

  sequence s1;
    @(posedge clk) a ##1 b ##1 c;
  endsequence

  sequence s2;
    @(posedge clk) d ##1 e ##1 f;
  endsequence

  sequence s3;
    @(negedge clk) g ##1 h ##1 i;
  endsequence

  sequence s4;
    @(edge clk) j ##1 k ##1 l;
  endsequence

  sequence delay_example(x, y, min, max, delay1);
    x ##delay1 y[*min:max];
  endsequence: delay_example

  // Legal
  a1: assert property (@(posedge clk) delay_example(x, y, 3, $, 2));
  int z, d;
  // Illegal: z and d are not elaboration-time constants
  a2_illegal: assert property (@(posedge clk) delay_example(x, y, z, $, d));

  sequence delay_arg_example (max, shortint delay1, delay2, min);
    x ##delay1 y[*min:max] ##delay2 z;
  endsequence: delay_arg_example

  parameter my_delay=2;
  cover property (delay_arg_example($, my_delay, my_delay-1, 3));

  logic b_d, d_d;
  sequence legal_loc_var_formal (
    local inout logic a,
    local logic b = b_d, // input inferred, default actual argument b_d
    c, // local input logic inferred, no default actual argument
    d = d_d, // local input logic inferred, default actual argument d_d
    logic e, f // e and f are not local variable formal arguments
    );

    logic g = c, h = g || d;
    ...
  endsequence
  ##[*] ##2 ##[+]

  req ##[4:32] gnt
  req ##1 gnt

  d ##1 e ##1 f // second sequence seq2
  (a ##1 b ##1 c) ##0 (d ##1 e ##1 f) // overlapped concatenation
  a ##1 b ##1 c&&d ##1 e ##1 f

  req ##[4:$] gnt
  a ##1 b ##1 c ##3 `true

  sequence delay_example(x, y, min, max, delay1);
    x ##delay1 y[*min:max];
  endsequence
  // Legal
  a1: assert property (@(posedge clk) delay_example(x, y, 3, $, 2));

  int z, d;

  // Illegal: z and d are not elaboration-time constants
  a2_illegal: assert property (@(posedge clk) delay_example(x, y, z, $, d));

  sequence s20_1(data,en);
    (!frame && (data==data_bus)) ##1 (c_be[0:3] == en);
  endsequence

  sequence s1(w, x, y);
    w ##1 x ##[2:10] y;
  endsequence

  sequence delay_arg_example (max, shortint delay1, delay2, min);
    x ##delay1 y[*min:max] ##delay2 z;
  endsequence

  parameter my_delay=2;
  cover property (delay_arg_example($, my_delay, my_delay-1, 3));

  a ##1 b ##1 b ##1 b ##1 c
  a ##1 b [*3] ##1 c
  a [*3] means a ##1 a ##1 a
  a [*0]

  sequence t2;
    (a ##[2:3] b) or (c ##[1:2] d);
  endsequence
  sequence ts2;
    first_match(t2);
  endsequence

  property abc(a, b, c);
    disable iff (a==2) @(posedge clk) not (b ##1 c);
  endproperty

  env_prop: ASSERT property (abc(rst, in1, in2)) $display("env_prop passed.");
  else $display("env_prop failed.");
  and


  Assertion_label:
  assert (a == 1) ;
  else ;

  property check_phase1;
    s1 |-> (phase1_prop and (1'b1 |=> check_phase2));
  endproperty
  property check_phase2;
    s2 |-> (phase2_prop and (1'b1 |=> check_phase1));
  endproperty

  property p_delay(logic [1:0] delay);
    case (delay)
      2'd0 : a && b;
      2'd1 : a ##2 b;
      2'd2 : a ##4 b;
      2'd3 : a ##8 b;
      default: 0; // cause a failure if delay has x or z values
    endcase
  endproperty

  property fibonacci2 (int a, b, n, fib_sig);
    (n > 0)
    |->
    (
    (fib_sig == a)
    and
    (1'b1 |=> fibonacci2(b, a + b, n - 1, fib_sig))
    );
  endproperty

  property rule5;
    @(posedge clk)
    a ##1 (b || c)[->1] |->
    if (b)
    (##1 d |-> e)
    else // c
    f ;
  endproperty

  @(posedge clk0) if (b) @(posedge clk1) s1 else @(posedge clk2) s2

  @(c) x |=> @(c) y ##1 @(d) z
  @(c) x |=> y ##1 @(d) z

  property mult_p8;
    @(posedge clk) a ##1 b |->
    if (c)
    (1 |=> @(posedge clk1) d)
    else
    e ##1 @(posedge clk2) f ;
  endproperty

  sequence_instance.matched()
  formal_argument_sequence.matched

  sequence e1(a,b,c);
    @(posedge clk) $rose(a) ##1 b ##1 c ;
  endsequence
  sequence e2;
    @(posedge sysclk) reset ##1 inst ##1 e1(ready,proc1,proc2).matched [->1]
    ##1 branch_back;
  endsequence

  property abc(a, b, c);
    disable iff (a==2) @(posedge clk) not (b ##1 c);
  endproperty

  env_prop: assert property (abc(rst, in1, in2))
  $display("env_prop passed.");
  else
  $display("env_prop failed.");

  a1:assume property ( @(posedge clk) req dist {0:=40, 1:=60} ) ;
  property proto ;
    @(posedge clk) req |-> req[*1:$] ##0 ack;
  endproperty

  a1:assume property (@(posedge clk) req dist {0:=40, 1:=60} );
  assume_req1:assume property (pr1);
  assume_req2:assume property (pr2);
  assume_req3:assume property (pr3);
  assert_ack1:assert property (pa1)
  else $display("\n ack asserted while req is still deasserted");
  assert_ack2:assert property (pa2)
  else $display("\n ack is extended over more than one cycle");

  restrict property (@(posedge clk) ctr == '0);

  assert property ( property_spec ) action_block;
  always assert property ( property_spec ) action_block;
  cover property ( property_spec ) statement_or_null;
  always cover property ( property_spec ) statement_or_null;

  module top(input logic clk);
    logic a,b,c;

    sequence seq3;
      @(posedge clk) b ##1 c;
    endsequence

    c1: cover property (seq3);
    ...
  endmodule: top

  property r1;
    q != d;
  endproperty
  always @(posedge mclk) begin
    q <= d1;
    r1_p1: assert property (r1);
    r1_p2: assert property (@(posedge scanclk)r1);
  end

  default clocking @(posedge clk);
  endclocking
  always @(a or b or c) begin : b2
    if (c == 8'hff) begin
      a2: assert property (a && b);
    end else begin
      a3: assert property (a || b);
    end
  end

  always @(clear_b2) begin : b3
    disable b2;
  end

  $inferred_clock
  $inferred_disable

  module m(logic a, b, c, d, rst1, clk1, clk2);
    logic rst;
    default clocking @(negedge clk1);
    endclocking
    default disable iff rst1;

    property p_triggers(start_event, end_event, form, clk = $inferred_clock,
      rst = $inferred_disable);
      @clk disable iff (rst)
      (start_event ##0 end_event[->1]) |=> form;
    endproperty

    property p_multiclock(clkw, clkx = $inferred_clock, clky, w, x, y, z);
      @clkw w ##1 @clkx x |=> @clky y ##1 z;
    endproperty

    a1: assert property (p_triggers(a, b, c));
    a2: assert property (p_triggers(a, b, c, posedge clk1, 1'b0) );
    always @(posedge clk2 or posedge rst) begin
      if (rst) ... ;
      else begin
        a3: assert property (p_triggers(a, b, c));
        ...
      end
    end

    a4: assert property(p_multiclock(negedge clk2, , posedge clk1, a, b, c, d) );
  endmodule

  sequence s2; @(posedge clk) a ##2 b;
  endsequence
  property p2; not s2;
  endproperty
  assert property (p2);

  // — Property, for example:
  property p3; @(posedge clk) not (a ##2 b);
  endproperty
  assert property (p3);
  // — Contextually inferred clock from a procedural block, for example:
  always @(posedge clk) assert property (not (a ##2 b));
  // — A clocking block, for example:
  clocking master_clk @(posedge clk);
    property p3; not (a ##2 b);
    endproperty
  endclocking

  assert property (master_clk.p3);

  // — Default clock, for example:
  default clocking master_clk ; // master clock as defined above
  property p4; (a ##2 b);
  endproperty
  assert property (p4);

  expect  wait
endsequence
endmodule