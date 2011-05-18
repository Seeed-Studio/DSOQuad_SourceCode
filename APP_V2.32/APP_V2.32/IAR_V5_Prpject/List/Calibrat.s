///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  13:45:23 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\APP_V2.32\source\Calibrat.c                   /
//    Command line =  E:\DS0203\APP_V2.32\source\Calibrat.c -lA               /
//                    E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\ -o             /
//                    E:\DS0203\APP_V2.32\IAR_V5_Prpject\Obj\ --debug         /
//                    --endian=little --cpu=Cortex-M3 --fpu=None              /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.0 Evaluation\ARM\INC\DLib_Config_Full.h"    /
//                    -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\..\FWLib\inc\  /
//                    -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\..\USBLib\inc\ /
//                     -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\include\ -I   /
//                    "C:\Program Files\IAR Systems\Embedded Workbench 5.0    /
//                    Evaluation\ARM\INC\" -Ohs                               /
//    List file    =  E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\Calibrat.s      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Calibrat

        EXTERN A_Vdc
        EXTERN App_init
        EXTERN B_Vdc
        EXTERN Beep_mS
        EXTERN Blink
        EXTERN Delayms
        EXTERN G_Attr
        EXTERN Int32String_sign
        EXTERN JumpCnt
        EXTERN Ka1
        EXTERN Ka2
        EXTERN Ka3
        EXTERN Kb1
        EXTERN Kb2
        EXTERN Kb3
        EXTERN Key_Buffer
        EXTERN Load_Parameter
        EXTERN PD_Cnt
        EXTERN Print_Str
        EXTERN Process
        EXTERN Save_Parameter
        EXTERN SecBuff
        EXTERN Title
        EXTERN Twink
        EXTERN X_Attr
        EXTERN Y_Attr
        EXTERN __Clear_Screen
        EXTERN __Get
        EXTERN __LCD_SetPixl
        EXTERN __Param_Area_WR
        EXTERN __Point_SCR
        EXTERN __Set
        EXTERN __aeabi_memclr
        EXTERN a_Avg
        EXTERN b_Avg
        EXTERN strcmp

        PUBLIC Calibrat
        PUBLIC Exit
        PUBLIC ExitStr
        PUBLIC VS_STR
        
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
        
