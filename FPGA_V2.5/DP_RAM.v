/********************* (C) COPYRIGHT 2011 e-Design Co.,Ltd. ********************
                       4096 * 18Bits dual-port SRAM module  
 Version   : FPGA CFG Ver 2.x                                     Author : bure
*******************************************************************************/

module DP_RAM ( Din, Wclk, nRclk, Waddr, Raddr, Dout );

  input  Wclk;                 // Wr clock       -> rising edge
  input  nRclk;                // Rd clock       -> falling edge
  
  input  [11:0]Waddr;          // written address
  input  [11:0]Raddr;          // read address
  input  [17:0]Din;            // input dtat
  
  output [17:0]Dout;           // output data
 
  reg [17:0] Dout;
  reg [17:0] Mem_data [4095:0];

  always @( posedge Wclk ) begin
    Mem_data[Waddr] <= Din;
  end

  always @( negedge nRclk ) begin
    Dout <= Mem_data[Raddr];
  end
  
endmodule