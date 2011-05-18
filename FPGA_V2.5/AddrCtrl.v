/********************* (C) COPYRIGHT 2011 e-Design Co.,Ltd. ********************
             Pre-sampling FIFO address counter and control module  
 Version   : FPGA CFG Ver 2.x                                     Author : bure
*******************************************************************************/

module AddrCtrl ( ClrW, Wclk, Start, nRclk, RE, H_L, Depth, PerCnt, Delay,
                  Ready, Sampled, Full, Empty, Wptr, Rptr );

  input	  ClrW;         // Wr addr cnt rst      -> Active high 
  input	  Wclk;         // Wr clock             -> rising edge 
  input	  Start;        // Sync start           -> active high 
  input   nRclk;        // Rd clock             -> falling edge
  input   RE;           // Rd cnt enable        -> active high
  input   H_L;          // Data output select   -> 1/0: [17:16]/[15: 0]Dout->[15:0]DB
  input   [11:0]Depth;  // Sampling depth
  input   [11:0]PerCnt; // Per-sampling counter                        
  input   [31:0]Delay;  // Sampling delay
  
  output  Sampled;      // Pre-sampling finish  -> active high
  output  Ready;        // Sampling start       -> active high
  output  Full;         // FIFO RAM is full     -> active high
  output  Empty;        // FIFO RAM is empty    -> active high
  output  [11:0]Wptr;   // written address pointer
  output  [11:0]Rptr;   // Read address pointer

  reg     Full;
  reg     Ready; 
  reg     Loaded;       // marked the Start address loaded ok   
  reg     [11:0]Wptr;
  reg     [11:0]Rptr;
  reg     [12:0]Pcnt;
  reg     [11:0]Bptr;
  reg     [31:0]DelayCnt;  

  reg     Sampled;

  always@ ( posedge Wclk or posedge ClrW ) begin
    if ( ClrW ) begin               
      Full <= 0;
      Pcnt <= 0;
      Sampled  <= 0;
      DelayCnt <= 0;  
      Ready    <= 0;              
    end else begin
      if ( Start )                      DelayCnt <= DelayCnt + 1;
      if ( Pcnt >= PerCnt )             Sampled  <= 1;
      if ( !Full )                      Wptr     <= Wptr + 1;
      if ( Pcnt >= Depth )              Full     <= Ready; 
      else                              Pcnt     <= Pcnt +1; // Sampling counter
      if(( !Start )&&( Pcnt >= PerCnt)) Pcnt     <= PerCnt;
      if ( DelayCnt == Delay ) begin  
        Ready <= 1;              
        Bptr  <= Wptr;                                       // Posedge of Start
        Pcnt  <= PerCnt;
      end  
    end 
  end

  assign Empty = ( Rptr == Wptr ) ? 1'b1 : 1'b0 ;
  
  always @( posedge nRclk or posedge ClrW ) begin
    if ( ClrW ) begin
      Loaded <= 0; 
      Rptr   <= 0;   
    end else begin 
      if ( H_L && RE )  Rptr <= Rptr + 1;
      if (( H_L )&& RE &&( ~Loaded )&& Start ) begin 
        Loaded <= 1;
        Rptr   <= Bptr - 151; 
      end  
    end   
  end

endmodule