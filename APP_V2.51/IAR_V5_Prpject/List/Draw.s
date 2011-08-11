///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  11:07:54 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\APP_V2.51\source\Draw.c                /
//    Command line =  E:\Mini-DS\DS203\APP_V2.51\source\Draw.c -lA            /
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
//    List file    =  E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\List\Draw.s   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Draw

        EXTERN Title
        EXTERN TrackBuff
        EXTERN __LCD_Copy
        EXTERN __LCD_DMA_Ready
        EXTERN __LCD_SetPixl
        EXTERN __LCD_Set_Block
        EXTERN __Point_SCR
        EXTERN __Row_Copy
        EXTERN __Row_DMA_Ready

        PUBLIC CLK_TAB
        PUBLIC Char_TAB_8x11
        PUBLIC Color
        PUBLIC Draw_Mark
        PUBLIC Draw_Row
        PUBLIC Draw_Window
        PUBLIC Get_Ref_Wave
        PUBLIC Get_TAB_8x11
        PUBLIC LCD_Buffer1
        PUBLIC LCD_Buffer2
        PUBLIC Mark_TAB
        PUBLIC Mark_TAB_1
        PUBLIC Mark_TAB_2
        PUBLIC Mark_TAB_3
        PUBLIC Mark_TAB_4
        PUBLIC Mark_TAB_T
        PUBLIC Print_Clk
        PUBLIC Print_Str
        PUBLIC RULE_BASE
        PUBLIC Ref_Wave
        PUBLIC Row_Base0
        PUBLIC Row_Base1
        PUBLIC Row_Base2
        PUBLIC Row_Base3
        PUBLIC Row_Base4
        PUBLIC Update_Mark
        PUBLIC Update_View_Area
        PUBLIC V_Trigg
        PUBLIC Vt1
        PUBLIC Vt2
        PUBLIC Vt3
        PUBLIC Vt4
        
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
        
// E:\Mini-DS\DS203\APP_V2.51\source\Draw.c
//    1 /******************** (C) COPYRIGHT 2009 e-Design Co.,Ltd. *********************
//    2  File Name : Draw.c       
//    3  Version   : DS203_APP Ver 2.3x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include "Process.h"
//    6 #include "Draw.h"
//    7 #include "Menu.h"
//    8 #include "BIOS.h"
//    9 

        SECTION `.rodata`:CONST:NOROOT(2)
//   10 uc16 RULE_BASE [8] ={0x020,0x040,0x080,0x040,0x020,0x010,0x008,0x010};
RULE_BASE:
        DATA
        DC16 32, 64, 128, 64, 32, 16, 8, 16
//   11 

        SECTION `.rodata`:CONST:NOROOT(2)
//   12 uc8  Mark_TAB_1[7] ={0x00,0x00,0x42,0xFE,0x02,0x00,0x00};      // Mark 1
Mark_TAB_1:
        DATA
        DC8 0, 0, 66, 254, 2, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
//   13 uc8  Mark_TAB_2[7] ={0x00,0x46,0x8A,0x92,0x92,0x62,0x00};      // Mark 2
Mark_TAB_2:
        DATA
        DC8 0, 70, 138, 146, 146, 98, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
//   14 uc8  Mark_TAB_3[7] ={0x00,0x44,0x82,0x92,0x92,0x6C,0x00};      // Mark 3
Mark_TAB_3:
        DATA
        DC8 0, 68, 130, 146, 146, 108, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
//   15 uc8  Mark_TAB_4[7] ={0x00,0x18,0x28,0x4A,0xFE,0x0A,0x00};      // Mark 4
Mark_TAB_4:
        DATA
        DC8 0, 24, 40, 74, 254, 10, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
//   16 uc8  Mark_TAB_T[7] ={0x00,0x40,0x40,0x7E,0x40,0x40,0x00};      // Mark T
Mark_TAB_T:
        DATA
        DC8 0, 64, 64, 126, 64, 64, 0, 0
//   17 

        SECTION `.rodata`:CONST:NOROOT(2)
//   18 uc8  Mark_TAB[5][7] ={{0x00,0x00,0x42,0xFE,0x02,0x00,0x00},    // Mark 1
Mark_TAB:
        DATA
        DC8 0, 0, 66, 254, 2, 0, 0, 0, 70, 138, 146, 146, 98, 0, 0, 68, 130
        DC8 146, 146, 108, 0, 0, 24, 40, 74, 254, 10, 0, 0, 64, 64, 126, 64, 64
        DC8 0, 0
//   19                       {0x00,0x46,0x8A,0x92,0x92,0x62,0x00},    // Mark 2
//   20                       {0x00,0x44,0x82,0x92,0x92,0x6C,0x00},    // Mark 3
//   21                       {0x00,0x18,0x28,0x4A,0xFE,0x0A,0x00},    // Mark 4
//   22                       {0x00,0x40,0x40,0x7E,0x40,0x40,0x00}};   // Mark T
//   23 

        SECTION `.rodata`:CONST:NOROOT(2)
//   24 uc16 CLK_TAB[44] =
CLK_TAB:
        DATA
        DC16 0, 0, 0, 0, 112, 1023, 112, 0, 0, 0, 0, 0, 2, 4, 8, 112, 112, 112
        DC16 128, 256, 512, 0, 32, 32, 32, 32, 112, 112, 112, 32, 32, 32, 32, 0
        DC16 512, 256, 128, 112, 112, 112, 8, 4, 2, 0
//   25   {0x000,0x000,0x000,0x000,0x070,0x3FF,0x070,0x000,0x000,0x000,0x000,
//   26    0x000,0x002,0x004,0x008,0x070,0x070,0x070,0x080,0x100,0x200,0x000,
//   27    0x020,0x020,0x020,0x020,0x070,0x070,0x070,0x020,0x020,0x020,0x020,
//   28    0x000,0x200,0x100,0x080,0x070,0x070,0x070,0x008,0x004,0x002,0x000};
//   29 

        SECTION `.rodata`:CONST:NOROOT(2)
//   30 uc16 Char_TAB_8x11[744] = {
Char_TAB_8x11:
        DATA
        DC16 0, 0, 0, 1920, 64, 32, 32, 32, 508, 508, 508, 508, 508, 508, 508
        DC16 0, 112, 248, 508, 508, 508, 248, 112, 0, 780, 396, 192, 96, 48
        DC16 792, 780, 0, 0, 384, 608, 540, 618, 644, 320, 0, 514, 514, 514
        DC16 514, 514, 514, 1022, 0, 0, 0, 248, 508, 774, 514, 0, 0, 0, 0, 514
        DC16 774, 508, 248, 0, 0, 0, 396, 216, 112, 112, 216, 396, 0, 0, 32, 32
        DC16 248, 248, 32, 32, 0, 32, 32, 16, 15, 0, 0, 0, 0, 0, 32, 32, 32, 32
        DC16 32, 32, 0, 0, 0, 768, 768, 0, 0, 0, 0, 384, 192, 96, 48, 24, 12, 6
        DC16 0, 508, 1022, 578, 546, 530, 1022, 508, 0, 0, 520, 524, 1022, 1022
        DC16 512, 512, 0, 772, 902, 706, 610, 562, 798, 780, 0, 260, 774, 546
        DC16 546, 546, 1022, 476, 0, 96, 112, 88, 588, 1022, 1022, 576, 0, 286
        DC16 542, 530, 530, 530, 1010, 482, 0, 504, 1020, 550, 546, 546, 992
        DC16 448, 0, 6, 6, 962, 994, 50, 30, 14, 0, 476, 1022, 546, 546, 546
        DC16 1022, 476, 0, 28, 574, 546, 546, 802, 510, 252, 0, 0, 0, 0, 408
        DC16 408, 0, 0, 0, 762, 762, 762, 762, 762, 762, 762, 762, 0, 32, 112
        DC16 216, 396, 774, 514, 0, 144, 144, 144, 144, 144, 144, 0, 0, 0, 514
        DC16 774, 396, 216, 112, 32, 0, 24, 28, 4, 836, 868, 60, 24, 0, 504
        DC16 260, 626, 626, 754, 644, 120, 0, 1008, 1016, 76, 70, 76, 1016
        DC16 1008, 0, 514, 1022, 1022, 546, 546, 1022, 476, 0, 248, 508, 774
        DC16 514, 514, 774, 396, 0, 514, 1022, 1022, 514, 774, 508, 248, 0, 514
        DC16 1022, 1022, 546, 626, 774, 910, 0, 514, 1022, 1022, 546, 114, 6
        DC16 14, 0, 248, 508, 774, 546, 546, 486, 1004, 0, 1022, 1022, 32, 32
        DC16 32, 1022, 1022, 0, 0, 0, 514, 1022, 1022, 514, 0, 0, 448, 960, 512
        DC16 514, 1022, 510, 2, 0, 514, 1022, 1022, 48, 248, 974, 774, 0, 514
        DC16 1022, 1022, 514, 512, 512, 768, 0, 1022, 1022, 28, 56, 28, 1022
        DC16 1022, 0, 1022, 1022, 28, 56, 112, 1022, 1022, 0, 248, 508, 774
        DC16 514, 774, 508, 248, 0, 514, 1022, 1022, 546, 34, 62, 28, 0, 508
        DC16 1022, 514, 642, 770, 1022, 508, 0, 514, 1022, 1022, 34, 98, 1022
        DC16 924, 0, 268, 798, 562, 546, 610, 974, 396, 0, 0, 14, 518, 1022
        DC16 1022, 518, 14, 0, 510, 1022, 512, 512, 512, 1022, 510, 0, 126, 254
        DC16 384, 768, 384, 254, 126, 0, 254, 1022, 896, 480, 896, 1022, 254, 0
        DC16 774, 990, 248, 32, 248, 990, 774, 0, 0, 30, 574, 992, 992, 574, 30
        DC16 0, 910, 966, 610, 562, 798, 910, 0, 0, 512, 768, 704, 544, 536
        DC16 516, 1022, 0, 0, 34, 66, 510, 1022, 576, 544, 0, 32, 16, 8, 6, 8
        DC16 16, 32, 32, 0, 544, 528, 1020, 1022, 18, 34, 0, 0, 512, 512, 512
        DC16 512, 512, 512, 0, 514, 514, 514, 514, 514, 514, 514, 514, 448
        DC16 1000, 552, 552, 504, 1008, 512, 0, 514, 1022, 510, 544, 544, 992
        DC16 448, 0, 480, 1008, 528, 528, 528, 816, 288, 0, 0, 448, 992, 544
        DC16 546, 1022, 1022, 0, 480, 1008, 592, 592, 592, 880, 352, 0, 0, 544
        DC16 1020, 1022, 546, 2, 4, 0, 304, 888, 584, 584, 1016, 504, 0, 0, 514
        DC16 1022, 1022, 32, 16, 1008, 992, 0, 0, 0, 512, 1014, 1014, 512, 0, 0
        DC16 0, 256, 768, 528, 1014, 502, 0, 0, 514, 1022, 1022, 98, 240, 920
        DC16 776, 0, 0, 0, 514, 1022, 1022, 512, 0, 0, 1016, 1016, 24, 1008, 24
        DC16 1016, 1008, 0, 8, 1016, 1008, 8, 8, 1016, 1008, 0, 0, 496, 1016
        DC16 520, 520, 1016, 496, 0, 520, 1016, 1008, 584, 72, 120, 48, 0, 48
        DC16 120, 72, 584, 1016, 1016, 512, 0, 520, 1016, 1008, 536, 8, 24, 48
        DC16 0, 0, 272, 824, 616, 584, 984, 400, 0, 16, 16, 504, 1020, 528, 784
        DC16 256, 0, 504, 1016, 512, 512, 504, 1016, 512, 0, 0, 248, 504, 768
        DC16 768, 504, 248, 0, 248, 1016, 768, 384, 768, 1016, 248, 0, 520, 792
        DC16 432, 224, 432, 792, 520, 0, 56, 632, 576, 576, 576, 504, 248, 0
        DC16 792, 904, 712, 616, 568, 792, 0, 0, 248, 136, 910, 34, 762, 762
        DC16 762, 762, 0, 0, 0, 1022, 1022, 0, 0, 0, 762, 762, 762, 762, 762
        DC16 514, 1022, 0, 248, 136, 910, 514, 514, 514, 514, 514
