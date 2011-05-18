/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : Config.c       
 Version   : DS203_SYS Ver 1.3x                                  Author : bure
*******************************************************************************/
#include "USB_desc.h"
#include "Config.h"
#include "BIOS.h"

ErrorStatus HSEStartUpStatus;

/*******************************************************************************
  Set_System :   Configures Main system clocks & power
*******************************************************************************/
void Set_System(void)
{
  RCC_DeInit();               
  RCC_HSEConfig(RCC_HSE_ON);  
  HSEStartUpStatus = RCC_WaitForHSEStartUp();
  if(HSEStartUpStatus == SUCCESS)
  {
    FLASH_PrefetchBufferCmd(FLASH_PrefetchBuffer_Enable);
    FLASH_SetLatency(FLASH_Latency_2);    //Flash 2 wait state  
    RCC_CFGR = 0x001D8402;/*AHB peripheral clock enable               
                 |||||||+--Bits1:0 =10 PLL used as system clock
                 ||||||+---Bits7:4 =0000 AHB clock=SYSCLK 
                 |||||+----Bits10:8  =100 PCLK1=HCLK divided by 2
                 ||||++----Bits13:11 =000 PCLK2=HCLK 
                 ||||+-----Bits15:14 =10 ADC prescaler PCLK2 divided by 6
                 |||+------Bit16 =1 HSE oscillator clock selected as PLL input clock
                 |||+------Bit17 =0 HSE clock not divided
                 ||++------Bits21:18 =0111 PLL input clock x 9
                 ||+-------Bit22=0 USB prescaler is PLL clock divided by 1.5
                 |+--------Bits26:24 =000 MCO as No clock
                 |+--------Bits26:24 =100 MCO as SYSCLK
                 |+--------Bits26:24 =111 MCO as SYSCLK/2
                 ++--------Bits31:27 Reserved*/
    RCC_PLLCmd(ENABLE);
    while(RCC_GetFlagStatus(RCC_FLAG_PLLRDY) == RESET){}
    RCC_SYSCLKConfig(RCC_SYSCLKSource_PLLCLK);
    while(RCC_GetSYSCLKSource()!=0x08){}
  }
  RCC_AHBENR = 0x00000117;/*AHB peripheral clock enable 
                 |||||||+--Bit0 =1 DMA1 clock enabled
                 |||||||+--Bit1 =1 DMA2 clock enabled
                 |||||||+--Bit2 =1 SRAM interface clock enabled during Sleep mode
                 ||||||+---Bit4 =1 FLITF clock enabled during Sleep mode
                 ||||||+---Bit6 =0 CRC clock disabled
                 |||||+----Bit8 =1 FSMC clock enabled
                 |||||+----Bit10=0 SDIO clock disabled
                 ++++++----Bits31:11=0 Reserved*/
  
  RCC_APB2ENR = 0x0000AE7D;/* APB2 peripheral clock enable
                  |||||||+--Bit0 =1 1:Alternate Function I/O clock enabled
                  |||||||+--Bit2 =1 I/O port A clock enabled
                  |||||||+--Bit3 =1 I/O port B clock enabled
                  ||||||+---Bit4 =1 I/O port C clock enabled
                  ||||||+---Bit5 =1 I/O port D clock enabled
                  ||||||+---Bit6 =1 I/O port E clock enabled
                  ||||||+---Bit7 =0 I/O port F clock disabled
                  |||||+----Bit8 =0 I/O port G clock disabled
                  |||||+----Bit9 =1 ADC 1 interface clock disabled
                  |||||+----Bit10=1 ADC 2 interface clock disabled
                  |||||+----Bit11=1 TIM1 timer clock enabled
                  ||||+-----Bit12=0 SPI 1 clock disabled
                  ||||+-----Bit13=1 TIM8 timer clock enabled
                  ||||+-----Bit14=0 USART1 clock disabled
                  ||||+-----Bit15=1 ADC 3 interface clock enabled
                  ++++------Bit31:17=0 Reserved*/

  RCC_USBCLKConfig(RCC_USBCLKSource_PLLCLK_1Div5);     //USBCLK = 48MHz
  RCC_APB1ENR = 0x2080802F;/* APB1 peripheral clock enable
                  |||||||+--Bit0 =1 Timer 2 clock enabled
                  |||||||+--Bit1 =1 Timer 3 clock enabled
                  |||||||+--Bit2 =1 Timer 4 clock enabled
                  |||||||+--Bit3 =1 Timer 5 clock enabled
                  ||||||+---Bit4 =0 Timer 6 clock disabled
                  ||||||+---Bit5 =1 Timer 7 clock ensabled
                  |||||+----Bit11=0 Window watchdog clock disabled
                  ||||+-----Bit14=0 SPI 2 clock disabled
                  ||||+-----Bit15=1 SPI 3 clock enabled
                  |||+------Bit17=0 USART 2 clock disabled
                  |||+------Bit18=0 USART 3 clock disabled
                  |||+------Bit19=0 USART 4 clock disabled
                  ||+-------Bit20=0 USART 5 clock disabled
                  ||+-------Bit21=0 I2C 1 clock disabled
                  ||+-------Bit22=0 I2C 2 clock enabled
                  ||+-------Bit23=1 USB clock enabled
                  |+--------Bit25=0 CAN clock disabled
                  |+--------Bit27=0 Backup interface clock disabled
                  +---------Bit28=0 Power interface clock disabled
                  +---------Bit29=1 DAC interface clock enable*/
  
}
/*******************************************************************************
* NVIC_Configuration:  interrupt seting  initializtion
*******************************************************************************/
void NVIC_Config(void)
{
  NVIC_InitTypeDef NVIC_InitStructure;
  
  NVIC_SetVectorTable(NVIC_VectTab_FLASH, 0x4000);

  NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);

  NVIC_InitStructure.NVIC_IRQChannel = USB_LP_CAN_RX0_IRQChannel;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  NVIC_Init(&NVIC_InitStructure);

  NVIC_InitStructure.NVIC_IRQChannel = USB_HP_CAN_TX_IRQChannel;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
  NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  NVIC_Init(&NVIC_InitStructure);
  
  // enabling TIM3 interrupt 
  NVIC_InitStructure.NVIC_IRQChannel=TIM3_IRQChannel;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
  NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  NVIC_Init(&NVIC_InitStructure);
  
}
/*******************************************************************************
* GPIO_Config: GPIO port initializtion
*******************************************************************************/
void GPIO_Config2(void)
{
  GPIOB_CRH = 0x88883338;  /* GPIOB Bit8-15 状态设置 //Setting of GPIOB Bit 8~15   0x83833333
                |||||||+----- Nib8  Key_n 上拉输入//Pull-up	
                ||||||+------ Nib9  Bx0.1 高速输出//Output
                |||||+------- Nib10 C_nSS 高速输出////high-speed outputt  
                ||||+-------- Nib11 C_SCK 高速输出////high-speed output
                |||+--------- Nib12 C_SI  高速输出  ////high-speed output
                ||+---------- Nib13 C_SO  上拉输入  //Pull-up	// 配置成功后改为“体验版”DTr   输入
                |+----------- Nib14 C_RST 高速输出 ////high-speed output // 配置成功后改为“体验版”CTr   输入
                +------------ Nib15 Cdone 上拉输入*/ //Pull-up	
  SPI_SS_HIGH();                                    // PWRon = 1
}

