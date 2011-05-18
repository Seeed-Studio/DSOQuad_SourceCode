///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  13:45:44 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\APP_V2.32\source\Process.c                    /
//    Command line =  E:\DS0203\APP_V2.32\source\Process.c -lA                /
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
//    List file    =  E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\Process.s       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Process

        EXTERN Current
        EXTERN Delayms
        EXTERN Draw_Window
        EXTERN FileBuff
        EXTERN Get_Ref_Wave
        EXTERN Int_sqrt
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

        PUBLIC A_Max
        PUBLIC A_Min
        PUBLIC A_Rms
        PUBLIC A_Tab
        PUBLIC A_Vdc
        PUBLIC A_Vpp
        PUBLIC App_init
        PUBLIC B_Max
        PUBLIC B_Min
        PUBLIC B_Rms
        PUBLIC B_Vdc
        PUBLIC B_Vpp
        PUBLIC CH_D_Data
        PUBLIC Ch
        PUBLIC D_Tab
        PUBLIC DataBuf
        PUBLIC Full
        PUBLIC G_Attr
        PUBLIC Interlace
        PUBLIC JumpCnt
        PUBLIC Ka1
        PUBLIC Ka2
        PUBLIC Ka3
        PUBLIC Kb1
        PUBLIC Kb2
        PUBLIC Kb3
        PUBLIC Process
        PUBLIC SAW_DATA
        PUBLIC SIN_DATA
        PUBLIC Synchro
        PUBLIC TRG_DATA
        PUBLIC T_Attr
        PUBLIC Tmp
        PUBLIC TrackBuff
        PUBLIC Update_Base
        PUBLIC Update_Output
        PUBLIC Update_Range
        PUBLIC Update_Trig
        PUBLIC V
        PUBLIC View_init
        PUBLIC Wait
        PUBLIC X_Attr
        PUBLIC Y_Attr
        PUBLIC a_Avg
        PUBLIC a_Ssq
        PUBLIC a_max
        PUBLIC a_min
        PUBLIC b_Avg
        PUBLIC b_Ssq
        PUBLIC b_max
        PUBLIC b_min
        PUBLIC n
        
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
        
// E:\DS0203\APP_V2.32\source\Process.c
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
//   13 u32 a_Avg, b_Avg, a_Ssq, b_Ssq;            // 统计用中间变量
//   14 u8  a_max, b_max, a_min, b_min;            // 统计用中间变量
//   15 s16 A_Vdc, A_Vpp, A_Max, A_Min, A_Rms;     // 计量结果
//   16 s16 B_Vdc, B_Vpp, B_Max, B_Min, B_Rms;     
//   17 u8  Ch[4], V[8];
//   18 s32 Tmp;
//   19 
//   20 u16  JumpCnt, n;
//   21 u8   Full=1, Interlace;
//   22 

        SECTION `.rodata`:CONST:NOROOT(2)
//   23 uc16 Wait[27]= {1000, 500, 200, 100, 50, 20, 10, 5, 2, 2,   
Wait:
        DATA
        DC16 1000, 500, 200, 100, 50, 20, 10, 5, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
        DC16 2, 2, 2, 2, 2, 2, 2, 2, 2
        DC8 0, 0

        SECTION `.bss`:DATA:NOROOT(2)
Tmp:
        DS8 4
//   24                 2,      2,   2,   2,  2,  2,  2, 2, 2, 2,    
//   25                 2,      2,   2,   2,  2,  2,  2 };
//   26                      
//   27 Y_attr *Y_Attr; 
//   28 X_attr *X_Attr; 
//   29 G_attr *G_Attr; 
//   30 T_attr *T_Attr; 
//   31 
//   32 u32  DataBuf[4096];
DataBuf:
        DS8 16384

        SECTION `.bss`:DATA:NOROOT(2)
Y_Attr:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
T_Attr:
        DS8 4

        SECTION `.data`:DATA:NOROOT(2)
//   33 u8  TrackBuff  [X_SIZE * 4];         // 曲线轨迹缓存：i+0,i+1,i+2,i+3,分别存放1～4号轨迹数据
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
V:
        DC8 0, 0, 0, 0, 0, 0, 0, 0
Ch:
        DC8 0, 0, 0, 0
a_max:
        DC8 0
b_max:
        DC8 0
a_min:
        DC8 0
b_min:
        DC8 0
Interlace:
        DC8 0
        DC8 0
A_Vdc:
        DC8 0, 0
A_Vpp:
        DC8 0, 0
A_Max:
        DC8 0, 0
A_Min:
        DC8 0, 0
A_Rms:
        DC8 0, 0
B_Vdc:
        DC8 0, 0
B_Vpp:
        DC8 0, 0
B_Max:
        DC8 0, 0
B_Min:
        DC8 0, 0
B_Rms:
        DC8 0, 0
JumpCnt:
        DC8 0, 0
n:
        DC8 0, 0
//   34 
//   35 s8  Ka1[10] ={   0,    0,    0,    0,    0,    0,    0,    0,    0,    0}; // A通道零点误差校正系数
//   36 s8  Kb1[10] ={   0,    0,    0,    0,    0,    0,    0,    0,    0,    0}; // B通道零点误差校正系数
//   37 u16 Ka2[10] ={1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024}; // A通道增益误差校正系数
//   38 u16 Kb2[10] ={1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024}; // B通道增益误差校正系数
//   39 u16 Ka3 = 256, Kb3 = 256;                                                // A B通道位移误差校正系数
Ka3:
        DC16 256
Kb3:
        DC16 256
        DC8 0, 0
a_Avg:
        DC8 0, 0, 0, 0
b_Avg:
        DC8 0, 0, 0, 0
a_Ssq:
        DC8 0, 0, 0, 0
b_Ssq:
        DC8 0, 0, 0, 0
X_Attr:
        DC8 0, 0, 0, 0
G_Attr:
        DC8 0, 0, 0, 0
Ka1:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Kb1:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Ka2:
        DC16 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024
Kb2:
        DC16 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024

        SECTION `.data`:DATA:NOROOT(0)
Full:
        DATA
        DC8 1
//   40 

        SECTION `.data`:DATA:NOROOT(2)
//   41 D_tab D_Tab[20] ={  // 脉冲波形输出驱动表, 基于72MHz主频
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
//   42 //    STR      PSC     ARR       DUTY% 
//   43   {" 10Hz ",  180-1,  40000-1,     50},
//   44   {" 20Hz ",  180-1,  20000-1,     50},
//   45   {" 50Hz ",  180-1,   8000-1,     50},
//   46   {"!100Hz!", 180-1,   4000-1,     50},
//   47   {"!200Hz!", 180-1,   2000-1,     50},
//   48   {"!500Hz!", 180-1,    800-1,     50},
//   49   {" 1KHz ",  180-1,    400-1,     50},
//   50   {" 2KHz ",  180-1,    200-1,     50},
//   51   {" 5KHz ",   18-1,    800-1,     50},
//   52   {"!10KHz!",  18-1,    400-1,     50},
//   53   {"!20KHz!",  18-1,    200-1,     50},
//   54   {"!50KHz!",   1-1,   1440-1,     50},
//   55   {"100KHz",    1-1,    720-1,     50},
//   56   {"200KHz",    1-1,    360-1,     50},
//   57   {"500KHz",    1-1,    144-1,     50},
//   58   {" 1MHz ",    1-1,     72-1,     50},
//   59   {" 2MHz ",    1-1,     36-1,     50},
//   60   {" 4MHz ",    1-1,     18-1,     50},
//   61   {" 6MHz ",    1-1,     12-1,     50},
//   62   {" 8MHz ",    1-1,      9-1,     50}};
//   63 
//   64 A_tab A_Tab[11] ={ // 模拟波形输出驱动表, 基于72MHz主频, 每周期36点合成
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
//   65 //    STR     PSC     ARR 
//   66   {" 10Hz ",  20-1,  10000-1},
//   67   {" 20Hz ",  20-1,   5000-1},
//   68   {" 50Hz ",  20-1,   2000-1},
//   69   {"!100Hz!", 20-1,   1000-1},
//   70   {"!200Hz!", 20-1,    500-1},
//   71   {"!500Hz!", 20-1,    200-1},
//   72   {" 1KHz ",  20-1,    100-1},
//   73   {" 2KHz ",  20-1,     50-1},
//   74   {" 5KHz ",  20-1,     20-1},
//   75   {"!10KHz!", 20-1,     10-1},
//   76   {"!20KHz!", 20-1,      5-1}};
//   77 
//   78 u16 SIN_DATA[36] =  // Sine wave data                                                                                                 //         
SIN_DATA:
        DC16 0, 39, 142, 304, 521, 785, 1089, 1423, 1776, 2138, 2496, 2841
        DC16 3161, 3446, 3688, 3878, 4011, 4083, 4095, 4055, 3952, 3790, 3573
        DC16 3309, 3005, 2671, 2318, 1956, 1598, 1253, 933, 648, 406, 216, 83
        DC16 11
//   79   {0x000,0x027,0x08E,0x130,0x209,0x311,0x441,0x58F,0x6F0,    // 90
//   80    0x85A,0x9C0,0xB19,0xC59,0xD76,0xE68,0xF26,0xFAB,0xFF3,    // 180
//   81    0xFFF,0xFD7,0xF70,0xECE,0xDF5,0xCED,0xBBD,0xA6F,0x90E,    // 270
//   82    0x7A4,0x63E,0x4E5,0x3A5,0x288,0x196,0x0D8,0x053,0x00B,};  // 360   
//   83 
//   84 u16 TRG_DATA[36] =  // triangle wave data
TRG_DATA:
        DC16 0, 227, 454, 682, 909, 1137, 1364, 1592, 1819, 2047, 2274, 2502
        DC16 2729, 2957, 3184, 3412, 3639, 3867, 4094, 3867, 3639, 3412, 3184
        DC16 2957, 2729, 2502, 2274, 2047, 1819, 1592, 1364, 1137, 909, 682
        DC16 454, 227
