config bot;
  design lib1.bot;
  default liblist lib1 lib2;
  instance bot.a1 liblist lib3;
endconfig

config top;
  design lib1.top;
  default liblist lib2 lib1;
  instance top.bot use lib1.bot:config;
  instance top.bot.a1 liblist lib4;
  // ERROR - cannot set liblist for top.bot.a1 from this config
endconfig

module top4 ();
  parameter S = 16;
  adder a1 #(.ID("a1"))(...);
  adder a2 #(.ID("a2"))(...);
  adder a3 #(.ID("a3"))(...);
  adder a4 #(.ID("a4"))(...);
endmodule

config cfg2;
  localparam S = 24;
  design rtlLib.top4;
  instance top4.a1 use #(.W(top4.S));
  instance top4.a2 use #(.W(S));
endconfig

config cfg4;
  design rtlLib.top;
  instance top.a1 use #(); // set all parameters in instance a1
  // back to their defaults
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