//   31   0x000,0x000,0x000,0x780,0x040,0x020,0x020,0x020, // " 左上角
//   32 //  0x020,0x020,0x040,0x780,0x000,0x000,0x000,0x000, // # 右上角
//   33   0x1FC,0x1FC,0x1FC,0x1FC,0x1FC,0x1FC,0x1FC,0x000, // # 方块
//   34 //  0x000,0x000,0x000,0x00F,0x010,0x020,0x020,0x020, // $ 左下角
//   35   0x070,0x0F8,0x1FC,0x1FC,0x1FC,0x0F8,0x070,0x000, // $ 圆点
//   36   0x30C,0x18C,0x0C0,0x060,0x030,0x318,0x30C,0x000, // % 
//   37   0x000,0x180,0x260,0x21C,0x26A,0x284,0x140,0x000, // & 
//   38   0x202,0x202,0x202,0x202,0x202,0x202,0x3FE,0x000, // ' 电池尾空
//   39   0x000,0x000,0x0F8,0x1FC,0x306,0x202,0x000,0x000, // (
//   40   0x000,0x000,0x202,0x306,0x1FC,0x0F8,0x000,0x000, // )
//   41   0x000,0x18C,0x0D8,0x070,0x070,0x0D8,0x18C,0x000, // *  ×
//   42   0x000,0x020,0x020,0x0F8,0x0F8,0x020,0x020,0x000, // + 
//   43   0x020,0x020,0x010,0x00F,0x000,0x000,0x000,0x000, // , 右下角
//   44   0x000,0x020,0x020,0x020,0x020,0x020,0x020,0x000, // -
//   45   0x000,0x000,0x300,0x300,0x000,0x000,0x000,0x000, // .
//   46   0x180,0x0C0,0x060,0x030,0x018,0x00C,0x006,0x000, // / 
//   47   0x1FC,0x3FE,0x242,0x222,0x212,0x3FE,0x1FC,0x000, // 0
//   48   0x000,0x208,0x20C,0x3FE,0x3FE,0x200,0x200,0x000, // 1
//   49   0x304,0x386,0x2C2,0x262,0x232,0x31E,0x30C,0x000, // 2
//   50   0x104,0x306,0x222,0x222,0x222,0x3FE,0x1DC,0x000, // 3
//   51   0x060,0x070,0x058,0x24C,0x3FE,0x3FE,0x240,0x000, // 4
//   52   0x11E,0x21E,0x212,0x212,0x212,0x3F2,0x1E2,0x000, // 5
//   53   0x1F8,0x3FC,0x226,0x222,0x222,0x3E0,0x1C0,0x000, // 6
//   54   0x006,0x006,0x3C2,0x3E2,0x032,0x01E,0x00E,0x000, // 7
//   55   0x1DC,0x3FE,0x222,0x222,0x222,0x3FE,0x1DC,0x000, // 8
//   56   0x01C,0x23E,0x222,0x222,0x322,0x1FE,0x0FC,0x000, // 9
//   57   0x000,0x000,0x000,0x198,0x198,0x000,0x000,0x000, // : 
//   58   0x2FA,0x2FA,0x2FA,0x2FA,0x2FA,0x2FA,0x2FA,0x2FA, // ; 电池身
//   59   0x000,0x020,0x070,0x0D8,0x18C,0x306,0x202,0x000, // <
//   60   0x090,0x090,0x090,0x090,0x090,0x090,0x000,0x000, // =  
//   61   0x000,0x202,0x306,0x18C,0x0D8,0x070,0x020,0x000, // >
//   62   0x018,0x01C,0x004,0x344,0x364,0x03C,0x018,0x000, // ? 
//   63   0x1F8,0x104,0x272,0x272,0x2F2,0x284,0x078,0x000, // @ 
//   64   0x3F0,0x3F8,0x04C,0x046,0x04C,0x3F8,0x3F0,0x000, // A
//   65   0x202,0x3FE,0x3FE,0x222,0x222,0x3FE,0x1DC,0x000, // B
//   66   0x0F8,0x1FC,0x306,0x202,0x202,0x306,0x18C,0x000, // C
//   67   0x202,0x3FE,0x3FE,0x202,0x306,0x1FC,0x0F8,0x000, // D
//   68   0x202,0x3FE,0x3FE,0x222,0x272,0x306,0x38E,0x000, // E
//   69   0x202,0x3FE,0x3FE,0x222,0x072,0x006,0x00E,0x000, // F
//   70   0x0F8,0x1FC,0x306,0x222,0x222,0x1E6,0x3EC,0x000, // G
//   71   0x3FE,0x3FE,0x020,0x020,0x020,0x3FE,0x3FE,0x000, // H
//   72   0x000,0x000,0x202,0x3FE,0x3FE,0x202,0x000,0x000, // I
//   73   0x1C0,0x3C0,0x200,0x202,0x3FE,0x1FE,0x002,0x000, // J
//   74   0x202,0x3FE,0x3FE,0x030,0x0F8,0x3CE,0x306,0x000, // K
//   75   0x202,0x3FE,0x3FE,0x202,0x200,0x200,0x300,0x000, // L
//   76   0x3FE,0x3FE,0x01C,0x038,0x01C,0x3FE,0x3FE,0x000, // M
//   77   0x3FE,0x3FE,0x01C,0x038,0x070,0x3FE,0x3FE,0x000, // N
//   78   0x0F8,0x1FC,0x306,0x202,0x306,0x1FC,0x0F8,0x000, // O
//   79   0x202,0x3FE,0x3FE,0x222,0x022,0x03E,0x01C,0x000, // P
//   80   0x1FC,0x3FE,0x202,0x282,0x302,0x3FE,0x1FC,0x000, // Q
//   81   0x202,0x3FE,0x3FE,0x022,0x062,0x3FE,0x39C,0x000, // R
//   82   0x10C,0x31E,0x232,0x222,0x262,0x3CE,0x18C,0x000, // S
//   83   0x000,0x00E,0x206,0x3FE,0x3FE,0x206,0x00E,0x000, // T
//   84   0x1FE,0x3FE,0x200,0x200,0x200,0x3FE,0x1FE,0x000, // U
//   85   0x07E,0x0FE,0x180,0x300,0x180,0x0FE,0x07E,0x000, // V
//   86   0x0FE,0x3FE,0x380,0x1E0,0x380,0x3FE,0x0FE,0x000, // W
//   87   0x306,0x3DE,0x0F8,0x020,0x0F8,0x3DE,0x306,0x000, // X
//   88   0x000,0x01E,0x23E,0x3E0,0x3E0,0x23E,0x01E,0x000, // Y
//   89   0x38E,0x3C6,0x262,0x232,0x31E,0x38E,0x000,0x000, // Z
//   90   0x200,0x300,0x2C0,0x220,0x218,0x204,0x3FE,0x000, // [ 三角       
//   91   0x000,0x022,0x042,0x1FE,0x3FE,0x240,0x220,0x000, // \下降沿   
//   92   0x020,0x010,0x008,0x006,0x008,0x010,0x020,0x020, // ] 指针    
//   93   0x000,0x220,0x210,0x3FC,0x3FE,0x012,0x022,0x000, // ^ 上升沿  
//   94   0x000,0x200,0x200,0x200,0x200,0x200,0x200,0x000, // _ 下横线  
//   95   0x202,0x202,0x202,0x202,0x202,0x202,0x202,0x202, // ` 电池身空
//   96   0x1C0,0x3E8,0x228,0x228,0x1F8,0x3F0,0x200,0x000, // a         
//   97   0x202,0x3FE,0x1FE,0x220,0x220,0x3E0,0x1C0,0x000, // b 
//   98   0x1E0,0x3F0,0x210,0x210,0x210,0x330,0x120,0x000, // c 
//   99   0x000,0x1C0,0x3E0,0x220,0x222,0x3FE,0x3FE,0x000, // d 
//  100   0x1E0,0x3F0,0x250,0x250,0x250,0x370,0x160,0x000, // e 
//  101   0x000,0x220,0x3FC,0x3FE,0x222,0x002,0x004,0x000, // f
//  102   0x130,0x378,0x248,0x248,0x3F8,0x1F8,0x000,0x000, // g
//  103   0x202,0x3FE,0x3FE,0x020,0x010,0x3F0,0x3E0,0x000, // h
//  104   0x000,0x000,0x200,0x3F6,0x3F6,0x200,0x000,0x000, // i 
//  105   0x000,0x100,0x300,0x210,0x3F6,0x1F6,0x000,0x000, // j
//  106   0x202,0x3FE,0x3FE,0x062,0x0F0,0x398,0x308,0x000, // k
//  107   0x000,0x000,0x202,0x3FE,0x3FE,0x200,0x000,0x000, // l
//  108   0x3F8,0x3F8,0x018,0x3F0,0x018,0x3F8,0x3F0,0x000, // m 
//  109   0x008,0x3F8,0x3F0,0x008,0x008,0x3F8,0x3F0,0x000, // n 
//  110   0x000,0x1F0,0x3F8,0x208,0x208,0x3F8,0x1F0,0x000, // o
//  111   0x208,0x3F8,0x3F0,0x248,0x048,0x078,0x030,0x000, // p 
//  112   0x030,0x078,0x048,0x248,0x3F8,0x3F8,0x200,0x000, // q
//  113   0x208,0x3F8,0x3F0,0x218,0x008,0x018,0x030,0x000, // r 
//  114   0x000,0x110,0x338,0x268,0x248,0x3D8,0x190,0x000, // s 
//  115   0x010,0x010,0x1F8,0x3FC,0x210,0x310,0x100,0x000, // t
//  116   0x1F8,0x3F8,0x200,0x200,0x1F8,0x3F8,0x200,0x000, // u 
//  117   0x000,0x0F8,0x1F8,0x300,0x300,0x1F8,0x0F8,0x000, // v
//  118   0x0F8,0x3F8,0x300,0x180,0x300,0x3F8,0x0F8,0x000, // w
//  119   0x208,0x318,0x1B0,0x0E0,0x1B0,0x318,0x208,0x000, // x
//  120   0x038,0x278,0x240,0x240,0x240,0x1F8,0x0F8,0x000, // y
//  121   0x318,0x388,0x2C8,0x268,0x238,0x318,0x000,0x000, // z 
//  122   0x0F8,0x088,0x38E,0x022,0x2FA,0x2FA,0x2FA,0x2FA, // { 电池头
//  123   0x000,0x000,0x000,0x3FE,0x3FE,0x000,0x000,0x000, // | 
//  124   0x2FA,0x2FA,0x2FA,0x2FA,0x2FA,0x202,0x3FE,0x000, // } 电池尾
//  125   0x0F8,0x088,0x38E,0x202,0x202,0x202,0x202,0x202};// ~ 空电池头
//  126 

        SECTION `.rodata`:CONST:NOROOT(2)
//  127 uc8  Ref_Wave [300] =   //样本波形描述
Ref_Wave:
        DATA
        DC8 100, 116, 130, 144, 157, 167, 175, 181, 185, 185, 184, 179, 173
        DC8 164, 153, 141, 128, 114, 100, 86, 73, 60, 49, 40, 33, 27, 24, 24
        DC8 25, 29, 35, 43, 52, 63, 75, 87, 100, 112, 124, 135, 145, 153, 160
        DC8 164, 167, 167, 166, 163, 157, 150, 142, 133, 122, 111, 100, 89, 79
        DC8 70, 61, 54, 48, 44, 42, 42, 43, 46, 50, 57, 64, 72, 81, 90, 100
        DC8 109, 118, 126, 133, 139, 144, 147, 149, 149, 148, 146, 142, 137
        DC8 130, 124, 116, 108, 100, 93, 85, 79, 73, 68, 64, 61, 60, 60, 61, 63
        DC8 66, 70, 75, 81, 87, 93, 100, 106, 112, 117, 122, 125, 128, 130, 131
        DC8 131, 131, 129, 126, 123, 119, 115, 110, 105, 100, 96, 91, 88, 84
        DC8 81, 79, 78, 77, 78, 78, 80, 82, 84, 87, 90, 93, 97, 100, 103, 106
        DC8 108, 110, 112, 113, 114, 114, 113, 113, 112, 110, 109, 107, 105
        DC8 104, 102, 100, 99, 97, 96, 96, 95, 95, 95, 95, 96, 96, 97, 97, 98
        DC8 99, 99, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100
        DC8 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100
        DC8 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100
        DC8 100, 100, 100, 100, 100, 100, 100, 100, 100, 115, 129, 141, 151
        DC8 160, 165, 169, 170, 169, 167, 162, 156, 148, 139, 130, 120, 110
        DC8 100, 91, 82, 75, 68, 63, 59, 57, 56, 56, 58, 61, 64, 69, 75, 81, 87
        DC8 94, 100, 106, 112, 117, 121, 125, 127, 129, 130, 130, 128, 127, 124
        DC8 121, 117, 113, 109, 104, 100, 96, 92, 88, 85, 83, 81, 80, 79, 79
        DC8 80, 81, 83, 85, 88, 91, 94, 97, 100, 103, 106, 108
//  128 {100,116,130,144,157,167,175,181,185,185,184,179,173,164,153,141,128,114,100, 86,
//  129   73, 60, 49, 40, 33, 27, 24, 24, 25, 29, 35, 43, 52, 63, 75, 87,100,112,124,135,
//  130  145,153,160,164,167,167,166,163,157,150,142,133,122,111,100, 89, 79, 70, 61, 54,
//  131   48, 44, 42, 42, 43, 46, 50, 57, 64, 72, 81, 90,100,109,118,126,133,139,144,147,
//  132  149,149,148,146,142,137,130,124,116,108,100, 93, 85, 79, 73, 68, 64, 61, 60, 60,
//  133   61, 63, 66, 70, 75, 81, 87, 93,100,106,112,117,122,125,128,130,131,131,131,129,
//  134  126,123,119,115,110,105,100, 96, 91, 88, 84, 81, 79, 78, 77, 78, 78, 80, 82, 84, 
//  135   87, 90, 93, 97,100,103,106,108,110,112,113,114,114,113,113,112,110,109,107,105,
//  136  104,102,100,99, 97, 96, 96, 95, 95, 95, 95, 96, 96, 97, 97, 98, 99, 99, 100,100,
//  137  100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,
//  138  100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,
//  139  100,100,100,100,100,115,129,141,151,160,165,169,170,169,167,162,156,148,139,130,
//  140  120,110,100, 91, 82, 75, 68, 63, 59, 57, 56, 56, 58, 61, 64, 69, 75, 81, 87, 94,
//  141  100,106,112,117,121,125,127,129,130,130,128,127,124,121,117,113,109,104,100, 96, 
//  142   92, 88, 85, 83, 81, 80, 79, 79, 80, 81, 83, 85, 88, 91, 94, 97,100,103,106,108,};
//  143 

        SECTION `.rodata`:CONST:NOROOT(2)
//  144 uc16  Row_Base0[201] =     //空白列基础数据
Row_Base0:
        DATA
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0
        DC8 0, 0
//  145 {BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
//  146  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
//  147  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 20~30
//  148  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
//  149  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
//  150  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
//  151  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
//  152  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 70~80
//  153  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
//  154  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
//  155  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
//  156  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
//  157  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 20~30
//  158  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
//  159  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
//  160  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
//  161  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
//  162  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 70~80
//  163  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
//  164  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
//  165  BLACK };
//  166    

        SECTION `.rodata`:CONST:NOROOT(2)
//  167 uc16  Row_Base1[201] =     //仅含垂直边线的列基础数据
Row_Base1:
        DATA
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727, 31727
        DC16 31727, 31727, 31727
        DC8 0, 0
//  168 {GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 00~10
//  169  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 10~20
//  170  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 20~30
//  171  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 30~40
//  172  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 40~50
//  173  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 50~60
//  174  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 60~70
//  175  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 70~80
//  176  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 80~90
//  177  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 90~00
//  178  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 00~10
//  179  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 10~20
//  180  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 20~30
//  181  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 30~40
//  182  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 40~50
//  183  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 50~60
//  184  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 60~70
//  185  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 70~80
//  186  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 80~90
//  187  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 90~00
//  188  GRAY };
//  189    
//  190 uc16  Row_Base2[201] =     //仅含水平边线的列基础数据
Row_Base2:
        DC16 31727, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 31727
        DC8 0, 0
//  191 {GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
//  192  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
//  193  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 20~30
//  194  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
//  195  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
//  196  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
//  197  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
//  198  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 70~80
//  199  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
//  200  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
//  201  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
//  202  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
//  203  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 20~30
//  204  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
//  205  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
//  206  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
//  207  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
//  208  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 70~80
//  209  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
//  210  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
//  211  GRAY };
//  212    
//  213 uc16  Row_Base3[201] =     //含水平格线和水平边线的列基础数据
Row_Base3:
        DC16 31727, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 31727, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 31727, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 31727
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 31727, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 31727
        DC8 0, 0
//  214 {GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
//  215  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
//  216  BLACK,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 20~30
//  217  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
//  218  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
//  219  GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
//  220  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
//  221  BLACK,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 70~80
//  222  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
//  223  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
//  224  GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
//  225  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
//  226  BLACK,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 20~30
//  227  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
//  228  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
//  229  GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
//  230  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
//  231  BLACK,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 70~80
//  232  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
//  233  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
//  234  GRAY };
//  235    
//  236 uc16  Row_Base4[201] =     //含垂直格线和水平边线的列基础数据
Row_Base4:
        DC16 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0
        DC16 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0
        DC16 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0
        DC16 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0
        DC16 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0
        DC16 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0
        DC16 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0
        DC16 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0
        DC16 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0
        DC16 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0
        DC16 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0, 0, 0, 0, 31727, 0
        DC16 0, 0, 0, 31727, 0, 0, 0, 0, 31727
        DC8 0, 0
