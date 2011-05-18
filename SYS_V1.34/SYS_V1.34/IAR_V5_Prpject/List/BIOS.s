///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  14:17:06 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\SYS_V1.34\source\BIOS.c                       /
//    Command line =  E:\DS0203\SYS_V1.34\source\BIOS.c -lA                   /
//                    E:\DS0203\SYS_V1.34\IAR_V5_Prpject\List\ -o             /
//                    E:\DS0203\SYS_V1.34\IAR_V5_Prpject\Obj\ --no_inline     /
//                    --endian=little --cpu=Cortex-M3 --fpu=None              /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.0 Evaluation\ARM\INC\DLib_Config_Full.h"    /
//                    -I E:\DS0203\SYS_V1.34\IAR_V5_Prpject\..\..\FWLib\inc\  /
//                    -I E:\DS0203\SYS_V1.34\IAR_V5_Prpject\..\..\USBLib\inc\ /
//                     -I E:\DS0203\SYS_V1.34\IAR_V5_Prpject\..\include\ -I   /
//                    "C:\Program Files\IAR Systems\Embedded Workbench 5.0    /
//                    Evaluation\ARM\INC\" -Ohs                               /
//    List file    =  E:\DS0203\SYS_V1.34\IAR_V5_Prpject\List\BIOS.s          /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME BIOS

        EXTERN Delayms

        PUBLIC G_ATTR
        PUBLIC Get
        PUBLIC SendByte
        PUBLIC Set
        PUBLIC Set_Param
        PUBLIC T_ATTR
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
        
// E:\DS0203\SYS_V1.34\source\BIOS.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : BIOS.c  
//    3  Version   : DS203_SYS Ver 1.3x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include "Config.h"
//    6 #include "Ident.h"
//    7 #include "BIOS.h"
//    8 #include "LCD.h"
//    9 #include "ASM.h"
//   10 

        SECTION `.rodata`:CONST:NOROOT(2)
//   11   const G_attr G_ATTR[1] =//LCD_X;LCD_Y;Yp_Max;Xp_Max;Tg_Num;Yv_Max;Xt_Max
G_ATTR:
        DATA
        DC16 400, 240, 7, 21, 15, 200, 4096, 1
        DC8 1, 1, 17, 0
        DC16 0, 1024, 0, 1024
//   12                          {  400,   240,   8-1,    22-1,   15,     200,    4096,  
//   13                           //Co_Max;Ya_Num;Yd_Num;INSERT;KpA1;KpA2;KpB1;KpB2
//   14                             1,     1,     1,     17,    0,   1024,  0, 1024};
//   15 
//   16   const Y_attr Y_ATTR[9] ={//  STR     KA1    KA2    KB1    KB2     SCALE 
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
//   17                            { "50mV",    0,   1024,    0,   1024,    2000},
//   18                            { "0.1V",    0,   1024,    0,   1024,    4000},
//   19                            { "0.2V",   -2,   1024,   -6,   1024,    8000},
//   20                            { "0.5V",   -1,   1024,   -6,   1024,   20000},
//   21                            { " 1V ",    0,   1024,   -6,   1024,   40000},
//   22                            { " 2V ",   -2,   1024,   -6,   1024,   80000},
//   23                            { " 5V ",   -1,   1024,   -6,   1024,  200000},
//   24                            { "!10V!",   0,   1024,   -6,   1024,  400000}};
//   25   
//   26 const X_attr X_ATTR[27] ={
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
//   27 //   STR      PSC      ARR      CCR    KP     SCALE
//   28   {"! 1S !", 1000-1,  2400-1,  1200,  1024, 33333333},
//   29   {"500mS",  1000-1,  1200-1,   600,  1024, 16666667}, 
//   30   {"200mS",  1000-1,   480-1,   240,  1024,  6666667}, 
//   31   {"100mS",  1000-1,   240-1,   120,  1024,  3333333},
//   32   {"!50mS!", 1000-1,   120-1,    60,  1024,  1666667}, 
//   33   {"!20mS!",  100-1,   480-1,   240,  1024,   666667}, 
//   34   {"!10mS!",  100-1,   240-1,   120,  1024,   333333}, 
//   35   {" 5mS ",   100-1,   120-1,    60,  1024,   166667},
//   36   {" 2mS ",    10-1,   480-1,   240,  1024,    66667}, 
//   37   {" 1mS ",    10-1,   240-1,   120,  1024,    33333},   
//   38   {"500uS",    10-1,   120-1,    60,  1024,    16667}, 
//   39   {"200uS",     1-1,   480-1,   240,  1024,     6667},
//   40   {"100uS",     1-1,   240-1,   120,  1024,     3333}, 
//   41   {"!50uS!",    1-1,   120-1,    60,  1024,     1667}, 
//   42   {"!20uS!",    1-1,    48-1,    24,  1024,      667},      
//   43   {"!10uS!",    1-1,    24-1,    12,  1024,      333},      
//   44   {" 5uS ",     1-1,    12-1,     6,  1024,      167},       
//   45   {" 2uS ",     1-1,     5-1,     3,   983,       67}, //1024*4.8/5 =983
//   46   {" 1uS ",     1-1,     3-1,     2,   819,       33}, //1024*2.4/3 =819 
//   47   {"0.5uS",     1-1,     2-1,     1,   614,       17}, //1024*1.2/2 =614
//   48   {"0.2uS",     1-1,     1-1,     1,   492,        7}, //1024*0.48  =492
//   49   {"0.1uS",     1-1,     1-1,     1,   246,        3}, //1024*0.24  =246 
//   50   {" 2uS+",     1-1,    10-1,     3,   983,       67}, //1024*9.6/10=983
//   51   {" 1uS+",     1-1,     5-1,     2,   983,       33}, //1024*4.8/5 =983
//   52   {".5uS+",     1-1,     3-1,     1,   819,       17}, //1024*2.4/3 =819
//   53   {".2uS+",     1-1,     2-1,     1,   983,        7}, //1024*0.96  =983
//   54   {".1uS+",     1-1,     1-1,     1,   491,        3}};//1024*0.48  =492
//   55 
//   56 
//   57 const T_attr T_ATTR[32] ={
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
//   58 //  STR   CHx  CMD    STR   CHx  CMD    STR   CHx  CMD    STR   CHx  CMD
//   59   {"<Vt",  0, 0x00},{"<Vt",  1, 0x02},{"<Vt",  2, 0x04},{"<Vt",  3, 0x06},
//   60   {">Vt",  0, 0x01},{">Vt",  1, 0x03},{">Vt",  2, 0x05},{">Vt",  3, 0x07}, 
//   61   {":!\\!",0, 0x08},{":!\\!",1, 0x0A},{":!\\!",2, 0x0C},{":!\\!",3, 0x0E}, 
//   62   {":!^!", 0, 0x09},{":!^!", 1, 0x0B},{":!^!", 2, 0x0D},{":!^!", 3, 0x0F},
//   63   {"<TL",  0, 0x10},{"<TL",  1, 0x12},{"<TL",  2, 0x14},{"<TL",  3, 0x16},
//   64   {">TL",  0, 0x11},{">TL",  1, 0x13},{">TL",  2, 0x15},{">TL",  3, 0x17}, 
//   65   {"<TH",  0, 0x18},{"<TH",  1, 0x1A},{"<TH",  2, 0x1C},{"<TH",  3, 0x1E},   
//   66   {">TH",  0, 0x19},{">TH",  1, 0x1B},{">TH",  2, 0x1D},{">TH",  3, 0x1F}};  
//   67 
//   68 /*******************************************************************************
//   69  Set:  硬件控制设备设置
//   70 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Set
        THUMB
