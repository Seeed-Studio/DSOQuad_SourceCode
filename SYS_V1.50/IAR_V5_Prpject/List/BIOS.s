///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:03:28 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\SYS_V1.50\source\BIOS.c                /
//    Command line =  E:\Mini-DS\DS203\SYS_V1.50\source\BIOS.c -lA            /
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
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\BIOS.s   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME BIOS

        EXTERN Delayms
        EXTERN SYS_Ver
        EXTERN __Chk_DFU
        EXTERN __Chk_HDW
        EXTERN u16ToDec5

        PUBLIC Clash
        PUBLIC DFU_Ver
        PUBLIC G_ATTR
        PUBLIC Get
        PUBLIC HDW_Ver
        PUBLIC SendByte
        PUBLIC Set
        PUBLIC Set_Param
        PUBLIC T_ATTR
        PUBLIC VerStr
        PUBLIC X_ATTR
        PUBLIC Y_ATTR
        
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
        
// E:\Mini-DS\DS203\SYS_V1.50\source\BIOS.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : BIOS.c  
//    3  Version   : DS203_SYS Ver 1.5x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include "Function.h"
//    6 #include "Config.h"
//    7 #include "Ident.h"
//    8 #include "BIOS.h"
//    9 #include "LCD.h"
//   10 #include "ASM.h"
//   11 
//   12 uc8  HDW_Ver[20] = "Hardware Ver 2.60 ";
//   13 uc8  DFU_Ver[5]  = "3.10";

        SECTION `.bss`:DATA:NOROOT(2)
//   14 u8   VerStr[8];
VerStr:
        DS8 8

        SECTION `.bss`:DATA:NOROOT(0)
//   15 u8   Clash = 0;
Clash:
        DS8 1

        SECTION `.rodata`:CONST:NOROOT(2)
HDW_Ver:
        DATA
        DC8 "Hardware Ver 2.60 "
        DC8 0
DFU_Ver:
        DC8 "3.10"
        DC8 0, 0, 0
//   16 
//   17 const G_attr G_ATTR[1] =//LCD_X;LCD_Y;Yp_Max;Xp_Max;Tg_Num;Yv_Max;Xt_Max
G_ATTR:
        DC16 400, 240, 7, 21, 15, 200, 4096, 1
        DC8 1, 1, 17, 0
        DC16 0, 1024, 0, 1024
//   18                        {  400,   240,   8-1,    22-1,   15,     200,    4096,  
//   19                         //Co_Max;Ya_Num;Yd_Num;INSERT;KpA1;KpA2;KpB1;KpB2
//   20                            1,     1,     1,     17,    0,   1024,  0, 1024};
//   21 
//   22 const Y_attr Y_ATTR[9] ={//  STR     KA1    KA2    KB1    KB2     SCALE 
Y_ATTR:
        DC8 "50mV"
        DC8 0, 0, 0
        DC16 0, 1024, 0, 1024
        DC32 2000
        DC8 "0.1V"
        DC8 0, 0, 0
        DC16 0, 1024, 0, 1024
        DC32 4000
        DC8 "0.2V"
        DC8 0, 0, 0
        DC16 -2, 1024, -6, 1024
        DC32 8000
        DC8 "0.5V"
        DC8 0, 0, 0
        DC16 -1, 1024, -6, 1024
        DC32 20000
        DC8 " 1V "
        DC8 0, 0, 0
        DC16 0, 1024, -6, 1024
        DC32 40000
        DC8 " 2V "
        DC8 0, 0, 0
        DC16 -2, 1024, -6, 1024
        DC32 80000
        DC8 " 5V "
        DC8 0, 0, 0
        DC16 -1, 1024, -6, 1024
        DC32 200000
        DC8 "!10V!"
        DC8 0, 0
        DC16 0, 1024, -6, 1024
        DC32 400000
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
//   23                          { "50mV",    0,   1024,    0,   1024,    2000},
//   24                          { "0.1V",    0,   1024,    0,   1024,    4000},
//   25                          { "0.2V",   -2,   1024,   -6,   1024,    8000},
//   26                          { "0.5V",   -1,   1024,   -6,   1024,   20000},
//   27                          { " 1V ",    0,   1024,   -6,   1024,   40000},
//   28                          { " 2V ",   -2,   1024,   -6,   1024,   80000},
//   29                          { " 5V ",   -1,   1024,   -6,   1024,  200000},
//   30                          { "!10V!",   0,   1024,   -6,   1024,  400000}};
//   31   
//   32 const X_attr X_ATTR[27] ={
X_ATTR:
        DC8 "! 1S !"
        DC8 0
        DC16 999, 2399, 1200, 1024
        DC32 33333333
        DC8 "500mS"
        DC8 0, 0
        DC16 999, 1199, 600, 1024
        DC32 16666667
        DC8 "200mS"
        DC8 0, 0
        DC16 999, 479, 240, 1024
        DC32 6666667
        DC8 "100mS"
        DC8 0, 0
        DC16 999, 239, 120, 1024
        DC32 3333333
        DC8 "!50mS!"
        DC8 0
        DC16 999, 119, 60, 1024
        DC32 1666667
        DC8 "!20mS!"
        DC8 0
        DC16 99, 479, 240, 1024
        DC32 666667
        DC8 "!10mS!"
        DC8 0
        DC16 99, 239, 120, 1024
        DC32 333333
        DC8 " 5mS "
        DC8 0, 0
        DC16 99, 119, 60, 1024
        DC32 166667
        DC8 " 2mS "
        DC8 0, 0
        DC16 9, 479, 240, 1024
        DC32 66667
        DC8 " 1mS "
        DC8 0, 0
        DC16 9, 239, 120, 1024
        DC32 33333
        DC8 "500uS"
        DC8 0, 0
        DC16 9, 119, 60, 1024
        DC32 16667
        DC8 "200uS"
        DC8 0, 0
        DC16 0, 479, 240, 1024
        DC32 6667
        DC8 "100uS"
        DC8 0, 0
        DC16 0, 239, 120, 1024
        DC32 3333
        DC8 "!50uS!"
        DC8 0
        DC16 0, 119, 60, 1024
        DC32 1667
        DC8 "!20uS!"
        DC8 0
        DC16 0, 47, 24, 1024
        DC32 667
        DC8 "!10uS!"
        DC8 0
        DC16 0, 23, 12, 1024
        DC32 333
        DC8 " 5uS "
        DC8 0, 0
        DC16 0, 11, 6, 1024
        DC32 167
        DC8 " 2uS "
        DC8 0, 0
        DC16 0, 4, 3, 983
        DC32 67
        DC8 " 1uS "
        DC8 0, 0
        DC16 0, 2, 2, 819
        DC32 33
        DC8 "0.5uS"
        DC8 0, 0
        DC16 0, 1, 1, 614
        DC32 17
        DC8 "0.2uS"
        DC8 0, 0
        DC16 0, 0, 1, 492
        DC32 7
        DC8 "0.1uS"
        DC8 0, 0
        DC16 0, 0, 1, 246
        DC32 3
        DC8 " 2uS+"
        DC8 0, 0
        DC16 0, 9, 3, 983
        DC32 67
        DC8 " 1uS+"
        DC8 0, 0
        DC16 0, 4, 2, 983
        DC32 33
        DC8 ".5uS+"
        DC8 0, 0
        DC16 0, 2, 1, 819
        DC32 17
        DC8 ".2uS+"
        DC8 0, 0
        DC16 0, 1, 1, 983
        DC32 7
        DC8 ".1uS+"
        DC8 0, 0
        DC16 0, 0, 1, 491
        DC32 3
