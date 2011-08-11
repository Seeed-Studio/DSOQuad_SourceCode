/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : BIOS.c  
 Version   : DS203_SYS Ver 1.5x                                  Author : bure
*******************************************************************************/
#include "Function.h"
#include "Config.h"
#include "Ident.h"
#include "BIOS.h"
#include "LCD.h"
#include "ASM.h"

uc8  HDW_Ver[20] = "Hardware Ver 2.60 ";
uc8  DFU_Ver[5]  = "3.10";
u8   VerStr[8];
u8   Clash = 0;

const G_attr G_ATTR[1] =//LCD_X;LCD_Y;Yp_Max;Xp_Max;Tg_Num;Yv_Max;Xt_Max
                       {  400,   240,   8-1,    22-1,   15,     200,    4096,  
                        //Co_Max;Ya_Num;Yd_Num;INSERT;KpA1;KpA2;KpB1;KpB2
                           1,     1,     1,     17,    0,   1024,  0, 1024};

const Y_attr Y_ATTR[9] ={//  STR     KA1    KA2    KB1    KB2     SCALE 
                         { "50mV",    0,   1024,    0,   1024,    2000},
                         { "0.1V",    0,   1024,    0,   1024,    4000},
                         { "0.2V",   -2,   1024,   -6,   1024,    8000},
                         { "0.5V",   -1,   1024,   -6,   1024,   20000},
                         { " 1V ",    0,   1024,   -6,   1024,   40000},
                         { " 2V ",   -2,   1024,   -6,   1024,   80000},
                         { " 5V ",   -1,   1024,   -6,   1024,  200000},
                         { "!10V!",   0,   1024,   -6,   1024,  400000}};
  
const X_attr X_ATTR[27] ={
//   STR      PSC      ARR      CCR    KP     SCALE
  {"! 1S !", 1000-1,  2400-1,  1200,  1024, 33333333},
  {"500mS",  1000-1,  1200-1,   600,  1024, 16666667}, 
  {"200mS",  1000-1,   480-1,   240,  1024,  6666667}, 
  {"100mS",  1000-1,   240-1,   120,  1024,  3333333},
  {"!50mS!", 1000-1,   120-1,    60,  1024,  1666667}, 
  {"!20mS!",  100-1,   480-1,   240,  1024,   666667}, 
  {"!10mS!",  100-1,   240-1,   120,  1024,   333333}, 
  {" 5mS ",   100-1,   120-1,    60,  1024,   166667},
  {" 2mS ",    10-1,   480-1,   240,  1024,    66667}, 
  {" 1mS ",    10-1,   240-1,   120,  1024,    33333},   
  {"500uS",    10-1,   120-1,    60,  1024,    16667}, 
  {"200uS",     1-1,   480-1,   240,  1024,     6667},
  {"100uS",     1-1,   240-1,   120,  1024,     3333}, 
  {"!50uS!",    1-1,   120-1,    60,  1024,     1667}, 
  {"!20uS!",    1-1,    48-1,    24,  1024,      667},      
  {"!10uS!",    1-1,    24-1,    12,  1024,      333},      
  {" 5uS ",     1-1,    12-1,     6,  1024,      167},       
  {" 2uS ",     1-1,     5-1,     3,   983,       67}, //1024*4.8/5 =983
  {" 1uS ",     1-1,     3-1,     2,   819,       33}, //1024*2.4/3 =819 
  {"0.5uS",     1-1,     2-1,     1,   614,       17}, //1024*1.2/2 =614
  {"0.2uS",     1-1,     1-1,     1,   492,        7}, //1024*0.48  =492
  {"0.1uS",     1-1,     1-1,     1,   246,        3}, //1024*0.24  =246 
  {" 2uS+",     1-1,    10-1,     3,   983,       67}, //1024*9.6/10=983
  {" 1uS+",     1-1,     5-1,     2,   983,       33}, //1024*4.8/5 =983
  {".5uS+",     1-1,     3-1,     1,   819,       17}, //1024*2.4/3 =819
  {".2uS+",     1-1,     2-1,     1,   983,        7}, //1024*0.96  =983
  {".1uS+",     1-1,     1-1,     1,   491,        3}};//1024*0.48  =492