//   71 u32 Set(u8 Object, u32 Value)
//   72 {
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
//   73   switch (Object){  
        CMP      R0,#+39
        BHI.W    ??Set_3
        TBH      [PC, R0, LSL #+1]
        DATA
??Set_0:
        DC16     +40,+53,+66,+71
        DC16     +79,+88,+101,+128
        DC16     +132,+174,+195,+185
        DC16     +343,+532,+554,+557
        DC16     +560,+577,+581,+609
        DC16     +612,+706,+706,+706
        DC16     +706,+706,+706,+706
        DC16     +706,+706,+706,+630
        DC16     +693,+693,+696,+706
        DC16     +693,+693,+693,+693
        THUMB
//   74   case CH_A_OFFSET:  TIM5_ARR  = 470;  TIM5_CCR1 = 450 - Value; // Value = 0~200  
??Set_4:
        LDR.W    R0,??Set_5       ;; 0x40000410
        MOV      R1,#+470
        STR      R1,[R0, #+2076]
        RSB      R0,R4,#+450
        LDR.W    R1,??Set_5       ;; 0x40000410
        STR      R0,[R1, #+2084]
        B.N      ??Set_3
//   75                      break;
//   76   case CH_B_OFFSET:  TIM5_ARR  = 470;  TIM5_CCR2 = 450 - Value; // Value = 0~200
??Set_6:
        LDR.W    R0,??Set_5       ;; 0x40000410
        MOV      R1,#+470
        STR      R1,[R0, #+2076]
        RSB      R0,R4,#+450
        LDR.W    R1,??Set_5       ;; 0x40000410
        STR      R0,[R1, #+2088]
        B.N      ??Set_3
//   77                      break;
//   78   case BACKLIGHT:    TIM8_CCR1 = Value;                         // Value = 0~100
??Set_7:
        LDR.W    R0,??Set_5+0x4   ;; 0x40012c00
        STR      R4,[R0, #+2100]
        B.N      ??Set_3
//   79                      break;
//   80   case BEEP_VOLUME:  TIM8_CCR2 = 100 - Value/2;                 // Value = 0~50
??Set_8:
        MOVS     R0,#+100
        SUB      R0,R0,R4, LSR #+1
        LDR.W    R1,??Set_5+0x4   ;; 0x40012c00
        STR      R0,[R1, #+2104]
        B.N      ??Set_3
//   81                      break;
//   82   case BETTERY_DT:   ADC3_CR2 |= (Value & 1)<<22;  // Value = 1/0   ADC3_CR2 |=0x00400000;
??Set_9:
        LDR.W    R0,??Set_5+0x8   ;; 0x40013c08
        LDR      R1,[R0, #+0]
        AND      R2,R4,#0x1
        ORR      R1,R1,R2, LSL #+22
??Set_10:
        STR      R1,[R0, #+0]
        B.N      ??Set_3
//   83                      break;
//   84   case ADC_MODE:     if(Value == SEPARATE) FIFO_MODE_LOW();  
??Set_11:
        CBNZ     R4,??Set_12
        LDR.W    R0,??Set_5+0xC   ;; 0x40010800
        MOVS     R1,#+8
        STR      R1,[R0, #+2068]
        B.N      ??Set_3
//   85                      else                  FIFO_MODE_HIGH();  break;
??Set_12:
        LDR.W    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOVS     R1,#+8
        B.N      ??Set_10
//   86   case FIFO_CLR:     if(Value == W_PTR){FIFO_CLRW_HIGH();  FIFO_CLRW_LOW();}
??Set_13:
        CMP      R4,#+1
        BNE.N    ??Set_14
        LDR.W    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+1040
        MOVS     R1,#+2
        STR      R1,[R0, #+0]
        LDR.W    R0,??Set_5+0xC   ;; 0x40010800
        STR      R1,[R0, #+1044]
        B.N      ??Set_3
//   87                      if(Value == R_PTR){FIFO_CLRR_HIGH();  FIFO_CLRR_LOW();} break;
??Set_14:
        CMP      R4,#+0
        BNE.W    ??Set_3
        LDR.W    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOVS     R1,#+16
        STR      R1,[R0, #+0]
        LDR.W    R0,??Set_5+0xC   ;; 0x40010800
        STR      R1,[R0, #+2068]
        B.N      ??Set_3
//   88   case T_BASE_PSC:   TIM1_PSC  = Value;
??Set_15:
        LDR.W    R0,??Set_5+0x4   ;; 0x40012c00
        STR      R4,[R0, #+40]
        B.N      ??Set_3
//   89                      break;
//   90   case T_BASE_ARR:   if(Value==0)      {TIM1_CCER=0; RCC_CFGR=0x041D8402;} // MCO as SYSCLK  
??Set_16:
        CBNZ     R4,??Set_17
        LDR.W    R0,??Set_5+0x4   ;; 0x40012c00
        MOVS     R1,#+0
        STR      R1,[R0, #+32]
        LDR.W    R0,??Set_5+0x10  ;; 0x40020448
        LDR.W    R1,??Set_5+0x14  ;; 0x41d8402
        STR      R1,[R0, #+3004]
        B.N      ??Set_3
//   91                      else if(Value==1) {TIM1_CCER=0; RCC_CFGR=0x071D8402;} // MCO as SYSCLK/2 
??Set_17:
        CMP      R4,#+1
        BNE.N    ??Set_18
        LDR.W    R0,??Set_5+0x4   ;; 0x40012c00
        MOVS     R1,#+0
        STR      R1,[R0, #+32]
        LDR.W    R0,??Set_5+0x10  ;; 0x40020448
        LDR.W    R1,??Set_5+0x18  ;; 0x71d8402
        STR      R1,[R0, #+3004]
        B.N      ??Set_3
//   92                      else  {RCC_CFGR=0x001D8402;  TIM1_CCER=0x0003;        // MCO as OC1 
??Set_18:
        LDR.W    R0,??Set_5+0x10  ;; 0x40020448
        LDR.W    R1,??Set_5+0x1C  ;; 0x1d8402
        STR      R1,[R0, #+3004]
        LDR.W    R0,??Set_5+0x4   ;; 0x40012c00
        MOVS     R1,#+3
        STR      R1,[R0, #+32]
//   93                             TIM1_ARR=Value;  TIM1_CCR1=(Value+1)/2;}
        STR      R4,[R0, #+44]
        ADDS     R0,R4,#+1
        LSRS     R0,R0,#+1
        LDR.W    R1,??Set_5+0x4   ;; 0x40012c00
        STR      R0,[R1, #+52]
        B.N      ??Set_3
//   94                      break;
//   95   case CH_A_COUPLE:  if(Value == AC ) AC_1();  else DC_1();
??Set_19:
        CMP      R4,#+1
        BNE.N    ??Set_20
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+1
??Set_21:
        STR      R1,[R0, #+4]
        B.N      ??Set_3
??Set_20:
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+1
        B.N      ??Set_10
//   96                      break;
//   97   case CH_B_COUPLE:  if(Value == AC ) AC_2();  else DC_2();
??Set_22:
        CMP      R4,#+1
        BNE.N    ??Set_23
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+32
        B.N      ??Set_21
??Set_23:
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+32
        B.N      ??Set_10
//   98                      break;
//   99   case CH_A_RANGE:
//  100     switch (Value){  
??Set_24:
        CMP      R4,#+8
        BHI.W    ??Set_3
        TBH      [PC, R4, LSL #+1]
        DATA
??Set_1:
        DC16     +9,+24,+40,+55
        DC16     +73,+89,+104,+120
        DC16     +130
        THUMB
//  101     case _50MV:  Ax0_ON();  Ax1_ON();  Ax2_HIGH(); Ax5_HIGH();
??Set_25:
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+0]
        LDR.W    R1,??Set_5+0xC   ;; 0x40010800
        ADD      R1,R1,#+1040
        MOV      R2,#+512
        STR      R2,[R1, #+0]
        MOVS     R1,#+4
        STR      R1,[R0, #+0]
        MOVS     R1,#+8
        B.N      ??Set_10
//  102                  break;
//  103     case _100MV:  Ax0_ON();  Ax1_ON();  Ax2_LOW();  Ax5_HIGH();    
??Set_26:
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+0]
        LDR.W    R1,??Set_5+0xC   ;; 0x40010800
        ADD      R1,R1,#+1040
        MOV      R2,#+512
        STR      R2,[R1, #+0]
        MOVS     R2,#+4
        STR      R2,[R0, #+4]
??Set_27:
        MOVS     R1,#+8
??Set_28:
        STR      R1,[R0, #+0]
        B.N      ??Set_3
//  104                  break;
//  105     case _200MV: Ax0_ON();  Ax1_ON();  Ax2_HIGH(); Ax5_LOW();
??Set_29:
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+0]
        LDR.W    R1,??Set_5+0xC   ;; 0x40010800
        ADD      R1,R1,#+1040
        MOV      R2,#+512
        STR      R2,[R1, #+0]
        MOVS     R1,#+4
        STR      R1,[R0, #+0]
        MOVS     R1,#+8
        B.N      ??Set_21
//  106                  break;
//  107     case _500MV: Ax0_ON();  Ax1_ON();  Ax2_LOW();  Ax5_LOW(); 
??Set_30:
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+0]
        LDR.W    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+1040
        MOV      R1,#+512
        STR      R1,[R0, #+0]
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
??Set_31:
        MOVS     R1,#+4
        STR      R1,[R0, #+4]
        MOVS     R1,#+8
        STR      R1,[R0, #+4]
        B.N      ??Set_3
//  108                  break;
//  109     case _1V: Ax0_OFF(); Ax1_OFF(); Ax2_HIGH(); Ax5_HIGH(); 
??Set_32:
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+4]
        LDR.W    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+512
        STR      R1,[R0, #+1044]
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+4
        STR      R1,[R0, #+0]
        MOVS     R1,#+8
        B.N      ??Set_10
//  110                  break;
//  111     case _2V:    Ax0_OFF(); Ax1_OFF(); Ax2_LOW();  Ax5_HIGH();
??Set_33:
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+4]
        LDR.W    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+512
        STR      R1,[R0, #+1044]
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+4
        STR      R1,[R0, #+4]
        B.N      ??Set_27
//  112                  break;
//  113     case _5V:    Ax0_OFF(); Ax1_OFF(); Ax2_HIGH(); Ax5_LOW(); 
??Set_34:
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+4]
        LDR.W    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+512
        STR      R1,[R0, #+1044]
        LDR.W    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+4
        STR      R1,[R0, #+0]
        MOVS     R1,#+8
        B.N      ??Set_21
//  114                  break;
//  115     case _10V:    Ax0_OFF(); Ax1_OFF(); Ax2_LOW();  Ax5_LOW();  
??Set_35:
        LDR.N    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+4]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+512
        STR      R1,[R0, #+1044]
        LDR.N    R0,??Set_5+0x20  ;; 0x40011810
        B.N      ??Set_31
//  116                  break;
//  117     case CH_B:   Ax0_ON(); Ax1_OFF();  Ax2_LOW();  Ax5_LOW();
??Set_36:
        LDR.N    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+16
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+512
        STR      R1,[R0, #+1044]
        LDR.N    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+4
        STR      R1,[R0, #+4]
        MOVS     R1,#+8
        B.N      ??Set_21
//  118                  break;
//  119     }  break;
//  120     
//  121   case CH_B_RANGE:
//  122     switch (Value){  
??Set_37:
        CMP      R4,#+8
        BHI.W    ??Set_3
        TBH      [PC, R4, LSL #+1]
        DATA
??Set_2:
        DC16     +9,+30,+49,+70
        DC16     +89,+109,+127,+147
        DC16     +165
        THUMB
//  123     case _50MV:  Bx0_ON();  Bx1_ON();  Bx2_HIGH(); Bx5_HIGH();
??Set_38:
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+8192
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+16384
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+32768
        B.N      ??Set_10
//  124                  break;
//  125     case _100MV:  Bx0_ON();  Bx1_ON();  Bx2_LOW();  Bx5_HIGH();
??Set_39:
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+8192
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+16384
        STR      R1,[R0, #+2068]
        ADD      R0,R0,#+2064
        MOV      R1,#+32768
        B.N      ??Set_28
//  126                  break;
//  127     case _200MV: Bx0_ON();  Bx1_ON();  Bx2_HIGH();  Bx5_LOW();
??Set_40:
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+8192
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+16384
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+32768
        STR      R1,[R0, #+2068]
        B.N      ??Set_3
//  128                  break;
//  129     case _500MV: Bx0_ON();  Bx1_ON();  Bx2_LOW();  Bx5_LOW();
??Set_41:
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+8192
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+16384
        STR      R1,[R0, #+2068]
        MOV      R1,#+32768
        STR      R1,[R0, #+2068]
        B.N      ??Set_3
//  130                  break;
//  131     case _1V: Bx0_OFF(); Bx1_OFF(); Bx2_HIGH(); Bx5_HIGH();
??Set_42:
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+8192
        STR      R1,[R0, #+2068]
        LDR.N    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+4]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+16384
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+32768
        B.N      ??Set_10
//  132                  break;
//  133     case _2V:    Bx0_OFF(); Bx1_OFF(); Bx2_LOW();  Bx5_HIGH();
??Set_43:
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+8192
        STR      R1,[R0, #+2068]
        LDR.N    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+4]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+16384
        STR      R1,[R0, #+2068]
        ADD      R0,R0,#+2064
        MOV      R1,#+32768
        B.N      ??Set_28
//  134                  break;
//  135     case _5V:    Bx0_OFF(); Bx1_OFF(); Bx2_HIGH();  Bx5_LOW();
??Set_44:
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+8192
        STR      R1,[R0, #+2068]
        LDR.N    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+4]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+16384
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+32768
        STR      R1,[R0, #+2068]
        B.N      ??Set_3
//  136                  break;
//  137     case _10V:    Bx0_OFF(); Bx1_OFF(); Bx2_LOW(); Bx5_LOW();
??Set_45:
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+8192
        STR      R1,[R0, #+2068]
        LDR.N    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+4]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+16384
        STR      R1,[R0, #+2068]
        MOV      R1,#+32768
        STR      R1,[R0, #+2068]
        B.N      ??Set_3
//  138                  break;
//  139     case CH_A:   Bx0_ON(); Bx1_OFF();  Bx2_LOW();  Bx5_LOW();
??Set_46:
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+2064
        MOV      R1,#+8192
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0x20  ;; 0x40011810
        MOVS     R1,#+64
        STR      R1,[R0, #+4]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+16384
        STR      R1,[R0, #+2068]
        MOV      R1,#+32768
        STR      R1,[R0, #+2068]
        B.N      ??Set_3
//  140                  break;
//  141     }  break;
//  142     
//  143   case ANALOG_ARR:  GPIOB_CRL = 0x34BBB438;  TIM4_CR1 = 0x0080;  // SQR_OUT = Disnable  
??Set_47:
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+1024
        LDR.N    R1,??Set_5+0x24  ;; 0x34bbb438
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5       ;; 0x40000410
        MOVS     R1,#+128
        STR      R1,[R0, #+1008]
//  144                     GPIOA_CRL   = 0x111011BB;  DAC_CR = 0x0001;  // DAC = Ensable 
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        LDR.N    R1,??Set_5+0x28  ;; 0x111011bb
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0x2C  ;; 0x40007400
        MOVS     R1,#+1
        STR      R1,[R0, #+0]
//  145                     TIM7_ARR = Value;  TIM7_CR1 = 0x0085;  break;// DAC_CLK = Enable
        LDR.N    R0,??Set_5+0x30  ;; 0x4000142c
        STR      R4,[R0, #+0]
        LDR.N    R0,??Set_5       ;; 0x40000410
        ADD      R0,R0,#+4080
        MOVS     R1,#+133
        B.N      ??Set_10
//  146   case ANALOG_PTR:  DMA2_CMAR4  = Value;
??Set_48:
        LDR.N    R0,??Set_5+0x10  ;; 0x40020448
        STR      R4,[R0, #+8]
        B.N      ??Set_3
//  147                     break;
//  148   case ANALOG_CNT:  DMA2_CNDTR4 = Value;       // Fout = (Cnt*(ARR+1)/72)KHz
??Set_49:
        LDR.N    R0,??Set_5+0x10  ;; 0x40020448
        STR      R4,[R0, #+0]
        B.N      ??Set_3
//  149                     break;
//  150   case DIGTAL_PSC:  TIM4_PSC = Value; GPIOA_CRL  |= 0x40000;  // DAC_OUT = Disnable
??Set_50:
        LDR.N    R0,??Set_5       ;; 0x40000410
        ADD      R0,R0,#+1048
        STR      R4,[R0, #+0]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x40000
        STR      R1,[R0, #+0]
//  151                     TIM7_CR1 = 0x0084;  DAC_CR = 0;  break;   // DAC = Disnable
        LDR.N    R0,??Set_5       ;; 0x40000410
        ADD      R0,R0,#+4080
        MOVS     R1,#+132
        STR      R1,[R0, #+0]
        LDR.N    R0,??Set_5+0x2C  ;; 0x40007400
        MOVS     R1,#+0
        B.N      ??Set_10
//  152   case DIGTAL_ARR:  TIM4_ARR    = Value;
??Set_51:
        LDR.N    R0,??Set_5       ;; 0x40000410
        STR      R4,[R0, #+1052]
        B.N      ??Set_3
//  153                     break;
//  154   case DIGTAL_CCR:  GPIOB_CRL &= 0xF0FFFFFF;  GPIOB_CRL |= 0x0B000000; // PORT_SQR = Enable
??Set_52:
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+1024
        LDR      R0,[R0, #+0]
        MVN      R1,#+251658240
        ANDS     R0,R1,R0
        LDR.N    R1,??Set_5+0xC   ;; 0x40010800
        ADD      R1,R1,#+1024
        STR      R0,[R1, #+0]
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+1024
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0xB000000
        LDR.N    R1,??Set_5+0xC   ;; 0x40010800
        ADD      R1,R1,#+1024
        STR      R0,[R1, #+0]
//  155                     TIM4_CCR1 = Value;  TIM4_CR1 = 0x0081; break;      // SQR_OUT = Enable 
        LDR.N    R0,??Set_5       ;; 0x40000410
        STR      R4,[R0, #+1060]
        MOVS     R1,#+129
        STR      R1,[R0, #+1008]
        B.N      ??Set_3
//  156   case KEY_IF_RST:  TIM3_SR = 0;               //Clear TIM3 interrupt flag
??Set_53:
        LDR.N    R0,??Set_5       ;; 0x40000410
        MOVS     R1,#+0
        B.N      ??Set_10
//  157                     break;
//  158   case STANDBY:     if(Value == 1) { STB_EN();}  else { STB_DN();}   
??Set_54:
        LDR.N    R0,??Set_5+0x4   ;; 0x40012c00
        CMP      R4,#+1
        BNE.N    ??Set_55
        LDR.N    R1,??Set_5+0xC   ;; 0x40010800
        MOV      R2,#+8192
        STR      R2,[R1, #+3092]
        MOVS     R1,#+132
        B.N      ??Set_28
??Set_55:
        LDR.N    R1,??Set_5+0xC   ;; 0x40010800
        ADD      R1,R1,#+3088
        MOV      R2,#+8192
        STR      R2,[R1, #+0]
        MOVS     R1,#+133
        B.N      ??Set_10
//  159                     break;
//  160                     
//  161   case FPGA_RST:    GPIOB_CRH &= 0xF0FFFFFF;  GPIOB_CRH |= 0x01000000;        // 设PB14为输出状态
??Set_56:
        MVN      R4,#+251658240
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        LDR      R0,[R0, #+1028]
        ANDS     R0,R4,R0
        LDR.N    R1,??Set_5+0xC   ;; 0x40010800
        STR      R0,[R1, #+1028]
        LDR      R0,[R1, #+1028]
        ORR      R0,R0,#0x1000000
        STR      R0,[R1, #+1028]
//  162                     SPI_CRST_LOW(); Delayms(1);   // SPI_CRST_LOW 1mS
        MOV      R0,R1
        MOV      R1,#+16384
        STR      R1,[R0, #+1044]
        MOVS     R0,#+1
        BL       Delayms
//  163                     SPI_SS_HIGH(); Delayms(1);     // SPI_SS_HIGH  1mS
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+1040
        MOV      R1,#+1024
        STR      R1,[R0, #+0]
        MOVS     R0,#+1
        BL       Delayms
//  164                     SPI_SS_LOW(); Delayms(1);      // SPI_SS_LOW   1mS
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        MOV      R1,#+1024
        STR      R1,[R0, #+1044]
        MOVS     R0,#+1
        BL       Delayms
//  165                     SPI_CRST_HIGH(); Delayms(2);   // SPI_CRST_HIGH 2mS
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        ADD      R0,R0,#+1040
        MOV      R1,#+16384
        STR      R1,[R0, #+0]
        MOVS     R0,#+2
        BL       Delayms
//  166                     GPIOB_CRH &= 0xF0FFFFFF;  GPIOB_CRH |= 0x08000000; break; // 设PB14为输入状态 
        LDR.N    R0,??Set_5+0xC   ;; 0x40010800
        LDR      R0,[R0, #+1028]
        ANDS     R0,R4,R0
        LDR.N    R1,??Set_5+0xC   ;; 0x40010800
        STR      R0,[R1, #+1028]
        LDR      R0,[R1, #+1028]
        ORR      R0,R0,#0x8000000
        STR      R0,[R1, #+1028]
        B.N      ??Set_3
//  167 
//  168   case TRIGG_MODE:  Set_Param(Object, Value);             
??Set_57:
        UXTB     R1,R4
        MOVS     R0,R5
        B.N      ??Set_58
//  169                     break; 
//  170   case V_THRESHOLD: Set_Param(Object, Value);          
//  171                     break;    
//  172   case T_THRESHOLD: Set_Param(Object, Value & 0xFF);            
??Set_59:
        UXTB     R1,R4
        MOVS     R0,R5
        BL       Set_Param
//  173                     Set_Param(Object +1, Value >> 8);  break;
        LSRS     R1,R4,#+8
        UXTB     R1,R1
        ADDS     R0,R5,#+1
        UXTB     R0,R0
??Set_58:
        BL       Set_Param
//  174   case ADC_CTRL:    Set_Param(Object, Value);               
//  175                     break;
//  176   case A_POSITION:  Set_Param(Object, Value);              
//  177                     break; 
//  178   case B_POSITION:  Set_Param(Object, Value);              
//  179                     break; 
//  180   case REG_ADDR:    Set_Param(Object, Value);          
//  181                     break;    
//  182   }
//  183   return 0;
??Set_3:
        MOVS     R0,#+0
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        DATA
??Set_5:
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
//  184 }
//  185 /*******************************************************************************
//  186  SendByte:  Send a byte to FPGA
//  187 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function SendByte
        THUMB
//  188 void SendByte(u8 Data) 
//  189 { 
//  190   u8 i;
//  191   
//  192   FIFO_SCK_HIGH();
SendByte:
        LDR.N    R1,??SendByte_0  ;; 0x40010810
        MOVS     R2,#+64
        STR      R2,[R1, #+0]
//  193   for(i=0; i<8; ++i){
        MOVS     R2,#+0
//  194     if((Data<<i) & 0x80) FIFO_SDA_HIGH();
??SendByte_1:
        MOVS     R3,R2
        LSL      R3,R0,R3
        TST      R3,#0x80
        BEQ.N    ??SendByte_2
        MOVS     R3,#+128
        STR      R3,[R1, #+0]
        B.N      ??SendByte_3
//  195     else                 FIFO_SDA_LOW();
??SendByte_2:
        MOV      R12,#+128
        STR      R12,[R1, #+4]
//  196     FIFO_SCK_LOW();
??SendByte_3:
        MOV      R12,#+64
        STR      R12,[R1, #+4]
//  197     FIFO_SCK_HIGH();
        MOVS     R3,#+64
        STR      R3,[R1, #+0]
//  198   }  
        ADDS     R2,R2,#+1
        UXTB     R3,R2
        CMP      R3,#+8
        BCC.N    ??SendByte_1
//  199   FIFO_SDA_LOW();
        MOVS     R2,#+128
        STR      R2,[R1, #+4]
//  200   FIFO_SCK_LOW();
        MOVS     R2,#+64
        STR      R2,[R1, #+4]
//  201   FIFO_SDA_HIGH(); // Send data to buffer
        MOVS     R0,#+128
        STR      R0,[R1, #+0]
//  202 }
        BX       LR               ;; return
        DATA
??SendByte_0:
        DC32     0x40010810
        CFI EndBlock cfiBlock1
//  203 /*******************************************************************************
//  204  Set_Param: Trigger control Parameter Set 
//  205 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Set_Param
        THUMB
//  206 void Set_Param(u8 RegAddr, u8 Parameter) 
//  207 {
Set_Param:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        MOVS     R4,R1
//  208   RegAddr &= 0x1F;
//  209   FIFO_H_L_HIGH();
        LDR.N    R1,??Set_Param_0  ;; 0x40011010
        MOVS     R2,#+32
        STR      R2,[R1, #+0]
//  210   SendByte(RegAddr);
        AND      R0,R0,#0x1F
        BL       SendByte
//  211   FIFO_H_L_LOW();
        LDR.N    R0,??Set_Param_0  ;; 0x40011010
        MOVS     R1,#+32
        STR      R1,[R0, #+4]
//  212   SendByte(Parameter);
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
//  213 }
//  214 /*******************************************************************************
//  215  Get: Get hardware attribute & status
//  216 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Get
        THUMB
//  217 u32 Get(u8 Object, u32 Value)
//  218 {
//  219   u16 Data;
//  220   
//  221   switch (Object){  
Get:
        CMP      R0,#+12
        BHI.W    ??Get_1
        TBB      [PC, R0]
        DATA
??Get_0:
        DC8      +7,+26,+15,+37
        DC8      +48,+111,+118,+125
        DC8      +127,+129,+131,+133
        DC8      +139,+0
        THUMB
//  222     
//  223   case FIFO_DIGIT:  FIFO_H_L_LOW();  return (*(vu16 *)0x64000000); // 16bits FIFO Digital data
??Get_2:
        LDR.N    R0,??Get_3       ;; 0x40010808
        MOVS     R1,#+32
        STR      R1,[R0, #+2060]
        MOV      R0,#+1677721600
        LDRH     R0,[R0, #+0]
        BX       LR
//  224 
//  225   case FIFO_START:  FIFO_H_L_LOW();  return ((*(vu16 *)0x64000000)& 0x04)>> 2;    // Start = Bit2
??Get_4:
        LDR.N    R0,??Get_3       ;; 0x40010808
        MOVS     R1,#+32
        STR      R1,[R0, #+2060]
        MOV      R0,#+1677721600
        LDRH     R0,[R0, #+0]
        AND      R0,R0,#0x4
??Get_5:
        LSRS     R0,R0,#+2
        BX       LR
//  226 
//  227   case FIFO_EMPTY:  FIFO_H_L_LOW();  return ((*(vu16 *)0x64000000)& 0x10)>> 4;    // Empty = Bit4
??Get_6:
        LDR.N    R0,??Get_3       ;; 0x40010808
        MOVS     R1,#+32
        STR      R1,[R0, #+2060]
        MOV      R0,#+1677721600
        LDRH     R0,[R0, #+0]
        AND      R0,R0,#0x10
        LSRS     R0,R0,#+4
        BX       LR
//  228 
//  229   case FIFO_FULL:   FIFO_H_L_LOW();  return ((*(vu16 *)0x64000000)& 0x08)>> 3;    // Full = Bit3
??Get_7:
        LDR.N    R0,??Get_3       ;; 0x40010808
        MOVS     R1,#+32
        STR      R1,[R0, #+2060]
        MOV      R0,#+1677721600
        LDRH     R0,[R0, #+0]
        AND      R0,R0,#0x8
        LSRS     R0,R0,#+3
        BX       LR
//  230 
//  231   case KEY_STATUS:  Data  =(GPIOA_IDR & 0x4000);    Data |=(GPIOC_IDR & 0x0400)<<3; // K1, K2
??Get_8:
        LDR.N    R0,??Get_3       ;; 0x40010808
        LDR      R1,[R0, #+0]
        AND      R1,R1,#0x4000
        ADD      R2,R0,#+2048
        LDR      R2,[R2, #+0]
        AND      R2,R2,#0x400
        ORR      R1,R1,R2, LSL #+3
//  232                     Data |=(GPIOC_IDR & 0x0200)>>1; Data |=(GPIOC_IDR & 0x0100)<<1; // K3, K4
        ADD      R2,R0,#+2048
        LDR      R2,[R2, #+0]
        AND      R2,R2,#0x200
        ORR      R1,R1,R2, LSR #+1
        ADD      R2,R0,#+2048
        LDR      R2,[R2, #+0]
        AND      R2,R2,#0x100
        ORR      R1,R1,R2, LSL #+1
//  233                     Data |=(GPIOA_IDR & 0x2000)>>3; Data |=(GPIOC_IDR & 0x1000)>>1; // K5, K6
        LDR      R2,[R0, #+0]
        AND      R2,R2,#0x2000
        ORR      R1,R1,R2, LSR #+3
        ADD      R2,R0,#+2048
        LDR      R2,[R2, #+0]
        AND      R2,R2,#0x1000
        ORR      R1,R1,R2, LSR #+1
//  234                     Data |=(GPIOC_IDR & 0x0800)<<1; Data |=(GPIOA_IDR & 0x8000);    // K7, K8
        ADD      R2,R0,#+2048
        LDR      R2,[R2, #+0]
        AND      R2,R2,#0x800
        ORR      R1,R1,R2, LSL #+1
        LDR      R0,[R0, #+0]
        AND      R0,R0,#0x8000
        ORRS     R0,R0,R1
//  235                     Data |=(GPIOD_IDR & 0x0008);    Data |=(GPIOD_IDR & 0x0040);    // K9, K10
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
//  236                     return Data;                              // Current keys status
        BX       LR
//  237 
//  238   case USB_POWER:   return USB_PWR_ON;               // USB power on = 1   
??Get_9:
        LDR.N    R0,??Get_3       ;; 0x40010808
        ADD      R0,R0,#+3072
        LDR      R0,[R0, #+0]
        AND      R0,R0,#0x4
        B.N      ??Get_5
//  239     
//  240   case V_BATTERY:   return (ADC3_DR*1400)/1024;      // Battery voltage (mV)  
??Get_10:
        LDR.N    R0,??Get_3+0x4   ;; 0x40013c4c
        LDR      R0,[R0, #+0]
        MOV      R1,#+1400
        MULS     R0,R0,R1
        LSRS     R0,R0,#+10
        BX       LR
//  241   
//  242   case VERTICAL:    return (u32)Y_ATTR;              // 垂直通道属性指针
??Get_11:
        LDR.N    R0,??Get_3+0x8   ;; G_ATTR + 28
        BX       LR
//  243     
//  244   case HORIZONTAL:  return (u32)X_ATTR;              // 水平通道属性指针
??Get_12:
        LDR.N    R0,??Get_3+0xC   ;; G_ATTR + 208
        BX       LR
//  245     
//  246   case GLOBAL:      return (u32)G_ATTR;              // 整体属性指针
??Get_13:
        LDR.N    R0,??Get_3+0x10  ;; G_ATTR
        BX       LR
//  247   
//  248     
//  249   case TRIGGER:     return (u32)T_ATTR;              // 触发通道属性指针
??Get_14:
        LDR.N    R0,??Get_3+0x14  ;; G_ATTR + 748
        BX       LR
//  250     
//  251   case FPGA_OK:     return FPGA_CFG_OK;              // FPGA config ok = 1
??Get_15:
        LDR.N    R0,??Get_3       ;; 0x40010808
        ADD      R0,R0,#+1024
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+15
        BX       LR
//  252 
//  253   case CHARGE:      return CHRG_ST;                  // Battery charge = 1
??Get_16:
        LDR.N    R0,??Get_3       ;; 0x40010808
        ADD      R0,R0,#+1024
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+8
        AND      R0,R0,#0x1
        EOR      R0,R0,#0x1
        BX       LR
//  254 
//  255   }
//  256   return 0;                          // No used
??Get_1:
        MOVS     R0,#+0
??Get_17:
        BX       LR               ;; return
        DATA
??Get_3:
        DC32     0x40010808
        DC32     0x40013c4c
        DC32     G_ATTR + 28
        DC32     G_ATTR + 208
        DC32     G_ATTR
        DC32     G_ATTR + 748
        CFI EndBlock cfiBlock3
//  257 }

        END
//  258 /********************************* END OF FILE ********************************/
// 
// 1 068 bytes in section .rodata
// 1 932 bytes in section .text
// 
// 1 932 bytes of CODE  memory
// 1 068 bytes of CONST memory
//
//Errors: none
//Warnings: none