//   33 //   STR      PSC      ARR      CCR    KP     SCALE
//   34   {"! 1S !", 1000-1,  2400-1,  1200,  1024, 33333333},
//   35   {"500mS",  1000-1,  1200-1,   600,  1024, 16666667}, 
//   36   {"200mS",  1000-1,   480-1,   240,  1024,  6666667}, 
//   37   {"100mS",  1000-1,   240-1,   120,  1024,  3333333},
//   38   {"!50mS!", 1000-1,   120-1,    60,  1024,  1666667}, 
//   39   {"!20mS!",  100-1,   480-1,   240,  1024,   666667}, 
//   40   {"!10mS!",  100-1,   240-1,   120,  1024,   333333}, 
//   41   {" 5mS ",   100-1,   120-1,    60,  1024,   166667},
//   42   {" 2mS ",    10-1,   480-1,   240,  1024,    66667}, 
//   43   {" 1mS ",    10-1,   240-1,   120,  1024,    33333},   
//   44   {"500uS",    10-1,   120-1,    60,  1024,    16667}, 
//   45   {"200uS",     1-1,   480-1,   240,  1024,     6667},
//   46   {"100uS",     1-1,   240-1,   120,  1024,     3333}, 
//   47   {"!50uS!",    1-1,   120-1,    60,  1024,     1667}, 
//   48   {"!20uS!",    1-1,    48-1,    24,  1024,      667},      
//   49   {"!10uS!",    1-1,    24-1,    12,  1024,      333},      
//   50   {" 5uS ",     1-1,    12-1,     6,  1024,      167},       
//   51   {" 2uS ",     1-1,     5-1,     3,   983,       67}, //1024*4.8/5 =983
//   52   {" 1uS ",     1-1,     3-1,     2,   819,       33}, //1024*2.4/3 =819 
//   53   {"0.5uS",     1-1,     2-1,     1,   614,       17}, //1024*1.2/2 =614
//   54   {"0.2uS",     1-1,     1-1,     1,   492,        7}, //1024*0.48  =492
//   55   {"0.1uS",     1-1,     1-1,     1,   246,        3}, //1024*0.24  =246 
//   56   {" 2uS+",     1-1,    10-1,     3,   983,       67}, //1024*9.6/10=983
//   57   {" 1uS+",     1-1,     5-1,     2,   983,       33}, //1024*4.8/5 =983
//   58   {".5uS+",     1-1,     3-1,     1,   819,       17}, //1024*2.4/3 =819
//   59   {".2uS+",     1-1,     2-1,     1,   983,        7}, //1024*0.96  =983
//   60   {".1uS+",     1-1,     1-1,     1,   491,        3}};//1024*0.48  =492
//   61 
//   62 const T_attr T_ATTR[32] ={
T_ATTR:
        DC8 "<Vt"
        DC8 0, 0, 0, 0, 0, 0
        DC8 "<Vt"
        DC8 0, 0, 0, 0, 1, 2
        DC8 "<Vt"
        DC8 0, 0, 0, 0, 2, 4
        DC8 "<Vt"
        DC8 0, 0, 0, 0, 3, 6
        DC8 ">Vt"
        DC8 0, 0, 0, 0, 0, 1
        DC8 ">Vt"
        DC8 0, 0, 0, 0, 1, 3
        DC8 ">Vt"
        DC8 0, 0, 0, 0, 2, 5
        DC8 ">Vt"
        DC8 0, 0, 0, 0, 3, 7
        DC8 ":!\\!"
        DC8 0, 0, 0, 0, 8
        DC8 ":!\\!"
        DC8 0, 0, 0, 1, 10
        DC8 ":!\\!"
        DC8 0, 0, 0, 2, 12
        DC8 ":!\\!"
        DC8 0, 0, 0, 3, 14
        DC8 ":!^!"
        DC8 0, 0, 0, 0, 9
        DC8 ":!^!"
        DC8 0, 0, 0, 1, 11
        DC8 ":!^!"
        DC8 0, 0, 0, 2, 13
        DC8 ":!^!"
        DC8 0, 0, 0, 3, 15
        DC8 "<TL"
        DC8 0, 0, 0, 0, 0, 16
        DC8 "<TL"
        DC8 0, 0, 0, 0, 1, 18
        DC8 "<TL"
        DC8 0, 0, 0, 0, 2, 20
        DC8 "<TL"
        DC8 0, 0, 0, 0, 3, 22
        DC8 ">TL"
        DC8 0, 0, 0, 0, 0, 17
        DC8 ">TL"
        DC8 0, 0, 0, 0, 1, 19
        DC8 ">TL"
        DC8 0, 0, 0, 0, 2, 21
        DC8 ">TL"
        DC8 0, 0, 0, 0, 3, 23
        DC8 "<TH"
        DC8 0, 0, 0, 0, 0, 24
        DC8 "<TH"
        DC8 0, 0, 0, 0, 1, 26
        DC8 "<TH"
        DC8 0, 0, 0, 0, 2, 28
        DC8 "<TH"
        DC8 0, 0, 0, 0, 3, 30
        DC8 ">TH"
        DC8 0, 0, 0, 0, 0, 25
        DC8 ">TH"
        DC8 0, 0, 0, 0, 1, 27
        DC8 ">TH"
        DC8 0, 0, 0, 0, 2, 29
        DC8 ">TH"
        DC8 0, 0, 0, 0, 3, 31