void GPIO_Config(void)
{
  GPIOA_CRL = 0x118088BB;  /* GPIOA Bit0-7 状态设置//Setting of GPIOA bit 0~7
                |||||||+----- Nib0  V1    复用输出 T51 PWM//Alternative function output
                ||||||+------ Nib1  V2    复用输出 T52 PWM//Alternative function output
                |||||+------- Nib2  NC    上拉输入 //Pull-up 
                ||||+-------- Nib3  NC    上拉输入  //Pull-up
                |||+--------- Nib4  DAC1  模拟输出  //DAC
                ||+---------- Nib5  NC    上拉输入  //Pull-up
                |+----------- Nib6  SCK   低速输出   //low-speec Output   
                +------------ Nib7  SDA   低速输出*/  //Output  
  GPIOA_CRH = 0x88833BBB;  /* GPIOA Bit8-15 状态设置//Setting of GPIOA bit 8~15
                |||||||+----- Nib8  MCO   复用输出//Alternative function output
                ||||||+------ Nib9  TX    复用输出//Alternative function output
                |||||+------- Nib10 RX    复用输入 //Alternative function input 
                ||||+-------- Nib11 D-    复用输入 //Alternative function input  // 开机时暂时设为输出"0"//Init value:0
                |||+--------- Nib12 D+    复用输入 //Alternative function input  // 开机时暂时设为输出"0" //Init value:0 
                ||+---------- Nib13 K2    上拉输入  //Pull-up
                |+----------- Nib14 K1    上拉输入  //Pull-up
                +------------ Nib15 K8    上拉输入//Pull-up*/
  GPIOA_ODR = 0xE7FF;
  
//  GPIOB_CRL = 0x3BBBB433;  /* GPIOB Bit0-7 状态设置
  GPIOB_CRL = 0x3BBBB818;  /* GPIOB Bit0-7 状态设置//Setting of GPIOB bit 0~7
                |||||||+----- Nib0  NC    上拉输入  //Pull-up
                ||||||+------ Nib1  ClrW  低速输出////low-speed output
                |||||+------- Nib2  NC    上拉输入 //Pull-up 
                ||||+-------- Nib3  MSCK  复用输出  //Alternative function output
                |||+--------- Nib4  SIMO  复用输出  //Alternative function output
                ||+---------- Nib5  MOSI  复用输出  //Alternative function output
                |+----------- Nib6  Sqr   高阻输入/复用输出(T42 PWM)//Alternative function output 
                +------------ Nib7  EECS  高速输出 */////high-speed output
  GPIOB_CRH = 0x88883338;  /* GPIOB Bit8-15 状态设置//Setting of GPIOB bit 8~15   0x83833333
                |||||||+----- Nib8  CHRG  上拉输入//Pull-up
                ||||||+------ Nib9  Bx0.1 高速输出//high-speed output
                |||||+------- Nib10 C_nSS 高速输出 //high-speed output // 配置成功后改为“标准版”PWRon 输出
                ||||+-------- Nib11 C_SCK 高速输出  //high-speed output
                |||+--------- Nib12 C_SI  高速输出 //high-speed output // 配置成功后改为“标准版”Ready 输入
                ||+---------- Nib13 C_SO  上拉输入 //Pull-up // 配置成功后改为“体验版”DTr   输入
                |+----------- Nib14 C_RST 高速输出 //high-speed output // 配置成功后改为“体验版”CTr   输入
                +------------ Nib15 Cdone 上拉输入//Pull-up*/ 
  GPIOB_ODR = 0xFFFF;
  
  GPIOC_CRL = 0xBB111000;  /* GPIOC Bit0-7 状态设置////Setting of GPIOC bit 0~7
                |||||||+----- Nib0  Ai    模拟输入//Analog input
                ||||||+------ Nib1  Bi    模拟输入//Analog input
                |||||+------- Nib2  Vbat  模拟输入 //Analog input 
                ||||+-------- Nib3  Mode  低速输出 //Low-speed output 
                |||+--------- Nib4  ClrR  低速输出 //Low-speed output 
                ||+---------- Nib5  H_L   低速输出  //Low-speed output 
                |+----------- Nib6  BL    低速输出 T81 PWM //Low-speed output 
                +------------ Nib7  BZ    低速输出 T82 PWM*///Low-speed output 
  GPIOC_CRH = 0x33388888;  /* GPIOC Bit8-15 状态设置//Setting of GPIOC bit 8~15
                |||||||+----- Nib8  Key_n 上拉输入//Pull-up
                ||||||+------ Nib9  Key_n 上拉输入//Pull-up
                |||||+------- Nib10 Key_n 上拉输入 //Pull-up 
                ||||+-------- Nib11 Key_n 上拉输入 //Pull-up 
                |||+--------- Nib12 Key_n 上拉输入 //Pull-up 
                ||+---------- Nib13 Ax5   高速输出  //high-speed output
                |+----------- Nib14 Ax2   高速输出  //high-speed output
                +------------ Nib15 Bx5   高速输出*/ //high-speed output
  GPIOC_ODR = 0xFFEF;
  
  GPIOD_CRL = 0xB8BB84BB;  /* GPIOD Bit0-7 状态设置//Setting of GPIOD bit 0~7
                |||||||+----- Nib0  DB2   复用输出//Alternative function output
                ||||||+------ Nib1  DB3   复用输出//Alternative function output
                |||||+------- Nib2  Vusb  高阻输入  //Float Input
                ||||+-------- Nib3  Key_n 上拉输入  //Pull-up
                |||+--------- Nib4  nRD   复用输出  //Alternative function output
                ||+---------- Nib5  nWR   复用输出  //Alternative function output
                |+----------- Nib6  Key_n 上拉输入  //Pull-up
                +------------ Nib7  nE1   复用输出*///Alternative function output
  GPIOD_CRH = 0xBB131BBB;  /* GPIOD Bit8-15 状态设置//Setting of GPIOD bit 8~15
                |||||||+----- Nib8  DB13  复用输出//Alternative function output
                ||||||+------ Nib9  DB14  复用输出//Alternative function output
                |||||+------- Nib10 DB15  复用输出  //Alternative function output
                ||||+-------- Nib11 nCLR  低速输出  //Low-speed output
                |||+--------- Nib12 A17   高速输出(RS)//high-speed output     
                ||+---------- Nib13 SLEEP 低速输出  //Low-speed output
                |+----------- Nib14 DB0   复用输出  //Alternative function output
                +------------ Nib15 DB1   复用输出*///Alternative function output
  GPIOD_ODR = 0xFFFF;
  
  GPIOE_CRL = 0xB3333383;  /* GPIOE Bit0-7 状态设置//Setting of GPIOE bit 0~7
                |||||||+----- Nib0  AC2   高速输出//high-speed output 
                ||||||+------ Nib1  NC    上拉输入//Pull-up
                |||||+------- Nib2  Bx1   高速输出 //high-speed output  
                ||||+-------- Nib3  Ax0.1 高速输出  //high-speed output 
                |||+--------- Nib4  AC1   高速输出 //high-speed output 
                ||+---------- Nib5  Ax1   高速输出 //high-speed output  
                |+----------- Nib6  Ax2   高速输出  //high-speed output 
                +------------ Nib7  DB4   复用输出*///Alternative function output
  GPIOE_CRH = 0xBBBBBBBB;  /* GPIOE Bit8-15 状态设置//Setting of GPIOE bit 8~15
                |||||||+----- Nib8  DB5   复用输出	//Alternative function output
                ||||||+------ Nib9  DB6   复用输出	//Alternative function output
                |||||+------- Nib10 DB7   复用输出  //Alternative function output
                ||||+-------- Nib11 DB8   复用输出  //Alternative function output
                |||+--------- Nib12 DB9   复用输出  //Alternative function output
                ||+---------- Nib13 DB10  复用输出  //Alternative function output
                |+----------- Nib14 DB11  复用输出  //Alternative function output
                +------------ Nib15 DB12  复用输出*///Alternative function output
  GPIOE_ODR = 0xFFFF;
  
  AFIO_MAPR = 0x04000000;  /* AFIO_MAPR Bit0-31 Configuration
                |||||+++----- Reset value
                ||||+-------- Bit12 =1 TIM4_CH1_CH2 Remap to PD12,PD13 
                ||++--------- Reset value  
                |+----------- Bit24-26 SWJ_CFG: JTAG-DP and SW-DP Disabled  
                +------------ Reset value*/
}
/*******************************************************************************
  FSMC_Config : Configures the Parallel interface (FSMC) for LCD(Parallel mode)
*******************************************************************************/
void FSMC_Config(void)
{
  FSMC_BTR1 = 0x10100F02;  /* Bit0-31 FSMC_Configuration
                |||||||+----- Bit0-3   AddressSetupTime = 2
                ||||||+------ Bit4-7   AddressHoldTime = 0;
                ||||++------- Bit8-15  DataSetupTime = 5     F
                |||+--------- Bit16-19 BusTurnAroundDuration = 0  
                ||+---------- Bit20-23 CLKDivision = 0  
                |+----------- Bit24-27 DataLatency = 0  
                +------------ Bit28-29 AccessMode_B*/  
                
  FSMC_BWTR1= 0x10100401;  /* Bit0-31 FSMC_Configuration
                |||||||+----- Bit0-3   AddressSetupTime = 1  1
                ||||||+------ Bit4-7   AddressHoldTime = 0;
                ||||++------- Bit8-15  DataSetupTime = 5     4
                |||+--------- Bit16-19 BusTurnAroundDuration = 0  
                ||+---------- Bit20-23 CLKDivision = 0  
                |+----------- Bit24-27 DataLatency = 0  
                +------------ Bit28-29 AccessMode_B*/  

  FSMC_BCR1 = 0x00005011;  /* Bit0-31 FSMC_Configuration
                |||||||+----- Bit0    FSMC_Bank1_Disable
                |||||||+----- Bit1    DataAddressMux_Disable
                |||||||+----- Bit2-3  MemoryType_SRAM
                ||||||+------ Bit4-5  MemoryDataWidth_16b
                ||||||+------ Bit6-7  Flash access enable
                |||||+------- Bit8    BurstAccessMode_Disable
                |||||+------- Bit9    WaitSignalPolarity_Low
                |||||+------- Bit10   WrapMode_Disable;
                |||||+------- Bit11   WaitSignalActive_BeforeWaitState  
                ||||+-------- Bit12   WriteOperation_Enable  
                ||||+-------- Bit13   WaitSignal_Disable  
                ||||+-------- Bit14   ExtendedMode_Enable  
                |||+--------- Bit19   WriteBurst_Disable  
                +++----------         Reserved*/

  FSMC_BTR2 = 0x10100702;/*   Bit0-31 FSMC_Configuration
                |||||||+----- Bit0-3   AddressSetupTime = 1
                ||||||+------ Bit4-7   AddressHoldTime = 0;
                ||||++------- Bit8-15  DataSetupTime = 5  
                |||+--------- Bit16-19 BusTurnAroundDuration = 0  
                ||+---------- Bit20-23 CLKDivision = 0  
                |+----------- Bit24-27 DataLatency = 0  
                +------------ Bit28-29 AccessMode_B*/  
                
  FSMC_BWTR2= 0x10100401;/*   Bit0-31 FSMC_Configuration= 
                |||||||+----- Bit0-3   AddressSetupTime = 1
                ||||||+------ Bit4-7   AddressHoldTime = 0;
                ||||++------- Bit8-15  DataSetupTime = 5  
                |||+--------- Bit16-19 BusTurnAroundDuration = 0  
                ||+---------- Bit20-23 CLKDivision = 0  
                |+----------- Bit24-27 DataLatency = 0  
                +------------ Bit28-29 AccessMode_B*/  

  FSMC_BCR2 = 0x00005011;/*   Bit0-31 FSMC_Configuration 
                |||||||+----- Bit0    FSMC_Bank2_enable
                |||||||+----- Bit1    DataAddressMux_Disable
                |||||||+----- Bit2-3  MemoryType_SRAM
                ||||||+------ Bit4-5  MemoryDataWidth_8b
                ||||||+------ Bit6-7  Flash access enable
                |||||+------- Bit8    BurstAccessMode_Disable
                |||||+------- Bit9    WaitSignalPolarity_Low
                |||||+------- Bit10   WrapMode_Disable;
                |||||+------- Bit11   WaitSignalActive_BeforeWaitState  
                ||||+-------- Bit12   WriteOperation_Enable  
                ||||+-------- Bit13   WaitSignal_Disable  
                ||||+-------- Bit14   ExtendedMode_Enable  
                |||+--------- Bit19   WriteBurst_Disable  
                +++----------         Reserved*/

}
/*******************************************************************************
  SPI_Config : SPI  port initializtion
*******************************************************************************/
void SPI_Config(void)
{
  SPI_InitTypeDef   SPI_InitStructure;
   
  SPI_InitStructure.SPI_Direction = SPI_Direction_2Lines_FullDuplex;
  SPI_InitStructure.SPI_Mode = SPI_Mode_Master;
  SPI_InitStructure.SPI_DataSize = SPI_DataSize_8b;
  SPI_InitStructure.SPI_CPOL = SPI_CPOL_High;
  SPI_InitStructure.SPI_CPHA = SPI_CPHA_2Edge;
  SPI_InitStructure.SPI_NSS = SPI_NSS_Soft;
  SPI_InitStructure.SPI_BaudRatePrescaler = SPI_BaudRatePrescaler_2;
  SPI_InitStructure.SPI_FirstBit = SPI_FirstBit_MSB;
  SPI_InitStructure.SPI_CRCPolynomial = 7;
  SPI_Init(SPI3, &SPI_InitStructure);  // SPI3 Config
  
  SPI_Cmd(SPI3, ENABLE);               // SPI3 enable 
}
/*******************************************************************************
  DMA_configuration : DMA channel initializtion
*******************************************************************************/
void DMA_Config(void)
{
//---------------- DMA1 CH1 Used for transfer ADC data to Memory ---------------
  DMA1_CPAR1 = ADC1_DR_ADDR;       //DMA1_CH1 peripheral address 
  DMA1_CCR1= 0x00001AA0;/*0001 1010 1000 0000  
               ||||       |||| |||| |||| |||+--EN = 1：DMA_CH1 enabled
               ||||       |||| |||| |||| ||+---TCIE=0：TC interrupt disabled
               ||||       |||| |||| |||| |+----HTIE=0：HT interrupt disabled
               ||||       |||| |||| |||| +-----TEIE=0：TE interrupt disabled
               ||||       |||| |||| |||+-------DIR =0：Read from peripheral
               ||||       |||| |||| ||+--------CIRC=0：Circular mode disabled
               ||||       |||| |||| |+---------PINC=0：Peripheral increment mode disabled 
               ||||       |||| |||| +----------MINC=1：Memory increment mode enabled
               ||||       |||| ||++------------PSIZE=10：Peripheral size=32 bits
               ||||       |||| ++--------------MSIZE=10：Memory size=32 bits
               ||||       ||++-----------------PL=11：Priority level Very high
               ||||       |+-------------------MEM2MEM=0：M to M mode disabled
               ++++-------+--------------------保留*///Reserved
//  DMA1_CMAR1 =(u32)&Analog_Buff[0];//DMA通道1的源或目标的存储器地址
  DMA1_CNDTR1=0x00001000;          //DMA通道1传输数量寄存器(4096*2 Bytes)  
  DMA1_CCR1 |= 0x00000001;         // EN = 1：DMA1通道1开启 //Enable
  
//----------- DMA1 CH2 Used for transfer LCD Row Base data to Memory -----------
  DMA1_CCR2= 0x000075C0;/*0111 0101 1100 0001  
               ||||       |||| |||| |||| |||+--EN = 1：DMA_CH2 enabled
               ||||       |||| |||| |||| ||+---TCIE=0：TC interrupt disabled
               ||||       |||| |||| |||| |+----HTIE=0：HT interrupt disabled
               ||||       |||| |||| |||| +-----TEIE=0：TE interrupt disabled
               ||||       |||| |||| |||+-------DIR =0：Read from peripheral
               ||||       |||| |||| ||+--------CIRC=0：Circular mode disabled
               ||||       |||| |||| |+---------PINC=1：Peripheral increment mode enabled 
               ||||       |||| |||| +----------MINC=1：Memory increment mode enabled
               ||||       |||| ||++------------PSIZE=01：Peripheral size=16 bits
               ||||       |||| ++--------------MSIZE=01：Memory size=16 bits
               ||||       ||++-----------------PL=10：Priority level Very high
               ||||       |+-------------------MEM2MEM=1：M to M mode disabled
               ++++-------+--------------------保留*///Reserved
  
//---------- DMA1 CH5 Used for transfer Digital input data to Memory -----------
/*  DMA1_CCR5= 0x000075C0;0111 0101 1000 0001  
               ||||       |||| |||| |||| |||+--EN = 1：DMA_CH5 enabled
               ||||       |||| |||| |||| ||+---TCIE=0：TC interrupt disabled
               ||||       |||| |||| |||| |+----HTIE=0：HT interrupt disabled
               ||||       |||| |||| |||| +-----TEIE=0：TE interrupt disabled
               ||||       |||| |||| |||+-------DIR =0：Read from peripheral
               ||||       |||| |||| ||+--------CIRC=0：Circular mode disabled
               ||||       |||| |||| |+---------PINC=0：Peripheral increment mode enabled 
               ||||       |||| |||| +----------MINC=1：Memory increment mode enabled
               ||||       |||| ||++------------PSIZE=00：Peripheral size=8 bits
               ||||       |||| ++--------------MSIZE=00：Memory size=8 bits
               ||||       ||++-----------------PL=11：Priority level Very high
               ||||       |+-------------------MEM2MEM=1：M to M mode disabled
               ++++-------+--------------------保留*///Reserved
  
//------------------- DMA2 CH1 Used for transfer data to LCD -------------------
  DMA2_CNDTR1= 0x0;                  // DMA2_CH1 number of data(*2 Bytes)  
  DMA2_CPAR1 = LCD_PORT_ADDR;        // DMA2_CH1 peripheral address
//  DMA2_CMAR1 = (u32)&Fill_Buffer;    // DMA2_CH1 memory address
  DMA2_CCR1 |= 0x00000001;           // EN = 1：DMA2通道1开启 
  DMA2_CCR1  = 0x00007591;/*0111 0101 1001 0001  
                 ||||       |||| |||| |||| |||+--EN = 1 DMA_CH1 enabled
                 ||||       |||| |||| |||| ||+---TCIE=0 TC interrupt disabled
                 ||||       |||| |||| |||| |+----HTIE=0 HT interrupt disabled
                 ||||       |||| |||| |||| +-----TEIE=0 TE interrupt disabled
                 ||||       |||| |||| |||+-------DIR =1 Read from memory
                 ||||       |||| |||| ||+--------CIRC=0 Circular mode disabled
                 ||||       |||| |||| |+---------PINC=0 Peripheral increment mode disabled
                 ||||       |||| |||| +----------MINC=1 Memory increment mode enabled
                 ||||       |||| ||++------------PSIZE=01 Peripheral size=16 bits
                 ||||       |||| ++--------------MSIZE=01 Memory size=16 bits
                 ||||       ||++-----------------PL=11 Priority level Medium
                 ||||       |+-------------------MEM2MEM=1 M to M mode enabled
                 ++++-------+--------------------Reserved*/
  

//------------------- DMA2 CH4 Used for transfer data to DAC -------------------
  DMA2_CNDTR4= 36;                  //DMA2_CH4 number of data(*2 Bytes)  
  DMA2_CPAR4 = DAC_DHR12R1_ADDR;    //DMA2_CH4 peripheral address
  DMA2_CCR4  = 0x000035B1;/*0011 0101 1011 0001  
                 ||||       |||| |||| |||| |||+--EN = 1 DMA_CH4 enabled
                 ||||       |||| |||| |||| ||+---TCIE=0 TC interrupt disabled
                 ||||       |||| |||| |||| |+----HTIE=0 HT interrupt disabled
                 ||||       |||| |||| |||| +-----TEIE=0 TE interrupt disabled
                 ||||       |||| |||| |||+-------DIR =1 Read from memory
                 ||||       |||| |||| ||+--------CIRC=1 Circular mode enabled
                 ||||       |||| |||| |+---------PINC=0 Peripheral increment mode disabled
                 ||||       |||| |||| +----------MINC=1 Memory increment mode enabled
                 ||||       |||| ||++------------PSIZE=01 Peripheral size=16 bits
                 ||||       |||| ++--------------MSIZE=01 Memory size=16 bits
                 ||||       ||++-----------------PL=11 Priority level Very high
                 ||||       |+-------------------MEM2MEM=0 M to M mode disabled
                 ++++-------+--------------------Reserved*/
}
/*******************************************************************************
  DAC_configuration : DAC initializtion
*******************************************************************************/
void DAC_Config(void)
{
  DAC_CR   =0x00000001;/*DAC control register 
              |||||||+--Bit0 =1 DAC channel1 enabled
              |||||||+--Bit1 =0 DAC channel1 output buffer enabled
              |||||||+--Bit2 =0 DAC channel1 trigger disabled
              ||||||++--Bits5:3 =000 DAC channel1 trigger selection
              ||||||+---Bits7:6 =00 DAC channel1 wave generation disabled
              |||||+----Bits11:8 =0000 DAC channel1 mask/amplitude selector
              ||||+-----Bit12 =0 DAC channel1 DMA mode disabled
              |||+------Bit16 =0 DAC channel2 disabled
              |||+------Bit17 =0 DAC channel2 output buffer enabled
              |||+------Bit18 =0 DAC channel2 trigger disabled
              ||++------Bits21:19 =00 DAC channel2 trigger selection
              ||+-------Bits23:22 =00 DAC channel2 wave generation disabled
              |+--------Bits27:24 =0000 DAC channel2 mask/amplitude selector
              +---------Bit28 =0 DAC channel2 DMA mode disabled*/  
  DAC_DHR12R1 = 2048;
}
/*******************************************************************************
  ADC_configuration : ADC initializtion
*******************************************************************************/
void ADC_Config(void)
{
  ADC3_CR1 =0x00000000;
  ADC2_CR1 =0x00000000;
  ADC1_CR1 =0x00000000;/*ADC control register 1
              ||||||++---Bits4:0=000 Analog watchdog channel select bits
              ||||||+----Bits7:5=000 JEOC & AWD & EOC interrupt disabled
              |||||+-----Bit 8 =0 Scan mode disabled
              |||||+-----Bit 9 =0 Analog watchdog enabled on all channels
              |||||+-----Bit10 =0 Automatic injected group conversion disabled
              |||||+-----Bit11 =0 Discontinuous mode on regular channels disabled
              ||||+-----Bit12 =0 Discontinuous mode on injected channels disabled
              ||||+-----Bits15:13 =000 Discontinuous mode channel count= 1 channel
              |||+------Bits19:16 =0000 Independent mode,=0111 Fast interleaved mode only
              ||+-------Bit23:22 =00 Analog watchdog disabled on regular & injected channels  
              ++--------Bits31:24 Reserved*/
  ADC3_CR2 =0x005E0000;
  ADC2_CR2 =0x00100000;
  ADC1_CR2 =0x00100100;/*ADC control register 2
              |||||||+--Bit 0 =0 A/D converter OFF, =1 A/D converter ON
              |||||||+--Bit 1 =0 Single conversion, =1 Continuous conversion
              |||||||+--Bit 2 =0 Calibration completed
              |||||||+--Bit 3 =0 Calibration register initialized.
              ||||||+----保留
              |||||+----Bit 8 =0 DMA mode disabled
              |||||+----Bit11 =0 Right Alignment
              ||||+-----Bit14:12 =000 
              ||||+-----Bit15 =0 Injected channels external event disabled
              |||+------Bits19:17 =000：Timer1 CC1 trigger, =111：SWSTART
              ||+-------Bit20 =1 Conversion on external event enabled 
              ||+-------Bit21 =0 Not Start conversion of injected channels 
              ||+-------Bit22 =0 =1,conversion of regular channels 
              ||+-------Bit23 =0 Temperature sensor and VREFINT channel disabled 
              ++--------Bits31:24 Reserved*/
  ADC3_SQR1=0x00000000;
  ADC2_SQR1=0x00000000;
  ADC1_SQR1=0x00000000;/*ADC regular sequence register 1
              ||+-------Bits23:20 =0000 Regular channel sequence length =1 conversion
              ++--------Bits31:24 Reserved*/
  ADC3_SQR3 =0x0000000C;
  ADC2_SQR3 =0x0000000B;
  ADC1_SQR3 =0x0000000A;/*ADC regular sequence register 3
               ||||||++--Bits4:0 =01101 1st conversion in regular sequence =CH13,CH11,CH12
               +---------Reserved*/
  ADC3_SMPR1=0x00000080;
  ADC2_SMPR1=0x00000000;
  ADC1_SMPR1=0x00000000;/*ADC sample time register 1
               |||||||+--Bits 2:0 =000 Channel 10 Sample time is 1.5T
               ||||||++--Bits 5:3 =000 Channel 11 Sample time is 1.5T
               |||||++---Bits 8:6 =010 Channel 12 Sample time is 13.5T
               ++--------Reserved*/
  ADC3_CR2 |=0x00000001;       //ADON=1：开启ADC3//Enalble ADC3
  ADC2_CR2 |=0x00000001;       //ADON=1：开启ADC2//Enalble ADC2
  ADC1_CR2 |=0x00000001;       //ADON=1：开启ADC1//Enalble ADC1
  
  ADC3_CR2 |=0x00000008; 
  while(ADC3_CR2 & 0x00000008);//初始化ADC3校准寄存器//Init the ADC control register for ADC3
  
  ADC2_CR2 |=0x00000008; 
  while(ADC2_CR2 & 0x00000008);//初始化ADC2校准寄存器//Init the ADC control register for ADC2
  
  ADC1_CR2 |=0x00000008; 
  while(ADC1_CR2 & 0x00000008);//初始化ADC1校准寄存器//Init the ADC control register for ADC1
  
  ADC3_CR2 |=0x00000004; 
  while(ADC2_CR2 & 0x00000004);//ADC3校准//Cal the ADC3
  
  ADC2_CR2 |=0x00000004; 
  while(ADC2_CR2 & 0x00000004);//ADC2校准//Cal the ADC2
  
  ADC1_CR2 |=0x00000004; 
  while(ADC1_CR2 & 0x00000004);//ADC1校准//Cal the ADC1
}
/*******************************************************************************
  Timer_configuration  
*******************************************************************************/
void Timer_Config(void)
{
//------------------ TIM1_CH1 Used for Sampling Clock Control ------------------
//    TIM1 update also used for Sampling digital input and DMA1_CH5 
  TIM1_PSC  =10-1; 
  TIM1_ARR  =36-1;       // 0.2MHz            
  TIM1_CCR1 =18;         // 50% 

  TIM1_CCER =0x0003;/*0000 0000 0000 0001  
                      |||| |||| |||| |||+---CC1E=1 OC1 signal is output
                      |||| |||| |||| ||+----CC1P=0 OC1 active high
                      |||| |||| |||| |+-----CC1NE=0 OC1N is not active
                      |||| |||| |||| +------CC1NP=0 OC1N active high
                      ++++-++++-++++--------CC2、CC3、CC4 as Reset value*/
  TIM1_CCMR1=0x0078;/*0000 0000 0111 1100  
                      |||| |||| |||| ||++---CC1S=00 CC1 channel is configured as output
                      |||| |||| |||| |+-----OC1FE=1 Output Compare 1 fast enable
                      |||| |||| |||| +------OC1PE=1 Preload register on TIM1_CCR1 enabled 
                      |||| |||| |+++--------0C1M=111 PWM mode 2
                      |||| |||| +-----------OC1CE=0 Ref is not affected by the ETRF Input
                      ++++-++++-------------CC2 as Reset value*/
  TIM1_BDTR =0x8000;/*1000 0000 0000 0000  
                      |+++-++++-++++-++++---as Reset value 
                      +---------------------MOE=0 Main output enable*/
  TIM1_DIER =0x0000;/*0100 0001 0000 0000  DMA和中断使能寄存器//DMA&IRQ enble register
                       |     ||        +----CC1IE=0：不允许捕获/比较1中断
                       |     |+-------------UDE=1：允许更新的DMA请求//NEW DAM request enabled
                       |     +--------------CC1DE=1：允许捕获/比较1的DMA请求
                       +--------------------TDE=1：允许触发DMA请求*/
  TIM1_CR1 = 0x0085;/*0000 0000 1000 0101  
                      |||| |||| |||| |||+---CEN=1，TIM1 enabled
                      |||| |||| |||| ||+----UDIS=0 UEV enabled
                      |||| |||| |||| |+-----URS=1  Overflow & update interrupt or DMA request disabled 
                      |||| |||| |||| +------OPM=0  Counter is not stopped at update event
                      |||| |||| |||+--------DIR=0  Counter used as upcounter
                      |||| |||| |++---------CMS=00 Edge-aligned mode
                      |||| |||| +-----------ARPE=1 TIM1_ARR Reload enabled
                      |||| ||++-------------CKD=00 Clock division=1
                      ++++-++---------------Reserved*/
  
//----------------- TIM3 Used for Key scan & application timing ----------------
  TIM3_PSC  =72-1; 
  TIM3_ARR  =1000-1;       // 1mS             
  TIM3_DIER =0x0001;/*0000 0000 0000 0001  DMA/Interrupt enable register
                                        +----Bit0 =1 UIE: Update interrupt enable*/
  TIM3_CR1 = 0x0085;/*0000 0000 1000 0101  
                      |||| |||| |||| |||+---CEN=1  TIM3 Enable
                      |||| |||| |||| ||+----UDIS=0 UEV enabled
                      |||| |||| |||| |+-----URS=1  Overflow & update interrupt or DMA request enabled 
                      |||| |||| |||| +------OPM=0  Counter is not stopped at update event
                      |||| |||| |||+--------DIR=0  Counter used as upcounter
                      |||| |||| |++---------CMS=00 Edge-aligned mode
                      |||| |||| +-----------ARPE=1 TIM3_ARR Reload Enable
                      |||| ||++-------------CKD=00 Clock division=1
                      ++++-++---------------Reserved*/

//-------------------- TIM4_CH1 Used for Square wave Output --------------------  
  TIM4_PSC =4-1;  
  TIM4_ARR =18000-1;       // Fout_ARR[Item_Index[11]];             
  TIM4_CCR1 =18000/2;     // (Fout_ARR[Item_Index[11]]+1)/2; 
  TIM4_CCER =0x0001;/*0000 0000 0000 0001  
                      |||| |||| |||| |||+---CC1E=1 OC2 signal is output
                      |||| |||| |||| ||+----CC1P=0 OC2 active high
                      |||| |||| |||| |+-----CC1NE=0 OC2N is not active.
                      |||| |||| |||| +------CC1NP=0 OC2N active high
                      ++++-++++-++++-++++---CC4、CC3、CC2 as Reset value*/
  TIM4_CCMR1=0x0078;/*0000 0000 0111 1000   
                      |||| |||| |||| ||++---CC1S=00 CC2 channel is configured as output
                      |||| |||| |||| |+-----OC1FE=0 CC2 fast disabled
                      |||| |||| |||| +------OC1PE=1 Preload register on TIM4_CCR2 enabled 
                      |||| |||| |+++--------0C1M=111 PWM mode 2
                      |||| |||| +-----------OC1CE=0 Ref is not affected by the ETRF Input
                      ++++-++++-------------CC2 as Reset value*/

  TIM4_CR1 = 0x0081;/*0000 0000 1000 0000  
                      |||| |||| |||| |||+---Bit0 =1 Counter enabled
                      |||| |||| |||| ||+----Bit1 =0 UEV enabled
                      |||| |||| |||| |+-----Bit2 =0 Overflow & update interrupt or DMA request disabled
                      |||| |||| |||| +------Bit3 =0 Counter is not stopped at update event 
                      |||| |||| |||+--------Bit4 =1 Counter used as downcounter
                      |||| |||| |++---------Bits5:6 =00 Edge-aligned mode
                      |||| |||| +-----------Bit7 =1 TIM4_ARR register is buffered
                      |||| ||++-------------Bits9:8 =00 Clock division=1
                      ++++-++---------------Reserved*/
//--------------- TIM5_CH1_CH2 Used for A_B Channal Offset Control -------------  
  TIM5_PSC  =0; 
  TIM5_ARR  =500-1;      //72MHz/3840=18.75KHz
  TIM5_CCR1 =300;      //Set_Y_Pos(Item_Index[Y_SENSITIVITY], Item_Index[V0]) 
  TIM5_CCR2 =300;      //((240-Y0)*Y_POSm[i])/32+Y_POSn[i] 
  TIM5_CCER =0x0033;/*0000 0000 0011 0011  
                                  ||   |+---CC1E=1，OC1 Output enable
                                  ||   +----CC1P=1，OC1 Output polarity active low
                                  |+--------CC2E=1，OC2 Output enable
                                  +---------CC2P=1，CC2 Output polarity active low*/
  TIM5_CCMR1=0x7878;/*0111 1000 0111 1000  
                      |||| |||| |||| ||++---CC1S=00  CC1is configured as output
                      |||| |||| |||| |+-----OC1FE=1  OC1 fast disabled
                      |||| |||| |||| +------OC1PE=1  OC1 preload enable 
                      |||| |||| |+++--------0C1M=111 PWM mode 2
                      |||| |||| +-----------OC1CE=0  OC1 Ref is not affected by the ETRF input
                      |||| ||++-------------CC2S=00  CC2 is configured as output
                      |||| |+---------------OC2FE=1  OC2 fast disabled
                      |||| +----------------OC2PE=1  OC2 preload enable 
                      |+++------------------0C2M=111 PWM mode 2
                      +---------------------OC2CE=0  OC2 Ref is not affected by the ETRF input*/
  TIM5_CR1 = 0x0081;/*0000 0000 1000 0001  
                      |||| |||| |||| |||+---CEN=1，TIM5 enabled
                      |||| |||| |||| ||+----UDIS=0 UEV enabled
                      |||| |||| |||| |+-----URS=0  Overflow & update interrupt or DMA request disabled 
                      |||| |||| |||| +------OPM=0  Counter is not stopped at update event
                      |||| |||| |||+--------DIR=0  Counter used as upcounter
                      |||| |||| |++---------CMS=00 Edge-aligned mode
                      |||| |||| +-----------ARPE=1 TIM5_ARR Reload enabled
                      |||| ||++-------------CKD=00 Clock division=1
                      ++++-++---------------Reserved*/
  
//------------------------- TIM7 Used for DAC refresh --------------------------  
  TIM7_PSC  =20-1; 
  TIM7_ARR  =100-1;      //Period = 72MHz/20/100/36 = 1000Hz
  TIM7_DIER =0x0100;/*0101 0001 0000 0000  DMA/Interrupt enable register
                              +------------Bit8 =1 UDE: Update DMA request enable*/
  TIM7_CR2 = 0x0008;/*0000 0000 0000 1000  
                                     +------CCDS=1 DMA requests sent when update event occurs*/
  TIM7_CR1 = 0x0085;/*0000 0000 1000 0101  
                      |||| |||| |||| |||+---CEN=1，TIM7 Enable
                      |||| |||| |||| ||+----UDIS=0 UEV enabled
                      |||| |||| |||| |+-----URS=1  Overflow & update interrupt or DMA request enabled 
                      |||| |||| |||| +------OPM=0  Counter is not stopped at update event
                      |||| |||| |||+--------DIR=0  Counter used as upcounter
                      |||| |||| |++---------CMS=00 Edge-aligned mode
                      |||| |||| +-----------ARPE=1 TIM7_ARR Reload Enable
                      |||| ||++-------------CKD=00 Clock division=1
                      ++++-++---------------Reserved*/
  
//------------------ TIM8_CH1_CH2 Used for Backlight & Buzzer ------------------
  TIM8_PSC =200-1;  
  TIM8_ARR =100-1;   // PWM Period = 3.6KHz
  TIM8_CCR1 =50;     // 50% Backlight
  TIM8_CCR2 =100;     // (100-CCR2 )% = 0% Duty for Buzzer
  TIM8_CCER =0x0013;/*0000 0000 0001 0011  
                      |||| |||| |||| |||+---CC1E=1 OC1 signal is output
                      |||| |||| |||| ||+----CC1P=1 OC1 active low
                      |||| |||| |||| |+-----CC1NE=0 OC1N is not active
                      |||| |||| |||| +------CC1NP=0 OC1N active high
                      |||| |||| |||+--------CC2E=1 OC2 signal is output
                      |||| |||| ||+---------CC2P=0 OC2 active high
                      |||| |||| |+----------CC2NE=0 OC2N is not active.
                      |||| |||| +-----------CC2NP=0 OC2N active high
                      ++++-++++------++++---CC4、CC3、CC1 as Reset value*/
  TIM8_CCMR1=0x7878;/*0111 1000 0111 1000  
                      |||| |||| |||| ||++---CC1S=00  CC1is configured as output
                      |||| |||| |||| |+-----OC1FE=1  OC1 fast disabled
                      |||| |||| |||| +------OC1PE=1  OC1 preload enable 
                      |||| |||| |+++--------0C1M=111 PWM mode 2
                      |||| |||| +-----------OC1CE=0  OC1 Ref is not affected by the ETRF input
                      |||| ||++-------------CC2S=00 CC2 channel is configured as output
                      |||| |+---------------OC2FE=0 CC2 fast disabled
                      |||| +----------------OC2PE=1 Preload register on TIM8_CCR2 enabled 
                      |+++------------------0C2M=111 PWM mode 2
                      +---------------------OC2CE=0 Ref is not affected by the ETRF Input*/
  TIM8_BDTR =0x8000;/*1000 0000 0000 0000  
                      |+++-++++-++++-++++---as Reset value 
                      +---------------------MOE=0 Main output enable*/
  TIM8_CR1 = 0x0091;/*0000 0000 1001 0001  
                      |||| |||| |||| |||+---Bit0 =1 Counter enabled
                      |||| |||| |||| ||+----Bit1 =0 UEV enabled
                      |||| |||| |||| |+-----Bit2 =0 Overflow & update interrupt or DMA request disabled
                      |||| |||| |||| +------Bit3 =0 Counter is not stopped at update event 
                      |||| |||| |||+--------Bit4 =1 Counter used as downcounter
                      |||| |||| |++---------Bits5:6 =00 Edge-aligned mode
                      |||| |||| +-----------Bit7 =1 TIMx_ARR register is buffered
                      |||| ||++-------------Bits9:8 =00 Clock division=1
                      ++++-++---------------Reserved*/
}