//  237 {GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 00~10
//  238  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 10~20
//  239  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 20~30
//  240  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 30~40
//  241  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 40~50
//  242  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 50~60
//  243  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 60~70
//  244  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 70~80
//  245  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 80~90
//  246  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 90~00
//  247  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 00~10
//  248  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 10~20
//  249  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 20~30
//  250  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 30~40
//  251  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 40~50
//  252  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 50~60
//  253  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 60~70
//  254  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 70~80
//  255  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 80~90
//  256  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 90~00
//  257  GRAY };
//  258    

        SECTION `.data`:DATA:NOROOT(2)
//  259 u16 Color[16] = { CYAN,   // #0  TRACK1 
//  260                   YEL,    // #1  TRACK2
//  261                   PURPL,  // #2  TRACK3 
//  262                   GRN,    // #3  TRACK4 
//  263                   WHT,    // #4  VERNIE   
//  264                   BLACK,  // #5  SCRN
//  265                   ORANGE, // #6  X_POSI 
//  266                   BLUE,   // #7  TRIGG 
//  267                   CYAN,   // #8  VERNIE  
//  268                   GRAY,   // #9  GRID 
//  269                   WHT,    // #10 TEXT 
//  270                   GRN,    // #11 TEXT2
//  271                   BLUE,   // #12 TEXT3
//  272                   GRAY,   // #13 BLOCK
//  273                   YEL,    // #14 SIDE
//  274                   RED };  // #15 NOTE 
//  275 
//  276 trigg V_Trigg[4] = {// Value,  Flag:( HID=0x04, UPDAT=0x02 )
//  277                      {   175,  UPDAT + HID },
//  278                      {   116,  UPDAT       },
//  279                      {    75,  UPDAT + HID },
//  280                      {    35,  UPDAT + HID },
//  281                    };
//  282 u16 LCD_Buffer1[240], LCD_Buffer2[240];
LCD_Buffer1:
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
LCD_Buffer2:
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
Color:
        DC16 65504, 2047, 63519, 2016, 65535, 0, 1311, 63488, 65504, 31727
        DC16 65535, 2016, 63488, 31727, 2047, 31
V_Trigg:
        DC16 175
        DC8 6, 0
        DC16 116
        DC8 2, 0
        DC16 75
        DC8 6, 0
        DC16 35
        DC8 6, 0

        SECTION `.data`:DATA:NOROOT(0)
//  283 u8  Vt1=180, Vt2=128, Vt3=70, Vt4=30;
Vt1:
        DATA
        DC8 180

        SECTION `.data`:DATA:NOROOT(0)
Vt2:
        DATA
        DC8 128

        SECTION `.data`:DATA:NOROOT(0)
Vt3:
        DATA
        DC8 70

        SECTION `.data`:DATA:NOROOT(0)
Vt4:
        DATA
        DC8 30
//  284 
//  285 /*******************************************************************************
//  286  Get_TAB_8x11
//  287 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Get_TAB_8x11
        THUMB
