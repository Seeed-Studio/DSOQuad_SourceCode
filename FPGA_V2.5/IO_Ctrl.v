/********************* (C) COPYRIGHT 2011 e-Design Co.,Ltd. ********************
                          Input & output control module  
 Version   : FPGA CFG Ver 2.x                                     Author : bure
*******************************************************************************/

module IO_Ctrl( CE, nRD, SCK, SDA, Dout, Start, Full, Empty, H_L, C_D, Ready,  
                A_Edge, A_TL, A_TH, B_Edge, B_TL, B_TH, 
                C_Edge, C_TL, C_TH, D_Edge, D_TL, D_TH, 
                Depth, PerCnt, Delay,
                nPD, Trigg_Mode, Vthreshold, Tthreshold, CtrlReg, DB ); 

  input     CE;                 // Databus selece enable -> Active high
  input     nRD;                // Databus read enable   -> Active low
  input     SCK;                // Serial input clock    -> rising edge 
  input     SDA;                // Serial input data 
  input     [17:0]Dout;         // Output data                     
  input     Start;              // Sync start            -> active high
  input     Ready;              // Sampling start        -> active high
  input     Full;               // FIFO RAM is full      -> active high
  input     Empty;              // FIFO RAM is empty     -> active high
  input     H_L;                // 0/1 = Status/[15:0]Din -> [15:0]DB
  input     C_D;                // 1 = [15:0]Data        -> [15:0]DB
                                
  input     [15:0]A_Edge;       // CH_A edge counter
  input     [15:0]A_TL;         // CH_A 
  input     [15:0]A_TH;         // CH_A 
  
  input     [15:0]B_Edge;       // CH_B edge counter
  input     [15:0]B_TL;         // CH_B 
  input     [15:0]B_TH;         // CH_B 
  
  input     [15:0]C_Edge;       // CH_C edge counter
  input     [15:0]C_TL;         // CH_C 
  input     [15:0]C_TH;         // CH_C 
  
  input     [15:0]D_Edge;       // CH_D edge counter
  input     [15:0]D_TL;         // CH_D 
  input     [15:0]D_TH;         // CH_D 
  
  output    [11:0]Depth;        // Sampling depth
  output    [11:0]PerCnt;       // Per-sampling counter                        
  output    [31:0]Delay;        // Sampling delay

  output    nPD;                // ADC power down        -> Active low
  output    [ 7:0]Trigg_Mode;   // Trigger Mode 
  output    [ 7:0]Vthreshold;   // Trigger voltage threshold 
  output    [15:0]Tthreshold;   // Trigger time threshold 
  output    [ 7:0]CtrlReg;      // bit0=nPD, bit1=Mode, 

  inout     [15:0]DB;           // Data bus to MCU

  reg       [ 7:0]Trigg_Mode;   // Trigger Mode 
  reg       [ 7:0]Vthreshold;   // Trigger voltage threshold 
  reg       [15:0]Tthreshold;   // Trigger time threshold 
  reg       [ 7:0]CtrlReg;
  reg       [ 7:0]RegAddr;
  reg       [ 7:0]DataBuff;
  wire      [15:0]DB_Mux ; 

  reg       [15:0]Data;
  reg       [ 7:0]Select;
  wire      [15:0]CD_Mux ; 

  reg       [11:0]Depth;       
  reg       [11:0]PerCnt;                         
  reg       [31:0]Delay;      
   
  assign nPD = CtrlReg[0];
        
  assign CD_Mux = C_D ? Data[15:0] : { 10'h000, Start, Empty, Full, Ready, Dout[17:16] };  
  assign DB_Mux = H_L ? Dout[15:0] : CD_Mux;  
   
  assign DB = ( CE && !nRD ) ? DB_Mux : 16'hzzzz ;

  always @(posedge SCK) begin
      
    DataBuff <= { DataBuff[6:0], SDA };
    
  end
  
  always @( negedge nRD ) begin
   case( Select )
     4'b0000: Data <= A_Edge;
     4'b0001: Data <= A_TL;
     4'b0010: Data <= A_TH;
     4'b0100: Data <= B_Edge;
     4'b0101: Data <= B_TL;
     4'b0110: Data <= B_TH;
     4'b1000: Data <= C_Edge;
     4'b1001: Data <= C_TL;
     4'b1010: Data <= C_TH;
     4'b1100: Data <= D_Edge;
     4'b1101: Data <= D_TL;
     4'b1110: Data <= D_TH;
     default: Data <= 0;
   endcase 
  end

  always @( posedge SDA ) begin
    if ( !SCK ) begin
      if ( H_L ) begin
        RegAddr <= DataBuff;
      end else begin
        case( RegAddr )
          8'h00:  begin 
            Trigg_Mode <= DataBuff;    
            Depth      <= 4095;
            PerCnt     <= 150;
            Delay      <= 1;
          end
          8'h01:  Vthreshold       <= DataBuff;    
          8'h02:  Tthreshold[ 7:0] <= DataBuff;    
          8'h03:  Tthreshold[15:8] <= DataBuff;    
          8'h04:  CtrlReg   [ 7:0] <= DataBuff;    
          8'h05:  Select    [ 7:0] <= DataBuff;    
          8'h06:  Depth     [ 7:0] <= DataBuff;       
          8'h07:  Depth     [11:8] <= DataBuff;      
          8'h08:  PerCnt    [ 7:0] <= DataBuff;                         
          8'h09:  PerCnt    [11:8] <= DataBuff;                         
          8'h0A:  Delay     [ 7:0] <= DataBuff;      
          8'h0B:  Delay     [15:8] <= DataBuff;      
          8'h0C:  Delay    [23:16] <= DataBuff;      
          8'h0D:  Delay    [31:24] <= DataBuff;      
        endcase 
      end
    end 
  end

endmodule