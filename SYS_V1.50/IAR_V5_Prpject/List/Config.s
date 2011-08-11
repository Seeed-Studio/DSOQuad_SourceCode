///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:03:30 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\SYS_V1.50\source\Config.c              /
//    Command line =  E:\Mini-DS\DS203\SYS_V1.50\source\Config.c -lA          /
//                    E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\ -o      /
//                    E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\Obj\          /
//                    --no_inline --endian=little --cpu=Cortex-M3 -e          /
//                    --fpu=None --dlib_config "C:\Program Files\IAR          /
//                    Systems\Embedded Workbench 5.0                          /
//                    Evaluation\ARM\INC\DLib_Config_Normal.h" -I             /
//                    E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\..\..\FWLib\i /
//                    nc\ -I E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\..\..\ /
//                    USBLib\inc\ -I E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpjec /
//                    t\..\include\ -I "C:\Program Files\IAR                  /
//                    Systems\Embedded Workbench 5.0 Evaluation\ARM\INC\"     /
//                    -Ohs                                                    /
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\Config.s /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Config

        EXTERN FLASH_PrefetchBufferCmd
        EXTERN FLASH_SetLatency
        EXTERN MASS_StringSerial
        EXTERN NVIC_Init
        EXTERN NVIC_PriorityGroupConfig
        EXTERN NVIC_SetVectorTable
        EXTERN RCC_DeInit
        EXTERN RCC_GetFlagStatus
        EXTERN RCC_GetSYSCLKSource
        EXTERN RCC_HSEConfig
        EXTERN RCC_PLLCmd
        EXTERN RCC_SYSCLKConfig
        EXTERN RCC_USBCLKConfig
        EXTERN RCC_WaitForHSEStartUp
        EXTERN SPI_Cmd
        EXTERN SPI_Init

        PUBLIC ADC_Config
        PUBLIC DAC_Config
        PUBLIC DMA_Config
        PUBLIC FSMC_Config
        PUBLIC GPIO_Config
        PUBLIC GPIO_Config2
        PUBLIC Get_SerialNum
        PUBLIC HSEStartUpStatus
        PUBLIC NVIC_Config
        PUBLIC SPI_Config
        PUBLIC Set_System
        PUBLIC Timer_Config
        
        CFI Names cfiNames0
        CFI StackFrame CFA R13 DATA
        CFI Resource R0:32, R1:32, R2:32, R3:32, R4:32, R5:32, R6:32, R7:32
        CFI Resource R8:32, R9:32, R10:32, R11:32, R12:32, R13:32, R14:32
        CFI EndNames cfiNames0
        
        CFI Common cfiCommon0 Using cfiNames0
        CFI CodeAlign 2
        CFI DataAlign 4
        CFI ReturnAddress R14 CODE
        CFI CFA R13+0
        CFI R0 Undefined
        CFI R1 Undefined
        CFI R2 Undefined
        CFI R3 Undefined
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R7 SameValue
        CFI R8 SameValue
        CFI R9 SameValue
        CFI R10 SameValue
        CFI R11 SameValue
        CFI R12 Undefined
        CFI R14 SameValue
        CFI EndCommon cfiCommon0
        
// E:\Mini-DS\DS203\SYS_V1.50\source\Config.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : Config.c       
//    3  Version   : DS203_SYS Ver 1.5x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include "USB_desc.h"
//    6 #include "Config.h"
//    7 #include "BIOS.h"
//    8 

        SECTION `.bss`:DATA:NOROOT(0)
//    9 ErrorStatus HSEStartUpStatus;
HSEStartUpStatus:
        DS8 1
//   10 
//   11 /*******************************************************************************
//   12   Set_System :   Configures Main system clocks & power
//   13 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Set_System
        THUMB
//   14 void Set_System(void)
//   15 {
Set_System:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//   16   RCC_DeInit();               
        BL       RCC_DeInit
//   17   RCC_HSEConfig(RCC_HSE_ON);  
        MOV      R0,#+65536
        BL       RCC_HSEConfig