//   85   {0x000,0x0E3,0x1C6,0x2AA,0x38D,0x471,0x554,0x638,0x71B,    // 90
//   86    0x7FF,0x8E2,0x9C6,0xAA9,0xB8D,0xC70,0xD54,0xE37,0xF1B,    // 180
//   87    0xFFE,0xF1B,0xE37,0xD54,0xC70,0xB8D,0xAA9,0x9C6,0x8E2,    // 270
//   88    0x7FF,0x71B,0x638,0x554,0x471,0x38D,0x2AA,0x1C6,0x0E3};   // 360			
//   89          
//   90 u16 SAW_DATA[36] =  // Sawtooth wave data                                                                                             //         
SAW_DATA:
        DC16 0, 117, 234, 351, 468, 585, 702, 819, 936, 1053, 1170, 1287, 1404
        DC16 1521, 1638, 1755, 1872, 1989, 2106, 2223, 2340, 2457, 2574, 2691
        DC16 2808, 2925, 3042, 3159, 3276, 3393, 3510, 3627, 3744, 3861, 3978
        DC16 4095
//   91   {0x000,0x075,0x0EA,0x15F,0x1D4,0x249,0x2BE,0x333,0x3A8,    // 90
//   92    0x41D,0x492,0x507,0x57C,0x5F1,0x666,0x6DB,0x750,0x7C5,    // 180
//   93    0x83A,0x8AF,0x924,0x999,0xA0E,0xA83,0xAF8,0xB6D,0xBE2,    // 270
//   94    0xC57,0xCCC,0xD41,0xDB6,0xE2B,0xEA0,0xF15,0xF8A,0xFFF};   // 360    
//   95 
//   96 
//   97 /*******************************************************************************
//   98  App_init: 显示窗口波形数据初始化
//   99 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function App_init
        THUMB
//  100 void App_init(void)
//  101 { 
App_init:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  102   u16 i, j;
//  103   __Set(ADC_CTRL, EN );       
        MOVS     R1,#+1
        MOVS     R0,#+36
        BL       __Set
//  104   __Set(STANDBY, DN);          // 退出省电状态
        MOVS     R1,#+0
        MOVS     R0,#+20
        BL       __Set
//  105   __Clear_Screen(BLACK);       // 清屏幕
        MOVS     R0,#+0
        BL       __Clear_Screen
//  106   Delayms(20); 
        MOVS     R0,#+20
        BL       Delayms
