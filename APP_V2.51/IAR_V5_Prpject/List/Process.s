///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  11:08:32 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\APP_V2.51\source\Process.c             /
//    Command line =  E:\Mini-DS\DS203\APP_V2.51\source\Process.c -lA         /
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
//    List file    =  E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\List\Process. /
//                    s                                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Process

        EXTERN Current
        EXTERN Delayms
        EXTERN Draw_Window
        EXTERN FileBuff
        EXTERN Get_Ref_Wave
        EXTERN Meter
        EXTERN PD_Cnt
        EXTERN Title
        EXTERN Update
        EXTERN V_Trigg
        EXTERN Wait_Cnt
        EXTERN __Clear_Screen
        EXTERN __Get
        EXTERN __Read_FIFO
        EXTERN __Set
        EXTERN __aeabi_memclr4

        PUBLIC A_Posi
        PUBLIC A_Tab
        PUBLIC App_init
        PUBLIC B_Posi
        PUBLIC D_Tab
        PUBLIC DataBuf
        PUBLIC Full
        PUBLIC G_Attr
        PUBLIC Interlace
        PUBLIC JumpCnt
        PUBLIC Ka1
        PUBLIC Ka2
        PUBLIC Ka3
        PUBLIC Kab
        PUBLIC Kb1
        PUBLIC Kb2
        PUBLIC Kb3
        PUBLIC PaS
        PUBLIC PbS
        PUBLIC PcS
        PUBLIC PdS
        PUBLIC Posi_41
        PUBLIC Posi_412
        PUBLIC Posi_42
        PUBLIC Posi_4F1
        PUBLIC Posi_4F2
        PUBLIC Posi_4F3
        PUBLIC Posi_4F4
        PUBLIC Posi_4_2
        PUBLIC Process
        PUBLIC SAW_DATA
        PUBLIC SIN_DATA
        PUBLIC Send_Data
        PUBLIC Synchro
        PUBLIC TRG_DATA
        PUBLIC T_Attr
        PUBLIC TaN
        PUBLIC TaS
        PUBLIC TbN
        PUBLIC TbS
        PUBLIC TcN
        PUBLIC TcS
        PUBLIC TdN
        PUBLIC TdS
        PUBLIC TrackBuff
        PUBLIC Update_Base
        PUBLIC Update_Output
        PUBLIC Update_Range
        PUBLIC Update_Trig
        PUBLIC View_init
        PUBLIC Wait
        PUBLIC X_Attr
        PUBLIC Y_Attr
        PUBLIC a_Avg
        PUBLIC a_Max
        PUBLIC a_Mid_H
        PUBLIC a_Mid_L
        PUBLIC a_Min
        PUBLIC a_Ssq
        PUBLIC b_Avg
        PUBLIC b_Max
        PUBLIC b_Mid_H
        PUBLIC b_Mid_L
        PUBLIC b_Min
        PUBLIC b_Ssq
        PUBLIC c_Max
        PUBLIC d_Max
        
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
        
// E:\Mini-DS\DS203\APP_V2.51\source\Process.c
//    1 /******************** (C) COPYRIGHT 2009 e-Design Co.,Ltd. *********************
//    2  File Name : Process.c       
//    3  Version   : DS203_APP Ver 2.3x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include "Interrupt.h"
//    6 #include "Function.h"
//    7 #include "Process.h"
//    8 #include "Draw.h"
//    9 #include "Menu.h"
//   10 #include "BIOS.h"
//   11 #include "File.h"
//   12 
//   13 u16 TaS, TbS, TcS, TdS;            // 周期累计
//   14 u16 PaS, PbS, PcS, PdS;            // 脉宽累计
//   15 u16 TaN, TbN, TcN, TdN;            // 周期计数
//   16 u8  a_Mid_H, a_Mid_L;
//   17 u8  b_Mid_H, b_Mid_L;
//   18 
//   19 s8  Kab;                                     // 模拟通道零点平衡校正系数
//   20 u32 a_Avg, b_Avg, a_Ssq, b_Ssq;              // 平均值累计,平方和累计
//   21 u8  a_Max, b_Max, a_Min, b_Min;              // 原始最大值,原始最小值
//   22 s16 Posi_412, Posi_41, Posi_42, Posi_4_2, Posi_4F1, Posi_4F2, Posi_4F3, Posi_4F4;
//   23 s16 c_Max, d_Max, A_Posi, B_Posi;
//   24 u8  Full=1, Interlace;
//   25 u16 JumpCnt;
//   26 

        SECTION `.rodata`:CONST:NOROOT(2)
//   27 uc16 Wait[27]= {1000, 500, 200, 100, 50, 20, 10, 5, 2, 2,   
Wait:
        DATA
        DC16 1000, 500, 200, 100, 50, 20, 10, 5, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
        DC16 2, 2, 2, 2, 2, 2, 2, 2, 2
        DC8 0, 0

        SECTION `.bss`:DATA:NOROOT(2)
a_Mid_H:
        DS8 1
a_Mid_L:
        DS8 1
b_Mid_H:
        DS8 1
b_Mid_L:
        DS8 1
a_Max:
        DS8 1
b_Max:
        DS8 1
a_Min:
        DS8 1
b_Min:
        DS8 1
TaS:
        DS8 2
TbS:
        DS8 2
TcS:
        DS8 2
TdS:
        DS8 2
PaS:
        DS8 2
PbS:
        DS8 2
PcS:
        DS8 2
PdS:
        DS8 2
TaN:
        DS8 2
TbN:
        DS8 2
TcN:
        DS8 2
TdN:
        DS8 2
A_Posi:
        DS8 2
B_Posi:
        DS8 2
a_Avg:
        DS8 4
b_Avg:
        DS8 4
a_Ssq:
        DS8 4
b_Ssq:
        DS8 4
//   28                 2,      2,   2,   2,  2,  2,  2, 2, 2, 2,    
//   29                 2,      2,   2,   2,  2,  2,  2 };
//   30                      
//   31 Y_attr *Y_Attr; 
//   32 X_attr *X_Attr; 
//   33 G_attr *G_Attr; 
//   34 T_attr *T_Attr; 
//   35 
//   36 u32 DataBuf[4096];
DataBuf:
        DS8 16384

        SECTION `.bss`:DATA:NOROOT(0)
Kab:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
Y_Attr:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
G_Attr:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
T_Attr:
        DS8 4

        SECTION `.data`:DATA:NOROOT(2)
//   37 u8  TrackBuff  [X_SIZE * 4];         // 曲线轨迹缓存：i+0,i+1,i+2,i+3,分别存放1～4号轨迹数据
TrackBuff:
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Interlace:
        DC8 0
        DC8 0
Posi_412:
        DC8 0, 0
Posi_41:
        DC8 0, 0
Posi_42:
        DC8 0, 0
Posi_4_2:
        DC8 0, 0
Posi_4F1:
        DC8 0, 0
Posi_4F2:
        DC8 0, 0
Posi_4F3:
        DC8 0, 0
Posi_4F4:
        DC8 0, 0
c_Max:
        DC8 0, 0
d_Max:
        DC8 0, 0
JumpCnt:
        DC8 0, 0
X_Attr:
        DC8 0, 0, 0, 0
//   38 
//   39 s8  Ka1[10] ={   0,    0,    0,    0,    0,    0,    0,    0,    0,    0}; // A通道低位误差校正系数
Ka1:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
//   40 s8  Kb1[10] ={   0,    0,    0,    0,    0,    0,    0,    0,    0,    0}; // B通道低位误差校正系数
Kb1:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
//   41 u16 Ka2[10] ={1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024}; // A通道增益误差校正系数
Ka2:
        DC16 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024
//   42 u16 Kb2[10] ={1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024}; // B通道增益误差校正系数
Kb2:
        DC16 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024