// E:\DS0203\APP_V2.32\source\Calibrat.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : Calibrat.c  
//    3  Version   : DS203_APP Ver 2.3x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include <string.h>
//    6 #include "Interrupt.h"
//    7 #include "Function.h"
//    8 #include "Calibrat.h"
//    9 #include "Process.h"
//   10 #include "File.h"
//   11 #include "BIOS.h"
//   12 #include "Menu.h"
//   13 

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant {"uV", "mV", "V ", "kV"}>`:
        DATA
        DC8 "uV"
        DC8 "mV"
        DC8 "V "
        DC8 "kV"
        DC8 "CH_A"
        DC8 0, 0, 0
        DC8 "ZERO"
        DC8 0, 0, 0
        DC8 "DIFF"
        DC8 0, 0, 0
        DC8 "VOTAGE"
        DC8 0
        DC8 "CH_B"
        DC8 0, 0, 0
        DC8 "         Parameters version error          "
        DC8 "         Save the calibration data         "
        DC8 "           Restore defaults data           "
        DC8 "!10V!"
        DC8 0, 0
        DC8 " 5V "
        DC8 0, 0, 0
        DC8 " 2V "
        DC8 0, 0, 0
        DC8 " 1V "
        DC8 0, 0, 0
        DC8 "0.5V"
        DC8 0, 0, 0
        DC8 "0.2V"
        DC8 0, 0, 0
        DC8 "0.1V"
        DC8 0, 0, 0
        DC8 "50mV"
        DC8 0, 0, 0
        DC8 "20mV"
        DC8 0, 0, 0
        DC8 " Input "
        DC8 "standard voltage to "
        DC8 0, 0, 0
        DC8 "CH_A  "
        DC8 0
        DC8 "CH_B  "
        DC8 0
        DC8 "     Please connect"
        DC8 "input to GND       "
        DC8 " CH_A "
        DC8 0
        DC8 " CH_B "
        DC8 0
        DC8 "    Push the . key to confirm exit        "
        DC8 0
//   14 uc8 VS_STR[10][12]={"100-120mV","250-300mV","0.5-0.6V ","1.0-1.2V ","2.5-3.0V ",
VS_STR:
        DC8 "100-120mV"
        DC8 0, 0
        DC8 "250-300mV"
        DC8 0, 0
        DC8 "0.5-0.6V "
        DC8 0, 0
        DC8 "1.0-1.2V "
        DC8 0, 0
        DC8 "2.5-3.0V "
        DC8 0, 0
        DC8 "5.0-6.0V "
        DC8 0, 0
        DC8 " 10-12V  "
        DC8 0, 0
        DC8 " 25-30V  "
        DC8 0, 0
        DC8 " 50-60V  "
        DC8 0, 0
        DC8 "suitable "
        DC8 0, 0
//   15                     "5.0-6.0V "," 10-12V  "," 25-30V  "," 50-60V  ","suitable "};
//   16 uc8 ExitStr[3][30]={" Exit without calibration ", 
ExitStr:
        DC8 " Exit without calibration "
        DC8 0, 0, 0
        DC8 "Exit with save calibration"
        DC8 0, 0, 0
        DC8 "Exit with Restore defaults"
        DC8 0, 0, 0, 0, 0
//   17                     "Exit with save calibration", 
//   18                     "Exit with Restore defaults"};

        SECTION `.bss`:DATA:NOROOT(0)
//   19 u8  Exit;      
Exit:
        DS8 1
//   20 
//   21 /*******************************************************************************
//   22   Calibrat : Calibrat routine
//   23 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Calibrat
        THUMB
//   24 void Calibrat(void)
//   25 { 
Calibrat:
        PUSH     {R4-R11,LR}
        CFI R14 Frame(CFA, -4)
        CFI R11 Frame(CFA, -8)
        CFI R10 Frame(CFA, -12)
        CFI R9 Frame(CFA, -16)
        CFI R8 Frame(CFA, -20)
        CFI R7 Frame(CFA, -24)
        CFI R6 Frame(CFA, -28)
        CFI R5 Frame(CFA, -32)
        CFI R4 Frame(CFA, -36)
        CFI CFA R13+36
        SUB      SP,SP,#+36
        CFI CFA R13+72
//   26   u8  V_Unit[4][3]={"uV","mV","V ","kV"};
        LDR.W    R4,??Calibrat_1  ;; `?<Constant {"uV", "mV", "V ", "kV"}>`
        ADD      R0,SP,#+24
        LDM      R4!,{R1-R3}
        STM      R0!,{R1-R3}
        SUBS     R4,R4,#+12
        LDR.W    R0,??Calibrat_1+0x4  ;; Key_Buffer
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//   27   u16 i, j, k, Range, Target;
//   28 
//   29   I32STR_RES Num;
//   30   
//   31   Key_Buffer = 0; 
//   32   __Set(STANDBY, DN);                                   // 退出省电状态
        MOVS     R0,#+20
        BL       __Set
        LDR.W    R0,??Calibrat_1+0x8  ;; Title
        LDRSH    R0,[R0, #+916]
        ADDS     R0,R0,#+1
        MOVS     R1,#+10
        MULS     R1,R0,R1
        MOVS     R0,#+2
//   33   __Set(BACKLIGHT, 10*(Title[BK_LIGHT][CLASS].Value+1));
        BL       __Set
//   34   __Clear_Screen(BLACK);                                // 清屏幕
        MOVS     R0,#+0
        BL       __Clear_Screen
//   35   
//   36   k = Load_Parameter();                                 // 读取预设开机参数  
        BL       Load_Parameter
        STR      R0,[SP, #+20]
//   37   __Set(TRIGG_MODE, UNCONDITION);                       // 设任意触发
        MOVS     R1,#+32
        MOVS     R0,#+32
        BL       __Set
//   38   __Set(ADC_CTRL, EN);       
        MOVS     R1,#+1
        MOVS     R0,#+36
        BL       __Set
//   39   _Status = RUN;
        LDR.W    R0,??Calibrat_1+0x8  ;; Title
        MOVS     R1,#+0
        STRH     R1,[R0, #+336]
        LDRSH    R0,[R0, #+996]
        SUBS     R0,R0,#+1
        MOVS     R1,#+5
        MULS     R1,R0,R1
        MOVS     R0,#+3
//   40   __Set(BEEP_VOLUME, 5*(Title[VOLUME][CLASS].Value-1)); // Reload volume
        BL       __Set
        LDR.W    R0,??Calibrat_1+0xC  ;; Beep_mS
        MOV      R1,#+500
        STRH     R1,[R0, #+0]
        LDR.W    R0,??Calibrat_1+0x10  ;; Exit
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//   41   Beep_mS = 500;                                        // 蜂鸣器响500mS
//   42   Exit = 0;
//   43   Range = 0;
        MOV      R5,R1
//   44   Target = 0;
        MOV      R6,R1
//   45   Key_Buffer = 0; 
        LDR.W    R0,??Calibrat_1+0x4  ;; Key_Buffer
        STRB     R1,[R0, #+0]
//   46   
//   47   __Set(T_BASE_PSC, X_Attr[_100uS].PSC);                // T_BASE = 100uS
        LDR.W    R7,??Calibrat_1+0x14  ;; X_Attr
        LDR      R0,[R7, #+0]
        LDRSH    R1,[R0, #+268]
        MOVS     R0,#+7
        BL       __Set
//   48   __Set(T_BASE_ARR, X_Attr[_100uS].ARR);
        LDR      R0,[R7, #+0]
        ADD      R0,R0,#+270
        LDRH     R1,[R0, #+0]
        MOVS     R0,#+8
        BL       __Set
//   49 
//   50   __Set(CH_A_COUPLE, DC);
        MOV      R1,R5
        MOVS     R0,#+9
        BL       __Set
//   51   __Set(CH_A_OFFSET, 25);
        MOVS     R1,#+25
        MOV      R0,R5
        BL       __Set
//   52   __Set(CH_B_COUPLE, DC);
        MOV      R1,R5
        MOVS     R0,#+11
        BL       __Set
//   53   __Set(CH_B_OFFSET, 25);
        MOVS     R1,#+25
        MOVS     R0,#+1
        BL       __Set
//   54   
//   55   
//   56   for(j=0; j<220; j+=20){                               // 画表格  
        MOV      R7,R5
        MOVW     R10,#+399
        MOVW     R9,#+65535
//   57     for(i=0; i<399; i++){
??Calibrat_2:
        MOV      R8,R5
//   58       __Point_SCR(i, j);
??Calibrat_3:
        UXTH     R1,R7
        MOV      R0,R8
        BL       __Point_SCR
//   59       __LCD_SetPixl(WHT);
        MOV      R0,R9
        BL       __LCD_SetPixl
//   60     }
        ADD      R8,R8,#+1
        UXTH     R8,R8
        CMP      R8,R10
        BCC.N    ??Calibrat_3
//   61   }
        ADDS     R7,R7,#+20
        UXTH     R0,R7
        CMP      R0,#+220
        BCC.N    ??Calibrat_2
//   62   for(i=0; i<399; i++){
        MOVS     R7,#+0
//   63     __Point_SCR(i, 239);
??Calibrat_4:
        MOVS     R1,#+239
        MOVS     R0,R7
        BL       __Point_SCR
//   64     __LCD_SetPixl(WHT);
        MOV      R0,R9
        BL       __LCD_SetPixl
//   65   }
        ADDS     R7,R7,#+1
        UXTH     R7,R7
        CMP      R7,R10
        BCC.N    ??Calibrat_4
//   66   __Point_SCR(  0,  0);
        MOVS     R1,#+0
        MOV      R0,R1
        BL       __Point_SCR
//   67   for(j= 0; j<239; j++)  __LCD_SetPixl(WHT); 
        MOVS     R7,#+239
??Calibrat_5:
        MOV      R0,R9
        BL       __LCD_SetPixl
        SUBS     R7,R7,#+1
        BNE.N    ??Calibrat_5
//   68   __Point_SCR( 44, 20);
        MOVS     R1,#+20
        MOVS     R0,#+44
        BL       __Point_SCR
//   69   for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
        MOVS     R7,#+181
??Calibrat_6:
        MOV      R0,R9
        BL       __LCD_SetPixl
        SUBS     R7,R7,#+1
        BNE.N    ??Calibrat_6
//   70   __Point_SCR( 88, 20);
        MOVS     R1,#+20
        MOVS     R0,#+88
        BL       __Point_SCR
//   71   for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
        MOVS     R7,#+181
??Calibrat_7:
        MOV      R0,R9
        BL       __LCD_SetPixl
        SUBS     R7,R7,#+1
        BNE.N    ??Calibrat_7
//   72   __Point_SCR(132, 20);
        MOVS     R1,#+20
        MOVS     R0,#+132
        BL       __Point_SCR
//   73   for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
        MOVS     R7,#+181
??Calibrat_8:
        MOV      R0,R9
        BL       __LCD_SetPixl
        SUBS     R7,R7,#+1
        BNE.N    ??Calibrat_8
//   74   __Point_SCR(200, 20);
        MOVS     R1,#+20
        MOVS     R0,#+200
        BL       __Point_SCR
//   75   for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
        MOVS     R7,#+181
??Calibrat_9:
        MOV      R0,R9
        BL       __LCD_SetPixl
        SUBS     R7,R7,#+1
        BNE.N    ??Calibrat_9
//   76   __Point_SCR(244, 20);
        MOVS     R1,#+20
        MOVS     R0,#+244
        BL       __Point_SCR
//   77   for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
        MOVS     R7,#+181
??Calibrat_10:
        MOV      R0,R9
        BL       __LCD_SetPixl
        SUBS     R7,R7,#+1
        BNE.N    ??Calibrat_10
//   78   __Point_SCR(288, 20);
        MOVS     R1,#+20
        MOV      R0,#+288
        BL       __Point_SCR
//   79   for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
        MOVS     R7,#+181
??Calibrat_11:
        MOV      R0,R9
        BL       __LCD_SetPixl
        SUBS     R7,R7,#+1
        BNE.N    ??Calibrat_11
//   80   __Point_SCR(332, 20);
        MOVS     R1,#+20
        MOV      R0,#+332
        BL       __Point_SCR
//   81   for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
        MOVS     R7,#+181
??Calibrat_12:
        MOV      R0,R9
        BL       __LCD_SetPixl
        SUBS     R7,R7,#+1
        BNE.N    ??Calibrat_12
//   82   __Point_SCR(398, 0);
        MOVS     R1,#+0
        MOV      R0,#+398
        BL       __Point_SCR
//   83   for(j= 0; j<239; j++)  __LCD_SetPixl(WHT); 
        MOVS     R7,#+239
??Calibrat_13:
        MOV      R0,R9
        BL       __LCD_SetPixl
        SUBS     R7,R7,#+1
        BNE.N    ??Calibrat_13
//   84  
//   85   Print_Str(  6, 185, 0x0005, PRN, "CH_A");              // 显示表格标题栏
        ADD      R0,R4,#+12
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVS     R2,#+5
        MOVS     R1,#+185
        MOVS     R0,#+6
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
//   86   Print_Str( 49, 185, 0x0005, PRN, "ZERO");
        ADD      R0,R4,#+20
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOV      R3,R5
        MOVS     R2,#+5
        MOVS     R1,#+185
        MOVS     R0,#+49
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
//   87   Print_Str( 93, 185, 0x0005, PRN, "DIFF");
        ADD      R0,R4,#+28
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOV      R3,R5
        MOVS     R2,#+5
        MOVS     R1,#+185
        MOVS     R0,#+93
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
//   88   Print_Str(141, 185, 0x0005, PRN, "VOTAGE");
        ADD      R0,R4,#+36
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOV      R3,R5
        MOVS     R2,#+5
        MOVS     R1,#+185
        MOVS     R0,#+141
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
//   89   Print_Str(206, 185, 0x0105, PRN, "CH_B");
        MOVW     R11,#+261
        ADD      R0,R4,#+44
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOV      R3,R5
        MOV      R2,R11
        MOVS     R1,#+185
        MOVS     R0,#+206
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
//   90   Print_Str(249, 185, 0x0105, PRN, "ZERO");
        ADD      R0,R4,#+20
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOV      R3,R5
        MOV      R2,R11
        MOVS     R1,#+185
        MOVS     R0,#+249
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
//   91   Print_Str(293, 185, 0x0105, PRN, "DIFF");
        ADD      R0,R4,#+28
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOV      R3,R5
        MOV      R2,R11
        MOVS     R1,#+185
        MOVW     R0,#+293
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
//   92   Print_Str(342, 185, 0x0105, PRN, "VOTAGE");
        ADD      R0,R4,#+36
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOV      R3,R5
        MOV      R2,R11
        MOVS     R1,#+185
        MOV      R0,#+342
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
//   93     
//   94   for(i=0; i<G_Attr[0].Yp_Max+1; i++){
        MOV      R7,R5
        LDR.W    R10,??Calibrat_1+0x18  ;; Y_Attr
        MOV      R8,#+20
        LDR.W    R0,??Calibrat_1+0x1C  ;; G_Attr
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+4]
        ADDS     R0,R0,#+1
        CMP      R0,#+1
        BLT.N    ??Calibrat_14
//   95     Print_Str(  6, 166-(i*20), 0x0005, PRN, Y_Attr[i].STR);
??Calibrat_15:
        MUL      R0,R7,R8
        STR      R0,[SP, #+12]
        RSB      R0,R0,#+166
        STRH     R0,[SP, #+16]
        LDR      R0,[SP, #+12]
        LDR      R1,[R10, #+0]
        ADDS     R0,R0,R1
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVS     R2,#+5
        LDRH     R1,[SP, #+24]
        MOVS     R0,#+6
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
//   96     Print_Str(206, 166-(i*20), 0x0105, PRN, Y_Attr[i].STR);
        LDR      R0,[SP, #+12]
        LDR      R1,[R10, #+0]
        ADDS     R0,R0,R1
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOV      R3,R5
        MOV      R2,R11
        LDRH     R1,[SP, #+24]
        MOVS     R0,#+206
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
//   97   }
        ADDS     R7,R7,#+1
        UXTH     R7,R7
        LDR.W    R0,??Calibrat_1+0x1C  ;; G_Attr
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+4]
        ADDS     R0,R0,#+1
        CMP      R7,R0
        BLT.N    ??Calibrat_15
//   98   Print_Str( 10, 166-(8*20), 0x0405, PRN, (u8*)ExitStr[Exit % 3]);
??Calibrat_14:
        LDR.W    R0,??Calibrat_1+0x10  ;; Exit
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+3
        SDIV     R1,R0,R1
        MOVS     R2,#+3
        MLS      R0,R1,R2,R0
        MOVS     R1,#+30
        MLA      R0,R0,R1,R4
        ADD      R0,R0,#+524
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVW     R2,#+1029
        MOVS     R1,#+6
        MOVS     R0,#+10
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
//   99 
//  100   if(k != 0) {
        LDR      R0,[SP, #+20]
        UXTH     R0,R0
        CMP      R0,#+0
        BEQ.N    ??Calibrat_16
//  101     Print_Str( 32, 216, 0x0405, PRN, "         Parameters version error          ");
        ADD      R0,R4,#+52
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVW     R2,#+1029
        MOVS     R1,#+216
        MOVS     R0,#+32
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
//  102     __Set(BEEP_VOLUME, 5*(Title[VOLUME][CLASS].Value-1));// Volume
        LDR.W    R0,??Calibrat_1+0x8  ;; Title
        LDRSH    R0,[R0, #+996]
        SUBS     R0,R0,#+1
        MOVS     R1,#+5
        MULS     R1,R0,R1
        MOVS     R0,#+3
        BL       __Set
//  103     Beep_mS = 500;                                       // 蜂鸣器响500mS
        LDR.W    R0,??Calibrat_1+0xC  ;; Beep_mS
        MOV      R1,#+500
        STRH     R1,[R0, #+0]
//  104     Delayms(2000); 
        MOV      R0,#+2000
        BL       Delayms
//  105     App_init();
??Calibrat_17:
        BL       App_init
//  106     return;
??Calibrat_18:
        ADD      SP,SP,#+36
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        CFI CFA R13+72
//  107   }
//  108   while (1){
//  109     if(PD_Cnt == 0){
//  110       __Set(BACKLIGHT, 0);                         // 关闭背光
//  111       __Set(STANDBY, EN);                          // 进入省电状态
//  112       return;
//  113     }
//  114     JumpCnt =0;
//  115     Process();                                     // 采样波形处理   
//  116     if((Target == 1)||(Target == 4)){ 
//  117       A_Vdc = Ka1[Range]*10+(10*Ka2[Range]*(a_Avg/1024))/4096 - 1750;  
//  118       B_Vdc = Kb1[Range]*10+(10*Kb2[Range]*(b_Avg/1024))/4096 - 1750;  
//  119     } else {
//  120       A_Vdc = Ka1[Range] +(Ka2[Range] *((a_Avg+512)/1024))/4096 - 25;  
//  121       B_Vdc = Kb1[Range] +(Kb2[Range] *((b_Avg+512)/1024))/4096 - 25; 
//  122     }
//  123     if(__Get(FIFO_FULL))  __Set(FIFO_CLR, W_PTR); // FIFO写指针复位 
//  124 
//  125     if(Key_Buffer) { 
//  126       PD_Cnt = 600;                               // 600秒
//  127       if(Range < G_Attr[0].Yp_Max +1){
//  128         if(Target == 0){
//  129           Int32String_sign(&Num, A_Vdc);
//  130           Print_Str( 45, 166-(Range*20), 0x0005, PRN, Num.str);
//  131         }
//  132         if(Target == 1){
//  133           Int32String_sign(&Num, A_Vdc);
//  134           Print_Str( 89, 166-(Range*20), 0x0005, PRN, Num.str);
//  135         }
//  136         if(Target == 2){
//  137           Int32String_sign(&Num, A_Vdc * Y_Attr[Range].SCALE);
//  138           Print_Str(134, 166-(Range*20), 0x0005, PRN, Num.str);
//  139           Print_Str(174, 166-(Range*20), 0x0005, PRN, V_Unit[Num.decPos]);
//  140         }
//  141         if(Target == 3){
//  142           Int32String_sign(&Num, B_Vdc);
//  143           Print_Str(245, 166-(Range*20), 0x0105, PRN, Num.str);
//  144         }
//  145         if(Target == 4){
//  146           Int32String_sign(&Num, B_Vdc);
//  147           Print_Str(289, 166-(Range*20), 0x0105, PRN, Num.str);
//  148         }
//  149         if(Target == 5){
//  150           Int32String_sign(&Num, B_Vdc * Y_Attr[Range].SCALE);
//  151           Print_Str(334, 166-(Range*20), 0x0105, PRN, Num.str);
//  152           Print_Str(374, 166-(Range*20), 0x0105, PRN, V_Unit[Num.decPos]);
//  153         }
//  154       } else {
//  155         Print_Str(  10, 166-(8*20), 0x0405, PRN, (u8*)ExitStr[Exit % 3]);
//  156       }
//  157       switch (Key_Buffer){  
//  158       case KEY2:
//  159         if(Range < G_Attr[0].Yp_Max)  Range = G_Attr[0].Yp_Max;
//  160 //        if(Range >= G_Attr[0].Yp_Max){
//  161         if(Exit == 1){
//  162           Save_Parameter(0);                         // 保存校正后的参数
//  163           Print_Str( 32, 216, 0x0405, PRN, "         Save the calibration data         ");
//  164           Delayms(1000); 
//  165         }
//  166         if(Exit == 2){
//  167           memset(SecBuff,0,256);  
//  168           __Param_Area_WR(SecBuff, PAGE_0);          // 保存缺省值参数 
//  169           Print_Str( 32, 216, 0x0405, PRN, "           Restore defaults data           ");
//  170           Delayms(1000); 
//  171         }
//  172         App_init();
//  173         return;
//  174       case K_ITEM_S:
//  175         if(Target <5) Target++;
//  176         else          Target =0;
//  177         break;
//  178       case K_ITEM_DEC:
//  179         if(Range >0) Range--;
//  180         break;
//  181       case K_ITEM_INC:
//  182         if(Range  <= G_Attr[0].Yp_Max) Range++;
//  183 //        if(Range == G_Attr[0].Yp_Max)    Target = 0;
//  184         break;
//  185       case K_INDEX_DEC:
//  186         if(Target == 0)  Ka1[Range]--;
//  187         if(Target == 1)  Ka2[Range]--;
//  188         if(Target == 2)  Ka3--;
//  189         if(Target == 3)  Kb1[Range]--;
//  190         if(Target == 4)  Kb2[Range]--;
//  191         if(Target == 5)  Kb3--;
//  192         if(Range >= G_Attr[0].Yp_Max) Exit--;
//  193         break;
//  194       case K_INDEX_INC:
//  195         if(Target == 0)  Ka1[Range]++;
//  196         if(Target == 1)  Ka2[Range]++;
//  197         if(Target == 2)  Ka3++;
//  198         if(Target == 3)  Kb1[Range]++;
//  199         if(Target == 4)  Kb2[Range]++;
//  200         if(Target == 3)  Kb3++;
//  201         if(Range >= G_Attr[0].Yp_Max) Exit++;
//  202         break;
//  203       }
//  204       Key_Buffer = 0;
//  205       if((Target == 1)||(Target == 4)){ 
//  206         __Set(CH_A_OFFSET, (Ka3 * 175)/256);
//  207         __Set(CH_B_OFFSET, (Kb3 * 175)/256);
//  208       } else {
//  209         __Set(CH_A_OFFSET, (Ka3 * 25)/256);
//  210         __Set(CH_B_OFFSET, (Kb3 * 25)/256);
//  211       }
//  212       __Set(CH_A_RANGE, Range);
//  213       __Set(CH_B_RANGE, Range);
//  214     }
//  215     
//  216     if(Blink){ 
//  217       Blink = 0;
//  218       if(Range < G_Attr[0].Yp_Max +1){
//  219         if(Target == 0){
//  220           Int32String_sign(&Num, A_Vdc);
//  221           Print_Str( 45, 166-(Range*20), 0x0005, Twink, Num.str);
//  222         }
//  223         if(Target == 1){
//  224           Int32String_sign(&Num, A_Vdc);
//  225           Print_Str( 89, 166-(Range*20), 0x0005, Twink, Num.str);
//  226         }
//  227         if(Target == 2){
//  228           Int32String_sign(&Num, A_Vdc * Y_Attr[Range].SCALE);
//  229           Print_Str(134, 166-(Range*20), 0x0005, Twink, Num.str);
//  230           Print_Str(174, 166-(Range*20), 0x0005, Twink, V_Unit[Num.decPos]);
//  231         }
//  232         if(Target == 3){
//  233           Int32String_sign(&Num, B_Vdc);
//  234           Print_Str(245, 166-(Range*20), 0x0105, Twink, Num.str);
//  235         }
//  236         if(Target == 4){
//  237           Int32String_sign(&Num, B_Vdc);
//  238           Print_Str(289, 166-(Range*20), 0x0105, Twink, Num.str);
//  239         }
//  240         if(Target == 5){
//  241           Int32String_sign(&Num, B_Vdc * Y_Attr[Range].SCALE);
//  242           Print_Str(334, 166-(Range*20), 0x0105, Twink, Num.str);
//  243           Print_Str(374, 166-(Range*20), 0x0105, Twink, V_Unit[Num.decPos]);
//  244         } 
//  245         if((Target == 2)||(Target == 5)){
//  246           if     (strcmp((char const*)Y_Attr[Range].STR, "20mV") == 0)  i = 0; 
//  247           else if(strcmp((char const*)Y_Attr[Range].STR, "50mV") == 0)  i = 1; 
//  248           else if(strcmp((char const*)Y_Attr[Range].STR, "0.1V") == 0)  i = 2; 
//  249           else if(strcmp((char const*)Y_Attr[Range].STR, "0.2V") == 0)  i = 3; 
//  250           else if(strcmp((char const*)Y_Attr[Range].STR, "0.5V") == 0)  i = 4; 
//  251           else if(strcmp((char const*)Y_Attr[Range].STR, " 1V ") == 0)  i = 5; 
//  252           else if(strcmp((char const*)Y_Attr[Range].STR, " 2V ") == 0)  i = 6; 
//  253           else if(strcmp((char const*)Y_Attr[Range].STR, " 5V ") == 0)  i = 7; 
//  254           else if(strcmp((char const*)Y_Attr[Range].STR, "!10V!")== 0)  i = 8; 
//  255           else                                             i = 9; 
//  256           Print_Str(  4*8, 216, 0x0605, PRN, " Input ");
//  257           Print_Str( 11*8, 216, 0x0405, PRN, (u8*)VS_STR[i]);
//  258           Print_Str( 21*8, 216, 0x0605, PRN, "standard voltage to ");
//  259           if(Target < 3) Print_Str( 41*8, 216, 0x0005, PRN, "CH_A  ");
//  260           else           Print_Str( 41*8, 216, 0x0105, PRN, "CH_B  ");
//  261         } else {
//  262           Print_Str(  4*8, 216, 0x0605, PRN, "     Please connect");
//  263           Print_Str( 29*8, 216, 0x0605, PRN, "input to GND       ");
//  264           if(Target < 3) Print_Str( 23*8, 216, 0x0105, PRN, " CH_A ");
//  265           else           Print_Str( 23*8, 216, 0x0005, PRN, " CH_B ");
//  266         }
//  267       } else {
//  268         Print_Str( 10, 166-(8*20), 0x0405, Twink, (u8*)ExitStr[Exit % 3]);
??Calibrat_19:
        LDR.W    R0,??Calibrat_1+0x10  ;; Exit
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+3
        SDIV     R1,R0,R1
        MOVS     R2,#+3
        MLS      R0,R1,R2,R0
        MOVS     R1,#+30
        MLA      R0,R0,R1,R4
        ADD      R0,R0,#+524
        PUSH     {R0,LR}
        CFI CFA R13+80
        LDR.W    R0,??Calibrat_1+0x20  ;; Twink
        LDRB     R3,[R0, #+0]
        MOVW     R2,#+1029
        MOVS     R1,#+6
        MOVS     R0,#+10
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
//  269         Print_Str(4*8, 216, 0x0605, PRN, "    Push the . key to confirm exit        ");
        ADD      R0,R4,#+360
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVW     R2,#+1541
        MOVS     R1,#+216
        MOVS     R0,#+32
??Calibrat_20:
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
//  270       }
??Calibrat_16:
        LDR.W    R8,??Calibrat_1+0x24  ;; PD_Cnt
        LDRH     R0,[R8, #+0]
        CBNZ     R0,??Calibrat_21
        MOVS     R1,#+0
        MOVS     R0,#+2
        BL       __Set
        MOVS     R1,#+1
        MOVS     R0,#+20
        BL       __Set
        B.N      ??Calibrat_18
??Calibrat_21:
        LDR.W    R0,??Calibrat_1+0x28  ;; JumpCnt
        MOVS     R1,#+0
        STRH     R1,[R0, #+0]
        BL       Process
        UXTH     R0,R6
        CMP      R0,#+1
        BEQ.N    ??Calibrat_22
        CMP      R0,#+4
        BNE.N    ??Calibrat_23
??Calibrat_22:
        UXTH     R7,R5
        LDR.W    R0,??Calibrat_1+0x2C  ;; Ka2
        LDRH     R0,[R0, R7, LSL #+1]
        MOVS     R1,#+10
        MULS     R0,R0,R1
        LDR.W    R1,??Calibrat_1+0x30  ;; a_Avg
        LDR      R1,[R1, #+0]
        LSRS     R1,R1,#+10
        MULS     R0,R0,R1
        LSRS     R0,R0,#+12
        LDR.W    R1,??Calibrat_1+0x34  ;; Ka1
        LDRSB    R1,[R7, R1]
        MOVS     R2,#+10
        MLA      R0,R1,R2,R0
        SUBW     R0,R0,#+1750
        LDR.W    R1,??Calibrat_1+0x38  ;; Kb2
        LDRH     R1,[R1, R7, LSL #+1]
        MULS     R1,R1,R2
        LDR.W    R2,??Calibrat_1+0x3C  ;; b_Avg
        LDR      R2,[R2, #+0]
        LSRS     R2,R2,#+10
        MULS     R1,R1,R2
        LSRS     R1,R1,#+12
        LDR.W    R2,??Calibrat_1+0x40  ;; Kb1
        LDRSB    R2,[R7, R2]
        MOVS     R3,#+10
        MLA      R1,R2,R3,R1
        SUBW     R1,R1,#+1750
        B.N      ??Calibrat_24
??Calibrat_23:
        UXTH     R7,R5
        LDR.W    R0,??Calibrat_1+0x2C  ;; Ka2
        LDRH     R0,[R0, R7, LSL #+1]
        LDR.W    R1,??Calibrat_1+0x30  ;; a_Avg
        LDR      R1,[R1, #+0]
        ADD      R1,R1,#+512
        LSRS     R1,R1,#+10
        MULS     R0,R0,R1
        LDR.W    R1,??Calibrat_1+0x34  ;; Ka1
        LDRSB    R1,[R7, R1]
        ADD      R0,R1,R0, LSR #+12
        SUBS     R0,R0,#+25
        LDR.W    R1,??Calibrat_1+0x38  ;; Kb2
        LDRH     R1,[R1, R7, LSL #+1]
        LDR.W    R2,??Calibrat_1+0x3C  ;; b_Avg
        LDR      R2,[R2, #+0]
        ADD      R2,R2,#+512
        LSRS     R2,R2,#+10
        MULS     R1,R1,R2
        LDR.W    R2,??Calibrat_1+0x40  ;; Kb1
        LDRSB    R2,[R7, R2]
        ADD      R1,R2,R1, LSR #+12
        SUBS     R1,R1,#+25
??Calibrat_24:
        LDR.W    R2,??Calibrat_1+0x44  ;; B_Vdc
        STRH     R1,[R2, #+0]
        LDR.W    R10,??Calibrat_1+0x48  ;; A_Vdc
        STRH     R0,[R10, #+0]
        MOVS     R0,#+3
        BL       __Get
        CBZ      R0,??Calibrat_25
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
??Calibrat_25:
        LDR.W    R0,??Calibrat_1+0x4  ;; Key_Buffer
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.W    ??Calibrat_26
        MOV      R0,#+600
        STRH     R0,[R8, #+0]
        LDR.W    R0,??Calibrat_1+0x1C  ;; G_Attr
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+4]
        ADDS     R0,R0,#+1
        CMP      R7,R0
        BGE.W    ??Calibrat_27
        UXTH     R0,R6
        CBNZ     R0,??Calibrat_28
        LDRSH    R1,[R10, #+0]
        ADD      R0,SP,#+0
        BL       Int32String_sign
        ADD      R0,SP,#+2
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVS     R2,#+5
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVS     R0,#+45
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
??Calibrat_28:
        UXTH     R0,R6
        CMP      R0,#+1
        BNE.N    ??Calibrat_29
        LDRSH    R1,[R10, #+0]
        ADD      R0,SP,#+0
        BL       Int32String_sign
        ADD      R0,SP,#+2
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVS     R2,#+5
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVS     R0,#+89
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
??Calibrat_29:
        UXTH     R0,R6
        CMP      R0,#+2
        BNE.N    ??Calibrat_30
        MOV      R8,#+20
        MUL      R8,R7,R8
        LDRSH    R0,[R10, #+0]
        LDR.W    R1,??Calibrat_1+0x18  ;; Y_Attr
        LDR      R1,[R1, #+0]
        ADD      R1,R8,R1
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADD      R0,SP,#+0
        BL       Int32String_sign
        RSB      R8,R8,#+166
        ADD      R0,SP,#+2
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVS     R2,#+5
        UXTH     R1,R8
        MOVS     R0,#+134
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
        LDRB     R0,[SP, #+0]
        MOVS     R1,#+3
        ADD      R2,SP,#+24
        MLA      R0,R0,R1,R2
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVS     R2,#+5
        UXTH     R1,R8
        MOVS     R0,#+174
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
??Calibrat_30:
        UXTH     R0,R6
        CMP      R0,#+3
        BNE.N    ??Calibrat_31
        LDR.W    R0,??Calibrat_1+0x44  ;; B_Vdc
        LDRSH    R1,[R0, #+0]
        ADD      R0,SP,#+0
        BL       Int32String_sign
        ADD      R0,SP,#+2
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOV      R2,R11
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVS     R0,#+245
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
??Calibrat_31:
        UXTH     R0,R6
        CMP      R0,#+4
        BNE.N    ??Calibrat_32
        LDR.W    R0,??Calibrat_1+0x44  ;; B_Vdc
        LDRSH    R1,[R0, #+0]
        ADD      R0,SP,#+0
        BL       Int32String_sign
        ADD      R0,SP,#+2
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOV      R2,R11
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVW     R0,#+289
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
??Calibrat_32:
        UXTH     R0,R6
        CMP      R0,#+5
        BNE.N    ??Calibrat_33
        MOV      R8,#+20
        MUL      R8,R7,R8
        LDR.W    R0,??Calibrat_1+0x44  ;; B_Vdc
        LDRSH    R0,[R0, #+0]
        LDR.W    R1,??Calibrat_1+0x18  ;; Y_Attr
        LDR      R1,[R1, #+0]
        ADD      R1,R8,R1
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADD      R0,SP,#+0
        BL       Int32String_sign
        RSB      R8,R8,#+166
        ADD      R0,SP,#+2
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOV      R2,R11
        UXTH     R1,R8
        MOV      R0,#+334
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
        LDRB     R0,[SP, #+0]
        MOVS     R1,#+3
        ADD      R2,SP,#+24
        MLA      R0,R0,R1,R2
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOV      R2,R11
        UXTH     R1,R8
        MOV      R0,#+374
        B.N      ??Calibrat_34
        CFI CFA R13+72
??Calibrat_27:
        LDR.W    R0,??Calibrat_1+0x10  ;; Exit
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+3
        SDIV     R1,R0,R1
        MOVS     R2,#+3
        MLS      R0,R1,R2,R0
        MOVS     R1,#+30
        MLA      R0,R0,R1,R4
        ADD      R0,R0,#+524
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVW     R2,#+1029
        MOVS     R1,#+6
        MOVS     R0,#+10
??Calibrat_34:
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
??Calibrat_33:
        LDR.W    R0,??Calibrat_1+0x4  ;; Key_Buffer
        LDRB     R0,[R0, #+0]
        SUBS     R0,R0,#+2
        CMP      R0,#+8
        BHI.W    ??Calibrat_35
        TBB      [PC, R0]
        DATA
??Calibrat_0:
        DC8      +5,+216,+216,+86
        DC8      +151,+216,+76,+69
        DC8      +61,+0
        THUMB
??Calibrat_36:
        LDR.W    R0,??Calibrat_1+0x10  ;; Exit
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??Calibrat_37
        MOVS     R0,#+0
        BL       Save_Parameter
        ADD      R0,R4,#+96
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVW     R2,#+1029
        MOVS     R1,#+216
        MOVS     R0,#+32
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
        MOV      R0,#+1000
        BL       Delayms
??Calibrat_37:
        LDR.W    R0,??Calibrat_1+0x10  ;; Exit
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.W    ??Calibrat_17
        LDR.W    R5,??Calibrat_1+0x4C  ;; SecBuff
        MOV      R1,#+256
        MOVS     R0,R5
        BL       __aeabi_memclr
        MOVS     R1,#+0
        MOVS     R0,R5
        BL       __Param_Area_WR
        ADD      R0,R4,#+140
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVW     R2,#+1029
        MOVS     R1,#+216
        MOVS     R0,#+32
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
        MOV      R0,#+1000
        BL       Delayms
??Calibrat_38:
        B.N      ??Calibrat_17
??Calibrat_39:
        UXTH     R0,R6
        CMP      R0,#+5
        BCS.N    ??Calibrat_40
        ADDS     R6,R6,#+1
        UXTH     R6,R6
        B.N      ??Calibrat_35
??Calibrat_40:
        MOVS     R6,#+0
        B.N      ??Calibrat_35
??Calibrat_41:
        UXTH     R0,R5
        CMP      R0,#+0
        BEQ.W    ??Calibrat_35
        ADD      R5,R9,R5
??Calibrat_42:
        UXTH     R5,R5
        B.N      ??Calibrat_35
??Calibrat_43:
        LDR.W    R0,??Calibrat_1+0x1C  ;; G_Attr
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+4]
        UXTH     R1,R5
        CMP      R0,R1
        BCC.W    ??Calibrat_35
        ADDS     R5,R5,#+1
        B.N      ??Calibrat_42
??Calibrat_44:
        UXTH     R0,R6
        CBNZ     R0,??Calibrat_45
        LDR.W    R0,??Calibrat_1+0x34  ;; Ka1
        LDRB     R1,[R7, R0]
        SUBS     R1,R1,#+1
        STRB     R1,[R7, R0]
??Calibrat_45:
        UXTH     R0,R6
        CMP      R0,#+1
        BNE.N    ??Calibrat_46
        LDR.W    R0,??Calibrat_1+0x2C  ;; Ka2
        LDRH     R1,[R0, R7, LSL #+1]
        ADD      R1,R9,R1
        STRH     R1,[R0, R7, LSL #+1]
??Calibrat_46:
        UXTH     R0,R6
        CMP      R0,#+2
        BNE.N    ??Calibrat_47
        LDR.W    R0,??Calibrat_1+0x50  ;; Ka3
        LDRH     R1,[R0, #+0]
        ADD      R1,R9,R1
        STRH     R1,[R0, #+0]
??Calibrat_47:
        UXTH     R0,R6
        CMP      R0,#+3
        BNE.N    ??Calibrat_48
        LDR.W    R0,??Calibrat_1+0x40  ;; Kb1
        LDRB     R1,[R7, R0]
        SUBS     R1,R1,#+1
        STRB     R1,[R7, R0]
??Calibrat_48:
        UXTH     R0,R6
        CMP      R0,#+4
        BNE.N    ??Calibrat_49
        LDR.W    R0,??Calibrat_1+0x38  ;; Kb2
        LDRH     R1,[R0, R7, LSL #+1]
        ADD      R1,R9,R1
        STRH     R1,[R0, R7, LSL #+1]
??Calibrat_49:
        UXTH     R0,R6
        CMP      R0,#+5
        BNE.N    ??Calibrat_50
        LDR.W    R0,??Calibrat_1+0x54  ;; Kb3
        LDRH     R1,[R0, #+0]
        ADD      R1,R9,R1
        STRH     R1,[R0, #+0]
??Calibrat_50:
        LDR.W    R1,??Calibrat_1+0x1C  ;; G_Attr
        LDR      R1,[R1, #+0]
        LDRH     R1,[R1, #+4]
        UXTH     R0,R5
        CMP      R0,R1
        BCC.N    ??Calibrat_35
        LDR.W    R0,??Calibrat_1+0x10  ;; Exit
        LDRB     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.W    R1,??Calibrat_1+0x10  ;; Exit
        B.N      ??Calibrat_51
??Calibrat_52:
        UXTH     R0,R6
        CBNZ     R0,??Calibrat_53
        LDR.W    R0,??Calibrat_1+0x34  ;; Ka1
        LDRB     R1,[R7, R0]
        ADDS     R1,R1,#+1
        STRB     R1,[R7, R0]
??Calibrat_53:
        UXTH     R0,R6
        CMP      R0,#+1
        BNE.N    ??Calibrat_54
        LDR.W    R0,??Calibrat_1+0x2C  ;; Ka2
        LDRH     R1,[R0, R7, LSL #+1]
        ADDS     R1,R1,#+1
        STRH     R1,[R0, R7, LSL #+1]
??Calibrat_54:
        UXTH     R0,R6
        CMP      R0,#+2
        BNE.N    ??Calibrat_55
        LDR.W    R0,??Calibrat_1+0x50  ;; Ka3
        LDRH     R1,[R0, #+0]
        ADDS     R1,R1,#+1
        STRH     R1,[R0, #+0]
??Calibrat_55:
        UXTH     R0,R6
        CMP      R0,#+3
        BNE.N    ??Calibrat_56
        LDR.W    R0,??Calibrat_1+0x40  ;; Kb1
        LDRB     R1,[R7, R0]
        ADDS     R1,R1,#+1
        STRB     R1,[R7, R0]
??Calibrat_56:
        UXTH     R0,R6
        CMP      R0,#+4
        BNE.N    ??Calibrat_57
        LDR.W    R0,??Calibrat_1+0x38  ;; Kb2
        LDRH     R1,[R0, R7, LSL #+1]
        ADDS     R1,R1,#+1
        STRH     R1,[R0, R7, LSL #+1]
??Calibrat_57:
        UXTH     R0,R6
        CMP      R0,#+3
        BNE.N    ??Calibrat_58
        LDR.W    R0,??Calibrat_1+0x54  ;; Kb3
        LDRH     R1,[R0, #+0]
        ADDS     R1,R1,#+1
        STRH     R1,[R0, #+0]
??Calibrat_58:
        LDR.W    R1,??Calibrat_1+0x1C  ;; G_Attr
        LDR      R1,[R1, #+0]
        LDRH     R1,[R1, #+4]
        UXTH     R0,R5
        CMP      R0,R1
        BCC.N    ??Calibrat_35
        LDR.W    R0,??Calibrat_1+0x10  ;; Exit
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??Calibrat_1+0x10  ;; Exit
??Calibrat_51:
        STRB     R0,[R1, #+0]
??Calibrat_35:
        LDR.W    R0,??Calibrat_1+0x4  ;; Key_Buffer
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
        UXTH     R0,R6
        CMP      R0,#+1
        BEQ.N    ??Calibrat_59
        CMP      R0,#+4
        BNE.N    ??Calibrat_60
??Calibrat_59:
        MOVS     R7,#+175
        LDR.W    R0,??Calibrat_1+0x50  ;; Ka3
        LDRH     R0,[R0, #+0]
        MULS     R0,R0,R7
        ASRS     R1,R0,#+7
        ADD      R0,R0,R1, LSR #+24
        ASRS     R1,R0,#+8
        MOVS     R0,#+0
        BL       __Set
        LDR.W    R0,??Calibrat_1+0x54  ;; Kb3
        LDRH     R0,[R0, #+0]
        MULS     R0,R0,R7
        ASRS     R1,R0,#+7
        ADD      R0,R0,R1, LSR #+24
        B.N      ??Calibrat_61
??Calibrat_60:
        MOVS     R7,#+25
        LDR.W    R0,??Calibrat_1+0x50  ;; Ka3
        LDRH     R0,[R0, #+0]
        MULS     R0,R0,R7
        ASRS     R1,R0,#+7
        ADD      R0,R0,R1, LSR #+24
        ASRS     R1,R0,#+8
        MOVS     R0,#+0
        BL       __Set
        LDR.W    R0,??Calibrat_1+0x54  ;; Kb3
        LDRH     R0,[R0, #+0]
        MULS     R0,R0,R7
        ASRS     R1,R0,#+7
        ADD      R0,R0,R1, LSR #+24
??Calibrat_61:
        ASRS     R1,R0,#+8
        MOVS     R0,#+1
        BL       __Set
        UXTH     R7,R5
        MOVS     R1,R7
        MOVS     R0,#+10
        BL       __Set
        MOVS     R1,R7
        MOVS     R0,#+12
        BL       __Set
??Calibrat_26:
        LDR.W    R0,??Calibrat_1+0x58  ;; Blink
        LDRB     R1,[R0, #+0]
        CMP      R1,#+0
        BEQ.W    ??Calibrat_16
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
        UXTH     R7,R5
        LDR.N    R0,??Calibrat_1+0x1C  ;; G_Attr
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+4]
        ADDS     R0,R0,#+1
        CMP      R7,R0
        BGE.W    ??Calibrat_19
        UXTH     R0,R6
        CBNZ     R0,??Calibrat_62
        LDRSH    R1,[R10, #+0]
        ADD      R0,SP,#+0
        BL       Int32String_sign
        ADD      R0,SP,#+2
        PUSH     {R0,LR}
        CFI CFA R13+80
        LDR.N    R0,??Calibrat_1+0x20  ;; Twink
        LDRB     R3,[R0, #+0]
        MOVS     R2,#+5
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVS     R0,#+45
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
??Calibrat_62:
        UXTH     R0,R6
        CMP      R0,#+1
        BNE.N    ??Calibrat_63
        LDRSH    R1,[R10, #+0]
        ADD      R0,SP,#+0
        BL       Int32String_sign
        ADD      R0,SP,#+2
        PUSH     {R0,LR}
        CFI CFA R13+80
        LDR.N    R0,??Calibrat_1+0x20  ;; Twink
        LDRB     R3,[R0, #+0]
        MOVS     R2,#+5
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVS     R0,#+89
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
??Calibrat_63:
        UXTH     R0,R6
        CMP      R0,#+2
        BNE.N    ??Calibrat_64
        MOV      R8,#+20
        MUL      R8,R7,R8
        LDRSH    R0,[R10, #+0]
        LDR.N    R1,??Calibrat_1+0x18  ;; Y_Attr
        LDR      R1,[R1, #+0]
        ADD      R1,R8,R1
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADD      R0,SP,#+0
        BL       Int32String_sign
        RSB      R10,R8,#+166
        LDR.W    R8,??Calibrat_1+0x20  ;; Twink
        ADD      R0,SP,#+2
        PUSH     {R0,LR}
        CFI CFA R13+80
        LDRB     R3,[R8, #+0]
        MOVS     R2,#+5
        UXTH     R1,R10
        MOVS     R0,#+134
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
        LDRB     R0,[SP, #+0]
        MOVS     R1,#+3
        ADD      R2,SP,#+24
        MLA      R0,R0,R1,R2
        PUSH     {R0,LR}
        CFI CFA R13+80
        LDRB     R3,[R8, #+0]
        MOVS     R2,#+5
        UXTH     R1,R10
        MOVS     R0,#+174
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
??Calibrat_64:
        UXTH     R0,R6
        CMP      R0,#+3
        BNE.N    ??Calibrat_65
        LDR.N    R0,??Calibrat_1+0x44  ;; B_Vdc
        LDRSH    R1,[R0, #+0]
        ADD      R0,SP,#+0
        BL       Int32String_sign
        ADD      R0,SP,#+2
        PUSH     {R0,LR}
        CFI CFA R13+80
        LDR.N    R0,??Calibrat_1+0x20  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R11
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVS     R0,#+245
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
??Calibrat_65:
        UXTH     R0,R6
        CMP      R0,#+4
        BNE.N    ??Calibrat_66
        LDR.N    R0,??Calibrat_1+0x44  ;; B_Vdc
        LDRSH    R1,[R0, #+0]
        ADD      R0,SP,#+0
        BL       Int32String_sign
        ADD      R0,SP,#+2
        PUSH     {R0,LR}
        CFI CFA R13+80
        LDR.N    R0,??Calibrat_1+0x20  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R11
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVW     R0,#+289
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
??Calibrat_66:
        UXTH     R0,R6
        CMP      R0,#+5
        BNE.N    ??Calibrat_67
        MOV      R8,#+20
        MUL      R8,R7,R8
        LDR.N    R0,??Calibrat_1+0x44  ;; B_Vdc
        LDRSH    R0,[R0, #+0]
        LDR.N    R1,??Calibrat_1+0x18  ;; Y_Attr
        LDR      R1,[R1, #+0]
        ADD      R1,R8,R1
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADD      R0,SP,#+0
        BL       Int32String_sign
        RSB      R10,R8,#+166
        LDR.W    R8,??Calibrat_1+0x20  ;; Twink
        ADD      R0,SP,#+2
        PUSH     {R0,LR}
        CFI CFA R13+80
        LDRB     R3,[R8, #+0]
        MOV      R2,R11
        UXTH     R1,R10
        MOV      R0,#+334
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
        LDRB     R0,[SP, #+0]
        MOVS     R1,#+3
        ADD      R2,SP,#+24
        MLA      R0,R0,R1,R2
        PUSH     {R0,LR}
        CFI CFA R13+80
        LDRB     R3,[R8, #+0]
        MOV      R2,R11
        UXTH     R1,R10
        MOV      R0,#+374
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
??Calibrat_67:
        UXTH     R0,R6
        CMP      R0,#+2
        BEQ.N    ??Calibrat_68
        CMP      R0,#+5
        BNE.W    ??Calibrat_69
??Calibrat_68:
        MOV      R8,#+20
        MUL      R8,R7,R8
        LDR.W    R10,??Calibrat_1+0x18  ;; Y_Attr
        ADD      R1,R4,#+248
        LDR      R0,[R10, #+0]
        ADD      R0,R8,R0
        BL       strcmp
        CBNZ     R0,??Calibrat_70
        MOVS     R7,#+0
        B.N      ??Calibrat_71
??Calibrat_70:
        ADD      R1,R4,#+240
        LDR      R0,[R10, #+0]
        ADD      R0,R8,R0
        BL       strcmp
        CBNZ     R0,??Calibrat_72
        MOVS     R7,#+1
        B.N      ??Calibrat_71
??Calibrat_72:
        ADD      R1,R4,#+232
        LDR      R0,[R10, #+0]
        ADD      R0,R8,R0
        BL       strcmp
        CBNZ     R0,??Calibrat_73
        MOVS     R7,#+2
        B.N      ??Calibrat_71
??Calibrat_73:
        ADD      R1,R4,#+224
        LDR      R0,[R10, #+0]
        ADD      R0,R8,R0
        BL       strcmp
        CBNZ     R0,??Calibrat_74
        MOVS     R7,#+3
        B.N      ??Calibrat_71
??Calibrat_74:
        ADD      R1,R4,#+216
        LDR      R0,[R10, #+0]
        ADD      R0,R8,R0
        BL       strcmp
        CBNZ     R0,??Calibrat_75
        MOVS     R7,#+4
        B.N      ??Calibrat_71
??Calibrat_75:
        ADD      R1,R4,#+208
        LDR      R0,[R10, #+0]
        ADD      R0,R8,R0
        BL       strcmp
        CBNZ     R0,??Calibrat_76
        MOVS     R7,#+5
        B.N      ??Calibrat_71
??Calibrat_76:
        ADD      R1,R4,#+200
        LDR      R0,[R10, #+0]
        ADD      R0,R8,R0
        BL       strcmp
        CBNZ     R0,??Calibrat_77
        MOVS     R7,#+6
        B.N      ??Calibrat_71
??Calibrat_77:
        ADD      R1,R4,#+192
        LDR      R0,[R10, #+0]
        ADD      R0,R8,R0
        BL       strcmp
        CBNZ     R0,??Calibrat_78
        MOVS     R7,#+7
        B.N      ??Calibrat_71
??Calibrat_78:
        ADD      R1,R4,#+184
        LDR      R0,[R10, #+0]
        ADD      R0,R8,R0
        BL       strcmp
        CBNZ     R0,??Calibrat_79
        MOVS     R7,#+8
        B.N      ??Calibrat_71
??Calibrat_79:
        MOVS     R7,#+9
??Calibrat_71:
        MOVW     R8,#+1541
        ADD      R0,R4,#+256
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOV      R2,R8
        MOVS     R1,#+216
        MOVS     R0,#+32
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
        MOVS     R0,#+12
        MLA      R0,R7,R0,R4
        ADD      R0,R0,#+404
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVW     R2,#+1029
        MOVS     R1,#+216
        MOVS     R0,#+88
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
        ADD      R0,R4,#+264
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOV      R2,R8
        MOVS     R1,#+216
        MOVS     R0,#+168
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
        UXTH     R0,R6
        CMP      R0,#+3
        BCS.N    ??Calibrat_80
        ADD      R0,R4,#+288
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVS     R2,#+5
        MOVS     R1,#+216
        MOV      R0,#+328
        B.N      ??Calibrat_20
        CFI CFA R13+72
??Calibrat_80:
        ADD      R0,R4,#+296
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOV      R2,R11
        MOVS     R1,#+216
        MOV      R0,#+328
        B.N      ??Calibrat_20
        CFI CFA R13+72
??Calibrat_69:
        MOVW     R8,#+1541
        ADD      R0,R4,#+304
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOV      R2,R8
        MOVS     R1,#+216
        MOVS     R0,#+32
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
        ADD      R0,R4,#+324
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOV      R2,R8
        MOVS     R1,#+216
        MOVS     R0,#+232
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+72
        UXTH     R0,R6
        CMP      R0,#+3
        BCS.N    ??Calibrat_81
        ADD      R0,R4,#+344
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOV      R2,R11
        MOVS     R1,#+216
        MOVS     R0,#+184
        B.W      ??Calibrat_20
        CFI CFA R13+72
??Calibrat_81:
        ADD      R0,R4,#+352
        PUSH     {R0,LR}
        CFI CFA R13+80
        MOVS     R3,#+0
        MOVS     R2,#+5
        MOVS     R1,#+216
        MOVS     R0,#+184
        B.W      ??Calibrat_20
        Nop      
        DATA
??Calibrat_1:
        DC32     `?<Constant {"uV", "mV", "V ", "kV"}>`
        DC32     Key_Buffer
        DC32     Title
        DC32     Beep_mS
        DC32     Exit
        DC32     X_Attr
        DC32     Y_Attr
        DC32     G_Attr
        DC32     Twink
        DC32     PD_Cnt
        DC32     JumpCnt
        DC32     Ka2
        DC32     a_Avg
        DC32     Ka1
        DC32     Kb2
        DC32     b_Avg
        DC32     Kb1
        DC32     B_Vdc
        DC32     A_Vdc
        DC32     SecBuff
        DC32     Ka3
        DC32     Kb3
        DC32     Blink
        CFI EndBlock cfiBlock0
//  271     }
//  272   }
//  273 }

        END
//  274 /*********************************  END OF FILE  ******************************/
// 
//     1 byte  in section .bss
//   616 bytes in section .rodata
// 3 104 bytes in section .text
// 
// 3 104 bytes of CODE  memory
//   616 bytes of CONST memory
//     1 byte  of DATA  memory
//
//Errors: none
//Warnings: none
