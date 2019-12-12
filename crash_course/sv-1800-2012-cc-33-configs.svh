config cfgl;
  design rtlLib.top;
  instance top use #(.WIDTH(32));
  instance top.a1 use #(.W(top.WIDTH));
endconfig

config cfg2;
  localparam S = 24;
  design rtlLib.top4;
  instance top4.a1 use #(.W(top4.S));
  instance top4.a2 use #(.W(S));
endconfig

config cfg3;
  design rtlLib.top5;
  instance top5.a1 use #(.W()); // set only parameter W back to its default
endconfig

config cfg4;/*some silly comment*/
  design rtlLib.top;
  instance top.a1 use #(); // set all parameters in instance a1
  // back to their defaults
endconfig

module top8 (...);
  parameter WIDTH = 32;
  adder a1 #(.ID("a1")) (...);
  adder a2 #(.ID("a2"),.W(WIDTH))(...);
endmodule

config cfg6;
  design rtlLib.test;
  instance test.t use #(.WIDTH(48));
endconfig
endconfig

config cfg1;
  design rtlLib.top ;
  default liblist aLib rtlLib;
endconfig

config cfg2;
  design rtlLib.top ;
  default liblist gateLib aLib rtlLib;
endconfig

config cfg3;
  design rtlLib.top ;
  default liblist aLib rtlLib;
  cell m use gateLib.m ;
endconfig

config cfg4
  design rtlLib.top ;
  default liblist gateLib rtlLib;
  instance top.a2 liblist aLib;
endconfig

config cfg5;
  design aLib.adder;
  default liblist gateLib aLib;
  instance adder.f1 liblist rtlLib;
endconfig

config cfg6;
  design rtlLib.top;
  default liblist aLib rtlLib;
  instance top.a2 use work.cfg5:config ;
endconfig