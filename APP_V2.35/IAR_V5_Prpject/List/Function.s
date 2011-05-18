///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  13:45:33 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\APP_V2.32\source\Function.c                   /
//    Command line =  E:\DS0203\APP_V2.32\source\Function.c -lA               /
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
//    List file    =  E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\Function.s      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Function

        EXTERN Delay_Cnt
        EXTERN Key_Repeat_Cnt
        EXTERN Key_Status_Last
        EXTERN Key_Wait_Cnt
        EXTERN __Get
        EXTERN __aeabi_memcpy

        PUBLIC Char2Hex
        PUBLIC Delayms
        PUBLIC Int32String
        PUBLIC Int32String_sign
        PUBLIC Int_sqrt
        PUBLIC Read_Keys
        PUBLIC Str2Byte
        PUBLIC Word2Hex
        PUBLIC u16ToDec5
        PUBLIC u8ToDec2
        PUBLIC u8ToDec3
        
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
        
// E:\DS0203\APP_V2.32\source\Function.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : Function.c  
//    3  Version   : DS203 APP Ver 2.3x                          Author : bure & Kewei
//    4 *******************************************************************************/
//    5 #include "Interrupt.h"
//    6 #include "Function.h"
//    7 #include "BIOS.h"
//    8 
//    9 /*******************************************************************************
//   10  delayms: 毫秒（mS）延时程序。 输入: 延时等待的毫秒数值（在72MHz主频情况下）
//   11 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Delayms
        THUMB