const T_attr T_ATTR[32] ={
//  STR   CHx  CMD    STR   CHx  CMD    STR   CHx  CMD    STR   CHx  CMD
  {"<Vt",  0, 0x00},{"<Vt",  1, 0x02},{"<Vt",  2, 0x04},{"<Vt",  3, 0x06},
  {">Vt",  0, 0x01},{">Vt",  1, 0x03},{">Vt",  2, 0x05},{">Vt",  3, 0x07}, 
  {":!\\!",0, 0x08},{":!\\!",1, 0x0A},{":!\\!",2, 0x0C},{":!\\!",3, 0x0E}, 
  {":!^!", 0, 0x09},{":!^!", 1, 0x0B},{":!^!", 2, 0x0D},{":!^!", 3, 0x0F},
  {"<TL",  0, 0x10},{"<TL",  1, 0x12},{"<TL",  2, 0x14},{"<TL",  3, 0x16},
  {">TL",  0, 0x11},{">TL",  1, 0x13},{">TL",  2, 0x15},{">TL",  3, 0x17}, 
  {"<TH",  0, 0x18},{"<TH",  1, 0x1A},{"<TH",  2, 0x1C},{"<TH",  3, 0x1E},   
  {">TH",  0, 0x19},{">TH",  1, 0x1B},{">TH",  2, 0x1D},{">TH",  3, 0x1F}};  