//  107   __Set(FIFO_CLR, W_PTR); 
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
//  108   for(i=0; i<13; i++) for(j=0; j<4; j++) Title[i][j].Flag |= UPDAT;
        LDR.W    R0,??DataTable21  ;; Title
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
//  109   for(i=0; i<9; i++)                     Meter[i].Flag    |= UPDAT;
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
//  110   if(Current != FILE) {
        LDR.N    R1,??App_init_1+0x4  ;; Current
        LDRB     R1,[R1, #+0]
        CMP      R1,#+9
        BEQ.N    ??App_init_3
//  111     Title[FILE][0].Flag &= !UPDAT;
        MOVS     R1,#+0
        STRB     R1,[R0, #+738]
//  112     Title[FILE][1].Flag &= !UPDAT;
        STRB     R1,[R0, #+758]
//  113     Title[FILE][3].Flag &= !UPDAT;
        STRB     R1,[R0, #+798]
//  114   }  
//  115   PD_Cnt = 600;
??App_init_3:
        LDR.N    R0,??App_init_1+0x8  ;; PD_Cnt
        MOV      R1,#+600
        STRH     R1,[R0, #+0]
//  116   Update = 1;                  // 返回后恢复原来的档位设置
        LDR.N    R0,??App_init_1+0xC  ;; Update
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  117 }
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
//  118 /*******************************************************************************
//  119  View_init: 显示窗口波形数据初始化
//  120 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function View_init
        THUMB
//  121 void View_init(void)
//  122 { 
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
//  123   u16 i, j = 0, k = 0;
        MOVS     R4,#+0
        MOVS     R5,#+0
//  124   for(i = 0; i < X_SIZE * 4; i += 4){
        MOV      R9,R4
        LDR.W    R6,??DataTable32  ;; TrackBuff
        MOVS     R7,#+17
        MOV      R8,#+160
//  125     TrackBuff[i] = 160;
??View_init_0:
        MOVS     R0,#+160
        STRB     R0,[R6, #+0]
//  126     TrackBuff[i+1] = Get_Ref_Wave(i/4);
        LSL      R0,R9,#+16
        LSRS     R0,R0,#+18
        BL       Get_Ref_Wave
        STRB     R0,[R6, #+1]
//  127     if((i%160)==0) j = 1 - j;
        SDIV     R0,R9,R8
        MLS      R0,R0,R8,R9
        CBNZ     R0,??View_init_1
        RSB      R4,R4,#+1
        UXTH     R4,R4
//  128     TrackBuff[i+2] = 60 + (j * 17);
??View_init_1:
        MOVS     R0,#+60
        MLA      R0,R4,R7,R0
        STRB     R0,[R6, #+2]
//  129     if((i%64)==0) k = 1 - k;
        LSL      R0,R9,#+16
        LSRS     R0,R0,#+22
        SUBS     R0,R9,R0, LSL #+6
        ITT      EQ 
        RSBEQ    R5,R5,#+1
        UXTHEQ   R5,R5
//  130     TrackBuff[i+3] = 20 + (k * 17);
        MOVS     R0,#+20
        MLA      R0,R5,R7,R0
        STRB     R0,[R6, #+3]
//  131   }
        ADD      R9,R9,#+4
        ADDS     R6,R6,#+4
        MOV      R1,#+1200
        UXTH     R0,R9
        CMP      R0,R1
        BCC.N    ??View_init_0
//  132 }
        ADD      SP,SP,#+4
        CFI CFA R13+28
        POP      {R4-R9,PC}       ;; return
        CFI EndBlock cfiBlock1
//  133 /*******************************************************************************
//  134  Update_Range: 
//  135 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Update_Range
        THUMB
//  136 void Update_Range(void) 
//  137 {
Update_Range:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//  138   Interlace = 0;
        LDR.W    R4,??DataTable32  ;; TrackBuff
        ADD      R0,R4,#+1216
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  139   __Set(ADC_MODE, SEPARATE);                        // Set Separate mode
        MOVS     R0,#+5
        BL       __Set
//  140   __Set(CH_A_COUPLE, Title[TRACK1][COUPLE].Value);
        LDR.W    R5,??DataTable21  ;; Title
        LDRSH    R1,[R5, #+36]
        MOVS     R0,#+9
        BL       __Set
//  141   __Set(CH_A_RANGE,  Title[TRACK1][RANGE].Value);
        LDRSH    R1,[R5, #+56]
        MOVS     R0,#+10
        BL       __Set
//  142   __Set(CH_A_OFFSET, (Ka3 * Title[TRACK1][POSI].Value)/256);
        LDRH     R0,[R4, #+1242]
        LDRSH    R1,[R5, #+76]
        MULS     R0,R0,R1
        ASRS     R1,R0,#+7
        ADD      R0,R0,R1, LSR #+24
        ASRS     R1,R0,#+8
        MOVS     R0,#+0
        BL       __Set
//  143   if(_1_source == HIDE){
        LDRSH    R0,[R5, #+16]
        CBNZ     R0,??Update_Range_0
//  144     if(_T_base > 16){
        LDRSH    R0,[R5, #+436]
        CMP      R0,#+17
        BLT.N    ??Update_Range_0
//  145       __Set(CH_A_RANGE, G_Attr[0].Yp_Max+1);        // A通道合并到B通道 
        LDR      R0,[R4, #+1268]
        LDRH     R0,[R0, #+4]
        ADDS     R1,R0,#+1
        MOVS     R0,#+10
        BL       __Set
//  146       __Set(ADC_MODE, INTERLACE);                   // Set Interlace mode
        MOVS     R1,#+1
        MOVS     R0,#+5
        BL       __Set
//  147       Interlace = 1;                      
        ADD      R0,R4,#+1216
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  148     }  
//  149   }
//  150   __Set(CH_B_COUPLE, Title[TRACK2][COUPLE].Value);
??Update_Range_0:
        LDRSH    R1,[R5, #+116]
        MOVS     R0,#+11
        BL       __Set
//  151   __Set(CH_B_RANGE,  Title[TRACK2][RANGE].Value);
        LDRSH    R1,[R5, #+136]
        MOVS     R0,#+12
        BL       __Set
//  152   __Set(CH_B_OFFSET, (Kb3 * Title[TRACK2][POSI].Value)/256);
        LDRH     R0,[R4, #+1244]
        LDRSH    R1,[R5, #+156]
        MULS     R0,R0,R1
        ASRS     R1,R0,#+7
        ADD      R0,R0,R1, LSR #+24
        ASRS     R1,R0,#+8
        MOVS     R0,#+1
        BL       __Set
//  153   if(_2_source == HIDE){
        LDRSH    R0,[R5, #+96]
        CBNZ     R0,??Update_Range_1
//  154     if(_T_base > 16){
        LDRSH    R0,[R5, #+436]
        CMP      R0,#+17
        BLT.N    ??Update_Range_1
//  155       __Set(CH_B_RANGE,  G_Attr[0].Yp_Max+1);      // B通道合并到A通道
        LDR      R0,[R4, #+1268]
        LDRH     R0,[R0, #+4]
        ADDS     R1,R0,#+1
        MOVS     R0,#+12
        BL       __Set
//  156       __Set(ADC_MODE, INTERLACE);                  // Set Interlace mode
        MOVS     R1,#+1
        MOVS     R0,#+5
        BL       __Set
//  157       Interlace = 2;                        
        ADD      R0,R4,#+1216
        MOVS     R1,#+2
        STRB     R1,[R0, #+0]
//  158     }
//  159   } 
//  160   if(_Status == RUN) __Set(FIFO_CLR, W_PTR);       // FIFO写指针复位
??Update_Range_1:
        LDRSH    R0,[R5, #+336]
        CBNZ     R0,??Update_Range_2
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
//  161 }
??Update_Range_2:
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        CFI EndBlock cfiBlock2
//  162 /*******************************************************************************
//  163  Update_Base: 
//  164 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Update_Base
        THUMB
//  165 void Update_Base(void) 
//  166 {
Update_Base:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
//  167   u16 i;
//  168   
//  169   __Set(ADC_CTRL, EN);       
        MOVS     R1,#+1
        MOVS     R0,#+36
        BL       __Set
//  170   i = Title[T_BASE][BASE].Value;
        LDR.W    R4,??DataTable21  ;; Title
        LDRSH    R0,[R4, #+436]
        UXTH     R0,R0
//  171   __Set(T_BASE_PSC, X_Attr[i].PSC);
        MOVS     R1,#+20
        MUL      R5,R0,R1
        LDR.W    R6,??DataTable32  ;; TrackBuff
        ADD      R0,R6,#+1264
        LDR      R0,[R0, #+0]
        ADDS     R0,R5,R0
        LDRSH    R1,[R0, #+8]
        MOVS     R0,#+7
        BL       __Set
//  172   __Set(T_BASE_ARR, X_Attr[i].ARR);
        ADD      R0,R6,#+1264
        LDR      R0,[R0, #+0]
        ADDS     R0,R5,R0
        LDRH     R1,[R0, #+10]
        MOVS     R0,#+8
        BL       __Set
//  173   Wait_Cnt = Wait[_T_base];
        LDRSH    R0,[R4, #+436]
        LDR.W    R1,??DataTable29  ;; Wait
        LDRH     R0,[R1, R0, LSL #+1]
        LDR.W    R1,??DataTable30  ;; Wait_Cnt
        STR      R0,[R1, #+0]
//  174   if(_Status == RUN) __Set(FIFO_CLR, W_PTR);      // FIFO写指针复位
        LDRSH    R0,[R4, #+336]
        CBNZ     R0,??Update_Base_0
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
//  175 }
??Update_Base_0:
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock3
//  176 /*******************************************************************************
//  177  Update_Output: 
//  178 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Update_Output
        THUMB
//  179 void Update_Output(void) 
//  180 {
Update_Output:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
//  181   if(_Kind == SINE){
        LDR.W    R4,??DataTable21  ;; Title
        LDRSH    R0,[R4, #+496]
        CBNZ     R0,??Update_Output_0
//  182     __Set(ANALOG_CNT, 36);
        MOVS     R1,#+36
        MOVS     R0,#+15
        BL       __Set
//  183     (*((vu32 *)(0x40020400+0x50))) = (u32)&SIN_DATA[0];
        LDR.N    R5,??Update_Output_1  ;; D_Tab
        ADD      R0,R5,#+412
        LDR.N    R1,??Update_Output_1+0x4  ;; 0x40020450
        STR      R0,[R1, #+0]
//  184     __Set(ANALOG_ARR, A_Tab[_Frqn].ARR);
        LDRSH    R0,[R4, #+516]
        MOVS     R1,#+12
        MLA      R0,R0,R1,R5
        ADD      R0,R0,#+290
        LDRH     R1,[R0, #+0]
        MOVS     R0,#+13
        BL       __Set
//  185   }
//  186   if(_Kind == SAW){
??Update_Output_0:
        LDRSH    R0,[R4, #+496]
        CMP      R0,#+2
        BNE.N    ??Update_Output_2
//  187     __Set(ANALOG_ARR, A_Tab[_Frqn].ARR);
        LDR.N    R5,??Update_Output_1  ;; D_Tab
        LDRSH    R0,[R4, #+516]
        MOVS     R1,#+12
        MLA      R0,R0,R1,R5
        ADD      R0,R0,#+290
        LDRH     R1,[R0, #+0]
        MOVS     R0,#+13
        BL       __Set
//  188     (*((vu32 *)(0x40020400+0x50))) = (u32)&SAW_DATA[0];
        ADD      R0,R5,#+556
        LDR.N    R1,??Update_Output_1+0x4  ;; 0x40020450
        STR      R0,[R1, #+0]
//  189     __Set(ANALOG_CNT, 36);
        MOVS     R1,#+36
        MOVS     R0,#+15
        BL       __Set
//  190   }
//  191   if(_Kind == TRIANG){
??Update_Output_2:
        LDRSH    R0,[R4, #+496]
        CMP      R0,#+1
        BNE.N    ??Update_Output_3
//  192     __Set(ANALOG_ARR, A_Tab[_Frqn].ARR);
        LDR.N    R5,??Update_Output_1  ;; D_Tab
        LDRSH    R0,[R4, #+516]
        MOVS     R1,#+12
        MLA      R0,R0,R1,R5
        ADD      R0,R0,#+290
        LDRH     R1,[R0, #+0]
        MOVS     R0,#+13
        BL       __Set
//  193     (*((vu32 *)(0x40020400+0x50))) = (u32)&TRG_DATA[0];
        ADD      R0,R5,#+484
        LDR.N    R1,??Update_Output_1+0x4  ;; 0x40020450
        STR      R0,[R1, #+0]
//  194     __Set(ANALOG_CNT, 36);
        MOVS     R1,#+36
        MOVS     R0,#+15
        BL       __Set
//  195   }
//  196   if(_Kind == DIGI){
??Update_Output_3:
        LDRSH    R0,[R4, #+496]
        CMP      R0,#+3
        BNE.N    ??Update_Output_4
//  197     __Set(DIGTAL_PSC, D_Tab[_Frqn].PSC);
        MOVS     R6,#+14
        LDR.N    R5,??Update_Output_1  ;; D_Tab
        LDRSH    R0,[R4, #+516]
        MLA      R0,R0,R6,R5
        LDRH     R1,[R0, #+8]
        MOVS     R0,#+16
        BL       __Set
//  198     __Set(DIGTAL_ARR, D_Tab[_Frqn].ARR);
        LDRSH    R0,[R4, #+516]
        MLA      R0,R0,R6,R5
        LDRH     R1,[R0, #+10]
        MOVS     R0,#+17
        BL       __Set
//  199     __Set(DIGTAL_CCR, (D_Tab[_Frqn].ARR+1)/2);
        LDRSH    R0,[R4, #+516]
        MLA      R0,R0,R6,R5
        LDRH     R0,[R0, #+10]
        ADDS     R0,R0,#+1
        ADD      R0,R0,R0, LSR #+31
        ASRS     R1,R0,#+1
        MOVS     R0,#+18
        BL       __Set
//  200   }
//  201 }
??Update_Output_4:
        POP      {R4-R6,PC}       ;; return
        Nop      
        DATA
??Update_Output_1:
        DC32     D_Tab
        DC32     0x40020450
        CFI EndBlock cfiBlock4
//  202 /*******************************************************************************
//  203  Update_Trig: 
//  204 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function Update_Trig
        THUMB
//  205 void Update_Trig(void) 
//  206 { 
Update_Trig:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  207   if(T1 > T2)  __Set(T_THRESHOLD, (_T1 - _T2));  
//  208   else         __Set(T_THRESHOLD, (_T2 - _T1)); 
        LDR.W    R4,??DataTable21  ;; Title
        LDRSH    R0,[R4, #+836]
        LDRSH    R1,[R4, #+816]
        SUBS     R1,R0,R1
        MOVS     R0,#+34
        BL       __Set
//  209   __Set(TRIGG_MODE,  (_Tr_source<< 3)+_Tr_kind);
        LDRSH    R0,[R4, #+576]
        LDRSH    R1,[R4, #+596]
        ADD      R1,R1,R0, LSL #+3
        MOVS     R0,#+32
        BL       __Set
//  210   if(Title[TRIGG][SOURCE].Value == TRACK1){ 
        LDRSH    R0,[R4, #+576]
        CBNZ     R0,??Update_Trig_0
        LDRSH    R1,[R4, #+56]
        LDR.W    R0,??DataTable32  ;; TrackBuff
        LDR.N    R2,??Update_Trig_1  ;; V_Trigg
        LDRSH    R2,[R2, #+0]
        ADDS     R3,R1,R0
        ADD      R3,R3,#+1272
        LDRSB    R3,[R3, #+0]
        SUBS     R2,R2,R3
        LSLS     R2,R2,#+10
        ADD      R0,R0,R1, LSL #+1
        ADD      R0,R0,#+1296
        LDRH     R0,[R0, #+0]
        SDIV     R0,R2,R0
        UXTB     R1,R0
        MOVS     R0,#+33
//  211     __Set(V_THRESHOLD, (((_Vt1-Ka1[_A_Range])*1024)/Ka2[_A_Range])&0xFF); 
        BL       __Set
//  212   }
//  213   if(Title[TRIGG][SOURCE].Value == TRACK2){ 
??Update_Trig_0:
        LDRSH    R0,[R4, #+576]
        CMP      R0,#+1
        BNE.N    ??Update_Trig_2
        LDRSH    R1,[R4, #+136]
        LDR.W    R0,??DataTable32  ;; TrackBuff
        LDR.N    R2,??Update_Trig_1  ;; V_Trigg
        LDRSH    R2,[R2, #+4]
        ADDS     R3,R1,R0
        LDRSB    R3,[R3, #+1284]
        SUBS     R2,R2,R3
        LSLS     R2,R2,#+10
        ADD      R0,R0,R1, LSL #+1
        LDRH     R0,[R0, #+1316]
        SDIV     R0,R2,R0
        UXTB     R1,R0
        MOVS     R0,#+33
//  214     __Set(V_THRESHOLD, (((_Vt2-Kb1[_B_Range])*1024)/Kb2[_B_Range])&0xFF); 
        BL       __Set
//  215   }
//  216   if(_Status == RUN) __Set(FIFO_CLR, W_PTR);      // FIFO写指针复位
??Update_Trig_2:
        LDRSH    R0,[R4, #+336]
        CBNZ     R0,??Update_Trig_3
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
//  217 }
??Update_Trig_3:
        POP      {R4,PC}          ;; return
        DATA
??Update_Trig_1:
        DC32     V_Trigg
        CFI EndBlock cfiBlock5
//  218 /*******************************************************************************
//  219  Process: 计算处理缓冲区数据 
//  220 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function Process
        THUMB
//  221 void Process(void)
//  222 { 
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
        SUB      SP,SP,#+20
        CFI CFA R13+56
//  223   s16 i, j, k;
//  224   
//  225   n= 0;
        LDR.W    R4,??DataTable32  ;; TrackBuff
        ADD      R0,R4,#+1240
        MOVS     R1,#+0
        STRH     R1,[R0, #+0]
        LDR.W    R5,??DataTable21  ;; Title
        LDRSH    R0,[R5, #+436]
        MOVS     R1,#+20
        ADD      R2,R4,#+1264
        LDR      R2,[R2, #+0]
        MLA      R0,R0,R1,R2
        LDRH     R0,[R0, #+14]
        RSB      R0,R0,#+1024
        MOVS     R1,#+150
        MULS     R0,R0,R1
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        LDRH     R1,[R5, #+456]
        ADD      R0,R1,R0, ASR #+10
        SXTH     R0,R0
        STR      R0,[SP, #+12]
//  226   k =((1024 -_Kp)* 150)/1024 + _X_posi.Value;  // 计算插值运算后窗口位置的修正值
//  227   a_Avg =0; b_Avg =0; a_Ssq =0; b_Ssq =0;      // 统计用中间变量
        ADD      R0,R4,#+1248
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        MOVS     R0,#+0
        STR      R0,[R4, #+1252]
        ADD      R0,R4,#+1256
        STR      R1,[R0, #+0]
        MOV      R0,R1
        STR      R0,[R4, #+1260]
//  228   a_max =0; b_max =0; a_min =255; b_min =255;  // 统计用中间变量
        STRB     R0,[R4, #+1212]
        STRB     R0,[R4, #+1213]
        MOVS     R0,#+255
        STRB     R0,[R4, #+1214]
        STRB     R0,[R4, #+1215]
//  229 
//  230   if(Interlace == 0){                          // 独立采样模式
        LDR      R1,[SP, #+12]
        RSBS     R0,R1,#+0
        SXTH     R0,R0
        ADD      R1,R4,#+1216
        LDRB     R1,[R1, #+0]
        CMP      R1,#+0
        BNE.W    ??Process_0
//  231     for(i=0; i <4096; i++){
        MOVS     R6,#+0
        STR      R0,[SP, #+8]
        LDR.W    R0,??Process_1   ;; Tmp + 4
        STR      R0,[SP, #+0]
        B.N      ??Process_2
//  232       if((__Get(FIFO_EMPTY)==0)&&(i == JumpCnt)&&(_Status == RUN)){
//  233         JumpCnt++;
//  234         DataBuf[i] = __Read_FIFO();             // 读入32位FIFO数据, 读后指针+1
//  235       }
//  236       Ch[A] = (DataBuf[i] & 0xFF );              
//  237       a_Avg += Ch[A];                           // 累计直流平均值              
//  238       Tmp = Ch[A]-_1_posi;
//  239       a_Ssq +=(Tmp * Tmp);                      // 统计平方和
//  240       if(Ch[A] > a_max)  a_max = Ch[A];         // 统计最大值  
//  241       if(Ch[A] < a_min)  a_min = Ch[A];         // 统计最小值  
//  242   
//  243       Ch[B] = ((DataBuf[i] >> 8) & 0xFF);       
//  244       b_Avg += Ch[B];                           // 累计直流平均值
//  245       Tmp = Ch[B]-_2_posi;
//  246       b_Ssq +=(Tmp * Tmp);                      // 统计平方和
//  247       if(Ch[B] > b_max)  b_max = Ch[B];         // 统计最大值  
//  248       if(Ch[B] < b_min)  b_min = Ch[B];         // 统计最小值  
//  249   
//  250       Ch[C] = ((DataBuf[i] >>16)& 1);
//  251       Ch[D] = ((DataBuf[i] >>17)& 1);
//  252     
//  253       if((i > k)&&(n < 300-1)){                 // 指针到达指定窗口位置
//  254         j =i-k;
//  255         V[A]  = Ka1[_A_Range] +(Ka2[_A_Range] *Ch[A])/1024;      
//  256         V[B]  = Kb1[_B_Range] +(Kb2[_B_Range] *Ch[B])/1024;      //计算当前点的主值
//  257         while(j*1024 - n*_Kp > 0 ){
//  258           V[Ap]= V[A_]+((V[A]-V[A_])*((n *_Kp)-(j-1)*1024))/1024;  //计算当前CH_A点的插值
//  259           TrackBuff[n*4 + TRACK1] = V[Ap];
//  260           
//  261           V[Bp]= V[B_]+((V[B]-V[B_])*((n *_Kp)-(j-1)*1024))/1024;  //计算当前CH_B点的插值
//  262           TrackBuff[n*4 + TRACK2] = V[Bp];
//  263           
//  264           Tmp = _3_posi + 20 * Ch[C];
//  265           if(Tmp >= Y_BASE+Y_SIZE)  Tmp = Y_BASE+Y_SIZE-1;
//  266           else if(Tmp <= Y_BASE+1)  Tmp = Y_BASE+1;
??Process_3:
        CMP      R0,#+2
        IT       LT 
        MOVLT    R0,#+1
??Process_4:
        LDR.W    R1,??Process_1+0x4  ;; Tmp
        STR      R0,[R1, #+0]
//  267           TrackBuff[n*4 + TRACK3] = Tmp;
        STRB     R0,[R7, #+2]
//  268           
//  269           TrackBuff[n*4 + TRACK4] = CH_D_Data(); 
        BL       CH_D_Data
        STRB     R0,[R7, #+3]
//  270           n++;
        ADD      R0,R8,#+1
        ADD      R1,R4,#+1240
        STRH     R0,[R1, #+0]
//  271         V[A_] = V[A];  V[B_] = V[B];       
        ADD      R1,R4,#+1200
        LDRB     R1,[R1, #+0]
        STRB     R1,[R4, #+1202]
        STRB     R10,[R4, #+1203]
        LSL      R1,R11,#+10
        UXTH     R0,R0
        LDRH     R2,[R9, #+14]
        MLS      R0,R0,R2,R1
        CMP      R0,#+1
        BGE.W    ??Process_5
??Process_6:
        ADDS     R6,R6,#+1
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,#+4
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+8]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+8]
        CMP      R6,#+4096
        BGE.W    ??Process_7
??Process_2:
        MOVS     R0,#+1
        BL       __Get
        CBNZ     R0,??Process_8
        LDRH     R0,[R4, #+1238]
        CMP      R6,R0
        BNE.N    ??Process_8
        LDRSH    R1,[R5, #+336]
        CBNZ     R1,??Process_8
        ADDS     R0,R0,#+1
        STRH     R0,[R4, #+1238]
        BL       __Read_FIFO
        LDR      R1,[SP, #+0]
        STR      R0,[R1, #+0]
??Process_8:
        ADD      R0,R4,#+1208
        LDR      R1,[SP, #+0]
        LDR      R1,[R1, #+0]
        STRB     R1,[R0, #+0]
        LDRB     R1,[R0, #+0]
        ADD      R0,R4,#+1248
        LDR      R0,[R0, #+0]
        ADDS     R0,R1,R0
        ADD      R2,R4,#+1248
        STR      R0,[R2, #+0]
        MOVS     R0,R1
        LDRSH    R2,[R5, #+76]
        SUBS     R2,R0,R2
        LDR.W    R3,??Process_1+0x4  ;; Tmp
        STR      R2,[R3, #+0]
        ADD      R3,R4,#+1256
        LDR      R3,[R3, #+0]
        MLA      R2,R2,R2,R3
        ADD      R3,R4,#+1256
        STR      R2,[R3, #+0]
        LDRB     R2,[R4, #+1212]
        CMP      R2,R1
        IT       CC 
        STRBCC   R1,[R4, #+1212]
        LDRB     R2,[R4, #+1214]
        CMP      R1,R2
        IT       CC 
        STRBCC   R1,[R4, #+1214]
        LDR      R1,[SP, #+0]
        LDR      R1,[R1, #+0]
        LSRS     R1,R1,#+8
        STRB     R1,[R4, #+1209]
        LDRB     R2,[R4, #+1209]
        LDR      R1,[R4, #+1252]
        ADDS     R1,R2,R1
        STR      R1,[R4, #+1252]
        MOVS     R1,R2
        LDRSH    R3,[R5, #+156]
        SUBS     R3,R1,R3
        LDR.W    R12,??Process_1+0x4  ;; Tmp
        STR      R3,[R12, #+0]
        LDR      R12,[R4, #+1260]
        MLA      R3,R3,R3,R12
        STR      R3,[R4, #+1260]
        LDRB     R3,[R4, #+1213]
        CMP      R3,R2
        IT       CC 
        STRBCC   R2,[R4, #+1213]
        LDRB     R3,[R4, #+1215]
        CMP      R2,R3
        IT       CC 
        STRBCC   R2,[R4, #+1215]
        LDR      R2,[SP, #+0]
        LDR      R2,[R2, #+0]
        LSRS     R2,R2,#+16
        AND      R2,R2,#0x1
        STRB     R2,[R4, #+1210]
        LDR      R2,[SP, #+0]
        LDR      R2,[R2, #+0]
        LSRS     R2,R2,#+17
        AND      R2,R2,#0x1
        STRB     R2,[R4, #+1211]
        LDR      R2,[SP, #+12]
        CMP      R2,R6
        BGE.N    ??Process_6
        ADD      R2,R4,#+1240
        LDRH     R2,[R2, #+0]
        MOVW     R3,#+299
        CMP      R2,R3
        BCS.W    ??Process_6
        LDR      R11,[SP, #+8]
        LDRSH    R3,[R5, #+56]
        ADD      R12,R4,R3, LSL #+1
        ADD      R12,R12,#+1296
        LDRH     R12,[R12, #+0]
        MUL      R0,R12,R0
        ADDS     R3,R3,R4
        ADD      R3,R3,#+1272
        LDRSB    R3,[R3, #+0]
        ASR      R12,R0,#+9
        ADD      R0,R0,R12, LSR #+22
        ASRS     R0,R0,#+10
        ADDS     R0,R0,R3
        ADD      R3,R4,#+1200
        STRB     R0,[R3, #+0]
        LDRSH    R0,[R5, #+136]
        ADD      R3,R4,R0, LSL #+1
        LDRH     R3,[R3, #+1316]
        MULS     R1,R3,R1
        ADDS     R0,R0,R4
        LDRSB    R0,[R0, #+1284]
        ASRS     R3,R1,#+9
        ADD      R1,R1,R3, LSR #+22
        ASRS     R1,R1,#+10
        ADDS     R0,R1,R0
        STRB     R0,[R4, #+1201]
        LDRSH    R0,[R5, #+436]
        MOVS     R1,#+20
        ADD      R3,R4,#+1264
        LDR      R3,[R3, #+0]
        MLA      R9,R0,R1,R3
        SUB      R0,R11,#+1
        LSLS     R0,R0,#+10
        STR      R0,[SP, #+4]
        LSL      R0,R11,#+10
        LDRH     R1,[R9, #+14]
        MLS      R0,R2,R1,R0
        CMP      R0,#+1
        BLT.W    ??Process_6
??Process_5:
        ADD      R0,R4,#+1240
        LDRH     R8,[R0, #+0]
        LDRB     R0,[R4, #+1202]
        ADD      R1,R4,#+1200
        LDRB     R1,[R1, #+0]
        SUBS     R1,R1,R0
        LDRH     R2,[R9, #+14]
        MUL      R2,R8,R2
        LDR      R3,[SP, #+4]
        SUBS     R2,R2,R3
        MULS     R1,R1,R2
        ASRS     R2,R1,#+9
        ADD      R1,R1,R2, LSR #+22
        ASRS     R1,R1,#+10
        ADDS     R0,R1,R0
        STRB     R0,[R4, #+1204]
        STRB     R0,[R4, R8, LSL #+2]
        LDRB     R0,[R4, #+1203]
        LDRB     R10,[R4, #+1201]
        SUB      R1,R10,R0
        LDRH     R2,[R9, #+14]
        MUL      R2,R8,R2
        LDR      R3,[SP, #+4]
        SUBS     R2,R2,R3
        MULS     R1,R1,R2
        ASRS     R2,R1,#+9
        ADD      R1,R1,R2, LSR #+22
        ASRS     R1,R1,#+10
        ADDS     R0,R1,R0
        STRB     R0,[R4, #+1205]
        ADD      R7,R4,R8, LSL #+2
        STRB     R0,[R7, #+1]
        LDRSH    R0,[R5, #+236]
        LDRB     R1,[R4, #+1210]
        MOVS     R2,#+20
        MLA      R0,R1,R2,R0
        CMP      R0,#+200
        BLT.W    ??Process_3
        MOVS     R0,#+199
        B.N      ??Process_4
//  272         }
//  273       }
//  274     }
//  275   } else {                                      // 交替采样模式
//  276     for(i=0; i <4096; i++){
??Process_0:
        MOVS     R6,#+0
        STR      R0,[SP, #+8]
        LDR.N    R0,??Process_1   ;; Tmp + 4
        STR      R0,[SP, #+4]
//  277       if((__Get(FIFO_EMPTY)==0)&&(i == JumpCnt)&&(_Status == RUN)){
??Process_9:
        MOVS     R0,#+1
        BL       __Get
        CBNZ     R0,??Process_10
        LDRH     R0,[R4, #+1238]
        CMP      R6,R0
        BNE.N    ??Process_10
        LDRSH    R1,[R5, #+336]
        CBNZ     R1,??Process_10
//  278         JumpCnt++;
        ADDS     R0,R0,#+1
        STRH     R0,[R4, #+1238]
//  279         DataBuf[i] = __Read_FIFO();             // 读入32位FIFO数据, 读后指针+1
        BL       __Read_FIFO
        LDR      R1,[SP, #+4]
        STR      R0,[R1, #+0]
//  280       }
//  281       Ch[A] = (DataBuf[i] & 0xFF );              
??Process_10:
        ADD      R0,R4,#+1208
        LDR      R1,[SP, #+4]
        LDR      R1,[R1, #+0]
        STRB     R1,[R0, #+0]
//  282       Ch[B] = ((DataBuf[i] >> 8) & 0xFF);       
        LDR      R0,[SP, #+4]
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+8
        STRB     R0,[R4, #+1209]
//  283 
//  284       a_Avg += Ch[A]+Ch[B];                                   
        LDRB     R2,[R4, #+1209]
        MOVS     R0,R2
        ADD      R1,R4,#+1208
        LDRB     R3,[R1, #+0]
        MOVS     R1,R3
        ADD      R12,R4,#+1248
        LDR      R12,[R12, #+0]
        ADD      LR,R0,R1
        ADD      R12,LR,R12
        ADD      LR,R4,#+1248
        STR      R12,[LR, #+0]
//  285       b_Avg = a_Avg;                            // 累计直流平均值
        STR      R12,[R4, #+1252]
//  286       
//  287       Tmp = Ch[A]-_1_posi;
        LDRSH    R12,[R5, #+76]
        SUB      LR,R1,R12
        LDR.N    R7,??Process_1+0x4  ;; Tmp
        STR      LR,[R7, #+0]
//  288       a_Ssq +=(Tmp * Tmp);
        ADD      R7,R4,#+1256
        LDR      R7,[R7, #+0]
        MLA      LR,LR,LR,R7
//  289       Tmp = Ch[B]-_1_posi;
        SUB      R7,R0,R12
        LDR.W    R12,??Process_1+0x4  ;; Tmp
        STR      R7,[R12, #+0]
//  290       a_Ssq +=(Tmp * Tmp);                    
        MLA      R12,R7,R7,LR
        ADD      LR,R4,#+1256
        STR      R12,[LR, #+0]
//  291       b_Ssq  = a_Ssq;                           // 统计平方和
        STR      R12,[R4, #+1260]
//  292       
//  293       if(Ch[A] > a_max)  a_max = Ch[A];          
        LDRB     R12,[R4, #+1212]
        CMP      R12,R3
        IT       CC 
        STRBCC   R3,[R4, #+1212]
//  294       if(Ch[B] > a_max)  a_max = Ch[B];         // 统计最大值 
        LDRB     R12,[R4, #+1212]
        CMP      R12,R2
        IT       CC 
        STRBCC   R2,[R4, #+1212]
//  295       b_max = a_max;
        LDRB     R12,[R4, #+1212]
        STRB     R12,[R4, #+1213]
//  296       
//  297       if(Ch[A] < a_min)  a_min = Ch[A];         
        LDRB     R12,[R4, #+1214]
        CMP      R3,R12
        IT       CC 
        STRBCC   R3,[R4, #+1214]
//  298       if(Ch[B] < a_min)  a_min = Ch[B];         // 统计最小值  
        LDRB     R3,[R4, #+1214]
        CMP      R2,R3
        IT       CC 
        STRBCC   R2,[R4, #+1214]
//  299       b_min = a_min;
        LDRB     R2,[R4, #+1214]
        STRB     R2,[R4, #+1215]
        LDR      R2,[SP, #+4]
        LDR      R2,[R2, #+0]
        LSRS     R2,R2,#+16
        AND      R2,R2,#0x1
        STRB     R2,[R4, #+1210]
//  300   
//  301       Ch[C] = ((DataBuf[i] >>16)& 1);
//  302       Ch[D] = ((DataBuf[i] >>17)& 1);
        LDR      R2,[SP, #+4]
        LDR      R2,[R2, #+0]
        LSRS     R2,R2,#+17
        AND      R2,R2,#0x1
        STRB     R2,[R4, #+1211]
//  303     
//  304       if(_2_source == HIDE){                 // B通道合并到A通道时
        LDRSH    R2,[R5, #+96]
        CBNZ     R2,??Process_11
//  305         V[A] = Ka1[_A_Range] +(Ka2[_A_Range] *Ch[A])/1024;        //计算当前第1点的主值
        LDRSH    R3,[R5, #+56]
        ADD      R2,R4,R3, LSL #+1
        ADD      R2,R2,#+1296
        LDRH     R2,[R2, #+0]
        MUL      R12,R2,R1
        ADDS     R1,R3,R4
        ADD      R1,R1,#+1272
        LDRSB    R1,[R1, #+0]
        ASR      R3,R12,#+9
        ADD      R3,R12,R3, LSR #+22
        ASRS     R3,R3,#+10
        ADDS     R3,R3,R1
        ADD      R12,R4,#+1200
        STRB     R3,[R12, #+0]
//  306         V[B] = Ka1[_A_Range] +(Ka2[_A_Range] *Ch[B])/1024;        //计算当前第2点的主值
        MULS     R0,R2,R0
        ASRS     R2,R0,#+9
        ADD      R0,R0,R2, LSR #+22
        ASRS     R0,R0,#+10
        ADDS     R0,R0,R1
        STRB     R0,[R4, #+1201]
        B.N      ??Process_12
//  307       } else {                            // A通道合并到B通道时
//  308         V[A] = Kb1[_B_Range] +(Kb2[_B_Range] * Ch[A])/1024;        //计算当前第1点的主值
??Process_11:
        LDRSH    R3,[R5, #+136]
        ADD      R2,R4,R3, LSL #+1
        LDRH     R2,[R2, #+1316]
        MUL      R12,R2,R1
        ADDS     R1,R3,R4
        LDRSB    R1,[R1, #+1284]
        ASR      R3,R12,#+9
        ADD      R3,R12,R3, LSR #+22
        ASRS     R3,R3,#+10
        ADDS     R3,R3,R1
        ADD      R12,R4,#+1200
        STRB     R3,[R12, #+0]
//  309         V[B] = Kb1[_B_Range] +(Kb2[_B_Range] * Ch[B])/1024;        //计算当前第2点的主值
        MULS     R0,R2,R0
        ASRS     R2,R0,#+9
        ADD      R0,R0,R2, LSR #+22
        ASRS     R0,R0,#+10
        ADDS     R0,R0,R1
        STRB     R0,[R4, #+1201]
//  310       }
//  311       if((i > k)&&(n < 300-1)){                 // 指针到达指定窗口位置
??Process_12:
        LDR      R0,[SP, #+12]
        CMP      R0,R6
        BGE.W    ??Process_13
        ADD      R0,R4,#+1240
        LDRH     R0,[R0, #+0]
        MOVW     R1,#+299
        CMP      R0,R1
        BCS.W    ??Process_13
//  312         j =i - k;
        LDR      R11,[SP, #+8]
        LDRSH    R1,[R5, #+436]
        MOVS     R2,#+20
        ADD      R3,R4,#+1264
        LDR      R3,[R3, #+0]
        MLA      R8,R1,R2,R3
        SUB      R1,R11,#+1
        LSLS     R1,R1,#+10
        STR      R1,[SP, #+0]
//  313         while(j*1024 > n*_Kp){
        LDRH     R1,[R8, #+14]
        MULS     R0,R0,R1
        CMP      R0,R11, LSL #+10
        BLT.N    ??Process_14
??Process_15:
        MOV      R10,R7
        SUB      R0,R11,#+1
        LSLS     R0,R0,#+10
        STR      R0,[SP, #+0]
//  314           V[Bp] =V[A_]+((V[B]-V[A_])*((n *_Kp)-(j-1)*1024))/1024;   //计算当前第2点的插值
//  315           TrackBuff[n*4 + TRACK1] = V[Bp];
//  316           TrackBuff[n*4 + TRACK2] = V[Bp];
//  317           Tmp = _3_posi + 20 * Ch[C];
//  318           if(Tmp >= Y_BASE+Y_SIZE)  Tmp = Y_BASE+Y_SIZE-1;
//  319           else if(Tmp <= Y_BASE+1)  Tmp = Y_BASE+1;
//  320           TrackBuff[n*4 + TRACK3] = Tmp;
//  321           TrackBuff[n*4 + TRACK4] = CH_D_Data(); 
//  322           n++;
//  323         }
//  324         while(j*1024 > n*_Kp){
        ADD      R0,R4,#+1240
        LDRH     R0,[R0, #+0]
        LDRH     R1,[R8, #+14]
        MULS     R0,R0,R1
        CMP      R0,R11, LSL #+10
        BGE.N    ??Process_16
//  325           V[Ap] =V[B]+((V[A]-V[B])*((n *_Kp)-(j-1)*1024))/1024;   //计算当前第1点的插值
??Process_17:
        ADD      R0,R4,#+1240
        LDRH     R7,[R0, #+0]
        LDRB     R0,[R4, #+1201]
        ADD      R1,R4,#+1200
        LDRB     R1,[R1, #+0]
        SUBS     R1,R1,R0
        LDRH     R2,[R8, #+14]
        MULS     R2,R7,R2
        LDR      R3,[SP, #+0]
        SUBS     R2,R2,R3
        MULS     R1,R1,R2
        ASRS     R2,R1,#+9
        ADD      R1,R1,R2, LSR #+22
        ASRS     R1,R1,#+10
        ADDS     R0,R1,R0
        STRB     R0,[R4, #+1204]
//  326           TrackBuff[n*4 + TRACK1] = V[Ap];
        STRB     R0,[R4, R7, LSL #+2]
//  327           TrackBuff[n*4 + TRACK2] = V[Ap];
        ADD      R9,R4,R7, LSL #+2
        STRB     R0,[R9, #+1]
//  328           Tmp = _3_posi + 20 * Ch[C];
        LDRSH    R0,[R5, #+236]
        LDRB     R1,[R4, #+1210]
        MOVS     R2,#+20
        MLA      R10,R1,R2,R0
//  329           if(Tmp >= Y_BASE+Y_SIZE)  Tmp = Y_BASE+Y_SIZE-1;
        CMP      R10,#+200
        BLT.N    ??Process_18
        MOV      R10,#+199
        B.N      ??Process_19
??Process_20:
        CMP      R7,#+2
        IT       LT 
        MOVLT    R7,#+1
??Process_21:
        STRB     R7,[R9, #+2]
        BL       CH_D_Data
        STRB     R0,[R9, #+3]
        ADD      R0,R10,#+1
        ADD      R1,R4,#+1240
        STRH     R0,[R1, #+0]
        UXTH     R0,R0
        LDRH     R1,[R8, #+14]
        MULS     R0,R0,R1
        CMP      R0,R11, LSL #+10
        BGE.N    ??Process_15
??Process_14:
        ADD      R0,R4,#+1240
        LDRH     R10,[R0, #+0]
        LDRB     R0,[R4, #+1202]
        LDRB     R1,[R4, #+1201]
        SUBS     R1,R1,R0
        LDRH     R2,[R8, #+14]
        MUL      R2,R10,R2
        LDR      R3,[SP, #+0]
        SUBS     R2,R2,R3
        MULS     R1,R1,R2
        ASRS     R2,R1,#+9
        ADD      R1,R1,R2, LSR #+22
        ASRS     R1,R1,#+10
        ADDS     R0,R1,R0
        STRB     R0,[R4, #+1205]
        STRB     R0,[R4, R10, LSL #+2]
        ADD      R9,R4,R10, LSL #+2
        STRB     R0,[R9, #+1]
        LDRSH    R0,[R5, #+236]
        LDRB     R1,[R4, #+1210]
        MOVS     R2,#+20
        MLA      R7,R1,R2,R0
        CMP      R7,#+200
        BLT.N    ??Process_20
        MOVS     R7,#+199
        B.N      ??Process_21
//  330           else if(Tmp <= Y_BASE+1)  Tmp = Y_BASE+1;
??Process_18:
        CMP      R10,#+2
        IT       LT 
        MOVLT    R10,#+1
//  331           TrackBuff[n*4 + TRACK3] = Tmp;
??Process_19:
        STRB     R10,[R9, #+2]
//  332           TrackBuff[n*4 + TRACK4] = CH_D_Data(); 
        BL       CH_D_Data
        STRB     R0,[R9, #+3]
//  333           n++;
        ADDS     R0,R7,#+1
        ADD      R1,R4,#+1240
        STRH     R0,[R1, #+0]
        UXTH     R0,R0
        LDRH     R1,[R8, #+14]
        MULS     R0,R0,R1
        CMP      R0,R11, LSL #+10
        BLT.N    ??Process_17
??Process_16:
        LDR.N    R0,??Process_1+0x4  ;; Tmp
        STR      R10,[R0, #+0]
//  334         }
//  335         V[A_] = V[A]; 
        ADD      R0,R4,#+1200
        LDRB     R0,[R0, #+0]
        STRB     R0,[R4, #+1202]
//  336       }
//  337     }
??Process_13:
        ADDS     R6,R6,#+1
        LDR      R0,[SP, #+4]
        ADDS     R0,R0,#+4
        STR      R0,[SP, #+4]
        LDR      R0,[SP, #+8]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+8]
        CMP      R6,#+4096
        BLT.W    ??Process_9
//  338   }
//  339   for(i=0; i<4; i++){                                    // 消除屏幕端点连线
??Process_7:
        ADD      R0,R4,#+1192
        MOVS     R1,#+4
//  340     for(j=0; j<4; j++){
//  341       TrackBuff[(i+0)*4+ j]   = TrackBuff[(i+1)*4 + j];
??Process_22:
        LDRB     R2,[R4, #+4]
        STRB     R2,[R4, #+0]
//  342       TrackBuff[(299-i)*4+ j] = TrackBuff[(298-i)*4 + j];
        LDRB     R2,[R0, #+0]
        STRB     R2,[R0, #+4]
        LDRB     R2,[R4, #+5]
        STRB     R2,[R4, #+1]
        LDRB     R2,[R0, #+1]
        STRB     R2,[R0, #+5]
        LDRB     R2,[R4, #+6]
        STRB     R2,[R4, #+2]
        LDRB     R2,[R0, #+2]
        STRB     R2,[R0, #+6]
        LDRB     R2,[R4, #+7]
        STRB     R2,[R4, #+3]
        LDRB     R2,[R0, #+3]
        STRB     R2,[R0, #+7]
//  343     }
//  344   }
        ADDS     R4,R4,#+4
        SUBS     R0,R0,#+4
        SUBS     R1,R1,#+1
        BNE.N    ??Process_22
//  345 }
        ADD      SP,SP,#+20
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        Nop      
        DATA
??Process_1:
        DC32     Tmp + 4
        DC32     Tmp
        CFI EndBlock cfiBlock6
//  346 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function CH_D_Data
        THUMB
//  347 u8 CH_D_Data(void)  //计算生成CH_D通道的显示数据
//  348 {
//  349   s32 Tmp;
//  350   
//  351   switch (_4_source){  
CH_D_Data:
        LDR.W    R1,??DataTable21  ;; Title
        LDRSH    R0,[R1, #+256]
        SUBS     R0,R0,#+2
        CMP      R0,#+7
        BHI.W    ??CH_D_Data_1
        TBB      [PC, R0]
        DATA
??CH_D_Data_0:
        DC8      +4,+52,+75,+75
        DC8      +87,+97,+110,+122
        THUMB
//  352   case A_add_B:
//  353     if(Interlace == 0){                          // 独立采样模式
??CH_D_Data_2:
        LDR.W    R0,??DataTable32  ;; TrackBuff
        ADD      R2,R0,#+1216
        LDRB     R2,[R2, #+0]
        CBNZ     R2,??CH_D_Data_3
//  354       Tmp = _4_posi +(V[A]-_1_posi)+(V[B]-_2_posi);
        LDRSH    R2,[R1, #+316]
        ADD      R3,R0,#+1200
        LDRB     R3,[R3, #+0]
        ADDS     R2,R3,R2
        LDRSH    R3,[R1, #+76]
        SUBS     R2,R2,R3
        LDRB     R0,[R0, #+1201]
        ADDS     R0,R0,R2
        LDRSH    R1,[R1, #+156]
??CH_D_Data_4:
        SUBS     R0,R0,R1
        B.N      ??CH_D_Data_5
//  355     } else {                                     // 交替采样模式
??CH_D_Data_3:
        LDRSH    R2,[R1, #+316]
        MOVS     R0,R2
//  356       Tmp = _4_posi;
//  357       if(_1_source != HIDE)  Tmp = _4_posi +(V[Ap]-_1_posi);
        LDRSH    R3,[R1, #+16]
        CBZ      R3,??CH_D_Data_6
        LDR.W    R0,??DataTable32  ;; TrackBuff
        LDRB     R0,[R0, #+1204]
        ADDS     R0,R0,R2
        LDRSH    R3,[R1, #+76]
        SUBS     R0,R0,R3
//  358       if(_2_source != HIDE)  Tmp = _4_posi +(V[Bp]-_2_posi);
??CH_D_Data_6:
        LDRSH    R3,[R1, #+96]
        CMP      R3,#+0
        BEQ.N    ??CH_D_Data_5
        LDR.W    R0,??DataTable32  ;; TrackBuff
        LDRB     R0,[R0, #+1205]
        ADDS     R0,R0,R2
        LDRSH    R1,[R1, #+156]
        B.N      ??CH_D_Data_4
//  359     } break;
//  360   case A_sub_B:
//  361     if(Interlace == 0){                          // 独立采样模式
??CH_D_Data_7:
        LDR.W    R0,??DataTable32  ;; TrackBuff
        ADD      R2,R0,#+1216
        LDRB     R2,[R2, #+0]
        CMP      R2,#+0
        BNE.N    ??CH_D_Data_3
//  362       Tmp = _4_posi +(V[A]-_1_posi)-(V[B]-_2_posi);  break;
        LDRSH    R2,[R1, #+316]
        ADD      R3,R0,#+1200
        LDRB     R3,[R3, #+0]
        ADDS     R2,R3,R2
        LDRSH    R3,[R1, #+76]
        SUBS     R2,R2,R3
        LDRB     R0,[R0, #+1201]
        SUBS     R0,R2,R0
        LDRSH    R1,[R1, #+156]
??CH_D_Data_8:
        ADDS     R0,R1,R0
        B.N      ??CH_D_Data_5
//  363     } else {                                     // 交替采样模式
//  364       Tmp = _4_posi;
//  365       if(_1_source != HIDE)  Tmp = _4_posi +(V[Ap]-_1_posi);
//  366       if(_2_source != HIDE)  Tmp = _4_posi +(V[Bp]-_2_posi);
//  367     } break;
//  368   case C_and_D:
//  369     Tmp = _4_posi + 20 *(Ch[C] & Ch[D]);  break;
??CH_D_Data_9:
        LDR.N    R0,??DataTable32  ;; TrackBuff
        LDRSH    R1,[R1, #+316]
        LDRB     R2,[R0, #+1210]
        LDRB     R0,[R0, #+1211]
        ANDS     R0,R0,R2
        MOVS     R2,#+20
        MLA      R0,R0,R2,R1
        B.N      ??CH_D_Data_5
//  370   case C_or_D:
//  371     Tmp =  _4_posi + 20 *(Ch[C] & Ch[D]);  break;
//  372   case FILE1:
//  373     Tmp = FileBuff[n] - FileBuff[299] +_4_posi;  break;
??CH_D_Data_10:
        LDR.N    R0,??CH_D_Data_11  ;; FileBuff
        LDR.N    R2,??CH_D_Data_11+0x4  ;; TrackBuff + 1240
        LDRH     R2,[R2, #+0]
        LDRB     R2,[R2, R0]
        LDRB     R0,[R0, #+299]
        SUBS     R0,R2,R0
        LDRSH    R1,[R1, #+316]
        B.N      ??CH_D_Data_8
//  374   case FILE2:
//  375     Tmp = FileBuff[n+300] - FileBuff[599] +_4_posi;  break;
??CH_D_Data_12:
        LDR.N    R0,??CH_D_Data_11  ;; FileBuff
        LDR.N    R2,??CH_D_Data_11+0x4  ;; TrackBuff + 1240
        LDRH     R2,[R2, #+0]
        ADDS     R2,R2,R0
        LDRB     R2,[R2, #+300]
        LDRB     R0,[R0, #+599]
        SUBS     R0,R2,R0
        LDRSH    R1,[R1, #+316]
??CH_D_Data_13:
        ADDS     R0,R1,R0
        B.N      ??CH_D_Data_5
//  376   case FILE3:
//  377     Tmp = FileBuff[n+600] - FileBuff[899] +_4_posi;  break;
??CH_D_Data_14:
        LDR.N    R0,??CH_D_Data_11  ;; FileBuff
        LDR.N    R2,??CH_D_Data_11+0x4  ;; TrackBuff + 1240
        LDRH     R2,[R2, #+0]
        ADDS     R2,R2,R0
        LDRB     R2,[R2, #+600]
        LDRB     R0,[R0, #+899]
        SUBS     R0,R2,R0
        LDRSH    R1,[R1, #+316]
        B.N      ??CH_D_Data_8
//  378   case FILE4:
//  379     Tmp = FileBuff[n+900] - FileBuff[1199] +_4_posi;  break;
??CH_D_Data_15:
        LDR.N    R0,??CH_D_Data_11  ;; FileBuff
        LDR.N    R2,??CH_D_Data_11+0x4  ;; TrackBuff + 1240
        LDRH     R2,[R2, #+0]
        ADDS     R2,R2,R0
        LDRB     R2,[R2, #+900]
        LDRB     R0,[R0, #+1199]
        SUBS     R0,R2,R0
        LDRSH    R1,[R1, #+316]
        B.N      ??CH_D_Data_13
//  380   default:
//  381     Tmp = _4_posi + 20 * Ch[D];
??CH_D_Data_1:
        LDRSH    R0,[R1, #+316]
        LDR.N    R1,??DataTable32  ;; TrackBuff
        LDRB     R1,[R1, #+1211]
        MOVS     R2,#+20
        MLA      R0,R1,R2,R0
//  382   }
//  383   if(Tmp >= Y_BASE+Y_SIZE)  Tmp = Y_BASE+Y_SIZE-1;
??CH_D_Data_5:
        CMP      R0,#+200
        BLT.N    ??CH_D_Data_16
        MOVS     R0,#+199
        B.N      ??CH_D_Data_17
//  384   else if(Tmp <= Y_BASE+1)  Tmp = Y_BASE+1;
??CH_D_Data_16:
        CMP      R0,#+2
        IT       LT 
        MOVLT    R0,#+1
//  385   return Tmp;
??CH_D_Data_17:
        UXTB     R0,R0
        BX       LR               ;; return
        Nop      
        DATA
??CH_D_Data_11:
        DC32     FileBuff
        DC32     TrackBuff + 1240
        CFI EndBlock cfiBlock7
//  386 }
//  387 /*******************************************************************************
//  388  Synchro: 扫描同步处理，按设定模式显示波形 
//  389 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function Synchro
        THUMB
//  390 void Synchro(void)  //扫描同步方式共有：AUTO、NORM、SIGN、NONE、SCAN 5种模式
//  391 { 
Synchro:
        PUSH     {R4-R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI R7 Frame(CFA, -8)
        CFI R6 Frame(CFA, -12)
        CFI R5 Frame(CFA, -16)
        CFI R4 Frame(CFA, -20)
        CFI CFA R13+20
        SUB      SP,SP,#+4
        CFI CFA R13+24
//  392   u16  i;
//  393 
//  394   switch (_Mode){ 
        LDR.N    R5,??DataTable21  ;; Title
        LDRSH    R0,[R5, #+416]
        CMP      R0,#+4
        BHI.N    ??Synchro_1
        TBB      [PC, R0]
        DATA
??Synchro_0:
        DC8      +3,+41,+70,+84
        DC8      +84,+0
        THUMB
//  395   case AUTO:
//  396     __Set(TRIGG_MODE,(_Tr_source <<3)+_Tr_kind);  // 设触发条件
??Synchro_2:
        LDRSH    R0,[R5, #+576]
        LDRSH    R1,[R5, #+596]
        ADD      R1,R1,R0, LSL #+3
        MOVS     R0,#+32
        BL       __Set
//  397     if(__Get(FIFO_START)!=0){
        MOVS     R0,#+2
        BL       __Get
        CBZ      R0,??Synchro_3
//  398       Process();                                  // 生成新的显示波形
??Synchro_4:
        BL       Process
//  399       Wait_Cnt = Wait[_T_base];
        LDRSH    R0,[R5, #+436]
        LDR.N    R1,??DataTable29  ;; Wait
        LDRH     R0,[R1, R0, LSL #+1]
        LDR.N    R1,??DataTable30  ;; Wait_Cnt
        STR      R0,[R1, #+0]
        B.N      ??Synchro_1
//  400     } else if(Wait_Cnt==0){
??Synchro_3:
        LDR.N    R0,??DataTable30  ;; Wait_Cnt
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Synchro_1
//  401       if(JumpCnt >= 4095)  JumpCnt = 0;         
        LDR.N    R4,??DataTable32  ;; TrackBuff
        LDRH     R0,[R4, #+1238]
        MOVW     R1,#+4095
        CMP      R0,R1
        BCC.N    ??Synchro_4
        MOVS     R0,#+0
        STRH     R0,[R4, #+1238]
        B.N      ??Synchro_4
//  402       Process();   
//  403       Wait_Cnt = Wait[_T_base];
//  404     } break;
//  405   case NORM:
//  406     __Set(TRIGG_MODE,(_Tr_source <<3)+_Tr_kind);  // 设触发条件
??Synchro_5:
        LDRSH    R0,[R5, #+576]
        LDRSH    R1,[R5, #+596]
        ADD      R1,R1,R0, LSL #+3
        MOVS     R0,#+32
        BL       __Set
//  407     if(__Get(FIFO_START)!=0){
        MOVS     R0,#+2
        BL       __Get
        CMP      R0,#+0
        BNE.N    ??Synchro_4
//  408       Process();                                  // 生成新的显示波形
//  409       Wait_Cnt = Wait[_T_base];
//  410     } else if(Wait_Cnt==0){
        LDR.N    R4,??DataTable30  ;; Wait_Cnt
        LDR      R0,[R4, #+0]
        CBNZ     R0,??Synchro_1
//  411       for(i=0; i<4*X_SIZE; ++i)  TrackBuff[i] = 0;// 清除旧的显示波形
        MOV      R1,#+1200
        LDR.N    R0,??DataTable32  ;; TrackBuff
        BL       __aeabi_memclr4
//  412       Wait_Cnt = Wait[_T_base];
        LDRSH    R0,[R5, #+436]
        LDR.N    R1,??DataTable29  ;; Wait
        LDRH     R0,[R1, R0, LSL #+1]
        STR      R0,[R4, #+0]
        B.N      ??Synchro_1
//  413     } break;
//  414   case SIGN:
//  415     __Set(TRIGG_MODE,(_Tr_source <<3)+_Tr_kind);  // 设触发条件
??Synchro_6:
        LDRSH    R0,[R5, #+576]
        LDRSH    R1,[R5, #+596]
        ADD      R1,R1,R0, LSL #+3
        MOVS     R0,#+32
        BL       __Set
//  416     if(__Get(FIFO_START)!=0)  Process();          // 生成新的显示波形
        MOVS     R0,#+2
        BL       __Get
        CBZ      R0,??Synchro_1
        B.N      ??Synchro_7
//  417     break;
//  418   case NONE:
//  419   case SCAN:
//  420     __Set(TRIGG_MODE, UNCONDITION);               // 设为无条件触发
??Synchro_8:
        MOVS     R1,#+32
        MOVS     R0,#+32
        BL       __Set
//  421     Process();                                    // 生成当前显示波形
??Synchro_7:
        BL       Process
//  422     break;
//  423   }
//  424   Draw_Window();                                  // 刷新屏幕波形显示区
??Synchro_1:
        BL       Draw_Window
//  425 
//  426   if((_Status == RUN)&&(__Get(FIFO_FULL)!=0)){    // FIFO is full
        LDRSH    R0,[R5, #+336]
        CMP      R0,#+0
        BNE.N    ??Synchro_9
        MOVS     R0,#+3
        BL       __Get
        CMP      R0,#+0
        BEQ.N    ??Synchro_9
//  427     __Set(FIFO_CLR, W_PTR);                       // FIFO写指针复位
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
//  428     Wait_Cnt = Wait[_T_base];
        LDRSH    R0,[R5, #+436]
        LDR.N    R1,??DataTable29  ;; Wait
        LDRH     R0,[R1, R0, LSL #+1]
        LDR.N    R1,??DataTable30  ;; Wait_Cnt
        STR      R0,[R1, #+0]
//  429     JumpCnt =0;
        LDR.N    R4,??DataTable32  ;; TrackBuff
        MOVS     R0,#+0
        STRH     R0,[R4, #+1238]
//  430     if(_Mode == SIGN){
        LDRSH    R0,[R5, #+416]
        CMP      R0,#+2
        BNE.N    ??Synchro_10
//  431       _Status = HOLD;                             // 一帧完后，进入暂停
        MOVS     R0,#+1
        STRH     R0,[R5, #+336]
//  432       _State.Flag |= UPDAT;
        ADD      R0,R5,#+338
        LDRB     R0,[R0, #+0]
        ORR      R0,R0,#0x2
        ADD      R1,R5,#+338
        STRB     R0,[R1, #+0]
        B.N      ??Synchro_9
//  433     }
//  434     if(_Mode == SCAN){
??Synchro_10:
        CMP      R0,#+4
        BNE.N    ??Synchro_9
//  435       for(i=0; i<X_SIZE; i++){                    // 重建当前轨迹基线                   
        MOVS     R0,#+75
        LDRSH    R1,[R5, #+316]
        LDRSH    R2,[R5, #+236]
        LDRSH    R3,[R5, #+156]
        LDRSH    R12,[R5, #+76]
//  436         TrackBuff[i*4 + TRACK1] = _1_posi;
??Synchro_11:
        STRB     R12,[R4], #+1
//  437         TrackBuff[i*4 + TRACK2] = _2_posi; 
        STRB     R3,[R4], #+1
//  438         TrackBuff[i*4 + TRACK3] = _3_posi; 
        STRB     R2,[R4], #+1
//  439         TrackBuff[i*4 + TRACK4] = _4_posi;
        STRB     R1,[R4], #+1
        STRB     R12,[R4], #+1
        STRB     R3,[R4], #+1
        STRB     R2,[R4], #+1
        STRB     R1,[R4], #+1
        STRB     R12,[R4], #+1
        STRB     R3,[R4], #+1
        STRB     R2,[R4], #+1
        STRB     R1,[R4], #+1
        STRB     R12,[R4], #+1
        STRB     R3,[R4], #+1
        STRB     R2,[R4], #+1
        STRB     R1,[R4], #+1
//  440       }
        SUBS     R0,R0,#+1
        BNE.N    ??Synchro_11
??Synchro_9:
        LDRSH    R0,[R5, #+56]
        LDR.N    R4,??DataTable32  ;; TrackBuff
        ADDS     R1,R0,R4
        ADD      R1,R1,#+1272
        LDRSB    R1,[R1, #+0]
        ADD      R0,R4,R0, LSL #+1
        ADD      R0,R0,#+1296
        LDRH     R0,[R0, #+0]
        ADD      R2,R4,#+1248
        LDR      R2,[R2, #+0]
        LSRS     R2,R2,#+10
        MULS     R0,R0,R2
        ADD      R0,R1,R0, LSR #+12
        LDRH     R1,[R5, #+76]
        SUBS     R0,R0,R1
        STRH     R0,[R4, #+1218]
        LDRSH    R0,[R5, #+136]
        ADDS     R1,R0,R4
        LDRSB    R1,[R1, #+1284]
        ADD      R0,R4,R0, LSL #+1
        LDRH     R0,[R0, #+1316]
        LDR      R2,[R4, #+1252]
        LSRS     R2,R2,#+10
        MULS     R0,R0,R2
        ADD      R0,R1,R0, LSR #+12
        LDRH     R1,[R5, #+156]
        SUBS     R0,R0,R1
        STRH     R0,[R4, #+1228]
//  441     }
//  442   }    
//  443   A_Vdc = Ka1[_A_Range] +(Ka2[_A_Range]*(a_Avg/1024))/4096 - _1_posi;  
//  444   B_Vdc = Kb1[_B_Range] +(Kb2[_B_Range]*(b_Avg/1024))/4096 - _2_posi;  
//  445 
//  446   A_Rms = Ka1[_A_Range] +(Ka2[_A_Range]*Int_sqrt(a_Ssq/4096))/1024;
        ADD      R0,R4,#+1256
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+12
        BL       Int_sqrt
        LDRSH    R1,[R5, #+56]
        ADDS     R2,R1,R4
        ADD      R2,R2,#+1272
        LDRSB    R2,[R2, #+0]
        ADD      R1,R4,R1, LSL #+1
        ADD      R1,R1,#+1296
        LDRH     R1,[R1, #+0]
        MULS     R0,R1,R0
        ADD      R0,R2,R0, LSR #+10
        STRH     R0,[R4, #+1226]
//  447   B_Rms = Kb1[_B_Range] +(Kb2[_B_Range]*Int_sqrt(b_Ssq/4096))/1024;
        LDR      R0,[R4, #+1260]
        LSRS     R0,R0,#+12
        BL       Int_sqrt
        LDRSH    R2,[R5, #+136]
        ADD      R1,R4,R2, LSL #+1
        LDRH     R1,[R1, #+1316]
        ADDS     R2,R2,R4
        LDRSB    R2,[R2, #+1284]
        MULS     R0,R1,R0
        ADD      R0,R2,R0, LSR #+10
        STRH     R0,[R4, #+1236]
        LDRSH    R0,[R5, #+56]
        ADD      R3,R4,R0, LSL #+1
        ADD      R3,R3,#+1296
        LDRH     R3,[R3, #+0]
        LDRB     R12,[R4, #+1212]
        MUL      R6,R3,R12
        ADDS     R0,R0,R4
        ADD      R0,R0,#+1272
        LDRSB    R12,[R0, #+0]
        LDRSH    LR,[R5, #+76]
        ASRS     R0,R6,#+9
        ADD      R0,R6,R0, LSR #+22
        ADD      R0,R12,R0, ASR #+10
        SUB      R0,R0,LR
        STRH     R0,[R4, #+1222]
//  448 
//  449   A_Max = Ka1[_A_Range] +(Ka2[_A_Range]*a_max)/1024 - _1_posi;
//  450   B_Max = Kb1[_B_Range] +(Kb2[_B_Range]*b_max)/1024 - _2_posi;
        LDRB     R6,[R4, #+1213]
        MULS     R6,R1,R6
        LDRSH    R5,[R5, #+156]
        ASRS     R7,R6,#+9
        ADD      R6,R6,R7, LSR #+22
        ADD      R6,R2,R6, ASR #+10
        SUBS     R6,R6,R5
        ADD      R7,R4,#+1232
        STRH     R6,[R7, #+0]
//  451  
//  452   A_Min = Ka1[_A_Range] +(Ka2[_A_Range]*a_min)/1024 - _1_posi;
        LDRB     R7,[R4, #+1214]
        MULS     R3,R3,R7
        ASRS     R7,R3,#+9
        ADD      R3,R3,R7, LSR #+22
        ADD      R3,R12,R3, ASR #+10
        SUB      R3,R3,LR
        ADD      R12,R4,#+1224
        STRH     R3,[R12, #+0]
//  453   B_Min = Kb1[_B_Range] +(Kb2[_B_Range]*b_min)/1024 - _2_posi;
        LDRB     R12,[R4, #+1215]
        MUL      R1,R1,R12
        ASR      R12,R1,#+9
        ADD      R1,R1,R12, LSR #+22
        ADD      R1,R2,R1, ASR #+10
        SUBS     R1,R1,R5
        STRH     R1,[R4, #+1234]
//  454     
//  455   A_Vpp = A_Max - A_Min;
        SUBS     R0,R0,R3
        STRH     R0,[R4, #+1220]
//  456   B_Vpp = B_Max - B_Min;
        SUBS     R0,R6,R1
        STRH     R0,[R4, #+1230]
//  457 }  
        ADD      SP,SP,#+4
        CFI CFA R13+20
        POP      {R4-R7,PC}       ;; return
        CFI EndBlock cfiBlock8

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable21:
        DC32     Title

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable29:
        DC32     Wait

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable30:
        DC32     Wait_Cnt

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable32:
        DC32     TrackBuff

        END
//  458 /******************************** END OF FILE *********************************/
// 
// 16 396 bytes in section .bss
//  1 965 bytes in section .data
//     56 bytes in section .rodata
//  3 596 bytes in section .text
// 
//  3 596 bytes of CODE  memory
//     56 bytes of CONST memory
// 18 361 bytes of DATA  memory
//
//Errors: none
//Warnings: none
