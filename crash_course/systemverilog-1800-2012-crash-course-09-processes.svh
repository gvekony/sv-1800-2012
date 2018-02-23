initial begin: label_test
  a = 0; // initialize a
  for (int index = 0; index < size; index++)
  memory[index] = 0; // initialize memory word
end: label_test

begin:label_test1
  begin: label_test2
  end :label_test2
end : label_test1

end // unmatched pair

always areg = ~areg;

always_comb
  a = b & c;

always_comb
  d <= #1ns b & c;

always_comb
begin
  a = b & c;
  A1:assert (a != e) else if (!disable_error) $error("failed");
end

always_latch
  if(ck) q <= d;

always_ff @(posedge clock iff reset == 0 or posedge reset)
begin
  r1 <= reset ? 0 : r2 + 1;
end

final
begin
  $display("Number of cycles executed %d",$time/period);
  $display("Final PC = %h",PC);
end

begin
  areg = breg;
  @(posedge clock) creg = areg; // assignment delayed until
end

parameter d = 50; // d declared as a parameter and
logic [7:0] r; // r declared as an 8-bit variable
begin // a waveform controlled by sequential delays
  #d r = 'h35;
  #d r = 'hE2;
  #d r = 'h00;
  #d r = 'hF7;
end

fork
  begin
    $display( "First Block\n" );
    #20ns;
  end
  begin
    $display( "Second Block\n" );
    @eventA;
  end
join

task wait_20;
  fork
    # 20;
    return ; // Illegal: cannot return; task lives in another process
  join_none
endtask

begin
  fork : fork_label
    @Aevent;
    @Bevent;
  join_any : fork_label
  areg = breg;
end

labelB: fork // label before the begin or fork
...
join_none : labelB

@r rega = regb; // controlled by any value change in the reg r
@(posedge clock) rega = regb; // controlled by posedge on clock
forever @(negedge clock) rega = regb; // controlled by negedge on clock
forever @(edge clock) rega = regb; // controlled by edge on clock

real AOR[]; // dynamic array of reals
byte stream[$]; // queue of bytes
initial wait(AOR.size() > 0) ....; // waits for array to be allocated
initial wait($bits(stream) > 60)...; // waits for total number of bits
// in stream greater than 60
Packet p = new; // Packet 1 -- Packet is defined in 8.2
Packet q = new; // Packet 2
initial fork
  @(p.status); // Wait for status in Packet 1 to change
  @p; // Wait for a change to handle p
  # 10 p = q; // triggers @p.
  // @(p.status) now waits for status in Packet 2 to change,
  // if not already different from Packet 1
join

@(trig or enable) rega = regb; // controlled by trig or enable
@(posedge clk_a or posedge clk_b or trig) rega = regb;

always @(a, b, c, d, e)
always @(posedge clk, negedge rstn)
always @(a or b, c, d or e)

always @(*) // equivalent to @(a or b or c or d or f)
y = (a & b) | (c & d) | myfunction(f);

always @* begin // equivalent to @(a or b or c or d or tmp1 or tmp2)
  tmp1 = a & b;
  tmp2 = c & d;
  y = tmp1 | tmp2;
end

always @* begin // equivalent to @(b)
  @(i) kid = b; // i is not added to @*
end

always @* begin // equivalent to @(a or b or c or d)
  x = a ^ b;
  @* // equivalent to @(c or d)
  x = c ^ d;
end

always @* begin // same as @(state or go or ws)
  next = 4'b0;
  case (1'b1)
    state[IDLE]:
      if (go) next[READ] = 1'b1;
        else next[IDLE] = 1'b1;
    state[READ]: next[DLY ] = 1'b1;
    state[DLY ]:
      if (!ws) next[DONE] = 1'b1;
        else next[READ] = 1'b1;
    state[DONE]: next[IDLE] = 1'b1;
  endcase
end

module latch (output logic [31:0] y, input [31:0] a, input enable);
  always @(a iff enable == 1)
    y <= a; //latch is in transparent mode
endmodule

sequence abc;
  @(posedge clk) a ##1 b ##1 c;
endsequence

program test;
  initial begin
    @ abc $display( "Saw a-b-c" );
    L1 : ...
  end
endprogram

program check;
  initial begin
    wait( abc.triggered || de.triggered );
    if( abc.triggered )
    $display( "abc succeeded" );
    if( de.triggered )
    $display( "de succeeded" );
    L2 : ...
  end
endprogram

a = repeat(3) @(posedge clk) b;
a = repeat(num) @(clk) data;
a <= repeat(a+b) @(posedge phi1 or negedge phi2) data;

task do_test;
  fork
    exec1();
    exec2();
  join_any
  fork
    exec3();
    exec4();
  join_none
  wait fork; // block until exec1 ... exec4 complete
endtask

begin : block_name
  rega = regb;
  disable block_name;
  regc = rega; // this assignment will never execute
end

task get_first( output int adr );
  fork
    wait_device( 1, adr );
    wait_device( 7, adr );
    wait_device( 13, adr );
  join_any
  disable fork;
endtask

class process;
  typedef enum { FINISHED, RUNNING, WAITING, SUSPENDED, KILLED } state;
  extern static function process self();
  extern function state .status();
  extern function void .kill();
  extern task .await();
  extern function void .suspend();
  extern function void .resume();
  extern function void srandom( int seed );
  extern function string get_randstate();
  extern function void set_randstate( string state );
endclass