/*******************************************************************************
Get_SerialNum :   Create the serial number string descriptor.
*******************************************************************************/
void Get_SerialNum(void)
{
  u32 Device_Serial0, Device_Serial1, Device_Serial2;

  Device_Serial0 = *(vu32*)(0x1FFFF7E8);
  Device_Serial1 = *(vu32*)(0x1FFFF7EC);
  Device_Serial2 = *(vu32*)(0x1FFFF7F0);

  if (Device_Serial0 != 0)
  {
    MASS_StringSerial[2] = (u8)(Device_Serial0 & 0x000000FF);
    MASS_StringSerial[4] = (u8)((Device_Serial0 & 0x0000FF00) >> 8);
    MASS_StringSerial[6] = (u8)((Device_Serial0 & 0x00FF0000) >> 16);
    MASS_StringSerial[8] = (u8)((Device_Serial0 & 0xFF000000) >> 24);

    MASS_StringSerial[10] = (u8)(Device_Serial1 & 0x000000FF);
    MASS_StringSerial[12] = (u8)((Device_Serial1 & 0x0000FF00) >> 8);
    MASS_StringSerial[14] = (u8)((Device_Serial1 & 0x00FF0000) >> 16);
    MASS_StringSerial[16] = (u8)((Device_Serial1 & 0xFF000000) >> 24);

    MASS_StringSerial[18] = (u8)(Device_Serial2 & 0x000000FF);
    MASS_StringSerial[20] = (u8)((Device_Serial2 & 0x0000FF00) >> 8);
    MASS_StringSerial[22] = (u8)((Device_Serial2 & 0x00FF0000) >> 16);
    MASS_StringSerial[24] = (u8)((Device_Serial2 & 0xFF000000) >> 24);
  }
}

/*********************************  END OF FILE  ******************************/