/*******************************************************************************
 Set:  硬件控制设备设置
*******************************************************************************/
u32 Set(u8 Object, u32 Value)
{
  switch (Object){  
  case CH_A_OFFSET:  if(Value < 65536){
                       TIM5_ARR = 470; TIM5_CCR1 = 450 - Value; // Value = 0~200
                     } else {
                       TIM5_ARR = Value >>16; TIM5_CCR1 = Value & 0xFFFF;
                     } break;
  case CH_B_OFFSET:  if(Value < 65536){
                       TIM5_ARR = 470; TIM5_CCR2 = 450 - Value; // Value = 0~200
                     } else {
                       TIM5_ARR = Value >>16; TIM5_CCR2 = Value & 0xFFFF;
                     } break;
  case BACKLIGHT:    TIM8_CCR1 = Value;                         // Value = 0~100
                     break;
  case BEEP_VOLUME:  TIM8_CCR2 = 100 - Value/2;                 // Value = 0~50
                     break;
  case BETTERY_DT:   ADC3_CR2 |= (Value & 1)<<22;  // Value = 1/0   ADC3_CR2 |=0x00400000;
                     break;
  case ADC_MODE:     if(Value == SEPARATE) FIFO_MODE_LOW();  
                     else                  FIFO_MODE_HIGH();  break;
  case FIFO_CLR:     if(Value == W_PTR){FIFO_CLRW_HIGH();  FIFO_CLRW_LOW();}
                     if(Value == R_PTR){FIFO_CLRR_HIGH();  FIFO_CLRR_LOW();} break;
  case T_BASE_PSC:   TIM1_PSC  = Value;
                     break;
  case T_BASE_ARR:   if(Value==0)      {TIM1_CCER=0; RCC_CFGR=0x041D8402;} // MCO as SYSCLK  
                     else if(Value==1) {TIM1_CCER=0; RCC_CFGR=0x071D8402;} // MCO as SYSCLK/2 
                     else  {RCC_CFGR=0x001D8402;  TIM1_CCER=0x0003;        // MCO as OC1 
                            TIM1_ARR=Value;  TIM1_CCR1=(Value+1)/2;}
                     break;
  case CH_A_COUPLE:  if(Value == AC ) AC_1();  else DC_1();
                     break;
  case CH_B_COUPLE:  if(Value == AC ) AC_2();  else DC_2();
                     break;
  case CH_A_RANGE:
    switch (Value){  
    case _50MV:  Ax0_ON();  Ax1_ON();  Ax2_HIGH(); Ax5_HIGH();
                 break;
    case _100MV:  Ax0_ON();  Ax1_ON();  Ax2_LOW();  Ax5_HIGH();    
                 break;
    case _200MV: Ax0_ON();  Ax1_ON();  Ax2_HIGH(); Ax5_LOW();
                 break;
    case _500MV: Ax0_ON();  Ax1_ON();  Ax2_LOW();  Ax5_LOW(); 
                 break;
    case _1V: Ax0_OFF(); Ax1_OFF(); Ax2_HIGH(); Ax5_HIGH(); 
                 break;
    case _2V:    Ax0_OFF(); Ax1_OFF(); Ax2_LOW();  Ax5_HIGH();
                 break;
    case _5V:    Ax0_OFF(); Ax1_OFF(); Ax2_HIGH(); Ax5_LOW(); 
                 break;
    case _10V:    Ax0_OFF(); Ax1_OFF(); Ax2_LOW();  Ax5_LOW();  
                 break;
    case CH_B:   Ax0_ON(); Ax1_OFF();  Ax2_LOW();  Ax5_LOW();
                 break;
    }  break;
    
  case CH_B_RANGE:
    switch (Value){  
    case _50MV:  Bx0_ON();  Bx1_ON();  Bx2_HIGH(); Bx5_HIGH();
                 break;
    case _100MV:  Bx0_ON();  Bx1_ON();  Bx2_LOW();  Bx5_HIGH();
                 break;
    case _200MV: Bx0_ON();  Bx1_ON();  Bx2_HIGH();  Bx5_LOW();
                 break;
    case _500MV: Bx0_ON();  Bx1_ON();  Bx2_LOW();  Bx5_LOW();
                 break;
    case _1V: Bx0_OFF(); Bx1_OFF(); Bx2_HIGH(); Bx5_HIGH();
                 break;
    case _2V:    Bx0_OFF(); Bx1_OFF(); Bx2_LOW();  Bx5_HIGH();
                 break;
    case _5V:    Bx0_OFF(); Bx1_OFF(); Bx2_HIGH();  Bx5_LOW();
                 break;
    case _10V:    Bx0_OFF(); Bx1_OFF(); Bx2_LOW(); Bx5_LOW();
                 break;
    case CH_A:   Bx0_ON(); Bx1_OFF();  Bx2_LOW();  Bx5_LOW();
                 break;
    }  break;
    
  case ANALOG_ARR:  GPIOB_CRL = 0x34BBB438;  TIM4_CR1 = 0x0080;  // SQR_OUT = Disnable  
                    GPIOA_CRL   = 0x111011BB;  DAC_CR = 0x0001;  // DAC = Ensable 
                    TIM7_ARR = Value;  TIM7_CR1 = 0x0085;  break;// DAC_CLK = Enable
  case ANALOG_PTR:  DMA2_CMAR4  = Value;
                    break;
  case ANALOG_CNT:  DMA2_CNDTR4 = Value;       // Fout = (Cnt*(ARR+1)/72)KHz
                    break;
  case DIGTAL_PSC:  TIM4_PSC = Value; GPIOA_CRL  |= 0x40000;  // DAC_OUT = Disnable
                    TIM7_CR1 = 0x0084;  DAC_CR = 0;  break;   // DAC = Disnable
  case DIGTAL_ARR:  TIM4_ARR    = Value;
                    break;
  case DIGTAL_CCR:  GPIOB_CRL &= 0xF0FFFFFF;  GPIOB_CRL |= 0x0B000000; // PORT_SQR = Enable
                    TIM4_CCR1 = Value;  TIM4_CR1 = 0x0081; break;      // SQR_OUT = Enable 
  case KEY_IF_RST:  TIM3_SR = 0;               //Clear TIM3 interrupt flag
                    break;
  case STANDBY:     if(Value == 1) { STB_EN();}  else { STB_DN();}   
                    break;
                    
  case FPGA_RST:    GPIOB_CRH &= 0xF0FFFFFF;  GPIOB_CRH |= 0x01000000;        // 设PB14为输出状态
                    SPI_CRST_LOW(); Delayms(1);   // SPI_CRST_LOW 1mS
                    SPI_SS_HIGH(); Delayms(1);     // SPI_SS_HIGH  1mS
                    SPI_SS_LOW(); Delayms(1);      // SPI_SS_LOW   1mS
                    SPI_CRST_HIGH(); Delayms(2);   // SPI_CRST_HIGH 2mS
                    GPIOB_CRH &= 0xF0FFFFFF;  GPIOB_CRH |= 0x08000000; break; // 设PB14为输入状态 

  case TRIGG_MODE:  Set_Param(Object, Value);             
                    break; 
  case V_THRESHOLD: Set_Param(Object, Value);          
                    break;    
  case T_THRESHOLD: Set_Param(Object, Value & 0xFF);            
                    Set_Param(Object +1, Value >> 8);  break;
  case ADC_CTRL:    Set_Param(Object, Value);               
                    break;
  case A_POSITION:  Set_Param(Object, Value);              
                    break; 
  case B_POSITION:  Set_Param(Object, Value);              
                    break; 
  case REG_ADDR:    Set_Param(Object, Value);          
                    break;    
  }
  return 0;
}
/*******************************************************************************
 SendByte:  Send a byte to FPGA
*******************************************************************************/
void SendByte(u8 Data) 
{ 
  u8 i;
  
  FIFO_SCK_HIGH();
  for(i=0; i<8; ++i){
    if((Data<<i) & 0x80) FIFO_SDA_HIGH();
    else                 FIFO_SDA_LOW();
    FIFO_SCK_LOW();
    FIFO_SCK_HIGH();
  }  
  FIFO_SDA_LOW();
  FIFO_SCK_LOW();
  FIFO_SDA_HIGH(); // Send data to buffer
}
/*******************************************************************************
 Set_Param: Trigger control Parameter Set 
*******************************************************************************/
void Set_Param(u8 RegAddr, u8 Parameter) 
{
  RegAddr &= 0x1F;
  FIFO_H_L_HIGH();
  SendByte(RegAddr);
  FIFO_H_L_LOW();
  SendByte(Parameter);
}
/*******************************************************************************
 Get: Get hardware attribute & status
*******************************************************************************/
u32 Get(u8 Object, u32 Value)
{
  u16 Data;
  u8* Ver;
  
  switch (Object){  
    
  case FIFO_DIGIT:  FIFO_H_L_LOW();  return (*(vu16 *)0x64000000); // 16bits FIFO Digital data

  case FIFO_START:  FIFO_H_L_LOW();  return ((*(vu16 *)0x64000000)& 0x04)>> 2;    // Start = Bit2

  case FIFO_EMPTY:  FIFO_H_L_LOW();  return ((*(vu16 *)0x64000000)& 0x10)>> 4;    // Empty = Bit4

  case FIFO_FULL:   FIFO_H_L_LOW();  return ((*(vu16 *)0x64000000)& 0x08)>> 3;    // Full = Bit3

  case KEY_STATUS:  Data  =(GPIOA_IDR & 0x4000);    Data |=(GPIOC_IDR & 0x0400)<<3; // K1, K2
                    Data |=(GPIOC_IDR & 0x0200)>>1; Data |=(GPIOC_IDR & 0x0100)<<1; // K3, K4
                    Data |=(GPIOA_IDR & 0x2000)>>3; Data |=(GPIOC_IDR & 0x1000)>>1; // K5, K6
                    Data |=(GPIOC_IDR & 0x0800)<<1; Data |=(GPIOA_IDR & 0x8000);    // K7, K8
                    Data |=(GPIOD_IDR & 0x0008);    Data |=(GPIOD_IDR & 0x0040);    // K9, K10
                    return Data;                              // Current keys status

  case USB_POWER:   return USB_PWR_ON;               // USB power on = 1   
    
  case V_BATTERY:   return (ADC3_DR*1400)/1024;      // Battery voltage (mV)  
  
  case VERTICAL:    return (u32)Y_ATTR;              // 垂直通道属性指针
    
  case HORIZONTAL:  return (u32)X_ATTR;              // 水平通道属性指针
    
  case GLOBAL:      return (u32)G_ATTR;              // 整体属性指针
  
    
  case TRIGGER:     return (u32)T_ATTR;              // 触发通道属性指针
    
  case FPGA_OK:     return FPGA_CFG_OK;              // FPGA config ok = 1

  case CHARGE:      return CHRG_ST;                  // Battery charge = 1

  case DFUVER:      Ver = __Chk_DFU();               // DFU固件版本信息
                    if(Ver == 0)  Ver = (u8*)DFU_Ver;
                    if(Value == 0) return (u32)Ver;
                    else return (Ver[0]-'0')*100 +(Ver[2]-'0')*10 +(Ver[3]-'0'); 
  case HDWVER:      Ver = __Chk_HDW();               // 设备硬件版本信息
                    if(Ver == 0)  Ver = (u8*)(HDW_Ver + 13);
                    if(Value == 0) return (u32)Ver;
                    else return (Ver[0]-'0')*100 +(Ver[2]-'0')*10 +(Ver[3]-'0'); 
  case SYSVER:      Ver = (u8*)SYS_Ver;              // SYS程序模块版本信息
                    if(Value == 0) return (u32)Ver;
                    else return (Ver[0]-'0')*100 +(Ver[2]-'0')*10 +(Ver[3]-'0'); 
  case FPGAVER:     FIFO_H_L_LOW();  
                    Data = (*(vu16 *)0x64000000)>> 6; // FPGA配置程序版本信息
                    u16ToDec5(VerStr, Data);
                    VerStr[0]=VerStr[2]; VerStr[1]='.'; VerStr[2]=VerStr[3]; 
                    VerStr[3]=VerStr[4]; VerStr[4]= 0; 
                    if(Value == 0) return (u32)(VerStr);
                    else return Data; 
  } 
  return 0;                          // No used
}
/********************************* END OF FILE ********************************/
