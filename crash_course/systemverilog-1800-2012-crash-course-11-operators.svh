#2ns
##2
#1step
// assignment_operator ::= // from A.6.2
= | += | -= | *= | /= | %= | &= | |= | ^= | <<= | >>= | <<<= | >>>=
// unary_operator ::= // from A.8.6
+ | - | ! | ~ | & | ~& | | | ~| | ^ | ~^ | ^~
// binary_operator ::=
+ | - | * | / | % | == | != | === | !== | ==? | !=? | && | || | **
| < | <= | > | >= | & | | | ^ | ^~ | ~^ | >> | << | >>> | <<<
| -> | <->
// inc_or_dec_operator ::=
++ | --

a = int'(a)

int IntA;
IntA = -12 / 3; // The result is -4
IntA = -'d 12 / 3; // The result is 1431655761
IntA = -'sd 12 / 3; // The result is -4
IntA = -4'sd 12 / 3; // -4'sd12 is the negative of the 4-bit
// quantity 1100, which is -4. -(-4) = 4
// The result is 1
(a < size-1) && (b != c) && (index != lastone)

bit ba = a inside { [16:23], [32:47] };
string I;
if (I inside {["a rock":"hard place"]}) ...

logic [2:0] val;
while ( val inside {3'b1?1} ) ... // matches 3'b101, 3'b111, 3'b1x1, 3'b1z1
wire r;
assign r=3'bz11 inside {3'b1?1, 3'b011}; // r = 1'bx

send:
begin // Create random packet and transmit
  byte q[$];
  Packet p = new;
  void'(p.randomize());
  q = {<< byte{p.header, p.len, p.payload, p.crc}}; // pack
  stream = {stream, q}; // append to stream
end
...
receive: begin // Receive packet, unpack, and remove
  byte q[$];
  Packet p = new;
  {<< byte{ p.header, p.len, p.payload with [0 +: p.len], p.crc }} = stream;
  stream = stream[ $bits(p) / 8 : $ ]; // remove packet
end

int j = { "A", "B", "C", "D" };
{ << byte {j}} // generates stream "D" "C" "B" "A" (little endian)
{ << 16 {j}} // generates stream "C" "D" "A" "B"
{ << { 8'b0011_0101 }} // generates stream 'b1010_1100 (bit reverse)
{ << 4 { 6'b11_0101 }} // generates stream 'b0101_11
{ >> 4 { 6'b11_0101 }} // generates stream 'b1101_01 (same)
{ << 2 { { << { 4'b1101 }} }} // generates stream 'b1110

typedef union tagged {
  struct {
    bit [4:0] reg1, reg2, regd;
  } Add;

  union tagged {
    bit [9:0] JmpU;

    struct {
      bit [1:0] cc;
      bit [9:0] addr;
    } JmpC;

  } Jmp;
} Instr;

// operator overload
bind + function float faddif(int, float);
bind + function float faddfi(float, int);
float A, B, C, D;
assign A = B + C; //equivalent to A = faddff(B, C);
assign D = A + 1.0; //equivalent to A = faddfr(A, 1.0);

bind = function float fcopyi(int); // cast int to float
bind = function float fcopyr(real); // cast real to float
bind = function float fcopyr(shortreal); // cast shortreal to float
float A, B;
bind + function float faddff(float, float);
always @(posedge clock) A += B; // equivalent to A = A + B

let valid_arb(request, valid, override) = |(request & valid) || override;
let mult(x, y) = ($bits(x) + $bits(y))'(x * y);
// let with formal arguments and default value on y
let eq(x, y = b) = x == y;
// without parameters, binds to a, b above
let tmp = a && b;

function static user_type get_fiszfasz();
endfunction: get_fiszfasz

function static int get_name();
endfunction: get_name

package pex_gen9_common_expressions;
  let valid_arb(request, valid, override) = |(request & valid) || override;
endpackage
module my_checker;
  import pex_gen9_common_expressions::*;
  if (valid_arb(.request(req), .valid(vld), .override(ovr))) ;
endmodule