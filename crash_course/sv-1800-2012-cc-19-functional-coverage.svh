class a;
  covergroup g1 @(posedge clk);
    c: coverpoint color;
  endgroup

  covergroup g2 @(posedge clk);
    Hue: coverpoint pixel_hue;
    Offset: coverpoint pixel_offset;
    AxC: cross color, pixel_adr; // cross 2 variables
    all: cross color, Hue, Offset; // cross 1 variable and 2 coverpoints
  endgroup

  covergroup cov1 @m_z; // embedded covergroup
    coverpoint m_x;
    coverpoint m_y;
    bins
    binsof
    get_coverage();
  endgroup

  class MC;
    logic [3:0] m_x;
    local logic m_z;
    bit m_e;

    covergroup cv1 @(posedge clk);
      coverpoint m_x;
    endgroup

  endclass

  covergroup cg ( ref int x , ref int y, input int c);
    coverpoint x; // creates coverpoint "x" covering the formal "x"
    x: coverpoint y; // INVALID: coverpoint label "x" already exists
    b: coverpoint y; // creates coverpoint "b" covering the formal "y"
    cx: coverpoint x; // creates coverpoint "cx" covering the formal "x"
    option.weight = c; // set weight of "cg" to value of formal "c"
    bit [7:0] d: coverpoint y[31:24]; // creates coverpoint "d" covering the
    // high order 8 bits of the formal "y"

    e: coverpoint x {
      option.weight = 2; // set the weight of coverpoint "e"
    }

    e.option.weight = 2; // INVALID use of "e", also syntax error
    cross x, y { // Creates implicit coverpoint "y" covering
      // the formal "y". Then creates a cross of
      // coverpoints "x", "y"
      option.weight = c; // set weight of cross to value of formal "c"
    }
    b: cross y, x; // INVALID: coverpoint label "b" already exists
  endgroup

  covergroup cg (ref int ra, input int low, int high ) @(posedge clk);
    coverpoint ra // sample variable passed by reference
    {
      bins good = { [low : high] };
      bins bad[] = default;
    }
  endgroup

  covergroup cg @(posedge clk);
    coverpoint v_a
    {
      bins sa = (4 => 5 => 6), ([7:9],10=>11,12);
      bins sb[] = (4=> 5 => 6), ([7:9],10=>11,12);
      bins sc = (12 => 3 [-> 1]);
      bins allother = default sequence ;
      wildcard bins g12_15 = { 4'b11?? };
      ignore_bins ignore_vals = {7,8};
      ignore_bins ignore_trans = (1=>3=>5);
      illegal_bins bad_vals = {1,2,3};
      illegal_bins bad_trans = (4=>5=>6);
    }
  endgroup

  bit [2:0] p1; // type expresses values in the range 0 to 7
  bit signed [2:0] p2; // type expresses values in the range –4 to 3

  covergroup g1 @(posedge clk);
    coverpoint p1 {
      bins b1 = { 1, [2:5], [6:10] };
      bins b2 = { -1, [1:10], 15 };
    }

    coverpoint p2 {
      bins b3 = {1, [2:5], [6:10] };
      bins b4 = { -1, [1:10], 15 };
    }
  endgroup

  covergroup cov3 @(posedge clk);
    A: coverpoint a_var { bins yy[] = { [0:9] }; }
    CC: cross b_var, A;
  endgroup

  int i,j;
  covergroup ct;
    coverpoint i { bins i[] = { [0:1] }; }
    coverpoint j { bins j[] = { [0:1] }; }
    x1: cross i,j;
    x2: cross i,j {
      bins i_zero = binsof(i) intersect { 0 };
    }
  endgroup

  covergroup cg;
    coverpoint a
    {
      bins low[] = {[0:127]};
      bins high = {[128:255]};
    }
    coverpoint b
    {
      bins two[] = b with (item % 2 == 0)
      bins three[] = b with (item % 3 == 0)
    }
    X: cross a,b
    {
      bins apple = X with (a+b < 257) matches 127;
      bins cherry = (( binsof(b) intersect {[0:50]} && binsof(a.low) intersect {[0:50]}) with (a==b)) ;
      bins plum = (binsof(b.two) with (b > 12) || binsof(a.low) with (a & b & mask));
    }
  endgroup
endclass

module mod_m;
  logic [31:0] a, b;
  covergroup cg(int cg_lim);
    coverpoint a;
    coverpoint b;
    aXb : cross a, b
    {
      function CrossQueueType myFunc1(int f_lim);
        for (int i = 0; i < f_lim; ++i)
        myFunc1.push_back('{i,i});
      endfunction

      bins one = myFunc1(cg_lim);
      bins two = myFunc2(cg_lim);

      function CrossQueueType myFunc2(logic [31:0] f_lim);
        for (logic [31:0] i = 0; i < f_lim; ++i)
        myFunc2.push_back('{2*i,2*i});
      endfunction
    }
  endgroup
  cg cg_inst = new(3);
endmodule

class b;
  covergroup yy;
    cross a, b
    {
      ignore_bins ignore = binsof(a) intersect { 5, [1:3] };
      illegal_bins illegal = binsof(y) intersect {bad};
    }
  endgroup
endclass b;

module a;
  g1.option.comment = "Here is a comment set for the instance g1";
  g1.a.option.weight = 3; // Set weight for coverpoint "a" of instance g1

  option.at_least
  option.auto_bin_max
  option.comment
  option.cross_num_print_missing
  option.detect_overlap
  option.goal
  option.name
  option.per_instance
  option.strobe
  option.weight

  type_option.at_least
  type_option.auto_bin_max
  type_option.comment
  type_option.cross_num_print_missing
  type_option.detect_overlap
  type_option.goal
  type_option.name
  type_option.per_instance
  type_option.strobe
  type_option.weight

  option.comment
  option.distribute_first
  option.goal
  option.merge_instances
  option.strobe
  option.weight
  with
  type_option.comment
  type_option.distribute_first
  type_option.goal
  type_option.merge_instances
  type_option.strobe
  type_option.weight

  covergroup p_cg with function sample(bit a, int x);
    coverpoint x;
    cross x, a;
  endgroup : p_cg

  p_cg cg1 = new;

  property p1;
    int x;
    @(posedge clk)(a, x = b) ##1 (c, cg1.sample(a, x));
  endproperty : p1

  c1: cover property (p1);

  function automatic void F(int j);
    bit d;
    ...
    cg1.sample( d, j );
  endfunction

  covergroup C1 (int v) with function sample (int v, bit b); // error (v)
    coverpoint v;
    option.per_instance = b;// error: b may only designate a coverpoint
    option.weight = v; // error: v is ambiguous
  endgroup

  $set_coverage_db_name();
endmodule
