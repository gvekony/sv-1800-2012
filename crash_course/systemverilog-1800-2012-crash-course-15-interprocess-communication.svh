typedef mailbox #(string) s_mbox;


s_mbox sm = new;
string s;
sm.put( "hello" );
...
sm.get( s ); // s <- "hello"

-> ->> wait

event done, blast; // declare two new events
event done_too = done; // declare done_too as alias to done
task trigger( event ev );
  -> ev;
endtask

fork
  @ done_too; // wait for done through done_too
  #1 trigger( done ); // trigger done through task trigger
join

fork
  -> blast;
  wait ( blast.triggered );
join

wait_order

fork
  T1: forever @ E2;
  T2: forever @ E1;
  T3: begin
    E2 = E1;
    forever -> E2;
  end
join