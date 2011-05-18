/******************** (C) COPYRIGHT 2011 e-Design Co.,Ltd. *********************

                          DS203 FIFO main control module  

 Version   : FPGA CFG Ver 2.x                                     Author : bure

********************************************************************************
版本修改说明：
 FPGA_V2.3: 1. 修改了同步触发模块的逻辑结构 
            2. 优化了FIFO读写地址控制的逻辑结构
 FPGA_V2.4: 1. 增加了4个通道独立的频率和脉宽计量
            2. 修改了脉宽触发的1个BUG
 FPGA_V2.5: 1. 增加了采样深度可设置的功能
            2. 增加了预采样深度可设置的功能
            3. 增加了延迟触发采样可设置的功能
*******************************************************************************/

module FIFO( ClrW, MCI, nRD, CE, H_L, C_D, SCK, SDA, Din, 
             nPD, CKA, CKB, DB);

  input	  ClrW;               // FIFO status reset       -> Active high 
  input	  MCI;                // Main clock input        -> rising edge 
  input	  nRD;                // FIFO read clock         -> falling edge
  input	  CE;                 // FIFO bus enable         -> Active high
  input	  H_L;                // 1 = [17:16]Dout->[ 1:0]DB, 0 = [15:0]Dout->[15:0]DB
  input	  C_D;                // 1 = [15:0]Data->[15:0]DB
  input	  SCK;                // Serial input clock    -> rising edge 
  input	  SDA;                // Serial input data 
  input	  [17:0]Din;          // FIFO write data

  output  nPD;                // ADC Power down Output
  output  CKA;                // Clock_A
  output  CKB;                // Clock_B

  inout   [15:0]DB;           // FIFO output data bus
  
  wire	  [11:0]R_Addr_Bus;   // current read address
  wire	  [11:0]W_Addr_Bus;   // current Writen address 
  wire	  [17:0]Dout_Bus;     // Internal data output Bus 
  wire	  [17:0]Din_Bus;      // Internal data input Bus 
  wire	  [ 7:0]Tm_Link;  
  wire	  [ 7:0]Vt_Link;      
  wire	  [15:0]Tt_Link;     
  wire	  [ 7:0]Ctrl_Link;
  wire	  Start_Link;
  wire	  Full_Link;
  wire	  Empty_Link;
  wire	  Sampled_Link;
  wire	  Ready_Link;
  wire	  [15:0]A_Edge_Link;
  wire	  [15:0]A_TL_Link;
  wire	  [15:0]A_TH_Link;   
  wire	  [15:0]B_Edge_Link;
  wire	  [15:0]B_TL_Link;
  wire	  [15:0]B_TH_Link;  
  wire	  [15:0]C_Edge_Link;
  wire	  [15:0]C_TL_Link;
  wire	  [15:0]C_TH_Link; 
  wire	  [15:0]D_Edge_Link;
  wire	  [15:0]D_TL_Link;
  wire	  [15:0]D_TH_Link; 
  wire	  [11:0]Depth_Link; 
  wire	  [11:0]PerCnt_Link; 
  wire	  [31:0]Delay_Link;

  assign Din_Bus = { Din[17:16], ~Din[15:8], ~Din[7:0] };

  AddrCtrl	U1(
    .ClrW( ClrW ),
    .Wclk( MCI ),
    .Start( Start_Link ),
    .nRclk( nRD ),
    .RE( CE ),
    .H_L( H_L ),
    .Depth( Depth_Link ), 
    .PerCnt( PerCnt_Link ), 
    .Delay( Delay_Link ),
    .Ready( Ready_Link ), 
    .Sampled(Sampled_Link),
    .Full( Full_Link ),
    .Empty( Empty_Link ),
    .Rptr( R_Addr_Bus ),
    .Wptr( W_Addr_Bus )
  );
  
  DP_RAM	U2(
    .Wclk( MCI ),
    .nRclk( nRD ),
    .Din( Din_Bus ),
    .Raddr( R_Addr_Bus ),
    .Waddr( W_Addr_Bus ),
    .Dout( Dout_Bus )
  );
                   
  Signal U3(
    .Reset( ClrW ),
    .Mclk( MCI ),         
    .Trigg_Mode( Tm_Link ), 
    .Vthreshold( Vt_Link ), 
    .Tthreshold( Tt_Link ), 
    .Din( Din_Bus ),
    .Sampled(Sampled_Link),
    .CtrlReg( Ctrl_Link ),
    .Start( Start_Link ),
    .ClkA( CKA ),
    .ClkB( CKB ),
    .A_Edge( A_Edge_Link ),
    .A_TL( A_TL_Link ),
    .A_TH( A_TH_Link ),   
    .B_Edge( B_Edge_Link ),
    .B_TL( B_TL_Link ),
    .B_TH( B_TH_Link ),   
    .C_Edge( C_Edge_Link ),
    .C_TL( C_TL_Link ),
    .C_TH( C_TH_Link ),   
    .D_Edge( D_Edge_Link ),
    .D_TL( D_TL_Link ),
    .D_TH( D_TH_Link )   
  );

  IO_Ctrl U4( 
    .CE( CE ), 
    .nRD( nRD ), 
    .SCK( SCK ), 
    .SDA( SDA ), 
    .Dout( Dout_Bus ),  
    .Start( Start_Link ),
    .Full( Full_Link ),
    .Empty( Empty_Link ),
    .H_L( H_L ), 
    .C_D( C_D ), 
    .Ready( Ready_Link ), 
    .A_Edge( A_Edge_Link ),
    .A_TL( A_TL_Link ),
    .A_TH( A_TH_Link ),   
    .B_Edge( B_Edge_Link ),
    .B_TL( B_TL_Link ),
    .B_TH( B_TH_Link ),   
    .C_Edge( C_Edge_Link ),
    .C_TL( C_TL_Link ),
    .C_TH( C_TH_Link ),   
    .D_Edge( D_Edge_Link ),
    .D_TL( D_TL_Link ),
    .D_TH( D_TH_Link ),   
    .Depth( Depth_Link ), 
    .PerCnt( PerCnt_Link ), 
    .Delay( Delay_Link ),
    .nPD( nPD ),
    .Trigg_Mode( Tm_Link ), 
    .Vthreshold( Vt_Link ), 
    .Tthreshold( Tt_Link ), 
    .CtrlReg( Ctrl_Link ),
    .DB( DB ) 
  );
  
endmodule
 