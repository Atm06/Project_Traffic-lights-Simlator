////////////DESIGN BENCH CODE FOR TRAFFIC SIGNAL CONTROLLER////////
///////TIME DELAY : ***20ns:green 30ns:red 5nsyellow*** ///////////

module traffic_light( clk, rst, m_red, m_green, m_yellow,s_red, s_green, s_yellow);
  input clk,rst;
  output reg m_red, m_green, m_yellow,s_red, s_green, s_yellow; 						//main road light and side road light signals//
  
  reg [1:0] state, next_state;
  
  parameter [2:0] main_G = 2'b00;
  parameter [2:0] main_Y = 2'b01;
  parameter [2:0] side_G = 2'b10;
  parameter [2:0] side_Y = 2'b11;
  
  reg [6:0]count;
  
 ////counter update////
  always@(posedge clk)begin
    if(rst) count<=0;
      else begin 
        if (count>=55) count<=0;
        else count<=count+1;
    end
  end

  ////present state initialization/////
    always@(posedge clk)begin
      if(rst) state <= main_G;
      else state <= next_state;
    end
  
   ////next state////
  always@(state,count)begin
      case(state)
        main_G: next_state = main_Y;
        
        main_Y: if(count>=0 && count<20)
                next_state = main_Y;
               else next_state = side_G;
        
        side_G:if(count>=20 && count<50)
            next_state = side_G;
            else next_state = side_Y;
        
        side_Y: if(count>=50 && count<55)
                next_state <= side_Y;
                else next_state = main_Y;
        
        default:next_state = main_G;
        
      endcase
    end
  
  ////output////
   always@(state)begin
    case(state)
    main_G:begin 
          m_red    =  0;
          m_green  =  0;
          m_yellow =  0;
      	  s_red    =  1;
          s_green  =  0;
      	  s_yellow =  0;
          end
    main_Y:begin 
          m_red    =  0;
          m_green  =  0;
          m_yellow =  1;
      	  s_red    =  1;
          s_green  =  0;
      	  s_yellow =  0;
          end
    side_G:begin 
           m_red   =  1;
          m_green  =  0;
          m_yellow =  0;
      	  s_red    =  0;
          s_green  =  1;
      	  s_yellow =  0;
          end
    side_Y:begin 
           m_red   =  1;
          m_green  =  0;
          m_yellow =  1;
      	  s_red    =  0;
          s_green  =  0;
      	  s_yellow =  1;
          end
    default:begin 
           m_red   =  0;
          m_green  =  0;
          m_yellow =  1;
      	  s_red    =  1;
          s_green  =  0;
      	  s_yellow =  0;
          end
    endcase
    end   
    endmodule
