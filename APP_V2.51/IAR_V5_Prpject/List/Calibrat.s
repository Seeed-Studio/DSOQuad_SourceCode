///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  11:07:50 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\APP_V2.51\source\Calibrat.c            /
//    Command line =  E:\Mini-DS\DS203\APP_V2.51\source\Calibrat.c -lA        /
//                    E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\List\ -o      /
//                    E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\Obj\ --debug  /
//                    --endian=little --cpu=Cortex-M3 --fpu=None              /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.0 Evaluation\ARM\INC\DLib_Config_Full.h"    /
//                    -I E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\..\..\FWLi /
//                    b\inc\ -I E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\..\ /
//                    ..\USBLib\inc\ -I E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prp /
//                    ject\..\include\ -I "C:\Program Files\IAR               /
//                    Systems\Embedded Workbench 5.0 Evaluation\ARM\INC\"     /
//                    -Ohs                                                    /
//    List file    =  E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\List\Calibrat /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Calibrat

        EXTERN App_init
        EXTERN Beep_mS
        EXTERN Blink
        EXTERN DataBuf
        EXTERN Delayms
        EXTERN G_Attr
        EXTERN Int2Str
        EXTERN Interlace
        EXTERN Ka1
        EXTERN Ka2
        EXTERN Ka3
        EXTERN Kab
        EXTERN Kb1
        EXTERN Kb2
        EXTERN Kb3
        EXTERN Key_Buffer
        EXTERN PD_Cnt
        EXTERN Print_Str
        EXTERN Save_Param
        EXTERN Title
        EXTERN Twink
        EXTERN Update_Trig
        EXTERN V_UNIT
        EXTERN X_Attr
        EXTERN Y_Attr
        EXTERN __Clear_Screen
        EXTERN __LCD_SetPixl
        EXTERN __Point_SCR
        EXTERN __Read_FIFO
        EXTERN __Set
        EXTERN a_Avg
        EXTERN b_Avg
        EXTERN s8ToPercen

        PUBLIC Balance
        PUBLIC Calibrat
        PUBLIC ExitStr
        PUBLIC VS_STR
        PUBLIC V_UNIT1
        
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
        