//   63 //  STR   CHx  CMD    STR   CHx  CMD    STR   CHx  CMD    STR   CHx  CMD
//   64   {"<Vt",  0, 0x00},{"<Vt",  1, 0x02},{"<Vt",  2, 0x04},{"<Vt",  3, 0x06},
//   65   {">Vt",  0, 0x01},{">Vt",  1, 0x03},{">Vt",  2, 0x05},{">Vt",  3, 0x07}, 
//   66   {":!\\!",0, 0x08},{":!\\!",1, 0x0A},{":!\\!",2, 0x0C},{":!\\!",3, 0x0E}, 
//   67   {":!^!", 0, 0x09},{":!^!", 1, 0x0B},{":!^!", 2, 0x0D},{":!^!", 3, 0x0F},
//   68   {"<TL",  0, 0x10},{"<TL",  1, 0x12},{"<TL",  2, 0x14},{"<TL",  3, 0x16},
//   69   {">TL",  0, 0x11},{">TL",  1, 0x13},{">TL",  2, 0x15},{">TL",  3, 0x17}, 
//   70   {"<TH",  0, 0x18},{"<TH",  1, 0x1A},{"<TH",  2, 0x1C},{"<TH",  3, 0x1E},   
//   71   {">TH",  0, 0x19},{">TH",  1, 0x1B},{">TH",  2, 0x1D},{">TH",  3, 0x1F}};  
//   72 
//   73 /*******************************************************************************
//   74  Set:  硬件控制设备设置
//   75 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Set
        THUMB
//   76 u32 Set(u8 Object, u32 Value)
//   77 {
Set:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
        MOVS     R5,R0
        MOVS     R4,R1