//   12 void Delayms(u16 mS) 
//   13 { 
//   14   Delay_Cnt = mS;
Delayms:
        LDR.N    R1,??Delayms_0   ;; Delay_Cnt
        STRH     R0,[R1, #+0]
//   15   while (Delay_Cnt > 0){}
??Delayms_1:
        LDRH     R0,[R1, #+0]
        CMP      R0,#+0
        BNE.N    ??Delayms_1
//   16 }
        BX       LR               ;; return
        DATA
??Delayms_0:
        DC32     Delay_Cnt
        CFI EndBlock cfiBlock0
//   17 /*******************************************************************************
//   18  Int32String_sign:带符号32位数转3位有效数字字符串  
//   19 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function Int32String_sign
        THUMB
//   20 void Int32String_sign(I32STR_RES *r, s32 n)
//   21 {
Int32String_sign:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//   22     u32 i, m, c, e=3, fixlen;
        MOV      R12,#+3
//   23      u8 *p = r->str;
        ADDS     R3,R0,#+2
//   24     fixlen=e+2;
//   25     if ( n == 0 ) {
        CBNZ     R1,??Int32String_sign_1
//   26         *p++ = '+';
        MOVS     R1,#+43
        STRB     R1,[R3, #+0]
//   27         *p++ = '0';
        MOVS     R1,#+48
        STRB     R1,[R3, #+1]!
//   28         *p++ = '.';
        MOVS     R1,#+46
        STRB     R1,[R3, #+1]!
//   29         *p++ = '0';
        MOVS     R1,#+48
        STRB     R1,[R3, #+1]!
//   30         *p++ = '0';
        STRB     R1,[R3, #+1]!
//   31         *p = 0;
        MOVS     R1,#+0
        STRB     R1,[R3, #+1]!
//   32         r->decPos = 0;
        STRB     R1,[R0, #+0]
//   33         r->len = p-r->str;
        MOVS     R1,#+5
        B.N      ??Int32String_sign_2
//   34         return;
//   35     }  
//   36     if ( n > 0 )
??Int32String_sign_1:
        CMP      R1,#+1
        BLT.N    ??Int32String_sign_3
//   37         *p++ = '+';
        MOVS     R2,#+43
        STRB     R2,[R3], #+1
        B.N      ??Int32String_sign_4
//   38     else {
//   39         *p++ = '-';
??Int32String_sign_3:
        MOVS     R2,#+45
        STRB     R2,[R3], #+1
//   40         n = -n;
        MOVS     R2,R1
        RSBS     R1,R2,#+0
//   41     }
//   42     m = n;
??Int32String_sign_4:
        MOV      LR,R1
//   43     i = 0;
        MOVS     R2,#+0
//   44     c = 5;
        MOVS     R4,#+5
        MOVS     R5,#+10
        B.N      ??Int32String_sign_5
//   45     while ( m >= 10 ) {
//   46         m /= 10;
??Int32String_sign_6:
        UDIV     LR,LR,R5
//   47         if ( ++i > e ) c *= 10;
        ADDS     R2,R2,#+1
        CMP      R2,#+4
        IT       CS 
        MULCS    R4,R4,R5
//   48     }
??Int32String_sign_5:
        CMP      LR,#+10
        BCS.N    ??Int32String_sign_6
//   49     r->decPos = i/3;   
        MOV      LR,R12
        UDIV     LR,R2,LR
        STRB     LR,[R0, #+0]
//   50     if ( i >= e ) n += c;
        CMP      R2,#+3
        IT       CS 
        ADDCS    R1,R4,R1
//   51     switch ( i ) {
        CMP      R2,#+9
        BHI.W    ??Int32String_sign_7
        TBB      [PC, R2]
        DATA
??Int32String_sign_0:
        DC8      +131,+119,+107,+90
        DC8      +77,+64,+46,+33
        DC8      +20,+5
        THUMB
//   52     case 9:
//   53         *p++ = '0'+n/1000000000;
??Int32String_sign_8:
        LDR.N    R2,??DataTable5  ;; 0x3b9aca00
        SDIV     LR,R1,R2
        ADD      R12,LR,#+48
        STRB     R12,[R3], #+1
//   54         if ( --e == 0 ) break;
        MOV      R12,#+2
//   55         n %= 1000000000;
        MLS      R1,LR,R2,R1
//   56         *p++ = '.', i = 0;
        MOVS     R2,#+46
        STRB     R2,[R3], #+1
        MOVS     R2,#+0
//   57     case 8:
//   58         *p++ = '0'+n/100000000;
??Int32String_sign_9:
        LDR.W    LR,??DataTable6  ;; 0x5f5e100
        SDIV     R4,R1,LR
        MOVS     R5,R4
        ADDS     R5,R5,#+48
        STRB     R5,[R3], #+1
//   59         if ( --e == 0 ) break;
        SUBS     R12,R12,#+1
        BEQ.N    ??Int32String_sign_7
//   60         n %= 100000000;
        MLS      R1,R4,LR,R1
//   61     case 7:
//   62         *p++ = '0'+n/10000000;
??Int32String_sign_10:
        LDR.W    LR,??DataTable7  ;; 0x989680
        SDIV     R4,R1,LR
        MOVS     R5,R4
        ADDS     R5,R5,#+48
        STRB     R5,[R3], #+1
//   63         if ( --e == 0 ) break;
        SUBS     R12,R12,#+1
        BEQ.N    ??Int32String_sign_7
//   64         n %= 10000000;
        MLS      R1,R4,LR,R1
//   65     case 6:
//   66         *p++ = '0'+n/1000000;
??Int32String_sign_11:
        LDR.W    LR,??DataTable8  ;; 0xf4240
        SDIV     R4,R1,LR
        MOVS     R5,R4
        ADDS     R5,R5,#+48
        STRB     R5,[R3], #+1
//   67         if ( --e == 0 ) break;
        SUBS     R12,R12,#+1
        BEQ.N    ??Int32String_sign_7
//   68         n %= 1000000;
        MLS      R1,R4,LR,R1
//   69         if ( i ) *p++ = '.', i = 0;
        CBZ      R2,??Int32String_sign_12
        MOVS     R2,#+46
        STRB     R2,[R3], #+1
        MOVS     R2,#+0
//   70     case 5:
//   71         *p++ = '0'+n/100000;
??Int32String_sign_12:
        LDR.W    LR,??DataTable9  ;; 0x186a0
        SDIV     R4,R1,LR
        MOVS     R5,R4
        ADDS     R5,R5,#+48
        STRB     R5,[R3], #+1
//   72         if ( --e == 0 ) break;
        SUBS     R12,R12,#+1
        BEQ.N    ??Int32String_sign_7
//   73         n %= 100000;
        MLS      R1,R4,LR,R1
//   74     case 4:
//   75         *p++ = '0'+n/10000;
??Int32String_sign_13:
        MOVW     LR,#+10000
        SDIV     R4,R1,LR
        MOVS     R5,R4
        ADDS     R5,R5,#+48
        STRB     R5,[R3], #+1
//   76         if ( --e == 0 ) break;
        SUBS     R12,R12,#+1
        BEQ.N    ??Int32String_sign_7
//   77         n %= 10000;
        MLS      R1,R4,LR,R1
//   78     case 3:
//   79         *p++ = '0'+n/1000;
??Int32String_sign_14:
        MOV      LR,#+1000
        SDIV     R4,R1,LR
        MOVS     R5,R4
        ADDS     R5,R5,#+48
        STRB     R5,[R3], #+1
//   80         if ( --e == 0 ) break;
        SUBS     R12,R12,#+1
        BEQ.N    ??Int32String_sign_7
//   81         n %= 1000;
        MLS      R1,R4,LR,R1
//   82         if ( i ) *p++ = '.', i = 0;
        CBZ      R2,??Int32String_sign_15
        MOVS     R2,#+46
        STRB     R2,[R3], #+1
//   83     case 2:
//   84         *p++ = '0'+n/100;
??Int32String_sign_15:
        MOVS     R2,#+100
        SDIV     LR,R1,R2
        MOV      R4,LR
        ADDS     R4,R4,#+48
        STRB     R4,[R3], #+1
//   85         if ( --e == 0 ) break;
        SUBS     R12,R12,#+1
        BEQ.N    ??Int32String_sign_7
//   86         n %= 100;
        MLS      R1,LR,R2,R1
//   87     case 1:
//   88         *p++ = '0'+n/10;
??Int32String_sign_16:
        MOVS     R5,#+10
        SDIV     R2,R1,R5
        ADD      LR,R2,#+48
        STRB     LR,[R3], #+1
//   89         if ( --e == 0 ) break;
        SUBS     R12,R12,#+1
        BEQ.N    ??Int32String_sign_7
//   90         n %= 10;
        MLS      R1,R2,R5,R1
//   91     case 0:
//   92         *p++ = '0'+n;
??Int32String_sign_17:
        ADDS     R1,R1,#+48
        STRB     R1,[R3], #+1
        B.N      ??Int32String_sign_7
//   93     }
//   94     while ( p < r->str+fixlen )
//   95         *p++ = ' ';
??Int32String_sign_18:
        MOVS     R1,#+32
        STRB     R1,[R3], #+1
??Int32String_sign_7:
        ADDS     R1,R0,#+7
        CMP      R3,R1
        BCC.N    ??Int32String_sign_18
//   96     *p = 0;
        MOVS     R1,#+0
        STRB     R1,[R3, #+0]
//   97     r->len = p-r->str;
        ADDS     R1,R0,#+2
        SUBS     R1,R3,R1
??Int32String_sign_2:
        STRB     R1,[R0, #+1]
//   98 }
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        CFI EndBlock cfiBlock1
//   99 /*******************************************************************************
//  100  Int32String:无符号32位数转e位有效数字字符串  
//  101 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Int32String
        THUMB
//  102 void Int32String(I32STR_RES *r, u32 n, u32 e)
//  103 {
Int32String:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
//  104     u32 i, m, c, fixlen;
//  105      u8 *p = r->str;
        ADDS     R3,R0,#+2
//  106     fixlen=e+2;
        ADD      R12,R2,#+2
//  107     if ( n == 0 ) {
        CBNZ     R1,??Int32String_1
//  108         *p++ = '0';
        MOVS     R1,#+48
        STRB     R1,[R3, #+0]
//  109         *p++ = '.';
        MOVS     R1,#+46
        STRB     R1,[R3, #+1]!
//  110         *p++ = '0';
        MOVS     R1,#+48
        STRB     R1,[R3, #+1]!
//  111         *p++ = '0';
        STRB     R1,[R3, #+1]!
//  112         *p++ = '0';
        STRB     R1,[R3, #+1]!
//  113         *p = 0;
        MOVS     R1,#+0
        STRB     R1,[R3, #+1]!
//  114         r->decPos = 0;
        STRB     R1,[R0, #+0]
//  115         r->len = p-r->str;
        MOVS     R1,#+5
        B.N      ??Int32String_2
//  116         return;
//  117     }  
//  118     m = n;
??Int32String_1:
        MOV      LR,R1
//  119     i = 0;
        MOVS     R4,#+0
//  120     c = 5;
        MOVS     R5,#+5
        MOVS     R6,#+10
        B.N      ??Int32String_3
//  121     while ( m >= 10 ) {
//  122         m /= 10;
??Int32String_4:
        UDIV     LR,LR,R6
//  123         if ( ++i > e ) c *= 10;
        ADDS     R4,R4,#+1
        CMP      R2,R4
        IT       CC 
        MULCC    R5,R5,R6
//  124     }
??Int32String_3:
        CMP      LR,#+10
        BCS.N    ??Int32String_4
//  125     r->decPos = i/3;   
        MOV      LR,#+3
        UDIV     LR,R4,LR
        STRB     LR,[R0, #+0]
//  126     if ( i >= e ) n += c;
        CMP      R4,R2
        IT       CS 
        ADDCS    R1,R5,R1
//  127     switch ( i ) {
        CMP      R4,#+9
        BHI.W    ??Int32String_5
        TBB      [PC, R4]
        DATA
??Int32String_0:
        DC8      +128,+117,+105,+88
        DC8      +76,+64,+46,+34
        DC8      +22,+5
        THUMB
//  128     case 9:
//  129         *p++ = '0'+n/1000000000;
??Int32String_6:
        LDR.W    LR,??DataTable5  ;; 0x3b9aca00
        UDIV     R4,R1,LR
        MOVS     R5,R4
        ADDS     R5,R5,#+48
        STRB     R5,[R3], #+1
//  130         if ( --e == 0 ) break;
        SUBS     R2,R2,#+1
        BEQ.N    ??Int32String_5
//  131         n %= 1000000000;
        MLS      R1,R4,LR,R1
//  132         *p++ = '.', i = 0;
        MOV      LR,#+46
        STRB     LR,[R3], #+1
        MOVS     R4,#+0
//  133     case 8:
//  134         *p++ = '0'+n/100000000;
??Int32String_7:
        LDR.W    LR,??DataTable6  ;; 0x5f5e100
        UDIV     R5,R1,LR
        MOVS     R6,R5
        ADDS     R6,R6,#+48
        STRB     R6,[R3], #+1
//  135         if ( --e == 0 ) break;
        SUBS     R2,R2,#+1
        BEQ.N    ??Int32String_5
//  136         n %= 100000000;
        MLS      R1,R5,LR,R1
//  137     case 7:
//  138         *p++ = '0'+n/10000000;
??Int32String_8:
        LDR.W    LR,??DataTable7  ;; 0x989680
        UDIV     R5,R1,LR
        MOVS     R6,R5
        ADDS     R6,R6,#+48
        STRB     R6,[R3], #+1
//  139         if ( --e == 0 ) break;
        SUBS     R2,R2,#+1
        BEQ.N    ??Int32String_5
//  140         n %= 10000000;
        MLS      R1,R5,LR,R1
//  141     case 6:
//  142         *p++ = '0'+n/1000000;
??Int32String_9:
        LDR.W    LR,??DataTable8  ;; 0xf4240
        UDIV     R5,R1,LR
        MOVS     R6,R5
        ADDS     R6,R6,#+48
        STRB     R6,[R3], #+1
//  143         if ( --e == 0 ) break;
        SUBS     R2,R2,#+1
        BEQ.N    ??Int32String_5
//  144         n %= 1000000;
        MLS      R1,R5,LR,R1
//  145         if ( i ) *p++ = '.', i = 0;
        CBZ      R4,??Int32String_10
        MOV      LR,#+46
        STRB     LR,[R3], #+1
        MOVS     R4,#+0
//  146     case 5:
//  147         *p++ = '0'+n/100000;
??Int32String_10:
        LDR.W    LR,??DataTable9  ;; 0x186a0
        UDIV     R5,R1,LR
        MOVS     R6,R5
        ADDS     R6,R6,#+48
        STRB     R6,[R3], #+1
//  148         if ( --e == 0 ) break;
        SUBS     R2,R2,#+1
        BEQ.N    ??Int32String_5
//  149         n %= 100000;
        MLS      R1,R5,LR,R1
//  150     case 4:
//  151         *p++ = '0'+n/10000;
??Int32String_11:
        MOVW     LR,#+10000
        UDIV     R5,R1,LR
        MOVS     R6,R5
        ADDS     R6,R6,#+48
        STRB     R6,[R3], #+1
//  152         if ( --e == 0 ) break;
        SUBS     R2,R2,#+1
        BEQ.N    ??Int32String_5
//  153         n %= 10000;
        MLS      R1,R5,LR,R1
//  154     case 3:
//  155         *p++ = '0'+n/1000;
??Int32String_12:
        MOV      LR,#+1000
        UDIV     R5,R1,LR
        MOVS     R6,R5
        ADDS     R6,R6,#+48
        STRB     R6,[R3], #+1
//  156         if ( --e == 0 ) break;
        SUBS     R2,R2,#+1
        BEQ.N    ??Int32String_5
//  157         n %= 1000;
        MLS      R1,R5,LR,R1
//  158         if ( i ) *p++ = '.', i = 0;
        CBZ      R4,??Int32String_13
        MOV      LR,#+46
        STRB     LR,[R3], #+1
//  159     case 2:
//  160         *p++ = '0'+n/100;
??Int32String_13:
        MOV      LR,#+100
        UDIV     R4,R1,LR
        MOVS     R5,R4
        ADDS     R5,R5,#+48
        STRB     R5,[R3], #+1
//  161         if ( --e == 0 ) break;
        SUBS     R2,R2,#+1
        BEQ.N    ??Int32String_5
//  162         n %= 100;
        MLS      R1,R4,LR,R1
//  163     case 1:
//  164         *p++ = '0'+n/10;
??Int32String_14:
        MOVS     R6,#+10
        UDIV     LR,R1,R6
        MOV      R4,LR
        ADDS     R4,R4,#+48
        STRB     R4,[R3], #+1
//  165         if ( --e == 0 ) break;
        SUBS     R2,R2,#+1
        BEQ.N    ??Int32String_5
//  166         n %= 10;
        MLS      R1,LR,R6,R1
//  167     case 0:
//  168         *p++ = '0'+n;
??Int32String_15:
        ADDS     R1,R1,#+48
        STRB     R1,[R3], #+1
        B.N      ??Int32String_5
//  169     }
//  170     while ( p < r->str+fixlen )
//  171         *p++ = ' ';
??Int32String_16:
        MOVS     R1,#+32
        STRB     R1,[R3], #+1
??Int32String_5:
        ADD      R1,R12,R0
        ADDS     R1,R1,#+2
        CMP      R3,R1
        BCC.N    ??Int32String_16
//  172     *p = 0;
        MOVS     R1,#+0
        STRB     R1,[R3, #+0]
//  173     r->len = p-r->str;
        ADDS     R1,R0,#+2
        SUBS     R1,R3,R1
??Int32String_2:
        STRB     R1,[R0, #+1]
//  174 }
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock2

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable5:
        DC32     0x3b9aca00

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable6:
        DC32     0x5f5e100

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7:
        DC32     0x989680

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     0xf4240

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable9:
        DC32     0x186a0
//  175 
//  176 /*******************************************************************************
//  177  Two ASCII character Change to 1 Byte HEX data 
//  178 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Str2Byte
        THUMB
//  179 u8 Str2Byte(u8 x,u8 y) // 双ASCII字符转1字节二进制数
//  180 {
Str2Byte:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+20
        CFI CFA R13+32
        MOVS     R5,R0
        MOVS     R4,R1
//  181   uc8 Hexcode[17]="0123456789ABCDEF";
        ADD      R0,SP,#+0
        LDR.N    R1,??Str2Byte_0  ;; `?<Constant "0123456789ABCDEF">`
        MOVS     R2,#+17
        BL       __aeabi_memcpy
//  182   u8 i, Temp=0;
        MOVS     R0,#+0
//  183   
//  184   if(x>='a' && x<='z')  x-=32;     // 小写改大写
        CMP      R5,#+97
        BCC.N    ??Str2Byte_1
        CMP      R5,#+123
        IT       CC 
        SUBCC    R5,R5,#+32
//  185   if(y>='a' && y<='z')  y-=32;     // 小写改大写
??Str2Byte_1:
        CMP      R4,#+97
        BCC.N    ??Str2Byte_2
        CMP      R4,#+123
        IT       CC 
        SUBCC    R4,R4,#+32
//  186   for(i=0;i<16;i++){
??Str2Byte_2:
        ADD      R1,SP,#+0
        MOVS     R2,#+0
        MOVS     R3,#+16
//  187     if(Hexcode[i]==x)  Temp+=i*16; // 将字符转为高4位十六进制数值
??Str2Byte_3:
        LDRB     R12,[R1, #+0]
        UXTB     R5,R5
        CMP      R12,R5
        BNE.N    ??Str2Byte_4
        ADDS     R0,R2,R0
        UXTB     R0,R0
//  188   }
??Str2Byte_4:
        ADDS     R2,R2,#+16
        ADDS     R1,R1,#+1
        SUBS     R3,R3,#+1
        BNE.N    ??Str2Byte_3
//  189   for(i=0;i<16;i++){
        MOVS     R1,#+0
        ADD      R2,SP,#+0
//  190     if(Hexcode[i]==y)  Temp+=i;    // 将字符转为低4位十六进制数值
??Str2Byte_5:
        LDRB     R3,[R2, #+0]
        UXTB     R4,R4
        CMP      R3,R4
        BNE.N    ??Str2Byte_6
        ADDS     R0,R1,R0
        UXTB     R0,R0
//  191   }
??Str2Byte_6:
        ADDS     R1,R1,#+1
        ADDS     R2,R2,#+1
        UXTB     R3,R1
        CMP      R3,#+16
        BCC.N    ??Str2Byte_5
//  192   return Temp;
        ADD      SP,SP,#+20
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        Nop      
        DATA
??Str2Byte_0:
        DC32     `?<Constant "0123456789ABCDEF">`
        CFI EndBlock cfiBlock3
//  193 }
//  194 
//  195 /*******************************************************************************
//  196  u16ToDec5: Change 2 Byte to 5 decimal number string   
//  197 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function u16ToDec5
        THUMB
//  198 void u16ToDec5(u8 *p, u16 n)
//  199 {
//  200     *p++ = '0'+n/10000;
u16ToDec5:
        MOVW     R2,#+10000
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+0]
//  201     n %= 10000;
        MLS      R1,R3,R2,R1
//  202     *p++ = '0'+n/1000;
        UXTH     R1,R1
        MOV      R2,#+1000
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+1]!
//  203     n %= 1000;
        MLS      R1,R3,R2,R1
//  204     *p++ = '0'+n/100;
        UXTH     R1,R1
        MOVS     R2,#+100
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+1]!
//  205     n %= 100;
        MLS      R1,R3,R2,R1
//  206     *p++ = '0'+n/10;
        UXTH     R1,R1
        MOVS     R2,#+10
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+1]!
//  207     n %= 10;
        MLS      R1,R3,R2,R1
//  208     *p++ = '0'+n;
        ADDS     R1,R1,#+48
        STRB     R1,[R0, #+1]!
//  209     *p = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]!
//  210 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  211 /*******************************************************************************
//  212  u8ToDec3: Change Byte to 3 decimal number string   
//  213 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function u8ToDec3
        THUMB
//  214 void u8ToDec3(u8 *p, u8 n)
//  215 {
//  216     *p++ = '0'+n/100;
u8ToDec3:
        MOVS     R2,#+100
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+0]
//  217     n %= 100;
        MLS      R1,R3,R2,R1
//  218     *p++ = '0'+n/10;
        UXTB     R1,R1
        MOVS     R2,#+10
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+1]!
//  219     n %= 10;
        MLS      R1,R3,R2,R1
//  220     *p++ = '0'+n;
        ADDS     R1,R1,#+48
        STRB     R1,[R0, #+1]!
//  221     *p = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]!
//  222 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  223 /*******************************************************************************
//  224  u8ToDec2: Change Byte to 2 decimal number string   
//  225 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function u8ToDec2
        THUMB
//  226 void u8ToDec2(u8 *p, u8 n)
//  227 {
//  228 //    *p++ = '0'+n/100;
//  229     n %= 100;
u8ToDec2:
        MOVS     R2,#+100
        SDIV     R3,R1,R2
        MLS      R1,R3,R2,R1
//  230     *p++ = '0'+n/10;
        UXTB     R1,R1
        MOVS     R2,#+10
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+0]
//  231     n %= 10;
        MLS      R1,R3,R2,R1
//  232     *p++ = '0'+n;
        ADDS     R1,R1,#+48
        STRB     R1,[R0, #+1]!
//  233     *p = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]!
//  234 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  235 /*******************************************************************************
//  236  Char2Hex: Change Byte to 2 hex number string  
//  237 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function Char2Hex
        THUMB
//  238 void Char2Hex(u8 *p, u8 n)
//  239 {
//  240     if(n/16>9) *p++ = 'A'+(n/16-10);
Char2Hex:
        LSRS     R2,R1,#+4
        CMP      R2,#+10
        ITTEE    CC 
        ADDCC    R3,R2,#+48
        STRBCC   R3,[R0], #+1
        ADDCS    R3,R2,#+55
        STRBCS   R3,[R0], #+1
//  241     else       *p++ = '0'+n/16;
//  242     n %= 16;
        SUB      R1,R1,R2, LSL #+4
//  243     if(n>9)    *p++ = 'A'+(n-10);
        UXTB     R1,R1
        CMP      R1,#+10
        BCC.N    ??Char2Hex_0
        ADDS     R1,R1,#+55
        STRB     R1,[R0], #+1
        B.N      ??Char2Hex_1
//  244     else       *p++ = '0'+n;
??Char2Hex_0:
        ADDS     R1,R1,#+48
        STRB     R1,[R0], #+1
//  245     *p = 0;
??Char2Hex_1:
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  246 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  247 /*******************************************************************************
//  248  Word2Hex: Change 4 Bytes to 8 hex number string  
//  249 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function Word2Hex
        THUMB
//  250 void Word2Hex(u8 *p, u32 n)
//  251 {
//  252     if(n/0x10000000>9) *p++ = 'A'+(n/0x10000000-10);
Word2Hex:
        LSRS     R2,R1,#+28
        CMP      R2,#+10
        BCC.N    ??Word2Hex_0
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_1
//  253     else               *p++ = '0'+ n/0x10000000;
??Word2Hex_0:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  254     n %= 0x10000000;
??Word2Hex_1:
        LSLS     R1,R1,#+4
        LSRS     R1,R1,#+4
//  255     if(n/0x01000000>9) *p++ = 'A'+(n/0x01000000-10);
        LSRS     R2,R1,#+24
        CMP      R2,#+10
        BCC.N    ??Word2Hex_2
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_3
//  256     else               *p++ = '0'+ n/0x01000000;
??Word2Hex_2:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  257     n %= 0x01000000;
??Word2Hex_3:
        LSLS     R1,R1,#+8
        LSRS     R1,R1,#+8
//  258     if(n/0x00100000>9) *p++ = 'A'+(n/0x00100000-10);
        LSRS     R2,R1,#+20
        CMP      R2,#+10
        BCC.N    ??Word2Hex_4
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_5
//  259     else               *p++ = '0'+ n/0x00100000;
??Word2Hex_4:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  260     n %= 0x00100000;
??Word2Hex_5:
        LSLS     R1,R1,#+12
        LSRS     R1,R1,#+12
//  261     if(n/0x00010000>9) *p++ = 'A'+(n/0x00010000-10);
        LSRS     R2,R1,#+16
        CMP      R2,#+10
        BCC.N    ??Word2Hex_6
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_7
//  262     else               *p++ = '0'+ n/0x00010000;
??Word2Hex_6:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  263     n %= 0x00010000;
??Word2Hex_7:
        UXTH     R1,R1
//  264     if(n/0x00001000>9) *p++ = 'A'+(n/0x00001000-10);
        LSRS     R2,R1,#+12
        CMP      R2,#+10
        BCC.N    ??Word2Hex_8
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_9
//  265     else               *p++ = '0'+ n/0x00001000;
??Word2Hex_8:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  266     n %= 0x00001000;
??Word2Hex_9:
        LSLS     R1,R1,#+20
        LSRS     R1,R1,#+20
//  267     if(n/0x00000100>9) *p++ = 'A'+(n/0x00000100-10);
        LSRS     R2,R1,#+8
        CMP      R2,#+10
        BCC.N    ??Word2Hex_10
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_11
//  268     else               *p++ = '0'+ n/0x00000100;
??Word2Hex_10:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  269     n %= 0x00000100;
??Word2Hex_11:
        UXTB     R1,R1
//  270     if(n/0x00000010>9) *p++ = 'A'+(n/0x00000010-10);
        LSRS     R2,R1,#+4
        CMP      R2,#+10
        BCC.N    ??Word2Hex_12
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_13
//  271     else               *p++ = '0'+ n/0x00000010;
??Word2Hex_12:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  272     n %= 0x00000010;
??Word2Hex_13:
        AND      R1,R1,#0xF
//  273     if(n/0x00000001>9) *p++ = 'A'+(n/0x00000001-10);
        CMP      R1,#+10
        BCC.N    ??Word2Hex_14
        ADDS     R1,R1,#+55
        STRB     R1,[R0], #+1
        B.N      ??Word2Hex_15
//  274     else               *p++ = '0'+ n/0x00000001;
??Word2Hex_14:
        ADDS     R1,R1,#+48
        STRB     R1,[R0], #+1
//  275     n %= 0x10000000;
//  276     *p = 0;
??Word2Hex_15:
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  277 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  278 /*******************************************************************************
//  279  Int_sqrt: unsigned int square root
//  280 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function Int_sqrt
        THUMB
//  281 u32 Int_sqrt(u32 n)
//  282 { u32 k;
Int_sqrt:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        MOVS     R4,R0
//  283   if ( n == 0 ) return 0;
        BNE.N    ??Int_sqrt_0
        MOVS     R0,#+0
        POP      {R4,PC}
//  284   k = 2*Int_sqrt(n/4)+1;
??Int_sqrt_0:
        LSRS     R0,R4,#+2
        BL       Int_sqrt
        LSLS     R0,R0,#+1
        ADDS     R0,R0,#+1
//  285   if ( k*k > n ) return k-1;
        MUL      R1,R0,R0
        CMP      R4,R1
        IT       CC 
        SUBCC    R0,R0,#+1
//  286   else return k;
??Int_sqrt_1:
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock9
//  287 }
//  288 /*******************************************************************************
//  289 Read_Keys:    Key status process                                Return: KeyCode
//  290 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function Read_Keys
        THUMB
//  291 u8 Read_Keys(void)
//  292 {
Read_Keys:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  293   u16 Key_Status, Key_Status_Now;
//  294   u8  KeyCode=0;
        MOVS     R4,#+0
//  295   
//  296   Key_Status_Now = ~__Get(KEY_STATUS);//~KeyScan();
        MOVS     R0,#+4
        BL       __Get
        MVNS     R0,R0
        UXTH     R0,R0
//  297   Key_Status = Key_Status_Now &(~Key_Status_Last);
        LDR.N    R1,??Read_Keys_0  ;; Key_Status_Last
        MOVS     R2,R0
        LDRH     R3,[R1, #+0]
        MVNS     R3,R3
        ANDS     R2,R3,R2
//  298   if(Key_Status){                               // New key push on
        BEQ.N    ??Read_Keys_1
//  299     Key_Wait_Cnt=25;                        // Close auto repeat 500mS
        LDR.N    R3,??Read_Keys_0+0x4  ;; Key_Wait_Cnt
        MOV      R12,#+25
        STRB     R12,[R3, #+0]
//  300     if(Key_Status & K_ITEM_D_STATUS)   KeyCode = K_ITEM_DEC;    // K9
        TST      R2,#0x8
        IT       NE 
        MOVNE    R4,#+9
//  301     if(Key_Status & K_ITEM_S_STATUS)   KeyCode = K_ITEM_S;      // K10
        TST      R2,#0x40
        IT       NE 
        MOVNE    R4,#+10
//  302     if(Key_Status & KEY3_STATUS)       KeyCode = KEY3;          // K3 
        TST      R2,#0x100
        IT       NE 
        MOVNE    R4,#+3
//  303     if(Key_Status & KEY4_STATUS)       KeyCode = KEY4;          // K4 
        TST      R2,#0x200
        IT       NE 
        MOVNE    R4,#+4
//  304     if(Key_Status & K_INDEX_D_STATUS)  KeyCode = K_INDEX_DEC;   // K5 
        TST      R2,#0x400
        IT       NE 
        MOVNE    R4,#+5
//  305     if(Key_Status & K_INDEX_I_STATUS)  KeyCode = K_INDEX_INC;   // K6  
        TST      R2,#0x800
        IT       NE 
        MOVNE    R4,#+6
//  306     if(Key_Status & K_INDEX_S_STATUS)  KeyCode = K_INDEX_S;     // K7  
        TST      R2,#0x1000
        IT       NE 
        MOVNE    R4,#+7
//  307     if(Key_Status & KEY2_STATUS)       KeyCode = KEY2;          // K2
        TST      R2,#0x2000
        IT       NE 
        MOVNE    R4,#+2
//  308     if(Key_Status & KEY1_STATUS)       KeyCode = KEY_P;         // K1
        TST      R2,#0x4000
        IT       NE 
        MOVNE    R4,#+1
//  309     if(Key_Status & K_ITEM_I_STATUS)   KeyCode = K_ITEM_INC;    // K8
        TST      R2,#0x8000
        BEQ.N    ??Read_Keys_2
        MOVS     R4,#+8
        B.N      ??Read_Keys_2
//  310   } else {
//  311     if(Key_Status_Now & Key_Status_Last){       // Key push hold on
??Read_Keys_1:
        LDRH     R2,[R1, #+0]
        TST      R0,R2
        BEQ.N    ??Read_Keys_2
//  312       if((Key_Wait_Cnt || Key_Repeat_Cnt)==0){
        LDR.N    R2,??Read_Keys_0+0x4  ;; Key_Wait_Cnt
        LDRB     R2,[R2, #+0]
        CBNZ     R2,??Read_Keys_2
        LDR.N    R2,??Read_Keys_0+0x8  ;; Key_Repeat_Cnt
        LDRB     R3,[R2, #+0]
        CBNZ     R3,??Read_Keys_2
//  313         if(Key_Status_Now & K_INDEX_D_STATUS)  KeyCode = K_INDEX_DEC;    // K5 
        TST      R0,#0x400
        IT       NE 
        MOVNE    R4,#+5
//  314         if(Key_Status_Now & K_INDEX_I_STATUS)  KeyCode = K_INDEX_INC;    // K6
        TST      R0,#0x800
        IT       NE 
        MOVNE    R4,#+6
//  315         if(Key_Status_Now & K_ITEM_D_STATUS)   KeyCode = K_ITEM_DEC;     // K9 
        TST      R0,#0x8
        IT       NE 
        MOVNE    R4,#+9
//  316         if(Key_Status_Now & K_ITEM_I_STATUS)   KeyCode = K_ITEM_INC;     // K8 
        TST      R0,#0x8000
        IT       NE 
        MOVNE    R4,#+8
//  317         Key_Repeat_Cnt = 5;                 // Auto repeat per 100mS
        MOVS     R3,#+5
        STRB     R3,[R2, #+0]
//  318       }
//  319     }
//  320   }
//  321   Key_Status_Last = Key_Status_Now;
??Read_Keys_2:
        STRH     R0,[R1, #+0]
//  322   return KeyCode;
        MOVS     R0,R4
        POP      {R4,PC}          ;; return
        Nop      
        DATA
??Read_Keys_0:
        DC32     Key_Status_Last
        DC32     Key_Wait_Cnt
        DC32     Key_Repeat_Cnt
        CFI EndBlock cfiBlock10
//  323 }    

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "0123456789ABCDEF">`:
        DATA
        DC8 "0123456789ABCDEF"
        DC8 0, 0, 0

        END
//  324 /********************************* END OF FILE ********************************/
// 
//    20 bytes in section .rodata
// 1 612 bytes in section .text
// 
// 1 612 bytes of CODE  memory
//    20 bytes of CONST memory
//
//Errors: none
//Warnings: none