//   18   HSEStartUpStatus = RCC_WaitForHSEStartUp();
        LDR.N    R4,??Set_System_0  ;; HSEStartUpStatus
        BL       RCC_WaitForHSEStartUp
        STRB     R0,[R4, #+0]
//   19   if(HSEStartUpStatus == SUCCESS)
        CMP      R0,#+1
        BNE.N    ??Set_System_1
//   20   {
//   21     FLASH_PrefetchBufferCmd(FLASH_PrefetchBuffer_Enable);
        MOVS     R0,#+16
        BL       FLASH_PrefetchBufferCmd
//   22     FLASH_SetLatency(FLASH_Latency_2);    //Flash 2 wait state  
        MOVS     R0,#+2
        BL       FLASH_SetLatency
//   23     RCC_CFGR = 0x001D8402;/*AHB peripheral clock enable               
        LDR.N    R0,??Set_System_0+0x4  ;; 0x40021004
        LDR.N    R1,??Set_System_0+0x8  ;; 0x1d8402
        STR      R1,[R0, #+0]
//   24                  |||||||+--Bits1:0 =10 PLL used as system clock
//   25                  ||||||+---Bits7:4 =0000 AHB clock=SYSCLK 
//   26                  |||||+----Bits10:8  =100 PCLK1=HCLK divided by 2
//   27                  ||||++----Bits13:11 =000 PCLK2=HCLK 
//   28                  ||||+-----Bits15:14 =10 ADC prescaler PCLK2 divided by 6
//   29                  |||+------Bit16 =1 HSE oscillator clock selected as PLL input clock
//   30                  |||+------Bit17 =0 HSE clock not divided
//   31                  ||++------Bits21:18 =0111 PLL input clock x 9
//   32                  ||+-------Bit22=0 USB prescaler is PLL clock divided by 1.5
//   33                  |+--------Bits26:24 =000 MCO as No clock
//   34                  |+--------Bits26:24 =100 MCO as SYSCLK
//   35                  |+--------Bits26:24 =111 MCO as SYSCLK/2
//   36                  ++--------Bits31:27 Reserved*/
//   37     RCC_PLLCmd(ENABLE);
        MOVS     R0,#+1
        BL       RCC_PLLCmd
//   38     while(RCC_GetFlagStatus(RCC_FLAG_PLLRDY) == RESET){}
??Set_System_2:
        MOVS     R0,#+57
        BL       RCC_GetFlagStatus
        CMP      R0,#+0
        BEQ.N    ??Set_System_2
//   39     RCC_SYSCLKConfig(RCC_SYSCLKSource_PLLCLK);
        MOVS     R0,#+2
        BL       RCC_SYSCLKConfig
//   40     while(RCC_GetSYSCLKSource()!=0x08){}
??Set_System_3:
        BL       RCC_GetSYSCLKSource
        CMP      R0,#+8
        BNE.N    ??Set_System_3
//   41   }
//   42   RCC_AHBENR = 0x00000117;/*AHB peripheral clock enable 
??Set_System_1:
        LDR.N    R0,??Set_System_0+0x4  ;; 0x40021004
        MOVW     R1,#+279
        STR      R1,[R0, #+16]
//   43                  |||||||+--Bit0 =1 DMA1 clock enabled
//   44                  |||||||+--Bit1 =1 DMA2 clock enabled
//   45                  |||||||+--Bit2 =1 SRAM interface clock enabled during Sleep mode
//   46                  ||||||+---Bit4 =1 FLITF clock enabled during Sleep mode
//   47                  ||||||+---Bit6 =0 CRC clock disabled
//   48                  |||||+----Bit8 =1 FSMC clock enabled
//   49                  |||||+----Bit10=0 SDIO clock disabled
//   50                  ++++++----Bits31:11=0 Reserved*/
//   51   
//   52   RCC_APB2ENR = 0x0000AE7D;/* APB2 peripheral clock enable
        MOVW     R1,#+44669
        STR      R1,[R0, #+20]
//   53                   |||||||+--Bit0 =1 1:Alternate Function I/O clock enabled
//   54                   |||||||+--Bit2 =1 I/O port A clock enabled
//   55                   |||||||+--Bit3 =1 I/O port B clock enabled
//   56                   ||||||+---Bit4 =1 I/O port C clock enabled
//   57                   ||||||+---Bit5 =1 I/O port D clock enabled
//   58                   ||||||+---Bit6 =1 I/O port E clock enabled
//   59                   ||||||+---Bit7 =0 I/O port F clock disabled
//   60                   |||||+----Bit8 =0 I/O port G clock disabled
//   61                   |||||+----Bit9 =1 ADC 1 interface clock disabled
//   62                   |||||+----Bit10=1 ADC 2 interface clock disabled
//   63                   |||||+----Bit11=1 TIM1 timer clock enabled
//   64                   ||||+-----Bit12=0 SPI 1 clock disabled
//   65                   ||||+-----Bit13=1 TIM8 timer clock enabled
//   66                   ||||+-----Bit14=0 USART1 clock disabled
//   67                   ||||+-----Bit15=1 ADC 3 interface clock enabled
//   68                   ++++------Bit31:17=0 Reserved*/
//   69 
//   70   RCC_USBCLKConfig(RCC_USBCLKSource_PLLCLK_1Div5);     //USBCLK = 48MHz
        MOVS     R0,#+0
        BL       RCC_USBCLKConfig
//   71   RCC_APB1ENR = 0x2080802F;/* APB1 peripheral clock enable
        LDR.N    R0,??Set_System_0+0x4  ;; 0x40021004
        LDR.N    R1,??Set_System_0+0xC  ;; 0x2080802f
        STR      R1,[R0, #+24]
//   72                   |||||||+--Bit0 =1 Timer 2 clock enabled
//   73                   |||||||+--Bit1 =1 Timer 3 clock enabled
//   74                   |||||||+--Bit2 =1 Timer 4 clock enabled
//   75                   |||||||+--Bit3 =1 Timer 5 clock enabled
//   76                   ||||||+---Bit4 =0 Timer 6 clock disabled
//   77                   ||||||+---Bit5 =1 Timer 7 clock ensabled
//   78                   |||||+----Bit11=0 Window watchdog clock disabled
//   79                   ||||+-----Bit14=0 SPI 2 clock disabled
//   80                   ||||+-----Bit15=1 SPI 3 clock enabled
//   81                   |||+------Bit17=0 USART 2 clock disabled
//   82                   |||+------Bit18=0 USART 3 clock disabled
//   83                   |||+------Bit19=0 USART 4 clock disabled
//   84                   ||+-------Bit20=0 USART 5 clock disabled
//   85                   ||+-------Bit21=0 I2C 1 clock disabled
//   86                   ||+-------Bit22=0 I2C 2 clock enabled
//   87                   ||+-------Bit23=1 USB clock enabled
//   88                   |+--------Bit25=0 CAN clock disabled
//   89                   |+--------Bit27=0 Backup interface clock disabled
//   90                   +---------Bit28=0 Power interface clock disabled
//   91                   +---------Bit29=1 DAC interface clock enable*/
//   92   
//   93 }
        POP      {R4,PC}          ;; return
        Nop      
        DATA
??Set_System_0:
        DC32     HSEStartUpStatus
        DC32     0x40021004
        DC32     0x1d8402
        DC32     0x2080802f
        CFI EndBlock cfiBlock0
//   94 /*******************************************************************************
//   95 * NVIC_Configuration:  interrupt seting  initializtion
//   96 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function NVIC_Config
        THUMB
//   97 void NVIC_Config(void)
//   98 {
NVIC_Config:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//   99   NVIC_InitTypeDef NVIC_InitStructure;
//  100   
//  101   NVIC_SetVectorTable(NVIC_VectTab_FLASH, 0x4000);
        MOV      R1,#+16384
        MOV      R0,#+134217728
        BL       NVIC_SetVectorTable
//  102 
//  103   NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);
        MOV      R0,#+1536
        BL       NVIC_PriorityGroupConfig
//  104 
//  105   NVIC_InitStructure.NVIC_IRQChannel = USB_LP_CAN_RX0_IRQChannel;
        MOVS     R0,#+20
        STRB     R0,[SP, #+0]
//  106   NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
        MOVS     R0,#+1
        STRB     R0,[SP, #+1]
//  107   NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
        STRB     R0,[SP, #+2]
//  108   NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
        STRB     R0,[SP, #+3]
//  109   NVIC_Init(&NVIC_InitStructure);
        ADD      R0,SP,#+0
        BL       NVIC_Init
//  110 
//  111   NVIC_InitStructure.NVIC_IRQChannel = USB_HP_CAN_TX_IRQChannel;
        MOVS     R0,#+19
        STRB     R0,[SP, #+0]
//  112   NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
        MOVS     R0,#+1
        STRB     R0,[SP, #+1]
//  113   NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+2]
//  114   NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
        MOVS     R0,#+1
        STRB     R0,[SP, #+3]
//  115   NVIC_Init(&NVIC_InitStructure);
        ADD      R0,SP,#+0
        BL       NVIC_Init
//  116   
//  117   // enabling TIM3 interrupt 
//  118   NVIC_InitStructure.NVIC_IRQChannel=TIM3_IRQChannel;
        MOVS     R0,#+29
        STRB     R0,[SP, #+0]
//  119   NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
        MOVS     R0,#+1
        STRB     R0,[SP, #+1]
//  120   NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+2]
//  121   NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
        MOVS     R0,#+1
        STRB     R0,[SP, #+3]
//  122   NVIC_Init(&NVIC_InitStructure);
        ADD      R0,SP,#+0
        BL       NVIC_Init
//  123   
//  124 }
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock1
//  125 /*******************************************************************************
//  126 * GPIO_Config: GPIO port initializtion
//  127 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function GPIO_Config2
        THUMB
//  128 void GPIO_Config2(void)
//  129 {
//  130   GPIOB_CRH = 0x88883338;  /* GPIOB Bit8-15 状态设置    0x83833333
GPIO_Config2:
        LDR.N    R0,??GPIO_Config2_0  ;; 0x40010c04
        LDR.N    R1,??DataTable1  ;; 0x88883338
        STR      R1,[R0, #+0]
//  131                 |||||||+----- Nib8  Key_n 上拉输入
//  132                 ||||||+------ Nib9  Bx0.1 高速输出
//  133                 |||||+------- Nib10 C_nSS 高速输出  
//  134                 ||||+-------- Nib11 C_SCK 高速输出  
//  135                 |||+--------- Nib12 C_SI  高速输出  
//  136                 ||+---------- Nib13 C_SO  上拉输入  // 配置成功后改为“体验版”DTr   输入
//  137                 |+----------- Nib14 C_RST 高速输出  // 配置成功后改为“体验版”CTr   输入
//  138                 +------------ Nib15 Cdone 上拉输入*/ 
//  139   SPI_SS_HIGH();                                    // PWRon = 1
        MOV      R1,#+1024
        STR      R1,[R0, #+12]
//  140 }
        BX       LR               ;; return
        Nop      
        DATA
??GPIO_Config2_0:
        DC32     0x40010c04
        CFI EndBlock cfiBlock2
//  141 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function GPIO_Config
        THUMB
//  142 void GPIO_Config(void)
//  143 {
//  144   GPIOA_CRL = 0x118088BB;  /* GPIOA Bit0-7 状态设置
GPIO_Config:
        LDR.N    R0,??GPIO_Config_0  ;; 0x40010004
        LDR.N    R1,??GPIO_Config_0+0x4  ;; 0x118088bb
        STR      R1,[R0, #+2044]
//  145                 |||||||+----- Nib0  V1    复用输出 T51 PWM
//  146                 ||||||+------ Nib1  V2    复用输出 T52 PWM
//  147                 |||||+------- Nib2  NC    上拉输入  
//  148                 ||||+-------- Nib3  NC    上拉输入  
//  149                 |||+--------- Nib4  DAC1  模拟输出  
//  150                 ||+---------- Nib5  NC    上拉输入  
//  151                 |+----------- Nib6  SCK   低速输出      
//  152                 +------------ Nib7  SDA   低速输出*/    
//  153   GPIOA_CRH = 0x88833BBB;  /* GPIOA Bit8-15 状态设置
        ADD      R0,R0,#+2048
        LDR.N    R1,??GPIO_Config_0+0x8  ;; 0x88833bbb
        STR      R1,[R0, #+0]
//  154                 |||||||+----- Nib8  MCO   复用输出
//  155                 ||||||+------ Nib9  TX    复用输出
//  156                 |||||+------- Nib10 RX    复用输入  
//  157                 ||||+-------- Nib11 D-    复用输入  // 开机时暂时设为输出"0"
//  158                 |||+--------- Nib12 D+    复用输入  // 开机时暂时设为输出"0"  
//  159                 ||+---------- Nib13 K2    上拉输入  
//  160                 |+----------- Nib14 K1    上拉输入  
//  161                 +------------ Nib15 K8    上拉输入*/
//  162   GPIOA_ODR = 0xE7FF;
        LDR.N    R0,??GPIO_Config_0  ;; 0x40010004
        MOVW     R1,#+59391
        STR      R1,[R0, #+2056]
//  163   
//  164 //  GPIOB_CRL = 0x3BBBB433;  /* GPIOB Bit0-7 状态设置
//  165   GPIOB_CRL = 0x3BBBB818;  /* GPIOB Bit0-7 状态设置
        LDR.N    R1,??GPIO_Config_0+0xC  ;; 0x3bbbb818
        STR      R1,[R0, #+3068]
//  166                 |||||||+----- Nib0  NC    上拉输入  
//  167                 ||||||+------ Nib1  ClrW  低速输出
//  168                 |||||+------- Nib2  NC    上拉输入  
//  169                 ||||+-------- Nib3  MSCK  复用输出  
//  170                 |||+--------- Nib4  SIMO  复用输出  
//  171                 ||+---------- Nib5  MOSI  复用输出  
//  172                 |+----------- Nib6  Sqr   高阻输入/复用输出(T42 PWM) 
//  173                 +------------ Nib7  EECS  高速输出 */
//  174   GPIOB_CRH = 0x88883338;  /* GPIOB Bit8-15 状态设置    0x83833333
        ADD      R0,R0,#+3072
        LDR.N    R1,??DataTable1  ;; 0x88883338
        STR      R1,[R0, #+0]
//  175                 |||||||+----- Nib8  CHRG  上拉输入
//  176                 ||||||+------ Nib9  Bx0.1 高速输出
//  177                 |||||+------- Nib10 C_nSS 高速输出  // 配置成功后改为“标准版”PWRon 输出
//  178                 ||||+-------- Nib11 C_SCK 高速输出  
//  179                 |||+--------- Nib12 C_SI  高速输出  // 配置成功后改为“标准版”Ready 输入
//  180                 ||+---------- Nib13 C_SO  上拉输入  // 配置成功后改为“体验版”DTr   输入
//  181                 |+----------- Nib14 C_RST 高速输出  // 配置成功后改为“体验版”CTr   输入
//  182                 +------------ Nib15 Cdone 上拉输入*/ 
//  183   GPIOB_ODR = 0xFFFF;
        MOVW     R0,#+65535
        LDR.N    R1,??GPIO_Config_0  ;; 0x40010004
        STR      R0,[R1, #+3080]
//  184   
//  185   GPIOC_CRL = 0xBB111000;  /* GPIOC Bit0-7 状态设置
        LDR.N    R2,??GPIO_Config_0+0x10  ;; 0xbb111000
        STR      R2,[R1, #+4092]
//  186                 |||||||+----- Nib0  Ai    模拟输入
//  187                 ||||||+------ Nib1  Bi    模拟输入
//  188                 |||||+------- Nib2  Vbat  模拟输入  
//  189                 ||||+-------- Nib3  Mode  低速输出  
//  190                 |||+--------- Nib4  ClrR  低速输出 
//  191                 ||+---------- Nib5  H_L   低速输出  
//  192                 |+----------- Nib6  BL    低速输出 T81 PWM 
//  193                 +------------ Nib7  BZ    低速输出 T82 PWM*/
//  194   GPIOC_CRH = 0x33388888;  /* GPIOC Bit8-15 状态设置
        LDR.N    R1,??GPIO_Config_0+0x14  ;; 0x40011004
        LDR.N    R2,??GPIO_Config_0+0x18  ;; 0x33388888
        STR      R2,[R1, #+0]
//  195                 |||||||+----- Nib8  Key_n 上拉输入
//  196                 ||||||+------ Nib9  Key_n 上拉输入
//  197                 |||||+------- Nib10 Key_n 上拉输入  
//  198                 ||||+-------- Nib11 Key_n 上拉输入  
//  199                 |||+--------- Nib12 Key_n 上拉输入  
//  200                 ||+---------- Nib13 Ax5   高速输出  
//  201                 |+----------- Nib14 Ax2   高速输出  
//  202                 +------------ Nib15 Bx5   高速输出*/ 
//  203   GPIOC_ODR = 0xFFEF;
        MOVW     R2,#+65519
        STR      R2,[R1, #+8]
//  204   
//  205   GPIOD_CRL = 0xB8BB84BB;  /* GPIOD Bit0-7 状态设置
        LDR.N    R2,??GPIO_Config_0+0x1C  ;; 0xb8bb84bb
        STR      R2,[R1, #+1020]
//  206                 |||||||+----- Nib0  DB2   复用输出
//  207                 ||||||+------ Nib1  DB3   复用输出
//  208                 |||||+------- Nib2  Vusb  高阻输入  
//  209                 ||||+-------- Nib3  Key_n 上拉输入  
//  210                 |||+--------- Nib4  nRD   复用输出  
//  211                 ||+---------- Nib5  nWR   复用输出  
//  212                 |+----------- Nib6  Key_n 上拉输入  
//  213                 +------------ Nib7  nE1   复用输出*/
//  214   GPIOD_CRH = 0xBB131BBB;  /* GPIOD Bit8-15 状态设置
        ADD      R1,R1,#+1024
        LDR.N    R2,??GPIO_Config_0+0x20  ;; 0xbb131bbb
        STR      R2,[R1, #+0]
//  215                 |||||||+----- Nib8  DB13  复用输出
//  216                 ||||||+------ Nib9  DB14  复用输出
//  217                 |||||+------- Nib10 DB15  复用输出  
//  218                 ||||+-------- Nib11 nCLR  低速输出  
//  219                 |||+--------- Nib12 A17   高速输出(RS)     
//  220                 ||+---------- Nib13 SLEEP 低速输出  
//  221                 |+----------- Nib14 DB0   复用输出  
//  222                 +------------ Nib15 DB1   复用输出*/
//  223   GPIOD_ODR = 0xFFFF;
        LDR.N    R1,??GPIO_Config_0+0x14  ;; 0x40011004
        ADD      R1,R1,#+1032
        STR      R0,[R1, #+0]
//  224   
//  225   GPIOE_CRL = 0xB3333383;  /* GPIOE Bit0-7 状态设置
        LDR.N    R1,??GPIO_Config_0+0x14  ;; 0x40011004
        LDR.N    R2,??GPIO_Config_0+0x24  ;; 0xb3333383
        STR      R2,[R1, #+2044]
//  226                 |||||||+----- Nib0  AC2   高速输出
//  227                 ||||||+------ Nib1  NC    上拉输入
//  228                 |||||+------- Nib2  Bx1   高速输出  
//  229                 ||||+-------- Nib3  Ax0.1 高速输出  
//  230                 |||+--------- Nib4  AC1   高速输出 
//  231                 ||+---------- Nib5  Ax1   高速输出  
//  232                 |+----------- Nib6  Ax2   高速输出  
//  233                 +------------ Nib7  DB4   复用输出*/
//  234   GPIOE_CRH = 0xBBBBBBBB;  /* GPIOE Bit8-15 状态设置
        ADD      R1,R1,#+2048
        MOV      R2,#-1145324613
        STR      R2,[R1, #+0]
//  235                 |||||||+----- Nib8  DB5   复用输出
//  236                 ||||||+------ Nib9  DB6   复用输出
//  237                 |||||+------- Nib10 DB7   复用输出  
//  238                 ||||+-------- Nib11 DB8   复用输出  
//  239                 |||+--------- Nib12 DB9   复用输出  
//  240                 ||+---------- Nib13 DB10  复用输出  
//  241                 |+----------- Nib14 DB11  复用输出  
//  242                 +------------ Nib15 DB12  复用输出*/
//  243   GPIOE_ODR = 0xFFFF;
        LDR.N    R1,??GPIO_Config_0+0x14  ;; 0x40011004
        STR      R0,[R1, #+2056]
//  244   
//  245   AFIO_MAPR = 0x04000000;  /* AFIO_MAPR Bit0-31 Configuration
        LDR.N    R0,??GPIO_Config_0  ;; 0x40010004
        MOV      R1,#+67108864
        STR      R1,[R0, #+0]
//  246                 |||||+++----- Reset value
//  247                 ||||+-------- Bit12 =1 TIM4_CH1_CH2 Remap to PD12,PD13 
//  248                 ||++--------- Reset value  
//  249                 |+----------- Bit24-26 SWJ_CFG: JTAG-DP and SW-DP Disabled  
//  250                 +------------ Reset value*/
//  251 }
        BX       LR               ;; return
        DATA
??GPIO_Config_0:
        DC32     0x40010004
        DC32     0x118088bb
        DC32     0x88833bbb
        DC32     0x3bbbb818
        DC32     0xbb111000
        DC32     0x40011004
        DC32     0x33388888
        DC32     0xb8bb84bb
        DC32     0xbb131bbb
        DC32     0xb3333383
        CFI EndBlock cfiBlock3

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable1:
        DC32     0x88883338
//  252 /*******************************************************************************
//  253   FSMC_Config : Configures the Parallel interface (FSMC) for LCD(Parallel mode)
//  254 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function FSMC_Config
        THUMB
//  255 void FSMC_Config(void)
//  256 {
//  257   FSMC_BTR1 = 0x10100F02;  /* Bit0-31 FSMC_Configuration
FSMC_Config:
        MOV      R0,#-1610612736
        LDR.N    R1,??FSMC_Config_0  ;; 0x10100f02
        STR      R1,[R0, #+4]
//  258                 |||||||+----- Bit0-3   AddressSetupTime = 2
//  259                 ||||||+------ Bit4-7   AddressHoldTime = 0;
//  260                 ||||++------- Bit8-15  DataSetupTime = 5     F
//  261                 |||+--------- Bit16-19 BusTurnAroundDuration = 0  
//  262                 ||+---------- Bit20-23 CLKDivision = 0  
//  263                 |+----------- Bit24-27 DataLatency = 0  
//  264                 +------------ Bit28-29 AccessMode_B*/  
//  265                 
//  266   FSMC_BWTR1= 0x10100401;  /* Bit0-31 FSMC_Configuration
        LDR.N    R0,??FSMC_Config_0+0x4  ;; 0x10100401
        MOV      R1,#-1610612736
        STR      R0,[R1, #+260]
//  267                 |||||||+----- Bit0-3   AddressSetupTime = 1  1
//  268                 ||||||+------ Bit4-7   AddressHoldTime = 0;
//  269                 ||||++------- Bit8-15  DataSetupTime = 5     4
//  270                 |||+--------- Bit16-19 BusTurnAroundDuration = 0  
//  271                 ||+---------- Bit20-23 CLKDivision = 0  
//  272                 |+----------- Bit24-27 DataLatency = 0  
//  273                 +------------ Bit28-29 AccessMode_B*/  
//  274 
//  275   FSMC_BCR1 = 0x00005011;  /* Bit0-31 FSMC_Configuration
        MOVW     R2,#+20497
        STR      R2,[R1, #+0]
//  276                 |||||||+----- Bit0    FSMC_Bank1_Disable
//  277                 |||||||+----- Bit1    DataAddressMux_Disable
//  278                 |||||||+----- Bit2-3  MemoryType_SRAM
//  279                 ||||||+------ Bit4-5  MemoryDataWidth_16b
//  280                 ||||||+------ Bit6-7  Flash access enable
//  281                 |||||+------- Bit8    BurstAccessMode_Disable
//  282                 |||||+------- Bit9    WaitSignalPolarity_Low
//  283                 |||||+------- Bit10   WrapMode_Disable;
//  284                 |||||+------- Bit11   WaitSignalActive_BeforeWaitState  
//  285                 ||||+-------- Bit12   WriteOperation_Enable  
//  286                 ||||+-------- Bit13   WaitSignal_Disable  
//  287                 ||||+-------- Bit14   ExtendedMode_Enable  
//  288                 |||+--------- Bit19   WriteBurst_Disable  
//  289                 +++----------         Reserved*/
//  290 
//  291   FSMC_BTR2 = 0x10100702;/*   Bit0-31 FSMC_Configuration
        LDR.N    R2,??FSMC_Config_0+0x8  ;; 0x10100702
        STR      R2,[R1, #+12]
//  292                 |||||||+----- Bit0-3   AddressSetupTime = 1
//  293                 ||||||+------ Bit4-7   AddressHoldTime = 0;
//  294                 ||||++------- Bit8-15  DataSetupTime = 5  
//  295                 |||+--------- Bit16-19 BusTurnAroundDuration = 0  
//  296                 ||+---------- Bit20-23 CLKDivision = 0  
//  297                 |+----------- Bit24-27 DataLatency = 0  
//  298                 +------------ Bit28-29 AccessMode_B*/  
//  299                 
//  300   FSMC_BWTR2= 0x10100401;/*   Bit0-31 FSMC_Configuration= 
        STR      R0,[R1, #+268]
//  301                 |||||||+----- Bit0-3   AddressSetupTime = 1
//  302                 ||||||+------ Bit4-7   AddressHoldTime = 0;
//  303                 ||||++------- Bit8-15  DataSetupTime = 5  
//  304                 |||+--------- Bit16-19 BusTurnAroundDuration = 0  
//  305                 ||+---------- Bit20-23 CLKDivision = 0  
//  306                 |+----------- Bit24-27 DataLatency = 0  
//  307                 +------------ Bit28-29 AccessMode_B*/  
//  308 
//  309   FSMC_BCR2 = 0x00005011;/*   Bit0-31 FSMC_Configuration 
        MOV      R0,R1
        MOVW     R1,#+20497
        STR      R1,[R0, #+8]
//  310                 |||||||+----- Bit0    FSMC_Bank2_enable
//  311                 |||||||+----- Bit1    DataAddressMux_Disable
//  312                 |||||||+----- Bit2-3  MemoryType_SRAM
//  313                 ||||||+------ Bit4-5  MemoryDataWidth_8b
//  314                 ||||||+------ Bit6-7  Flash access enable
//  315                 |||||+------- Bit8    BurstAccessMode_Disable
//  316                 |||||+------- Bit9    WaitSignalPolarity_Low
//  317                 |||||+------- Bit10   WrapMode_Disable;
//  318                 |||||+------- Bit11   WaitSignalActive_BeforeWaitState  
//  319                 ||||+-------- Bit12   WriteOperation_Enable  
//  320                 ||||+-------- Bit13   WaitSignal_Disable  
//  321                 ||||+-------- Bit14   ExtendedMode_Enable  
//  322                 |||+--------- Bit19   WriteBurst_Disable  
//  323                 +++----------         Reserved*/
//  324 
//  325 }
        BX       LR               ;; return
        Nop      
        DATA
??FSMC_Config_0:
        DC32     0x10100f02
        DC32     0x10100401
        DC32     0x10100702
        CFI EndBlock cfiBlock4
//  326 /*******************************************************************************
//  327   SPI_Config : SPI  port initializtion
//  328 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function SPI_Config
        THUMB
//  329 void SPI_Config(void)
//  330 {
SPI_Config:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        SUB      SP,SP,#+24
        CFI CFA R13+32
//  331   SPI_InitTypeDef   SPI_InitStructure;
//  332    
//  333   SPI_InitStructure.SPI_Direction = SPI_Direction_2Lines_FullDuplex;
        MOVS     R0,#+0
        STRH     R0,[SP, #+0]
//  334   SPI_InitStructure.SPI_Mode = SPI_Mode_Master;
        MOV      R0,#+260
        STRH     R0,[SP, #+2]
//  335   SPI_InitStructure.SPI_DataSize = SPI_DataSize_8b;
        MOVS     R0,#+0
        STRH     R0,[SP, #+4]
//  336   SPI_InitStructure.SPI_CPOL = SPI_CPOL_High;
        MOVS     R0,#+2
        STRH     R0,[SP, #+6]
//  337   SPI_InitStructure.SPI_CPHA = SPI_CPHA_2Edge;
        MOVS     R0,#+1
        STRH     R0,[SP, #+8]
//  338   SPI_InitStructure.SPI_NSS = SPI_NSS_Soft;
        MOV      R0,#+512
        STRH     R0,[SP, #+10]
//  339   SPI_InitStructure.SPI_BaudRatePrescaler = SPI_BaudRatePrescaler_2;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
//  340   SPI_InitStructure.SPI_FirstBit = SPI_FirstBit_MSB;
//  341   SPI_InitStructure.SPI_CRCPolynomial = 7;
        MOVS     R0,#+7
        STRH     R0,[SP, #+16]
//  342   SPI_Init(SPI3, &SPI_InitStructure);  // SPI3 Config
        LDR.N    R4,??SPI_Config_0  ;; 0x40003c00
        ADD      R1,SP,#+0
        MOVS     R0,R4
        BL       SPI_Init
//  343   
//  344   SPI_Cmd(SPI3, ENABLE);               // SPI3 enable 
        MOVS     R1,#+1
        MOVS     R0,R4
        BL       SPI_Cmd
//  345 }
        ADD      SP,SP,#+24
        CFI CFA R13+8
        POP      {R4,PC}          ;; return
        DATA
??SPI_Config_0:
        DC32     0x40003c00
        CFI EndBlock cfiBlock5
//  346 /*******************************************************************************
//  347   DMA_configuration : DMA channel initializtion
//  348 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function DMA_Config
        THUMB
//  349 void DMA_Config(void)
//  350 {
//  351 //---------------- DMA1 CH1 Used for transfer ADC data to Memory ---------------
//  352   DMA1_CPAR1 = ADC1_DR_ADDR;       //DMA1_CH1 peripheral address 
DMA_Config:
        LDR.N    R0,??DMA_Config_0  ;; 0x40020008
        LDR.N    R1,??DMA_Config_0+0x4  ;; 0x4001244c
        STR      R1,[R0, #+8]
//  353   DMA1_CCR1= 0x00001AA0;/*0001 1010 1000 0000  
        MOV      R1,#+6816
        STR      R1,[R0, #+0]
//  354                ||||       |||| |||| |||| |||+--EN = 1：DMA_CH1 enabled
//  355                ||||       |||| |||| |||| ||+---TCIE=0：TC interrupt disabled
//  356                ||||       |||| |||| |||| |+----HTIE=0：HT interrupt disabled
//  357                ||||       |||| |||| |||| +-----TEIE=0：TE interrupt disabled
//  358                ||||       |||| |||| |||+-------DIR =0：Read from peripheral
//  359                ||||       |||| |||| ||+--------CIRC=0：Circular mode disabled
//  360                ||||       |||| |||| |+---------PINC=0：Peripheral increment mode disabled 
//  361                ||||       |||| |||| +----------MINC=1：Memory increment mode enabled
//  362                ||||       |||| ||++------------PSIZE=10：Peripheral size=32 bits
//  363                ||||       |||| ++--------------MSIZE=10：Memory size=32 bits
//  364                ||||       ||++-----------------PL=11：Priority level Very high
//  365                ||||       |+-------------------MEM2MEM=0：M to M mode disabled
//  366                ++++-------+--------------------保留*/
//  367 //  DMA1_CMAR1 =(u32)&Analog_Buff[0];//DMA通道1的源或目标的存储器地址
//  368   DMA1_CNDTR1=0x00001000;          //DMA通道1传输数量寄存器(4096*2 Bytes)  
        MOV      R2,#+4096
        STR      R2,[R0, #+4]
//  369   DMA1_CCR1 |= 0x00000001;         // EN = 1：DMA1通道1开启 
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1
        STR      R1,[R0, #+0]
//  370   
//  371 //----------- DMA1 CH2 Used for transfer LCD Row Base data to Memory -----------
//  372   DMA1_CCR2= 0x000075C0;/*0111 0101 1100 0001  
        MOVW     R1,#+30144
        STR      R1,[R0, #+20]
//  373                ||||       |||| |||| |||| |||+--EN = 1：DMA_CH2 enabled
//  374                ||||       |||| |||| |||| ||+---TCIE=0：TC interrupt disabled
//  375                ||||       |||| |||| |||| |+----HTIE=0：HT interrupt disabled
//  376                ||||       |||| |||| |||| +-----TEIE=0：TE interrupt disabled
//  377                ||||       |||| |||| |||+-------DIR =0：Read from peripheral
//  378                ||||       |||| |||| ||+--------CIRC=0：Circular mode disabled
//  379                ||||       |||| |||| |+---------PINC=1：Peripheral increment mode enabled 
//  380                ||||       |||| |||| +----------MINC=1：Memory increment mode enabled
//  381                ||||       |||| ||++------------PSIZE=01：Peripheral size=16 bits
//  382                ||||       |||| ++--------------MSIZE=01：Memory size=16 bits
//  383                ||||       ||++-----------------PL=10：Priority level Very high
//  384                ||||       |+-------------------MEM2MEM=1：M to M mode disabled
//  385                ++++-------+--------------------保留*/
//  386   
//  387 //---------- DMA1 CH5 Used for transfer Digital input data to Memory -----------
//  388 /*  DMA1_CCR5= 0x000075C0;0111 0101 1000 0001  
//  389                ||||       |||| |||| |||| |||+--EN = 1：DMA_CH5 enabled
//  390                ||||       |||| |||| |||| ||+---TCIE=0：TC interrupt disabled
//  391                ||||       |||| |||| |||| |+----HTIE=0：HT interrupt disabled
//  392                ||||       |||| |||| |||| +-----TEIE=0：TE interrupt disabled
//  393                ||||       |||| |||| |||+-------DIR =0：Read from peripheral
//  394                ||||       |||| |||| ||+--------CIRC=0：Circular mode disabled
//  395                ||||       |||| |||| |+---------PINC=0：Peripheral increment mode enabled 
//  396                ||||       |||| |||| +----------MINC=1：Memory increment mode enabled
//  397                ||||       |||| ||++------------PSIZE=00：Peripheral size=8 bits
//  398                ||||       |||| ++--------------MSIZE=00：Memory size=8 bits
//  399                ||||       ||++-----------------PL=11：Priority level Very high
//  400                ||||       |+-------------------MEM2MEM=1：M to M mode disabled
//  401                ++++-------+--------------------保留*/
//  402   
//  403 //------------------- DMA2 CH1 Used for transfer data to LCD -------------------
//  404   DMA2_CNDTR1= 0x0;                  // DMA2_CH1 number of data(*2 Bytes)  
        MOVS     R1,#+0
        STR      R1,[R0, #+1028]
//  405   DMA2_CPAR1 = LCD_PORT_ADDR;        // DMA2_CH1 peripheral address
        ADD      R0,R0,#+1032
        MOV      R1,#+1610612736
        STR      R1,[R0, #+0]
//  406 //  DMA2_CMAR1 = (u32)&Fill_Buffer;    // DMA2_CH1 memory address
//  407   DMA2_CCR1 |= 0x00000001;           // EN = 1：DMA2通道1开启 
        LDR.N    R0,??DMA_Config_0  ;; 0x40020008
        ADD      R0,R0,#+1024
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x1
        LDR.N    R1,??DMA_Config_0  ;; 0x40020008
        ADD      R1,R1,#+1024
        STR      R0,[R1, #+0]
//  408   DMA2_CCR1  = 0x00007591;/*0111 0101 1001 0001  
        LDR.N    R0,??DMA_Config_0  ;; 0x40020008
        ADD      R0,R0,#+1024
        MOVW     R1,#+30097
        STR      R1,[R0, #+0]
//  409                  ||||       |||| |||| |||| |||+--EN = 1 DMA_CH1 enabled
//  410                  ||||       |||| |||| |||| ||+---TCIE=0 TC interrupt disabled
//  411                  ||||       |||| |||| |||| |+----HTIE=0 HT interrupt disabled
//  412                  ||||       |||| |||| |||| +-----TEIE=0 TE interrupt disabled
//  413                  ||||       |||| |||| |||+-------DIR =1 Read from memory
//  414                  ||||       |||| |||| ||+--------CIRC=0 Circular mode disabled
//  415                  ||||       |||| |||| |+---------PINC=0 Peripheral increment mode disabled
//  416                  ||||       |||| |||| +----------MINC=1 Memory increment mode enabled
//  417                  ||||       |||| ||++------------PSIZE=01 Peripheral size=16 bits
//  418                  ||||       |||| ++--------------MSIZE=01 Memory size=16 bits
//  419                  ||||       ||++-----------------PL=11 Priority level Medium
//  420                  ||||       |+-------------------MEM2MEM=1 M to M mode enabled
//  421                  ++++-------+--------------------Reserved*/
//  422   
//  423 
//  424 //------------------- DMA2 CH4 Used for transfer data to DAC -------------------
//  425   DMA2_CNDTR4= 36;                  //DMA2_CH4 number of data(*2 Bytes)  
        LDR.N    R0,??DMA_Config_0  ;; 0x40020008
        ADD      R0,R0,#+1088
        MOVS     R1,#+36
        STR      R1,[R0, #+0]
//  426   DMA2_CPAR4 = DAC_DHR12R1_ADDR;    //DMA2_CH4 peripheral address
        LDR.N    R0,??DMA_Config_0  ;; 0x40020008
        LDR.N    R1,??DMA_Config_0+0x8  ;; 0x40007408
        STR      R1,[R0, #+1092]
//  427   DMA2_CCR4  = 0x000035B1;/*0011 0101 1011 0001  
        MOVW     R1,#+13745
        STR      R1,[R0, #+1084]
//  428                  ||||       |||| |||| |||| |||+--EN = 1 DMA_CH4 enabled
//  429                  ||||       |||| |||| |||| ||+---TCIE=0 TC interrupt disabled
//  430                  ||||       |||| |||| |||| |+----HTIE=0 HT interrupt disabled
//  431                  ||||       |||| |||| |||| +-----TEIE=0 TE interrupt disabled
//  432                  ||||       |||| |||| |||+-------DIR =1 Read from memory
//  433                  ||||       |||| |||| ||+--------CIRC=1 Circular mode enabled
//  434                  ||||       |||| |||| |+---------PINC=0 Peripheral increment mode disabled
//  435                  ||||       |||| |||| +----------MINC=1 Memory increment mode enabled
//  436                  ||||       |||| ||++------------PSIZE=01 Peripheral size=16 bits
//  437                  ||||       |||| ++--------------MSIZE=01 Memory size=16 bits
//  438                  ||||       ||++-----------------PL=11 Priority level Very high
//  439                  ||||       |+-------------------MEM2MEM=0 M to M mode disabled
//  440                  ++++-------+--------------------Reserved*/
//  441 }
        BX       LR               ;; return
        DATA
??DMA_Config_0:
        DC32     0x40020008
        DC32     0x4001244c
        DC32     0x40007408
        CFI EndBlock cfiBlock6
//  442 /*******************************************************************************
//  443   DAC_configuration : DAC initializtion
//  444 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function DAC_Config
        THUMB
//  445 void DAC_Config(void)
//  446 {
//  447   DAC_CR   =0x00000001;/*DAC control register 
DAC_Config:
        LDR.N    R0,??DAC_Config_0  ;; 0x40007400
        MOVS     R1,#+1
        STR      R1,[R0, #+0]
//  448               |||||||+--Bit0 =1 DAC channel1 enabled
//  449               |||||||+--Bit1 =0 DAC channel1 output buffer enabled
//  450               |||||||+--Bit2 =0 DAC channel1 trigger disabled
//  451               ||||||++--Bits5:3 =000 DAC channel1 trigger selection
//  452               ||||||+---Bits7:6 =00 DAC channel1 wave generation disabled
//  453               |||||+----Bits11:8 =0000 DAC channel1 mask/amplitude selector
//  454               ||||+-----Bit12 =0 DAC channel1 DMA mode disabled
//  455               |||+------Bit16 =0 DAC channel2 disabled
//  456               |||+------Bit17 =0 DAC channel2 output buffer enabled
//  457               |||+------Bit18 =0 DAC channel2 trigger disabled
//  458               ||++------Bits21:19 =00 DAC channel2 trigger selection
//  459               ||+-------Bits23:22 =00 DAC channel2 wave generation disabled
//  460               |+--------Bits27:24 =0000 DAC channel2 mask/amplitude selector
//  461               +---------Bit28 =0 DAC channel2 DMA mode disabled*/  
//  462   DAC_DHR12R1 = 2048;
        MOV      R1,#+2048
        STR      R1,[R0, #+8]
//  463 }
        BX       LR               ;; return
        Nop      
        DATA
??DAC_Config_0:
        DC32     0x40007400
        CFI EndBlock cfiBlock7
//  464 /*******************************************************************************
//  465   ADC_configuration : ADC initializtion
//  466 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function ADC_Config
        THUMB
//  467 void ADC_Config(void)
//  468 {
//  469   ADC3_CR1 =0x00000000;
ADC_Config:
        LDR.N    R0,??ADC_Config_0  ;; 0x40013c04
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  470   ADC2_CR1 =0x00000000;
        LDR.N    R0,??ADC_Config_0+0x4  ;; 0x40012404
        ADD      R0,R0,#+1024
        STR      R1,[R0, #+0]
//  471   ADC1_CR1 =0x00000000;/*ADC control register 1
        LDR.N    R0,??ADC_Config_0+0x4  ;; 0x40012404
        STR      R1,[R0, #+0]
//  472               ||||||++---Bits4:0=000 Analog watchdog channel select bits
//  473               ||||||+----Bits7:5=000 JEOC & AWD & EOC interrupt disabled
//  474               |||||+-----Bit 8 =0 Scan mode disabled
//  475               |||||+-----Bit 9 =0 Analog watchdog enabled on all channels
//  476               |||||+-----Bit10 =0 Automatic injected group conversion disabled
//  477               |||||+-----Bit11 =0 Discontinuous mode on regular channels disabled
//  478               ||||+-----Bit12 =0 Discontinuous mode on injected channels disabled
//  479               ||||+-----Bits15:13 =000 Discontinuous mode channel count= 1 channel
//  480               |||+------Bits19:16 =0000 Independent mode,=0111 Fast interleaved mode only
//  481               ||+-------Bit23:22 =00 Analog watchdog disabled on regular & injected channels  
//  482               ++--------Bits31:24 Reserved*/
//  483   ADC3_CR2 =0x005E0000;
        LDR.N    R0,??ADC_Config_0  ;; 0x40013c04
        MOV      R1,#+6160384
        STR      R1,[R0, #+4]
//  484   ADC2_CR2 =0x00100000;
        LDR.N    R0,??ADC_Config_0+0x4  ;; 0x40012404
        MOV      R1,#+1048576
        STR      R1,[R0, #+1028]
//  485   ADC1_CR2 =0x00100100;/*ADC control register 2
        LDR.N    R1,??ADC_Config_0+0x8  ;; 0x100100
        STR      R1,[R0, #+4]
//  486               |||||||+--Bit 0 =0 A/D converter OFF, =1 A/D converter ON
//  487               |||||||+--Bit 1 =0 Single conversion, =1 Continuous conversion
//  488               |||||||+--Bit 2 =0 Calibration completed
//  489               |||||||+--Bit 3 =0 Calibration register initialized.
//  490               ||||||+----保留
//  491               |||||+----Bit 8 =0 DMA mode disabled
//  492               |||||+----Bit11 =0 Right Alignment
//  493               ||||+-----Bit14:12 =000 
//  494               ||||+-----Bit15 =0 Injected channels external event disabled
//  495               |||+------Bits19:17 =000：Timer1 CC1 trigger, =111：SWSTART
//  496               ||+-------Bit20 =1 Conversion on external event enabled 
//  497               ||+-------Bit21 =0 Not Start conversion of injected channels 
//  498               ||+-------Bit22 =0 =1,conversion of regular channels 
//  499               ||+-------Bit23 =0 Temperature sensor and VREFINT channel disabled 
//  500               ++--------Bits31:24 Reserved*/
//  501   ADC3_SQR1=0x00000000;
        LDR.N    R0,??ADC_Config_0  ;; 0x40013c04
        MOVS     R1,#+0
        STR      R1,[R0, #+40]
//  502   ADC2_SQR1=0x00000000;
        LDR.N    R0,??ADC_Config_0+0x4  ;; 0x40012404
        ADD      R0,R0,#+1064
        STR      R1,[R0, #+0]
//  503   ADC1_SQR1=0x00000000;/*ADC regular sequence register 1
        LDR.N    R0,??ADC_Config_0+0x4  ;; 0x40012404
        STR      R1,[R0, #+40]
//  504               ||+-------Bits23:20 =0000 Regular channel sequence length =1 conversion
//  505               ++--------Bits31:24 Reserved*/
//  506   ADC3_SQR3 =0x0000000C;
        LDR.N    R0,??ADC_Config_0  ;; 0x40013c04
        MOVS     R1,#+12
        STR      R1,[R0, #+48]
//  507   ADC2_SQR3 =0x0000000B;
        LDR.N    R0,??ADC_Config_0+0x4  ;; 0x40012404
        ADD      R0,R0,#+1072
        MOVS     R1,#+11
        STR      R1,[R0, #+0]
//  508   ADC1_SQR3 =0x0000000A;/*ADC regular sequence register 3
        LDR.N    R0,??ADC_Config_0+0x4  ;; 0x40012404
        MOVS     R1,#+10
        STR      R1,[R0, #+48]
//  509                ||||||++--Bits4:0 =01101 1st conversion in regular sequence =CH13,CH11,CH12
//  510                +---------Reserved*/
//  511   ADC3_SMPR1=0x00000080;
        LDR.N    R0,??ADC_Config_0  ;; 0x40013c04
        MOVS     R1,#+128
        STR      R1,[R0, #+8]
//  512   ADC2_SMPR1=0x00000000;
        LDR.N    R0,??ADC_Config_0+0x4  ;; 0x40012404
        ADD      R0,R0,#+1032
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  513   ADC1_SMPR1=0x00000000;/*ADC sample time register 1
        LDR.N    R0,??ADC_Config_0+0x4  ;; 0x40012404
        STR      R1,[R0, #+8]
//  514                |||||||+--Bits 2:0 =000 Channel 10 Sample time is 1.5T
//  515                ||||||++--Bits 5:3 =000 Channel 11 Sample time is 1.5T
//  516                |||||++---Bits 8:6 =010 Channel 12 Sample time is 13.5T
//  517                ++--------Reserved*/
//  518   ADC3_CR2 |=0x00000001;       //ADON=1：开启ADC3
        LDR.N    R0,??ADC_Config_0  ;; 0x40013c04
        LDR      R0,[R0, #+4]
        ORR      R0,R0,#0x1
        LDR.N    R1,??ADC_Config_0  ;; 0x40013c04
        STR      R0,[R1, #+4]
//  519   ADC2_CR2 |=0x00000001;       //ADON=1：开启ADC2
        LDR.N    R0,??ADC_Config_0+0x4  ;; 0x40012404
        LDR      R0,[R0, #+1028]
        ORR      R0,R0,#0x1
        LDR.N    R1,??ADC_Config_0+0x4  ;; 0x40012404
        STR      R0,[R1, #+1028]
//  520   ADC1_CR2 |=0x00000001;       //ADON=1：开启ADC1
        LDR      R0,[R1, #+4]
        ORR      R0,R0,#0x1
        STR      R0,[R1, #+4]
//  521   
//  522   ADC3_CR2 |=0x00000008; 
        LDR.N    R0,??ADC_Config_0  ;; 0x40013c04
        LDR      R0,[R0, #+4]
        ORR      R0,R0,#0x8
        LDR.N    R1,??ADC_Config_0  ;; 0x40013c04
        STR      R0,[R1, #+4]
//  523   while(ADC3_CR2 & 0x00000008);//初始化ADC3校准寄存器
??ADC_Config_1:
        LDR      R0,[R1, #+4]
        TST      R0,#0x8
        BNE.N    ??ADC_Config_1
//  524   
//  525   ADC2_CR2 |=0x00000008; 
        LDR.N    R0,??ADC_Config_0+0x4  ;; 0x40012404
        LDR      R0,[R0, #+1028]
        ORR      R0,R0,#0x8
        LDR.N    R1,??ADC_Config_0+0x4  ;; 0x40012404
        STR      R0,[R1, #+1028]
//  526   while(ADC2_CR2 & 0x00000008);//初始化ADC2校准寄存器
??ADC_Config_2:
        LDR      R0,[R1, #+1028]
        TST      R0,#0x8
        BNE.N    ??ADC_Config_2
//  527   
//  528   ADC1_CR2 |=0x00000008; 
        LDR      R0,[R1, #+4]
        ORR      R0,R0,#0x8
        STR      R0,[R1, #+4]
//  529   while(ADC1_CR2 & 0x00000008);//初始化ADC1校准寄存器
??ADC_Config_3:
        LDR      R0,[R1, #+4]
        TST      R0,#0x8
        BNE.N    ??ADC_Config_3
//  530   
//  531   ADC3_CR2 |=0x00000004; 
        LDR.N    R0,??ADC_Config_0  ;; 0x40013c04
        LDR      R0,[R0, #+4]
        ORR      R0,R0,#0x4
        LDR.N    R1,??ADC_Config_0  ;; 0x40013c04
        STR      R0,[R1, #+4]
//  532   while(ADC2_CR2 & 0x00000004);//ADC3校准
??ADC_Config_4:
        LDR.N    R0,??ADC_Config_0+0x4  ;; 0x40012404
        LDR      R0,[R0, #+1028]
        TST      R0,#0x4
        BNE.N    ??ADC_Config_4
//  533   
//  534   ADC2_CR2 |=0x00000004; 
        LDR.N    R0,??ADC_Config_0+0x4  ;; 0x40012404
        LDR      R0,[R0, #+1028]
        ORR      R0,R0,#0x4
        LDR.N    R1,??ADC_Config_0+0x4  ;; 0x40012404
        STR      R0,[R1, #+1028]
//  535   while(ADC2_CR2 & 0x00000004);//ADC2校准
??ADC_Config_5:
        LDR      R0,[R1, #+1028]
        TST      R0,#0x4
        BNE.N    ??ADC_Config_5
//  536   
//  537   ADC1_CR2 |=0x00000004; 
        LDR      R0,[R1, #+4]
        ORR      R0,R0,#0x4
        STR      R0,[R1, #+4]
//  538   while(ADC1_CR2 & 0x00000004);//ADC1校准
??ADC_Config_6:
        LDR      R0,[R1, #+4]
        TST      R0,#0x4
        BNE.N    ??ADC_Config_6
//  539 }
        BX       LR               ;; return
        Nop      
        DATA
??ADC_Config_0:
        DC32     0x40013c04
        DC32     0x40012404
        DC32     0x100100
        CFI EndBlock cfiBlock8
//  540 /*******************************************************************************
//  541   Timer_configuration  
//  542 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function Timer_Config
        THUMB
//  543 void Timer_Config(void)
//  544 {
//  545 //------------------ TIM1_CH1 Used for Sampling Clock Control ------------------
//  546 //    TIM1 update also used for Sampling digital input and DMA1_CH5 
//  547   TIM1_PSC  =10-1; 
Timer_Config:
        LDR.N    R0,??Timer_Config_0  ;; 0x40012c00
        MOVS     R1,#+9
        STR      R1,[R0, #+40]
//  548   TIM1_ARR  =36-1;       // 0.2MHz            
        MOVS     R1,#+35
        STR      R1,[R0, #+44]
//  549   TIM1_CCR1 =18;         // 50% 
        MOVS     R1,#+18
        STR      R1,[R0, #+52]
//  550 
//  551   TIM1_CCER =0x0003;/*0000 0000 0000 0001  
        MOVS     R1,#+3
        STR      R1,[R0, #+32]
//  552                       |||| |||| |||| |||+---CC1E=1 OC1 signal is output
//  553                       |||| |||| |||| ||+----CC1P=0 OC1 active high
//  554                       |||| |||| |||| |+-----CC1NE=0 OC1N is not active
//  555                       |||| |||| |||| +------CC1NP=0 OC1N active high
//  556                       ++++-++++-++++--------CC2、CC3、CC4 as Reset value*/
//  557   TIM1_CCMR1=0x0078;/*0000 0000 0111 1100  
        MOVS     R1,#+120
        STR      R1,[R0, #+24]
//  558                       |||| |||| |||| ||++---CC1S=00 CC1 channel is configured as output
//  559                       |||| |||| |||| |+-----OC1FE=1 Output Compare 1 fast enable
//  560                       |||| |||| |||| +------OC1PE=1 Preload register on TIM1_CCR1 enabled 
//  561                       |||| |||| |+++--------0C1M=111 PWM mode 2
//  562                       |||| |||| +-----------OC1CE=0 Ref is not affected by the ETRF Input
//  563                       ++++-++++-------------CC2 as Reset value*/
//  564   TIM1_BDTR =0x8000;/*1000 0000 0000 0000  
        MOV      R1,#+32768
        STR      R1,[R0, #+68]
//  565                       |+++-++++-++++-++++---as Reset value 
//  566                       +---------------------MOE=0 Main output enable*/
//  567   TIM1_DIER =0x0000;/*0100 0001 0000 0000  DMA和中断使能寄存器
        MOVS     R1,#+0
        STR      R1,[R0, #+12]
//  568                        |     ||        +----CC1IE=0：不允许捕获/比较1中断
//  569                        |     |+-------------UDE=1：允许更新的DMA请求
//  570                        |     +--------------CC1DE=1：允许捕获/比较1的DMA请求
//  571                        +--------------------TDE=1：允许触发DMA请求*/
//  572   TIM1_CR1 = 0x0085;/*0000 0000 1000 0101  
        MOVS     R1,#+133
        STR      R1,[R0, #+0]
//  573                       |||| |||| |||| |||+---CEN=1，TIM1 enabled
//  574                       |||| |||| |||| ||+----UDIS=0 UEV enabled
//  575                       |||| |||| |||| |+-----URS=1  Overflow & update interrupt or DMA request disabled 
//  576                       |||| |||| |||| +------OPM=0  Counter is not stopped at update event
//  577                       |||| |||| |||+--------DIR=0  Counter used as upcounter
//  578                       |||| |||| |++---------CMS=00 Edge-aligned mode
//  579                       |||| |||| +-----------ARPE=1 TIM1_ARR Reload enabled
//  580                       |||| ||++-------------CKD=00 Clock division=1
//  581                       ++++-++---------------Reserved*/
//  582   
//  583 //----------------- TIM3 Used for Key scan & application timing ----------------
//  584   TIM3_PSC  =72-1; 
        LDR.N    R0,??Timer_Config_0+0x4  ;; 0x40000400
        MOVS     R1,#+71
        STR      R1,[R0, #+40]
//  585   TIM3_ARR  =1000-1;       // 1mS             
        MOVW     R1,#+999
        STR      R1,[R0, #+44]
//  586   TIM3_DIER =0x0001;/*0000 0000 0000 0001  DMA/Interrupt enable register
        MOVS     R1,#+1
        STR      R1,[R0, #+12]
//  587                                         +----Bit0 =1 UIE: Update interrupt enable*/
//  588   TIM3_CR1 = 0x0085;/*0000 0000 1000 0101  
        MOVS     R1,#+133
        STR      R1,[R0, #+0]
//  589                       |||| |||| |||| |||+---CEN=1  TIM3 Enable
//  590                       |||| |||| |||| ||+----UDIS=0 UEV enabled
//  591                       |||| |||| |||| |+-----URS=1  Overflow & update interrupt or DMA request enabled 
//  592                       |||| |||| |||| +------OPM=0  Counter is not stopped at update event
//  593                       |||| |||| |||+--------DIR=0  Counter used as upcounter
//  594                       |||| |||| |++---------CMS=00 Edge-aligned mode
//  595                       |||| |||| +-----------ARPE=1 TIM3_ARR Reload Enable
//  596                       |||| ||++-------------CKD=00 Clock division=1
//  597                       ++++-++---------------Reserved*/
//  598 
//  599 //-------------------- TIM4_CH1 Used for Square wave Output --------------------  
//  600   TIM4_PSC =4-1;  
        ADD      R0,R0,#+1064
        MOVS     R1,#+3
        STR      R1,[R0, #+0]
//  601   TIM4_ARR =18000-1;       // Fout_ARR[Item_Index[11]];             
        LDR.N    R0,??Timer_Config_0+0x4  ;; 0x40000400
        MOVW     R1,#+17999
        STR      R1,[R0, #+1068]
//  602   TIM4_CCR1 =18000/2;     // (Fout_ARR[Item_Index[11]]+1)/2; 
        MOVW     R1,#+9000
        STR      R1,[R0, #+1076]
//  603   TIM4_CCER =0x0001;/*0000 0000 0000 0001  
        ADD      R0,R0,#+1056
        MOVS     R1,#+1
        STR      R1,[R0, #+0]
//  604                       |||| |||| |||| |||+---CC1E=1 OC2 signal is output
//  605                       |||| |||| |||| ||+----CC1P=0 OC2 active high
//  606                       |||| |||| |||| |+-----CC1NE=0 OC2N is not active.
//  607                       |||| |||| |||| +------CC1NP=0 OC2N active high
//  608                       ++++-++++-++++-++++---CC4、CC3、CC2 as Reset value*/
//  609   TIM4_CCMR1=0x0078;/*0000 0000 0111 1000   
        LDR.N    R0,??Timer_Config_0+0x4  ;; 0x40000400
        ADD      R0,R0,#+1048
        MOVS     R1,#+120
        STR      R1,[R0, #+0]
//  610                       |||| |||| |||| ||++---CC1S=00 CC2 channel is configured as output
//  611                       |||| |||| |||| |+-----OC1FE=0 CC2 fast disabled
//  612                       |||| |||| |||| +------OC1PE=1 Preload register on TIM4_CCR2 enabled 
//  613                       |||| |||| |+++--------0C1M=111 PWM mode 2
//  614                       |||| |||| +-----------OC1CE=0 Ref is not affected by the ETRF Input
//  615                       ++++-++++-------------CC2 as Reset value*/
//  616 
//  617   TIM4_CR1 = 0x0081;/*0000 0000 1000 0000  
        LDR.N    R0,??Timer_Config_0+0x4  ;; 0x40000400
        ADD      R0,R0,#+1024
        MOVS     R1,#+129
        STR      R1,[R0, #+0]
//  618                       |||| |||| |||| |||+---Bit0 =1 Counter enabled
//  619                       |||| |||| |||| ||+----Bit1 =0 UEV enabled
//  620                       |||| |||| |||| |+-----Bit2 =0 Overflow & update interrupt or DMA request disabled
//  621                       |||| |||| |||| +------Bit3 =0 Counter is not stopped at update event 
//  622                       |||| |||| |||+--------Bit4 =1 Counter used as downcounter
//  623                       |||| |||| |++---------Bits5:6 =00 Edge-aligned mode
//  624                       |||| |||| +-----------Bit7 =1 TIM4_ARR register is buffered
//  625                       |||| ||++-------------Bits9:8 =00 Clock division=1
//  626                       ++++-++---------------Reserved*/
//  627 //--------------- TIM5_CH1_CH2 Used for A_B Channal Offset Control -------------  
//  628   TIM5_PSC  =0; 
        LDR.N    R0,??Timer_Config_0+0x4  ;; 0x40000400
        MOVS     R1,#+0
        STR      R1,[R0, #+2088]
//  629   TIM5_ARR  =500-1;      //72MHz/3840=18.75KHz
        MOVW     R1,#+499
        STR      R1,[R0, #+2092]
//  630   TIM5_CCR1 =300;      //Set_Y_Pos(Item_Index[Y_SENSITIVITY], Item_Index[V0]) 
        MOV      R1,#+300
        STR      R1,[R0, #+2100]
//  631   TIM5_CCR2 =300;      //((240-Y0)*Y_POSm[i])/32+Y_POSn[i] 
        STR      R1,[R0, #+2104]
//  632   TIM5_CCER =0x0033;/*0000 0000 0011 0011  
        ADD      R0,R0,#+2080
        MOVS     R1,#+51
        STR      R1,[R0, #+0]
//  633                                   ||   |+---CC1E=1，OC1 Output enable
//  634                                   ||   +----CC1P=1，OC1 Output polarity active low
//  635                                   |+--------CC2E=1，OC2 Output enable
//  636                                   +---------CC2P=1，CC2 Output polarity active low*/
//  637   TIM5_CCMR1=0x7878;/*0111 1000 0111 1000  
        LDR.N    R0,??Timer_Config_0+0x4  ;; 0x40000400
        MOVW     R1,#+30840
        STR      R1,[R0, #+2072]
//  638                       |||| |||| |||| ||++---CC1S=00  CC1is configured as output
//  639                       |||| |||| |||| |+-----OC1FE=1  OC1 fast disabled
//  640                       |||| |||| |||| +------OC1PE=1  OC1 preload enable 
//  641                       |||| |||| |+++--------0C1M=111 PWM mode 2
//  642                       |||| |||| +-----------OC1CE=0  OC1 Ref is not affected by the ETRF input
//  643                       |||| ||++-------------CC2S=00  CC2 is configured as output
//  644                       |||| |+---------------OC2FE=1  OC2 fast disabled
//  645                       |||| +----------------OC2PE=1  OC2 preload enable 
//  646                       |+++------------------0C2M=111 PWM mode 2
//  647                       +---------------------OC2CE=0  OC2 Ref is not affected by the ETRF input*/
//  648   TIM5_CR1 = 0x0081;/*0000 0000 1000 0001  
        ADD      R0,R0,#+2048
        MOVS     R1,#+129
        STR      R1,[R0, #+0]
//  649                       |||| |||| |||| |||+---CEN=1，TIM5 enabled
//  650                       |||| |||| |||| ||+----UDIS=0 UEV enabled
//  651                       |||| |||| |||| |+-----URS=0  Overflow & update interrupt or DMA request disabled 
//  652                       |||| |||| |||| +------OPM=0  Counter is not stopped at update event
//  653                       |||| |||| |||+--------DIR=0  Counter used as upcounter
//  654                       |||| |||| |++---------CMS=00 Edge-aligned mode
//  655                       |||| |||| +-----------ARPE=1 TIM5_ARR Reload enabled
//  656                       |||| ||++-------------CKD=00 Clock division=1
//  657                       ++++-++---------------Reserved*/
//  658   
//  659 //------------------------- TIM7 Used for DAC refresh --------------------------  
//  660   TIM7_PSC  =20-1; 
        LDR.N    R0,??Timer_Config_0+0x8  ;; 0x40001400
        MOVS     R1,#+19
        STR      R1,[R0, #+40]
//  661   TIM7_ARR  =100-1;      //Period = 72MHz/20/100/36 = 1000Hz
        MOVS     R1,#+99
        STR      R1,[R0, #+44]
//  662   TIM7_DIER =0x0100;/*0101 0001 0000 0000  DMA/Interrupt enable register
        MOV      R1,#+256
        STR      R1,[R0, #+12]
//  663                               +------------Bit8 =1 UDE: Update DMA request enable*/
//  664   TIM7_CR2 = 0x0008;/*0000 0000 0000 1000  
        MOVS     R1,#+8
        STR      R1,[R0, #+4]
//  665                                      +------CCDS=1 DMA requests sent when update event occurs*/
//  666   TIM7_CR1 = 0x0085;/*0000 0000 1000 0101  
        MOVS     R1,#+133
        STR      R1,[R0, #+0]
//  667                       |||| |||| |||| |||+---CEN=1，TIM7 Enable
//  668                       |||| |||| |||| ||+----UDIS=0 UEV enabled
//  669                       |||| |||| |||| |+-----URS=1  Overflow & update interrupt or DMA request enabled 
//  670                       |||| |||| |||| +------OPM=0  Counter is not stopped at update event
//  671                       |||| |||| |||+--------DIR=0  Counter used as upcounter
//  672                       |||| |||| |++---------CMS=00 Edge-aligned mode
//  673                       |||| |||| +-----------ARPE=1 TIM7_ARR Reload Enable
//  674                       |||| ||++-------------CKD=00 Clock division=1
//  675                       ++++-++---------------Reserved*/
//  676   
//  677 //------------------ TIM8_CH1_CH2 Used for Backlight & Buzzer ------------------
//  678   TIM8_PSC =200-1;  
        LDR.N    R0,??Timer_Config_0  ;; 0x40012c00
        MOVS     R1,#+199
        STR      R1,[R0, #+2088]
//  679   TIM8_ARR =100-1;   // PWM Period = 3.6KHz
        MOVS     R1,#+99
        STR      R1,[R0, #+2092]
//  680   TIM8_CCR1 =50;     // 50% Backlight
        MOVS     R1,#+50
        STR      R1,[R0, #+2100]
//  681   TIM8_CCR2 =100;     // (100-CCR2 )% = 0% Duty for Buzzer
        MOVS     R1,#+100
        STR      R1,[R0, #+2104]
//  682   TIM8_CCER =0x0013;/*0000 0000 0001 0011  
        ADD      R0,R0,#+2080
        MOVS     R1,#+19
        STR      R1,[R0, #+0]
//  683                       |||| |||| |||| |||+---CC1E=1 OC1 signal is output
//  684                       |||| |||| |||| ||+----CC1P=1 OC1 active low
//  685                       |||| |||| |||| |+-----CC1NE=0 OC1N is not active
//  686                       |||| |||| |||| +------CC1NP=0 OC1N active high
//  687                       |||| |||| |||+--------CC2E=1 OC2 signal is output
//  688                       |||| |||| ||+---------CC2P=0 OC2 active high
//  689                       |||| |||| |+----------CC2NE=0 OC2N is not active.
//  690                       |||| |||| +-----------CC2NP=0 OC2N active high
//  691                       ++++-++++------++++---CC4、CC3、CC1 as Reset value*/
//  692   TIM8_CCMR1=0x7878;/*0111 1000 0111 1000  
        LDR.N    R0,??Timer_Config_0  ;; 0x40012c00
        MOVW     R1,#+30840
        STR      R1,[R0, #+2072]
//  693                       |||| |||| |||| ||++---CC1S=00  CC1is configured as output
//  694                       |||| |||| |||| |+-----OC1FE=1  OC1 fast disabled
//  695                       |||| |||| |||| +------OC1PE=1  OC1 preload enable 
//  696                       |||| |||| |+++--------0C1M=111 PWM mode 2
//  697                       |||| |||| +-----------OC1CE=0  OC1 Ref is not affected by the ETRF input
//  698                       |||| ||++-------------CC2S=00 CC2 channel is configured as output
//  699                       |||| |+---------------OC2FE=0 CC2 fast disabled
//  700                       |||| +----------------OC2PE=1 Preload register on TIM8_CCR2 enabled 
//  701                       |+++------------------0C2M=111 PWM mode 2
//  702                       +---------------------OC2CE=0 Ref is not affected by the ETRF Input*/
//  703   TIM8_BDTR =0x8000;/*1000 0000 0000 0000  
        MOV      R1,#+32768
        STR      R1,[R0, #+2116]
//  704                       |+++-++++-++++-++++---as Reset value 
//  705                       +---------------------MOE=0 Main output enable*/
//  706   TIM8_CR1 = 0x0091;/*0000 0000 1001 0001  
        ADD      R0,R0,#+2048
        MOVS     R1,#+145
        STR      R1,[R0, #+0]
//  707                       |||| |||| |||| |||+---Bit0 =1 Counter enabled
//  708                       |||| |||| |||| ||+----Bit1 =0 UEV enabled
//  709                       |||| |||| |||| |+-----Bit2 =0 Overflow & update interrupt or DMA request disabled
//  710                       |||| |||| |||| +------Bit3 =0 Counter is not stopped at update event 
//  711                       |||| |||| |||+--------Bit4 =1 Counter used as downcounter
//  712                       |||| |||| |++---------Bits5:6 =00 Edge-aligned mode
//  713                       |||| |||| +-----------Bit7 =1 TIMx_ARR register is buffered
//  714                       |||| ||++-------------Bits9:8 =00 Clock division=1
//  715                       ++++-++---------------Reserved*/
//  716 }
        BX       LR               ;; return
        Nop      
        DATA
??Timer_Config_0:
        DC32     0x40012c00
        DC32     0x40000400
        DC32     0x40001400
        CFI EndBlock cfiBlock9
//  717 
//  718 /*******************************************************************************
//  719 Get_SerialNum :   Create the serial number string descriptor.
//  720 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function Get_SerialNum
        THUMB
//  721 void Get_SerialNum(void)
//  722 {
//  723   u32 Device_Serial0, Device_Serial1, Device_Serial2;
//  724 
//  725   Device_Serial0 = *(vu32*)(0x1FFFF7E8);
Get_SerialNum:
        LDR.N    R0,??Get_SerialNum_0  ;; 0x1ffff7e8
        LDR      R0,[R0, #+0]
//  726   Device_Serial1 = *(vu32*)(0x1FFFF7EC);
        LDR.N    R1,??Get_SerialNum_0  ;; 0x1ffff7e8
        LDR      R1,[R1, #+4]
//  727   Device_Serial2 = *(vu32*)(0x1FFFF7F0);
        LDR.N    R2,??Get_SerialNum_0  ;; 0x1ffff7e8
        LDR      R2,[R2, #+8]
//  728 
//  729   if (Device_Serial0 != 0)
        CBZ      R0,??Get_SerialNum_1
//  730   {
//  731     MASS_StringSerial[2] = (u8)(Device_Serial0 & 0x000000FF);
        LDR.N    R3,??Get_SerialNum_0+0x4  ;; MASS_StringSerial
        STRB     R0,[R3, #+2]
//  732     MASS_StringSerial[4] = (u8)((Device_Serial0 & 0x0000FF00) >> 8);
        LSR      R12,R0,#+8
        STRB     R12,[R3, #+4]
//  733     MASS_StringSerial[6] = (u8)((Device_Serial0 & 0x00FF0000) >> 16);
        LSR      R12,R0,#+16
        STRB     R12,[R3, #+6]
//  734     MASS_StringSerial[8] = (u8)((Device_Serial0 & 0xFF000000) >> 24);
        LSRS     R0,R0,#+24
        STRB     R0,[R3, #+8]
//  735 
//  736     MASS_StringSerial[10] = (u8)(Device_Serial1 & 0x000000FF);
        STRB     R1,[R3, #+10]
//  737     MASS_StringSerial[12] = (u8)((Device_Serial1 & 0x0000FF00) >> 8);
        LSRS     R0,R1,#+8
        STRB     R0,[R3, #+12]
//  738     MASS_StringSerial[14] = (u8)((Device_Serial1 & 0x00FF0000) >> 16);
        LSRS     R0,R1,#+16
        STRB     R0,[R3, #+14]
//  739     MASS_StringSerial[16] = (u8)((Device_Serial1 & 0xFF000000) >> 24);
        LSRS     R0,R1,#+24
        STRB     R0,[R3, #+16]
//  740 
//  741     MASS_StringSerial[18] = (u8)(Device_Serial2 & 0x000000FF);
        STRB     R2,[R3, #+18]
//  742     MASS_StringSerial[20] = (u8)((Device_Serial2 & 0x0000FF00) >> 8);
        LSRS     R0,R2,#+8
        STRB     R0,[R3, #+20]
//  743     MASS_StringSerial[22] = (u8)((Device_Serial2 & 0x00FF0000) >> 16);
        LSRS     R0,R2,#+16
        STRB     R0,[R3, #+22]
//  744     MASS_StringSerial[24] = (u8)((Device_Serial2 & 0xFF000000) >> 24);
        LSRS     R0,R2,#+24
        STRB     R0,[R3, #+24]
//  745   }
//  746 }
??Get_SerialNum_1:
        BX       LR               ;; return
        DATA
??Get_SerialNum_0:
        DC32     0x1ffff7e8
        DC32     MASS_StringSerial
        CFI EndBlock cfiBlock10

        END
//  747 
//  748 /*********************************  END OF FILE  ******************************/
// 
//     1 byte  in section .bss
// 1 318 bytes in section .text
// 
// 1 318 bytes of CODE memory
//     1 byte  of DATA memory
//
//Errors: none
//Warnings: none