//   43 s8  Ka3[10] ={   0,    0,    0,    0,    0,    0,    0,    0,    0,    0}; // A通道高位误差校正系数
Ka3:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
//   44 s8  Kb3[10] ={   0,    0,    0,    0,    0,    0,    0,    0,    0,    0}; // B通道高位误差校正系数
Kb3:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.data`:DATA:NOROOT(0)
Full:
        DATA
        DC8 1
//   45 

        SECTION `.data`:DATA:NOROOT(2)
//   46 D_tab D_Tab[20] ={  // 脉冲波形输出驱动表, 基于72MHz主频
D_Tab:
        DATA
        DC8 " 10Hz "
        DC8 0
        DC16 179, 39999, 50
        DC8 " 20Hz "
        DC8 0
        DC16 179, 19999, 50
        DC8 " 50Hz "
        DC8 0
        DC16 179, 7999, 50
        DC8 "!100Hz!"
        DC16 179, 3999, 50
        DC8 "!200Hz!"
        DC16 179, 1999, 50
        DC8 "!500Hz!"
        DC16 179, 799, 50
        DC8 " 1KHz "
        DC8 0
        DC16 179, 399, 50
        DC8 " 2KHz "
        DC8 0
        DC16 179, 199, 50
        DC8 " 5KHz "
        DC8 0
        DC16 17, 799, 50
        DC8 "!10KHz!"
        DC16 17, 399, 50
        DC8 "!20KHz!"
        DC16 17, 199, 50
        DC8 "!50KHz!"
        DC16 0, 1439, 50
        DC8 "100KHz"
        DC8 0
        DC16 0, 719, 50
        DC8 "200KHz"
        DC8 0
        DC16 0, 359, 50
        DC8 "500KHz"
        DC8 0
        DC16 0, 143, 50
        DC8 " 1MHz "
        DC8 0
        DC16 0, 71, 50
        DC8 " 2MHz "
        DC8 0
        DC16 0, 35, 50
        DC8 " 4MHz "
        DC8 0
        DC16 0, 17, 50
        DC8 " 6MHz "
        DC8 0
        DC16 0, 11, 50
        DC8 " 8MHz "
        DC8 0
        DC16 0, 8, 50
//   47 //    STR      PSC     ARR       DUTY% 
//   48   {" 10Hz ",  180-1,  40000-1,     50},
//   49   {" 20Hz ",  180-1,  20000-1,     50},
//   50   {" 50Hz ",  180-1,   8000-1,     50},
//   51   {"!100Hz!", 180-1,   4000-1,     50},
//   52   {"!200Hz!", 180-1,   2000-1,     50},
//   53   {"!500Hz!", 180-1,    800-1,     50},
//   54   {" 1KHz ",  180-1,    400-1,     50},
//   55   {" 2KHz ",  180-1,    200-1,     50},
//   56   {" 5KHz ",   18-1,    800-1,     50},
//   57   {"!10KHz!",  18-1,    400-1,     50},
//   58   {"!20KHz!",  18-1,    200-1,     50},
//   59   {"!50KHz!",   1-1,   1440-1,     50},
//   60   {"100KHz",    1-1,    720-1,     50},
//   61   {"200KHz",    1-1,    360-1,     50},
//   62   {"500KHz",    1-1,    144-1,     50},
//   63   {" 1MHz ",    1-1,     72-1,     50},
//   64   {" 2MHz ",    1-1,     36-1,     50},
//   65   {" 4MHz ",    1-1,     18-1,     50},
//   66   {" 6MHz ",    1-1,     12-1,     50},
//   67   {" 8MHz ",    1-1,      9-1,     50}};
//   68 
//   69 A_tab A_Tab[11] ={ // 模拟波形输出驱动表, 基于72MHz主频, 每周期36点合成
A_Tab:
        DC8 " 10Hz "
        DC8 0
        DC16 19, 9999
        DC8 " 20Hz "
        DC8 0
        DC16 19, 4999
        DC8 " 50Hz "
        DC8 0
        DC16 19, 1999
        DC8 "!100Hz!"
        DC16 19, 999
        DC8 "!200Hz!"
        DC16 19, 499
        DC8 "!500Hz!"
        DC16 19, 199
        DC8 " 1KHz "
        DC8 0
        DC16 19, 99
        DC8 " 2KHz "
        DC8 0
        DC16 19, 49
        DC8 " 5KHz "
        DC8 0
        DC16 19, 19
        DC8 "!10KHz!"
        DC16 19, 9
        DC8 "!20KHz!"
        DC16 19, 4
//   70 //    STR     PSC     ARR 
//   71   {" 10Hz ",  20-1,  10000-1},
//   72   {" 20Hz ",  20-1,   5000-1},
//   73   {" 50Hz ",  20-1,   2000-1},
//   74   {"!100Hz!", 20-1,   1000-1},
//   75   {"!200Hz!", 20-1,    500-1},
//   76   {"!500Hz!", 20-1,    200-1},
//   77   {" 1KHz ",  20-1,    100-1},
//   78   {" 2KHz ",  20-1,     50-1},
//   79   {" 5KHz ",  20-1,     20-1},
//   80   {"!10KHz!", 20-1,     10-1},
//   81   {"!20KHz!", 20-1,      5-1}};
//   82 
//   83 u16 SIN_DATA[36] =  // Sine wave data                                                                                                 //         
SIN_DATA:
        DC16 0, 39, 142, 304, 521, 785, 1089, 1423, 1776, 2138, 2496, 2841
        DC16 3161, 3446, 3688, 3878, 4011, 4083, 4095, 4055, 3952, 3790, 3573
        DC16 3309, 3005, 2671, 2318, 1956, 1598, 1253, 933, 648, 406, 216, 83
        DC16 11
//   84   {0x000,0x027,0x08E,0x130,0x209,0x311,0x441,0x58F,0x6F0,    // 90
//   85    0x85A,0x9C0,0xB19,0xC59,0xD76,0xE68,0xF26,0xFAB,0xFF3,    // 180
//   86    0xFFF,0xFD7,0xF70,0xECE,0xDF5,0xCED,0xBBD,0xA6F,0x90E,    // 270
//   87    0x7A4,0x63E,0x4E5,0x3A5,0x288,0x196,0x0D8,0x053,0x00B,};  // 360   
//   88 
//   89 u16 TRG_DATA[36] =  // triangle wave data
TRG_DATA:
        DC16 0, 227, 454, 682, 909, 1137, 1364, 1592, 1819, 2047, 2274, 2502
        DC16 2729, 2957, 3184, 3412, 3639, 3867, 4094, 3867, 3639, 3412, 3184
        DC16 2957, 2729, 2502, 2274, 2047, 1819, 1592, 1364, 1137, 909, 682
        DC16 454, 227
//   90   {0x000,0x0E3,0x1C6,0x2AA,0x38D,0x471,0x554,0x638,0x71B,    // 90
//   91    0x7FF,0x8E2,0x9C6,0xAA9,0xB8D,0xC70,0xD54,0xE37,0xF1B,    // 180
//   92    0xFFE,0xF1B,0xE37,0xD54,0xC70,0xB8D,0xAA9,0x9C6,0x8E2,    // 270
//   93    0x7FF,0x71B,0x638,0x554,0x471,0x38D,0x2AA,0x1C6,0x0E3};   // 360   
//   94          
//   95 u16 SAW_DATA[36] =  // Sawtooth wave data                                                                                             //         
SAW_DATA:
        DC16 0, 117, 234, 351, 468, 585, 702, 819, 936, 1053, 1170, 1287, 1404
        DC16 1521, 1638, 1755, 1872, 1989, 2106, 2223, 2340, 2457, 2574, 2691
        DC16 2808, 2925, 3042, 3159, 3276, 3393, 3510, 3627, 3744, 3861, 3978
        DC16 4095
//   96   {0x000,0x075,0x0EA,0x15F,0x1D4,0x249,0x2BE,0x333,0x3A8,    // 90
//   97    0x41D,0x492,0x507,0x57C,0x5F1,0x666,0x6DB,0x750,0x7C5,    // 180
//   98    0x83A,0x8AF,0x924,0x999,0xA0E,0xA83,0xAF8,0xB6D,0xBE2,    // 270
//   99    0xC57,0xCCC,0xD41,0xDB6,0xE2B,0xEA0,0xF15,0xF8A,0xFFF};   // 360    
//  100 
//  101 
//  102 /*******************************************************************************
//  103  App_init: 显示窗口波形数据初始化
//  104 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function App_init
        THUMB
//  105 void App_init(void)
//  106 { 
App_init:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  107   u16 i, j;
//  108   __Set(ADC_CTRL, EN );       
        MOVS     R1,#+1
        MOVS     R0,#+36
        BL       __Set
//  109   __Set(STANDBY, DN);          // 退出省电状态
        MOVS     R1,#+0
        MOVS     R0,#+20
        BL       __Set
//  110   __Clear_Screen(BLACK);       // 清屏幕
        MOVS     R0,#+0
        BL       __Clear_Screen
//  111   Delayms(20); 
        MOVS     R0,#+20
        BL       Delayms
//  112   __Set(FIFO_CLR, W_PTR); 
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
//  113   for(i=0; i<13; i++) for(j=0; j<4; j++) Title[i][j].Flag |= UPDAT;
        LDR.W    R0,??DataTable16  ;; Title
        ADD      R1,R0,#+18
        MOVS     R2,#+13
??App_init_0:
        LDRB     R3,[R1, #+0]
        ORR      R3,R3,#0x2
        STRB     R3,[R1, #+0]
        LDRB     R3,[R1, #+20]
        ORR      R3,R3,#0x2
        STRB     R3,[R1, #+20]
        LDRB     R3,[R1, #+40]
        ORR      R3,R3,#0x2
        STRB     R3,[R1, #+40]
        LDRB     R3,[R1, #+60]
        ORR      R3,R3,#0x2
        STRB     R3,[R1, #+60]
        ADDS     R1,R1,#+80
        SUBS     R2,R2,#+1
        BNE.N    ??App_init_0
//  114   for(i=0; i<9; i++)                     Meter[i].Flag    |= UPDAT;
        LDR.N    R1,??App_init_1  ;; Meter + 11
        MOVS     R2,#+3
??App_init_2:
        LDRB     R3,[R1, #+0]
        ORR      R3,R3,#0x2
        STRB     R3,[R1, #+0]
        LDRB     R3,[R1, #+12]
        ORR      R3,R3,#0x2
        STRB     R3,[R1, #+12]
        LDRB     R3,[R1, #+24]
        ORR      R3,R3,#0x2
        STRB     R3,[R1, #+24]
        ADDS     R1,R1,#+36
        SUBS     R2,R2,#+1
        BNE.N    ??App_init_2
//  115   if(Current != FILE) {
        LDR.N    R1,??App_init_1+0x4  ;; Current
        LDRB     R1,[R1, #+0]
        CMP      R1,#+9
        BEQ.N    ??App_init_3
//  116     Title[FILE][0].Flag &= !UPDAT;
        MOVS     R1,#+0
        STRB     R1,[R0, #+738]
//  117     Title[FILE][1].Flag &= !UPDAT;
        STRB     R1,[R0, #+758]
//  118     Title[FILE][3].Flag &= !UPDAT;
        STRB     R1,[R0, #+798]
//  119   }  
//  120   PD_Cnt = 600;
??App_init_3:
        LDR.N    R0,??App_init_1+0x8  ;; PD_Cnt
        MOV      R1,#+600
        STRH     R1,[R0, #+0]
//  121   Update = 1;                  // 返回后恢复原来的档位设置
        LDR.N    R0,??App_init_1+0xC  ;; Update
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  122 }
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        Nop      
        DATA
??App_init_1:
        DC32     Meter + 11
        DC32     Current
        DC32     PD_Cnt
        DC32     Update
        CFI EndBlock cfiBlock0
//  123 /*******************************************************************************
//  124  View_init: 显示窗口波形数据初始化
//  125 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function View_init
        THUMB
//  126 void View_init(void)
//  127 { 
View_init:
        PUSH     {R4-R9,LR}
        CFI R14 Frame(CFA, -4)
        CFI R9 Frame(CFA, -8)
        CFI R8 Frame(CFA, -12)
        CFI R7 Frame(CFA, -16)
        CFI R6 Frame(CFA, -20)
        CFI R5 Frame(CFA, -24)
        CFI R4 Frame(CFA, -28)
        CFI CFA R13+28
        SUB      SP,SP,#+4
        CFI CFA R13+32
//  128   u16 i, j = 0, k = 0;
        MOVS     R4,#+0
        MOVS     R5,#+0
//  129   for(i = 0; i < X_SIZE * 4; i += 4){
        MOV      R9,R4
        LDR.W    R6,??DataTable15  ;; TrackBuff
        MOVS     R7,#+17
        MOV      R8,#+160
//  130     TrackBuff[i] = 160;
??View_init_0:
        MOVS     R0,#+160
        STRB     R0,[R6, #+0]
//  131     TrackBuff[i+1] = Get_Ref_Wave(i/4);
        LSL      R0,R9,#+16
        LSRS     R0,R0,#+18
        BL       Get_Ref_Wave
        STRB     R0,[R6, #+1]
//  132     if((i%160)==0) j = 1 - j;
        SDIV     R0,R9,R8
        MLS      R0,R0,R8,R9
        CBNZ     R0,??View_init_1
        RSB      R4,R4,#+1
        UXTH     R4,R4
//  133     TrackBuff[i+2] = 60 + (j * 17);
??View_init_1:
        MOVS     R0,#+60
        MLA      R0,R4,R7,R0
        STRB     R0,[R6, #+2]
//  134     if((i%64)==0) k = 1 - k;
        LSL      R0,R9,#+16
        LSRS     R0,R0,#+22
        SUBS     R0,R9,R0, LSL #+6
        ITT      EQ 
        RSBEQ    R5,R5,#+1
        UXTHEQ   R5,R5
//  135     TrackBuff[i+3] = 20 + (k * 17);
        MOVS     R0,#+20
        MLA      R0,R5,R7,R0
        STRB     R0,[R6, #+3]
//  136   }
        ADD      R9,R9,#+4
        ADDS     R6,R6,#+4
        MOV      R1,#+1200
        UXTH     R0,R9
        CMP      R0,R1
        BCC.N    ??View_init_0
//  137 }
        ADD      SP,SP,#+4
        CFI CFA R13+28
        POP      {R4-R9,PC}       ;; return
        CFI EndBlock cfiBlock1
//  138 /*******************************************************************************
//  139  Update_Range: 
//  140 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Update_Range
        THUMB
//  141 void Update_Range(void) 
//  142 {
Update_Range:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//  143   Interlace = 0;
        LDR.W    R4,??DataTable15  ;; TrackBuff
        ADD      R0,R4,#+1200
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  144   __Set(ADC_CTRL, EN);       
        MOVS     R1,#+1
        MOVS     R0,#+36
        BL       __Set
//  145   __Set(ADC_MODE, SEPARATE);                        // Set Separate mode ((Range + 1)*25)
        MOVS     R1,#+0
        MOVS     R0,#+5
        BL       __Set
//  146   __Set(CH_A_COUPLE, Title[TRACK1][COUPLE].Value);
        LDR.W    R5,??DataTable16  ;; Title
        LDRSH    R1,[R5, #+36]
        MOVS     R0,#+9
        BL       __Set
//  147   __Set(CH_A_RANGE,  Title[TRACK1][RANGE].Value);
        LDRSH    R1,[R5, #+56]
        MOVS     R0,#+10
        BL       __Set
//  148   __Set(CH_A_OFFSET, ((1024 + Ka3[_A_Range])*_1_posi + 512)/1024);
        LDRSH    R0,[R5, #+56]
        ADDS     R0,R0,R4
        LDRSB    R0,[R0, #+1292]
        ADD      R0,R0,#+1024
        LDRSH    R1,[R5, #+76]
        MOV      R2,#+512
        MLA      R0,R0,R1,R2
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R1,R0,#+10
        MOVS     R0,#+0
        BL       __Set
//  149 //  if(_1_source == HIDE){
//  150 //    if(_T_base > 16){
//  151 //      Interlace = 1;                      
//  152 //      __Set(CH_A_RANGE, G_Attr[0].Yp_Max+1);        // A通道合并到B通道 
//  153 //      __Set(ADC_CTRL, EN + 2);       
//  154 //      __Set(ADC_MODE, INTERLACE);                   // Set Interlace mode
//  155 //    }  
//  156 //  }
//  157   __Set(CH_B_COUPLE, Title[TRACK2][COUPLE].Value);
        LDRSH    R1,[R5, #+116]
        MOVS     R0,#+11
        BL       __Set
//  158   __Set(CH_B_RANGE,  Title[TRACK2][RANGE].Value);
        LDRSH    R1,[R5, #+136]
        MOVS     R0,#+12
        BL       __Set
//  159   __Set(CH_B_OFFSET, ((1024 + Kb3[_B_Range])*_2_posi + 512)/1024);
        LDRSH    R0,[R5, #+136]
        ADDS     R0,R0,R4
        ADD      R0,R0,#+1304
        LDRSB    R0,[R0, #+0]
        ADD      R0,R0,#+1024
        LDRSH    R1,[R5, #+156]
        MOV      R2,#+512
        MLA      R0,R0,R1,R2
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R1,R0,#+10
        MOVS     R0,#+1
        BL       __Set
//  160 //  if(_2_source == HIDE){
//  161 //    if(_T_base > 16){
//  162 //      Interlace = 1;                        
//  163 //      __Set(CH_B_RANGE,  G_Attr[0].Yp_Max+1);      // B通道合并到A通道
//  164 //      __Set(ADC_CTRL, EN + 2);       
//  165 //      __Set(ADC_MODE, INTERLACE);                  // Set Interlace mode
//  166 //    }
//  167 //  } 
//  168   if(_Status == RUN) __Set(FIFO_CLR, W_PTR);       // FIFO写指针复位
        LDRSH    R0,[R5, #+336]
        CBNZ     R0,??Update_Range_0
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
//  169 }
??Update_Range_0:
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        CFI EndBlock cfiBlock2
//  170 /*******************************************************************************
//  171  Update_Base: 
//  172 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Update_Base
        THUMB
//  173 void Update_Base(void) 
//  174 {
Update_Base:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
//  175   u16 i;
//  176   
//  177   __Set(ADC_CTRL, EN);       
        MOVS     R1,#+1
        MOVS     R0,#+36
        BL       __Set
//  178   if(Interlace == 0)  i = Title[T_BASE][BASE].Value;     // 独立采样模式
        LDR.W    R4,??DataTable16  ;; Title
        LDRSH    R0,[R4, #+436]
        LDR.W    R5,??DataTable15  ;; TrackBuff
        ADD      R1,R5,#+1200
        LDRB     R1,[R1, #+0]
        CBZ      R1,??Update_Base_0
//  179   else                i = Title[T_BASE][BASE].Value + 5; // 交替采样模式
??Update_Base_1:
        ADDS     R0,R0,#+5
??Update_Base_0:
        UXTH     R0,R0
//  180   __Set(T_BASE_PSC, X_Attr[i].PSC);
        MOVS     R1,#+20
        MUL      R6,R0,R1
        ADD      R0,R5,#+1224
        LDR      R0,[R0, #+0]
        ADDS     R0,R6,R0
        LDRSH    R1,[R0, #+8]
        MOVS     R0,#+7
        BL       __Set
//  181   __Set(T_BASE_ARR, X_Attr[i].ARR);
        ADD      R0,R5,#+1224
        LDR      R0,[R0, #+0]
        ADDS     R0,R6,R0
        LDRH     R1,[R0, #+10]
        MOVS     R0,#+8
        BL       __Set
//  182   Wait_Cnt = Wait[_T_base];
        LDRSH    R0,[R4, #+436]
        LDR.N    R1,??DataTable6  ;; Wait
        LDRH     R0,[R1, R0, LSL #+1]
        LDR.N    R1,??DataTable7  ;; Wait_Cnt
        STR      R0,[R1, #+0]
//  183   if(_Status == RUN) __Set(FIFO_CLR, W_PTR);      // FIFO写指针复位
        LDRSH    R0,[R4, #+336]
        CBNZ     R0,??Update_Base_2
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
//  184 }
??Update_Base_2:
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock3

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable6:
        DC32     Wait

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7:
        DC32     Wait_Cnt
//  185 /*******************************************************************************
//  186  Update_Output: 
//  187 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Update_Output
        THUMB
//  188 void Update_Output(void) 
//  189 {
Update_Output:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
//  190   if(_Kind == SINE){
        LDR.W    R4,??DataTable16  ;; Title
        LDRSH    R0,[R4, #+496]
        CBNZ     R0,??Update_Output_0
//  191     __Set(ANALOG_CNT, 36);
        MOVS     R1,#+36
        MOVS     R0,#+15
        BL       __Set
//  192     (*((vu32 *)(0x40020400+0x50))) = (u32)&SIN_DATA[0];
        LDR.N    R5,??Update_Output_1  ;; D_Tab
        ADD      R0,R5,#+412
        LDR.N    R1,??Update_Output_1+0x4  ;; 0x40020450
        STR      R0,[R1, #+0]
//  193     __Set(ANALOG_ARR, A_Tab[_Frqn].ARR);
        LDRSH    R0,[R4, #+516]
        MOVS     R1,#+12
        MLA      R0,R0,R1,R5
        ADD      R0,R0,#+290
        LDRH     R1,[R0, #+0]
        MOVS     R0,#+13
        BL       __Set
//  194   }
//  195   if(_Kind == SAW){
??Update_Output_0:
        LDRSH    R0,[R4, #+496]
        CMP      R0,#+2
        BNE.N    ??Update_Output_2
//  196     __Set(ANALOG_ARR, A_Tab[_Frqn].ARR);
        LDR.N    R5,??Update_Output_1  ;; D_Tab
        LDRSH    R0,[R4, #+516]
        MOVS     R1,#+12
        MLA      R0,R0,R1,R5
        ADD      R0,R0,#+290
        LDRH     R1,[R0, #+0]
        MOVS     R0,#+13
        BL       __Set
//  197     (*((vu32 *)(0x40020400+0x50))) = (u32)&SAW_DATA[0];
        ADD      R0,R5,#+556
        LDR.N    R1,??Update_Output_1+0x4  ;; 0x40020450
        STR      R0,[R1, #+0]
//  198     __Set(ANALOG_CNT, 36);
        MOVS     R1,#+36
        MOVS     R0,#+15
        BL       __Set
//  199   }
//  200   if(_Kind == TRIANG){
??Update_Output_2:
        LDRSH    R0,[R4, #+496]
        CMP      R0,#+1
        BNE.N    ??Update_Output_3
//  201     __Set(ANALOG_ARR, A_Tab[_Frqn].ARR);
        LDR.N    R5,??Update_Output_1  ;; D_Tab
        LDRSH    R0,[R4, #+516]
        MOVS     R1,#+12
        MLA      R0,R0,R1,R5
        ADD      R0,R0,#+290
        LDRH     R1,[R0, #+0]
        MOVS     R0,#+13
        BL       __Set
//  202     (*((vu32 *)(0x40020400+0x50))) = (u32)&TRG_DATA[0];
        ADD      R0,R5,#+484
        LDR.N    R1,??Update_Output_1+0x4  ;; 0x40020450
        STR      R0,[R1, #+0]
//  203     __Set(ANALOG_CNT, 36);
        MOVS     R1,#+36
        MOVS     R0,#+15
        BL       __Set
//  204   }
//  205   if(_Kind == DIGI){
??Update_Output_3:
        LDRSH    R0,[R4, #+496]
        CMP      R0,#+3
        BNE.N    ??Update_Output_4
//  206     __Set(DIGTAL_PSC, D_Tab[_Frqn].PSC);
        MOVS     R6,#+14
        LDR.N    R5,??Update_Output_1  ;; D_Tab
        LDRSH    R0,[R4, #+516]
        MLA      R0,R0,R6,R5
        LDRH     R1,[R0, #+8]
        MOVS     R0,#+16
        BL       __Set
//  207     __Set(DIGTAL_ARR, D_Tab[_Frqn].ARR);
        LDRSH    R0,[R4, #+516]
        MLA      R0,R0,R6,R5
        LDRH     R1,[R0, #+10]
        MOVS     R0,#+17
        BL       __Set
//  208     __Set(DIGTAL_CCR, (D_Tab[_Frqn].ARR+1)/2);
        LDRSH    R0,[R4, #+516]
        MLA      R0,R0,R6,R5
        LDRH     R0,[R0, #+10]
        ADDS     R0,R0,#+1
        ADD      R0,R0,R0, LSR #+31
        ASRS     R1,R0,#+1
        MOVS     R0,#+18
        BL       __Set
//  209   }
//  210 }
??Update_Output_4:
        POP      {R4-R6,PC}       ;; return
        Nop      
        DATA
??Update_Output_1:
        DC32     D_Tab
        DC32     0x40020450
        CFI EndBlock cfiBlock4
//  211 /*******************************************************************************
//  212  Update_Trig: 
//  213 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function Update_Trig
        THUMB
//  214 void Update_Trig(void) 
//  215 { 
Update_Trig:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  216   if(_T1 > _T2)  __Set(T_THRESHOLD, (_T1 - _T2));  
        LDR.W    R4,??DataTable16  ;; Title
        LDRSH    R0,[R4, #+816]
        LDRSH    R2,[R4, #+836]
        CMP      R2,R0
        BGE.N    ??Update_Trig_0
        SUBS     R1,R0,R2
        B.N      ??Update_Trig_1
//  217   else           __Set(T_THRESHOLD, (_T2 - _T1)); 
??Update_Trig_0:
        SUBS     R1,R2,R0
??Update_Trig_1:
        MOVS     R0,#+34
        BL       __Set
//  218   __Set(TRIGG_MODE,  (_Tr_source<< 3)+_Tr_kind);
        LDRSH    R0,[R4, #+576]
        LDRSH    R1,[R4, #+596]
        ADD      R1,R1,R0, LSL #+3
        MOVS     R0,#+32
        BL       __Set
//  219   if(Title[TRIGG][SOURCE].Value == TRACK1){ 
        LDRSH    R0,[R4, #+576]
        CBNZ     R0,??Update_Trig_2
        LDRSH    R1,[R4, #+56]
        LDR.W    R0,??DataTable15  ;; TrackBuff
        LDR.N    R2,??Update_Trig_3  ;; V_Trigg
        LDRSH    R2,[R2, #+0]
        ADDS     R3,R1,R0
        LDRSB    R3,[R3, #+1228]
        SUBS     R2,R2,R3
        LSLS     R2,R2,#+10
        ADD      R0,R0,R1, LSL #+1
        LDRH     R0,[R0, #+1252]
        SDIV     R0,R2,R0
        UXTB     R1,R0
        MOVS     R0,#+33
//  220     __Set(V_THRESHOLD, (((_Vt1-Ka1[_A_Range])*1024)/Ka2[_A_Range])&0xFF); 
        BL       __Set
//  221   }
//  222   if(Title[TRIGG][SOURCE].Value == TRACK2){ 
??Update_Trig_2:
        LDRSH    R0,[R4, #+576]
        CMP      R0,#+1
        BNE.N    ??Update_Trig_4
        LDRSH    R1,[R4, #+136]
        LDR.W    R0,??DataTable15  ;; TrackBuff
        LDR.N    R2,??Update_Trig_3  ;; V_Trigg
        LDRSH    R2,[R2, #+4]
        ADDS     R3,R1,R0
        ADD      R3,R3,#+1240
        LDRSB    R3,[R3, #+0]
        SUBS     R2,R2,R3
        LSLS     R2,R2,#+10
        ADD      R0,R0,R1, LSL #+1
        ADD      R0,R0,#+1272
        LDRH     R0,[R0, #+0]
        SDIV     R0,R2,R0
        UXTB     R1,R0
        MOVS     R0,#+33
//  223     __Set(V_THRESHOLD, (((_Vt2-Kb1[_B_Range])*1024)/Kb2[_B_Range])&0xFF); 
        BL       __Set
//  224   }
//  225   if(_Status == RUN) __Set(FIFO_CLR, W_PTR);      // FIFO写指针复位
??Update_Trig_4:
        LDRSH    R0,[R4, #+336]
        CBNZ     R0,??Update_Trig_5
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
//  226 }
??Update_Trig_5:
        POP      {R4,PC}          ;; return
        DATA
??Update_Trig_3:
        DC32     V_Trigg
        CFI EndBlock cfiBlock5
//  227 /*******************************************************************************
//  228  Process: 计算处理缓冲区数据 
//  229 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function Process
        THUMB
//  230 void Process(void)
//  231 { 
Process:
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
        SUB      SP,SP,#+76
        CFI CFA R13+112
//  232   s16 i, j = 0, k, V[8], n = 0;
        MOVS     R4,#+0
        MOVS     R5,#+0
//  233   s32 Tmp;
//  234   u8  Ch[4], C_D;
//  235   s8  Sa = 2, Sb = 2, Sc = 2, Sd = 2; // 计时状态
        MOVS     R0,#+2
        STR      R0,[SP, #+16]
        STR      R0,[SP, #+20]
        STR      R0,[SP, #+24]
        MOV      R11,R0
//  236   u16 Ta, Tb, Tc, Td;                 // 脉宽计数
//  237   
//  238   PaS = 0; PbS = 0; PcS = 0; PdS = 0; 
        LDR.W    R6,??Process_0   ;; a_Mid_H
        STRH     R4,[R6, #+16]
        STRH     R4,[R6, #+18]
        STRH     R4,[R6, #+20]
        STRH     R4,[R6, #+22]
//  239   TaN = 0; TbN = 0; TcN = 0; TdN = 0; 
        STRH     R4,[R6, #+24]
        STRH     R4,[R6, #+26]
        STRH     R4,[R6, #+28]
        STRH     R4,[R6, #+30]
//  240 
//  241   Posi_412 = _4_posi - _1_posi - _2_posi;
        LDR.W    R9,??DataTable16  ;; Title
        LDRSH    R2,[R9, #+76]
        LDRSH    R0,[R9, #+316]
        SUBS     R3,R0,R2
        LDRSH    R1,[R9, #+156]
        LDR.W    R8,??DataTable15  ;; TrackBuff
        SUB      R12,R3,R1
        STRH     R12,[R8, #+1202]
//  242   Posi_41  = _4_posi - _1_posi;
        STRH     R3,[R8, #+1204]
//  243   Posi_42  = _4_posi - _2_posi;
        SUBS     R3,R0,R1
        STRH     R3,[R8, #+1206]
//  244   Posi_4_2 = _4_posi + _2_posi;
        ADDS     R3,R1,R0
        ADD      R12,R8,#+1208
        STRH     R3,[R12, #+0]
//  245   Posi_4F1 = _4_posi - FileBuff[ 299];
        LDR.W    R3,??DataTable20  ;; FileBuff
        LDRB     R12,[R3, #+299]
        SUB      R12,R0,R12
        STRH     R12,[R8, #+1210]
//  246   Posi_4F2 = _4_posi - FileBuff[ 599];
        LDRB     R12,[R3, #+599]
        SUB      R12,R0,R12
        STRH     R12,[R8, #+1212]
//  247   Posi_4F3 = _4_posi - FileBuff[ 899];
        LDRB     R12,[R3, #+899]
        SUB      R12,R0,R12
        STRH     R12,[R8, #+1214]
//  248   Posi_4F4 = _4_posi - FileBuff[1199];
        LDRB     R3,[R3, #+1199]
        SUBS     R3,R0,R3
        ADD      R12,R8,#+1216
        STRH     R3,[R12, #+0]
        LDRSH    R3,[R9, #+56]
        ADD      R12,R3,R8
        LDRSB    R12,[R12, #+1228]
        SUB      R2,R2,R12
        LSLS     R2,R2,#+10
        ADD      R3,R8,R3, LSL #+1
        LDRH     R3,[R3, #+1252]
        SDIV     R2,R2,R3
        STRH     R2,[R6, #+32]
        LDRSH    R2,[R9, #+136]
        ADD      R3,R2,R8
        ADD      R3,R3,#+1240
        LDRSB    R3,[R3, R4]
        SUBS     R1,R1,R3
        LSLS     R1,R1,#+10
        ADD      R2,R8,R2, LSL #+1
        ADD      R2,R2,#+1272
        LDRH     R2,[R2, #+0]
        SDIV     R1,R1,R2
        STRH     R1,[R6, #+34]
//  249   A_Posi   = ((_1_posi-Ka1[_A_Range])*1024)/Ka2[_A_Range];
//  250   B_Posi   = ((_2_posi-Kb1[_B_Range])*1024)/Kb2[_B_Range];
//  251   
//  252   a_Max = A_Posi; b_Max = B_Posi; 
        LDRSH    R1,[R6, #+32]
        STRB     R1,[R6, #+4]
        LDRSH    R2,[R6, #+34]
        STRB     R2,[R6, #+5]
//  253   a_Min = A_Posi; b_Min = B_Posi;             
        STRB     R1,[R6, #+6]
        STRB     R2,[R6, #+7]
//  254   a_Avg = 2048;   b_Avg = 2048; 
        MOV      R1,#+2048
        STR      R1,[R6, #+36]
        STR      R1,[R6, #+40]
//  255   a_Ssq = 2048;   b_Ssq = 2048;      
        STR      R1,[R6, #+44]
        STR      R1,[R6, #+48]
//  256   
//  257   if((_3_posi + 20)>= Y_BASE+Y_SIZE)  c_Max = Y_BASE+Y_SIZE-1;
        LDRSH    R1,[R9, #+236]
        ADD      R2,R1,#+20
        CMP      R2,#+200
        BLT.N    ??Process_1
        MOVS     R1,#+199
        B.N      ??Process_2
//  258   else                                c_Max = _3_posi + 20;
??Process_1:
        ADDS     R1,R1,#+20
??Process_2:
        STRH     R1,[R8, #+1218]
//  259   if((_4_posi + 20)>= Y_BASE+Y_SIZE)  d_Max = Y_BASE+Y_SIZE-1;
        ADD      R1,R0,#+20
        CMP      R1,#+200
        BLT.N    ??Process_3
        MOVS     R0,#+199
        B.N      ??Process_4
//  260   else                                d_Max = _4_posi + 20;
??Process_3:
        ADDS     R0,R0,#+20
??Process_4:
        STRH     R0,[R8, #+1220]
        LDRSH    R0,[R9, #+436]
        MOVS     R1,#+20
        ADD      R2,R8,#+1224
        LDR      R2,[R2, #+0]
        MLA      R1,R0,R1,R2
        LDRSH    R0,[R9, #+456]
        MOVS     R2,#+150
        LDR.W    R3,??Process_0+0x4  ;; 0x25a00
        ADD      R12,R8,#+1200
        LDRB     R12,[R12, #+0]
        CMP      R12,#+0
        BNE.W    ??Process_5
//  261   
//  262   if(Interlace == 0){                           // 独立采样模式
//  263     k =((1024 -_Kp1)*150 + 512)/1024 + _X_posi.Value;  // 计算插值运算后窗口位置的修正值
        LDRH     R1,[R1, #+14]
        MLS      R1,R1,R2,R3
        ASRS     R2,R1,#+9
        ADD      R1,R1,R2, LSR #+22
        ADD      R10,R0,R1, ASR #+10
//  264     for(i=0; i <4096; i++){
        MOVS     R7,#+0
        ADD      R0,R6,#+52
        STR      R0,[SP, #+4]
        B.N      ??Process_6
//  265       if((_T_base > 16)&&(_Status == RUN))  DataBuf[i] = __Read_FIFO(); // 读入32位FIFO数据, 读后指针+1
//  266       else if((__Get(FIFO_EMPTY)==0)&&(i == JumpCnt)&&(_Status == RUN)){
//  267         JumpCnt++;
//  268         DataBuf[i] = __Read_FIFO();             // 读入32位FIFO数据, 读后指针+1
//  269       }
//  270       Ch[A] = (DataBuf[i] & 0xFF );              
//  271       a_Avg += Ch[A];                           // 累计A通道直流平均值              
//  272       Tmp = Ch[A]- A_Posi;
//  273       a_Ssq +=(Tmp * Tmp);                      // 统计A通道平方和
//  274       Ch[B] = ((DataBuf[i] >> 8) & 0xFF);       
//  275       b_Avg += Ch[B];                           // 累计B通道直流平均值
//  276       Tmp = Ch[B]- B_Posi;
//  277       b_Ssq +=(Tmp * Tmp);                      // 统计B通道平方和
//  278         
//  279       if(Ch[A] > a_Max)  a_Max = Ch[A];         // 统计A通道最大值  
//  280       if(Ch[A] < a_Min)  a_Min = Ch[A];         // 统计A通道最小值  
//  281       if(Ch[B] > b_Max)  b_Max = Ch[B];         // 统计B通道最大值  
//  282       if(Ch[B] < b_Min)  b_Min = Ch[B];         // 统计B通道最小值  
//  283        
//  284       C_D = DataBuf[i] >>16;
//  285       if((i>1)&&(i<4094)){
//  286         if(Sa == 2){TaS = i; Ta = i; PaS = 0;}
//  287         if(Ch[A] > a_Mid_H){
//  288           if(Sa == 0){ TaS = i; TaN++;} 
//  289           Sa = 1;  
//  290         } else { 
//  291           if(Ch[A] < a_Mid_L) if(Sa == 1){Sa = 0; PaS += i-TaS;}
//  292         }
//  293         if(Sb == 2){TbS = i; Tb = i; PbS = 0;}
//  294         if(Ch[B] > b_Mid_H){
//  295           if(Sb == 0){ TbS = i; TbN++;} 
//  296           Sb = 1;  
//  297         } else { 
//  298           if(Ch[B] < b_Mid_L) if(Sb == 1){Sb = 0; PbS += i-TbS;}
//  299         }
//  300         if(Sc == 2){TcS = i; Tc = i; PcS = 0;}
//  301         if(C_D & 1){
//  302           if(Sc == 0){ TcS = i; TcN++;} 
//  303           Sc = 1;  
//  304         } else {
//  305           if(Sc == 1){Sc = 0; PcS += i-TcS;} 
//  306         }
//  307         if(Sd == 2){TdS = i; Td = i; PdS = 0;}
//  308         if(C_D & 2){
//  309           if(Sd == 0){ TdS = i; TdN++;} 
//  310           Sd = 1;  
//  311         } else {
//  312           if(Sd == 1){Sd = 0; PdS += i-TdS;} 
??Process_7:
        CMP      R11,#+1
        BNE.N    ??Process_8
        MOV      R11,#+0
        LDRH     R0,[R6, #+22]
        ADDS     R0,R7,R0
        LDRH     R1,[R6, #+14]
        SUBS     R0,R0,R1
        STRH     R0,[R6, #+22]
//  313         }
//  314       }
//  315       if(i >= k){                               // 指针到达指定窗口位置
??Process_8:
        SXTH     R10,R10
        CMP      R7,R10
        BLT.N    ??Process_9
//  316         V[A]  = Ka1[_A_Range] +(Ka2[_A_Range] *Ch[A]+ 512)/1024;      
        LDRSH    R0,[R9, #+56]
        ADD      R1,R8,R0, LSL #+1
        LDRH     R1,[R1, #+1252]
        MOV      R12,#+512
        MLA      R1,R1,R3,R12
        ADD      R0,R0,R8
        LDRSB    R0,[R0, #+1228]
        ASRS     R3,R1,#+9
        ADD      R1,R1,R3, LSR #+22
        ADD      R0,R0,R1, ASR #+10
        STRH     R0,[SP, #+28]
//  317         V[B]  = Kb1[_B_Range] +(Kb2[_B_Range] *Ch[B]+ 512)/1024;      //当前点的主值
        LDRSH    R0,[R9, #+136]
        ADD      R1,R8,R0, LSL #+1
        ADD      R1,R1,#+1272
        LDRH     R1,[R1, #+0]
        MLA      R1,R1,R2,R12
        ADD      R0,R0,R8
        ADD      R0,R0,#+1240
        LDRSB    R0,[R0, #+0]
        ASRS     R2,R1,#+9
        ADD      R1,R1,R2, LSR #+22
        ADD      R0,R0,R1, ASR #+10
        STRH     R0,[SP, #+8]
        LDRH     R0,[SP, #+8]
        STRH     R0,[SP, #+30]
        LDRH     R0,[SP, #+32]
        STRH     R0,[SP, #+10]
        LDRSH    R0,[SP, #+28]
        LDRSH    R1,[SP, #+10]
        SUBS     R0,R0,R1
        STR      R0,[SP, #+64]
        LDRH     R0,[SP, #+34]
        STRH     R0,[SP, #+44]
        LDRSH    R0,[SP, #+8]
        LDRSH    R1,[SP, #+44]
        SUBS     R0,R0,R1
        STR      R0,[SP, #+68]
//  318         while(j > 0 ){
??Process_10:
        CMP      R4,#+1
        BLT.N    ??Process_11
//  319           Send_Data( V[A_]+((V[A]-V[A_])*(1024 - j))/1024, //当前CH_A点的插值
//  320                      V[B_]+((V[B]-V[B_])*(1024 - j))/1024, //当前CH_B点的插值
//  321                      C_D,                                  //当前点数字通道值
//  322                      n++);
        RSB      R0,R4,#+1024
        LDR      R1,[SP, #+68]
        MULS     R1,R1,R0
        LDR      R2,[SP, #+64]
        MULS     R0,R2,R0
        UXTH     R3,R5
        LDR      R2,[SP, #+12]
        UXTB     R2,R2
        LDRH     R12,[SP, #+44]
        ASR      LR,R1,#+9
        ADD      R1,R1,LR, LSR #+22
        ADD      R1,R12,R1, ASR #+10
        SXTH     R1,R1
        LDRH     R12,[SP, #+10]
        ASR      LR,R0,#+9
        ADD      R0,R0,LR, LSR #+22
        ADD      R0,R12,R0, ASR #+10
        SXTH     R0,R0
        BL       Send_Data
        ADDS     R5,R5,#+1
        SXTH     R5,R5
//  323           j -= _Kp1;
        LDRSH    R0,[R9, #+436]
        MOVS     R1,#+20
        ADD      R2,R8,#+1224
        LDR      R2,[R2, #+0]
        MLA      R0,R0,R1,R2
        LDRSH    R0,[R0, #+14]
        SUBS     R4,R4,R0
        SXTH     R4,R4
//  324           if(n >= 300){ k = 8192;  break;}
        CMP      R5,#+300
        BLT.N    ??Process_10
        MOV      R10,#+8192
//  325         }
//  326         j += 1024;
??Process_11:
        ADD      R4,R4,#+1024
        SXTH     R4,R4
//  327         V[A_] = V[A];  V[B_] = V[B];     
        LDRH     R0,[SP, #+28]
        STRH     R0,[SP, #+32]
        LDRH     R0,[SP, #+8]
        STRH     R0,[SP, #+34]
//  328       }
??Process_9:
        ADDS     R7,R7,#+1
        LDR      R0,[SP, #+4]
        ADDS     R0,R0,#+4
        STR      R0,[SP, #+4]
        CMP      R7,#+4096
        BGE.W    ??Process_12
??Process_6:
        LDRSH    R0,[R9, #+436]
        CMP      R0,#+17
        BLT.N    ??Process_13
        LDRSH    R0,[R9, #+336]
        CBZ      R0,??Process_14
??Process_13:
        MOVS     R0,#+1
        BL       __Get
        CBNZ     R0,??Process_15
        LDRH     R0,[R8, #+1222]
        CMP      R7,R0
        BNE.N    ??Process_15
        LDRSH    R1,[R9, #+336]
        CBNZ     R1,??Process_15
        ADDS     R0,R0,#+1
        STRH     R0,[R8, #+1222]
??Process_14:
        BL       __Read_FIFO
        LDR      R1,[SP, #+4]
        STR      R0,[R1, #+0]
??Process_15:
        LDR      R0,[SP, #+4]
        LDR      R0,[R0, #+0]
        ADD      R1,SP,#+0
        STRB     R0,[R1, #+0]
        LDR      R1,[R6, #+36]
        LDRB     R2,[SP, #+0]
        ADDS     R1,R2,R1
        STR      R1,[R6, #+36]
        LDRB     R3,[SP, #+0]
        LDRSH    R1,[R6, #+32]
        SUBS     R1,R3,R1
        LDR      R2,[R6, #+44]
        MLA      R1,R1,R1,R2
        STR      R1,[R6, #+44]
        LSRS     R0,R0,#+8
        STRB     R0,[SP, #+1]
        LDRB     R1,[SP, #+1]
        LDR      R0,[R6, #+40]
        ADDS     R0,R1,R0
        STR      R0,[R6, #+40]
        MOVS     R2,R1
        LDRSH    R0,[R6, #+34]
        SUBS     R0,R2,R0
        LDR      R12,[R6, #+48]
        MLA      R0,R0,R0,R12
        STR      R0,[R6, #+48]
        LDRB     R0,[R6, #+4]
        LDRB     R12,[SP, #+0]
        CMP      R0,R12
        ITT      CC 
        MOVCC    R0,R12
        STRBCC   R0,[R6, #+4]
        MOV      R0,R12
        LDRB     R12,[R6, #+6]
        CMP      R0,R12
        IT       CC 
        STRBCC   R0,[R6, #+6]
        LDRB     R0,[R6, #+5]
        CMP      R0,R1
        IT       CC 
        STRBCC   R1,[R6, #+5]
        LDRB     R0,[R6, #+7]
        CMP      R1,R0
        IT       CC 
        STRBCC   R1,[R6, #+7]
        LDR      R0,[SP, #+4]
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+8
        LSRS     R0,R0,#+24
        STR      R0,[SP, #+12]
        CMP      R7,#+2
        BLT.W    ??Process_8
        MOVW     R0,#+4094
        CMP      R7,R0
        BGE.W    ??Process_8
        LDR      R0,[SP, #+16]
        CMP      R0,#+2
        BNE.N    ??Process_16
        STRH     R7,[R6, #+8]
        UXTH     R0,R7
        STR      R0,[SP, #+48]
        MOVS     R0,#+0
        STRH     R0,[R6, #+16]
??Process_16:
        LDRB     R0,[R6, #+0]
        LDRB     R12,[SP, #+0]
        CMP      R0,R12
        BCS.N    ??Process_17
        LDR      R0,[SP, #+16]
        CBNZ     R0,??Process_18
        STRH     R7,[R6, #+8]
        LDRH     R0,[R6, #+24]
        ADDS     R0,R0,#+1
        STRH     R0,[R6, #+24]
??Process_18:
        MOVS     R0,#+1
        STR      R0,[SP, #+16]
        B.N      ??Process_19
??Process_17:
        MOV      R0,R12
        LDRB     R12,[R6, #+1]
        CMP      R0,R12
        BCS.N    ??Process_19
        LDR      R0,[SP, #+16]
        CMP      R0,#+1
        BNE.N    ??Process_19
        MOVS     R0,#+0
        STR      R0,[SP, #+16]
        LDRH     R0,[R6, #+16]
        ADDS     R0,R7,R0
        LDRH     R12,[R6, #+8]
        SUB      R0,R0,R12
        STRH     R0,[R6, #+16]
??Process_19:
        LDR      R0,[SP, #+20]
        CMP      R0,#+2
        BNE.N    ??Process_20
        STRH     R7,[R6, #+10]
        UXTH     R0,R7
        STR      R0,[SP, #+52]
        MOVS     R0,#+0
        STRH     R0,[R6, #+18]
??Process_20:
        LDRB     R0,[R6, #+2]
        CMP      R0,R1
        BCS.N    ??Process_21
        LDR      R0,[SP, #+20]
        CBNZ     R0,??Process_22
        STRH     R7,[R6, #+10]
        LDRH     R0,[R6, #+26]
        ADDS     R0,R0,#+1
        STRH     R0,[R6, #+26]
??Process_22:
        MOVS     R0,#+1
        STR      R0,[SP, #+20]
        B.N      ??Process_23
??Process_21:
        LDRB     R0,[R6, #+3]
        CMP      R1,R0
        BCS.N    ??Process_23
        LDR      R0,[SP, #+20]
        CMP      R0,#+1
        BNE.N    ??Process_23
        MOVS     R0,#+0
        STR      R0,[SP, #+20]
        LDRH     R0,[R6, #+18]
        ADDS     R0,R7,R0
        LDRH     R1,[R6, #+10]
        SUBS     R0,R0,R1
        STRH     R0,[R6, #+18]
??Process_23:
        LDR      R0,[SP, #+24]
        CMP      R0,#+2
        BNE.N    ??Process_24
        STRH     R7,[R6, #+12]
        UXTH     R0,R7
        STR      R0,[SP, #+56]
        MOVS     R0,#+0
        STRH     R0,[R6, #+20]
??Process_24:
        LDR      R0,[SP, #+12]
        TST      R0,#0x1
        LDR      R0,[SP, #+24]
        BEQ.N    ??Process_25
        CBNZ     R0,??Process_26
        STRH     R7,[R6, #+12]
        LDRH     R0,[R6, #+28]
        ADDS     R0,R0,#+1
        STRH     R0,[R6, #+28]
??Process_26:
        MOVS     R0,#+1
        STR      R0,[SP, #+24]
        B.N      ??Process_27
??Process_25:
        CMP      R0,#+1
        BNE.N    ??Process_27
        MOVS     R0,#+0
        STR      R0,[SP, #+24]
        LDRH     R0,[R6, #+20]
        ADDS     R0,R7,R0
        LDRH     R1,[R6, #+12]
        SUBS     R0,R0,R1
        STRH     R0,[R6, #+20]
??Process_27:
        CMP      R11,#+2
        BNE.N    ??Process_28
        STRH     R7,[R6, #+14]
        UXTH     R0,R7
        STR      R0,[SP, #+60]
        MOVS     R0,#+0
        STRH     R0,[R6, #+22]
??Process_28:
        LDR      R0,[SP, #+12]
        TST      R0,#0x2
        BEQ.W    ??Process_7
        CMP      R11,#+0
        BNE.N    ??Process_29
        STRH     R7,[R6, #+14]
        LDRH     R0,[R6, #+30]
        ADDS     R0,R0,#+1
        STRH     R0,[R6, #+30]
??Process_29:
        MOV      R11,#+1
        B.N      ??Process_8
//  329     }
//  330   } 
//  331   else {                            // 交替采样模式
//  332     k =((1024 -_Kp2)*150 + 512)/1024 + _X_posi.Value;  // 计算插值运算后窗口位置的修正值
??Process_5:
        LDRH     R1,[R1, #+114]
        MLS      R1,R1,R2,R3
        ASRS     R2,R1,#+9
        ADD      R1,R1,R2, LSR #+22
        ADD      R10,R0,R1, ASR #+10
//  333     for(i=0; i <4096; i++){
        MOVS     R7,#+0
        ADD      R0,R6,#+52
        STR      R0,[SP, #+4]
//  334       if(_Status == RUN)  DataBuf[i] = __Read_FIFO(); // 读入32位FIFO数据, 读后指针+1
??Process_30:
        LDRSH    R0,[R9, #+336]
        CBNZ     R0,??Process_31
        BL       __Read_FIFO
        LDR      R1,[SP, #+4]
        STR      R0,[R1, #+0]
//  335       C_D    = DataBuf[i] >>16;
??Process_31:
        LDR      R0,[SP, #+4]
        LDR      R1,[R0, #+0]
        LSRS     R0,R1,#+16
        UXTB     R0,R0
        STR      R0,[SP, #+12]
//  336       if(_2_source == HIDE){                            // B通道合并到A通道时
        LDR      R0,[R6, #+44]
        LDRH     R2,[R9, #+96]
        STRH     R2,[SP, #+8]
        LDRSH    R2,[SP, #+8]
        CMP      R2,#+0
        ADD      R2,SP,#+0
        BNE.N    ??Process_32
//  337         Ch[A]  = (DataBuf[i] & 0xFF );              
        STRB     R1,[R2, #+0]
//  338         Ch[B]  = ((DataBuf[i] >> 8) & 0xFF);//+ Kab;
        LSRS     R1,R1,#+8
        STRB     R1,[SP, #+1]
        LDRSH    R2,[R6, #+32]
        LDRB     R3,[SP, #+0]
        SUBS     R3,R3,R2
//  339         Tmp    = (Ch[A]- A_Posi);
//  340         a_Ssq += (Tmp * Tmp)/2;
        MULS     R3,R3,R3
        ADD      R3,R3,R3, LSR #+31
        ADD      R3,R0,R3, ASR #+1
//  341         Tmp    = (Ch[B]- A_Posi);
        UXTB     R1,R1
        SUBS     R0,R1,R2
//  342         a_Ssq += (Tmp * Tmp)/2;                         // 统计平方和                    
        MULS     R0,R0,R0
        ADD      R0,R0,R0, LSR #+31
        ADD      R0,R3,R0, ASR #+1
        B.N      ??Process_33
//  343       } else {                                          // A通道合并到B通道时
//  344         Ch[B]  = (DataBuf[i] & 0xFF );//- Kab;              
??Process_32:
        STRB     R1,[R2, #+1]
//  345         Ch[A]  = ((DataBuf[i] >> 8) & 0xFF);  
        LSRS     R1,R1,#+8
        STRB     R1,[SP, #+0]
        LDRSH    R1,[R6, #+34]
        LDRB     R2,[SP, #+0]
        SUBS     R2,R2,R1
//  346         Tmp    = (Ch[A]- B_Posi);
//  347         a_Ssq += (Tmp * Tmp)/2;
        MULS     R2,R2,R2
        ADD      R2,R2,R2, LSR #+31
        ADD      R2,R0,R2, ASR #+1
//  348         Tmp    = (Ch[B]- B_Posi);
        LDRB     R0,[SP, #+1]
        SUBS     R0,R0,R1
//  349         a_Ssq += (Tmp * Tmp)/2;                                    // 统计平方和                    
        MULS     R0,R0,R0
        ADD      R0,R0,R0, LSR #+31
        ADD      R0,R2,R0, ASR #+1
??Process_33:
        STR      R0,[R6, #+44]
//  350       }
//  351       a_Avg += (Ch[A]+Ch[B])/2;                                   // 累计直流平均值                                   
        LDRB     R2,[SP, #+1]
        MOVS     R0,R2
        LDRB     R1,[SP, #+0]
        ADDS     R3,R0,R1
        LDR      R12,[R6, #+36]
        ADD      R3,R3,R3, LSR #+31
        ADD      R3,R12,R3, ASR #+1
        STR      R3,[R6, #+36]
//  352       if(Ch[A] > a_Max)  a_Max = Ch[A];          
        LDRB     R3,[R6, #+4]
        LDRB     R12,[SP, #+0]
        CMP      R3,R12
        ITT      CC 
        MOVCC    R3,R12
        STRBCC   R3,[R6, #+4]
//  353       if(Ch[B] > a_Max)  a_Max = Ch[B];                          // 统计最大值 
        LDRB     R3,[R6, #+4]
        CMP      R3,R2
        IT       CC 
        STRBCC   R2,[R6, #+4]
//  354       if(Ch[A] < a_Min)  a_Min = Ch[A];         
        LDRB     R3,[SP, #+0]
        LDRB     R12,[R6, #+6]
        CMP      R3,R12
        IT       CC 
        STRBCC   R3,[R6, #+6]
//  355       if(Ch[B] < a_Min)  a_Min = Ch[B];                          // 统计最小值  
        LDRB     R3,[R6, #+6]
        CMP      R2,R3
        IT       CC 
        STRBCC   R2,[R6, #+6]
//  356 
//  357       if(i >= k){                 // 第1点指针到达指定窗口位置
        SXTH     R10,R10
        CMP      R7,R10
        BLT.N    ??Process_34
//  358         if(_2_source == HIDE){                            // B通道合并到A通道时
        LDRSH    R2,[SP, #+8]
        CBNZ     R2,??Process_35
//  359           V[A] = Ka1[_A_Range] +(Ka2[_A_Range]*Ch[A]+ 512)/1024;    //计算当前第1点的主值
        LDRSH    R3,[R9, #+56]
        ADD      R2,R8,R3, LSL #+1
        LDRH     R2,[R2, #+1252]
        MOV      R12,#+512
        MLA      R12,R2,R1,R12
        ADD      R1,R3,R8
        LDRSB    R1,[R1, #+1228]
        ASR      R3,R12,#+9
        ADD      R3,R12,R3, LSR #+22
        ADD      R3,R1,R3, ASR #+10
        STRH     R3,[SP, #+28]
//  360           V[B] = Ka1[_A_Range] +(Ka2[_A_Range]*Ch[B]+ 512)/1024;    //计算当前第2点的主值
        MOV      R3,#+512
        MLA      R0,R2,R0,R3
        ASRS     R2,R0,#+9
        ADD      R0,R0,R2, LSR #+22
        ADD      R0,R1,R0, ASR #+10
        STRH     R0,[SP, #+30]
        B.N      ??Process_36
//  361         } else {                                          // A通道合并到B通道时
//  362           V[A] = Kb1[_B_Range] +(Kb2[_B_Range]*Ch[A]+ 512)/1024;   //计算当前第1点的主值
??Process_35:
        LDRSH    R2,[R9, #+136]
        ADD      R3,R8,R2, LSL #+1
        ADD      R3,R3,#+1272
        LDRH     R3,[R3, #+0]
        MOV      R12,#+512
        MLA      R1,R3,R1,R12
        ADD      R2,R2,R8
        ADD      R2,R2,#+1240
        LDRSB    R2,[R2, #+0]
        ASR      R12,R1,#+9
        ADD      R1,R1,R12, LSR #+22
        ADD      R1,R2,R1, ASR #+10
        STRH     R1,[SP, #+28]
//  363           V[B] = Kb1[_B_Range] +(Kb2[_B_Range]*Ch[B]+ 512)/1024;   //计算当前第2点的主值
        MOV      R1,#+512
        MLA      R0,R3,R0,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ADD      R0,R2,R0, ASR #+10
        STRH     R0,[SP, #+30]
//  364         }
//  365         while(j > 0 ){
??Process_36:
        CMP      R4,#+1
        BLT.N    ??Process_37
//  366           Tmp = V[B_]+((V[A]- V[B_])*(1024 - j))/1024; //当前第1点的插值
        LDRSH    R0,[SP, #+34]
        LDRSH    R1,[SP, #+28]
        SUBS     R1,R1,R0
        RSB      R2,R4,#+1024
        MULS     R1,R1,R2
        ASRS     R2,R1,#+9
        ADD      R1,R1,R2, LSR #+22
        ADD      R0,R0,R1, ASR #+10
//  367           Send_Data(Tmp, Tmp, C_D, n++);
        UXTH     R3,R5
        LDR      R2,[SP, #+12]
        UXTB     R2,R2
        SXTH     R1,R0
        SXTH     R0,R0
        BL       Send_Data
        ADDS     R5,R5,#+1
        SXTH     R5,R5
//  368           j -= _Kp2;
        LDRSH    R0,[R9, #+436]
        MOVS     R1,#+20
        ADD      R2,R8,#+1224
        LDR      R2,[R2, #+0]
        MLA      R0,R0,R1,R2
        LDRSH    R0,[R0, #+114]
        SUBS     R4,R4,R0
        SXTH     R4,R4
//  369           if(n >= 300){ k = 8192;  break;}
        CMP      R5,#+300
        BLT.N    ??Process_36
        MOV      R10,#+8192
//  370         }
//  371         j += 1024;
??Process_37:
        ADD      R4,R4,#+1024
        SXTH     R4,R4
//  372       }
//  373       if(i >= k){                 // 第2点指针到达指定窗口位置
??Process_34:
        CMP      R7,R10
        BLT.N    ??Process_38
//  374         while(j > 0 ){
??Process_39:
        LDRSH    R11,[SP, #+30]
        CMP      R4,#+1
        BLT.N    ??Process_40
//  375           Tmp = V[A]+((V[B]- V[A])*(1024 - j))/1024;  //当前第2点的插值
        LDRSH    R0,[SP, #+28]
        SUB      R1,R11,R0
        RSB      R2,R4,#+1024
        MULS     R1,R1,R2
        ASRS     R2,R1,#+9
        ADD      R1,R1,R2, LSR #+22
        ADD      R0,R0,R1, ASR #+10
//  376           Send_Data(Tmp, Tmp, C_D, n++);
        UXTH     R3,R5
        LDR      R2,[SP, #+12]
        UXTB     R2,R2
        SXTH     R1,R0
        SXTH     R0,R0
        BL       Send_Data
        ADDS     R5,R5,#+1
        SXTH     R5,R5
//  377           j -= _Kp2;
        LDRSH    R0,[R9, #+436]
        MOVS     R1,#+20
        ADD      R2,R8,#+1224
        LDR      R2,[R2, #+0]
        MLA      R0,R0,R1,R2
        LDRSH    R0,[R0, #+114]
        SUBS     R4,R4,R0
        SXTH     R4,R4
//  378           if(n >= 300){ k = 8192;  break;}
        CMP      R5,#+300
        BLT.N    ??Process_39
        MOV      R10,#+8192
//  379         }
//  380         j += 1024;
??Process_40:
        ADD      R4,R4,#+1024
        SXTH     R4,R4
//  381         V[B_] = V[B];       
        STRH     R11,[SP, #+34]
//  382       }
//  383     }
??Process_38:
        ADDS     R7,R7,#+1
        LDR      R0,[SP, #+4]
        ADDS     R0,R0,#+4
        STR      R0,[SP, #+4]
        CMP      R7,#+4096
        BLT.W    ??Process_30
//  384     b_Avg  = a_Avg;
        LDR      R0,[R6, #+36]
        STR      R0,[R6, #+40]
//  385     b_Ssq  = a_Ssq;
        LDR      R0,[R6, #+44]
        STR      R0,[R6, #+48]
//  386     b_Max  = a_Max;
        LDRB     R0,[R6, #+4]
        STRB     R0,[R6, #+5]
//  387     b_Min  = a_Min;
        LDRB     R0,[R6, #+6]
        STRB     R0,[R6, #+7]
//  388 
//  389     if(_1_source == HIDE)  a_Avg = _1_posi*4096;   // A通道合并到B通道时      
        LDRSH    R0,[R9, #+16]
        CBNZ     R0,??Process_41
        LDRSH    R0,[R9, #+76]
        LSLS     R0,R0,#+12
        STR      R0,[R6, #+36]
//  390     if(_2_source == HIDE)  b_Avg = _2_posi*4096;   // B通道合并到A通道时
??Process_41:
        LDRSH    R0,[R9, #+96]
        CBNZ     R0,??Process_12
        LDRSH    R0,[R9, #+156]
        LSLS     R0,R0,#+12
        STR      R0,[R6, #+40]
//  391   }
//  392 
//  393   a_Mid_H = 4 +(a_Max + a_Min)/2;
??Process_12:
        LDRB     R0,[R6, #+4]
        LDRB     R1,[R6, #+6]
        ADDS     R0,R1,R0
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        ADDS     R0,R0,#+4
        STRB     R0,[R6, #+0]
//  394   a_Mid_L = a_Mid_H - 8;
        SUBS     R0,R0,#+8
        STRB     R0,[R6, #+1]
//  395   b_Mid_H = 4 +(b_Max + b_Min)/2;
        LDRB     R0,[R6, #+5]
        LDRB     R1,[R6, #+7]
        ADDS     R0,R1,R0
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        ADDS     R0,R0,#+4
        STRB     R0,[R6, #+2]
//  396   b_Mid_L = b_Mid_H - 8;
        SUBS     R0,R0,#+8
        STRB     R0,[R6, #+3]
//  397 
//  398   TaS -= Ta; TbS -= Tb; TcS -= Tc; TdS -= Td;
        LDRH     R0,[R6, #+8]
        LDR      R1,[SP, #+48]
        SUBS     R0,R0,R1
        STRH     R0,[R6, #+8]
        LDRH     R0,[R6, #+10]
        LDR      R1,[SP, #+52]
        SUBS     R0,R0,R1
        STRH     R0,[R6, #+10]
        LDRH     R0,[R6, #+12]
        LDR      R1,[SP, #+56]
        SUBS     R0,R0,R1
        STRH     R0,[R6, #+12]
        LDRH     R0,[R6, #+14]
        LDR      R1,[SP, #+60]
        SUBS     R0,R0,R1
        STRH     R0,[R6, #+14]
//  399   
//  400   for(j=0; j<4; j++){                               // 消除屏幕端点连线
//  401     TrackBuff[(  0)*4+ j] = TrackBuff[(  1)*4 + j];
        LDRB     R0,[R8, #+4]
        STRB     R0,[R8, #+0]
//  402     TrackBuff[(299)*4+ j] = TrackBuff[(298)*4 + j];
        ADD      R0,R8,#+1192
        LDRB     R0,[R0, #+0]
        STRB     R0,[R8, #+1196]
        LDRB     R0,[R8, #+5]
        STRB     R0,[R8, #+1]
        LDRB     R0,[R8, #+1193]
        STRB     R0,[R8, #+1197]
        LDRB     R0,[R8, #+6]
        STRB     R0,[R8, #+2]
        LDRB     R0,[R8, #+1194]
        STRB     R0,[R8, #+1198]
        LDRB     R0,[R8, #+7]
        STRB     R0,[R8, #+3]
        LDRB     R0,[R8, #+1195]
        STRB     R0,[R8, #+1199]
//  403   }
//  404 }
        ADD      SP,SP,#+76
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        DATA
??Process_0:
        DC32     a_Mid_H
        DC32     0x25a00
        CFI EndBlock cfiBlock6
//  405 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function Send_Data
        THUMB
//  406 void Send_Data(s16 Va, s16 Vb, u8 C_D, u16 n)  //输出显示数据
//  407 {
Send_Data:
        PUSH     {R4-R8,LR}
        CFI R14 Frame(CFA, -4)
        CFI R8 Frame(CFA, -8)
        CFI R7 Frame(CFA, -12)
        CFI R6 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
//  408   s32 Tmp, i;
//  409 
//  410   i = n*4;
        LSLS     R4,R3,#+2
//  411   if(Va >= Y_BASE+Y_SIZE)  TrackBuff[i + TRACK1] = Y_BASE+Y_SIZE-1;
        LDR.N    R5,??DataTable15  ;; TrackBuff
        CMP      R0,#+200
        BLT.N    ??Send_Data_1
        MOV      LR,#+199
        STRB     LR,[R4, R5]
        B.N      ??Send_Data_2
//  412   else if(Va <= Y_BASE+1)  TrackBuff[i + TRACK1] = Y_BASE+1;
??Send_Data_1:
        CMP      R0,#+2
        ITEE     GE 
        STRBGE   R0,[R4, R5]
        MOVLT    LR,#+1
        STRBLT   LR,[R4, R5]
//  413   else                     TrackBuff[i + TRACK1] = Va;
//  414   if(Vb >= Y_BASE+Y_SIZE)  TrackBuff[i + TRACK2] = Y_BASE+Y_SIZE-1;
??Send_Data_2:
        CMP      R1,#+200
        BLT.N    ??Send_Data_3
        ADD      LR,R4,R5
        MOVS     R6,#+199
        STRB     R6,[LR, #+1]
        B.N      ??Send_Data_4
//  415   else if(Vb <= Y_BASE+1)  TrackBuff[i + TRACK2] = Y_BASE+1;
??Send_Data_3:
        CMP      R1,#+2
        BGE.N    ??Send_Data_5
        ADD      LR,R4,R5
        MOVS     R6,#+1
        STRB     R6,[LR, #+1]
        B.N      ??Send_Data_4
//  416   else                     TrackBuff[i + TRACK2] = Vb;
??Send_Data_5:
        ADD      LR,R4,R5
        STRB     R1,[LR, #+1]
//  417   
//  418   if(C_D & 1)  TrackBuff[i + TRACK3] = c_Max;
??Send_Data_4:
        LDR.N    R6,??DataTable16  ;; Title
        TST      R2,#0x1
        ITTEE    EQ 
        LDRHEQ   R7,[R6, #+236]
        STRBEQ   R7,[LR, #+2]
        LDRHNE   R7,[R5, #+1218]
        STRBNE   R7,[LR, #+2]
//  419   else         TrackBuff[i + TRACK3] = _3_posi;
//  420   
//  421   switch (_4_source){                       
        LDRSH    R7,[R6, #+256]
        SUBS     R7,R7,#+2
        CMP      R7,#+7
        BHI.N    ??Send_Data_6
        TBB      [PC, R7]
        DATA
??Send_Data_0:
        DC8      +4,+30,+58,+67
        DC8      +75,+82,+91,+100
        THUMB
//  422   case A_add_B:
//  423     if(Interlace == 0) Tmp = Posi_412 + Va + Vb;
??Send_Data_7:
        ADD      R2,R5,#+1200
        LDRB     R2,[R2, #+0]
        CBNZ     R2,??Send_Data_8
        LDRSH    R2,[R5, #+1202]
        ADDS     R0,R0,R2
        ADD      R12,R1,R0
        B.N      ??Send_Data_9
//  424     else{
//  425       if(_1_source != HIDE) Tmp = Posi_41  + Va;
??Send_Data_8:
        LDRSH    R2,[R6, #+16]
        CBZ      R2,??Send_Data_10
        LDRSH    R2,[R5, #+1204]
        ADD      R12,R0,R2
//  426       if(_2_source != HIDE) Tmp = Posi_42  + Vb;
??Send_Data_10:
        LDRSH    R0,[R6, #+96]
        CMP      R0,#+0
        BEQ.N    ??Send_Data_9
        LDRSH    R0,[R5, #+1206]
        ADD      R12,R1,R0
        B.N      ??Send_Data_9
//  427     } break;
//  428   case A_sub_B:
//  429     if(Interlace == 0) Tmp = Posi_412 + Va - Vb;
??Send_Data_11:
        ADD      R2,R5,#+1200
        LDRB     R2,[R2, #+0]
        CBNZ     R2,??Send_Data_12
        LDRSH    R2,[R5, #+1202]
        ADDS     R0,R0,R2
        SUB      R12,R0,R1
        B.N      ??Send_Data_9
//  430     else{
//  431       if(_1_source != HIDE) Tmp = Posi_41  + Va;
??Send_Data_12:
        LDRSH    R2,[R6, #+16]
        CBZ      R2,??Send_Data_13
        LDRSH    R2,[R5, #+1204]
        ADD      R12,R0,R2
//  432       if(_2_source != HIDE) Tmp = Posi_4_2 - Vb;
??Send_Data_13:
        LDRSH    R0,[R6, #+96]
        CMP      R0,#+0
        BEQ.N    ??Send_Data_9
        ADD      R0,R5,#+1208
        LDRSH    R0,[R0, #+0]
        SUB      R12,R0,R1
        B.N      ??Send_Data_9
//  433     } break;
//  434   case C_and_D:
//  435     if((~C_D)& 3) Tmp = d_Max; 
??Send_Data_14:
        MVNS     R0,R2
        TST      R0,#0x3
        ITE      EQ 
        LDRSHEQ  R12,[R6, #+316]
        LDRSHNE  R12,[R5, #+1220]
        B.N      ??Send_Data_9
//  436     else          Tmp = _4_posi;
//  437     break;  
//  438   case C_or_D:
//  439     if(C_D & 3)   Tmp = d_Max; 
??Send_Data_15:
        TST      R2,#0x3
        ITE      EQ 
        LDRSHEQ  R12,[R6, #+316]
        LDRSHNE  R12,[R5, #+1220]
        B.N      ??Send_Data_9
//  440     else          Tmp = _4_posi;
//  441     break;  
//  442   case REC_1:
//  443     Tmp = Posi_4F1 + FileBuff[n];  
??Send_Data_16:
        LDRSH    R0,[R5, #+1210]
        LDR.N    R1,??DataTable20  ;; FileBuff
        LDRB     R1,[R3, R1]
        ADD      R12,R1,R0
        B.N      ??Send_Data_9
//  444     break;
//  445   case REC_2:
//  446     Tmp = Posi_4F2 + FileBuff[n+300];  
??Send_Data_17:
        LDRSH    R0,[R5, #+1212]
        LDR.N    R1,??DataTable20  ;; FileBuff
        ADDS     R1,R3,R1
        LDRB     R1,[R1, #+300]
        ADD      R12,R1,R0
        B.N      ??Send_Data_9
//  447     break;
//  448   case REC_3:
//  449     Tmp = Posi_4F3 + FileBuff[n+600];  
??Send_Data_18:
        LDRSH    R0,[R5, #+1214]
        LDR.N    R1,??DataTable20  ;; FileBuff
        ADDS     R1,R3,R1
        LDRB     R1,[R1, #+600]
        ADD      R12,R1,R0
        B.N      ??Send_Data_9
//  450     break;
//  451   case REC_4:
//  452     Tmp = Posi_4F4 +  FileBuff[n+900];  
??Send_Data_19:
        ADD      R0,R5,#+1216
        LDRSH    R0,[R0, #+0]
        LDR.N    R1,??DataTable20  ;; FileBuff
        ADDS     R1,R3,R1
        LDRB     R1,[R1, #+900]
        ADD      R12,R1,R0
        B.N      ??Send_Data_9
//  453     break;
//  454   default:
//  455     if(C_D & 2)  Tmp = d_Max;
??Send_Data_6:
        TST      R2,#0x2
        ITE      EQ 
        LDRSHEQ  R12,[R6, #+316]
        LDRSHNE  R12,[R5, #+1220]
//  456     else         Tmp = _4_posi;
//  457   }
//  458   if(Tmp >= Y_BASE+Y_SIZE)  TrackBuff[i + TRACK4] = Y_BASE+Y_SIZE-1;
??Send_Data_9:
        CMP      R12,#+200
        BLT.N    ??Send_Data_20
        ADDS     R0,R4,R5
        MOVS     R1,#+199
??Send_Data_21:
        STRB     R1,[R0, #+3]
        B.N      ??Send_Data_22
//  459   else if(Tmp <= Y_BASE+1)  TrackBuff[i + TRACK4] = Y_BASE+1;
??Send_Data_20:
        CMP      R12,#+2
        BGE.N    ??Send_Data_23
        ADDS     R0,R4,R5
        MOVS     R1,#+1
        B.N      ??Send_Data_21
//  460   else                      TrackBuff[i + TRACK4] = Tmp;
??Send_Data_23:
        ADDS     R0,R4,R5
        STRB     R12,[R0, #+3]
//  461 }
??Send_Data_22:
        POP      {R4-R8,PC}       ;; return
        CFI EndBlock cfiBlock7

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable15:
        DC32     TrackBuff

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable16:
        DC32     Title

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable20:
        DC32     FileBuff
//  462 /*******************************************************************************
//  463  Synchro: 扫描同步处理，按设定模式显示波形 
//  464 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function Synchro
        THUMB
//  465 void Synchro(void)  //扫描同步方式共有：AUTO、NORM、SGL、NONE、SCAN 5种模式
//  466 { 
Synchro:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//  467   u16  i;
//  468 
//  469   switch (_Mode){ 
        LDR.N    R4,??Synchro_1   ;; Title
        LDRSH    R0,[R4, #+416]
        CMP      R0,#+4
        BHI.N    ??Synchro_2
        TBB      [PC, R0]
        DATA
??Synchro_0:
        DC8      +3,+41,+70,+84
        DC8      +84,+0
        THUMB
//  470   case AUTO:
//  471     __Set(TRIGG_MODE,(_Tr_source <<3)+_Tr_kind);  // 设触发条件
??Synchro_3:
        LDRSH    R0,[R4, #+576]
        LDRSH    R1,[R4, #+596]
        ADD      R1,R1,R0, LSL #+3
        MOVS     R0,#+32
        BL       __Set
//  472     if(__Get(FIFO_START)!=0){
        MOVS     R0,#+2
        BL       __Get
        CBZ      R0,??Synchro_4
//  473       Process();                                  // 生成新的显示波形
??Synchro_5:
        BL       Process
//  474       Wait_Cnt = Wait[_T_base];
        LDRSH    R0,[R4, #+436]
        LDR.N    R1,??Synchro_1+0x4  ;; Wait
        LDRH     R0,[R1, R0, LSL #+1]
        LDR.N    R1,??Synchro_1+0x8  ;; Wait_Cnt
        STR      R0,[R1, #+0]
        B.N      ??Synchro_2
//  475     } else if(Wait_Cnt==0){
??Synchro_4:
        LDR.N    R0,??Synchro_1+0x8  ;; Wait_Cnt
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Synchro_2
//  476       if(JumpCnt >= 4095)  JumpCnt = 0;         
        LDR.N    R0,??Synchro_1+0xC  ;; TrackBuff
        LDRH     R1,[R0, #+1222]
        MOVW     R2,#+4095
        CMP      R1,R2
        BCC.N    ??Synchro_5
        MOVS     R1,#+0
        STRH     R1,[R0, #+1222]
        B.N      ??Synchro_5
//  477       Process();   
//  478       Wait_Cnt = Wait[_T_base];
//  479     } break;
//  480   case NORM:
//  481     __Set(TRIGG_MODE,(_Tr_source <<3)+_Tr_kind);  // 设触发条件
??Synchro_6:
        LDRSH    R0,[R4, #+576]
        LDRSH    R1,[R4, #+596]
        ADD      R1,R1,R0, LSL #+3
        MOVS     R0,#+32
        BL       __Set
//  482     if(__Get(FIFO_START)!=0){
        MOVS     R0,#+2
        BL       __Get
        CMP      R0,#+0
        BNE.N    ??Synchro_5
//  483       Process();                                  // 生成新的显示波形
//  484       Wait_Cnt = Wait[_T_base];
//  485     } else if(Wait_Cnt==0){
        LDR.N    R5,??Synchro_1+0x8  ;; Wait_Cnt
        LDR      R0,[R5, #+0]
        CBNZ     R0,??Synchro_2
//  486       for(i=0; i<4*X_SIZE; ++i)  TrackBuff[i] = 0;// 清除旧的显示波形
        MOV      R1,#+1200
        LDR.N    R0,??Synchro_1+0xC  ;; TrackBuff
        BL       __aeabi_memclr4
//  487       Wait_Cnt = Wait[_T_base];
        LDRSH    R0,[R4, #+436]
        LDR.N    R1,??Synchro_1+0x4  ;; Wait
        LDRH     R0,[R1, R0, LSL #+1]
        STR      R0,[R5, #+0]
        B.N      ??Synchro_2
//  488     } break;
//  489   case SGL:
//  490     __Set(TRIGG_MODE,(_Tr_source <<3)+_Tr_kind);  // 设触发条件
??Synchro_7:
        LDRSH    R0,[R4, #+576]
        LDRSH    R1,[R4, #+596]
        ADD      R1,R1,R0, LSL #+3
        MOVS     R0,#+32
        BL       __Set
//  491     if(__Get(FIFO_START)!=0)  Process();          // 生成新的显示波形
        MOVS     R0,#+2
        BL       __Get
        CBZ      R0,??Synchro_2
        B.N      ??Synchro_8
//  492     break;
//  493   case NONE:
//  494   case SCAN:
//  495     __Set(TRIGG_MODE, UNCONDITION);               // 设为无条件触发
??Synchro_9:
        MOVS     R1,#+32
        MOVS     R0,#+32
        BL       __Set
//  496     Process();                                    // 生成当前显示波形
??Synchro_8:
        BL       Process
//  497     break;
//  498   }
//  499   Draw_Window();                                  // 刷新屏幕波形显示区
??Synchro_2:
        BL       Draw_Window
//  500 
//  501   if((_Status == RUN)&&(__Get(FIFO_FULL)!=0)){    // FIFO is full
        LDRSH    R0,[R4, #+336]
        CMP      R0,#+0
        BNE.N    ??Synchro_10
        MOVS     R0,#+3
        BL       __Get
        CMP      R0,#+0
        BEQ.N    ??Synchro_10
//  502     __Set(FIFO_CLR, W_PTR);                       // FIFO写指针复位
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
//  503     Wait_Cnt = Wait[_T_base];
        LDRSH    R0,[R4, #+436]
        LDR.N    R1,??Synchro_1+0x4  ;; Wait
        LDRH     R0,[R1, R0, LSL #+1]
        LDR.N    R1,??Synchro_1+0x8  ;; Wait_Cnt
        STR      R0,[R1, #+0]
//  504     JumpCnt =0;
        LDR.N    R0,??Synchro_1+0xC  ;; TrackBuff
        MOVS     R1,#+0
        STRH     R1,[R0, #+1222]
//  505     if(_Mode == SGL){
        LDRSH    R1,[R4, #+416]
        CMP      R1,#+2
        BNE.N    ??Synchro_11
//  506       _Status = HOLD;                             // 一帧完后，进入暂停
        MOVS     R0,#+1
        STRH     R0,[R4, #+336]
//  507       _State.Flag |= UPDAT;
        ADD      R0,R4,#+338
        LDRB     R0,[R0, #+0]
        ORR      R0,R0,#0x2
        ADD      R1,R4,#+338
        STRB     R0,[R1, #+0]
        B.N      ??Synchro_10
//  508     }
//  509     if(_Mode == SCAN){
??Synchro_11:
        CMP      R1,#+4
        BNE.N    ??Synchro_10
//  510       for(i=0; i<X_SIZE; i++){                    // 重建当前轨迹基线                   
        MOVS     R1,#+75
        LDRSH    R2,[R4, #+316]
        LDRSH    R3,[R4, #+236]
        LDRSH    R12,[R4, #+156]
        LDRSH    LR,[R4, #+76]
//  511         TrackBuff[i*4 + TRACK1] = _1_posi;
??Synchro_12:
        STRB     LR,[R0], #+1
//  512         TrackBuff[i*4 + TRACK2] = _2_posi; 
        STRB     R12,[R0], #+1
//  513         TrackBuff[i*4 + TRACK3] = _3_posi; 
        STRB     R3,[R0], #+1
//  514         TrackBuff[i*4 + TRACK4] = _4_posi;
        STRB     R2,[R0], #+1
        STRB     LR,[R0], #+1
        STRB     R12,[R0], #+1
        STRB     R3,[R0], #+1
        STRB     R2,[R0], #+1
        STRB     LR,[R0], #+1
        STRB     R12,[R0], #+1
        STRB     R3,[R0], #+1
        STRB     R2,[R0], #+1
        STRB     LR,[R0], #+1
        STRB     R12,[R0], #+1
        STRB     R3,[R0], #+1
        STRB     R2,[R0], #+1
//  515       }
        SUBS     R1,R1,#+1
        BNE.N    ??Synchro_12
//  516     }
//  517   }    
//  518 }  
??Synchro_10:
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        DATA
??Synchro_1:
        DC32     Title
        DC32     Wait
        DC32     Wait_Cnt
        DC32     TrackBuff
        CFI EndBlock cfiBlock8

        END
//  519 /******************************** END OF FILE *********************************/
// 
// 16 449 bytes in section .bss
//  1 945 bytes in section .data
//     56 bytes in section .rodata
//  3 644 bytes in section .text
// 
//  3 644 bytes of CODE  memory
//     56 bytes of CONST memory
// 18 394 bytes of DATA  memory
//
//Errors: none
//Warnings: none