//  288 u16 Get_TAB_8x11(u8 Code, u8 Row)
//  289 {
//  290   return Char_TAB_8x11[((Code-0x22)*8)+Row];
Get_TAB_8x11:
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable3  ;; Char_TAB_8x11
        ADD      R0,R1,R0, LSL #+1
        SUB      R0,R0,#+544
        LDRH     R0,[R0, #+0]
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//  291 }
//  292 /*******************************************************************************
//  293  Get_Ref_Wave: 
//  294 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function Get_Ref_Wave
        THUMB
//  295 u8 Get_Ref_Wave(u16 i)
//  296 {
//  297   return Ref_Wave[i];
Get_Ref_Wave:
        LDR.N    R1,??Get_Ref_Wave_0  ;; Ref_Wave
        LDRB     R0,[R0, R1]
        BX       LR               ;; return
        Nop      
        DATA
??Get_Ref_Wave_0:
        DC32     Ref_Wave
        CFI EndBlock cfiBlock1
//  298 }
//  299 /*******************************************************************************
//  300  Print_Clk: 进度指示
//  301 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Print_Clk
        THUMB
//  302 void Print_Clk(u16 x0, u16 y0, u16 Type, u8 Phase)
//  303 {
Print_Clk:
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
        MOVS     R4,R2
        MOVS     R5,R3
//  304   u16 i, j, b;
//  305   
//  306   __LCD_Set_Block(x0, x0+10, y0, y0+10);
        ADD      R3,R1,#+10
        UXTH     R3,R3
        MOVS     R2,R1
        ADD      R1,R0,#+10
        UXTH     R1,R1
        BL       __LCD_Set_Block
//  307   for(i=0; i<11; ++i){
        MOVS     R0,#+11
        MULS     R0,R5,R0
        LDR.N    R1,??Print_Clk_0  ;; CLK_TAB
        ADD      R5,R1,R0, LSL #+1
        MOVS     R6,#+11
        AND      R7,R4,#0xF
        ASRS     R4,R4,#+8
//  308     b = CLK_TAB[Phase *11 + i];
??Print_Clk_1:
        LDRH     R9,[R5, #+0]
//  309     for(j=0; j<11; ++j){
        MOV      R8,#+0
//  310       if((b >> j)& 0x001) __LCD_SetPixl(Color[Type >> 0x8]);
??Print_Clk_2:
        LDR.W    R0,??DataTable34  ;; LCD_Buffer1
        MOV      R1,R8
        ASR      R1,R9,R1
        TST      R1,#0x1
        BEQ.N    ??Print_Clk_3
        ADD      R0,R0,#+960
        LDRH     R0,[R0, R4, LSL #+1]
        B.N      ??Print_Clk_4
//  311       else                __LCD_SetPixl(Color[Type & 0x0F]);
??Print_Clk_3:
        ADD      R0,R0,#+960
        LDRH     R0,[R0, R7, LSL #+1]
??Print_Clk_4:
        BL       __LCD_SetPixl
//  312     }
        ADD      R8,R8,#+1
        UXTH     R0,R8
        CMP      R0,#+11
        BCC.N    ??Print_Clk_2
//  313   }
        ADDS     R5,R5,#+2
        SUBS     R6,R6,#+1
        BNE.N    ??Print_Clk_1
//  314   __LCD_Set_Block(LCD_X1,LCD_X2,LCD_Y1,LCD_Y2);  //恢复全尺寸窗口
        MOVS     R3,#+239
        MOVS     R2,#+0
        MOVW     R1,#+399
        MOVS     R0,#+0
        ADD      SP,SP,#+4
        CFI CFA R13+28
        POP      {R4-R9,LR}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R7 SameValue
        CFI R8 SameValue
        CFI R9 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      __LCD_Set_Block
        Nop      
        DATA
??Print_Clk_0:
        DC32     CLK_TAB
        CFI EndBlock cfiBlock2
//  315 }
//  316 /*******************************************************************************
//  317  Print_Str: 
//  318 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Print_Str
        THUMB
//  319 void Print_Str(u16 x0, u16 y0, u16 Type, u8 Mode, u8 *s)
//  320 { 
Print_Str:
        PUSH     {R2,R4-R11,LR}
        CFI R14 Frame(CFA, -4)
        CFI R11 Frame(CFA, -8)
        CFI R10 Frame(CFA, -12)
        CFI R9 Frame(CFA, -16)
        CFI R8 Frame(CFA, -20)
        CFI R7 Frame(CFA, -24)
        CFI R6 Frame(CFA, -28)
        CFI R5 Frame(CFA, -32)
        CFI R4 Frame(CFA, -36)
        CFI CFA R13+40
        MOVS     R4,R3
        LDR      R5,[SP, #+40]
        ADD      R3,R1,#+10
        UXTH     R3,R3
        MOVS     R2,R1
        MOVW     R1,#+399
//  321   signed short i, j, b; 
//  322   __LCD_Set_Block(x0, LCD_X2, y0, y0+10);
        BL       __LCD_Set_Block
//  323   for (j=0; j<11;++j){ 
        MOVS     R7,#+11
        LDRH     R0,[SP, #+0]
        AND      R8,R0,#0xF
        ASR      R9,R0,#+8
        LDR.W    R6,??DataTable34  ;; LCD_Buffer1
//  324     if(Mode == 0) __LCD_SetPixl(Color[Type & 0x0F]);   //Normal replace Display
??Print_Str_0:
        CBNZ     R4,??Print_Str_1
        ADD      R0,R6,#+960
        LDRH     R0,[R0, R8, LSL #+1]
        B.N      ??Print_Str_2
//  325     else          __LCD_SetPixl(Color[Type >> 0x8]);   //Inverse replace Display
??Print_Str_1:
        ADD      R0,R6,#+960
        LDRH     R0,[R0, R9, LSL #+1]
??Print_Str_2:
        BL       __LCD_SetPixl
//  326   }
        SUBS     R7,R7,#+1
        BNE.N    ??Print_Str_0
//  327   x0++;                            // 每一个字符串前增加一空白列 
//  328   while (*s!=0) {
??Print_Str_3:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+0
        BEQ.N    ??Print_Str_4
//  329     for(i=0;i<8;++i){
        MOVS     R7,#+0
        LDRH     R0,[SP, #+0]
        AND      R8,R0,#0xF
        ASR      R9,R0,#+8
//  330       if((*s==0x20)||(*s==0x21)) b = 0x0000;
??Print_Str_5:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+32
        BEQ.N    ??Print_Str_6
        CMP      R0,#+33
        BNE.N    ??Print_Str_7
??Print_Str_6:
        MOV      R11,#+0
//  331       else                       b = Get_TAB_8x11(*s, i);
//  332       if((*s==0x21)&&(i==4)) break;
        CMP      R0,#+33
        BNE.N    ??Print_Str_8
        CMP      R7,#+4
        BEQ.N    ??Print_Str_9
//  333       for(j=0;j<11;++j){
??Print_Str_8:
        MOV      R10,#+0
//  334         if((b << j)& 0x400) {
??Print_Str_10:
        MOV      R0,R10
        LSL      R0,R11,R0
        TST      R0,#0x400
        BEQ.N    ??Print_Str_11
//  335           if(Mode == 0) __LCD_SetPixl(Color[Type >> 0x8]);
        CBNZ     R4,??Print_Str_12
??Print_Str_13:
        ADD      R0,R6,#+960
        LDRH     R0,[R0, R9, LSL #+1]
??Print_Str_14:
        BL       __LCD_SetPixl
        ADD      R10,R10,#+1
        CMP      R10,#+11
        BLT.N    ??Print_Str_10
        ADDS     R7,R7,#+1
        CMP      R7,#+8
        BLT.N    ??Print_Str_5
//  336           else          __LCD_SetPixl(Color[Type & 0x0F]);
//  337         } else {
//  338           if(Mode == 0) __LCD_SetPixl(Color[Type & 0x0F]);
//  339           else          __LCD_SetPixl(Color[Type >> 0x8]);
//  340         }
//  341       }
//  342     }
//  343     if(*s==0x21) x0 +=4;           //显示位置水平方向+4
//  344     else  x0 += 8;                 //显示位置水平方向+8
//  345     ++s;                           //字符串指针+1
??Print_Str_9:
        ADDS     R5,R5,#+1
        B.N      ??Print_Str_3
??Print_Str_7:
        UXTB     R1,R7
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable3  ;; Char_TAB_8x11
        ADD      R0,R1,R0, LSL #+1
        SUB      R0,R0,#+544
        LDRSH    R11,[R0, #+0]
        B.N      ??Print_Str_8
??Print_Str_11:
        CMP      R4,#+0
        BNE.N    ??Print_Str_13
??Print_Str_12:
        ADD      R0,R6,#+960
        LDRH     R0,[R0, R8, LSL #+1]
        B.N      ??Print_Str_14
//  346   }
//  347   __LCD_Set_Block(LCD_X1,LCD_X2,LCD_Y1,LCD_Y2);  //恢复全尺寸窗口
??Print_Str_4:
        MOVS     R3,#+239
        MOVS     R2,#+0
        MOVW     R1,#+399
        ADD      SP,SP,#+4
        CFI CFA R13+36
        POP      {R4-R11,LR}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R7 SameValue
        CFI R8 SameValue
        CFI R9 SameValue
        CFI R10 SameValue
        CFI R11 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      __LCD_Set_Block
        CFI EndBlock cfiBlock3
//  348 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable3:
        DC32     Char_TAB_8x11
//  349 /*******************************************************************************
//  350  Draw_Row : 为缓解DMA冲突，分两个缓冲区交替工作
//  351 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Draw_Row
        THUMB
//  352 void Draw_Row(u16 Row)
//  353 { 
Draw_Row:
        PUSH     {R4-R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI R7 Frame(CFA, -8)
        CFI R6 Frame(CFA, -12)
        CFI R5 Frame(CFA, -16)
        CFI R4 Frame(CFA, -20)
        CFI CFA R13+20
        SUB      SP,SP,#+20
        CFI CFA R13+40
        MOVS     R5,R0
//  354   u8  i, y[8], Dot_Hide[8]; 
//  355   s16 Tmp, m, n ;
//  356   if((Row > MIN_X)&&(Row <= MAX_X)){               // 波形显示区数据预处理
        CMP      R5,#+12
        BCC.N    ??Draw_Row_0
        MOV      R0,#+312
        CMP      R5,R0
        BCS.N    ??Draw_Row_0
//  357     m = (Row - MIN_X-1)* 4;
        SUB      R0,R5,#+12
        SXTH     R0,R0
        LSLS     R2,R0,#+2
        SXTH     R2,R2
//  358     n = (Row - MIN_X)  * 4;
        SUB      R0,R5,#+11
        SXTH     R0,R0
        LSLS     R3,R0,#+2
        SXTH     R3,R3
//  359     for(i = 0; i < 8; i += 2) {
        MOVS     R0,#+0
        ADD      R12,SP,#+8
        ADD      LR,SP,#+0
        LDR.W    R4,??Draw_Row_1  ;; TrackBuff
//  360       Dot_Hide[i] = 0;
??Draw_Row_2:
        MOVS     R1,#+0
        STRB     R1,[R12, #+0]
//  361       y[i]   = TrackBuff[m + i/2];                  // 端点提取
        ASRS     R1,R0,#+1
        ADDS     R6,R1,R2
        LDRB     R6,[R6, R4]
        STRB     R6,[LR, #+0]
//  362       y[i+1] = TrackBuff[n + i/2];
        ADDS     R1,R1,R3
        LDRB     R1,[R1, R4]
        STRB     R1,[LR, #+1]
//  363       
//  364       if(y[i]   >= Y_BASE+Y_SIZE)  y[i]   = Y_BASE+Y_SIZE-1;      // 超界处理
        CMP      R6,#+200
        BCC.N    ??Draw_Row_3
        MOVS     R6,#+199
        STRB     R6,[LR, #+0]
        B.N      ??Draw_Row_4
//  365       else if(y[i]   <= Y_BASE+1)  y[i]   = Y_BASE+1;   
??Draw_Row_3:
        CMP      R6,#+2
        BCS.N    ??Draw_Row_4
        MOVS     R6,#+1
        STRB     R6,[LR, #+0]
//  366       if(y[i+1] >= Y_BASE+Y_SIZE)  y[i+1] = Y_BASE+Y_SIZE-1;
??Draw_Row_4:
        CMP      R1,#+200
        BCC.N    ??Draw_Row_5
        MOVS     R1,#+199
        STRB     R1,[LR, #+1]
        B.N      ??Draw_Row_6
//  367       else if(y[i+1] <= Y_BASE+1)  y[i+1] = Y_BASE+1;
??Draw_Row_5:
        CMP      R1,#+2
        BCS.N    ??Draw_Row_6
        MOVS     R1,#+1
        STRB     R1,[LR, #+1]
//  368       
//  369       if(y[i] == y[i+1]){
??Draw_Row_6:
        LDRB     R1,[LR, #+0]
        LDRB     R6,[LR, #+1]
        CMP      R1,R6
        BNE.N    ??Draw_Row_7
//  370         if((y[i] == Y_BASE+1)||(y[i] == Y_SIZE-1)) Dot_Hide[i] = 1;  // 超界消隐
        CMP      R1,#+1
        BEQ.N    ??Draw_Row_8
        CMP      R1,#+199
        BNE.N    ??Draw_Row_9
??Draw_Row_8:
        MOVS     R1,#+1
        STRB     R1,[R12, #+0]
        B.N      ??Draw_Row_7
//  371         else {
//  372           if(y[i] >= Y_BASE+2)           y[i]   -= 1;              // 水平线加粗
??Draw_Row_9:
        CMP      R1,#+2
        BCC.N    ??Draw_Row_10
        SUBS     R1,R1,#+1
        STRB     R1,[LR, #+0]
//  373           if(y[i+1] <= Y_BASE+Y_SIZE-2)  y[i+1] += 1;
??Draw_Row_10:
        CMP      R6,#+199
        BCS.N    ??Draw_Row_7
        ADDS     R1,R6,#+1
        STRB     R1,[LR, #+1]
//  374         }
//  375       }
//  376       if(y[i] > y[i+1]){                                             // 大小排序
??Draw_Row_7:
        LDRB     R1,[LR, #+1]
        LDRB     R6,[LR, #+0]
        CMP      R1,R6
        ITT      CC 
//  377         Tmp = y[i+1]; y[i+1]= y[i]; y[i]= Tmp; 
        STRBCC   R6,[LR, #+1]
        STRBCC   R1,[LR, #+0]
//  378       }
//  379     }
        ADDS     R0,R0,#+2
        ADD      LR,LR,#+2
        ADD      R12,R12,#+2
        UXTB     R1,R0
        CMP      R1,#+8
        BCC.N    ??Draw_Row_2
//  380   } 
//  381   __Row_DMA_Ready();
??Draw_Row_0:
        BL       __Row_DMA_Ready
//  382   __Point_SCR(Row, MIN_Y);
        MOVS     R1,#+13
        MOVS     R0,R5
        BL       __Point_SCR
//  383   
//  384   if(Row & 1){                                       // Odd row process
        TST      R5,#0x1
        BEQ.W    ??Draw_Row_11
//  385 //----------------------- Fill the row base data -------------------------------
//  386     __Row_Copy(Row_Base2, LCD_Buffer1);
        LDR.W    R4,??DataTable34  ;; LCD_Buffer1
        MOVS     R1,R4
        LDR.W    R0,??Draw_Row_1+0x4  ;; Row_Base1 + 404
        BL       __Row_Copy
//  387 //------------------------- Draw the Curve data --------------------------------
//  388     if((Row > MIN_X)&&(Row < MAX_X)){             
        CMP      R5,#+12
        BCC.W    ??Draw_Row_12
        MOVW     R7,#+311
        CMP      R5,R7
        BCS.W    ??Draw_Row_13
//  389       if((Dot_Hide[0] == 0)&&(Title[TRACK1][SOURCE].Value != HIDE)){
        LDR.W    R2,??DataTable12  ;; Title
        LDRB     R0,[SP, #+8]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_14
        LDRSH    R0,[R2, #+16]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_14
//  390         if((y[1]-y[0])>5){
        LDRB     R0,[SP, #+0]
        ADD      R3,SP,#+0
        LDRB     R1,[R3, #+1]
        SUBS     R3,R1,R0
        CMP      R3,#+6
        BLT.N    ??Draw_Row_15
//  391           for(i=y[0]; i<=y[1]; ++i) LCD_Buffer2[i] |=Color[TR_1]-0x4200; // 低亮度
        CMP      R1,R0
        BCC.N    ??Draw_Row_14
        ADD      R3,R4,R0, LSL #+1
        ADD      R3,R3,#+480
        LDRH     R12,[R4, #+960]
        SUB      R12,R12,#+16896
??Draw_Row_16:
        LDRH     LR,[R3, #+0]
        ORR      LR,R12,LR
        STRH     LR,[R3], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R1,R0
        BCC.N    ??Draw_Row_14
        B.N      ??Draw_Row_16
//  392         } else {
//  393           for(i=y[0]; i<=y[1]; ++i) LCD_Buffer2[i] |=Color[TR_1];        // 正常亮度
??Draw_Row_15:
        CMP      R1,R0
        BCC.N    ??Draw_Row_14
        ADD      R3,R4,R0, LSL #+1
        ADD      R3,R3,#+480
        LDRH     R12,[R4, #+960]
??Draw_Row_17:
        LDRH     LR,[R3, #+0]
        ORR      LR,R12,LR
        STRH     LR,[R3], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R1,R0
        BCS.N    ??Draw_Row_17
//  394         }
//  395       }
//  396       if((Dot_Hide[2] == 0)&&(Title[TRACK2][SOURCE].Value != HIDE)){
??Draw_Row_14:
        ADD      R1,SP,#+8
        LDRB     R0,[R1, #+2]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_18
        LDRSH    R0,[R2, #+96]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_18
//  397         if((y[3]-y[2])>5){
        ADD      R3,SP,#+0
        LDRB     R12,[R3, #+2]
        MOV      R0,R12
        LDRB     R3,[R3, #+3]
        SUB      R12,R3,R12
        CMP      R12,#+6
        BLT.N    ??Draw_Row_19
//  398           for(i=y[2]; i<=y[3]; ++i) LCD_Buffer2[i] |=Color[TR_2]-0x0208; // 低亮度
        CMP      R3,R0
        BCC.N    ??Draw_Row_18
        ADD      R12,R4,R0, LSL #+1
        ADD      R12,R12,#+480
        LDRH     LR,[R4, #+962]
        MOVW     R7,#+65016
        ADD      LR,R7,LR
??Draw_Row_20:
        LDRH     R6,[R12, #+0]
        ORR      R6,LR,R6
        STRH     R6,[R12], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R3,R0
        BCC.N    ??Draw_Row_18
        B.N      ??Draw_Row_20
//  399         } else {   
//  400           for(i=y[2]; i<=y[3]; ++i) LCD_Buffer2[i] |=Color[TR_2];        // 正常亮度
??Draw_Row_19:
        CMP      R3,R0
        BCC.N    ??Draw_Row_18
        ADD      R12,R4,R0, LSL #+1
        ADD      R12,R12,#+480
        LDRH     LR,[R4, #+962]
??Draw_Row_21:
        LDRH     R6,[R12, #+0]
        ORR      R6,LR,R6
        STRH     R6,[R12], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R3,R0
        BCS.N    ??Draw_Row_21
//  401         }
//  402       }
//  403       if((Dot_Hide[4] == 0)&&(Title[TRACK3][SOURCE].Value != HIDE)){
??Draw_Row_18:
        LDRB     R0,[R1, #+4]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_22
        LDRSH    R0,[R2, #+176]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_22
//  404         if((y[5]-y[4])>5){
        ADD      R3,SP,#+0
        LDRB     R12,[R3, #+4]
        MOV      R0,R12
        LDRB     R3,[R3, #+5]
        SUB      R12,R3,R12
        CMP      R12,#+6
        BLT.N    ??Draw_Row_23
//  405           for(i=y[4]; i<=y[5]; ++i) LCD_Buffer2[i] |=Color[TR_3]-0x4008; // 低亮度
        CMP      R3,R0
        BCC.N    ??Draw_Row_22
        ADD      R12,R4,R0, LSL #+1
        ADD      R12,R12,#+480
        LDRH     LR,[R4, #+964]
        MOVW     R7,#+49144
        ADD      LR,R7,LR
??Draw_Row_24:
        LDRH     R6,[R12, #+0]
        ORR      R6,LR,R6
        STRH     R6,[R12], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R3,R0
        BCC.N    ??Draw_Row_22
        B.N      ??Draw_Row_24
//  406         } else {
//  407           for(i=y[4]; i<=y[5]; ++i) LCD_Buffer2[i] |=Color[TR_3];        // 正常亮度
??Draw_Row_23:
        CMP      R3,R0
        BCC.N    ??Draw_Row_22
        ADD      R12,R4,R0, LSL #+1
        ADD      R12,R12,#+480
        LDRH     LR,[R4, #+964]
??Draw_Row_25:
        LDRH     R6,[R12, #+0]
        ORR      R6,LR,R6
        STRH     R6,[R12], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R3,R0
        BCS.N    ??Draw_Row_25
//  408         }
//  409       }
//  410       if((Dot_Hide[6] == 0)&&(Title[TRACK4][SOURCE].Value != HIDE)){
??Draw_Row_22:
        LDRB     R0,[R1, #+6]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_26
        LDRSH    R0,[R2, #+256]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_26
//  411         if((y[7]-y[6])>5){
        ADD      R3,SP,#+0
        LDRB     R12,[R3, #+6]
        MOV      R0,R12
        LDRB     R1,[R3, #+7]
        SUB      R3,R1,R12
        CMP      R3,#+6
        BLT.N    ??Draw_Row_27
//  412           for(i=y[6]; i<=y[7]; ++i) LCD_Buffer2[i] |=Color[TR_4]-0x0200; // 低亮度
        CMP      R1,R0
        BCC.N    ??Draw_Row_26
        ADD      R3,R4,R0, LSL #+1
        ADD      R3,R3,#+480
??Draw_Row_28:
        LDRH     R12,[R3, #+0]
        LDRH     LR,[R4, #+966]
        SUB      LR,LR,#+512
        ORR      R12,LR,R12
        STRH     R12,[R3], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R1,R0
        BCC.N    ??Draw_Row_26
        B.N      ??Draw_Row_28
//  413         } else {
//  414           for(i=y[6]; i<=y[7]; ++i) LCD_Buffer2[i] |=Color[TR_4];        // 正常亮度
??Draw_Row_27:
        CMP      R1,R0
        BCC.N    ??Draw_Row_26
        ADD      R3,R4,R0, LSL #+1
        ADD      R3,R3,#+480
        LDRH     R12,[R4, #+966]
??Draw_Row_29:
        LDRH     LR,[R3, #+0]
        ORR      LR,R12,LR
        STRH     LR,[R3], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R1,R0
        BCS.N    ??Draw_Row_29
//  415         }
//  416       }
//  417 //------------------------- Draw the Trigg Vernie data -------------------------
//  418       if(Title[TRIGG][SOURCE].Value == TRACK1) 
??Draw_Row_26:
        LDRSH    R0,[R2, #+576]
        CBNZ     R0,??Draw_Row_30
        LDRSH    R0,[R4, #+992]
        ADD      R0,R4,R0, LSL #+1
        LDRH     R1,[R0, #+480]
        LDRH     R3,[R4, #+960]
        ORRS     R1,R3,R1
        STRH     R1,[R0, #+480]
        B.N      ??Draw_Row_31
//  419         LCD_Buffer2[V_Trigg[TRACK1].Value] |= Color[TR_1];
//  420       if(Title[TRIGG][SOURCE].Value == TRACK2) 
??Draw_Row_30:
        CMP      R0,#+1
        BNE.N    ??Draw_Row_32
        LDRSH    R0,[R4, #+996]
        ADD      R0,R4,R0, LSL #+1
        LDRH     R1,[R0, #+480]
        LDRH     R3,[R4, #+962]
        ORRS     R1,R3,R1
        STRH     R1,[R0, #+480]
        B.N      ??Draw_Row_31
//  421         LCD_Buffer2[V_Trigg[TRACK2].Value] |= Color[TR_2];
//  422       if(Title[TRIGG][SOURCE].Value == TRACK3) 
??Draw_Row_32:
        CMP      R0,#+2
        BNE.N    ??Draw_Row_33
        LDRSH    R0,[R4, #+1000]
        ADD      R0,R4,R0, LSL #+1
        LDRH     R1,[R0, #+480]
        LDRH     R3,[R4, #+964]
        ORRS     R1,R3,R1
        STRH     R1,[R0, #+480]
        B.N      ??Draw_Row_31
//  423         LCD_Buffer2[V_Trigg[TRACK3].Value] |= Color[TR_3];
//  424       if(Title[TRIGG][SOURCE].Value == TRACK4) 
??Draw_Row_33:
        CMP      R0,#+3
        BNE.N    ??Draw_Row_31
        LDRSH    R0,[R4, #+1004]
        ADD      R0,R4,R0, LSL #+1
        LDRH     R1,[R0, #+480]
        LDRH     R3,[R4, #+966]
        ORRS     R1,R3,R1
        STRH     R1,[R0, #+480]
//  425         LCD_Buffer2[V_Trigg[TRACK4].Value] |= Color[TR_4];
//  426 //------------------------- Draw the X Vernie data -----------------------------
//  427       Tmp =(MIN_X + 150)- _X_posi.Value;
??Draw_Row_31:
        LDRH     R0,[R2, #+456]
        RSB      R0,R0,#+161
        SXTH     R0,R0
//  428       if(Tmp > MIN_X) {
        CMP      R0,#+12
        BLT.N    ??Draw_Row_34
//  429         if((Row == Tmp)&&((_X_posi.Flag & HID)== 0)){
        CMP      R5,R0
        BNE.N    ??Draw_Row_35
        ADD      R1,R2,#+458
        LDRB     R1,[R1, #+0]
        TST      R1,#0x4
        BNE.N    ??Draw_Row_35
//  430           for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer2[i] |= Color[X_POSI];
        LDRH     R1,[R4, #+972]
        ADD      R3,R4,#+482
        LDRH     R3,[R3, #+0]
        ORRS     R3,R1,R3
        ADD      R12,R4,#+482
        STRH     R3,[R12, #+0]
        ADD      R3,R4,#+488
        MOV      R12,#+11
??Draw_Row_36:
        LDRH     LR,[R3, #+0]
        ORR      LR,R1,LR
        STRH     LR,[R3, #+0]
        LDRH     LR,[R3, #+6]
        ORR      LR,R1,LR
        STRH     LR,[R3, #+6]
        LDRH     LR,[R3, #+12]
        ORR      LR,R1,LR
        STRH     LR,[R3, #+12]
        LDRH     LR,[R3, #+18]
        ORR      LR,R1,LR
        STRH     LR,[R3, #+18]
        LDRH     LR,[R3, #+24]
        ORR      LR,R1,LR
        STRH     LR,[R3, #+24]
        LDRH     LR,[R3, #+30]
        ORR      LR,R1,LR
        STRH     LR,[R3, #+30]
        ADDS     R3,R3,#+36
        SUBS     R12,R12,#+1
        BNE.N    ??Draw_Row_36
//  431         }
//  432         if((Row == Tmp-1)||(Row == Tmp+1)){
??Draw_Row_35:
        SUBS     R1,R0,#+1
        CMP      R5,R1
        BEQ.N    ??Draw_Row_37
        ADDS     R1,R0,#+1
        CMP      R5,R1
        BNE.N    ??Draw_Row_38
//  433           LCD_Buffer2[Y_SIZE] = Color[X_POSI];
??Draw_Row_37:
        LDRH     R1,[R4, #+972]
        STRH     R1,[R4, #+880]
//  434           LCD_Buffer2[Y_BASE] = Color[X_POSI];
        STRH     R1,[R4, #+480]
//  435         }
//  436         if(Row == Tmp){
??Draw_Row_38:
        CMP      R5,R0
        BNE.N    ??Draw_Row_34
//  437           LCD_Buffer2[Y_SIZE]   = Color[X_POSI];
        LDRH     R1,[R4, #+972]
        STRH     R1,[R4, #+880]
//  438           LCD_Buffer2[Y_SIZE-1] = Color[X_POSI];
        STRH     R1,[R4, #+878]
//  439           LCD_Buffer2[Y_BASE+1] = Color[X_POSI];
        ADD      R0,R4,#+482
        STRH     R1,[R0, #+0]
//  440           LCD_Buffer2[Y_BASE]   = Color[X_POSI];
        STRH     R1,[R4, #+480]
//  441         }
//  442       }
//  443       Tmp = MIN_X + Title[T_VERNIE][T1].Value;
??Draw_Row_34:
        LDRH     R0,[R2, #+816]
        ADD      R1,R0,#+11
        SXTH     R1,R1
//  444       if((Row == Tmp)&&((Title[T_VERNIE][T1].Flag & HID)== 0)){
        CMP      R5,R1
        BNE.N    ??Draw_Row_39
        LDRB     R0,[R2, #+818]
        TST      R0,#0x4
        BNE.N    ??Draw_Row_39
//  445         for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer2[i] |= Color[VERNIE];
        LDRH     R0,[R4, #+968]
        ADD      R3,R4,#+482
        LDRH     R3,[R3, #+0]
        ORRS     R3,R0,R3
        ADD      R12,R4,#+482
        STRH     R3,[R12, #+0]
        ADD      R3,R4,#+488
        MOV      R12,#+11
??Draw_Row_40:
        LDRH     LR,[R3, #+0]
        ORR      LR,R0,LR
        STRH     LR,[R3, #+0]
        LDRH     LR,[R3, #+6]
        ORR      LR,R0,LR
        STRH     LR,[R3, #+6]
        LDRH     LR,[R3, #+12]
        ORR      LR,R0,LR
        STRH     LR,[R3, #+12]
        LDRH     LR,[R3, #+18]
        ORR      LR,R0,LR
        STRH     LR,[R3, #+18]
        LDRH     LR,[R3, #+24]
        ORR      LR,R0,LR
        STRH     LR,[R3, #+24]
        LDRH     LR,[R3, #+30]
        ORR      LR,R0,LR
        STRH     LR,[R3, #+30]
        ADDS     R3,R3,#+36
        SUBS     R12,R12,#+1
        BNE.N    ??Draw_Row_40
//  446       }
//  447       if((Row == Tmp-1)||(Row == Tmp+1)){
??Draw_Row_39:
        SUBS     R0,R1,#+1
        CMP      R5,R0
        BEQ.N    ??Draw_Row_41
        ADDS     R0,R1,#+1
        CMP      R5,R0
        BNE.N    ??Draw_Row_42
//  448         LCD_Buffer2[Y_SIZE] |= Color[VERNIE];
??Draw_Row_41:
        LDRH     R0,[R4, #+968]
        LDRH     R3,[R4, #+880]
        ORRS     R3,R0,R3
        STRH     R3,[R4, #+880]
//  449         LCD_Buffer2[Y_BASE] |= Color[VERNIE];
        LDRH     R3,[R4, #+480]
        ORRS     R0,R0,R3
        STRH     R0,[R4, #+480]
//  450       }
//  451       if(Row == Tmp){
??Draw_Row_42:
        CMP      R5,R1
        BNE.N    ??Draw_Row_43
//  452         LCD_Buffer2[Y_SIZE]   |= Color[VERNIE];
        LDRH     R0,[R4, #+968]
        LDRH     R1,[R4, #+880]
        ORRS     R1,R0,R1
        STRH     R1,[R4, #+880]
//  453         LCD_Buffer2[Y_SIZE-1] |= Color[VERNIE];
        LDRH     R1,[R4, #+878]
        ORRS     R1,R0,R1
        STRH     R1,[R4, #+878]
//  454         LCD_Buffer2[Y_BASE+1] |= Color[VERNIE];
        ADD      R1,R4,#+482
        LDRH     R1,[R1, #+0]
        ORRS     R1,R0,R1
        ADD      R3,R4,#+482
        STRH     R1,[R3, #+0]
//  455         LCD_Buffer2[Y_BASE]   |= Color[VERNIE];
        LDRH     R1,[R4, #+480]
        ORRS     R0,R0,R1
        STRH     R0,[R4, #+480]
//  456       }
//  457       Tmp = MIN_X + Title[T_VERNIE][T2].Value;
??Draw_Row_43:
        LDRH     R0,[R2, #+836]
        ADD      R1,R0,#+11
        SXTH     R1,R1
//  458       if((Row == Tmp)&&((Title[T_VERNIE][T2].Flag & HID)== 0)){
        CMP      R5,R1
        BNE.N    ??Draw_Row_44
        LDRB     R0,[R2, #+838]
        TST      R0,#0x4
        BNE.N    ??Draw_Row_44
//  459         for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer2[i] |= Color[VERNIE];
        LDRH     R0,[R4, #+968]
        ADD      R2,R4,#+482
        LDRH     R2,[R2, #+0]
        ORRS     R2,R0,R2
        ADD      R3,R4,#+482
        STRH     R2,[R3, #+0]
        ADD      R2,R4,#+488
        MOVS     R3,#+11
??Draw_Row_45:
        LDRH     R12,[R2, #+0]
        ORR      R12,R0,R12
        STRH     R12,[R2, #+0]
        LDRH     R12,[R2, #+6]
        ORR      R12,R0,R12
        STRH     R12,[R2, #+6]
        LDRH     R12,[R2, #+12]
        ORR      R12,R0,R12
        STRH     R12,[R2, #+12]
        LDRH     R12,[R2, #+18]
        ORR      R12,R0,R12
        STRH     R12,[R2, #+18]
        LDRH     R12,[R2, #+24]
        ORR      R12,R0,R12
        STRH     R12,[R2, #+24]
        LDRH     R12,[R2, #+30]
        ORR      R12,R0,R12
        STRH     R12,[R2, #+30]
        ADDS     R2,R2,#+36
        SUBS     R3,R3,#+1
        BNE.N    ??Draw_Row_45
//  460       }
//  461       if((Row == Tmp-1)||(Row == Tmp+1)){
??Draw_Row_44:
        SUBS     R0,R1,#+1
        CMP      R5,R0
        BEQ.N    ??Draw_Row_46
        ADDS     R0,R1,#+1
        CMP      R5,R0
        BNE.N    ??Draw_Row_47
//  462         LCD_Buffer2[Y_SIZE] = Color[VERNIE];
??Draw_Row_46:
        LDRH     R0,[R4, #+968]
        STRH     R0,[R4, #+880]
//  463         LCD_Buffer2[Y_BASE] = Color[VERNIE];
        STRH     R0,[R4, #+480]
//  464       }
//  465       if(Row == Tmp){
??Draw_Row_47:
        CMP      R5,R1
        BNE.N    ??Draw_Row_48
//  466         LCD_Buffer2[Y_SIZE]   = Color[VERNIE];
        LDRH     R0,[R4, #+968]
        STRH     R0,[R4, #+880]
//  467         LCD_Buffer2[Y_SIZE-1] = Color[VERNIE];
        STRH     R0,[R4, #+878]
//  468         LCD_Buffer2[Y_BASE+1] = Color[VERNIE];
        ADD      R1,R4,#+482
        B.N      ??Draw_Row_49
//  469       }
//  470     } 
//  471 //------------------------- Draw the Y Vernie data -----------------------------
//  472       if((Row == MIN_X)||(Row == MAX_X)){
??Draw_Row_12:
        CMP      R5,#+11
        BNE.N    ??Draw_Row_48
        B.N      ??Draw_Row_50
??Draw_Row_13:
        BNE.N    ??Draw_Row_48
//  473         LCD_Buffer2[Title[V_VERNIE][V1].Value-1] |= Color[VERNIE];
??Draw_Row_50:
        LDR.W    R2,??DataTable12  ;; Title
        LDRSH    R0,[R2, #+656]
        ADD      R1,R4,R0, LSL #+1
        LDRH     R0,[R4, #+968]
        ADD      R3,R1,#+478
        LDRH     R3,[R3, #+0]
        ORRS     R3,R0,R3
        ADD      R12,R1,#+478
        STRH     R3,[R12, #+0]
//  474         LCD_Buffer2[Title[V_VERNIE][V1].Value+0] |= Color[VERNIE];
        LDRH     R3,[R1, #+480]
        ORRS     R3,R0,R3
        STRH     R3,[R1, #+480]
//  475         LCD_Buffer2[Title[V_VERNIE][V1].Value+1] |= Color[VERNIE];
        ADD      R3,R1,#+482
        LDRH     R3,[R3, #+0]
        ORRS     R3,R0,R3
        ADD      R1,R1,#+482
        STRH     R3,[R1, #+0]
        LDRSH    R1,[R2, #+676]
        ADD      R1,R4,R1, LSL #+1
        ADD      R2,R1,#+478
        LDRH     R2,[R2, #+0]
        ORRS     R2,R0,R2
        ADD      R3,R1,#+478
        STRH     R2,[R3, #+0]
//  476         LCD_Buffer2[Title[V_VERNIE][V2].Value-1] |= Color[VERNIE];
//  477         LCD_Buffer2[Title[V_VERNIE][V2].Value+0] |= Color[VERNIE];
        LDRH     R2,[R1, #+480]
        ORRS     R2,R0,R2
        STRH     R2,[R1, #+480]
//  478         LCD_Buffer2[Title[V_VERNIE][V2].Value+1] |= Color[VERNIE];
        ADD      R2,R1,#+482
        LDRH     R2,[R2, #+0]
        ORRS     R0,R0,R2
        ADD      R1,R1,#+482
??Draw_Row_49:
        STRH     R0,[R1, #+0]
//  479       }
//  480     __LCD_Copy(LCD_Buffer2, Y_SIZE+1);               // Odd row Transitive
??Draw_Row_48:
        MOVS     R1,#+201
        ADD      R0,R4,#+480
        B.N      ??Draw_Row_51
//  481   } else {                                           // Even row process
//  482 //----------------------- Fill the row base data -------------------------------
//  483     if(Row+1 == MAX_X)                   __Row_Copy(Row_Base1, LCD_Buffer2);
??Draw_Row_11:
        ADDS     R0,R5,#+1
        MOVW     R7,#+311
        CMP      R0,R7
        BNE.N    ??Draw_Row_52
        LDR.W    R1,??Draw_Row_1+0x8  ;; LCD_Buffer1 + 480
        LDR.W    R0,??DataTable33  ;; Row_Base1
        B.N      ??Draw_Row_53
//  484     else if(Row+1 == MIN_X)              ;
??Draw_Row_52:
        CMP      R0,#+11
        BEQ.N    ??Draw_Row_54
//  485     else if((Row+1 - MIN_X)%30 == 0)     __Row_Copy(Row_Base4, LCD_Buffer2);
        SUB      R0,R5,#+10
        MOVS     R1,#+30
        LDR.W    R2,??DataTable33  ;; Row_Base1
        LDR.W    R4,??DataTable34  ;; LCD_Buffer1
        SDIV     R3,R0,R1
        MLS      R1,R3,R1,R0
        CBNZ     R1,??Draw_Row_55
        ADD      R1,R4,#+480
        ADDW     R0,R2,#+1212
        B.N      ??Draw_Row_53
//  486     else if((Row+1 - MIN_X)%6  == 0)     __Row_Copy(Row_Base3, LCD_Buffer2);
??Draw_Row_55:
        MOVS     R1,#+6
        SDIV     R3,R0,R1
        MLS      R0,R3,R1,R0
        CBNZ     R0,??Draw_Row_56
        ADD      R1,R4,#+480
        ADD      R0,R2,#+808
        B.N      ??Draw_Row_53
//  487     else                                 __Row_Copy(Row_Base2, LCD_Buffer2);
??Draw_Row_56:
        ADD      R1,R4,#+480
        ADD      R0,R2,#+404
??Draw_Row_53:
        BL       __Row_Copy
//  488 //------------------------- Draw the Y Vernie data -----------------------------
//  489     if((Row==MIN_X+1)||(Row==MAX_X-1)){
??Draw_Row_54:
        CMP      R5,#+12
        BEQ.N    ??Draw_Row_57
        MOV      R0,#+310
        CMP      R5,R0
        BNE.N    ??Draw_Row_58
//  490         LCD_Buffer1[Title[V_VERNIE][V1].Value] |= Color[VERNIE];
??Draw_Row_57:
        LDR.W    R2,??DataTable12  ;; Title
        LDRSH    R1,[R2, #+656]
        LDR.W    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, #+968]
        LDRH     R3,[R4, R1, LSL #+1]
        ORRS     R3,R0,R3
        STRH     R3,[R4, R1, LSL #+1]
//  491         LCD_Buffer1[Title[V_VERNIE][V2].Value] |= Color[VERNIE];
        LDRSH    R1,[R2, #+676]
        LDRH     R2,[R4, R1, LSL #+1]
        ORRS     R0,R0,R2
        STRH     R0,[R4, R1, LSL #+1]
//  492     }
//  493       if((Title[V_VERNIE][V1].Flag & HID)== 0) 
??Draw_Row_58:
        LDR.W    R2,??DataTable12  ;; Title
        LDRB     R0,[R2, #+658]
        TST      R0,#0x4
        BNE.N    ??Draw_Row_59
//  494         LCD_Buffer1[Title[V_VERNIE][V1].Value] |= Color[VERNIE];
        LDRSH    R1,[R2, #+656]
        LDR.W    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, R1, LSL #+1]
        LDRH     R3,[R4, #+968]
        ORRS     R0,R3,R0
        STRH     R0,[R4, R1, LSL #+1]
//  495       if((Title[V_VERNIE][V2].Flag & HID)== 0) 
??Draw_Row_59:
        LDRB     R0,[R2, #+678]
        TST      R0,#0x4
        BNE.N    ??Draw_Row_60
//  496         LCD_Buffer1[Title[V_VERNIE][V2].Value] |= Color[VERNIE];
        LDRSH    R1,[R2, #+676]
        LDR.W    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, R1, LSL #+1]
        LDRH     R3,[R4, #+968]
        ORRS     R0,R3,R0
        STRH     R0,[R4, R1, LSL #+1]
//  497 //------------------------- Draw the Curve data --------------------------------
//  498     if((Row > MIN_X)&&(Row < MAX_X)){              
??Draw_Row_60:
        CMP      R5,#+12
        BCC.W    ??Draw_Row_61
        CMP      R5,R7
        BCS.W    ??Draw_Row_61
//  499       if((Dot_Hide[0] == 0)&&(Title[TRACK1][SOURCE].Value != HIDE)){
        LDRB     R0,[SP, #+8]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_62
        LDRSH    R0,[R2, #+16]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_62
//  500         if((y[1]-y[0])>5){
        LDRB     R0,[SP, #+0]
        ADD      R3,SP,#+0
        LDRB     R1,[R3, #+1]
        SUBS     R3,R1,R0
        CMP      R3,#+6
        BLT.N    ??Draw_Row_63
//  501           for(i=y[0]; i<=y[1]; ++i) LCD_Buffer1[i] |=Color[TR_1]-0x4200; // 低亮度
        CMP      R1,R0
        BCC.N    ??Draw_Row_62
        LDR.W    R4,??DataTable34  ;; LCD_Buffer1
        ADD      R3,R4,R0, LSL #+1
        LDRH     R12,[R4, #+960]
        SUB      R12,R12,#+16896
??Draw_Row_64:
        LDRH     LR,[R3, #+0]
        ORR      LR,R12,LR
        STRH     LR,[R3], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R1,R0
        BCC.N    ??Draw_Row_62
        B.N      ??Draw_Row_64
//  502         } else {
//  503           for(i=y[0]; i<=y[1]; ++i) LCD_Buffer1[i] |=Color[TR_1];        // 正常亮度
??Draw_Row_63:
        CMP      R1,R0
        BCC.N    ??Draw_Row_62
        LDR.W    R4,??DataTable34  ;; LCD_Buffer1
        ADD      R3,R4,R0, LSL #+1
        LDRH     R12,[R4, #+960]
??Draw_Row_65:
        LDRH     LR,[R3, #+0]
        ORR      LR,R12,LR
        STRH     LR,[R3], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R1,R0
        BCS.N    ??Draw_Row_65
//  504         }
//  505       }
//  506       if((Dot_Hide[2] == 0)&&(Title[TRACK2][SOURCE].Value != HIDE)){
??Draw_Row_62:
        ADD      R1,SP,#+8
        LDRB     R0,[R1, #+2]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_66
        LDRSH    R0,[R2, #+96]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_66
//  507         if((y[3]-y[2])>5){
        ADD      R3,SP,#+0
        LDRB     R12,[R3, #+2]
        MOV      R0,R12
        LDRB     R3,[R3, #+3]
        SUB      R12,R3,R12
        CMP      R12,#+6
        BLT.N    ??Draw_Row_67
//  508           for(i=y[2]; i<=y[3]; ++i) LCD_Buffer1[i] |=Color[TR_2]-0x0208; // 低亮度
        CMP      R3,R0
        BCC.N    ??Draw_Row_66
        LDR.W    R4,??DataTable34  ;; LCD_Buffer1
        ADD      R12,R4,R0, LSL #+1
        LDRH     LR,[R4, #+962]
        MOVW     R7,#+65016
        ADD      LR,R7,LR
??Draw_Row_68:
        LDRH     R4,[R12, #+0]
        ORR      R4,LR,R4
        STRH     R4,[R12], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R3,R0
        BCC.N    ??Draw_Row_66
        B.N      ??Draw_Row_68
//  509         } else {   
//  510           for(i=y[2]; i<=y[3]; ++i) LCD_Buffer1[i] |=Color[TR_2];        // 正常亮度
??Draw_Row_67:
        CMP      R3,R0
        BCC.N    ??Draw_Row_66
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        ADD      R12,R4,R0, LSL #+1
        LDRH     LR,[R4, #+962]
??Draw_Row_69:
        LDRH     R4,[R12, #+0]
        ORR      R4,LR,R4
        STRH     R4,[R12], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R3,R0
        BCS.N    ??Draw_Row_69
//  511         }
//  512       }
//  513       if((Dot_Hide[4] == 0)&&(Title[TRACK3][SOURCE].Value != HIDE)){
??Draw_Row_66:
        LDRB     R0,[R1, #+4]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_70
        LDRSH    R0,[R2, #+176]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_70
//  514         if((y[5]-y[4])>5){
        ADD      R3,SP,#+0
        LDRB     R12,[R3, #+4]
        MOV      R0,R12
        LDRB     R3,[R3, #+5]
        SUB      R12,R3,R12
        CMP      R12,#+6
        BLT.N    ??Draw_Row_71
//  515           for(i=y[4]; i<=y[5]; ++i) LCD_Buffer1[i] |=Color[TR_3]-0x4008; // 低亮度
        CMP      R3,R0
        BCC.N    ??Draw_Row_70
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        ADD      R12,R4,R0, LSL #+1
        LDRH     LR,[R4, #+964]
        MOVW     R7,#+49144
        ADD      LR,R7,LR
??Draw_Row_72:
        LDRH     R4,[R12, #+0]
        ORR      R4,LR,R4
        STRH     R4,[R12], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R3,R0
        BCC.N    ??Draw_Row_70
        B.N      ??Draw_Row_72
//  516         } else {
//  517           for(i=y[4]; i<=y[5]; ++i) LCD_Buffer1[i] |=Color[TR_3];        // 正常亮度
??Draw_Row_71:
        CMP      R3,R0
        BCC.N    ??Draw_Row_70
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        ADD      R12,R4,R0, LSL #+1
        LDRH     LR,[R4, #+964]
??Draw_Row_73:
        LDRH     R4,[R12, #+0]
        ORR      R4,LR,R4
        STRH     R4,[R12], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R3,R0
        BCS.N    ??Draw_Row_73
//  518         }
//  519       }
//  520       if((Dot_Hide[6] == 0)&&(Title[TRACK4][SOURCE].Value != HIDE)){
??Draw_Row_70:
        LDRB     R0,[R1, #+6]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_74
        LDRSH    R0,[R2, #+256]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_74
//  521         if((y[7]-y[6])>5){
        ADD      R3,SP,#+0
        LDRB     R12,[R3, #+6]
        MOV      R0,R12
        LDRB     R1,[R3, #+7]
        SUB      R3,R1,R12
        CMP      R3,#+6
        BLT.N    ??Draw_Row_75
//  522           for(i=y[6]; i<=y[7]; ++i) LCD_Buffer1[i] |=Color[TR_4]-0x0200; // 低亮度
        CMP      R1,R0
        BCC.N    ??Draw_Row_74
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        ADD      R3,R4,R0, LSL #+1
        LDRH     R12,[R4, #+966]
        SUB      R12,R12,#+512
??Draw_Row_76:
        LDRH     LR,[R3, #+0]
        ORR      LR,R12,LR
        STRH     LR,[R3], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R1,R0
        BCC.N    ??Draw_Row_74
        B.N      ??Draw_Row_76
//  523         } else {
//  524           for(i=y[6]; i<=y[7]; ++i) LCD_Buffer1[i] |=Color[TR_4];        // 正常亮度
??Draw_Row_75:
        CMP      R1,R0
        BCC.N    ??Draw_Row_74
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        ADD      R3,R4,R0, LSL #+1
        LDRH     R12,[R4, #+966]
??Draw_Row_77:
        LDRH     LR,[R3, #+0]
        ORR      LR,R12,LR
        STRH     LR,[R3], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R1,R0
        BCS.N    ??Draw_Row_77
//  525         }
//  526       }
//  527 //------------------------- Draw the X Vernie data -----------------------------
//  528       Tmp =(MIN_X + 150)- _X_posi.Value;
??Draw_Row_74:
        LDRH     R0,[R2, #+456]
        RSB      R0,R0,#+161
        SXTH     R0,R0
//  529       if(Tmp > MIN_X) {
        CMP      R0,#+12
        BLT.N    ??Draw_Row_78
//  530         if((Row == Tmp)&&((_X_posi.Flag & HID)== 0)){
        CMP      R5,R0
        BNE.N    ??Draw_Row_79
        ADD      R1,R2,#+458
        LDRB     R1,[R1, #+0]
        TST      R1,#0x4
        BNE.N    ??Draw_Row_79
//  531           for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer1[i] |= Color[X_POSI];
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R1,[R4, #+972]
        LDRH     R3,[R4, #+2]
        ORRS     R3,R1,R3
        STRH     R3,[R4, #+2]
        ADD      R3,R4,#+8
        MOV      R12,#+11
??Draw_Row_80:
        LDRH     LR,[R3, #+0]
        ORR      LR,R1,LR
        STRH     LR,[R3, #+0]
        LDRH     LR,[R3, #+6]
        ORR      LR,R1,LR
        STRH     LR,[R3, #+6]
        LDRH     LR,[R3, #+12]
        ORR      LR,R1,LR
        STRH     LR,[R3, #+12]
        LDRH     LR,[R3, #+18]
        ORR      LR,R1,LR
        STRH     LR,[R3, #+18]
        LDRH     LR,[R3, #+24]
        ORR      LR,R1,LR
        STRH     LR,[R3, #+24]
        LDRH     LR,[R3, #+30]
        ORR      LR,R1,LR
        STRH     LR,[R3, #+30]
        ADDS     R3,R3,#+36
        SUBS     R12,R12,#+1
        BNE.N    ??Draw_Row_80
//  532         }
//  533         if((Row == Tmp-1)||(Row == Tmp+1)){
??Draw_Row_79:
        SUBS     R1,R0,#+1
        CMP      R5,R1
        BEQ.N    ??Draw_Row_81
        ADDS     R1,R0,#+1
        CMP      R5,R1
        BNE.N    ??Draw_Row_82
//  534           LCD_Buffer1[Y_SIZE] = Color[X_POSI];
??Draw_Row_81:
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R1,[R4, #+972]
        STRH     R1,[R4, #+400]
//  535           LCD_Buffer1[Y_BASE] = Color[X_POSI];
        STRH     R1,[R4, #+0]
//  536         }
//  537         if(Row == Tmp){
??Draw_Row_82:
        CMP      R5,R0
        BNE.N    ??Draw_Row_78
//  538           LCD_Buffer1[Y_SIZE]   = Color[X_POSI];
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R1,[R4, #+972]
        STRH     R1,[R4, #+400]
//  539           LCD_Buffer1[Y_SIZE-1] = Color[X_POSI];
        ADD      R0,R4,#+398
        STRH     R1,[R0, #+0]
//  540           LCD_Buffer1[Y_BASE+1] = Color[X_POSI];
        STRH     R1,[R4, #+2]
//  541           LCD_Buffer1[Y_BASE]   = Color[X_POSI];
        STRH     R1,[R4, #+0]
//  542         }
//  543       }
//  544       Tmp = MIN_X + Title[T_VERNIE][T1].Value;
??Draw_Row_78:
        LDRH     R0,[R2, #+816]
        ADD      R1,R0,#+11
        SXTH     R1,R1
//  545       if((Row == Tmp)&&((Title[T_VERNIE][T1].Flag & HID)== 0)){
        CMP      R5,R1
        BNE.N    ??Draw_Row_83
        LDRB     R0,[R2, #+818]
        TST      R0,#0x4
        BNE.N    ??Draw_Row_83
//  546         for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer1[i] |= Color[VERNIE];
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, #+968]
        LDRH     R3,[R4, #+2]
        ORRS     R3,R0,R3
        STRH     R3,[R4, #+2]
        ADD      R3,R4,#+8
        MOV      R12,#+11
??Draw_Row_84:
        LDRH     LR,[R3, #+0]
        ORR      LR,R0,LR
        STRH     LR,[R3, #+0]
        LDRH     LR,[R3, #+6]
        ORR      LR,R0,LR
        STRH     LR,[R3, #+6]
        LDRH     LR,[R3, #+12]
        ORR      LR,R0,LR
        STRH     LR,[R3, #+12]
        LDRH     LR,[R3, #+18]
        ORR      LR,R0,LR
        STRH     LR,[R3, #+18]
        LDRH     LR,[R3, #+24]
        ORR      LR,R0,LR
        STRH     LR,[R3, #+24]
        LDRH     LR,[R3, #+30]
        ORR      LR,R0,LR
        STRH     LR,[R3, #+30]
        ADDS     R3,R3,#+36
        SUBS     R12,R12,#+1
        BNE.N    ??Draw_Row_84
//  547       }
//  548       if((Row == Tmp-1)||(Row == Tmp+1)){
??Draw_Row_83:
        SUBS     R0,R1,#+1
        CMP      R5,R0
        BEQ.N    ??Draw_Row_85
        ADDS     R0,R1,#+1
        CMP      R5,R0
        BNE.N    ??Draw_Row_86
//  549         LCD_Buffer1[Y_SIZE] = Color[VERNIE];
??Draw_Row_85:
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, #+968]
        STRH     R0,[R4, #+400]
//  550         LCD_Buffer1[Y_BASE] = Color[VERNIE];
        STRH     R0,[R4, #+0]
//  551       }
//  552       if(Row == Tmp){
??Draw_Row_86:
        CMP      R5,R1
        BNE.N    ??Draw_Row_87
//  553         LCD_Buffer1[Y_SIZE]   = Color[VERNIE];
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, #+968]
        STRH     R0,[R4, #+400]
//  554         LCD_Buffer1[Y_SIZE-1] = Color[VERNIE];
        ADD      R1,R4,#+398
        STRH     R0,[R1, #+0]
//  555         LCD_Buffer1[Y_BASE+1] = Color[VERNIE];
        STRH     R0,[R4, #+2]
//  556       }
//  557       Tmp = MIN_X + Title[T_VERNIE][T2].Value;
??Draw_Row_87:
        LDRH     R0,[R2, #+836]
        ADD      R1,R0,#+11
        SXTH     R1,R1
//  558       if((Row == Tmp)&&((Title[T_VERNIE][T2].Flag & HID)== 0)){
        CMP      R5,R1
        BNE.N    ??Draw_Row_88
        LDRB     R0,[R2, #+838]
        TST      R0,#0x4
        BNE.N    ??Draw_Row_88
//  559         for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer1[i] |= Color[VERNIE];
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, #+968]
        LDRH     R2,[R4, #+2]
        ORRS     R2,R0,R2
        STRH     R2,[R4, #+2]
        ADD      R2,R4,#+8
        MOVS     R3,#+11
??Draw_Row_89:
        LDRH     R12,[R2, #+0]
        ORR      R12,R0,R12
        STRH     R12,[R2, #+0]
        LDRH     R12,[R2, #+6]
        ORR      R12,R0,R12
        STRH     R12,[R2, #+6]
        LDRH     R12,[R2, #+12]
        ORR      R12,R0,R12
        STRH     R12,[R2, #+12]
        LDRH     R12,[R2, #+18]
        ORR      R12,R0,R12
        STRH     R12,[R2, #+18]
        LDRH     R12,[R2, #+24]
        ORR      R12,R0,R12
        STRH     R12,[R2, #+24]
        LDRH     R12,[R2, #+30]
        ORR      R12,R0,R12
        STRH     R12,[R2, #+30]
        ADDS     R2,R2,#+36
        SUBS     R3,R3,#+1
        BNE.N    ??Draw_Row_89
//  560       }
//  561       if((Row == Tmp-1)||(Row == Tmp+1)){
??Draw_Row_88:
        SUBS     R0,R1,#+1
        CMP      R5,R0
        BEQ.N    ??Draw_Row_90
        ADDS     R0,R1,#+1
        CMP      R5,R0
        BNE.N    ??Draw_Row_91
//  562         LCD_Buffer1[Y_SIZE] = Color[VERNIE];
??Draw_Row_90:
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, #+968]
        STRH     R0,[R4, #+400]
//  563         LCD_Buffer1[Y_BASE] = Color[VERNIE];
        STRH     R0,[R4, #+0]
//  564       }
//  565       if(Row == Tmp){
??Draw_Row_91:
        CMP      R5,R1
        BNE.N    ??Draw_Row_61
//  566         LCD_Buffer1[Y_SIZE]   = Color[VERNIE];
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, #+968]
        STRH     R0,[R4, #+400]
//  567         LCD_Buffer1[Y_SIZE-1] = Color[VERNIE];
        ADD      R1,R4,#+398
        STRH     R0,[R1, #+0]
//  568         LCD_Buffer1[Y_BASE+1] = Color[VERNIE];
        STRH     R0,[R4, #+2]
//  569       }
//  570     }
//  571     __LCD_Copy(LCD_Buffer1, Y_SIZE+1);             // Even row Transitive
??Draw_Row_61:
        MOVS     R1,#+201
        LDR.N    R0,??DataTable34  ;; LCD_Buffer1
??Draw_Row_51:
        BL       __LCD_Copy
//  572   }
//  573 }
        ADD      SP,SP,#+20
        CFI CFA R13+20
        POP      {R4-R7,PC}       ;; return
        DATA
??Draw_Row_1:
        DC32     TrackBuff
        DC32     Row_Base1 + 404
        DC32     LCD_Buffer1 + 480
        CFI EndBlock cfiBlock4

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable12:
        DC32     Title
//  574 /*******************************************************************************
//  575  Draw_Window :  
//  576 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function Draw_Window
        THUMB
//  577 void Draw_Window(void)						
//  578 { 
Draw_Window:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//  579   u16 Row;
//  580   __Row_DMA_Ready();
        BL       __Row_DMA_Ready
//  581   __Row_Copy(Row_Base1, LCD_Buffer2);
        LDR.N    R4,??DataTable33  ;; Row_Base1
        LDR.N    R5,??DataTable34  ;; LCD_Buffer1
        ADD      R1,R5,#+480
        MOVS     R0,R4
        BL       __Row_Copy
//  582   __Row_DMA_Ready();
        BL       __Row_DMA_Ready
//  583   __Row_Copy(Row_Base2, LCD_Buffer1);
        MOVS     R1,R5
        ADD      R0,R4,#+404
        BL       __Row_Copy
//  584   for(Row = MIN_X; Row <= MAX_X; ++Row) Draw_Row(Row); 
        MOVS     R4,#+11
??Draw_Window_0:
        UXTH     R0,R4
        BL       Draw_Row
        ADDS     R4,R4,#+1
        MOV      R1,#+312
        UXTH     R0,R4
        CMP      R0,R1
        BCC.N    ??Draw_Window_0
//  585   __LCD_DMA_Ready();
        BL       __LCD_DMA_Ready
//  586   __Row_DMA_Ready();
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,LR}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      __Row_DMA_Ready
        CFI EndBlock cfiBlock5
//  587 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable33:
        DC32     Row_Base1

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable34:
        DC32     LCD_Buffer1
//  588 /*******************************************************************************
//  589  Draw_Mark :  
//  590 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function Draw_Mark
        THUMB
//  591 void Draw_Mark(u16 m, u16 n)						
//  592 { 
Draw_Mark:
        PUSH     {R0,R4-R11,LR}
        CFI R14 Frame(CFA, -4)
        CFI R11 Frame(CFA, -8)
        CFI R10 Frame(CFA, -12)
        CFI R9 Frame(CFA, -16)
        CFI R8 Frame(CFA, -20)
        CFI R7 Frame(CFA, -24)
        CFI R6 Frame(CFA, -28)
        CFI R5 Frame(CFA, -32)
        CFI R4 Frame(CFA, -36)
        CFI CFA R13+40
        SUB      SP,SP,#+8
        CFI CFA R13+48
//  593   u16 i, j, Tmp;
//  594   
//  595   if(m < 4)  if(Title[m][POSI].Value > 200-3) return;
        CMP      R0,#+4
        BCS.N    ??Draw_Mark_0
        MOVS     R2,#+80
        LDR.N    R3,??Draw_Mark_1  ;; Title
        MLA      R2,R0,R2,R3
        LDRSH    R2,[R2, #+76]
        CMP      R2,#+198
        BGE.W    ??Draw_Mark_2
//  596   else       if(V_Trigg[n].Value > 200-3)     return;  
        LDR.N    R2,??Draw_Mark_1+0x4  ;; LCD_Buffer1
        ADD      R2,R2,R1, LSL #+2
        LDRSH    R2,[R2, #+992]
        CMP      R2,#+198
        BGE.W    ??Draw_Mark_2
//  597   
//  598   for(i = 0; i <= 10; ++i){
??Draw_Mark_0:
        MOVS     R4,#+0
        LDR.N    R2,??Draw_Mark_1+0x8  ;; Mark_TAB
        MOVS     R3,#+7
        MLA      R3,R0,R3,R2
        STR      R3,[SP, #+0]
        ADD      R11,R2,#+28
        MOVS     R5,R1
        LDR.N    R6,??Draw_Mark_1+0x4  ;; LCD_Buffer1
        ADD      R7,R6,R5, LSL #+2
        MOVS     R1,#+80
        LDR.N    R2,??Draw_Mark_1  ;; Title
        MLA      R8,R0,R1,R2
//  599     if(i < 7){
??Draw_Mark_3:
        UXTH     R0,R4
        CMP      R0,#+7
        BCS.N    ??Draw_Mark_4
//  600       if(m < 4){
        LDRH     R0,[SP, #+8]
        CMP      R0,#+4
        BCS.N    ??Draw_Mark_5
//  601         Tmp = Mark_TAB[m][i];
        LDR      R0,[SP, #+0]
        LDRB     R9,[R0, #+0]
//  602         __Point_SCR(i, Title[m][POSI].Value +(MIN_Y-4));
        LDRSH    R0,[R8, #+76]
        ADD      R1,R0,#+9
        B.N      ??Draw_Mark_6
//  603       } else {
//  604         Tmp = Mark_TAB[4][i];
??Draw_Mark_5:
        LDRB     R9,[R11, #+0]
//  605         __Point_SCR(i,     V_Trigg[n].Value +(MIN_Y-4));
        LDRSH    R0,[R7, #+992]
        ADD      R1,R0,#+9
??Draw_Mark_6:
        UXTH     R1,R1
        UXTH     R0,R4
        BL       __Point_SCR
//  606       }
//  607       for(j = 0; j < 8; ++j){
        MOV      R10,#+8
//  608         if(Tmp & 1) __LCD_SetPixl(Color[SCRN]);
??Draw_Mark_7:
        TST      R9,#0x1
        BEQ.N    ??Draw_Mark_8
        LDRH     R0,[R6, #+970]
        B.N      ??Draw_Mark_9
//  609         else        __LCD_SetPixl(Color[n]);
??Draw_Mark_8:
        ADD      R0,R6,#+960
        LDRH     R0,[R0, R5, LSL #+1]
??Draw_Mark_9:
        BL       __LCD_SetPixl
//  610         Tmp >>= 1;
        LSR      R9,R9,#+1
//  611       }
        SUBS     R10,R10,#+1
        BNE.N    ??Draw_Mark_7
//  612       __LCD_SetPixl(Color[n]);
        ADD      R0,R6,#+960
        LDRH     R0,[R0, R5, LSL #+1]
        BL       __LCD_SetPixl
        B.N      ??Draw_Mark_10
//  613     } else {
//  614       if(m < 4){
??Draw_Mark_4:
        LDRH     R0,[SP, #+8]
        CMP      R0,#+4
        BCS.N    ??Draw_Mark_11
//  615         __Point_SCR(i, Title[m][POSI].Value +(MIN_Y-10)+ i);
        LDRSH    R1,[R8, #+76]
        ADDS     R0,R1,R4
        ADDS     R1,R0,#+3
        UXTH     R1,R1
        UXTH     R0,R4
        BL       __Point_SCR
//  616         for(j=Title[m][POSI].Value+(MIN_Y-10)+i;j<(Title[m][POSI].Value+(MIN_Y+11)-i);++j) 
        LDRSH    R0,[R8, #+76]
        ADDS     R1,R0,R4
        ADD      R9,R1,#+3
        UXTH     R9,R9
        ADDS     R0,R0,#+24
        SUBS     R0,R0,R4
        CMP      R9,R0
        BGE.N    ??Draw_Mark_10
//  617           __LCD_SetPixl(Color[n]); 
??Draw_Mark_12:
        ADD      R0,R6,#+960
        LDRH     R0,[R0, R5, LSL #+1]
        BL       __LCD_SetPixl
        ADD      R9,R9,#+1
        UXTH     R9,R9
        LDRSH    R0,[R8, #+76]
        ADDS     R0,R0,#+24
        SUBS     R0,R0,R4
        CMP      R9,R0
        BGE.N    ??Draw_Mark_10
        B.N      ??Draw_Mark_12
//  618       } else { 
//  619         __Point_SCR(i,     V_Trigg[n].Value +(MIN_Y-10)+ i);   
??Draw_Mark_11:
        LDRSH    R1,[R7, #+992]
        ADDS     R0,R1,R4
        ADDS     R1,R0,#+3
        UXTH     R1,R1
        UXTH     R0,R4
        BL       __Point_SCR
//  620         for(j=V_Trigg[n].Value+(MIN_Y-10)+i;j<(V_Trigg[n].Value+(MIN_Y+11)-i);++j) 
        LDRSH    R0,[R7, #+992]
        ADDS     R1,R0,R4
        ADD      R9,R1,#+3
        UXTH     R9,R9
        ADDS     R0,R0,#+24
        SUBS     R0,R0,R4
        CMP      R9,R0
        BGE.N    ??Draw_Mark_10
//  621           __LCD_SetPixl(Color[n]); 
??Draw_Mark_13:
        ADD      R0,R6,#+960
        LDRH     R0,[R0, R5, LSL #+1]
        BL       __LCD_SetPixl
        ADD      R9,R9,#+1
        UXTH     R9,R9
        LDRSH    R0,[R7, #+992]
        ADDS     R0,R0,#+24
        SUBS     R0,R0,R4
        CMP      R9,R0
        BLT.N    ??Draw_Mark_13
//  622       }
//  623     }
//  624   }
??Draw_Mark_10:
        ADDS     R4,R4,#+1
        ADD      R11,R11,#+1
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+0]
        UXTH     R0,R4
        CMP      R0,#+11
        BCC.W    ??Draw_Mark_3
??Draw_Mark_2:
        ADD      SP,SP,#+12
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        Nop      
        DATA
??Draw_Mark_1:
        DC32     Title
        DC32     LCD_Buffer1
        DC32     Mark_TAB
        CFI EndBlock cfiBlock6
//  625 }
//  626 /*******************************************************************************
//  627  Update_Mark :  
//  628 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function Update_Mark
        THUMB
//  629 void Update_Mark(void)						
//  630 { 
Update_Mark:
        PUSH     {R4-R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI R7 Frame(CFA, -8)
        CFI R6 Frame(CFA, -12)
        CFI R5 Frame(CFA, -16)
        CFI R4 Frame(CFA, -20)
        CFI CFA R13+20
        SUB      SP,SP,#+4
        CFI CFA R13+24
//  631   s16 i, Tmp; 
//  632   u8  j;
//  633   
//  634   __Row_DMA_Ready();
        BL       __Row_DMA_Ready
//  635   for(i = 0; i <= 10; ++i){
        MOVS     R5,#+0
        LDR.N    R4,??Update_Mark_0  ;; LCD_Buffer1
//  636     __Point_SCR(i, MIN_Y-1);
??Update_Mark_1:
        MOVS     R1,#+12
        UXTH     R0,R5
        BL       __Point_SCR
//  637     for(j = MIN_Y-1; j < MAX_Y+2; ++j)  __LCD_SetPixl(Color[SCRN]);   // Clear row
        MOVS     R6,#+203
??Update_Mark_2:
        LDRH     R0,[R4, #+970]
        BL       __LCD_SetPixl
        SUBS     R6,R6,#+1
        BNE.N    ??Update_Mark_2
//  638   }
        ADDS     R5,R5,#+1
        CMP      R5,#+11
        BLT.N    ??Update_Mark_1
//  639   if(_1_source  != HIDE)    Draw_Mark(TRACK1, TRACK1); // Display Track1 mark
        LDR.N    R5,??Update_Mark_0+0x4  ;; Title
        LDRSH    R0,[R5, #+16]
        CBZ      R0,??Update_Mark_3
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       Draw_Mark
//  640   if(_2_source  != HIDE)    Draw_Mark(TRACK2, TRACK2); // Display Track1 mark
??Update_Mark_3:
        LDRSH    R0,[R5, #+96]
        CBZ      R0,??Update_Mark_4
        MOVS     R1,#+1
        MOVS     R0,#+1
        BL       Draw_Mark
//  641   if(_3_source  != HIDE)    Draw_Mark(TRACK3, TRACK3); // Display Track1 mark
??Update_Mark_4:
        LDRSH    R0,[R5, #+176]
        CBZ      R0,??Update_Mark_5
        MOVS     R1,#+2
        MOVS     R0,#+2
        BL       Draw_Mark
//  642   if(_4_source  != HIDE)    Draw_Mark(TRACK4, TRACK4); // Display Track1 mark
??Update_Mark_5:
        LDRSH    R0,[R5, #+256]
        CBZ      R0,??Update_Mark_6
        MOVS     R1,#+3
        MOVS     R0,#+3
        BL       Draw_Mark
//  643   if(_Tr_source == TRACK1)  Draw_Mark(TRIGG,  TRACK1); // Display Trigg1 mark
??Update_Mark_6:
        LDRSH    R0,[R5, #+576]
        CBNZ     R0,??Update_Mark_7
        MOVS     R1,#+0
        MOVS     R0,#+7
        BL       Draw_Mark
//  644   if(_Tr_source == TRACK2)  Draw_Mark(TRIGG,  TRACK2); // Display Trigg1 mark
??Update_Mark_7:
        LDRSH    R0,[R5, #+576]
        CMP      R0,#+1
        BNE.N    ??Update_Mark_8
        MOVS     R1,#+1
        MOVS     R0,#+7
        BL       Draw_Mark
//  645   if(_Tr_source == TRACK3)  Draw_Mark(TRIGG,  TRACK3); // Display Trigg1 mark
??Update_Mark_8:
        LDRSH    R0,[R5, #+576]
        CMP      R0,#+2
        BNE.N    ??Update_Mark_9
        MOVS     R1,#+2
        MOVS     R0,#+7
        BL       Draw_Mark
//  646   if(_Tr_source == TRACK4)  Draw_Mark(TRIGG,  TRACK4); // Display Trigg1 mark
??Update_Mark_9:
        LDRSH    R0,[R5, #+576]
        CMP      R0,#+3
        BNE.N    ??Update_Mark_10
        MOVS     R1,#+3
        MOVS     R0,#+7
        BL       Draw_Mark
//  647     
//  648   __Point_SCR(MAX_X+1, MIN_Y-1);
??Update_Mark_10:
        MOVS     R1,#+12
        MOV      R0,#+312
        BL       __Point_SCR
//  649   for(j = MIN_Y-1; j < MAX_Y+2; ++j) __LCD_SetPixl(Color[SCRN]); // Clear last row 
        MOVS     R6,#+203
??Update_Mark_11:
        LDRH     R0,[R4, #+970]
        BL       __LCD_SetPixl
        SUBS     R6,R6,#+1
        BNE.N    ??Update_Mark_11
//  650   for(i = MIN_X; i <= MAX_X+1; ++i)
        MOVS     R6,#+11
        MOVW     R7,#+313
//  651   {
//  652     __Point_SCR(i, MIN_Y-1);
??Update_Mark_12:
        MOVS     R1,#+12
        UXTH     R0,R6
        BL       __Point_SCR
//  653     __LCD_SetPixl(Color[SCRN]);                            // Clear first column
        LDRH     R0,[R4, #+970]
        BL       __LCD_SetPixl
//  654     __Point_SCR(i, MAX_Y+1);
        MOVS     R1,#+214
        UXTH     R0,R6
        BL       __Point_SCR
//  655     __LCD_SetPixl(Color[SCRN]);                            // Clear last column
        LDRH     R0,[R4, #+970]
        BL       __LCD_SetPixl
//  656   }
        ADDS     R6,R6,#+1
        CMP      R6,R7
        BLT.N    ??Update_Mark_12
//  657   __Point_SCR(MIN_X-1, Title[V_VERNIE][V1].Value +(MIN_Y - 2));
        LDRSH    R0,[R5, #+656]
        ADD      R1,R0,#+11
        UXTH     R1,R1
        MOVS     R0,#+10
        BL       __Point_SCR
//  658   for(i = 0; i < 5; ++i) __LCD_SetPixl(Color[VERNIE]);
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
//  659   __Point_SCR(MIN_X-1, Title[V_VERNIE][V2].Value +(MIN_Y - 2));
        LDRSH    R0,[R5, #+676]
        ADD      R1,R0,#+11
        UXTH     R1,R1
        MOVS     R0,#+10
        BL       __Point_SCR
//  660   for(i = 0; i < 5; ++i) __LCD_SetPixl(Color[VERNIE]);
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
//  661   __Point_SCR(MAX_X+1, Title[V_VERNIE][V1].Value +(MIN_Y - 2));
        LDRSH    R0,[R5, #+656]
        ADD      R1,R0,#+11
        UXTH     R1,R1
        MOV      R0,#+312
        BL       __Point_SCR
//  662   for(i = 0; i < 5; ++i) __LCD_SetPixl(Color[VERNIE]);
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
//  663   __Point_SCR(MAX_X+1, Title[V_VERNIE][V2].Value +(MIN_Y - 2));
        LDRSH    R0,[R5, #+676]
        ADD      R1,R0,#+11
        UXTH     R1,R1
        MOV      R0,#+312
        BL       __Point_SCR
//  664   for(i = 0; i < 5; ++i) __LCD_SetPixl(Color[VERNIE]);
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
//  665   
//  666   Tmp =(MIN_X + 150)- _X_posi.Value;
        LDRH     R0,[R5, #+456]
        RSB      R0,R0,#+161
        SXTH     R0,R0
//  667   if(Tmp > MIN_X){
        CMP      R0,#+12
        BLT.N    ??Update_Mark_13
//  668     for(i = Tmp - 2; i <= Tmp + 2; ++i){
        SUBS     R6,R0,#+2
        SXTH     R6,R6
        ADDS     R7,R0,#+2
        CMP      R7,R6
        BLT.N    ??Update_Mark_13
//  669       __Point_SCR(i, MIN_Y-1);
??Update_Mark_14:
        MOVS     R1,#+12
        UXTH     R0,R6
        BL       __Point_SCR
//  670       __LCD_SetPixl(Color[X_POSI]);
        LDRH     R0,[R4, #+972]
        BL       __LCD_SetPixl
//  671       __Point_SCR(i, MAX_Y+1);
        MOVS     R1,#+214
        UXTH     R0,R6
        BL       __Point_SCR
//  672       __LCD_SetPixl(Color[X_POSI]);
        LDRH     R0,[R4, #+972]
        BL       __LCD_SetPixl
//  673     }
        ADDS     R6,R6,#+1
        SXTH     R6,R6
        CMP      R7,R6
        BGE.N    ??Update_Mark_14
//  674   }
//  675   Tmp = MIN_X + Title[T_VERNIE][T1].Value;
??Update_Mark_13:
        LDRH     R0,[R5, #+816]
        ADDS     R0,R0,#+11
        SXTH     R0,R0
//  676   for(i = Tmp - 2; i <= Tmp + 2; ++i){
        SUBS     R6,R0,#+2
        SXTH     R6,R6
        ADDS     R7,R0,#+2
        CMP      R7,R6
        BLT.N    ??Update_Mark_15
//  677     __Point_SCR(i, MIN_Y-1);
??Update_Mark_16:
        MOVS     R1,#+12
        UXTH     R0,R6
        BL       __Point_SCR
//  678     __LCD_SetPixl(Color[VERNIE]);
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
//  679     __Point_SCR(i, MAX_Y+1);
        MOVS     R1,#+214
        UXTH     R0,R6
        BL       __Point_SCR
//  680     __LCD_SetPixl(Color[VERNIE]);
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
//  681   }
        ADDS     R6,R6,#+1
        SXTH     R6,R6
        CMP      R7,R6
        BGE.N    ??Update_Mark_16
//  682   Tmp = MIN_X + Title[T_VERNIE][T2].Value;
??Update_Mark_15:
        LDRH     R0,[R5, #+836]
        ADDS     R0,R0,#+11
        SXTH     R0,R0
//  683   for(i = Tmp - 2; i <= Tmp + 2; ++i){
        SUBS     R5,R0,#+2
        SXTH     R5,R5
        ADDS     R6,R0,#+2
        CMP      R6,R5
        BLT.N    ??Update_Mark_17
//  684     __Point_SCR(i, MIN_Y-1);
??Update_Mark_18:
        MOVS     R1,#+12
        UXTH     R0,R5
        BL       __Point_SCR
//  685     __LCD_SetPixl(Color[VERNIE]);
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
//  686     __Point_SCR(i, MAX_Y+1);
        MOVS     R1,#+214
        UXTH     R0,R5
        BL       __Point_SCR
//  687     __LCD_SetPixl(Color[VERNIE]);
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
//  688   }
        ADDS     R5,R5,#+1
        SXTH     R5,R5
        CMP      R6,R5
        BGE.N    ??Update_Mark_18
//  689 }
??Update_Mark_17:
        ADD      SP,SP,#+4
        CFI CFA R13+20
        POP      {R4-R7,PC}       ;; return
        DATA
??Update_Mark_0:
        DC32     LCD_Buffer1
        DC32     Title
        CFI EndBlock cfiBlock7
//  690 /*******************************************************************************
//  691  Update_View_Area: 刷新显示窗口位置指示 
//  692 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function Update_View_Area
        THUMB
//  693 void Update_View_Area(void)
//  694 {  
Update_View_Area:
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
        SUB      SP,SP,#+4
        CFI CFA R13+40
//  695   s16 i, j, k;
//  696   {
//  697     __Point_SCR(89,  0);
        MOVS     R1,#+0
        MOVS     R0,#+89
        BL       __Point_SCR
//  698     for(j=0; j<12; ++j) __LCD_SetPixl(ORANGE); 
        MOVS     R5,#+12
        MOVW     R4,#+1311
??Update_View_Area_0:
        MOVS     R0,R4
        BL       __LCD_SetPixl
        SUBS     R5,R5,#+1
        BNE.N    ??Update_View_Area_0
//  699     __Point_SCR(90,  0);
        MOVS     R1,#+0
        MOVS     R0,#+90
        BL       __Point_SCR
//  700     for(j=0; j<12; ++j) __LCD_SetPixl(ORANGE); 
        MOVS     R5,#+12
??Update_View_Area_1:
        MOVS     R0,R4
        BL       __LCD_SetPixl
        SUBS     R5,R5,#+1
        BNE.N    ??Update_View_Area_1
//  701     __Point_SCR(308, 0);
        MOVS     R1,#+0
        MOV      R0,#+308
        BL       __Point_SCR
//  702     for(j=0; j<12; ++j) __LCD_SetPixl(ORANGE); 
        MOVS     R5,#+12
??Update_View_Area_2:
        MOVS     R0,R4
        BL       __LCD_SetPixl
        SUBS     R5,R5,#+1
        BNE.N    ??Update_View_Area_2
//  703     __Point_SCR(309, 0);
        MOVS     R1,#+0
        MOVW     R0,#+309
        BL       __Point_SCR
//  704     for(j=0; j<12; ++j) __LCD_SetPixl(ORANGE); 
        MOVS     R5,#+12
??Update_View_Area_3:
        MOVS     R0,R4
        BL       __LCD_SetPixl
        SUBS     R5,R5,#+1
        BNE.N    ??Update_View_Area_3
//  705 
//  706     for(i=91; i<307; i+=8){
        MOVS     R5,#+91
        MOVW     R11,#+307
        LDR.N    R6,??Update_View_Area_4  ;; RULE_BASE
//  707       for(j=0; j<8; ++j){
??Update_View_Area_5:
        MOVS     R7,R5
        MOV      R8,R6
        MOV      R9,#+8
//  708         __Point_SCR(i+j, 0);
??Update_View_Area_6:
        MOVS     R1,#+0
        UXTH     R0,R7
        BL       __Point_SCR
//  709         for(k=0; k<12; ++k){
        MOV      R10,#+0
//  710           if((0x01 << k)& RULE_BASE[j]) __LCD_SetPixl(ORANGE);
??Update_View_Area_7:
        MOVS     R0,#+1
        LSL      R0,R0,R10
        LDRH     R1,[R8, #+0]
        TST      R0,R1
        BEQ.N    ??Update_View_Area_8
        MOVS     R0,R4
        B.N      ??Update_View_Area_9
//  711           else                          __LCD_SetPixl(BLACK);
??Update_View_Area_8:
        MOVS     R0,#+0
??Update_View_Area_9:
        BL       __LCD_SetPixl
//  712         }
        ADD      R10,R10,#+1
        CMP      R10,#+12
        BLT.N    ??Update_View_Area_7
//  713       }
        ADD      R8,R8,#+2
        ADDS     R7,R7,#+1
        SUBS     R9,R9,#+1
        BNE.N    ??Update_View_Area_6
//  714     }
        ADDS     R5,R5,#+8
        CMP      R5,R11
        BLT.N    ??Update_View_Area_5
//  715     __Point_SCR(0  + 91 + (_X_posi.Value * 200)/3796, 0); 
        MOVW     R4,#+3796
        MOVS     R5,#+200
        LDR.N    R6,??Update_View_Area_4+0x4  ;; Title
        MOVS     R1,#+0
        LDRSH    R0,[R6, #+456]
        MULS     R0,R0,R5
        SDIV     R0,R0,R4
        ADDS     R0,R0,#+91
        UXTH     R0,R0
        BL       __Point_SCR
//  716     for(j=0;j<9;++j) __LCD_SetPixl(WHT);
        MOV      R8,#+9
        MOVW     R7,#+65535
??Update_View_Area_10:
        MOVS     R0,R7
        BL       __LCD_SetPixl
        SUBS     R8,R8,#+1
        BNE.N    ??Update_View_Area_10
//  717     __Point_SCR(15 + 91 + (_X_posi.Value * 200)/3796, 0);
        MOVS     R1,#+0
        LDRSH    R0,[R6, #+456]
        MULS     R0,R0,R5
        SDIV     R0,R0,R4
        ADDS     R0,R0,#+106
        UXTH     R0,R0
        BL       __Point_SCR
//  718     for(j=0;j<9;++j) __LCD_SetPixl(WHT);
        MOV      R8,#+9
??Update_View_Area_11:
        MOVS     R0,R7
        BL       __LCD_SetPixl
        SUBS     R8,R8,#+1
        BNE.N    ??Update_View_Area_11
//  719     for(i=0;i<16;++i){
        MOV      R8,#+0
//  720       __Point_SCR(i + 91 +(_X_posi.Value * 200)/3796, 0);
??Update_View_Area_12:
        MOVS     R1,#+0
        LDRSH    R0,[R6, #+456]
        MULS     R0,R0,R5
        SDIV     R0,R0,R4
        MOV      R2,R8
        ADDS     R0,R2,R0
        ADDS     R0,R0,#+91
        UXTH     R0,R0
        BL       __Point_SCR
//  721       __LCD_SetPixl(WHT);
        MOVS     R0,R7
        BL       __LCD_SetPixl
//  722       __Point_SCR(i + 91 +(_X_posi.Value * 200)/3796, 9);
        MOVS     R1,#+9
        LDRSH    R0,[R6, #+456]
        MULS     R0,R0,R5
        SDIV     R0,R0,R4
        MOV      R2,R8
        ADDS     R0,R2,R0
        ADDS     R0,R0,#+91
        UXTH     R0,R0
        BL       __Point_SCR
//  723       __LCD_SetPixl(WHT);
        MOVS     R0,R7
        BL       __LCD_SetPixl
//  724     }
        ADD      R8,R8,#+1
        CMP      R8,#+16
        BLT.N    ??Update_View_Area_12
//  725     _X_View.Flag &= !UPDAT;
        ADD      R0,R6,#+478
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  726   }
//  727 }
        ADD      SP,SP,#+4
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        Nop      
        DATA
??Update_View_Area_4:
        DC32     RULE_BASE
        DC32     Title
        CFI EndBlock cfiBlock8

        END
//  728 /******************************** END OF FILE *********************************/
// 
// 1 012 bytes in section .data
// 3 988 bytes in section .rodata
// 4 556 bytes in section .text
// 
// 4 556 bytes of CODE  memory
// 3 988 bytes of CONST memory
// 1 012 bytes of DATA  memory
//
//Errors: none
//Warnings: none
