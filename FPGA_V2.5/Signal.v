/********************* (C) COPYRIGHT 2011 e-Design Co.,Ltd. ********************
                     Sync signal select and control module  
 Version   : FPGA CFG Ver 2.x                                     Author : bure
*******************************************************************************/

module Signal( Reset, Mclk, Trigg_Mode, Vthreshold, Tthreshold, Din, 
               Sampled, CtrlReg,
               Start, ClkA, ClkB, 
               A_Edge, A_TL, A_TH, B_Edge, B_TL, B_TH, 
               C_Edge, C_TL, C_TH, D_Edge, D_TL, D_TH, );

  input   Reset;              // Trigger status rst    -> Active high 
  input   Mclk;               // main clock
  input   [ 7:0]Trigg_Mode;   // Trigger Mode 
  input   [ 7:0]Vthreshold;   // Trigger voltage threshold 
  input   [15:0]Tthreshold;   // Trigger time threshold 
  input   [17:0]Din;          // 0~7:CH_A, 8~15:CH_B, 16:CH_C, 17:CH_D
  input   Sampled;
  input   [ 7:0]CtrlReg;      // bit0=nPD, bit1=Mode, 

  output  Start;              // Sync start            -> Active high 
  output  ClkA;               // Clock_A for ADC CH_A
  output  ClkB;               // Clock_B for ADC CH_B
  
  output  [15:0]A_Edge;       // CH_A edge counter
  output  [15:0]A_TL;         // CH_A 
  output  [15:0]A_TH;         // CH_A 
  
  output  [15:0]B_Edge;       // CH_B edge counter
  output  [15:0]B_TL;         // CH_B 
  output  [15:0]B_TH;         // CH_B 
  
  output  [15:0]C_Edge;       // CH_C edge counter
  output  [15:0]C_TL;         // CH_C 
  output  [15:0]C_TH;         // CH_C 
  
  output  [15:0]D_Edge;       // CH_D edge counter
  output  [15:0]D_TL;         // CH_D 
  output  [15:0]D_TH;         // CH_D 
  
  reg     Start;
  wire    [ 8:0]Delta_V1;
  wire    [ 8:0]Delta_V2;
  wire    [ 8:0]Delta_V3;
  wire    [ 8:0]Delta_V4;

  reg     A_Flag;
  reg     A_Status;
  reg     A_Dt_L;
  reg     A_Dt_H;
  reg     A_Ut_L;
  reg     A_Ut_H;
  reg     [11:0]A_Cnt;
  reg     [15:0]A_Edge;
  reg     [15:0]A_TL;
  reg     [15:0]A_TH; 
   
  reg     B_Flag;
  reg     B_Status;
  reg     B_Dt_L;
  reg     B_Dt_H;
  reg     B_Ut_L;
  reg     B_Ut_H;
  reg     [11:0]B_Cnt;
  reg     [15:0]B_Edge;
  reg     [15:0]B_TL;
  reg     [15:0]B_TH; 
  
  reg     C_Flag;
  reg     C_Dt_L;
  reg     C_Dt_H;
  reg     C_Ut_L;
  reg     C_Ut_H;
  reg     [11:0]C_Cnt;
  reg     [15:0]C_Edge;
  reg     [15:0]C_TL;
  reg     [15:0]C_TH; 
  
  reg     D_Flag;
  reg     D_Dt_L;
  reg     D_Dt_H;
  reg     D_Ut_L;
  reg     D_Ut_H;
  reg     [11:0]D_Cnt;
  reg     [15:0]D_Edge;
  reg     [15:0]D_TL;
  reg     [15:0]D_TH; 
  
  assign ClkA = Mclk; 
  assign ClkB = CtrlReg[1] ? ( ~Mclk ) : ( Mclk );
  
  assign  Delta_V1 = Vthreshold + 12;
  assign  Delta_V2 = Vthreshold - 12;
  assign  Delta_V3 = Vthreshold + 1;
  assign  Delta_V4 = Vthreshold - 1;
  
  always @( posedge Mclk or posedge Reset ) begin

    if ( Reset ) begin 
      Start    <= 0;
      A_Dt_L   <= 0;
      A_Dt_H   <= 0;
      A_Ut_L   <= 0;
      A_Ut_H   <= 0;
      A_Edge   <= 0;
      A_TL     <= 0;
      A_TH     <= 0;
      B_Dt_L   <= 0;
      B_Dt_H   <= 0;
      B_Ut_L   <= 0;
      B_Ut_H   <= 0;
      B_Edge   <= 0;
      B_TL     <= 0;
      B_TH     <= 0;
      C_Dt_L   <= 0;
      C_Dt_H   <= 0;
      C_Ut_L   <= 0;
      C_Ut_H   <= 0;
      C_Edge   <= 0;
      C_TL     <= 0;
      C_TH     <= 0;
      D_Dt_L   <= 0;
      D_Dt_H   <= 0;
      D_Ut_L   <= 0;
      D_Ut_H   <= 0;
      D_Edge   <= 0;
      D_TL     <= 0;
      D_TH     <= 0;
    end else begin
      // For CH_A Trigger
      if ( Din[ 7:0] > Delta_V3 )  A_Status <= 1;
      if ( Din[ 7:0] < Delta_V4 )  A_Status <= 0;
      if (( Din[ 7:0] > Delta_V1 )&&( ~A_Flag )) begin
        if ( A_Cnt < Tthreshold )  A_Dt_L <= Sampled; 
        else                       A_Ut_L <= Sampled; 
        A_Flag <= 1;
        A_Cnt  <= 0;
        A_Edge <= A_Edge + 1;
        A_TL   <= A_TL + A_Cnt;
      end else
      if (( Din[ 7:0] < Delta_V2 )&&(  A_Flag )) begin
        if ( A_Cnt < Tthreshold )  A_Dt_H <= Sampled; 
        else                       A_Ut_H <= Sampled; 
        A_Flag <= 0;
        A_Cnt  <= 0;
        A_Edge <= A_Edge + 1;
        A_TH   <= A_TH + A_Cnt;
      end  else  A_Cnt <= A_Cnt + 1; 
      
      // For CH_B Trigger
      if ( Din[15:8] > Delta_V3 )  B_Status <= 1;
      if ( Din[15:8] < Delta_V4 )  B_Status <= 0;
      if (( Din[15:8] > Delta_V1 )&&( ~B_Flag )) begin
        if ( B_Cnt < Tthreshold )  B_Dt_L <= Sampled;
        else                       B_Ut_L <= Sampled;
        B_Flag <= 1;
        B_Cnt  <= 0;
        B_Edge <= B_Edge + 1;
        B_TL   <= B_TL + B_Cnt;
      end else
      if (( Din[15:8] < Delta_V2 )&&(  B_Flag )) begin
        if ( B_Cnt < Tthreshold )  B_Dt_H <= Sampled;
        else                       B_Ut_H <= Sampled;
        B_Flag <= 0;
        B_Cnt  <= 0;
        B_Edge <= B_Edge + 1;
        B_TH   <= B_TH + B_Cnt;
      end  else  B_Cnt <= B_Cnt + 1; 
    
      // For CH_C Trigger
      if ( Din[16] != C_Flag ) begin
        if ( C_Cnt < Tthreshold ) begin
          if ( Din[16] )  C_Dt_L <= Sampled;
          else            C_Dt_H <= Sampled;
        end else begin
          if ( Din[16] )  C_Ut_L <= Sampled;
          else            C_Ut_H <= Sampled;
        end 
        C_Cnt <= 0;
        C_Edge <= C_Edge + 1;
        if ( ~C_Flag )  C_TL <= C_TL + C_Cnt;
        else            C_TH <= C_TH + C_Cnt;
      end else  C_Cnt <= C_Cnt + 1; 
      C_Flag <= Din[16]; 
       
      // For CH_D Trigger
      if ( Din[17] != D_Flag ) begin
        if ( D_Cnt < Tthreshold ) begin
          if ( Din[17] )  D_Dt_L <= Sampled;
          else            D_Dt_H <= Sampled;
        end else begin
          if ( Din[17] )  D_Ut_L <= Sampled;
          else            D_Ut_H <= Sampled;
        end  
        D_Cnt <= 0;
        D_Edge <= D_Edge + 1;
        if ( ~D_Flag )  D_TL <= D_TL + D_Cnt;
        else            D_TH <= D_TH + D_Cnt;
      end else  D_Cnt <= D_Cnt + 1; 
      D_Flag <= Din[17]; 
    
      case( Trigg_Mode )
        // For CH_A Trigger
        8'h00: if (( Din[ 7:0] < Vthreshold )&&(  A_Flag ))   Start <= Sampled; // Negedge
        8'h01: if (( Din[ 7:0] > Vthreshold )&&( ~A_Flag ))   Start <= Sampled; // Posedge
        8'h02: if (( Din[ 7:0] < Vthreshold )&&(  A_Status )) Start <= Sampled; // L Level
        8'h03: if (( Din[ 7:0] > Vthreshold )&&( ~A_Status )) Start <= Sampled; // H Level
        8'h04: Start <= A_Dt_L; // Pusle 0 < ConfigDt
        8'h05: Start <= A_Ut_L; // Pusle 0 > ConfigDt
        8'h06: Start <= A_Dt_H; // Pusle 1 < ConfigDt
        8'h07: Start <= A_Ut_H; // Pusle 1 > ConfigDt
        // For CH_B Trigger
        8'h08: if (( Din[15:8] < Vthreshold )&&(  B_Flag ))   Start <= Sampled; // Negedge
        8'h09: if (( Din[15:8] > Vthreshold )&&( ~B_Flag ))   Start <= Sampled; // Posedge
        8'h0A: if (( Din[15:8] < Vthreshold )&&(  B_Status )) Start <= Sampled; // L Level
        8'h0B: if (( Din[15:8] > Vthreshold )&&( ~B_Status )) Start <= Sampled; // H Level
        8'h0C: Start <= B_Dt_L; // Pusle 0 < ConfigDt
        8'h0D: Start <= B_Ut_L; // Pusle 0 > ConfigDt
        8'h0E: Start <= B_Dt_H; // Pusle 1 < ConfigDt
        8'h0F: Start <= B_Ut_H; // Pusle 1 > ConfigDt
        // For CH_C Trigger
        8'h10: if (( ~Din[16] )&&(  C_Flag ))  Start <= Sampled; // Negedge
        8'h11: if ((  Din[16] )&&( ~C_Flag ))  Start <= Sampled; // Posedge
        8'h12: if (( ~Din[16] )&&(  C_Flag ))  Start <= Sampled; // L Level
        8'h13: if ((  Din[16] )&&( ~C_Flag ))  Start <= Sampled; // H Level
        8'h14: Start <= C_Dt_L; // Pusle 0 < ConfigDt
        8'h15: Start <= C_Ut_L; // Pusle 0 > ConfigDt
        8'h16: Start <= C_Dt_H; // Pusle 1 < ConfigDt
        8'h17: Start <= C_Ut_H; // Pusle 1 > ConfigDt
        // For CH_D Trigger
        8'h18: if (( ~Din[17] )&&(  D_Flag ))  Start <= Sampled; // Negedge
        8'h19: if ((  Din[17] )&&( ~D_Flag ))  Start <= Sampled; // Posedge
        8'h1A: if (( ~Din[17] )&&(  D_Flag ))  Start <= Sampled; // L Level
        8'h1B: if ((  Din[17] )&&( ~D_Flag ))  Start <= Sampled; // H Level
        8'h1C: Start <= D_Dt_L; // Pusle 0 < ConfigDt
        8'h1D: Start <= D_Ut_L; // Pusle 0 > ConfigDt
        8'h1E: Start <= D_Dt_H; // Pusle 1 < ConfigDt
        8'h1F: Start <= D_Ut_H; // Pusle 1 > ConfigDt
        default:                                          Start <= 1;
      endcase
    end
  end
endmodule