// E:\Mini-DS\DS203\APP_V2.51\source\Calibrat.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : Calibrat.c  
//    3  Version   : DS203_APP Ver 2.3x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include "Interrupt.h"
//    6 #include "Function.h"
//    7 #include "Calibrat.h"
//    8 #include "Process.h"
//    9 #include "File.h"
//   10 #include "BIOS.h"
//   11 #include "Menu.h"
//   12 

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "CH_A">`:
        DATA
        DC8 "CH_A"
        DC8 0, 0, 0
        DC8 "ZERO"
        DC8 0, 0, 0
        DC8 "DIFF"
        DC8 0, 0, 0
        DC8 "VOLTAGE"
        DC8 "CH_B"
        DC8 0, 0, 0
        DC8 "        PLEASE CONNECT"
        DC8 0
        DC8 "INPUT TO "
        DC8 0, 0
        DC8 "GND      "
        DC8 0, 0
        DC8 "   PRESS   KEY TO CONFIRM THE INPUT VOLTAGE   "
        DC8 0
        DC8 " CH_A "
        DC8 0
        DC8 " CH_B "
        DC8 0
        DC8 "   AUTOMATIC CALIBRATION IN PROGRESS...       "
        DC8 0
        DC8 " INPUT "
        DC8 " STANDARD VOLTAGE TO "
        DC8 0, 0
        DC8 "MODIFY VOLTAGE:   ...    "
        DC8 0, 0
        DC8 "SELECT RANGE:   ---   "
        DC8 0
        DC8 "CH_A  "
        DC8 0
        DC8 "CH_B  "
        DC8 0
        DC8 "    PRESS   ---  "
        DC8 0, 0
        DC8 " TO SELECT THE NEXT OPERATION   "
        DC8 0, 0, 0
        DC8 "  PRESS   TO "
        DC8 0, 0
        DC8 "CONFIRM THE RE-CALIBRATION "
        DC8 "CH_A "
        DC8 0, 0
        DC8 "CH_B "
        DC8 0, 0
        DC8 "SELECT THE CALIBRATION "
        DC8 "CH_B     "
        DC8 0, 0
        DC8 "CH_A     "
        DC8 0, 0
        DC8 "Exit WITHOUT SAVE RESULTS        "
        DC8 0, 0
        DC8 "Exit AND SAVE CALIBRATION RESULTS"
        DC8 0, 0
        DC8 "Exit AND RESTORE SYSTEM DEFAULTS "
        DC8 0, 0
        DC8 "     "
        DC8 0, 0
        DC8 "       "
        DC8 "                                                "
        DC8 0, 0, 0
        DC8 "          SAVING THE CALIBRATION DATA           "
        DC8 0, 0, 0
        DC8 "       RESTORE DEFAULTS CALIBRATION DATA        "
        DC8 0, 0, 0
//   13 uc8 VS_STR[9][12]  ={"250-300mV", "!0.5-0.6V!","!1.0-1.2V!","!2.5-3.0V!",
VS_STR:
        DC8 "250-300mV"
        DC8 0, 0
        DC8 "!0.5-0.6V!"
        DC8 0
        DC8 "!1.0-1.2V!"
        DC8 0
        DC8 "!2.5-3.0V!"
        DC8 0
        DC8 "!5.0-6.0V!"
        DC8 0
        DC8 " !10-12V! "
        DC8 0
        DC8 " !25-30V! "
        DC8 0
        DC8 " !50-60V! "
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(1)
        DATA
        DC8 " "

        SECTION `.rodata`:CONST:NOROOT(1)
        DATA
        DC8 "-"

        SECTION `.rodata`:CONST:NOROOT(1)
        DATA
        DC8 "+"

        SECTION `.rodata`:CONST:NOROOT(1)
        DATA
        DC8 "<"

        SECTION `.rodata`:CONST:NOROOT(1)
        DATA
        DC8 ">"
//   14                      "!5.0-6.0V!"," !10-12V! "," !25-30V! "," !50-60V! "};

        SECTION `.rodata`:CONST:NOROOT(2)
//   15 uc8 ExitStr[3][50] ={" PRESS (#) KEY TO Exit WITH RESTORE DEFAULTS ",
ExitStr:
        DATA
        DC8 " PRESS (#) KEY TO Exit WITH RESTORE DEFAULTS "
        DC8 0, 0, 0, 0
        DC8 " PRESS (#) KEY TO Exit WITH SAVE CALIBRATION "
        DC8 0, 0, 0, 0
        DC8 " PRESS (#) KEY TO Exit WITHOUT CALIBRATION   "
        DC8 0, 0, 0, 0, 0, 0
//   16                      " PRESS (#) KEY TO Exit WITH SAVE CALIBRATION ",
//   17                      " PRESS (#) KEY TO Exit WITHOUT CALIBRATION   "};

        SECTION `.rodata`:CONST:NOROOT(2)
//   18 uc8 V_UNIT1[8] ={'m','V','m','V','V',' ','k','V'};
V_UNIT1:
        DATA
        DC8 109, 86, 109, 86, 86, 32, 107, 86
//   19 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Balance
        THUMB
//   20 void Balance(void)
//   21 {
Balance:
        PUSH     {R4-R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI R7 Frame(CFA, -8)
        CFI R6 Frame(CFA, -12)
        CFI R5 Frame(CFA, -16)
        CFI R4 Frame(CFA, -20)
        CFI CFA R13+20
        SUB      SP,SP,#+4
        CFI CFA R13+24
//   22   u16 i;
//   23   
//   24   __Set(STANDBY, DN);                          // 退出省电状态
        MOVS     R1,#+0
        MOVS     R0,#+20
        BL       __Set
//   25   __Set(ADC_CTRL, EN );       
        MOVS     R1,#+1
        MOVS     R0,#+36
        BL       __Set
//   26   __Set(T_BASE_PSC, X_Attr[_2uS].PSC);         // T_BASE = 2uS
        LDR.N    R4,??DataTable0  ;; X_Attr
        LDR      R0,[R4, #+0]
        LDRSH    R1,[R0, #+348]
        MOVS     R0,#+7
        BL       __Set
//   27   __Set(T_BASE_ARR, X_Attr[_2uS].ARR);
        LDR      R0,[R4, #+0]
        ADD      R0,R0,#+350
        LDRH     R1,[R0, #+0]
        MOVS     R0,#+8
        BL       __Set
//   28   __Set(CH_A_COUPLE, AC);
        MOVS     R1,#+1
        MOVS     R0,#+9
        BL       __Set
//   29   __Set(CH_B_COUPLE, AC);
        MOVS     R1,#+1
        MOVS     R0,#+11
        BL       __Set
//   30   __Set(CH_A_OFFSET, 100);
        MOVS     R1,#+100
        MOVS     R0,#+0
        BL       __Set
//   31   __Set(CH_B_OFFSET, 100);
        MOVS     R1,#+100
        MOVS     R0,#+1
        BL       __Set
//   32   __Set(CH_A_RANGE,  G_Attr[0].Yp_Max);        // 10V/Div
        LDR.N    R4,??DataTable1  ;; G_Attr
        LDR      R0,[R4, #+0]
        LDRH     R1,[R0, #+4]
        MOVS     R0,#+10
        BL       __Set
//   33   __Set(CH_B_RANGE,  G_Attr[0].Yp_Max+1);      // B通道合并到A通道
        LDR      R0,[R4, #+0]
        LDRH     R0,[R0, #+4]
        ADDS     R1,R0,#+1
        MOVS     R0,#+12
        BL       __Set
//   34   __Set(ADC_MODE, INTERLACE);                  // Set Interlace mode
        MOVS     R1,#+1
        MOVS     R0,#+5
        BL       __Set
//   35   Update_Trig();
        BL       Update_Trig
//   36   __Set(TRIGG_MODE, UNCONDITION);              // 设任意触发
        MOVS     R1,#+32
        MOVS     R0,#+32
        BL       __Set
//   37   Delayms(2000); 
        MOV      R0,#+2000
        BL       Delayms
//   38   
//   39   __Set(FIFO_CLR, W_PTR); 
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
//   40   Delayms(20); 
        MOVS     R0,#+20
        BL       Delayms
//   41   a_Avg = 2048;               
        LDR.N    R4,??DataTable2  ;; a_Avg
        MOV      R0,#+2048
        STR      R0,[R4, #+0]
//   42   b_Avg = 2048;            
        LDR.N    R5,??DataTable3  ;; b_Avg
        STR      R0,[R5, #+0]
//   43   for(i=0; i <4096; i++){
        LDR.N    R6,??DataTable4  ;; DataBuf
        MOV      R7,#+4096
//   44     DataBuf[i] = __Read_FIFO();         // 读入32位FIFO数据, 读后指针+1
??Balance_0:
        BL       __Read_FIFO
        STR      R0,[R6, #+0]
//   45     a_Avg += (DataBuf[i] & 0xFF );      // 累计直流平均值                
        LDR      R0,[R4, #+0]
        LDR      R1,[R6, #+0]
        UXTB     R1,R1
        ADDS     R0,R1,R0
        STR      R0,[R4, #+0]
//   46     b_Avg += ((DataBuf[i]>>8) & 0xFF );              
        LDR      R1,[R5, #+0]
        LDR      R2,[R6], #+4
        LSLS     R2,R2,#+16
        LSRS     R2,R2,#+24
        ADDS     R1,R2,R1
        STR      R1,[R5, #+0]
//   47   }
        SUBS     R7,R7,#+1
        BNE.N    ??Balance_0
//   48   Kab = (a_Avg - b_Avg)/4096;
        LDR      R1,[R5, #+0]
        SUBS     R0,R0,R1
        LSRS     R0,R0,#+12
        LDR.N    R1,??Balance_1   ;; Kab
        STRB     R0,[R1, #+0]
//   49 }
        ADD      SP,SP,#+4
        CFI CFA R13+20
        POP      {R4-R7,PC}       ;; return
        DATA
??Balance_1:
        DC32     Kab
        CFI EndBlock cfiBlock0

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable0:
        DC32     X_Attr

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable1:
        DC32     G_Attr

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2:
        DC32     a_Avg

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable3:
        DC32     b_Avg

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable4:
        DC32     DataBuf
//   50 /*******************************************************************************
//   51   Calibrat : Calibrat routine
//   52 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function Calibrat
        THUMB
//   53 void Calibrat(u8 Channel)
//   54 { 
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
        SUB      SP,SP,#+156
        CFI CFA R13+192
        MOV      R10,R0
        LDR.W    R0,??Calibrat_1+0x4  ;; Key_Buffer
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//   55   s8  Ma1[10], Mb1[10], Ma3[10], Mb3[10];
//   56   u16 Ma2[10], Mb2[10], i, j;
//   57   s16 TmpA, TmpB;
//   58   u8  Range, n[10], k, m, Step;
//   59   
//   60   Key_Buffer = 0; 
//   61   __Set(STANDBY, DN);                                   // 退出省电状态
        MOVS     R0,#+20
        BL       __Set
//   62   __Set(BACKLIGHT, 10*(Title[BK_LIGHT][CLASS].Value+1));
        LDR.W    R5,??Calibrat_1+0x8  ;; Title
        LDRSH    R0,[R5, #+916]
        ADDS     R0,R0,#+1
        MOVS     R1,#+10
        MULS     R1,R0,R1
        MOVS     R0,#+2
        BL       __Set
//   63   __Clear_Screen(BLACK);                                // 清屏幕
        MOVS     R0,#+0
        BL       __Clear_Screen
//   64   
//   65   Interlace = 0;
        LDR.W    R0,??Calibrat_1+0x10  ;; Interlace
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//   66   __Set(ADC_MODE, SEPARATE);                            // Set Separate mode
        MOVS     R0,#+5
        BL       __Set
//   67   __Set(ADC_CTRL, EN);       
        MOVS     R1,#+1
        MOVS     R0,#+36
        BL       __Set
//   68   __Set(TRIGG_MODE, UNCONDITION);                       // 设任意触发
        MOVS     R1,#+32
        MOVS     R0,#+32
        BL       __Set
//   69   _Status = RUN;
        MOVS     R0,#+0
        STRH     R0,[R5, #+336]
//   70   __Set(BEEP_VOLUME, 5*(Title[VOLUME][CLASS].Value-1)); // Reload volume
        LDRSH    R0,[R5, #+996]
        SUBS     R0,R0,#+1
        MOVS     R1,#+5
        MULS     R1,R0,R1
        MOVS     R0,#+3
        BL       __Set
//   71   Beep_mS = 500;                                        // 蜂鸣器响500mS
        LDR.W    R0,??Calibrat_1+0x1C  ;; Beep_mS
        MOV      R1,#+500
        STRH     R1,[R0, #+0]
//   72   Range = 0;
        MOVS     R5,#+0
//   73   Step  = 0;
        MOV      R6,R5
//   74   m     = 0;
        MOV      R0,R5
        STRB     R0,[SP, #+16]
//   75   
//   76   __Set(T_BASE_PSC, X_Attr[_100uS].PSC);                // T_BASE = 100uS
        LDR.W    R7,??Calibrat_1+0x20  ;; X_Attr
        LDR      R0,[R7, #+0]
        LDRSH    R1,[R0, #+248]
        MOVS     R0,#+7
        BL       __Set
//   77   __Set(T_BASE_ARR, X_Attr[_100uS].ARR);
        LDR      R0,[R7, #+0]
        LDRH     R1,[R0, #+250]
        MOVS     R0,#+8
        BL       __Set
//   78 
//   79   __Set(CH_A_COUPLE, DC);
        MOV      R1,R5
        MOVS     R0,#+9
        BL       __Set
//   80   __Set(CH_B_COUPLE, DC);
        MOV      R1,R5
        MOVS     R0,#+11
        BL       __Set
//   81   
//   82   for(j=0; j<220; j+=20){                               // 画表格  
        MOV      R9,R5
        MOVW     R11,#+399
        MOVW     R7,#+65535
//   83     for(i=0; i<399; i++){
??Calibrat_2:
        MOV      R8,R5
//   84       __Point_SCR(i, j);
??Calibrat_3:
        UXTH     R1,R9
        UXTH     R0,R8
        BL       __Point_SCR
//   85       __LCD_SetPixl(WHT);
        MOVS     R0,R7
        BL       __LCD_SetPixl
//   86     }
        ADD      R8,R8,#+1
        UXTH     R0,R8
        CMP      R0,R11
        BCC.N    ??Calibrat_3
//   87   }
        ADD      R9,R9,#+20
        UXTH     R0,R9
        CMP      R0,#+220
        BCC.N    ??Calibrat_2
//   88   for(i=0; i<399; i++){
        MOV      R8,R5
//   89     __Point_SCR(i, 239);
??Calibrat_4:
        MOVS     R1,#+239
        UXTH     R0,R8
        BL       __Point_SCR
//   90     __LCD_SetPixl(WHT);
        MOVS     R0,R7
        BL       __LCD_SetPixl
//   91   }
        ADD      R8,R8,#+1
        UXTH     R0,R8
        CMP      R0,R11
        BCC.N    ??Calibrat_4
//   92   __Point_SCR(  0,  0);
        MOVS     R1,#+0
        MOV      R0,R1
        BL       __Point_SCR
//   93   for(j= 0; j<239; j++)  __LCD_SetPixl(WHT); 
        MOV      R8,#+239
??Calibrat_5:
        MOVS     R0,R7
        BL       __LCD_SetPixl
        SUBS     R8,R8,#+1
        BNE.N    ??Calibrat_5
//   94   __Point_SCR( 44, 20);
        MOVS     R1,#+20
        MOVS     R0,#+44
        BL       __Point_SCR
//   95   for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
        MOV      R8,#+181
??Calibrat_6:
        MOVS     R0,R7
        BL       __LCD_SetPixl
        SUBS     R8,R8,#+1
        BNE.N    ??Calibrat_6
//   96   __Point_SCR( 88, 20);
        MOVS     R1,#+20
        MOVS     R0,#+88
        BL       __Point_SCR
//   97   for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
        MOV      R8,#+181
??Calibrat_7:
        MOVS     R0,R7
        BL       __LCD_SetPixl
        SUBS     R8,R8,#+1
        BNE.N    ??Calibrat_7
//   98   __Point_SCR(132, 20);
        MOVS     R1,#+20
        MOVS     R0,#+132
        BL       __Point_SCR
//   99   for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
        MOV      R8,#+181
??Calibrat_8:
        MOVS     R0,R7
        BL       __LCD_SetPixl
        SUBS     R8,R8,#+1
        BNE.N    ??Calibrat_8
//  100   __Point_SCR(200, 20);
        MOVS     R1,#+20
        MOVS     R0,#+200
        BL       __Point_SCR
//  101   for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
        MOV      R8,#+181
??Calibrat_9:
        MOVS     R0,R7
        BL       __LCD_SetPixl
        SUBS     R8,R8,#+1
        BNE.N    ??Calibrat_9
//  102   __Point_SCR(244, 20);
        MOVS     R1,#+20
        MOVS     R0,#+244
        BL       __Point_SCR
//  103   for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
        MOV      R8,#+181
??Calibrat_10:
        MOVS     R0,R7
        BL       __LCD_SetPixl
        SUBS     R8,R8,#+1
        BNE.N    ??Calibrat_10
//  104   __Point_SCR(288, 20);
        MOVS     R1,#+20
        MOV      R0,#+288
        BL       __Point_SCR
//  105   for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
        MOV      R8,#+181
??Calibrat_11:
        MOVS     R0,R7
        BL       __LCD_SetPixl
        SUBS     R8,R8,#+1
        BNE.N    ??Calibrat_11
//  106   __Point_SCR(332, 20);
        MOVS     R1,#+20
        MOV      R0,#+332
        BL       __Point_SCR
//  107   for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
        MOV      R8,#+181
??Calibrat_12:
        MOVS     R0,R7
        BL       __LCD_SetPixl
        SUBS     R8,R8,#+1
        BNE.N    ??Calibrat_12
//  108   __Point_SCR(398, 0);
        MOVS     R1,#+0
        MOV      R0,#+398
        BL       __Point_SCR
//  109   for(j= 0; j<239; j++)  __LCD_SetPixl(WHT); 
        MOV      R8,#+239
??Calibrat_13:
        MOVS     R0,R7
        BL       __LCD_SetPixl
        SUBS     R8,R8,#+1
        BNE.N    ??Calibrat_13
//  110  
//  111   Print_Str(  6, 185, 0x0005, PRN, "CH_A");              // 显示表格标题栏
        LDR.W    R8,??Calibrat_1+0x24  ;; `?<Constant "CH_A">`
        PUSH     {R8,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVS     R2,#+5
        MOVS     R1,#+185
        MOVS     R0,#+6
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  112   Print_Str( 49, 185, 0x0005, PRN, "ZERO");
        ADD      R0,R8,#+8
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOV      R3,R5
        MOVS     R2,#+5
        MOVS     R1,#+185
        MOVS     R0,#+49
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  113   Print_Str( 93, 185, 0x0005, PRN, "DIFF");
        ADD      R0,R8,#+16
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOV      R3,R5
        MOVS     R2,#+5
        MOVS     R1,#+185
        MOVS     R0,#+93
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  114   Print_Str(137, 185, 0x0005, PRN, "VOLTAGE");
        ADD      R0,R8,#+24
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOV      R3,R5
        MOVS     R2,#+5
        MOVS     R1,#+185
        MOVS     R0,#+137
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
        ADD      R0,R8,#+32
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOV      R3,R5
        MOVW     R2,#+261
        MOVS     R1,#+185
        MOVS     R0,#+206
//  115   Print_Str(206, 185, 0x0105, PRN, "CH_B");
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  116   Print_Str(249, 185, 0x0105, PRN, "ZERO");
        ADD      R0,R8,#+8
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOV      R3,R5
        MOVW     R2,#+261
        MOVS     R1,#+185
        MOVS     R0,#+249
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  117   Print_Str(293, 185, 0x0105, PRN, "DIFF");
        ADD      R0,R8,#+16
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOV      R3,R5
        MOVW     R2,#+261
        MOVS     R1,#+185
        MOVW     R0,#+293
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  118   Print_Str(338, 185, 0x0105, PRN, "VOLTAGE");
        ADD      R0,R8,#+24
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOV      R3,R5
        MOVW     R2,#+261
        MOVS     R1,#+185
        MOV      R0,#+338
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  119     
//  120   for(i=0; i<=G_Attr[0].Yp_Max; i++){
        MOV      R7,R5
        ADD      R0,SP,#+64
        STR      R0,[SP, #+36]
        LDR.W    R0,??Calibrat_1+0x2C  ;; Ka1
        STR      R0,[SP, #+40]
        ADD      R0,SP,#+88
        STR      R0,[SP, #+44]
        LDR.W    R0,??Calibrat_1+0x30  ;; Ka3
        STR      R0,[SP, #+48]
        ADD      R0,SP,#+76
        STR      R0,[SP, #+52]
        LDR.W    R0,??Calibrat_1+0x34  ;; Kb1
        STR      R0,[SP, #+56]
        ADD      R0,SP,#+100
        STR      R0,[SP, #+60]
        LDR.W    R0,??Calibrat_1+0x38  ;; Kb3
        STR      R0,[SP, #+0]
        ADD      R0,SP,#+112
        STR      R0,[SP, #+32]
        LDR.W    R0,??Calibrat_1+0x3C  ;; Ka2
        STR      R0,[SP, #+28]
        ADD      R0,SP,#+132
        STR      R0,[SP, #+24]
        LDR.W    R0,??Calibrat_1+0x40  ;; Kb2
        STR      R0,[SP, #+20]
        MOV      R11,R5
        MOV      R9,#+166
//  121     Print_Str(  6, 166-(i*20), 0x0005, PRN, Y_Attr[i].STR); // 显示量程
??Calibrat_14:
        LDR.W    R0,??Calibrat_1+0x44  ;; Y_Attr
        LDR      R0,[R0, #+0]
        ADD      R0,R11,R0
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVS     R2,#+5
        UXTH     R1,R9
        MOVS     R0,#+6
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  122     Print_Str(206, 166-(i*20), 0x0105, PRN, Y_Attr[i].STR);
        LDR.W    R0,??Calibrat_1+0x44  ;; Y_Attr
        LDR      R0,[R0, #+0]
        ADD      R0,R11,R0
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOV      R3,R5
        MOVW     R2,#+261
        UXTH     R1,R9
        MOVS     R0,#+206
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  123     Ma1[i] = Ka1[i];  Ma2[i] = Ka2[i];  Ma3[i] = Ka3[i];    // 备份校准前的参数
        ADD      R1,SP,#+36
        LDR      R0,[R1, #+0]
        ADDS     R2,R0,#+1
        STR      R2,[R1, #+0]
        ADD      R1,SP,#+40
        LDR      R3,[R1, #+0]
        ADDS     R2,R3,#+1
        STR      R2,[R1, #+0]
        LDRB     R1,[R3, #+0]
        STRB     R1,[R0, #+0]
        ADD      R1,SP,#+32
        LDR      R0,[R1, #+0]
        ADDS     R2,R0,#+2
        STR      R2,[R1, #+0]
        ADD      R1,SP,#+28
        LDR      R3,[R1, #+0]
        ADDS     R2,R3,#+2
        STR      R2,[R1, #+0]
        LDRH     R1,[R3, #+0]
        STRH     R1,[R0, #+0]
        ADD      R1,SP,#+44
        LDR      R0,[R1, #+0]
        ADDS     R2,R0,#+1
        STR      R2,[R1, #+0]
        ADD      R1,SP,#+48
        LDR      R3,[R1, #+0]
        ADDS     R2,R3,#+1
        STR      R2,[R1, #+0]
        LDRB     R1,[R3, #+0]
        STRB     R1,[R0, #+0]
//  124     Mb1[i] = Kb1[i];  Mb2[i] = Kb2[i];  Mb3[i] = Kb3[i];
        ADD      R1,SP,#+52
        LDR      R0,[R1, #+0]
        ADDS     R2,R0,#+1
        STR      R2,[R1, #+0]
        ADD      R1,SP,#+56
        LDR      R3,[R1, #+0]
        ADDS     R2,R3,#+1
        STR      R2,[R1, #+0]
        LDRB     R1,[R3, #+0]
        STRB     R1,[R0, #+0]
        ADD      R1,SP,#+24
        LDR      R0,[R1, #+0]
        ADDS     R2,R0,#+2
        STR      R2,[R1, #+0]
        ADD      R1,SP,#+20
        LDR      R3,[R1, #+0]
        ADDS     R2,R3,#+2
        STR      R2,[R1, #+0]
        LDRH     R1,[R3, #+0]
        STRH     R1,[R0, #+0]
        ADD      R1,SP,#+60
        LDR      R0,[R1, #+0]
        ADDS     R2,R0,#+1
        STR      R2,[R1, #+0]
        ADD      R1,SP,#+0
        LDR      R3,[R1, #+0]
        ADDS     R2,R3,#+1
        STR      R2,[R1, #+0]
        LDRB     R1,[R3, #+0]
        STRB     R1,[R0, #+0]
//  125   }
        ADDS     R7,R7,#+1
        UXTH     R7,R7
        SUB      R9,R9,#+20
        ADD      R11,R11,#+20
        LDR.W    R0,??Calibrat_1+0x48  ;; G_Attr
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+4]
        CMP      R0,R7
        BCS.N    ??Calibrat_14
??Calibrat_15:
        LDR.W    R0,??Calibrat_1+0x4C  ;; PD_Cnt
        LDRH     R0,[R0, #+0]
        CBNZ     R0,??Calibrat_16
//  126 
//  127   while (1){
//  128     if(PD_Cnt == 0){
//  129       __Set(BACKLIGHT, 0);                               // 关闭背光
        MOVS     R1,#+0
        MOVS     R0,#+2
        BL       __Set
//  130       __Set(STANDBY, EN);                                // 进入省电状态
        MOVS     R1,#+1
        MOVS     R0,#+20
        BL       __Set
//  131       return;
??Calibrat_17:
        ADD      SP,SP,#+156
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        CFI CFA R13+192
//  132     }
//  133     __Set(CH_A_RANGE, Range);  __Set(CH_B_RANGE, Range);
??Calibrat_16:
        UXTB     R7,R5
        MOVS     R1,R7
        MOVS     R0,#+10
        BL       __Set
        MOVS     R1,R7
        MOVS     R0,#+12
        BL       __Set
//  134     Delayms(20); 
        MOVS     R0,#+20
        BL       Delayms
//  135     __Set(FIFO_CLR, W_PTR);
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
//  136     Delayms(20); 
        MOVS     R0,#+20
        BL       Delayms
        LDR.W    R0,??Calibrat_18  ;; a_Avg
        MOV      R1,#+2048
        STR      R1,[R0, #+0]
//  137     a_Avg = 2048;  b_Avg = 2048;               
        LDR.W    R11,??Calibrat_18+0x4  ;; b_Avg
        MOV      R0,R1
        STR      R0,[R11, #+0]
//  138     for(i=0; i <4096; i++){
        LDR.W    R7,??Calibrat_18+0x8  ;; DataBuf
        MOV      R9,#+4096
//  139       DataBuf[i] = __Read_FIFO();         // 读入32位FIFO数据
??Calibrat_19:
        BL       __Read_FIFO
        STR      R0,[R7, #+0]
//  140       a_Avg += (DataBuf[i] & 0xFF );      // 累计直流平均值                
        LDR.W    R0,??Calibrat_18  ;; a_Avg
        LDR      R0,[R0, #+0]
        LDR      R1,[R7, #+0]
        UXTB     R1,R1
        ADDS     R0,R1,R0
        LDR.W    R1,??Calibrat_18  ;; a_Avg
        STR      R0,[R1, #+0]
//  141       b_Avg += ((DataBuf[i]>>8) & 0xFF );              
        LDR      R1,[R11, #+0]
        LDR      R2,[R7], #+4
        LSLS     R2,R2,#+16
        LSRS     R2,R2,#+24
        ADDS     R1,R2,R1
        STR      R1,[R11, #+0]
//  142     }
        SUBS     R9,R9,#+1
        BNE.N    ??Calibrat_19
//  143     TmpA  = Ka1[Range] +(Ka2[Range]*(a_Avg/4096)+ 512)/1024;
        UXTB     R7,R5
        LDR.W    R1,??Calibrat_1+0x2C  ;; Ka1
        LDRSB    R1,[R7, R1]
        LDR.W    R2,??Calibrat_1+0x3C  ;; Ka2
        LDRH     R2,[R2, R7, LSL #+1]
        LSRS     R0,R0,#+12
        MOV      R3,#+512
        MLA      R0,R2,R0,R3
        ADD      R0,R1,R0, LSR #+10
        SXTH     R0,R0
        STR      R0,[SP, #+0]
//  144     TmpB  = Kb1[Range] +(Kb2[Range]*(b_Avg/4096)+ 512)/1024;
        LDR.W    R0,??Calibrat_1+0x34  ;; Kb1
        LDRSB    R0,[R7, R0]
        LDR.W    R1,??Calibrat_1+0x40  ;; Kb2
        LDRH     R1,[R1, R7, LSL #+1]
        LDR      R2,[R11, #+0]
        LSRS     R2,R2,#+12
        MLA      R1,R1,R2,R3
        ADD      R11,R0,R1, LSR #+10
        SXTH     R11,R11
//  145 
//  146     if(Blink){ 
        LDR.W    R0,??Calibrat_18+0xC  ;; Blink
        LDRB     R1,[R0, #+0]
        CMP      R1,#+0
        BEQ.W    ??Calibrat_20
//  147       Blink = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  148       switch (Step){  
        UXTB     R0,R6
        CMP      R0,#+12
        BHI.W    ??Calibrat_20
        TBH      [PC, R0, LSL #+1]
        DATA
??Calibrat_0:
        DC16     +13,+184,+303,+429
        DC16     +483,+603,+706,+816
        DC16     +1031,+1139,+1189,+1210
        DC16     +1231
        THUMB
//  149       case 0:
//  150         Range = 0;
??Calibrat_21:
        MOVS     R5,#+0
//  151         __Set(CH_A_OFFSET, ((1024+Ka3[Range])*40 + 512)/1024);
        MOVS     R7,#+40
        LDR.W    R0,??Calibrat_1+0x30  ;; Ka3
        LDRSB    R0,[R0, R5]
        MOV      R1,#+41472
        MLA      R0,R0,R7,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R1,R0,#+10
        MOVS     R0,#+0
        BL       __Set
//  152         __Set(CH_B_OFFSET, ((1024+Kb3[Range])*40 + 512)/1024);
        LDR.W    R0,??Calibrat_1+0x38  ;; Kb3
        LDRSB    R0,[R0, R5]
        MOV      R1,#+41472
        MLA      R0,R0,R7,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R1,R0,#+10
        MOVS     R0,#+1
        BL       __Set
        ADD      R0,R8,#+40
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOV      R3,R5
        MOVW     R2,#+773
        MOVS     R1,#+216
        MOVS     R0,#+8
//  153         Print_Str(   8, 216, 0x0305, PRN,   "        PLEASE CONNECT");
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  154         Print_Str(29*8, 216, 0x0305, PRN,   "INPUT TO ");
        ADD      R0,R8,#+64
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOV      R3,R5
        MOVW     R2,#+773
        MOVS     R1,#+216
        MOVS     R0,#+232
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  155         Print_Str(38*8, 216, 0x0405, PRN,   "GND      ");
        MOVW     R9,#+1029
        ADD      R0,R8,#+76
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOV      R3,R5
        MOV      R2,R9
        MOVS     R1,#+216
        MOV      R0,#+304
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  156         Print_Str(   8,   6, 0x0305, PRN,   "   PRESS   KEY TO CONFIRM THE INPUT VOLTAGE   ");
        ADD      R0,R8,#+88
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOV      R3,R5
        MOVW     R2,#+773
        MOVS     R1,#+6
        MOVS     R0,#+8
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  157         Print_Str(10*8,   6, 0x0405, Twink, " ");
        ADR.N    R0,??Calibrat_22  ;; " "
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R9
        MOVS     R1,#+6
        MOVS     R0,#+80
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  158         if(Channel == TRACK1){
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_23
//  159           Print_Str( 23*8, 216, 0x0005, PRN, " CH_A ");
        ADD      R0,R8,#+136
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVS     R2,#+5
        MOVS     R1,#+216
        MOVS     R0,#+184
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  160           for(i=0; i<=G_Attr[0].Yp_Max; i++){
        MOV      R7,R5
        LDR.W    R0,??Calibrat_1+0x2C  ;; Ka1
        LDR.W    R1,??Calibrat_1+0x30  ;; Ka3
        LDR.W    R2,??Calibrat_1+0x3C  ;; Ka2
//  161             Ka1[i] = 0; Ka2[i] = 1024; Ka3[i] = 0;         // 设置校准参数初值
??Calibrat_24:
        MOVS     R3,#+0
        STRB     R3,[R0], #+1
        MOV      R3,#+1024
        STRH     R3,[R2], #+2
        MOV      R3,R5
        STRB     R3,[R1], #+1
//  162           }
        ADDS     R7,R7,#+1
        UXTH     R7,R7
        LDR.W    R3,??Calibrat_1+0x48  ;; G_Attr
        LDR      R3,[R3, #+0]
        LDRH     R3,[R3, #+4]
        CMP      R3,R7
        BCC.W    ??Calibrat_20
        B.N      ??Calibrat_24
//  163         }
//  164         if(Channel == TRACK2){
??Calibrat_23:
        CMP      R10,#+1
        BNE.W    ??Calibrat_20
//  165           Print_Str( 23*8, 216, 0x0105, PRN, " CH_B ");
        ADD      R0,R8,#+144
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+261
        MOVS     R1,#+216
        MOVS     R0,#+184
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  166           for(i=0; i<=G_Attr[0].Yp_Max; i++){
        MOV      R7,R5
        LDR.W    R0,??Calibrat_1+0x34  ;; Kb1
        LDR.W    R1,??Calibrat_1+0x38  ;; Kb3
        LDR.W    R2,??Calibrat_1+0x40  ;; Kb2
//  167             Kb1[i] = 0; Kb2[i] = 1024; Kb3[i] = 0;         // 设置校准参数初值
??Calibrat_25:
        MOVS     R3,#+0
        STRB     R3,[R0], #+1
        MOV      R3,#+1024
        STRH     R3,[R2], #+2
        MOV      R3,R5
        STRB     R3,[R1], #+1
//  168           }
        ADDS     R7,R7,#+1
        UXTH     R7,R7
        LDR.W    R3,??Calibrat_1+0x48  ;; G_Attr
        LDR      R3,[R3, #+0]
        LDRH     R3,[R3, #+4]
        CMP      R3,R7
        BCC.W    ??Calibrat_20
        B.N      ??Calibrat_25
//  169         }
//  170         break;
//  171       case 1:
//  172         Print_Str(   8,   6, 0x0305, PRN,   "   AUTOMATIC CALIBRATION IN PROGRESS...       ");
??Calibrat_26:
        ADD      R0,R8,#+152
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+773
        MOVS     R1,#+6
        MOVS     R0,#+8
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  173         if(Channel == TRACK1){
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_27
//  174           s8ToPercen(n, TmpA - 40);
        LDR      R0,[SP, #+0]
        SUB      R1,R0,#+40
        SXTB     R1,R1
        ADD      R0,SP,#+4
        BL       s8ToPercen
//  175           Print_Str( 45, 166-(Range*20), 0x0005, INV, n);
        ADD      R0,SP,#+4
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+1
        MOVS     R2,#+5
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVS     R0,#+45
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  176           Ka1[Range] -= TmpA - 40; 
        LDR.W    R0,??Calibrat_1+0x2C  ;; Ka1
        LDRB     R0,[R7, R0]
        LDR      R1,[SP, #+0]
        SUBS     R0,R0,R1
        ADDS     R0,R0,#+40
        LDR.W    R1,??Calibrat_1+0x2C  ;; Ka1
        B.N      ??Calibrat_28
//  177         } 
//  178         if(Channel == TRACK2){
??Calibrat_27:
        CMP      R10,#+1
        BNE.N    ??Calibrat_29
//  179           s8ToPercen(n, TmpB - 40);
        SUB      R1,R11,#+40
        SXTB     R1,R1
        ADD      R0,SP,#+4
        BL       s8ToPercen
//  180           Print_Str(245, 166-(Range*20), 0x0105, INV, n);
        ADD      R0,SP,#+4
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+1
        MOVW     R2,#+261
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVS     R0,#+245
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  181           Kb1[Range] -= TmpB - 40; 
        LDR.W    R0,??Calibrat_1+0x34  ;; Kb1
        LDRB     R0,[R7, R0]
        MOV      R1,R11
        SUBS     R0,R0,R1
        ADDS     R0,R0,#+40
        LDR.W    R1,??Calibrat_1+0x34  ;; Kb1
??Calibrat_28:
        STRB     R0,[R7, R1]
//  182         }
//  183         Range++;
??Calibrat_29:
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  184         if(Range > G_Attr[0].Yp_Max){ 
        LDR.W    R0,??Calibrat_1+0x48  ;; G_Attr
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+4]
        CMP      R0,R5
        BCS.N    ??Calibrat_30
//  185           Range = 0;  Step++;
        MOVS     R5,#+0
        ADDS     R6,R6,#+1
        UXTB     R6,R6
//  186         } 
//  187         __Set(CH_A_OFFSET, ((1024+Ka3[Range])*40 + 512)/1024);
??Calibrat_30:
        MOVS     R7,#+40
        LDR.W    R0,??Calibrat_1+0x30  ;; Ka3
        LDRSB    R0,[R5, R0]
        MOV      R1,#+41472
        MLA      R0,R0,R7,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R1,R0,#+10
        MOVS     R0,#+0
        BL       __Set
//  188         __Set(CH_B_OFFSET, ((1024+Kb3[Range])*40 + 512)/1024);
        LDR.W    R0,??Calibrat_1+0x38  ;; Kb3
        LDRSB    R0,[R5, R0]
        MOV      R1,#+41472
        MLA      R0,R0,R7,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R1,R0,#+10
        MOVS     R0,#+1
        BL       __Set
//  189         k = 0;
        MOVS     R4,#+0
        B.N      ??Calibrat_20
//  190         break;
//  191       case 2:
//  192         k++;
??Calibrat_31:
        ADDS     R4,R4,#+1
//  193         if(k >= 8) k = 0;
        UXTB     R4,R4
        CMP      R4,#+8
        IT       CS 
        MOVCS    R4,#+0
//  194         if(Channel == TRACK1){
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_32
//  195           s8ToPercen(n, TmpA - 40);
        LDR      R0,[SP, #+0]
        SUB      R1,R0,#+40
        SXTB     R1,R1
        ADD      R0,SP,#+4
        BL       s8ToPercen
//  196           Print_Str( 45, 166-(Range*20), 0x0005, PRN, n);
        ADD      R0,SP,#+4
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVS     R2,#+5
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVS     R0,#+45
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  197           if(TmpA - 40 != 0)  Ka1[Range] -= TmpA - 40;
        LDR      R0,[SP, #+0]
        SUBS     R0,R0,#+40
        BEQ.N    ??Calibrat_33
        LDR.W    R0,??Calibrat_1+0x2C  ;; Ka1
        LDRB     R0,[R7, R0]
        LDR      R1,[SP, #+0]
        SUBS     R0,R0,R1
        ADDS     R0,R0,#+40
        LDR.W    R1,??Calibrat_1+0x2C  ;; Ka1
        B.N      ??Calibrat_34
//  198           else                k = 0;           
??Calibrat_33:
        MOVS     R4,#+0
        B.N      ??Calibrat_35
//  199         } 
//  200         if(Channel == TRACK2){
??Calibrat_32:
        CMP      R10,#+1
        BNE.N    ??Calibrat_36
//  201           s8ToPercen(n, TmpB - 40);
        SUB      R1,R11,#+40
        SXTB     R1,R1
        ADD      R0,SP,#+4
        BL       s8ToPercen
//  202           Print_Str(245, 166-(Range*20), 0x0105, PRN, n);
        ADD      R0,SP,#+4
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+261
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVS     R0,#+245
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  203           if(TmpB - 40 != 0)  Kb1[Range] -= TmpB - 40;
        SUBS     R0,R11,#+40
        BEQ.N    ??Calibrat_33
        LDR.W    R0,??Calibrat_1+0x34  ;; Kb1
        LDRB     R0,[R7, R0]
        MOV      R1,R11
        SUBS     R0,R0,R1
        ADDS     R0,R0,#+40
        LDR.W    R1,??Calibrat_1+0x34  ;; Kb1
??Calibrat_34:
        STRB     R0,[R7, R1]
//  204           else                k = 0; 
//  205         }
//  206         if(k == 0)  Range++;
??Calibrat_36:
        CBNZ     R4,??Calibrat_37
??Calibrat_35:
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  207         if(Range > G_Attr[0].Yp_Max){ 
??Calibrat_37:
        LDR.W    R0,??Calibrat_1+0x48  ;; G_Attr
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+4]
        UXTB     R1,R5
        CMP      R0,R1
        BCS.N    ??Calibrat_38
//  208           Range = 0;  Step++;
        MOVS     R5,#+0
        ADDS     R6,R6,#+1
        UXTB     R6,R6
//  209         } 
//  210         __Set(CH_A_OFFSET, ((1024+Ka3[Range])*40 + 512)/1024);
??Calibrat_38:
        UXTB     R9,R5
        MOVS     R7,#+40
        LDR.W    R0,??Calibrat_1+0x30  ;; Ka3
        LDRSB    R0,[R9, R0]
        MOV      R1,#+41472
        MLA      R0,R0,R7,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R1,R0,#+10
        MOVS     R0,#+0
        BL       __Set
//  211         __Set(CH_B_OFFSET, ((1024+Kb3[Range])*40 + 512)/1024);
        LDR.W    R0,??Calibrat_1+0x38  ;; Kb3
        LDRSB    R0,[R9, R0]
        MOV      R1,#+41472
        MLA      R0,R0,R7,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
??Calibrat_39:
        ASRS     R1,R0,#+10
        MOVS     R0,#+1
        BL       __Set
        B.N      ??Calibrat_20
//  212         break;
//  213       case 3:
//  214         k++;
??Calibrat_40:
        ADDS     R4,R4,#+1
        MOV      R9,#+160
        LDR.W    R0,??Calibrat_1+0x30  ;; Ka3
        LDRSB    R0,[R7, R0]
        LDR.W    R1,??Calibrat_18+0x14  ;; 0x28200
        MLA      R0,R0,R9,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R1,R0,#+10
        MOVS     R0,#+0
//  215         __Set(CH_A_OFFSET, ((1024+Ka3[Range])*160 + 512)/1024);
        BL       __Set
//  216         __Set(CH_B_OFFSET, ((1024+Kb3[Range])*160 + 512)/1024);
        LDR.W    R0,??Calibrat_1+0x38  ;; Kb3
        LDRSB    R0,[R7, R0]
        LDR.W    R1,??Calibrat_18+0x14  ;; 0x28200
        MLA      R0,R0,R9,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R1,R0,#+10
        MOVS     R0,#+1
        BL       __Set
//  217         if((Channel == TRACK1)&&(TmpA > 140))  Step++;
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_41
        LDR      R0,[SP, #+0]
        CMP      R0,#+141
        B.N      ??Calibrat_42
//  218         if((Channel == TRACK2)&&(TmpB > 140))  Step++;
??Calibrat_41:
        CMP      R10,#+1
        BNE.N    ??Calibrat_43
        CMP      R11,#+141
??Calibrat_42:
        BLT.N    ??Calibrat_43
        ADDS     R6,R6,#+1
        UXTB     R6,R6
//  219         if(k > 20)  Step++;
??Calibrat_43:
        UXTB     R4,R4
        CMP      R4,#+21
        BCC.W    ??Calibrat_20
??Calibrat_44:
        ADDS     R6,R6,#+1
        UXTB     R6,R6
        B.N      ??Calibrat_20
//  220         break;
//  221       case 4:
//  222         k = 0;
??Calibrat_45:
        MOVS     R4,#+0
//  223         if(Channel == TRACK1){
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_46
//  224           s8ToPercen(n, TmpA - 160);
        LDR      R0,[SP, #+0]
        ADD      R1,R0,#+96
        SXTB     R1,R1
        ADD      R0,SP,#+4
        BL       s8ToPercen
//  225           Print_Str( 89, 166-(Range*20), 0x0005, INV, n);
        ADD      R0,SP,#+4
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+1
        MOVS     R2,#+5
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVS     R0,#+89
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  226           Ka3[Range] -= (1024*(TmpA-160)+80)/160;
        LDR.W    R0,??Calibrat_1+0x30  ;; Ka3
        LDRB     R0,[R7, R0]
        LDR      R1,[SP, #+0]
        LDR.W    R2,??Calibrat_18+0x18  ;; 0xfffd8050
        ADD      R1,R2,R1, LSL #+10
        MOVS     R2,#+160
        SDIV     R1,R1,R2
        SUBS     R0,R0,R1
        LDR.W    R1,??Calibrat_1+0x30  ;; Ka3
        B.N      ??Calibrat_47
        DATA
??Calibrat_22:
        DC8      " ",+0,+0
        THUMB
//  227         } 
//  228         if(Channel == TRACK2){
??Calibrat_46:
        CMP      R10,#+1
        BNE.N    ??Calibrat_48
//  229           s8ToPercen(n, TmpB - 160);
        ADD      R1,R11,#+96
        SXTB     R1,R1
        ADD      R0,SP,#+4
        BL       s8ToPercen
//  230           Print_Str(289, 166-(Range*20), 0x0105, INV, n);
        ADD      R0,SP,#+4
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+1
        MOVW     R2,#+261
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVW     R0,#+289
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  231           Kb3[Range] -= (1024*(TmpB-160)+80)/160;
        LDR.W    R0,??Calibrat_1+0x38  ;; Kb3
        LDRB     R0,[R7, R0]
        LDR.W    R1,??Calibrat_18+0x18  ;; 0xfffd8050
        ADD      R1,R1,R11, LSL #+10
        MOVS     R2,#+160
        SDIV     R1,R1,R2
        SUBS     R0,R0,R1
        LDR.W    R1,??Calibrat_1+0x38  ;; Kb3
??Calibrat_47:
        STRB     R0,[R7, R1]
//  232         }
//  233         Range++;
??Calibrat_48:
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  234         if(Range > G_Attr[0].Yp_Max){ 
        LDR.W    R0,??Calibrat_1+0x48  ;; G_Attr
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+4]
        CMP      R0,R5
        BCS.N    ??Calibrat_49
//  235           Range = 0;  Step++;
??Calibrat_50:
        MOVS     R5,#+0
        ADDS     R6,R6,#+1
        UXTB     R6,R6
//  236         } 
//  237         __Set(CH_A_OFFSET, ((1024+Ka3[Range])* 160 + 512)/1024);
??Calibrat_49:
        UXTB     R7,R5
        MOV      R9,#+160
        LDR.W    R0,??Calibrat_1+0x30  ;; Ka3
        LDRSB    R0,[R7, R0]
        LDR.W    R1,??Calibrat_18+0x14  ;; 0x28200
        MLA      R0,R0,R9,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R1,R0,#+10
        MOVS     R0,#+0
        BL       __Set
//  238         __Set(CH_B_OFFSET, ((1024+Kb3[Range])* 160 + 512)/1024);
        LDR.W    R0,??Calibrat_1+0x38  ;; Kb3
        LDRSB    R0,[R7, R0]
        LDR.W    R1,??Calibrat_18+0x14  ;; 0x28200
        MLA      R0,R0,R9,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        B.N      ??Calibrat_39
//  239         break;
//  240       case 5:
//  241         k++;
??Calibrat_51:
        ADDS     R4,R4,#+1
//  242         if(k >= 8) k = 0;
        UXTB     R4,R4
        CMP      R4,#+8
        IT       CS 
        MOVCS    R4,#+0
//  243         if(Channel == TRACK1){
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_52
//  244           s8ToPercen(n, TmpA - 160);
        LDR      R0,[SP, #+0]
        ADD      R1,R0,#+96
        SXTB     R1,R1
        ADD      R0,SP,#+4
        BL       s8ToPercen
//  245           Print_Str( 89, 166-(Range*20), 0x0005, PRN, n);
        ADD      R0,SP,#+4
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVS     R2,#+5
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVS     R0,#+89
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  246           if(TmpA - 160 != 0) Ka3[Range] -= (1024*(TmpA-160)+80)/160;
        LDR      R0,[SP, #+0]
        SUBS     R0,R0,#+160
        BEQ.N    ??Calibrat_53
        LDR.W    R0,??Calibrat_1+0x30  ;; Ka3
        LDRB     R0,[R7, R0]
        LDR      R1,[SP, #+0]
        LDR.W    R2,??Calibrat_18+0x18  ;; 0xfffd8050
        ADD      R1,R2,R1, LSL #+10
        MOVS     R2,#+160
        SDIV     R1,R1,R2
        SUBS     R0,R0,R1
        LDR.W    R1,??Calibrat_1+0x30  ;; Ka3
        B.N      ??Calibrat_54
//  247           else                k = 0;           
??Calibrat_53:
        MOVS     R4,#+0
        B.N      ??Calibrat_55
//  248         } 
//  249         if(Channel == TRACK2){
??Calibrat_52:
        CMP      R10,#+1
        BNE.N    ??Calibrat_56
//  250           s8ToPercen(n, TmpB - 160);
        ADD      R1,R11,#+96
        SXTB     R1,R1
        ADD      R0,SP,#+4
        BL       s8ToPercen
//  251           Print_Str(289, 166-(Range*20), 0x0105, PRN, n);
        ADD      R0,SP,#+4
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+261
        MOVS     R0,#+166
        MOVS     R1,#+20
        MLS      R1,R7,R1,R0
        UXTH     R1,R1
        MOVW     R0,#+289
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  252           if(TmpB - 160 != 0) Kb3[Range] -= (1024*(TmpB-160)+80)/160;
        SUBS     R0,R11,#+160
        BEQ.N    ??Calibrat_53
        LDR.W    R0,??Calibrat_1+0x38  ;; Kb3
        LDRB     R0,[R7, R0]
        LDR.W    R1,??Calibrat_18+0x18  ;; 0xfffd8050
        ADD      R1,R1,R11, LSL #+10
        MOVS     R2,#+160
        SDIV     R1,R1,R2
        SUBS     R0,R0,R1
        LDR.W    R1,??Calibrat_1+0x38  ;; Kb3
??Calibrat_54:
        STRB     R0,[R7, R1]
//  253           else                k = 0; 
//  254         }
//  255         if(k == 0)  Range++;
??Calibrat_56:
        CBNZ     R4,??Calibrat_57
??Calibrat_55:
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  256         if(Range > G_Attr[0].Yp_Max){ 
??Calibrat_57:
        LDR.W    R0,??Calibrat_1+0x48  ;; G_Attr
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+4]
        UXTB     R1,R5
        CMP      R0,R1
        BCS.W    ??Calibrat_49
        B.N      ??Calibrat_50
//  257           Range = 0;  Step++;
//  258         } 
//  259         __Set(CH_A_OFFSET, ((1024+Ka3[Range])* 160 + 512)/1024);
//  260         __Set(CH_B_OFFSET, ((1024+Kb3[Range])* 160 + 512)/1024);
//  261         break;
//  262       case 6:
//  263         k++;
??Calibrat_58:
        ADDS     R4,R4,#+1
//  264         if(k > 20)  Step++;
        UXTB     R4,R4
        CMP      R4,#+21
        BCC.N    ??Calibrat_59
        ADDS     R6,R6,#+1
        UXTB     R6,R6
//  265         Range = 0;
??Calibrat_59:
        MOVS     R5,#+0
        LDR.W    R0,??Calibrat_1+0x30  ;; Ka3
        LDRSB    R0,[R0, R5]
        LDRB     R1,[SP, #+16]
        CMP      R1,#+2
        BCS.N    ??Calibrat_60
//  266         if(m < 2){
//  267           __Set(CH_A_OFFSET, ((1024+Ka3[Range])*40 + 512)/1024);
        MOVS     R7,#+40
        MOV      R1,#+41472
        MLA      R0,R0,R7,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R1,R0,#+10
        MOVS     R0,#+0
        BL       __Set
//  268           __Set(CH_B_OFFSET, ((1024+Kb3[Range])*40 + 512)/1024);
        LDR.W    R0,??Calibrat_1+0x38  ;; Kb3
        LDRSB    R0,[R0, R5]
        MOV      R1,#+41472
        MLA      R0,R0,R7,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R1,R0,#+10
        MOVS     R0,#+1
        BL       __Set
//  269           if((Channel == TRACK1)&&(TmpA < 50)){
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_61
        LDR      R0,[SP, #+0]
        CMP      R0,#+50
        BGE.W    ??Calibrat_20
//  270             Step = 1;
??Calibrat_62:
        MOVS     R6,#+1
//  271             m++;
        LDRB     R0,[SP, #+16]
        ADDS     R0,R0,#+1
        STRB     R0,[SP, #+16]
        B.N      ??Calibrat_20
//  272           }
//  273           if((Channel == TRACK2)&&(TmpB < 50)){
??Calibrat_61:
        CMP      R10,#+1
        BNE.W    ??Calibrat_20
        CMP      R11,#+50
        BGE.W    ??Calibrat_20
        B.N      ??Calibrat_62
//  274             Step = 1;
//  275             m++;
//  276           }
//  277         } else {
//  278           __Set(CH_A_OFFSET, ((1024+Ka3[Range])* 25 + 512)/1024);
??Calibrat_60:
        MOVS     R7,#+25
        MOV      R1,#+26112
        MLA      R0,R0,R7,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R1,R0,#+10
        MOVS     R0,#+0
        BL       __Set
//  279           __Set(CH_B_OFFSET, ((1024+Kb3[Range])* 25 + 512)/1024);
        LDR.W    R0,??Calibrat_1+0x38  ;; Kb3
        LDRSB    R0,[R0, R5]
        MOV      R1,#+26112
        MLA      R0,R0,R7,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R1,R0,#+10
        MOVS     R0,#+1
        BL       __Set
//  280           if((Channel == TRACK1)&&(TmpA < 55))  Step++;
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_63
        LDR      R0,[SP, #+0]
        CMP      R0,#+55
        BGE.W    ??Calibrat_20
        B.N      ??Calibrat_44
//  281           if((Channel == TRACK2)&&(TmpB < 55))  Step++;
??Calibrat_63:
        CMP      R10,#+1
        BNE.W    ??Calibrat_20
        CMP      R11,#+55
        BGE.W    ??Calibrat_20
        B.N      ??Calibrat_44
//  282         }
??Calibrat_64:
        ADD      R0,R8,#+200
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+773
        MOVS     R1,#+216
        MOVS     R0,#+32
//  283         break;
//  284       case 7:
//  285         Print_Str( 4*8, 216, 0x0305, PRN,   " INPUT ");
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  286         Print_Str(11*8, 216, 0x0405, Twink, (u8*)VS_STR[Range]);
        MOVW     R9,#+1029
        MOVS     R0,#+12
        MLA      R0,R7,R0,R8
        ADD      R0,R0,#+744
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R9
        MOVS     R1,#+216
        MOVS     R0,#+88
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  287         Print_Str(20*8, 216, 0x0305, PRN,   " STANDARD VOLTAGE TO ");
        ADD      R0,R8,#+208
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+773
        MOVS     R1,#+216
        MOVS     R0,#+160
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  288         Print_Str(   8,   6, 0x0305, PRN,   "MODIFY VOLTAGE:   ...    ");
        ADD      R0,R8,#+232
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+773
        MOVS     R1,#+6
        MOVS     R0,#+8
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  289         Print_Str(18*8,   6, 0x0405, Twink, "-");
        ADR.N    R0,??Calibrat_1  ;; "-"
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R9
        MOVS     R1,#+6
        MOVS     R0,#+144
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  290         Print_Str(22*8,   6, 0x0405, Twink, "+");
        ADR.N    R0,??Calibrat_1+0xC  ;; "+"
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R9
        MOVS     R1,#+6
        MOVS     R0,#+176
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  291         Print_Str(27*8,   6, 0x0305, PRN,   "SELECT RANGE:   ---   ");
        ADD      R0,R8,#+260
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+773
        MOVS     R1,#+6
        MOVS     R0,#+216
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  292         Print_Str(42*8,   6, 0x0405, Twink, "<");
        ADR.N    R0,??Calibrat_1+0x14  ;; "<"
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R9
        MOVS     R1,#+6
        MOV      R0,#+336
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  293         Print_Str(46*8,   6, 0x0405, Twink, ">");
        ADR.N    R0,??Calibrat_1+0x18  ;; ">"
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R9
        MOVS     R1,#+6
        MOV      R0,#+368
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  294         if(Channel == TRACK1){
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_65
//  295           if(TmpA > 35){
        MOVS     R0,#+20
        MULS     R7,R7,R0
        LDR.W    R2,??Calibrat_18+0x1C  ;; V_UNIT
        LDR      R0,[SP, #+0]
        CMP      R0,#+36
        BLT.N    ??Calibrat_66
//  296             Int2Str(n, (TmpA - 25)* Y_Attr[Range].SCALE, V_UNIT, 3, SIGN);
        MOVS     R0,#+0
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+3
        LDR      R0,[SP, #+8]
        SUBS     R0,R0,#+25
        LDR.N    R1,??Calibrat_1+0x44  ;; Y_Attr
        LDR      R1,[R1, #+0]
        ADDS     R1,R7,R1
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        B.N      ??Calibrat_67
        CFI CFA R13+192
//  297           } else {
//  298             Int2Str(n, 0, V_UNIT, 3, SIGN);
??Calibrat_66:
        MOVS     R0,#+0
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+3
        MOVS     R1,#+0
??Calibrat_67:
        ADD      R0,SP,#+12
        BL       Int2Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  299           }
//  300           Print_Str( 134, 166-(Range*20), 0x0005, Twink, n);
        ADD      R0,SP,#+4
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOVS     R2,#+5
        RSB      R1,R7,#+166
        UXTH     R1,R1
        MOVS     R0,#+134
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  301           Print_Str(41*8, 216,            0x0005, PRN,   "CH_A  ");
        ADD      R0,R8,#+284
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVS     R2,#+5
        MOVS     R1,#+216
        MOV      R0,#+328
        B.N      ??Calibrat_68
        CFI CFA R13+192
//  302         } 
//  303         if(Channel == TRACK2){
??Calibrat_65:
        CMP      R10,#+1
        BNE.W    ??Calibrat_20
//  304           if(TmpB > 35){
        MOVS     R0,#+20
        MULS     R7,R7,R0
        LDR.W    R2,??Calibrat_18+0x1C  ;; V_UNIT
        CMP      R11,#+36
        BLT.N    ??Calibrat_69
//  305             Int2Str(n, (TmpB - 25)* Y_Attr[Range].SCALE, V_UNIT, 3, SIGN);
        MOVS     R0,#+0
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+3
        SUB      R0,R11,#+25
        LDR.N    R1,??Calibrat_1+0x44  ;; Y_Attr
        LDR      R1,[R1, #+0]
        ADDS     R1,R7,R1
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        B.N      ??Calibrat_70
        CFI CFA R13+192
//  306           } else {
//  307             Int2Str(n, 0, V_UNIT, 3, SIGN);
??Calibrat_69:
        MOVS     R0,#+0
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+3
        MOVS     R1,#+0
??Calibrat_70:
        ADD      R0,SP,#+12
        BL       Int2Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  308           }
//  309           Print_Str( 334, 166-(Range*20), 0x0105, Twink, n);
        ADD      R0,SP,#+4
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOVW     R2,#+261
        RSB      R1,R7,#+166
        UXTH     R1,R1
        MOV      R0,#+334
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  310           Print_Str(41*8, 216,            0x0105, PRN,   "CH_B  ");
        ADD      R0,R8,#+292
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+261
        MOVS     R1,#+216
        MOV      R0,#+328
        B.N      ??Calibrat_68
        CFI CFA R13+192
//  311         }
//  312         break;
//  313       case 8:                             //"    PRESS   ---   TO SELECT THE NEXT OPERATION"
//  314         m = 0;
??Calibrat_71:
        MOVS     R0,#+0
        STRB     R0,[SP, #+16]
        ADD      R0,R8,#+300
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+773
        MOVS     R1,#+6
        MOVS     R0,#+8
//  315         Print_Str(   8,   6, 0x0305, PRN,   "    PRESS   ---  ");
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  316         Print_Str(12*8,   6, 0x0405, Twink, "<");
        MOVW     R9,#+1029
        ADR.N    R0,??Calibrat_1+0x14  ;; "<"
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R9
        MOVS     R1,#+6
        MOVS     R0,#+96
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  317         Print_Str(16*8,   6, 0x0405, Twink, ">");
        ADR.N    R0,??Calibrat_1+0x18  ;; ">"
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R9
        MOVS     R1,#+6
        MOVS     R0,#+128
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  318         Print_Str(17*8,   6, 0x0305, PRN,   " TO SELECT THE NEXT OPERATION   ");
        ADD      R0,R8,#+320
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+773
        MOVS     R1,#+6
        MOVS     R0,#+136
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  319         Print_Str(   8, 216, 0x0305, PRN,   "  PRESS   TO ");
        ADD      R0,R8,#+356
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+773
        MOVS     R1,#+216
        MOVS     R0,#+8
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  320         Print_Str(14*8, 216, 0x0405, PRN,   "CONFIRM THE RE-CALIBRATION ");
        ADD      R0,R8,#+372
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOV      R2,R9
        MOVS     R1,#+216
        MOVS     R0,#+112
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  321         Print_Str( 9*8, 216, 0x0405, Twink, " ");       
        ADR.N    R0,??Calibrat_1+0x28  ;; " "
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R9
        MOVS     R1,#+216
        MOVS     R0,#+72
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  322         if(Channel == TRACK1)  Print_Str(41*8, 216, 0x0005, PRN, "CH_A "); 
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_72
        ADD      R0,R8,#+400
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVS     R2,#+5
        MOVS     R1,#+216
        MOV      R0,#+328
        B.N      ??Calibrat_68
        CFI CFA R13+192
//  323         if(Channel == TRACK2)  Print_Str(41*8, 216, 0x0105, PRN, "CH_B ");
??Calibrat_72:
        CMP      R10,#+1
        BNE.N    ??Calibrat_20
        ADD      R0,R8,#+408
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+261
        MOVS     R1,#+216
        MOV      R0,#+328
        B.N      ??Calibrat_68
        CFI CFA R13+192
//  324         break;                            //"  PRESS   TO CONFIRM THE RE-CALIBRATION CH_A  "
//  325       case 9:                             //             "SELECT THE CALIBRATION CH_A      "
//  326         Print_Str( 9*8, 216, 0x0405, Twink, " ");       
??Calibrat_73:
        MOVW     R9,#+1029
        ADR.N    R0,??Calibrat_1+0x28  ;; " "
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R9
        MOVS     R1,#+216
        MOVS     R0,#+72
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  327         Print_Str(14*8, 216, 0x0405, PRN,   "SELECT THE CALIBRATION ");
        ADD      R0,R8,#+416
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOV      R2,R9
        MOVS     R1,#+216
        MOVS     R0,#+112
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  328         if(Channel == TRACK1)  Print_Str(37*8, 216, 0x0105, PRN, "CH_B     "); 
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_74
        ADD      R0,R8,#+440
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+261
        MOVS     R1,#+216
        MOV      R0,#+296
        B.N      ??Calibrat_68
        CFI CFA R13+192
//  329         if(Channel == TRACK2)  Print_Str(37*8, 216, 0x0005, PRN, "CH_A     ");
??Calibrat_74:
        CMP      R10,#+1
        BNE.N    ??Calibrat_20
        ADD      R0,R8,#+452
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVS     R2,#+5
        MOVS     R1,#+216
        MOV      R0,#+296
        B.N      ??Calibrat_68
        CFI CFA R13+192
//  330         break;
//  331       case 10:                            //             "Exit WITHOUT SAVE RESULTS        "
//  332         Print_Str( 9*8, 216, 0x0405, Twink, " ");       
??Calibrat_75:
        MOVW     R9,#+1029
        ADR.N    R0,??Calibrat_1+0x28  ;; " "
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R9
        MOVS     R1,#+216
        MOVS     R0,#+72
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  333         Print_Str(14*8, 216, 0x0405, PRN,   "Exit WITHOUT SAVE RESULTS        ");
        ADD      R0,R8,#+464
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOV      R2,R9
        MOVS     R1,#+216
        MOVS     R0,#+112
        B.N      ??Calibrat_68
        CFI CFA R13+192
//  334         break;
//  335       case 11:                            //             "Exit AND SAVE CALIBRATION RESULTS"
//  336         Print_Str( 9*8, 216, 0x0405, Twink, " ");       
??Calibrat_76:
        MOVW     R9,#+1029
        ADR.N    R0,??Calibrat_1+0x28  ;; " "
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R9
        MOVS     R1,#+216
        MOVS     R0,#+72
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  337         Print_Str(14*8, 216, 0x0405, PRN,   "Exit AND SAVE CALIBRATION RESULTS");
        ADD      R0,R8,#+500
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOV      R2,R9
        MOVS     R1,#+216
        MOVS     R0,#+112
        B.N      ??Calibrat_68
        CFI CFA R13+192
//  338         break;
//  339       case 12:                            //             "Exit AND RESTORE SYSTEM DEFAULTS "
//  340         Print_Str( 9*8, 216, 0x0405, Twink, " ");       
??Calibrat_77:
        MOVW     R9,#+1029
        ADR.N    R0,??Calibrat_1+0x28  ;; " "
        PUSH     {R0,LR}
        CFI CFA R13+200
        LDR.W    R0,??Calibrat_18+0x10  ;; Twink
        LDRB     R3,[R0, #+0]
        MOV      R2,R9
        MOVS     R1,#+216
        MOVS     R0,#+72
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  341         Print_Str(14*8, 216, 0x0405, PRN,   "Exit AND RESTORE SYSTEM DEFAULTS ");
        ADD      R0,R8,#+536
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOV      R2,R9
        MOVS     R1,#+216
        MOVS     R0,#+112
??Calibrat_68:
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  342         break;
//  343       }
//  344     }
//  345     if(Key_Buffer){ 
??Calibrat_20:
        LDR.N    R0,??Calibrat_1+0x4  ;; Key_Buffer
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.W    ??Calibrat_15
//  346       PD_Cnt = 600;                               // 重新设定等待时间600秒
        LDR.N    R0,??Calibrat_1+0x4C  ;; PD_Cnt
        MOV      R1,#+600
        STRH     R1,[R0, #+0]
//  347       if((Range <= G_Attr[0].Yp_Max)&&(Step == 7)){
        LDR.N    R0,??Calibrat_1+0x48  ;; G_Attr
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+4]
        UXTB     R1,R5
        CMP      R0,R1
        BCC.N    ??Calibrat_78
        UXTB     R0,R6
        CMP      R0,#+7
        BNE.N    ??Calibrat_78
//  348         if(Channel == TRACK1){
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_79
//  349           Print_Str(134, 166-(Range*20), 0x0005, PRN, n);
        ADD      R0,SP,#+4
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVS     R2,#+5
        MOVS     R0,#+166
        MOV      R12,#+20
        MLS      R1,R1,R12,R0
        UXTH     R1,R1
        MOVS     R0,#+134
        B.N      ??Calibrat_80
        Nop      
        DATA
??Calibrat_1:
        DC8      "-",+0,+0
        DC32     Key_Buffer
        DC32     Title
        DC8      "+",+0,+0
        DC32     Interlace
        DC8      "<",+0,+0
        DC8      ">",+0,+0
        DC32     Beep_mS
        DC32     X_Attr
        DC32     `?<Constant "CH_A">`
        DC8      " ",+0,+0
        DC32     Ka1
        DC32     Ka3
        DC32     Kb1
        DC32     Kb3
        DC32     Ka2
        DC32     Kb2
        DC32     Y_Attr
        DC32     G_Attr
        DC32     PD_Cnt
        CFI CFA R13+192
        THUMB
//  350         }
//  351         if(Channel == TRACK2){
??Calibrat_79:
        CMP      R10,#+1
        BNE.N    ??Calibrat_78
//  352           Print_Str(334, 166-(Range*20), 0x0105, PRN, n);
        ADD      R0,SP,#+4
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+261
        MOVS     R0,#+166
        MOV      R12,#+20
        MLS      R1,R1,R12,R0
        UXTH     R1,R1
        MOV      R0,#+334
??Calibrat_80:
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  353         }
//  354       } 
//  355       switch (Key_Buffer){  
??Calibrat_78:
        LDR.N    R0,??Calibrat_18+0x20  ;; Key_Buffer
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BEQ.N    ??Calibrat_81
        CMP      R0,#+5
        BEQ.W    ??Calibrat_82
        CMP      R0,#+6
        BEQ.W    ??Calibrat_83
        CMP      R0,#+8
        BEQ.W    ??Calibrat_84
        CMP      R0,#+9
        BEQ.W    ??Calibrat_85
        B.N      ??Calibrat_86
//  356       case KEY2:
//  357         if(Step == 0)  Step++;
??Calibrat_81:
        UXTB     R0,R6
        CBNZ     R0,??Calibrat_87
        ADDS     R6,R6,#+1
        UXTB     R6,R6
//  358         if((Step == 8)||(Step == 9)){
??Calibrat_87:
        UXTB     R0,R6
        CMP      R0,#+8
        BEQ.N    ??Calibrat_88
        CMP      R0,#+9
        BNE.N    ??Calibrat_89
//  359           if(Step == 9) Channel = 1 - Channel;
        RSB      R10,R10,#+1
//  360           for(i=0; i<=G_Attr[0].Yp_Max; i++){
??Calibrat_88:
        MOVS     R7,#+0
        MOVS     R6,#+166
        MOVW     R9,#+289
//  361             if(Channel == TRACK1){
??Calibrat_90:
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_91
//  362               Print_Str( 45, 166-(i*20), 0x0005, PRN, "     ");   
        ADD      R0,R8,#+572
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVS     R2,#+5
        UXTH     R1,R6
        MOVS     R0,#+45
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  363               Print_Str( 89, 166-(i*20), 0x0005, PRN, "     ");   
        ADD      R0,R8,#+572
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVS     R2,#+5
        UXTH     R1,R6
        MOVS     R0,#+89
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  364               Print_Str(134, 166-(i*20), 0x0005, PRN, "       ");  
        ADD      R0,R8,#+580
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVS     R2,#+5
        UXTH     R1,R6
        MOVS     R0,#+134
        B.N      ??Calibrat_92
        CFI CFA R13+192
//  365             }
//  366             if(Channel == TRACK2){
??Calibrat_91:
        CMP      R10,#+1
        BNE.N    ??Calibrat_93
//  367               Print_Str(245, 166-(i*20), 0x0105, PRN, "     ");
        ADD      R0,R8,#+572
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+261
        UXTH     R1,R6
        MOVS     R0,#+245
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  368               Print_Str(289, 166-(i*20), 0x0105, PRN, "     ");
        ADD      R0,R8,#+572
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+261
        UXTH     R1,R6
        MOV      R0,R9
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  369               Print_Str(334, 166-(i*20), 0x0105, PRN, "       ");
        ADD      R0,R8,#+580
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+261
        UXTH     R1,R6
        MOV      R0,#+334
??Calibrat_92:
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  370             }
//  371           }
??Calibrat_93:
        ADDS     R7,R7,#+1
        UXTH     R7,R7
        SUBS     R6,R6,#+20
        LDR.N    R0,??DataTable8  ;; G_Attr
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+4]
        CMP      R0,R7
        BCS.N    ??Calibrat_90
//  372           Step = 0;; 
        MOVS     R6,#+0
        B.N      ??Calibrat_86
//  373         } 
//  374         if(Step >= 10){
??Calibrat_89:
        CMP      R0,#+10
        BCC.W    ??Calibrat_86
//  375           if(Step == 10){
        BNE.N    ??Calibrat_94
//  376             for(i=0; i<=G_Attr[0].Yp_Max; i++){
        MOVS     R7,#+0
        LDR.N    R0,??Calibrat_18+0x24  ;; Ka1
        STR      R0,[SP, #+20]
        ADD      R0,SP,#+64
        STR      R0,[SP, #+24]
        LDR.N    R0,??Calibrat_18+0x28  ;; Ka3
        STR      R0,[SP, #+28]
        ADD      R0,SP,#+88
        STR      R0,[SP, #+32]
        LDR.N    R0,??Calibrat_18+0x2C  ;; Kb1
        ADD      R1,SP,#+76
        LDR.N    R2,??Calibrat_18+0x30  ;; Kb3
        ADD      R3,SP,#+100
        LDR.W    R12,??Calibrat_18+0x34  ;; Ka2
        ADD      LR,SP,#+112
        LDR.N    R4,??Calibrat_18+0x38  ;; Kb2
        ADD      R5,SP,#+132
//  377               Ka1[i] = Ma1[i];  Ka2[i] = Ma2[i];  Ka3[i] = Ma3[i];
??Calibrat_95:
        ADD      R10,SP,#+20
        LDR      R9,[R10, #+0]
        ADD      R11,R9,#+1
        STR      R11,[R10, #+0]
        STR      R9,[SP, #-8]!
        CFI CFA R13+200
        ADD      R9,SP,#+32
        LDR      R10,[R9, #+0]
        ADD      R11,R10,#+1
        STR      R11,[R9, #+0]
        LDRB     R10,[R10, #+0]
        LDR      R9,[SP], #+8
        CFI CFA R13+192
        STRB     R10,[R9, #+0]
        LDRH     R9,[LR], #+2
        STRH     R9,[R12], #+2
        ADD      R10,SP,#+28
        LDR      R9,[R10, #+0]
        ADD      R11,R9,#+1
        STR      R11,[R10, #+0]
        STR      R9,[SP, #-8]!
        CFI CFA R13+200
        ADD      R9,SP,#+40
        LDR      R10,[R9, #+0]
        ADD      R11,R10,#+1
        STR      R11,[R9, #+0]
        LDRB     R10,[R10, #+0]
        LDR      R9,[SP], #+8
        CFI CFA R13+192
        STRB     R10,[R9, #+0]
//  378               Kb1[i] = Mb1[i];  Kb2[i] = Mb2[i];  Kb3[i] = Mb3[i];
        LDRB     R9,[R1], #+1
        STRB     R9,[R0], #+1
        LDRH     R9,[R5], #+2
        STRH     R9,[R4], #+2
        LDRB     R9,[R3], #+1
        STRB     R9,[R2], #+1
//  379             }
        ADDS     R7,R7,#+1
        UXTH     R7,R7
        LDR.W    R9,??DataTable8  ;; G_Attr
        LDR      R9,[R9, #+0]
        LDRH     R9,[R9, #+4]
        CMP      R9,R7
        BCS.N    ??Calibrat_95
//  380             Save_Param();                         // 不保存校正后的参数
        BL       Save_Param
//  381             Print_Str( 8, 216, 0x0405, PRN, "                                                ");
        ADD      R0,R8,#+588
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+1029
        MOVS     R1,#+216
        MOVS     R0,#+8
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  382           } 
//  383           if(Step == 11){
??Calibrat_94:
        UXTB     R0,R6
        CMP      R0,#+11
        BNE.N    ??Calibrat_96
//  384             Save_Param();                         // 保存校正后的参数
        BL       Save_Param
//  385             Print_Str( 8, 216, 0x0405, PRN, "          SAVING THE CALIBRATION DATA           ");
        ADD      R0,R8,#+640
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+1029
        MOVS     R1,#+216
        MOVS     R0,#+8
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  386           }  
//  387           if(Step == 12){ 
??Calibrat_96:
        UXTB     R6,R6
        CMP      R6,#+12
        BNE.N    ??Calibrat_97
//  388             for(i=0; i<=G_Attr[0].Yp_Max; i++){
        MOVS     R7,#+0
        LDR.N    R0,??Calibrat_18+0x24  ;; Ka1
        LDR.N    R1,??Calibrat_18+0x28  ;; Ka3
        LDR.N    R2,??Calibrat_18+0x2C  ;; Kb1
        LDR.N    R3,??Calibrat_18+0x30  ;; Kb3
        LDR.W    R12,??Calibrat_18+0x34  ;; Ka2
        LDR.W    LR,??Calibrat_18+0x38  ;; Kb2
//  389               Ka1[i] = 0; Ka2[i] = 1024; Ka3[i] = 0;         // 设置校准参数初值
??Calibrat_98:
        MOVS     R4,#+0
        STRB     R4,[R0], #+1
        MOV      R4,#+1024
        STRH     R4,[R12], #+2
        MOVS     R4,#+0
        STRB     R4,[R1], #+1
//  390               Kb1[i] = 0; Kb2[i] = 1024; Kb3[i] = 0;
        STRB     R4,[R2], #+1
        MOV      R4,#+1024
        STRH     R4,[LR], #+2
        MOVS     R4,#+0
        STRB     R4,[R3], #+1
//  391             }
        ADDS     R7,R7,#+1
        UXTH     R7,R7
        LDR.N    R4,??DataTable8  ;; G_Attr
        LDR      R4,[R4, #+0]
        LDRH     R4,[R4, #+4]
        CMP      R4,R7
        BCS.N    ??Calibrat_98
//  392             Save_Param();  // 清除校准参数，保存缺省值 
        BL       Save_Param
//  393             Print_Str( 8, 216, 0x0405, PRN, "       RESTORE DEFAULTS CALIBRATION DATA        ");
        ADD      R0,R8,#+692
        PUSH     {R0,LR}
        CFI CFA R13+200
        MOVS     R3,#+0
        MOVW     R2,#+1029
        MOVS     R1,#+216
        MOVS     R0,#+8
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+192
//  394           }
//  395           Delayms(1000);                                      
??Calibrat_97:
        MOV      R0,#+1000
        BL       Delayms
//  396           App_init();
        BL       App_init
//  397           return;
        B.W      ??Calibrat_17
//  398         }
//  399         break;
//  400       case KEY3:
//  401         break;
//  402       case K_ITEM_DEC:
//  403         if((Step == 7)&&(Range > 0)) Range--;  
??Calibrat_85:
        UXTB     R0,R6
        CMP      R0,#+7
        BNE.N    ??Calibrat_99
        UXTB     R0,R5
        CBZ      R0,??Calibrat_99
        SUBS     R5,R5,#+1
        UXTB     R5,R5
//  404         if( Step >= 9)               Step--;
??Calibrat_99:
        UXTB     R0,R6
        CMP      R0,#+9
        BCC.N    ??Calibrat_100
        SUBS     R6,R6,#+1
        UXTB     R6,R6
//  405         if( Step == 8)               Step = 12;
??Calibrat_100:
        UXTB     R0,R6
        CMP      R0,#+8
        BNE.N    ??Calibrat_86
        MOVS     R6,#+12
        B.N      ??Calibrat_86
//  406         break;
//  407       case K_ITEM_INC:
//  408         if(Step >= 8)  Step++;
??Calibrat_84:
        UXTB     R0,R6
        CMP      R0,#+8
        BCC.N    ??Calibrat_101
        ADDS     R6,R6,#+1
        UXTB     R6,R6
//  409         if(Step > 12)  Step = 8;
??Calibrat_101:
        UXTB     R0,R6
        CMP      R0,#+13
        BCC.N    ??Calibrat_102
        MOVS     R6,#+8
        B.N      ??Calibrat_103
//  410         if(Step == 7)  Range++;  
??Calibrat_102:
        CMP      R0,#+7
        BNE.N    ??Calibrat_103
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  411         if(Range  > G_Attr[0].Yp_Max){  
??Calibrat_103:
        LDR.N    R0,??DataTable8  ;; G_Attr
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+4]
        UXTB     R1,R5
        CMP      R0,R1
        BCS.N    ??Calibrat_86
//  412           Range = 0;        
        MOVS     R5,#+0
//  413           Step++;
        ADDS     R6,R6,#+1
        UXTB     R6,R6
        B.N      ??Calibrat_86
//  414         } 
//  415         break;
//  416       case K_INDEX_DEC:
//  417         if(Step == 7){  
??Calibrat_82:
        UXTB     R0,R6
        CMP      R0,#+7
        BNE.N    ??Calibrat_86
//  418           if((Channel == TRACK1)&&(TmpA > 35))  Ka2[Range] -= 2;
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_104
        LDR      R0,[SP, #+0]
        CMP      R0,#+36
        BLT.N    ??Calibrat_86
        UXTB     R0,R5
        LDR.N    R1,??Calibrat_18+0x34  ;; Ka2
        LDRH     R1,[R1, R0, LSL #+1]
        SUBS     R1,R1,#+2
        LDR.N    R2,??Calibrat_18+0x34  ;; Ka2
        STRH     R1,[R2, R0, LSL #+1]
        B.N      ??Calibrat_86
//  419           if((Channel == TRACK2)&&(TmpB > 35))  Kb2[Range] -= 2;
??Calibrat_104:
        CMP      R10,#+1
        BNE.N    ??Calibrat_86
        CMP      R11,#+36
        BLT.N    ??Calibrat_86
        UXTB     R0,R5
        LDR.N    R1,??Calibrat_18+0x38  ;; Kb2
        LDRH     R1,[R1, R0, LSL #+1]
        SUBS     R1,R1,#+2
        LDR.N    R2,??Calibrat_18+0x38  ;; Kb2
        STRH     R1,[R2, R0, LSL #+1]
        B.N      ??Calibrat_86
//  420         }
//  421         break;
//  422       case K_INDEX_INC:
//  423         if(Step == 7){  
??Calibrat_83:
        UXTB     R0,R6
        CMP      R0,#+7
        BNE.N    ??Calibrat_86
//  424           if((Channel == TRACK1)&&(TmpA > 35))  Ka2[Range] += 2;
        UXTB     R10,R10
        CMP      R10,#+0
        BNE.N    ??Calibrat_105
        LDR      R0,[SP, #+0]
        CMP      R0,#+36
        BLT.N    ??Calibrat_86
        UXTB     R0,R5
        LDR.N    R1,??Calibrat_18+0x34  ;; Ka2
        LDRH     R1,[R1, R0, LSL #+1]
        ADDS     R1,R1,#+2
        LDR.N    R2,??Calibrat_18+0x34  ;; Ka2
        STRH     R1,[R2, R0, LSL #+1]
        B.N      ??Calibrat_86
//  425           if((Channel == TRACK2)&&(TmpB > 35))  Kb2[Range] += 2;
??Calibrat_105:
        CMP      R10,#+1
        BNE.N    ??Calibrat_86
        CMP      R11,#+36
        BLT.N    ??Calibrat_86
        UXTB     R0,R5
        LDR.N    R1,??Calibrat_18+0x38  ;; Kb2
        LDRH     R1,[R1, R0, LSL #+1]
        ADDS     R1,R1,#+2
        LDR.N    R2,??Calibrat_18+0x38  ;; Kb2
        STRH     R1,[R2, R0, LSL #+1]
//  426         }
//  427         break;
//  428       }
//  429       Key_Buffer = 0;
??Calibrat_86:
        LDR.N    R0,??Calibrat_18+0x20  ;; Key_Buffer
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
        B.W      ??Calibrat_15
        Nop      
        DATA
??Calibrat_18:
        DC32     a_Avg
        DC32     b_Avg
        DC32     DataBuf
        DC32     Blink
        DC32     Twink
        DC32     0x28200
        DC32     0xfffd8050
        DC32     V_UNIT
        DC32     Key_Buffer
        DC32     Ka1
        DC32     Ka3
        DC32     Kb1
        DC32     Kb3
        DC32     Ka2
        DC32     Kb2
        CFI EndBlock cfiBlock1
//  430     }
//  431   }
//  432 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     G_Attr

        END
//  433 /*********************************  END OF FILE  ******************************/
// 
// 1 022 bytes in section .rodata
// 4 972 bytes in section .text
// 
// 4 972 bytes of CODE  memory
// 1 022 bytes of CONST memory
//
//Errors: none
//Warnings: none