//   78   switch (Object){  
        CMP      R0,#+39
        BHI.W    ??Set_3
        TBH      [PC, R0, LSL #+1]
        DATA
??Set_0:
        DC16     +40,+65,+90,+95
        DC16     +103,+112,+125,+152
        DC16     +156,+198,+219,+209
        DC16     +367,+556,+578,+581
        DC16     +584,+601,+605,+633
        DC16     +636,+730,+730,+730
        DC16     +730,+730,+730,+730
        DC16     +730,+730,+730,+654
        DC16     +717,+717,+720,+730
        DC16     +717,+717,+717,+717
        THUMB
//   79   case CH_A_OFFSET:  if(Value < 65536){
??Set_4:
        CMP      R4,#+65536
        BCS.N    ??Set_5
//   80                        TIM5_ARR = 470; TIM5_CCR1 = 450 - Value; // Value = 0~200
        LDR.W    R0,??Set_6       ;; 0x40000410
        MOV      R1,#+470
        STR      R1,[R0, #+2076]
        RSB      R0,R4,#+450
        LDR.W    R1,??Set_6       ;; 0x40000410
        STR      R0,[R1, #+2084]
        B.N      ??Set_3
//   81                      } else {
//   82                        TIM5_ARR = Value >>16; TIM5_CCR1 = Value & 0xFFFF;
??Set_5:
        LDR.W    R0,??Set_6       ;; 0x40000410
        LSRS     R1,R4,#+16
        STR      R1,[R0, #+2076]
        UXTH     R1,R4
        STR      R1,[R0, #+2084]
        B.N      ??Set_3
//   83                      } break;
//   84   case CH_B_OFFSET:  if(Value < 65536){
??Set_7:
        CMP      R4,#+65536
        BCS.N    ??Set_8
//   85                        TIM5_ARR = 470; TIM5_CCR2 = 450 - Value; // Value = 0~200
        LDR.W    R0,??Set_6       ;; 0x40000410
        MOV      R1,#+470
        STR      R1,[R0, #+2076]
        RSB      R0,R4,#+450
        LDR.W    R1,??Set_6       ;; 0x40000410
        STR      R0,[R1, #+2088]
        B.N      ??Set_3
//   86                      } else {
//   87                        TIM5_ARR = Value >>16; TIM5_CCR2 = Value & 0xFFFF;
??Set_8:
        LDR.W    R0,??Set_6       ;; 0x40000410
        LSRS     R1,R4,#+16
        STR      R1,[R0, #+2076]
        UXTH     R1,R4
        STR      R1,[R0, #+2088]
        B.N      ??Set_3
//   88                      } break;
//   89   case BACKLIGHT:    TIM8_CCR1 = Value;                         // Value = 0~100
??Set_9:
        LDR.W    R0,??Set_6+0x4   ;; 0x40012c00
        STR      R4,[R0, #+2100]
        B.N      ??Set_3
//   90                      break;
//   91   case BEEP_VOLUME:  TIM8_CCR2 = 100 - Value/2;                 // Value = 0~50
??Set_10:
        MOVS     R0,#+100
        SUB      R0,R0,R4, LSR #+1
        LDR.W    R1,??Set_6+0x4   ;; 0x40012c00
        STR      R0,[R1, #+2104]
        B.N      ??Set_3
//   92                      break;
//   93   case BETTERY_DT:   ADC3_CR2 |= (Value & 1)<<22;  // Value = 1/0   ADC3_CR2 |=0x00400000;
??Set_11:
        LDR.W    R0,??Set_6+0x8   ;; 0x40013c08
        LDR      R1,[R0, #+0]
        AND      R2,R4,#0x1
        ORR      R1,R1,R2, LSL #+22
??Set_12:
        STR      R1,[R0, #+0]
        B.N      ??Set_3
//   94                      break;
//   95   case ADC_MODE:     if(Value == SEPARATE) FIFO_MODE_LOW();  
??Set_13:
        CBNZ     R4,??Set_14
        LDR.W    R0,??Set_6+0xC   ;; 0x40010800
        MOVS     R1,#+8
        STR      R1,[R0, #+2068]
        B.N      ??Set_3
//   96                      else                  FIFO_MODE_HIGH();  break;
??Set_14:
        LDR.W    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOVS     R1,#+8
        B.N      ??Set_12
//   97   case FIFO_CLR:     if(Value == W_PTR){FIFO_CLRW_HIGH();  FIFO_CLRW_LOW();}
??Set_15:
        CMP      R4,#+1
        BNE.N    ??Set_16
        LDR.W    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+1040
        MOVS     R1,#+2
        STR      R1,[R0, #+0]
        LDR.W    R0,??Set_6+0xC   ;; 0x40010800
        STR      R1,[R0, #+1044]
        B.N      ??Set_3
//   98                      if(Value == R_PTR){FIFO_CLRR_HIGH();  FIFO_CLRR_LOW();} break;
??Set_16:
        CMP      R4,#+0
        BNE.W    ??Set_3
        LDR.W    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOVS     R1,#+16
        STR      R1,[R0, #+0]
        LDR.W    R0,??Set_6+0xC   ;; 0x40010800
        STR      R1,[R0, #+2068]
        B.N      ??Set_3
//   99   case T_BASE_PSC:   TIM1_PSC  = Value;
??Set_17:
        LDR.W    R0,??Set_6+0x4   ;; 0x40012c00
        STR      R4,[R0, #+40]
        B.N      ??Set_3
//  100                      break;
//  101   case T_BASE_ARR:   if(Value==0)      {TIM1_CCER=0; RCC_CFGR=0x041D8402;} // MCO as SYSCLK  
??Set_18:
        CBNZ     R4,??Set_19
        LDR.W    R0,??Set_6+0x4   ;; 0x40012c00
        MOVS     R1,#+0
        STR      R1,[R0, #+32]
        LDR.W    R0,??Set_6+0x10  ;; 0x40020448
        LDR.W    R1,??Set_6+0x14  ;; 0x41d8402
        STR      R1,[R0, #+3004]
        B.N      ??Set_3
//  102                      else if(Value==1) {TIM1_CCER=0; RCC_CFGR=0x071D8402;} // MCO as SYSCLK/2 
??Set_19:
        CMP      R4,#+1
        BNE.N    ??Set_20
        LDR.W    R0,??Set_6+0x4   ;; 0x40012c00
        MOVS     R1,#+0
        STR      R1,[R0, #+32]
        LDR.W    R0,??Set_6+0x10  ;; 0x40020448
        LDR.W    R1,??Set_6+0x18  ;; 0x71d8402
        STR      R1,[R0, #+3004]
        B.N      ??Set_3
//  103                      else  {RCC_CFGR=0x001D8402;  TIM1_CCER=0x0003;        // MCO as OC1 
??Set_20:
        LDR.W    R0,??Set_6+0x10  ;; 0x40020448
        LDR.W    R1,??Set_6+0x1C  ;; 0x1d8402
        STR      R1,[R0, #+3004]
        LDR.W    R0,??Set_6+0x4   ;; 0x40012c00
        MOVS     R1,#+3
        STR      R1,[R0, #+32]
//  104                             TIM1_ARR=Value;  TIM1_CCR1=(Value+1)/2;}
        STR      R4,[R0, #+44]
        ADDS     R0,R4,#+1
        LSRS     R0,R0,#+1
        LDR.W    R1,??Set_6+0x4   ;; 0x40012c00
        STR      R0,[R1, #+52]
        B.N      ??Set_3
//  105                      break;
//  106   case CH_A_COUPLE:  if(Value == AC ) AC_1();  else DC_1();
??Set_21:
        CMP      R4,#+1
        BNE.N    ??Set_22
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+1
??Set_23:
        STR      R1,[R0, #+4]
        B.N      ??Set_3
??Set_22:
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+1
        B.N      ??Set_12
//  107                      break;
//  108   case CH_B_COUPLE:  if(Value == AC ) AC_2();  else DC_2();
??Set_24:
        CMP      R4,#+1
        BNE.N    ??Set_25
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+32
        B.N      ??Set_23
??Set_25:
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+32
        B.N      ??Set_12
//  109                      break;
//  110   case CH_A_RANGE:
//  111     switch (Value){  
??Set_26:
        CMP      R4,#+8
        BHI.W    ??Set_3
        TBH      [PC, R4, LSL #+1]
        DATA
??Set_1:
        DC16     +9,+24,+40,+55
        DC16     +73,+89,+104,+120
        DC16     +130
        THUMB
//  112     case _50MV:  Ax0_ON();  Ax1_ON();  Ax2_HIGH(); Ax5_HIGH();
??Set_27:
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+0]
        LDR.W    R1,??Set_6+0xC   ;; 0x40010800
        ADD      R1,R1,#+1040
        MOV      R2,#+512
        STR      R2,[R1, #+0]
        MOVS     R1,#+4
        STR      R1,[R0, #+0]
        MOVS     R1,#+8
        B.N      ??Set_12
//  113                  break;
//  114     case _100MV:  Ax0_ON();  Ax1_ON();  Ax2_LOW();  Ax5_HIGH();    
??Set_28:
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+0]
        LDR.W    R1,??Set_6+0xC   ;; 0x40010800
        ADD      R1,R1,#+1040
        MOV      R2,#+512
        STR      R2,[R1, #+0]
        MOVS     R2,#+4
        STR      R2,[R0, #+4]
??Set_29:
        MOVS     R1,#+8
??Set_30:
        STR      R1,[R0, #+0]
        B.N      ??Set_3
//  115                  break;
//  116     case _200MV: Ax0_ON();  Ax1_ON();  Ax2_HIGH(); Ax5_LOW();
??Set_31:
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+0]
        LDR.W    R1,??Set_6+0xC   ;; 0x40010800
        ADD      R1,R1,#+1040
        MOV      R2,#+512
        STR      R2,[R1, #+0]
        MOVS     R1,#+4
        STR      R1,[R0, #+0]
        MOVS     R1,#+8
        B.N      ??Set_23
//  117                  break;
//  118     case _500MV: Ax0_ON();  Ax1_ON();  Ax2_LOW();  Ax5_LOW(); 
??Set_32:
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+0]
        LDR.W    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+1040
        MOV      R1,#+512
        STR      R1,[R0, #+0]
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
??Set_33:
        MOVS     R1,#+4
        STR      R1,[R0, #+4]
        MOVS     R1,#+8
        STR      R1,[R0, #+4]
        B.N      ??Set_3
//  119                  break;
//  120     case _1V: Ax0_OFF(); Ax1_OFF(); Ax2_HIGH(); Ax5_HIGH(); 
??Set_34:
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+4]
        LDR.W    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+512
        STR      R1,[R0, #+1044]
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+4
        STR      R1,[R0, #+0]
        MOVS     R1,#+8
        B.N      ??Set_12
//  121                  break;
//  122     case _2V:    Ax0_OFF(); Ax1_OFF(); Ax2_LOW();  Ax5_HIGH();
??Set_35:
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+4]
        LDR.W    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+512
        STR      R1,[R0, #+1044]
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+4
        STR      R1,[R0, #+4]
        B.N      ??Set_29
//  123                  break;
//  124     case _5V:    Ax0_OFF(); Ax1_OFF(); Ax2_HIGH(); Ax5_LOW(); 
??Set_36:
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+4]
        LDR.W    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+512
        STR      R1,[R0, #+1044]
        LDR.W    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+4
        STR      R1,[R0, #+0]
        MOVS     R1,#+8
        B.N      ??Set_23
//  125                  break;
//  126     case _10V:    Ax0_OFF(); Ax1_OFF(); Ax2_LOW();  Ax5_LOW();  
??Set_37:
        LDR.N    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+4]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+512
        STR      R1,[R0, #+1044]
        LDR.N    R0,??Set_6+0x20  ;; 0x40011810
        B.N      ??Set_33
//  127                  break;
//  128     case CH_B:   Ax0_ON(); Ax1_OFF();  Ax2_LOW();  Ax5_LOW();
??Set_38:
        LDR.N    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+512
        STR      R1,[R0, #+1044]
        LDR.N    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+4
        STR      R1,[R0, #+4]
        MOVS     R1,#+8
        B.N      ??Set_23
//  129                  break;
//  130     }  break;
//  131     
//  132   case CH_B_RANGE:
//  133     switch (Value){  
??Set_39:
        CMP      R4,#+8
        BHI.W    ??Set_3
        TBH      [PC, R4, LSL #+1]
        DATA
??Set_2:
        DC16     +9,+30,+49,+70
        DC16     +89,+109,+127,+147
        DC16     +165
        THUMB
//  134     case _50MV:  Bx0_ON();  Bx1_ON();  Bx2_HIGH(); Bx5_HIGH();
??Set_40:
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+8192
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+16384
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+32768
        B.N      ??Set_12
//  135                  break;
//  136     case _100MV:  Bx0_ON();  Bx1_ON();  Bx2_LOW();  Bx5_HIGH();
??Set_41:
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+8192
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+16384
        STR      R1,[R0, #+2068]
        ADD      R0,R0,#+2064
        MOV      R1,#+32768
        B.N      ??Set_30
//  137                  break;
//  138     case _200MV: Bx0_ON();  Bx1_ON();  Bx2_HIGH();  Bx5_LOW();
??Set_42:
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+8192
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+16384
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+32768
        STR      R1,[R0, #+2068]
        B.N      ??Set_3
//  139                  break;
//  140     case _500MV: Bx0_ON();  Bx1_ON();  Bx2_LOW();  Bx5_LOW();
??Set_43:
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+8192
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+16384
        STR      R1,[R0, #+2068]
        MOV      R1,#+32768
        STR      R1,[R0, #+2068]
        B.N      ??Set_3
//  141                  break;
//  142     case _1V: Bx0_OFF(); Bx1_OFF(); Bx2_HIGH(); Bx5_HIGH();
??Set_44:
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+8192
        STR      R1,[R0, #+2068]
        LDR.N    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+4]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+16384
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+32768
        B.N      ??Set_12
//  143                  break;
//  144     case _2V:    Bx0_OFF(); Bx1_OFF(); Bx2_LOW();  Bx5_HIGH();
??Set_45:
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+8192
        STR      R1,[R0, #+2068]
        LDR.N    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+4]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+16384
        STR      R1,[R0, #+2068]
        ADD      R0,R0,#+2064
        MOV      R1,#+32768
        B.N      ??Set_30
//  145                  break;
//  146     case _5V:    Bx0_OFF(); Bx1_OFF(); Bx2_HIGH();  Bx5_LOW();
??Set_46:
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+8192
        STR      R1,[R0, #+2068]
        LDR.N    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+4]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+16384
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+32768
        STR      R1,[R0, #+2068]
        B.N      ??Set_3
//  147                  break;
//  148     case _10V:    Bx0_OFF(); Bx1_OFF(); Bx2_LOW(); Bx5_LOW();
??Set_47:
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+8192
        STR      R1,[R0, #+2068]
        LDR.N    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+4]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+16384
        STR      R1,[R0, #+2068]
        MOV      R1,#+32768
        STR      R1,[R0, #+2068]
        B.N      ??Set_3
//  149                  break;
//  150     case CH_A:   Bx0_ON(); Bx1_OFF();  Bx2_LOW();  Bx5_LOW();
??Set_48:
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+8192
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+4]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+16384
        STR      R1,[R0, #+2068]
        MOV      R1,#+32768
        STR      R1,[R0, #+2068]
        B.N      ??Set_3
//  151                  break;
//  152     }  break;
//  153     
//  154   case ANALOG_ARR:  GPIOB_CRL = 0x34BBB438;  TIM4_CR1 = 0x0080;  // SQR_OUT = Disnable  
??Set_49:
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+1024
        LDR.N    R1,??Set_6+0x24  ;; 0x34bbb438
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6       ;; 0x40000410
        MOVS     R1,#+128
        STR      R1,[R0, #+1008]
//  155                     GPIOA_CRL   = 0x111011BB;  DAC_CR = 0x0001;  // DAC = Ensable 
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        LDR.N    R1,??Set_6+0x28  ;; 0x111011bb
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0x2C  ;; 0x40007400
        MOVS     R1,#+1
        STR      R1,[R0, #+0]
//  156                     TIM7_ARR = Value;  TIM7_CR1 = 0x0085;  break;// DAC_CLK = Enable
        LDR.N    R0,??Set_6+0x30  ;; 0x4000142c
        STR      R4,[R0, #+0]
        LDR.N    R0,??Set_6       ;; 0x40000410
        ADD      R0,R0,#+4080
        MOVS     R1,#+133
        B.N      ??Set_12
//  157   case ANALOG_PTR:  DMA2_CMAR4  = Value;
??Set_50:
        LDR.N    R0,??Set_6+0x10  ;; 0x40020448
        STR      R4,[R0, #+8]
        B.N      ??Set_3
//  158                     break;
//  159   case ANALOG_CNT:  DMA2_CNDTR4 = Value;       // Fout = (Cnt*(ARR+1)/72)KHz
??Set_51:
        LDR.N    R0,??Set_6+0x10  ;; 0x40020448
        STR      R4,[R0, #+0]
        B.N      ??Set_3
//  160                     break;
//  161   case DIGTAL_PSC:  TIM4_PSC = Value; GPIOA_CRL  |= 0x40000;  // DAC_OUT = Disnable
??Set_52:
        LDR.N    R0,??Set_6       ;; 0x40000410
        ADD      R0,R0,#+1048
        STR      R4,[R0, #+0]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x40000
        STR      R1,[R0, #+0]
//  162                     TIM7_CR1 = 0x0084;  DAC_CR = 0;  break;   // DAC = Disnable
        LDR.N    R0,??Set_6       ;; 0x40000410
        ADD      R0,R0,#+4080
        MOVS     R1,#+132
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_6+0x2C  ;; 0x40007400
        MOVS     R1,#+0
        B.N      ??Set_12
//  163   case DIGTAL_ARR:  TIM4_ARR    = Value;
??Set_53:
        LDR.N    R0,??Set_6       ;; 0x40000410
        STR      R4,[R0, #+1052]
        B.N      ??Set_3
//  164                     break;
//  165   case DIGTAL_CCR:  GPIOB_CRL &= 0xF0FFFFFF;  GPIOB_CRL |= 0x0B000000; // PORT_SQR = Enable
??Set_54:
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+1024
        LDR      R0,[R0, #+0]
        MVN      R1,#+251658240
        ANDS     R0,R1,R0
        LDR.N    R1,??Set_6+0xC   ;; 0x40010800
        ADD      R1,R1,#+1024
        STR      R0,[R1, #+0]
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+1024
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0xB000000
        LDR.N    R1,??Set_6+0xC   ;; 0x40010800
        ADD      R1,R1,#+1024
        STR      R0,[R1, #+0]
//  166                     TIM4_CCR1 = Value;  TIM4_CR1 = 0x0081; break;      // SQR_OUT = Enable 
        LDR.N    R0,??Set_6       ;; 0x40000410
        STR      R4,[R0, #+1060]
        MOVS     R1,#+129
        STR      R1,[R0, #+1008]
        B.N      ??Set_3
//  167   case KEY_IF_RST:  TIM3_SR = 0;               //Clear TIM3 interrupt flag
??Set_55:
        LDR.N    R0,??Set_6       ;; 0x40000410
        MOVS     R1,#+0
        B.N      ??Set_12
//  168                     break;
//  169   case STANDBY:     if(Value == 1) { STB_EN();}  else { STB_DN();}   
??Set_56:
        LDR.N    R0,??Set_6+0x4   ;; 0x40012c00
        CMP      R4,#+1
        BNE.N    ??Set_57
        LDR.N    R1,??Set_6+0xC   ;; 0x40010800
        MOV      R2,#+8192
        STR      R2,[R1, #+3092]
        MOVS     R1,#+132
        B.N      ??Set_30
??Set_57:
        LDR.N    R1,??Set_6+0xC   ;; 0x40010800
        ADD      R1,R1,#+3088
        MOV      R2,#+8192
        STR      R2,[R1, #+0]
        MOVS     R1,#+133
        B.N      ??Set_12
//  170                     break;
//  171                     
//  172   case FPGA_RST:    GPIOB_CRH &= 0xF0FFFFFF;  GPIOB_CRH |= 0x01000000;        // 设PB14为输出状态
??Set_58:
        MVN      R4,#+251658240
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        LDR      R0,[R0, #+1028]
        ANDS     R0,R4,R0
        LDR.N    R1,??Set_6+0xC   ;; 0x40010800
        STR      R0,[R1, #+1028]
        LDR      R0,[R1, #+1028]
        ORR      R0,R0,#0x1000000
        STR      R0,[R1, #+1028]
//  173                     SPI_CRST_LOW(); Delayms(1);   // SPI_CRST_LOW 1mS
        MOV      R0,R1
        MOV      R1,#+16384
        STR      R1,[R0, #+1044]
        MOVS     R0,#+1
        BL       Delayms
//  174                     SPI_SS_HIGH(); Delayms(1);     // SPI_SS_HIGH  1mS
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+1040
        MOV      R1,#+1024
        STR      R1,[R0, #+0]
        MOVS     R0,#+1
        BL       Delayms
//  175                     SPI_SS_LOW(); Delayms(1);      // SPI_SS_LOW   1mS
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        MOV      R1,#+1024
        STR      R1,[R0, #+1044]
        MOVS     R0,#+1
        BL       Delayms
//  176                     SPI_CRST_HIGH(); Delayms(2);   // SPI_CRST_HIGH 2mS
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        ADD      R0,R0,#+1040
        MOV      R1,#+16384
        STR      R1,[R0, #+0]
        MOVS     R0,#+2
        BL       Delayms
//  177                     GPIOB_CRH &= 0xF0FFFFFF;  GPIOB_CRH |= 0x08000000; break; // 设PB14为输入状态 
        LDR.N    R0,??Set_6+0xC   ;; 0x40010800
        LDR      R0,[R0, #+1028]
        ANDS     R0,R4,R0
        LDR.N    R1,??Set_6+0xC   ;; 0x40010800
        STR      R0,[R1, #+1028]
        LDR      R0,[R1, #+1028]
        ORR      R0,R0,#0x8000000
        STR      R0,[R1, #+1028]
        B.N      ??Set_3
//  178 
//  179   case TRIGG_MODE:  Set_Param(Object, Value);             
??Set_59:
        UXTB     R1,R4
        MOVS     R0,R5
        B.N      ??Set_60
//  180                     break; 
//  181   case V_THRESHOLD: Set_Param(Object, Value);          
//  182                     break;    
//  183   case T_THRESHOLD: Set_Param(Object, Value & 0xFF);            
??Set_61:
        UXTB     R1,R4
        MOVS     R0,R5
        BL       Set_Param
//  184                     Set_Param(Object +1, Value >> 8);  break;
        LSRS     R1,R4,#+8
        UXTB     R1,R1
        ADDS     R0,R5,#+1
        UXTB     R0,R0
??Set_60:
        BL       Set_Param
//  185   case ADC_CTRL:    Set_Param(Object, Value);               
//  186                     break;
//  187   case A_POSITION:  Set_Param(Object, Value);              
//  188                     break; 
//  189   case B_POSITION:  Set_Param(Object, Value);              
//  190                     break; 
//  191   case REG_ADDR:    Set_Param(Object, Value);          
//  192                     break;    
//  193   }
//  194   return 0;
??Set_3:
        MOVS     R0,#+0
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        DATA
??Set_6:
        DC32     0x40000410
        DC32     0x40012c00
        DC32     0x40013c08
        DC32     0x40010800
        DC32     0x40020448
        DC32     0x41d8402
        DC32     0x71d8402
        DC32     0x1d8402
        DC32     0x40011810
        DC32     0x34bbb438
        DC32     0x111011bb
        DC32     0x40007400
        DC32     0x4000142c
        CFI EndBlock cfiBlock0
//  195 }
//  196 /*******************************************************************************
//  197  SendByte:  Send a byte to FPGA
//  198 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function SendByte
        THUMB
//  199 void SendByte(u8 Data) 
//  200 { 
//  201   u8 i;
//  202   
//  203   FIFO_SCK_HIGH();
SendByte:
        LDR.N    R1,??SendByte_0  ;; 0x40010810
        MOVS     R2,#+64
        STR      R2,[R1, #+0]
//  204   for(i=0; i<8; ++i){
        MOVS     R2,#+0
//  205     if((Data<<i) & 0x80) FIFO_SDA_HIGH();
??SendByte_1:
        MOVS     R3,R2
        LSL      R3,R0,R3
        TST      R3,#0x80
        BEQ.N    ??SendByte_2
        MOVS     R3,#+128
        STR      R3,[R1, #+0]
        B.N      ??SendByte_3
//  206     else                 FIFO_SDA_LOW();
??SendByte_2:
        MOV      R12,#+128
        STR      R12,[R1, #+4]
//  207     FIFO_SCK_LOW();
??SendByte_3:
        MOV      R12,#+64
        STR      R12,[R1, #+4]
//  208     FIFO_SCK_HIGH();
        MOVS     R3,#+64
        STR      R3,[R1, #+0]
//  209   }  
        ADDS     R2,R2,#+1
        UXTB     R3,R2
        CMP      R3,#+8
        BCC.N    ??SendByte_1
//  210   FIFO_SDA_LOW();
        MOVS     R2,#+128
        STR      R2,[R1, #+4]
//  211   FIFO_SCK_LOW();
        MOVS     R2,#+64
        STR      R2,[R1, #+4]
//  212   FIFO_SDA_HIGH(); // Send data to buffer
        MOVS     R0,#+128
        STR      R0,[R1, #+0]
//  213 }
        BX       LR               ;; return
        DATA
??SendByte_0:
        DC32     0x40010810
        CFI EndBlock cfiBlock1
//  214 /*******************************************************************************
//  215  Set_Param: Trigger control Parameter Set 
//  216 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Set_Param
        THUMB
//  217 void Set_Param(u8 RegAddr, u8 Parameter) 
//  218 {
Set_Param:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        MOVS     R4,R1
//  219   RegAddr &= 0x1F;
//  220   FIFO_H_L_HIGH();
        LDR.N    R1,??Set_Param_0  ;; 0x40011010
        MOVS     R2,#+32
        STR      R2,[R1, #+0]
//  221   SendByte(RegAddr);
        AND      R0,R0,#0x1F
        BL       SendByte
//  222   FIFO_H_L_LOW();
        LDR.N    R0,??Set_Param_0  ;; 0x40011010
        MOVS     R1,#+32
        STR      R1,[R0, #+4]
//  223   SendByte(Parameter);
        MOVS     R0,R4
        POP      {R4,LR}
        CFI R4 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.N      SendByte
        DATA
??Set_Param_0:
        DC32     0x40011010
        CFI EndBlock cfiBlock2
//  224 }
//  225 /*******************************************************************************
//  226  Get: Get hardware attribute & status
//  227 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Get
        THUMB
//  228 u32 Get(u8 Object, u32 Value)
//  229 {
Get:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOVS     R4,R1
//  230   u16 Data;
//  231   u8* Ver;
//  232   
//  233   switch (Object){  
        CMP      R0,#+16
        BHI.W    ??Get_1
        TBB      [PC, R0]
        DATA
??Get_0:
        DC8      +9,+28,+17,+39
        DC8      +50,+113,+120,+127
        DC8      +129,+131,+133,+135
        DC8      +141,+171,+151,+177
        DC8      +192,+0
        THUMB
//  234     
//  235   case FIFO_DIGIT:  FIFO_H_L_LOW();  return (*(vu16 *)0x64000000); // 16bits FIFO Digital data
??Get_2:
        LDR.N    R0,??Get_3       ;; 0x40010808
        MOVS     R1,#+32
        STR      R1,[R0, #+2060]
        MOV      R0,#+1677721600
        LDRH     R0,[R0, #+0]
        POP      {R4-R6,PC}
//  236 
//  237   case FIFO_START:  FIFO_H_L_LOW();  return ((*(vu16 *)0x64000000)& 0x04)>> 2;    // Start = Bit2
??Get_4:
        LDR.N    R0,??Get_3       ;; 0x40010808
        MOVS     R1,#+32
        STR      R1,[R0, #+2060]
        MOV      R0,#+1677721600
        LDRH     R0,[R0, #+0]
        AND      R0,R0,#0x4
??Get_5:
        LSRS     R0,R0,#+2
        POP      {R4-R6,PC}
//  238 
//  239   case FIFO_EMPTY:  FIFO_H_L_LOW();  return ((*(vu16 *)0x64000000)& 0x10)>> 4;    // Empty = Bit4
??Get_6:
        LDR.N    R0,??Get_3       ;; 0x40010808
        MOVS     R1,#+32
        STR      R1,[R0, #+2060]
        MOV      R0,#+1677721600
        LDRH     R0,[R0, #+0]
        AND      R0,R0,#0x10
        LSRS     R0,R0,#+4
        POP      {R4-R6,PC}
//  240 
//  241   case FIFO_FULL:   FIFO_H_L_LOW();  return ((*(vu16 *)0x64000000)& 0x08)>> 3;    // Full = Bit3
??Get_7:
        LDR.N    R0,??Get_3       ;; 0x40010808
        MOVS     R1,#+32
        STR      R1,[R0, #+2060]
        MOV      R0,#+1677721600
        LDRH     R0,[R0, #+0]
        AND      R0,R0,#0x8
        LSRS     R0,R0,#+3
        POP      {R4-R6,PC}
//  242 
//  243   case KEY_STATUS:  Data  =(GPIOA_IDR & 0x4000);    Data |=(GPIOC_IDR & 0x0400)<<3; // K1, K2
??Get_8:
        LDR.N    R0,??Get_3       ;; 0x40010808
        LDR      R1,[R0, #+0]
        AND      R1,R1,#0x4000
        ADD      R2,R0,#+2048
        LDR      R2,[R2, #+0]
        AND      R2,R2,#0x400
        ORR      R1,R1,R2, LSL #+3
//  244                     Data |=(GPIOC_IDR & 0x0200)>>1; Data |=(GPIOC_IDR & 0x0100)<<1; // K3, K4
        ADD      R2,R0,#+2048
        LDR      R2,[R2, #+0]
        AND      R2,R2,#0x200
        ORR      R1,R1,R2, LSR #+1
        ADD      R2,R0,#+2048
        LDR      R2,[R2, #+0]
        AND      R2,R2,#0x100
        ORR      R1,R1,R2, LSL #+1
//  245                     Data |=(GPIOA_IDR & 0x2000)>>3; Data |=(GPIOC_IDR & 0x1000)>>1; // K5, K6
        LDR      R2,[R0, #+0]
        AND      R2,R2,#0x2000
        ORR      R1,R1,R2, LSR #+3
        ADD      R2,R0,#+2048
        LDR      R2,[R2, #+0]
        AND      R2,R2,#0x1000
        ORR      R1,R1,R2, LSR #+1
//  246                     Data |=(GPIOC_IDR & 0x0800)<<1; Data |=(GPIOA_IDR & 0x8000);    // K7, K8
        ADD      R2,R0,#+2048
        LDR      R2,[R2, #+0]
        AND      R2,R2,#0x800
        ORR      R1,R1,R2, LSL #+1
        LDR      R0,[R0, #+0]
        AND      R0,R0,#0x8000
        ORRS     R0,R0,R1
//  247                     Data |=(GPIOD_IDR & 0x0008);    Data |=(GPIOD_IDR & 0x0040);    // K9, K10
        LDR.N    R1,??Get_3       ;; 0x40010808
        ADD      R1,R1,#+3072
        LDR      R1,[R1, #+0]
        AND      R1,R1,#0x8
        ORRS     R0,R1,R0
        LDR.N    R1,??Get_3       ;; 0x40010808
        ADD      R1,R1,#+3072
        LDR      R1,[R1, #+0]
        AND      R1,R1,#0x40
        ORRS     R0,R1,R0
//  248                     return Data;                              // Current keys status
        POP      {R4-R6,PC}
//  249 
//  250   case USB_POWER:   return USB_PWR_ON;               // USB power on = 1   
??Get_9:
        LDR.N    R0,??Get_3       ;; 0x40010808
        ADD      R0,R0,#+3072
        LDR      R0,[R0, #+0]
        AND      R0,R0,#0x4
        B.N      ??Get_5
//  251     
//  252   case V_BATTERY:   return (ADC3_DR*1400)/1024;      // Battery voltage (mV)  
??Get_10:
        LDR.N    R0,??Get_3+0x4   ;; 0x40013c4c
        LDR      R0,[R0, #+0]
        MOV      R1,#+1400
        MULS     R0,R0,R1
        LSRS     R0,R0,#+10
        POP      {R4-R6,PC}
//  253   
//  254   case VERTICAL:    return (u32)Y_ATTR;              // 垂直通道属性指针
??Get_11:
        LDR.N    R0,??Get_3+0x8   ;; HDW_Ver + 56
        POP      {R4-R6,PC}
//  255     
//  256   case HORIZONTAL:  return (u32)X_ATTR;              // 水平通道属性指针
??Get_12:
        LDR.N    R0,??Get_3+0xC   ;; HDW_Ver + 236
        POP      {R4-R6,PC}
//  257     
//  258   case GLOBAL:      return (u32)G_ATTR;              // 整体属性指针
??Get_13:
        LDR.N    R0,??Get_3+0x10  ;; HDW_Ver + 28
        POP      {R4-R6,PC}
//  259   
//  260     
//  261   case TRIGGER:     return (u32)T_ATTR;              // 触发通道属性指针
??Get_14:
        LDR.N    R0,??Get_3+0x14  ;; HDW_Ver + 776
        POP      {R4-R6,PC}
//  262     
//  263   case FPGA_OK:     return FPGA_CFG_OK;              // FPGA config ok = 1
??Get_15:
        LDR.N    R0,??Get_3       ;; 0x40010808
        ADD      R0,R0,#+1024
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+15
        POP      {R4-R6,PC}
//  264 
//  265   case CHARGE:      return CHRG_ST;                  // Battery charge = 1
??Get_16:
        LDR.N    R0,??Get_3       ;; 0x40010808
        ADD      R0,R0,#+1024
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+8
        AND      R0,R0,#0x1
        EOR      R0,R0,#0x1
        POP      {R4-R6,PC}
//  266 
//  267   case DFUVER:      Ver = __Chk_DFU();               // DFU固件版本信息
??Get_17:
        BL       __Chk_DFU
//  268                     if(Ver == 0)  Ver = (u8*)DFU_Ver;
        CBNZ     R0,??Get_18
        LDR.N    R0,??Get_3+0x18  ;; HDW_Ver + 20
//  269                     if(Value == 0) return (u32)Ver;
??Get_18:
        CMP      R4,#+0
        BEQ.N    ??Get_19
//  270                     else return (Ver[0]-'0')*100 +(Ver[2]-'0')*10 +(Ver[3]-'0'); 
        LDRB     R1,[R0, #+0]
        MOVS     R2,#+100
        LDRB     R3,[R0, #+2]
        MOV      R12,#+10
        MUL      R3,R3,R12
        MLA      R1,R1,R2,R3
        LDRB     R0,[R0, #+3]
        ADDS     R0,R0,R1
        LDR.N    R1,??Get_3+0x1C  ;; 0xffffeb30
??Get_20:
        ADDS     R0,R1,R0
        POP      {R4-R6,PC}
//  271   case HDWVER:      Ver = __Chk_HDW();               // 设备硬件版本信息
??Get_21:
        BL       __Chk_HDW
//  272                     if(Ver == 0)  Ver = (u8*)(HDW_Ver + 13);
        CMP      R0,#+0
        BNE.N    ??Get_18
        LDR.N    R0,??Get_3+0x20  ;; HDW_Ver + 13
        B.N      ??Get_18
//  273                     if(Value == 0) return (u32)Ver;
//  274                     else return (Ver[0]-'0')*100 +(Ver[2]-'0')*10 +(Ver[3]-'0'); 
//  275   case SYSVER:      Ver = (u8*)SYS_Ver;              // SYS程序模块版本信息
//  276                     if(Value == 0) return (u32)Ver;
??Get_22:
        LDR.N    R0,??Get_3+0x24  ;; SYS_Ver
        CBZ      R4,??Get_19
//  277                     else return (Ver[0]-'0')*100 +(Ver[2]-'0')*10 +(Ver[3]-'0'); 
        LDRB     R1,[R0, #+0]
        MOVS     R2,#+100
        LDRB     R3,[R0, #+2]
        MOV      R12,#+10
        MUL      R3,R3,R12
        MLA      R1,R1,R2,R3
        LDRB     R0,[R0, #+3]
        ADDS     R0,R0,R1
        LDR.N    R1,??Get_3+0x1C  ;; 0xffffeb30
        B.N      ??Get_20
//  278   case FPGAVER:     FIFO_H_L_LOW();  
??Get_23:
        LDR.N    R0,??Get_3       ;; 0x40010808
        MOVS     R1,#+32
        STR      R1,[R0, #+2060]
//  279                     Data = (*(vu16 *)0x64000000)>> 6; // FPGA配置程序版本信息
        MOV      R0,#+1677721600
        LDRH     R0,[R0, #+0]
        LSRS     R5,R0,#+6
//  280                     u16ToDec5(VerStr, Data);
        LDR.N    R6,??Get_3+0x28  ;; VerStr
        MOVS     R1,R5
        MOVS     R0,R6
        BL       u16ToDec5
//  281                     VerStr[0]=VerStr[2]; VerStr[1]='.'; VerStr[2]=VerStr[3]; 
        LDRB     R0,[R6, #+2]
        STRB     R0,[R6, #+0]
        MOVS     R0,#+46
        STRB     R0,[R6, #+1]
        LDRB     R0,[R6, #+3]
        STRB     R0,[R6, #+2]
//  282                     VerStr[3]=VerStr[4]; VerStr[4]= 0; 
        LDRB     R0,[R6, #+4]
        STRB     R0,[R6, #+3]
        MOVS     R0,#+0
        STRB     R0,[R6, #+4]
//  283                     if(Value == 0) return (u32)(VerStr);
        CBNZ     R4,??Get_24
        MOVS     R0,R6
        POP      {R4-R6,PC}
//  284                     else return Data; 
??Get_24:
        MOVS     R0,R5
        POP      {R4-R6,PC}
//  285   } 
//  286   return 0;                          // No used
??Get_1:
        MOVS     R0,#+0
??Get_19:
        POP      {R4-R6,PC}       ;; return
        Nop      
        DATA
??Get_3:
        DC32     0x40010808
        DC32     0x40013c4c
        DC32     HDW_Ver + 56
        DC32     HDW_Ver + 236
        DC32     HDW_Ver + 28
        DC32     HDW_Ver + 776
        DC32     HDW_Ver + 20
        DC32     0xffffeb30
        DC32     HDW_Ver + 13
        DC32     SYS_Ver
        DC32     VerStr
        CFI EndBlock cfiBlock3
//  287 }

        END
//  288 /********************************* END OF FILE ********************************/
// 
//     9 bytes in section .bss
// 1 096 bytes in section .rodata
// 2 148 bytes in section .text
// 
// 2 148 bytes of CODE  memory
// 1 096 bytes of CONST memory
//     9 bytes of DATA  memory
//
//Errors: none
//Warnings: none
