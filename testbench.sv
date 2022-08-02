////////////TEST BENCH CODE FOR TRAFFIC SIGNAL CONTROLLER////////////
//
module traffic_light_tb;
  reg clk,rst;
  wire  main_signal, side_signal;
  wire[1:0] state, next_state;
  wire[6:0] count;
 
   traffic_light dut(clk, rst, main_signal_red, main_signal_green, main_signal_yellow, side_signal_red, side_signal_green, side_signal_yellow);
  
  always#1 clk=~clk;

    initial begin
      $monitor("time=%0t, main_signal_red=%b,  main_signal_green=%b, main_signal_yellow=%b, side_signal_red=%b, side_signal_green=%b, side_signal_yellow=%b", $time, main_signal_red,  main_signal_green,  main_signal_yellow,  side_signal_red,  side_signal_green, side_signal_yellow);
      
      clk=0;
      rst=1;
      @ (posedge clk);
      #1 rst=0;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
    #500 $finish;
  end
endmodule
  
