if (expression) statement;
else if (expression) statement;
else if (expression) statement;
else statement;

// declare variables and parameters
logic [31:0] instruction,
segment_area[255:0];
logic [7:0] index;
logic [5:0] modify_seg1,
modify_seg2,
modify_seg3;
parameter
  segment1 = 0, inc_seg1 = 1,
  segment2 = 20, inc_seg2 = 2,
  segment3 = 64, inc_seg3 = 4,
  data = 128;

// test the index variable
if (index < segment2) begin
  instruction = segment_area [index + modify_seg1];
  index = index + inc_seg1;
end
else if (index < segment3) begin
  instruction = segment_area [index + modify_seg2];
  index = index + inc_seg2;
end
else if (index < data) begin
  instruction = segment_area [index + modify_seg3];
  index = index + inc_seg3;
end
else
  instruction = segment_area [index];

if (e matches (tagged Jmp (tagged JmpC '{cc:.c,addr:.a})))
  ... // c and a can be used here
else ;
  ...

if (e matches (tagged Jmp .j) &&& j matches (tagged JmpC '{cc:.c,addr:.a}))
  ... // c and a can be used here
else ;

logic [15:0] data;
logic [9:0] result;
case (data)
  16'd0: result = 10'b0111111111;
  16'd1: result = 10'b1011111111;
  16'd2: result = 10'b1101111111;
  16'd3: result = 10'b1110111111;
  16'd4: result = 10'b1111011111;
  16'd5: result = 10'b1111101111;
  16'd6: result = 10'b1111110111;
  16'd7: result = 10'b1111111011;
  16'd8: result = 10'b1111111101;
  16'd9: result = 10'b1111111110;
  default: result = 'x;
endcase

case (1)
  encode[2] : $display("Select Line 2") ;
  encode[1] : $display("Select Line 1") ;
  encode[0] : $display("Select Line 0") ;
  default   : $display("Error: One of the bits expected ON");
endcase

bit [2:0] a;
unique case(a) // values 3,5,6,7 cause a violation report
  0,1: $display("0 or 1");
  2: $display("2");
  4: $display("4");
endcase

priority casez(a) // values 4,5,6,7 cause a violation report
  3'b00?: $display("0 or 1");
  3'b0??: $display("2 or 3");
endcase

unique0 case(a) // values 3,5,6,7 do not cause a violation report
  0,1: $display("0 or 1");
  2: $display("2");
  4: $display("4");
endcase

always_comb begin : a1
  unique case (1'b1)
    a : z = b;
    not_a : z = c;
  endcase
end

case (v) matches
  tagged Invalid : $display ("v is Invalid");
  tagged Valid .n : $display ("v is Valid with value %d", n);
endcase

case (instr) matches
  tagged Add s: case (s) matches
    '{.*, .*, 0} : ; // no op
    '{.r1, .r2, .rd} : rf[rd] = rf[r1] + rf[r2];
  endcase
  tagged Jmp .j: case (j) matches
    tagged JmpU .a : pc = pc + a;
    tagged JmpC '{.c, .a} : if (rf[c]) pc = a;
    default ;
    default: ;
  endcase
endcase

case (instr) matches
  tagged Add '{reg2:.r2,regd:.rd,reg1:.r1} &&& (rd != 0): rf[rd] = rf[r1] + rf[r2];
  tagged Jmp (tagged JmpU .a) : pc = pc + a;
  tagged Jmp (tagged JmpC '{addr:.a,cc:.c}) : if (rf[c]) pc = a;
endcase

foreach( words [ j ] )
  $display( j , words[j] ); // print each index and value
foreach( prod[ k, m ] )
  prod[k][m] = k * m; // initialize

return break continue

initial begin
  clock1 <= 0;
  clock2 <= 0;
  fork
       forever #10 clock1 = ~clock1;
    #5 forever #10 clock2 = ~clock2;
  join
end

logic [2:0] status;
always @(posedge clock)
  priority case (status) inside
    1, 3          : task1; // matches 'b001 and 'b011
    3'b0?0, [4:7] : task2; // matches 'b000 'b010 'b0x0 'b0z0 'b100 'b101 'b110 'b111
  endcase // priority case fails all other values including 'b00x 'b01x 'bxxx