///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  13:45:29 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\APP_V2.32\source\Draw.c                       /
//    Command line =  E:\DS0203\APP_V2.32\source\Draw.c -lA                   /
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
//    List file    =  E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\Draw.s          /
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
        
// E:\DS0203\APP_V2.32\source\Draw.c
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
        DC16 0, 0, 0, 1920, 64, 32, 32, 32, 32, 32, 64, 1920, 0, 0, 0, 0, 0, 0
        DC16 0, 15, 16, 32, 32, 32, 780, 396, 192, 96, 48, 792, 780, 0, 0, 384
        DC16 608, 540, 618, 644, 320, 0, 514, 514, 514, 514, 514, 514, 1022, 0
        DC16 0, 0, 248, 508, 774, 514, 0, 0, 0, 0, 514, 774, 508, 248, 0, 0, 0
        DC16 396, 216, 112, 112, 216, 396, 0, 0, 32, 32, 248, 248, 32, 32, 0
        DC16 32, 32, 16, 15, 0, 0, 0, 0, 0, 32, 32, 32, 32, 32, 32, 0, 0, 0
        DC16 768, 768, 0, 0, 0, 0, 384, 192, 96, 48, 24, 12, 6, 0, 508, 1022
        DC16 578, 546, 530, 1022, 508, 0, 0, 520, 524, 1022, 1022, 512, 512, 0
        DC16 772, 902, 706, 610, 562, 798, 780, 0, 260, 774, 546, 546, 546
        DC16 1022, 476, 0, 96, 112, 88, 588, 1022, 1022, 576, 0, 286, 542, 530
        DC16 530, 530, 1010, 482, 0, 504, 1020, 550, 546, 546, 992, 448, 0, 6
        DC16 6, 962, 994, 50, 30, 14, 0, 476, 1022, 546, 546, 546, 1022, 476, 0
        DC16 28, 574, 546, 546, 802, 510, 252, 0, 0, 0, 0, 408, 408, 0, 0, 0
        DC16 762, 762, 762, 762, 762, 762, 762, 762, 0, 32, 112, 216, 396, 774
        DC16 514, 0, 144, 144, 144, 144, 144, 144, 0, 0, 0, 514, 774, 396, 216
        DC16 112, 32, 0, 24, 28, 4, 836, 868, 60, 24, 0, 504, 260, 626, 626
        DC16 754, 644, 120, 0, 1008, 1016, 76, 70, 76, 1016, 1008, 0, 514, 1022
        DC16 1022, 546, 546, 1022, 476, 0, 248, 508, 774, 514, 514, 774, 396, 0
        DC16 514, 1022, 1022, 514, 774, 508, 248, 0, 514, 1022, 1022, 546, 626
        DC16 774, 910, 0, 514, 1022, 1022, 546, 114, 6, 14, 0, 248, 508, 774
        DC16 546, 546, 486, 1004, 0, 1022, 1022, 32, 32, 32, 1022, 1022, 0, 0
        DC16 0, 514, 1022, 1022, 514, 0, 0, 448, 960, 512, 514, 1022, 510, 2, 0
        DC16 514, 1022, 1022, 48, 248, 974, 774, 0, 514, 1022, 1022, 514, 512
        DC16 512, 768, 0, 1022, 1022, 28, 56, 28, 1022, 1022, 0, 1022, 1022, 28
        DC16 56, 112, 1022, 1022, 0, 248, 508, 774, 514, 774, 508, 248, 0, 514
        DC16 1022, 1022, 546, 34, 62, 28, 0, 508, 1022, 514, 642, 770, 1022
        DC16 508, 0, 514, 1022, 1022, 34, 98, 1022, 924, 0, 268, 798, 562, 546
        DC16 610, 974, 396, 0, 0, 14, 518, 1022, 1022, 518, 14, 0, 510, 1022
        DC16 512, 512, 512, 1022, 510, 0, 126, 254, 384, 768, 384, 254, 126, 0
        DC16 254, 1022, 896, 480, 896, 1022, 254, 0, 774, 990, 248, 32, 248
        DC16 990, 774, 0, 0, 30, 574, 992, 992, 574, 30, 0, 910, 966, 610, 562
        DC16 798, 910, 0, 0, 512, 768, 704, 544, 536, 516, 1022, 0, 0, 34, 66
        DC16 510, 1022, 576, 544, 0, 32, 16, 8, 6, 8, 16, 32, 32, 0, 544, 528
        DC16 1020, 1022, 18, 34, 0, 0, 512, 512, 512, 512, 512, 512, 0, 514
        DC16 514, 514, 514, 514, 514, 514, 514, 448, 1000, 552, 552, 504, 1008
        DC16 512, 0, 514, 1022, 510, 544, 544, 992, 448, 0, 480, 1008, 528, 528
        DC16 528, 816, 288, 0, 0, 448, 992, 544, 546, 1022, 1022, 0, 480, 1008
        DC16 592, 592, 592, 880, 352, 0, 0, 544, 1020, 1022, 546, 2, 4, 0, 304
        DC16 888, 584, 584, 1016, 504, 0, 0, 514, 1022, 1022, 32, 16, 1008, 992
        DC16 0, 0, 0, 512, 1014, 1014, 512, 0, 0, 0, 256, 768, 528, 1014, 502
        DC16 0, 0, 514, 1022, 1022, 98, 240, 920, 776, 0, 0, 0, 514, 1022, 1022
        DC16 512, 0, 0, 1016, 1016, 24, 1008, 24, 1016, 1008, 0, 8, 1016, 1008
        DC16 8, 8, 1016, 1008, 0, 0, 496, 1016, 520, 520, 1016, 496, 0, 520
        DC16 1016, 1008, 584, 72, 120, 48, 0, 48, 120, 72, 584, 1016, 1016, 512
        DC16 0, 520, 1016, 1008, 536, 8, 24, 48, 0, 0, 272, 824, 616, 584, 984
        DC16 400, 0, 16, 16, 504, 1020, 528, 784, 256, 0, 504, 1016, 512, 512
        DC16 504, 1016, 512, 0, 0, 248, 504, 768, 768, 504, 248, 0, 248, 1016
        DC16 768, 384, 768, 1016, 248, 0, 520, 792, 432, 224, 432, 792, 520, 0
        DC16 56, 632, 576, 576, 576, 504, 248, 0, 792, 904, 712, 616, 568, 792
        DC16 0, 0, 248, 136, 910, 34, 762, 762, 762, 762, 0, 0, 0, 1022, 1022
        DC16 0, 0, 0, 762, 762, 762, 762, 762, 514, 1022, 0, 248, 136, 910, 514
        DC16 514, 514, 514, 514
//   31   0x000,0x000,0x000,0x780,0x040,0x020,0x020,0x020, // " 左上角
//   32   0x020,0x020,0x040,0x780,0x000,0x000,0x000,0x000, // # 右上角
//   33   0x000,0x000,0x000,0x00F,0x010,0x020,0x020,0x020, // $ 左下角
//   34   0x30C,0x18C,0x0C0,0x060,0x030,0x318,0x30C,0x000, // % 
//   35   0x000,0x180,0x260,0x21C,0x26A,0x284,0x140,0x000, // & 
//   36   0x202,0x202,0x202,0x202,0x202,0x202,0x3FE,0x000, // ' 电池尾空
//   37   0x000,0x000,0x0F8,0x1FC,0x306,0x202,0x000,0x000, // (
//   38   0x000,0x000,0x202,0x306,0x1FC,0x0F8,0x000,0x000, // )
//   39   0x000,0x18C,0x0D8,0x070,0x070,0x0D8,0x18C,0x000, // *  ×
//   40   0x000,0x020,0x020,0x0F8,0x0F8,0x020,0x020,0x000, // + 
//   41   0x020,0x020,0x010,0x00F,0x000,0x000,0x000,0x000, // , 右下角
//   42   0x000,0x020,0x020,0x020,0x020,0x020,0x020,0x000, // -
//   43   0x000,0x000,0x300,0x300,0x000,0x000,0x000,0x000, // .
//   44   0x180,0x0C0,0x060,0x030,0x018,0x00C,0x006,0x000, // / 
//   45   0x1FC,0x3FE,0x242,0x222,0x212,0x3FE,0x1FC,0x000, // 0
//   46   0x000,0x208,0x20C,0x3FE,0x3FE,0x200,0x200,0x000, // 1
//   47   0x304,0x386,0x2C2,0x262,0x232,0x31E,0x30C,0x000, // 2
//   48   0x104,0x306,0x222,0x222,0x222,0x3FE,0x1DC,0x000, // 3
//   49   0x060,0x070,0x058,0x24C,0x3FE,0x3FE,0x240,0x000, // 4
//   50   0x11E,0x21E,0x212,0x212,0x212,0x3F2,0x1E2,0x000, // 5
//   51   0x1F8,0x3FC,0x226,0x222,0x222,0x3E0,0x1C0,0x000, // 6
//   52   0x006,0x006,0x3C2,0x3E2,0x032,0x01E,0x00E,0x000, // 7
//   53   0x1DC,0x3FE,0x222,0x222,0x222,0x3FE,0x1DC,0x000, // 8
//   54   0x01C,0x23E,0x222,0x222,0x322,0x1FE,0x0FC,0x000, // 9
//   55   0x000,0x000,0x000,0x198,0x198,0x000,0x000,0x000, // : 
//   56   0x2FA,0x2FA,0x2FA,0x2FA,0x2FA,0x2FA,0x2FA,0x2FA, // ; 电池身
//   57   0x000,0x020,0x070,0x0D8,0x18C,0x306,0x202,0x000, // <
//   58   0x090,0x090,0x090,0x090,0x090,0x090,0x000,0x000, // =  
//   59   0x000,0x202,0x306,0x18C,0x0D8,0x070,0x020,0x000, // >
//   60   0x018,0x01C,0x004,0x344,0x364,0x03C,0x018,0x000, // ? 
//   61   0x1F8,0x104,0x272,0x272,0x2F2,0x284,0x078,0x000, // @ 
//   62   0x3F0,0x3F8,0x04C,0x046,0x04C,0x3F8,0x3F0,0x000, // A
//   63   0x202,0x3FE,0x3FE,0x222,0x222,0x3FE,0x1DC,0x000, // B
//   64   0x0F8,0x1FC,0x306,0x202,0x202,0x306,0x18C,0x000, // C
//   65   0x202,0x3FE,0x3FE,0x202,0x306,0x1FC,0x0F8,0x000, // D
//   66   0x202,0x3FE,0x3FE,0x222,0x272,0x306,0x38E,0x000, // E
//   67   0x202,0x3FE,0x3FE,0x222,0x072,0x006,0x00E,0x000, // F
//   68   0x0F8,0x1FC,0x306,0x222,0x222,0x1E6,0x3EC,0x000, // G
//   69   0x3FE,0x3FE,0x020,0x020,0x020,0x3FE,0x3FE,0x000, // H
//   70   0x000,0x000,0x202,0x3FE,0x3FE,0x202,0x000,0x000, // I
//   71   0x1C0,0x3C0,0x200,0x202,0x3FE,0x1FE,0x002,0x000, // J
//   72   0x202,0x3FE,0x3FE,0x030,0x0F8,0x3CE,0x306,0x000, // K
//   73   0x202,0x3FE,0x3FE,0x202,0x200,0x200,0x300,0x000, // L
//   74   0x3FE,0x3FE,0x01C,0x038,0x01C,0x3FE,0x3FE,0x000, // M
//   75   0x3FE,0x3FE,0x01C,0x038,0x070,0x3FE,0x3FE,0x000, // N
//   76   0x0F8,0x1FC,0x306,0x202,0x306,0x1FC,0x0F8,0x000, // O
//   77   0x202,0x3FE,0x3FE,0x222,0x022,0x03E,0x01C,0x000, // P
//   78   0x1FC,0x3FE,0x202,0x282,0x302,0x3FE,0x1FC,0x000, // Q
//   79   0x202,0x3FE,0x3FE,0x022,0x062,0x3FE,0x39C,0x000, // R
//   80   0x10C,0x31E,0x232,0x222,0x262,0x3CE,0x18C,0x000, // S
//   81   0x000,0x00E,0x206,0x3FE,0x3FE,0x206,0x00E,0x000, // T
//   82   0x1FE,0x3FE,0x200,0x200,0x200,0x3FE,0x1FE,0x000, // U
//   83   0x07E,0x0FE,0x180,0x300,0x180,0x0FE,0x07E,0x000, // V
//   84   0x0FE,0x3FE,0x380,0x1E0,0x380,0x3FE,0x0FE,0x000, // W
//   85   0x306,0x3DE,0x0F8,0x020,0x0F8,0x3DE,0x306,0x000, // X
//   86   0x000,0x01E,0x23E,0x3E0,0x3E0,0x23E,0x01E,0x000, // Y
//   87   0x38E,0x3C6,0x262,0x232,0x31E,0x38E,0x000,0x000, // Z
//   88   0x200,0x300,0x2C0,0x220,0x218,0x204,0x3FE,0x000, // [ 三角       
//   89   0x000,0x022,0x042,0x1FE,0x3FE,0x240,0x220,0x000, // \下降沿   
//   90   0x020,0x010,0x008,0x006,0x008,0x010,0x020,0x020, // ] 指针    
//   91   0x000,0x220,0x210,0x3FC,0x3FE,0x012,0x022,0x000, // ^ 上升沿  
//   92   0x000,0x200,0x200,0x200,0x200,0x200,0x200,0x000, // _ 下横线  
//   93   0x202,0x202,0x202,0x202,0x202,0x202,0x202,0x202, // ` 电池身空
//   94   0x1C0,0x3E8,0x228,0x228,0x1F8,0x3F0,0x200,0x000, // a         
//   95   0x202,0x3FE,0x1FE,0x220,0x220,0x3E0,0x1C0,0x000, // b 
//   96   0x1E0,0x3F0,0x210,0x210,0x210,0x330,0x120,0x000, // c 
//   97   0x000,0x1C0,0x3E0,0x220,0x222,0x3FE,0x3FE,0x000, // d 
//   98   0x1E0,0x3F0,0x250,0x250,0x250,0x370,0x160,0x000, // e 
//   99   0x000,0x220,0x3FC,0x3FE,0x222,0x002,0x004,0x000, // f
//  100   0x130,0x378,0x248,0x248,0x3F8,0x1F8,0x000,0x000, // g
//  101   0x202,0x3FE,0x3FE,0x020,0x010,0x3F0,0x3E0,0x000, // h
//  102   0x000,0x000,0x200,0x3F6,0x3F6,0x200,0x000,0x000, // i 
//  103   0x000,0x100,0x300,0x210,0x3F6,0x1F6,0x000,0x000, // j
//  104   0x202,0x3FE,0x3FE,0x062,0x0F0,0x398,0x308,0x000, // k
//  105   0x000,0x000,0x202,0x3FE,0x3FE,0x200,0x000,0x000, // l
//  106   0x3F8,0x3F8,0x018,0x3F0,0x018,0x3F8,0x3F0,0x000, // m 
//  107   0x008,0x3F8,0x3F0,0x008,0x008,0x3F8,0x3F0,0x000, // n 
//  108   0x000,0x1F0,0x3F8,0x208,0x208,0x3F8,0x1F0,0x000, // o
//  109   0x208,0x3F8,0x3F0,0x248,0x048,0x078,0x030,0x000, // p 
//  110   0x030,0x078,0x048,0x248,0x3F8,0x3F8,0x200,0x000, // q
//  111   0x208,0x3F8,0x3F0,0x218,0x008,0x018,0x030,0x000, // r 
//  112   0x000,0x110,0x338,0x268,0x248,0x3D8,0x190,0x000, // s 
//  113   0x010,0x010,0x1F8,0x3FC,0x210,0x310,0x100,0x000, // t
//  114   0x1F8,0x3F8,0x200,0x200,0x1F8,0x3F8,0x200,0x000, // u 
//  115   0x000,0x0F8,0x1F8,0x300,0x300,0x1F8,0x0F8,0x000, // v
//  116   0x0F8,0x3F8,0x300,0x180,0x300,0x3F8,0x0F8,0x000, // w
//  117   0x208,0x318,0x1B0,0x0E0,0x1B0,0x318,0x208,0x000, // x
//  118   0x038,0x278,0x240,0x240,0x240,0x1F8,0x0F8,0x000, // y
//  119   0x318,0x388,0x2C8,0x268,0x238,0x318,0x000,0x000, // z 
//  120   0x0F8,0x088,0x38E,0x022,0x2FA,0x2FA,0x2FA,0x2FA, // { 电池头
//  121   0x000,0x000,0x000,0x3FE,0x3FE,0x000,0x000,0x000, // | 
//  122   0x2FA,0x2FA,0x2FA,0x2FA,0x2FA,0x202,0x3FE,0x000, // } 电池尾
//  123   0x0F8,0x088,0x38E,0x202,0x202,0x202,0x202,0x202};// ~ 空电池头
//  124 

        SECTION `.rodata`:CONST:NOROOT(2)
//  125 uc8  Ref_Wave [300] =   //样本波形描述
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
//  126 {100,116,130,144,157,167,175,181,185,185,184,179,173,164,153,141,128,114,100, 86,
//  127   73, 60, 49, 40, 33, 27, 24, 24, 25, 29, 35, 43, 52, 63, 75, 87,100,112,124,135,
//  128  145,153,160,164,167,167,166,163,157,150,142,133,122,111,100, 89, 79, 70, 61, 54,
//  129   48, 44, 42, 42, 43, 46, 50, 57, 64, 72, 81, 90,100,109,118,126,133,139,144,147,
//  130  149,149,148,146,142,137,130,124,116,108,100, 93, 85, 79, 73, 68, 64, 61, 60, 60,
//  131   61, 63, 66, 70, 75, 81, 87, 93,100,106,112,117,122,125,128,130,131,131,131,129,
//  132  126,123,119,115,110,105,100, 96, 91, 88, 84, 81, 79, 78, 77, 78, 78, 80, 82, 84, 
//  133   87, 90, 93, 97,100,103,106,108,110,112,113,114,114,113,113,112,110,109,107,105,
//  134  104,102,100,99, 97, 96, 96, 95, 95, 95, 95, 96, 96, 97, 97, 98, 99, 99, 100,100,
//  135  100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,
//  136  100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,
//  137  100,100,100,100,100,115,129,141,151,160,165,169,170,169,167,162,156,148,139,130,
//  138  120,110,100, 91, 82, 75, 68, 63, 59, 57, 56, 56, 58, 61, 64, 69, 75, 81, 87, 94,
//  139  100,106,112,117,121,125,127,129,130,130,128,127,124,121,117,113,109,104,100, 96, 
//  140   92, 88, 85, 83, 81, 80, 79, 79, 80, 81, 83, 85, 88, 91, 94, 97,100,103,106,108,};
//  141 

        SECTION `.rodata`:CONST:NOROOT(2)
//  142 uc16  Row_Base0[201] =     //空白列基础数据
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
//  143 {BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
//  144  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
//  145  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 20~30
//  146  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
//  147  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
//  148  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
//  149  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
//  150  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 70~80
//  151  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
//  152  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
//  153  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
//  154  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
//  155  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 20~30
//  156  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
//  157  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
//  158  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
//  159  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
//  160  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 70~80
//  161  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
//  162  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
//  163  BLACK };
//  164    

        SECTION `.rodata`:CONST:NOROOT(2)
//  165 uc16  Row_Base1[201] =     //仅含垂直边线的列基础数据
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
//  166 {GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 00~10
//  167  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 10~20
//  168  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 20~30
//  169  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 30~40
//  170  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 40~50
//  171  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 50~60
//  172  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 60~70
//  173  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 70~80
//  174  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 80~90
//  175  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 90~00
//  176  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 00~10
//  177  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 10~20
//  178  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 20~30
//  179  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 30~40
//  180  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 40~50
//  181  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 50~60
//  182  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 60~70
//  183  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 70~80
//  184  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 80~90
//  185  GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 90~00
//  186  GRAY };
//  187    
//  188 uc16  Row_Base2[201] =     //仅含水平边线的列基础数据
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
//  189 {GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
//  190  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
//  191  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 20~30
//  192  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
//  193  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
//  194  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
//  195  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
//  196  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 70~80
//  197  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
//  198  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
//  199  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
//  200  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
//  201  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 20~30
//  202  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
//  203  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
//  204  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
//  205  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
//  206  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 70~80
//  207  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
//  208  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
//  209  GRAY };
//  210    
//  211 uc16  Row_Base3[201] =     //含水平格线和水平边线的列基础数据
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
//  212 {GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
//  213  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
//  214  BLACK,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 20~30
//  215  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
//  216  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
//  217  GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
//  218  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
//  219  BLACK,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 70~80
//  220  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
//  221  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
//  222  GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
//  223  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
//  224  BLACK,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 20~30
//  225  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
//  226  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
//  227  GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
//  228  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
//  229  BLACK,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 70~80
//  230  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
//  231  BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
//  232  GRAY };
//  233    
//  234 uc16  Row_Base4[201] =     //含垂直格线和水平边线的列基础数据
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
//  235 {GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 00~10
//  236  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 10~20
//  237  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 20~30
//  238  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 30~40
//  239  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 40~50
//  240  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 50~60
//  241  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 60~70
//  242  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 70~80
//  243  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 80~90
//  244  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 90~00
//  245  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 00~10
//  246  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 10~20
//  247  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 20~30
//  248  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 30~40
//  249  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 40~50
//  250  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 50~60
//  251  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 60~70
//  252  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 70~80
//  253  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 80~90
//  254  GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 90~00
//  255  GRAY };
//  256    

        SECTION `.data`:DATA:NOROOT(2)
//  257 u16 Color[16] = { CYAN,   // #0  TRACK1 
//  258                   YEL,    // #1  TRACK2
//  259                   PURPL,  // #2  TRACK3 
//  260                   GRN,    // #3  TRACK4 
//  261                   WHT,    // #4  VERNIE   
//  262                   BLACK,  // #5  SCRN
//  263                   ORANGE, // #6  X_POSI 
//  264                   BLUE,   // #7  TRIGG 
//  265                   CYAN,   // #8  VERNIE  
//  266                   GRAY,   // #9  GRID 
//  267                   WHT,    // #10 TEXT 
//  268                   GRN,    // #11 TEXT2
//  269                   BLUE,   // #12 TEXT3
//  270                   GRAY,   // #13 BLOCK
//  271                   YEL,    // #14 SIDE
//  272                   RED };  // #15 NOTE 
//  273 
//  274 trigg V_Trigg[4] = {// Value,  Flag:( HID=0x04, UPDAT=0x02 )
//  275                      {   175,  UPDAT + HID },
//  276                      {   116,  UPDAT       },
//  277                      {    75,  UPDAT + HID },
//  278                      {    35,  UPDAT + HID },
//  279                    };
//  280 u16 LCD_Buffer1[240], LCD_Buffer2[240];
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
//  281 u8  Vt1=180, Vt2=128, Vt3=70, Vt4=30;
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
//  282 
//  283 /*******************************************************************************
//  284  Get_TAB_8x11
//  285 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Get_TAB_8x11
        THUMB
//  286 u16 Get_TAB_8x11(u8 Code, u8 Row)
//  287 {
//  288   return Char_TAB_8x11[((Code-0x22)*8)+Row];
Get_TAB_8x11:
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable3  ;; Char_TAB_8x11
        ADD      R0,R1,R0, LSL #+1
        SUB      R0,R0,#+544
        LDRH     R0,[R0, #+0]
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//  289 }
//  290 /*******************************************************************************
//  291  Get_Ref_Wave: 
//  292 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function Get_Ref_Wave
        THUMB
//  293 u8 Get_Ref_Wave(u16 i)
//  294 {
//  295   return Ref_Wave[i];
Get_Ref_Wave:
        LDR.N    R1,??Get_Ref_Wave_0  ;; Ref_Wave
        LDRB     R0,[R0, R1]
        BX       LR               ;; return
        Nop      
        DATA
??Get_Ref_Wave_0:
        DC32     Ref_Wave
        CFI EndBlock cfiBlock1
//  296 }
//  297 /*******************************************************************************
//  298  Print_Clk: 进度指示
//  299 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Print_Clk
        THUMB
//  300 void Print_Clk(u16 x0, u16 y0, u16 Type, u8 Phase)
//  301 {
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
//  302   u16 i, j, b;
//  303   
//  304   __LCD_Set_Block(x0, x0+10, y0, y0+10);
        ADD      R3,R1,#+10
        UXTH     R3,R3
        MOVS     R2,R1
        ADD      R1,R0,#+10
        UXTH     R1,R1
        BL       __LCD_Set_Block
//  305   for(i=0; i<11; ++i){
        MOVS     R0,#+11
        MULS     R0,R5,R0
        LDR.N    R1,??Print_Clk_0  ;; CLK_TAB
        ADD      R5,R1,R0, LSL #+1
        MOVS     R6,#+11
        AND      R7,R4,#0xF
        ASRS     R4,R4,#+8
//  306     b = CLK_TAB[Phase *11 + i];
??Print_Clk_1:
        LDRH     R9,[R5, #+0]
//  307     for(j=0; j<11; ++j){
        MOV      R8,#+0
//  308       if((b >> j)& 0x001) __LCD_SetPixl(Color[Type >> 0x8]);
??Print_Clk_2:
        LDR.W    R0,??DataTable34  ;; LCD_Buffer1
        MOV      R1,R8
        ASR      R1,R9,R1
        TST      R1,#0x1
        BEQ.N    ??Print_Clk_3
        ADD      R0,R0,#+960
        LDRH     R0,[R0, R4, LSL #+1]
        B.N      ??Print_Clk_4
//  309       else                __LCD_SetPixl(Color[Type & 0x0F]);
??Print_Clk_3:
        ADD      R0,R0,#+960
        LDRH     R0,[R0, R7, LSL #+1]
??Print_Clk_4:
        BL       __LCD_SetPixl
//  310     }
        ADD      R8,R8,#+1
        UXTH     R0,R8
        CMP      R0,#+11
        BCC.N    ??Print_Clk_2
//  311   }
        ADDS     R5,R5,#+2
        SUBS     R6,R6,#+1
        BNE.N    ??Print_Clk_1
//  312   __LCD_Set_Block(LCD_X1,LCD_X2,LCD_Y1,LCD_Y2);  //恢复全尺寸窗口
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
//  313 }
//  314 /*******************************************************************************
//  315  Print_Str: 
//  316 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Print_Str
        THUMB
//  317 void Print_Str(u16 x0, u16 y0, u16 Type, u8 Mode, u8 *s)
//  318 { 
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
//  319   signed short i, j, b; 
//  320   __LCD_Set_Block(x0, LCD_X2, y0, y0+10);
        BL       __LCD_Set_Block
//  321   for (j=0; j<11;++j){ 
        MOVS     R7,#+11
        LDRH     R0,[SP, #+0]
        AND      R8,R0,#0xF
        ASR      R9,R0,#+8
        LDR.W    R6,??DataTable34  ;; LCD_Buffer1
//  322     if(Mode == 0) __LCD_SetPixl(Color[Type & 0x0F]);   //Normal replace Display
??Print_Str_0:
        CBNZ     R4,??Print_Str_1
        ADD      R0,R6,#+960
        LDRH     R0,[R0, R8, LSL #+1]
        B.N      ??Print_Str_2
//  323     else          __LCD_SetPixl(Color[Type >> 0x8]);   //Inverse replace Display
??Print_Str_1:
        ADD      R0,R6,#+960
        LDRH     R0,[R0, R9, LSL #+1]
??Print_Str_2:
        BL       __LCD_SetPixl
//  324   }
        SUBS     R7,R7,#+1
        BNE.N    ??Print_Str_0
//  325   x0++;                            // 每一个字符串前增加一空白列 
//  326   while (*s!=0) {
??Print_Str_3:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+0
        BEQ.N    ??Print_Str_4
//  327     for(i=0;i<8;++i){
        MOVS     R7,#+0
        LDRH     R0,[SP, #+0]
        AND      R8,R0,#0xF
        ASR      R9,R0,#+8
//  328       if((*s==0x20)||(*s==0x21)) b = 0x0000;
??Print_Str_5:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+32
        BEQ.N    ??Print_Str_6
        CMP      R0,#+33
        BNE.N    ??Print_Str_7
??Print_Str_6:
        MOV      R11,#+0
//  329       else                       b = Get_TAB_8x11(*s, i);
//  330       if((*s==0x21)&&(i==4)) break;
        CMP      R0,#+33
        BNE.N    ??Print_Str_8
        CMP      R7,#+4
        BEQ.N    ??Print_Str_9
//  331       for(j=0;j<11;++j){
??Print_Str_8:
        MOV      R10,#+0
//  332         if((b << j)& 0x400) {
??Print_Str_10:
        MOV      R0,R10
        LSL      R0,R11,R0
        TST      R0,#0x400
        BEQ.N    ??Print_Str_11
//  333           if(Mode == 0) __LCD_SetPixl(Color[Type >> 0x8]);
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
//  334           else          __LCD_SetPixl(Color[Type & 0x0F]);
//  335         } else {
//  336           if(Mode == 0) __LCD_SetPixl(Color[Type & 0x0F]);
//  337           else          __LCD_SetPixl(Color[Type >> 0x8]);
//  338         }
//  339       }
//  340     }
//  341     if(*s==0x21) x0 +=4;           //显示位置水平方向+4
//  342     else  x0 += 8;                 //显示位置水平方向+8
//  343     ++s;                           //字符串指针+1
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
//  344   }
//  345   __LCD_Set_Block(LCD_X1,LCD_X2,LCD_Y1,LCD_Y2);  //恢复全尺寸窗口
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
//  346 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable3:
        DC32     Char_TAB_8x11
//  347 /*******************************************************************************
//  348  Draw_Row : 为缓解DMA冲突，分两个缓冲区交替工作
//  349 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Draw_Row
        THUMB
//  350 void Draw_Row(u16 Row)
//  351 { 
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
//  352   u8  i, y[8], Dot_Hide[8]; 
//  353   s16 Tmp, m, n ;
//  354   if((Row > MIN_X)&&(Row <= MAX_X)){               // 波形显示区数据预处理
        CMP      R5,#+12
        BCC.N    ??Draw_Row_0
        MOV      R0,#+312
        CMP      R5,R0
        BCS.N    ??Draw_Row_0
//  355     m = (Row - MIN_X-1)* 4;
        SUB      R0,R5,#+12
        SXTH     R0,R0
        LSLS     R2,R0,#+2
        SXTH     R2,R2
//  356     n = (Row - MIN_X)  * 4;
        SUB      R0,R5,#+11
        SXTH     R0,R0
        LSLS     R3,R0,#+2
        SXTH     R3,R3
//  357     for(i = 0; i < 8; i += 2) {
        MOVS     R0,#+0
        ADD      R12,SP,#+8
        ADD      LR,SP,#+0
        LDR.W    R4,??Draw_Row_1  ;; TrackBuff
//  358       Dot_Hide[i] = 0;
??Draw_Row_2:
        MOVS     R1,#+0
        STRB     R1,[R12, #+0]
//  359       y[i]   = TrackBuff[m + i/2];                  // 端点提取
        ASRS     R1,R0,#+1
        ADDS     R6,R1,R2
        LDRB     R6,[R6, R4]
        STRB     R6,[LR, #+0]
//  360       y[i+1] = TrackBuff[n + i/2];
        ADDS     R1,R1,R3
        LDRB     R1,[R1, R4]
        STRB     R1,[LR, #+1]
//  361       
//  362       if(y[i]   >= Y_BASE+Y_SIZE)  y[i]   = Y_BASE+Y_SIZE-1;      // 超界处理
        CMP      R6,#+200
        BCC.N    ??Draw_Row_3
        MOVS     R6,#+199
        STRB     R6,[LR, #+0]
        B.N      ??Draw_Row_4
//  363       else if(y[i]   <= Y_BASE+1)  y[i]   = Y_BASE+1;   
??Draw_Row_3:
        CMP      R6,#+2
        BCS.N    ??Draw_Row_4
        MOVS     R6,#+1
        STRB     R6,[LR, #+0]
//  364       if(y[i+1] >= Y_BASE+Y_SIZE)  y[i+1] = Y_BASE+Y_SIZE-1;
??Draw_Row_4:
        CMP      R1,#+200
        BCC.N    ??Draw_Row_5
        MOVS     R1,#+199
        STRB     R1,[LR, #+1]
        B.N      ??Draw_Row_6
//  365       else if(y[i+1] <= Y_BASE+1)  y[i+1] = Y_BASE+1;
??Draw_Row_5:
        CMP      R1,#+2
        BCS.N    ??Draw_Row_6
        MOVS     R1,#+1
        STRB     R1,[LR, #+1]
//  366       
//  367       if(y[i] == y[i+1]){
??Draw_Row_6:
        LDRB     R1,[LR, #+0]
        LDRB     R6,[LR, #+1]
        CMP      R1,R6
        BNE.N    ??Draw_Row_7
//  368         if((y[i] == Y_BASE+1)||(y[i] == Y_SIZE-1)) Dot_Hide[i] = 1;  // 超界消隐
        CMP      R1,#+1
        BEQ.N    ??Draw_Row_8
        CMP      R1,#+199
        BNE.N    ??Draw_Row_9
??Draw_Row_8:
        MOVS     R1,#+1
        STRB     R1,[R12, #+0]
        B.N      ??Draw_Row_7
//  369         else {
//  370           if(y[i] >= Y_BASE+2)           y[i]   -= 1;              // 水平线加粗
??Draw_Row_9:
        CMP      R1,#+2
        BCC.N    ??Draw_Row_10
        SUBS     R1,R1,#+1
        STRB     R1,[LR, #+0]
//  371           if(y[i+1] <= Y_BASE+Y_SIZE-2)  y[i+1] += 1;
??Draw_Row_10:
        CMP      R6,#+199
        BCS.N    ??Draw_Row_7
        ADDS     R1,R6,#+1
        STRB     R1,[LR, #+1]
//  372         }
//  373       }
//  374       if(y[i] > y[i+1]){                                             // 大小排序
??Draw_Row_7:
        LDRB     R1,[LR, #+1]
        LDRB     R6,[LR, #+0]
        CMP      R1,R6
        ITT      CC 
//  375         Tmp = y[i+1]; y[i+1]= y[i]; y[i]= Tmp; 
        STRBCC   R6,[LR, #+1]
        STRBCC   R1,[LR, #+0]
//  376       }
//  377     }
        ADDS     R0,R0,#+2
        ADD      LR,LR,#+2
        ADD      R12,R12,#+2
        UXTB     R1,R0
        CMP      R1,#+8
        BCC.N    ??Draw_Row_2
//  378   } 
//  379   __Row_DMA_Ready();
??Draw_Row_0:
        BL       __Row_DMA_Ready
//  380   __Point_SCR(Row, MIN_Y);
        MOVS     R1,#+13
        MOVS     R0,R5
        BL       __Point_SCR
//  381   
//  382   if(Row & 1){                                       // Odd row process
        TST      R5,#0x1
        BEQ.W    ??Draw_Row_11
//  383 //----------------------- Fill the row base data -------------------------------
//  384     __Row_Copy(Row_Base2, LCD_Buffer1);
        LDR.W    R4,??DataTable34  ;; LCD_Buffer1
        MOVS     R1,R4
        LDR.W    R0,??Draw_Row_1+0x4  ;; Row_Base1 + 404
        BL       __Row_Copy
//  385 //------------------------- Draw the Curve data --------------------------------
//  386     if((Row > MIN_X)&&(Row < MAX_X)){             
        CMP      R5,#+12
        BCC.W    ??Draw_Row_12
        MOVW     R7,#+311
        CMP      R5,R7
        BCS.W    ??Draw_Row_13
//  387       if((Dot_Hide[0] == 0)&&(Title[TRACK1][SOURCE].Value != HIDE)){
        LDR.W    R2,??DataTable12  ;; Title
        LDRB     R0,[SP, #+8]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_14
        LDRSH    R0,[R2, #+16]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_14
//  388         if((y[1]-y[0])>5){
        LDRB     R0,[SP, #+0]
        ADD      R3,SP,#+0
        LDRB     R1,[R3, #+1]
        SUBS     R3,R1,R0
        CMP      R3,#+6
        BLT.N    ??Draw_Row_15
//  389           for(i=y[0]; i<=y[1]; ++i) LCD_Buffer2[i] |=Color[TR_1]-0x4200; // 低亮度
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
//  390         } else {
//  391           for(i=y[0]; i<=y[1]; ++i) LCD_Buffer2[i] |=Color[TR_1];        // 正常亮度
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
//  392         }
//  393       }
//  394       if((Dot_Hide[2] == 0)&&(Title[TRACK2][SOURCE].Value != HIDE)){
??Draw_Row_14:
        ADD      R1,SP,#+8
        LDRB     R0,[R1, #+2]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_18
        LDRSH    R0,[R2, #+96]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_18
//  395         if((y[3]-y[2])>5){
        ADD      R3,SP,#+0
        LDRB     R12,[R3, #+2]
        MOV      R0,R12
        LDRB     R3,[R3, #+3]
        SUB      R12,R3,R12
        CMP      R12,#+6
        BLT.N    ??Draw_Row_19
//  396           for(i=y[2]; i<=y[3]; ++i) LCD_Buffer2[i] |=Color[TR_2]-0x0208; // 低亮度
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
//  397         } else {   
//  398           for(i=y[2]; i<=y[3]; ++i) LCD_Buffer2[i] |=Color[TR_2];        // 正常亮度
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
//  399         }
//  400       }
//  401       if((Dot_Hide[4] == 0)&&(Title[TRACK3][SOURCE].Value != HIDE)){
??Draw_Row_18:
        LDRB     R0,[R1, #+4]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_22
        LDRSH    R0,[R2, #+176]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_22
//  402         if((y[5]-y[4])>5){
        ADD      R3,SP,#+0
        LDRB     R12,[R3, #+4]
        MOV      R0,R12
        LDRB     R3,[R3, #+5]
        SUB      R12,R3,R12
        CMP      R12,#+6
        BLT.N    ??Draw_Row_23
//  403           for(i=y[4]; i<=y[5]; ++i) LCD_Buffer2[i] |=Color[TR_3]-0x4008; // 低亮度
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
//  404         } else {
//  405           for(i=y[4]; i<=y[5]; ++i) LCD_Buffer2[i] |=Color[TR_3];        // 正常亮度
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
//  406         }
//  407       }
//  408       if((Dot_Hide[6] == 0)&&(Title[TRACK4][SOURCE].Value != HIDE)){
??Draw_Row_22:
        LDRB     R0,[R1, #+6]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_26
        LDRSH    R0,[R2, #+256]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_26
//  409         if((y[7]-y[6])>5){
        ADD      R3,SP,#+0
        LDRB     R12,[R3, #+6]
        MOV      R0,R12
        LDRB     R1,[R3, #+7]
        SUB      R3,R1,R12
        CMP      R3,#+6
        BLT.N    ??Draw_Row_27
//  410           for(i=y[6]; i<=y[7]; ++i) LCD_Buffer2[i] |=Color[TR_4]-0x0200; // 低亮度
        CMP      R1,R0
        BCC.N    ??Draw_Row_26
        ADD      R3,R4,R0, LSL #+1
        ADD      R3,R3,#+480
        LDRH     R12,[R4, #+966]
        SUB      R12,R12,#+512
??Draw_Row_28:
        LDRH     LR,[R3, #+0]
        ORR      LR,R12,LR
        STRH     LR,[R3], #+2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        CMP      R1,R0
        BCC.N    ??Draw_Row_26
        B.N      ??Draw_Row_28
//  411         } else {
//  412           for(i=y[6]; i<=y[7]; ++i) LCD_Buffer2[i] |=Color[TR_4];        // 正常亮度
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
//  413         }
//  414       }
//  415 //------------------------- Draw the Trigg Vernie data -------------------------
//  416       if(Title[TRIGG][SOURCE].Value == TRACK1) 
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
//  417         LCD_Buffer2[V_Trigg[TRACK1].Value] |= Color[TR_1];
//  418       if(Title[TRIGG][SOURCE].Value == TRACK2) 
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
//  419         LCD_Buffer2[V_Trigg[TRACK2].Value] |= Color[TR_2];
//  420       if(Title[TRIGG][SOURCE].Value == TRACK3) 
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
//  421         LCD_Buffer2[V_Trigg[TRACK3].Value] |= Color[TR_3];
//  422       if(Title[TRIGG][SOURCE].Value == TRACK4) 
??Draw_Row_33:
        CMP      R0,#+3
        BNE.N    ??Draw_Row_31
        LDRSH    R0,[R4, #+1004]
        ADD      R0,R4,R0, LSL #+1
        LDRH     R1,[R0, #+480]
        LDRH     R3,[R4, #+966]
        ORRS     R1,R3,R1
        STRH     R1,[R0, #+480]
//  423         LCD_Buffer2[V_Trigg[TRACK4].Value] |= Color[TR_4];
//  424 //------------------------- Draw the X Vernie data -----------------------------
//  425       Tmp =(MIN_X + 150)- _X_posi.Value;
??Draw_Row_31:
        LDRH     R0,[R2, #+456]
        RSB      R0,R0,#+161
        SXTH     R0,R0
//  426       if(Tmp > MIN_X) {
        CMP      R0,#+12
        BLT.N    ??Draw_Row_34
//  427         if((Row == Tmp)&&((_X_posi.Flag & HID)== 0)){
        CMP      R5,R0
        BNE.N    ??Draw_Row_35
        ADD      R1,R2,#+458
        LDRB     R1,[R1, #+0]
        TST      R1,#0x4
        BNE.N    ??Draw_Row_35
//  428           for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer2[i] |= Color[X_POSI];
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
//  429         }
//  430         if((Row == Tmp-1)||(Row == Tmp+1)){
??Draw_Row_35:
        SUBS     R1,R0,#+1
        CMP      R5,R1
        BEQ.N    ??Draw_Row_37
        ADDS     R1,R0,#+1
        CMP      R5,R1
        BNE.N    ??Draw_Row_38
//  431           LCD_Buffer2[Y_SIZE] = Color[X_POSI];
??Draw_Row_37:
        LDRH     R1,[R4, #+972]
        STRH     R1,[R4, #+880]
//  432           LCD_Buffer2[Y_BASE] = Color[X_POSI];
        STRH     R1,[R4, #+480]
//  433         }
//  434         if(Row == Tmp){
??Draw_Row_38:
        CMP      R5,R0
        BNE.N    ??Draw_Row_34
//  435           LCD_Buffer2[Y_SIZE]   = Color[X_POSI];
        LDRH     R1,[R4, #+972]
        STRH     R1,[R4, #+880]
//  436           LCD_Buffer2[Y_SIZE-1] = Color[X_POSI];
        STRH     R1,[R4, #+878]
//  437           LCD_Buffer2[Y_BASE+1] = Color[X_POSI];
        ADD      R0,R4,#+482
        STRH     R1,[R0, #+0]
//  438           LCD_Buffer2[Y_BASE]   = Color[X_POSI];
        STRH     R1,[R4, #+480]
//  439         }
//  440       }
//  441       Tmp = MIN_X + Title[T_VERNIE][T1].Value;
??Draw_Row_34:
        LDRH     R0,[R2, #+816]
        ADD      R1,R0,#+11
        SXTH     R1,R1
//  442       if((Row == Tmp)&&((Title[T_VERNIE][T1].Flag & HID)== 0)){
        CMP      R5,R1
        BNE.N    ??Draw_Row_39
        LDRB     R0,[R2, #+818]
        TST      R0,#0x4
        BNE.N    ??Draw_Row_39
//  443         for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer2[i] |= Color[VERNIE];
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
//  444       }
//  445       if((Row == Tmp-1)||(Row == Tmp+1)){
??Draw_Row_39:
        SUBS     R0,R1,#+1
        CMP      R5,R0
        BEQ.N    ??Draw_Row_41
        ADDS     R0,R1,#+1
        CMP      R5,R0
        BNE.N    ??Draw_Row_42
//  446         LCD_Buffer2[Y_SIZE] |= Color[VERNIE];
??Draw_Row_41:
        LDRH     R0,[R4, #+968]
        LDRH     R3,[R4, #+880]
        ORRS     R3,R0,R3
        STRH     R3,[R4, #+880]
//  447         LCD_Buffer2[Y_BASE] |= Color[VERNIE];
        LDRH     R3,[R4, #+480]
        ORRS     R0,R0,R3
        STRH     R0,[R4, #+480]
//  448       }
//  449       if(Row == Tmp){
??Draw_Row_42:
        CMP      R5,R1
        BNE.N    ??Draw_Row_43
//  450         LCD_Buffer2[Y_SIZE]   |= Color[VERNIE];
        LDRH     R0,[R4, #+968]
        LDRH     R1,[R4, #+880]
        ORRS     R1,R0,R1
        STRH     R1,[R4, #+880]
//  451         LCD_Buffer2[Y_SIZE-1] |= Color[VERNIE];
        LDRH     R1,[R4, #+878]
        ORRS     R1,R0,R1
        STRH     R1,[R4, #+878]
//  452         LCD_Buffer2[Y_BASE+1] |= Color[VERNIE];
        ADD      R1,R4,#+482
        LDRH     R1,[R1, #+0]
        ORRS     R1,R0,R1
        ADD      R3,R4,#+482
        STRH     R1,[R3, #+0]
//  453         LCD_Buffer2[Y_BASE]   |= Color[VERNIE];
        LDRH     R1,[R4, #+480]
        ORRS     R0,R0,R1
        STRH     R0,[R4, #+480]
//  454       }
//  455       Tmp = MIN_X + Title[T_VERNIE][T2].Value;
??Draw_Row_43:
        LDRH     R0,[R2, #+836]
        ADD      R1,R0,#+11
        SXTH     R1,R1
//  456       if((Row == Tmp)&&((Title[T_VERNIE][T2].Flag & HID)== 0)){
        CMP      R5,R1
        BNE.N    ??Draw_Row_44
        LDRB     R0,[R2, #+838]
        TST      R0,#0x4
        BNE.N    ??Draw_Row_44
//  457         for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer2[i] |= Color[VERNIE];
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
//  458       }
//  459       if((Row == Tmp-1)||(Row == Tmp+1)){
??Draw_Row_44:
        SUBS     R0,R1,#+1
        CMP      R5,R0
        BEQ.N    ??Draw_Row_46
        ADDS     R0,R1,#+1
        CMP      R5,R0
        BNE.N    ??Draw_Row_47
//  460         LCD_Buffer2[Y_SIZE] = Color[VERNIE];
??Draw_Row_46:
        LDRH     R0,[R4, #+968]
        STRH     R0,[R4, #+880]
//  461         LCD_Buffer2[Y_BASE] = Color[VERNIE];
        STRH     R0,[R4, #+480]
//  462       }
//  463       if(Row == Tmp){
??Draw_Row_47:
        CMP      R5,R1
        BNE.N    ??Draw_Row_48
//  464         LCD_Buffer2[Y_SIZE]   = Color[VERNIE];
        LDRH     R0,[R4, #+968]
        STRH     R0,[R4, #+880]
//  465         LCD_Buffer2[Y_SIZE-1] = Color[VERNIE];
        STRH     R0,[R4, #+878]
//  466         LCD_Buffer2[Y_BASE+1] = Color[VERNIE];
        ADD      R1,R4,#+482
        B.N      ??Draw_Row_49
//  467       }
//  468     } 
//  469 //------------------------- Draw the Y Vernie data -----------------------------
//  470       if((Row == MIN_X)||(Row == MAX_X)){
??Draw_Row_12:
        CMP      R5,#+11
        BNE.N    ??Draw_Row_48
        B.N      ??Draw_Row_50
??Draw_Row_13:
        BNE.N    ??Draw_Row_48
//  471         LCD_Buffer2[Title[V_VERNIE][V1].Value-1] |= Color[VERNIE];
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
//  472         LCD_Buffer2[Title[V_VERNIE][V1].Value+0] |= Color[VERNIE];
        LDRH     R3,[R1, #+480]
        ORRS     R3,R0,R3
        STRH     R3,[R1, #+480]
//  473         LCD_Buffer2[Title[V_VERNIE][V1].Value+1] |= Color[VERNIE];
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
//  474         LCD_Buffer2[Title[V_VERNIE][V2].Value-1] |= Color[VERNIE];
//  475         LCD_Buffer2[Title[V_VERNIE][V2].Value+0] |= Color[VERNIE];
        LDRH     R2,[R1, #+480]
        ORRS     R2,R0,R2
        STRH     R2,[R1, #+480]
//  476         LCD_Buffer2[Title[V_VERNIE][V2].Value+1] |= Color[VERNIE];
        ADD      R2,R1,#+482
        LDRH     R2,[R2, #+0]
        ORRS     R0,R0,R2
        ADD      R1,R1,#+482
??Draw_Row_49:
        STRH     R0,[R1, #+0]
//  477       }
//  478     __LCD_Copy(LCD_Buffer2, Y_SIZE+1);               // Odd row Transitive
??Draw_Row_48:
        MOVS     R1,#+201
        ADD      R0,R4,#+480
        B.N      ??Draw_Row_51
//  479   } else {                                           // Even row process
//  480 //----------------------- Fill the row base data -------------------------------
//  481     if(Row+1 == MAX_X)                   __Row_Copy(Row_Base1, LCD_Buffer2);
??Draw_Row_11:
        ADDS     R0,R5,#+1
        MOVW     R7,#+311
        CMP      R0,R7
        BNE.N    ??Draw_Row_52
        LDR.W    R1,??Draw_Row_1+0x8  ;; LCD_Buffer1 + 480
        LDR.W    R0,??DataTable33  ;; Row_Base1
        B.N      ??Draw_Row_53
//  482     else if(Row+1 == MIN_X)              ;
??Draw_Row_52:
        CMP      R0,#+11
        BEQ.N    ??Draw_Row_54
//  483     else if((Row+1 - MIN_X)%30 == 0)     __Row_Copy(Row_Base4, LCD_Buffer2);
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
//  484     else if((Row+1 - MIN_X)%6  == 0)     __Row_Copy(Row_Base3, LCD_Buffer2);
??Draw_Row_55:
        MOVS     R1,#+6
        SDIV     R3,R0,R1
        MLS      R0,R3,R1,R0
        CBNZ     R0,??Draw_Row_56
        ADD      R1,R4,#+480
        ADD      R0,R2,#+808
        B.N      ??Draw_Row_53
//  485     else                                 __Row_Copy(Row_Base2, LCD_Buffer2);
??Draw_Row_56:
        ADD      R1,R4,#+480
        ADD      R0,R2,#+404
??Draw_Row_53:
        BL       __Row_Copy
//  486 //------------------------- Draw the Y Vernie data -----------------------------
//  487     if((Row==MIN_X+1)||(Row==MAX_X-1)){
??Draw_Row_54:
        CMP      R5,#+12
        BEQ.N    ??Draw_Row_57
        MOV      R0,#+310
        CMP      R5,R0
        BNE.N    ??Draw_Row_58
//  488         LCD_Buffer1[Title[V_VERNIE][V1].Value] |= Color[VERNIE];
??Draw_Row_57:
        LDR.W    R2,??DataTable12  ;; Title
        LDRSH    R1,[R2, #+656]
        LDR.W    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, #+968]
        LDRH     R3,[R4, R1, LSL #+1]
        ORRS     R3,R0,R3
        STRH     R3,[R4, R1, LSL #+1]
//  489         LCD_Buffer1[Title[V_VERNIE][V2].Value] |= Color[VERNIE];
        LDRSH    R1,[R2, #+676]
        LDRH     R2,[R4, R1, LSL #+1]
        ORRS     R0,R0,R2
        STRH     R0,[R4, R1, LSL #+1]
//  490     }
//  491       if((Title[V_VERNIE][V1].Flag & HID)== 0) 
??Draw_Row_58:
        LDR.W    R2,??DataTable12  ;; Title
        LDRB     R0,[R2, #+658]
        TST      R0,#0x4
        BNE.N    ??Draw_Row_59
//  492         LCD_Buffer1[Title[V_VERNIE][V1].Value] |= Color[VERNIE];
        LDRSH    R1,[R2, #+656]
        LDR.W    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, R1, LSL #+1]
        LDRH     R3,[R4, #+968]
        ORRS     R0,R3,R0
        STRH     R0,[R4, R1, LSL #+1]
//  493       if((Title[V_VERNIE][V2].Flag & HID)== 0) 
??Draw_Row_59:
        LDRB     R0,[R2, #+678]
        TST      R0,#0x4
        BNE.N    ??Draw_Row_60
//  494         LCD_Buffer1[Title[V_VERNIE][V2].Value] |= Color[VERNIE];
        LDRSH    R1,[R2, #+676]
        LDR.W    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, R1, LSL #+1]
        LDRH     R3,[R4, #+968]
        ORRS     R0,R3,R0
        STRH     R0,[R4, R1, LSL #+1]
//  495 //------------------------- Draw the Curve data --------------------------------
//  496     if((Row > MIN_X)&&(Row < MAX_X)){              
??Draw_Row_60:
        CMP      R5,#+12
        BCC.W    ??Draw_Row_61
        CMP      R5,R7
        BCS.W    ??Draw_Row_61
//  497       if((Dot_Hide[0] == 0)&&(Title[TRACK1][SOURCE].Value != HIDE)){
        LDRB     R0,[SP, #+8]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_62
        LDRSH    R0,[R2, #+16]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_62
//  498         if((y[1]-y[0])>5){
        LDRB     R0,[SP, #+0]
        ADD      R3,SP,#+0
        LDRB     R1,[R3, #+1]
        SUBS     R3,R1,R0
        CMP      R3,#+6
        BLT.N    ??Draw_Row_63
//  499           for(i=y[0]; i<=y[1]; ++i) LCD_Buffer1[i] |=Color[TR_1]-0x4200; // 低亮度
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
//  500         } else {
//  501           for(i=y[0]; i<=y[1]; ++i) LCD_Buffer1[i] |=Color[TR_1];        // 正常亮度
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
//  502         }
//  503       }
//  504       if((Dot_Hide[2] == 0)&&(Title[TRACK2][SOURCE].Value != HIDE)){
??Draw_Row_62:
        ADD      R1,SP,#+8
        LDRB     R0,[R1, #+2]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_66
        LDRSH    R0,[R2, #+96]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_66
//  505         if((y[3]-y[2])>5){
        ADD      R3,SP,#+0
        LDRB     R12,[R3, #+2]
        MOV      R0,R12
        LDRB     R3,[R3, #+3]
        SUB      R12,R3,R12
        CMP      R12,#+6
        BLT.N    ??Draw_Row_67
//  506           for(i=y[2]; i<=y[3]; ++i) LCD_Buffer1[i] |=Color[TR_2]-0x0208; // 低亮度
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
//  507         } else {   
//  508           for(i=y[2]; i<=y[3]; ++i) LCD_Buffer1[i] |=Color[TR_2];        // 正常亮度
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
//  509         }
//  510       }
//  511       if((Dot_Hide[4] == 0)&&(Title[TRACK3][SOURCE].Value != HIDE)){
??Draw_Row_66:
        LDRB     R0,[R1, #+4]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_70
        LDRSH    R0,[R2, #+176]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_70
//  512         if((y[5]-y[4])>5){
        ADD      R3,SP,#+0
        LDRB     R12,[R3, #+4]
        MOV      R0,R12
        LDRB     R3,[R3, #+5]
        SUB      R12,R3,R12
        CMP      R12,#+6
        BLT.N    ??Draw_Row_71
//  513           for(i=y[4]; i<=y[5]; ++i) LCD_Buffer1[i] |=Color[TR_3]-0x4008; // 低亮度
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
//  514         } else {
//  515           for(i=y[4]; i<=y[5]; ++i) LCD_Buffer1[i] |=Color[TR_3];        // 正常亮度
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
//  516         }
//  517       }
//  518       if((Dot_Hide[6] == 0)&&(Title[TRACK4][SOURCE].Value != HIDE)){
??Draw_Row_70:
        LDRB     R0,[R1, #+6]
        CMP      R0,#+0
        BNE.N    ??Draw_Row_74
        LDRSH    R0,[R2, #+256]
        CMP      R0,#+0
        BEQ.N    ??Draw_Row_74
//  519         if((y[7]-y[6])>5){
        ADD      R3,SP,#+0
        LDRB     R12,[R3, #+6]
        MOV      R0,R12
        LDRB     R1,[R3, #+7]
        SUB      R3,R1,R12
        CMP      R3,#+6
        BLT.N    ??Draw_Row_75
//  520           for(i=y[6]; i<=y[7]; ++i) LCD_Buffer1[i] |=Color[TR_4]-0x0200; // 低亮度
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
//  521         } else {
//  522           for(i=y[6]; i<=y[7]; ++i) LCD_Buffer1[i] |=Color[TR_4];        // 正常亮度
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
//  523         }
//  524       }
//  525 //------------------------- Draw the X Vernie data -----------------------------
//  526       Tmp =(MIN_X + 150)- _X_posi.Value;
??Draw_Row_74:
        LDRH     R0,[R2, #+456]
        RSB      R0,R0,#+161
        SXTH     R0,R0
//  527       if(Tmp > MIN_X) {
        CMP      R0,#+12
        BLT.N    ??Draw_Row_78
//  528         if((Row == Tmp)&&((_X_posi.Flag & HID)== 0)){
        CMP      R5,R0
        BNE.N    ??Draw_Row_79
        ADD      R1,R2,#+458
        LDRB     R1,[R1, #+0]
        TST      R1,#0x4
        BNE.N    ??Draw_Row_79
//  529           for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer1[i] |= Color[X_POSI];
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
//  530         }
//  531         if((Row == Tmp-1)||(Row == Tmp+1)){
??Draw_Row_79:
        SUBS     R1,R0,#+1
        CMP      R5,R1
        BEQ.N    ??Draw_Row_81
        ADDS     R1,R0,#+1
        CMP      R5,R1
        BNE.N    ??Draw_Row_82
//  532           LCD_Buffer1[Y_SIZE] = Color[X_POSI];
??Draw_Row_81:
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R1,[R4, #+972]
        STRH     R1,[R4, #+400]
//  533           LCD_Buffer1[Y_BASE] = Color[X_POSI];
        STRH     R1,[R4, #+0]
//  534         }
//  535         if(Row == Tmp){
??Draw_Row_82:
        CMP      R5,R0
        BNE.N    ??Draw_Row_78
//  536           LCD_Buffer1[Y_SIZE]   = Color[X_POSI];
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R1,[R4, #+972]
        STRH     R1,[R4, #+400]
//  537           LCD_Buffer1[Y_SIZE-1] = Color[X_POSI];
        ADD      R0,R4,#+398
        STRH     R1,[R0, #+0]
//  538           LCD_Buffer1[Y_BASE+1] = Color[X_POSI];
        STRH     R1,[R4, #+2]
//  539           LCD_Buffer1[Y_BASE]   = Color[X_POSI];
        STRH     R1,[R4, #+0]
//  540         }
//  541       }
//  542       Tmp = MIN_X + Title[T_VERNIE][T1].Value;
??Draw_Row_78:
        LDRH     R0,[R2, #+816]
        ADD      R1,R0,#+11
        SXTH     R1,R1
//  543       if((Row == Tmp)&&((Title[T_VERNIE][T1].Flag & HID)== 0)){
        CMP      R5,R1
        BNE.N    ??Draw_Row_83
        LDRB     R0,[R2, #+818]
        TST      R0,#0x4
        BNE.N    ??Draw_Row_83
//  544         for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer1[i] |= Color[VERNIE];
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
//  545       }
//  546       if((Row == Tmp-1)||(Row == Tmp+1)){
??Draw_Row_83:
        SUBS     R0,R1,#+1
        CMP      R5,R0
        BEQ.N    ??Draw_Row_85
        ADDS     R0,R1,#+1
        CMP      R5,R0
        BNE.N    ??Draw_Row_86
//  547         LCD_Buffer1[Y_SIZE] = Color[VERNIE];
??Draw_Row_85:
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, #+968]
        STRH     R0,[R4, #+400]
//  548         LCD_Buffer1[Y_BASE] = Color[VERNIE];
        STRH     R0,[R4, #+0]
//  549       }
//  550       if(Row == Tmp){
??Draw_Row_86:
        CMP      R5,R1
        BNE.N    ??Draw_Row_87
//  551         LCD_Buffer1[Y_SIZE]   = Color[VERNIE];
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, #+968]
        STRH     R0,[R4, #+400]
//  552         LCD_Buffer1[Y_SIZE-1] = Color[VERNIE];
        ADD      R1,R4,#+398
        STRH     R0,[R1, #+0]
//  553         LCD_Buffer1[Y_BASE+1] = Color[VERNIE];
        STRH     R0,[R4, #+2]
//  554       }
//  555       Tmp = MIN_X + Title[T_VERNIE][T2].Value;
??Draw_Row_87:
        LDRH     R0,[R2, #+836]
        ADD      R1,R0,#+11
        SXTH     R1,R1
//  556       if((Row == Tmp)&&((Title[T_VERNIE][T2].Flag & HID)== 0)){
        CMP      R5,R1
        BNE.N    ??Draw_Row_88
        LDRB     R0,[R2, #+838]
        TST      R0,#0x4
        BNE.N    ??Draw_Row_88
//  557         for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer1[i] |= Color[VERNIE];
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
//  558       }
//  559       if((Row == Tmp-1)||(Row == Tmp+1)){
??Draw_Row_88:
        SUBS     R0,R1,#+1
        CMP      R5,R0
        BEQ.N    ??Draw_Row_90
        ADDS     R0,R1,#+1
        CMP      R5,R0
        BNE.N    ??Draw_Row_91
//  560         LCD_Buffer1[Y_SIZE] = Color[VERNIE];
??Draw_Row_90:
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, #+968]
        STRH     R0,[R4, #+400]
//  561         LCD_Buffer1[Y_BASE] = Color[VERNIE];
        STRH     R0,[R4, #+0]
//  562       }
//  563       if(Row == Tmp){
??Draw_Row_91:
        CMP      R5,R1
        BNE.N    ??Draw_Row_61
//  564         LCD_Buffer1[Y_SIZE]   = Color[VERNIE];
        LDR.N    R4,??DataTable34  ;; LCD_Buffer1
        LDRH     R0,[R4, #+968]
        STRH     R0,[R4, #+400]
//  565         LCD_Buffer1[Y_SIZE-1] = Color[VERNIE];
        ADD      R1,R4,#+398
        STRH     R0,[R1, #+0]
//  566         LCD_Buffer1[Y_BASE+1] = Color[VERNIE];
        STRH     R0,[R4, #+2]
//  567       }
//  568     }
//  569     __LCD_Copy(LCD_Buffer1, Y_SIZE+1);             // Even row Transitive
??Draw_Row_61:
        MOVS     R1,#+201
        LDR.N    R0,??DataTable34  ;; LCD_Buffer1
??Draw_Row_51:
        BL       __LCD_Copy
//  570   }
//  571 }
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
//  572 /*******************************************************************************
//  573  Draw_Window :  
//  574 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function Draw_Window
        THUMB
//  575 void Draw_Window(void)						
//  576 { 
Draw_Window:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//  577   u16 Row;
//  578   __Row_DMA_Ready();
        BL       __Row_DMA_Ready
//  579   __Row_Copy(Row_Base1, LCD_Buffer2);
        LDR.N    R4,??DataTable33  ;; Row_Base1
        LDR.N    R5,??DataTable34  ;; LCD_Buffer1
        ADD      R1,R5,#+480
        MOVS     R0,R4
        BL       __Row_Copy
//  580   __Row_DMA_Ready();
        BL       __Row_DMA_Ready
//  581   __Row_Copy(Row_Base2, LCD_Buffer1);
        MOVS     R1,R5
        ADD      R0,R4,#+404
        BL       __Row_Copy
//  582   for(Row = MIN_X; Row <= MAX_X; ++Row) Draw_Row(Row); 
        MOVS     R4,#+11
??Draw_Window_0:
        UXTH     R0,R4
        BL       Draw_Row
        ADDS     R4,R4,#+1
        MOV      R1,#+312
        UXTH     R0,R4
        CMP      R0,R1
        BCC.N    ??Draw_Window_0
//  583   __LCD_DMA_Ready();
        BL       __LCD_DMA_Ready
//  584   __Row_DMA_Ready();
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,LR}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      __Row_DMA_Ready
        CFI EndBlock cfiBlock5
//  585 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable33:
        DC32     Row_Base1

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable34:
        DC32     LCD_Buffer1
//  586 /*******************************************************************************
//  587  Draw_Mark :  
//  588 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function Draw_Mark
        THUMB
//  589 void Draw_Mark(u16 m, u16 n)						
//  590 { 
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
//  591   u16 i, j, Tmp;
//  592   
//  593   if(m < 4)  if(Title[m][POSI].Value > 200-3) return;
        CMP      R0,#+4
        BCS.N    ??Draw_Mark_0
        MOVS     R2,#+80
        LDR.N    R3,??Draw_Mark_1  ;; Title
        MLA      R2,R0,R2,R3
        LDRSH    R2,[R2, #+76]
        CMP      R2,#+198
        BGE.W    ??Draw_Mark_2
//  594   else       if(V_Trigg[n].Value > 200-3)     return;  
        LDR.N    R2,??Draw_Mark_1+0x4  ;; LCD_Buffer1
        ADD      R2,R2,R1, LSL #+2
        LDRSH    R2,[R2, #+992]
        CMP      R2,#+198
        BGE.W    ??Draw_Mark_2
//  595   
//  596   for(i = 0; i <= 10; ++i){
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
//  597     if(i < 7){
??Draw_Mark_3:
        UXTH     R0,R4
        CMP      R0,#+7
        BCS.N    ??Draw_Mark_4
//  598       if(m < 4){
        LDRH     R0,[SP, #+8]
        CMP      R0,#+4
        BCS.N    ??Draw_Mark_5
//  599         Tmp = Mark_TAB[m][i];
        LDR      R0,[SP, #+0]
        LDRB     R9,[R0, #+0]
//  600         __Point_SCR(i, Title[m][POSI].Value +(MIN_Y-4));
        LDRSH    R0,[R8, #+76]
        ADD      R1,R0,#+9
        B.N      ??Draw_Mark_6
//  601       } else {
//  602         Tmp = Mark_TAB[4][i];
??Draw_Mark_5:
        LDRB     R9,[R11, #+0]
//  603         __Point_SCR(i,     V_Trigg[n].Value +(MIN_Y-4));
        LDRSH    R0,[R7, #+992]
        ADD      R1,R0,#+9
??Draw_Mark_6:
        UXTH     R1,R1
        UXTH     R0,R4
        BL       __Point_SCR
//  604       }
//  605       for(j = 0; j < 8; ++j){
        MOV      R10,#+8
//  606         if(Tmp & 1) __LCD_SetPixl(Color[SCRN]);
??Draw_Mark_7:
        TST      R9,#0x1
        BEQ.N    ??Draw_Mark_8
        LDRH     R0,[R6, #+970]
        B.N      ??Draw_Mark_9
//  607         else        __LCD_SetPixl(Color[n]);
??Draw_Mark_8:
        ADD      R0,R6,#+960
        LDRH     R0,[R0, R5, LSL #+1]
??Draw_Mark_9:
        BL       __LCD_SetPixl
//  608         Tmp >>= 1;
        LSR      R9,R9,#+1
//  609       }
        SUBS     R10,R10,#+1
        BNE.N    ??Draw_Mark_7
//  610       __LCD_SetPixl(Color[n]);
        ADD      R0,R6,#+960
        LDRH     R0,[R0, R5, LSL #+1]
        BL       __LCD_SetPixl
        B.N      ??Draw_Mark_10
//  611     } else {
//  612       if(m < 4){
??Draw_Mark_4:
        LDRH     R0,[SP, #+8]
        CMP      R0,#+4
        BCS.N    ??Draw_Mark_11
//  613         __Point_SCR(i, Title[m][POSI].Value +(MIN_Y-10)+ i);
        LDRSH    R1,[R8, #+76]
        ADDS     R0,R1,R4
        ADDS     R1,R0,#+3
        UXTH     R1,R1
        UXTH     R0,R4
        BL       __Point_SCR
//  614         for(j=Title[m][POSI].Value+(MIN_Y-10)+i;j<(Title[m][POSI].Value+(MIN_Y+11)-i);++j) 
        LDRSH    R0,[R8, #+76]
        ADDS     R1,R0,R4
        ADD      R9,R1,#+3
        UXTH     R9,R9
        ADDS     R0,R0,#+24
        SUBS     R0,R0,R4
        CMP      R9,R0
        BGE.N    ??Draw_Mark_10
//  615           __LCD_SetPixl(Color[n]); 
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
//  616       } else { 
//  617         __Point_SCR(i,     V_Trigg[n].Value +(MIN_Y-10)+ i);   
??Draw_Mark_11:
        LDRSH    R1,[R7, #+992]
        ADDS     R0,R1,R4
        ADDS     R1,R0,#+3
        UXTH     R1,R1
        UXTH     R0,R4
        BL       __Point_SCR
//  618         for(j=V_Trigg[n].Value+(MIN_Y-10)+i;j<(V_Trigg[n].Value+(MIN_Y+11)-i);++j) 
        LDRSH    R0,[R7, #+992]
        ADDS     R1,R0,R4
        ADD      R9,R1,#+3
        UXTH     R9,R9
        ADDS     R0,R0,#+24
        SUBS     R0,R0,R4
        CMP      R9,R0
        BGE.N    ??Draw_Mark_10
//  619           __LCD_SetPixl(Color[n]); 
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
//  620       }
//  621     }
//  622   }
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
//  623 }
//  624 /*******************************************************************************
//  625  Update_Mark :  
//  626 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function Update_Mark
        THUMB
//  627 void Update_Mark(void)						
//  628 { 
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
//  629   s16 i, Tmp; 
//  630   u8  j;
//  631   
//  632   __Row_DMA_Ready();
        BL       __Row_DMA_Ready
//  633   for(i = 0; i <= 10; ++i){
        MOVS     R5,#+0
        LDR.N    R4,??Update_Mark_0  ;; LCD_Buffer1
//  634     __Point_SCR(i, MIN_Y-1);
??Update_Mark_1:
        MOVS     R1,#+12
        UXTH     R0,R5
        BL       __Point_SCR
//  635     for(j = MIN_Y-1; j < MAX_Y+2; ++j)  __LCD_SetPixl(Color[SCRN]);   // Clear row
        MOVS     R6,#+203
??Update_Mark_2:
        LDRH     R0,[R4, #+970]
        BL       __LCD_SetPixl
        SUBS     R6,R6,#+1
        BNE.N    ??Update_Mark_2
//  636   }
        ADDS     R5,R5,#+1
        CMP      R5,#+11
        BLT.N    ??Update_Mark_1
//  637   if(_1_source  != HIDE)    Draw_Mark(TRACK1, TRACK1); // Display Track1 mark
        LDR.N    R5,??Update_Mark_0+0x4  ;; Title
        LDRSH    R0,[R5, #+16]
        CBZ      R0,??Update_Mark_3
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       Draw_Mark
//  638   if(_2_source  != HIDE)    Draw_Mark(TRACK2, TRACK2); // Display Track1 mark
??Update_Mark_3:
        LDRSH    R0,[R5, #+96]
        CBZ      R0,??Update_Mark_4
        MOVS     R1,#+1
        MOVS     R0,#+1
        BL       Draw_Mark
//  639   if(_3_source  != HIDE)    Draw_Mark(TRACK3, TRACK3); // Display Track1 mark
??Update_Mark_4:
        LDRSH    R0,[R5, #+176]
        CBZ      R0,??Update_Mark_5
        MOVS     R1,#+2
        MOVS     R0,#+2
        BL       Draw_Mark
//  640   if(_4_source  != HIDE)    Draw_Mark(TRACK4, TRACK4); // Display Track1 mark
??Update_Mark_5:
        LDRSH    R0,[R5, #+256]
        CBZ      R0,??Update_Mark_6
        MOVS     R1,#+3
        MOVS     R0,#+3
        BL       Draw_Mark
//  641   if(_Tr_source == TRACK1)  Draw_Mark(TRIGG,  TRACK1); // Display Trigg1 mark
??Update_Mark_6:
        LDRSH    R0,[R5, #+576]
        CBNZ     R0,??Update_Mark_7
        MOVS     R1,#+0
        MOVS     R0,#+7
        BL       Draw_Mark
//  642   if(_Tr_source == TRACK2)  Draw_Mark(TRIGG,  TRACK2); // Display Trigg1 mark
??Update_Mark_7:
        LDRSH    R0,[R5, #+576]
        CMP      R0,#+1
        BNE.N    ??Update_Mark_8
        MOVS     R1,#+1
        MOVS     R0,#+7
        BL       Draw_Mark
//  643   if(_Tr_source == TRACK3)  Draw_Mark(TRIGG,  TRACK3); // Display Trigg1 mark
??Update_Mark_8:
        LDRSH    R0,[R5, #+576]
        CMP      R0,#+2
        BNE.N    ??Update_Mark_9
        MOVS     R1,#+2
        MOVS     R0,#+7
        BL       Draw_Mark
//  644   if(_Tr_source == TRACK4)  Draw_Mark(TRIGG,  TRACK4); // Display Trigg1 mark
??Update_Mark_9:
        LDRSH    R0,[R5, #+576]
        CMP      R0,#+3
        BNE.N    ??Update_Mark_10
        MOVS     R1,#+3
        MOVS     R0,#+7
        BL       Draw_Mark
//  645     
//  646   __Point_SCR(MAX_X+1, MIN_Y-1);
??Update_Mark_10:
        MOVS     R1,#+12
        MOV      R0,#+312
        BL       __Point_SCR
//  647   for(j = MIN_Y-1; j < MAX_Y+2; ++j) __LCD_SetPixl(Color[SCRN]); // Clear last row 
        MOVS     R6,#+203
??Update_Mark_11:
        LDRH     R0,[R4, #+970]
        BL       __LCD_SetPixl
        SUBS     R6,R6,#+1
        BNE.N    ??Update_Mark_11
//  648   for(i = MIN_X; i <= MAX_X+1; ++i)
        MOVS     R6,#+11
        MOVW     R7,#+313
//  649   {
//  650     __Point_SCR(i, MIN_Y-1);
??Update_Mark_12:
        MOVS     R1,#+12
        UXTH     R0,R6
        BL       __Point_SCR
//  651     __LCD_SetPixl(Color[SCRN]);                            // Clear first column
        LDRH     R0,[R4, #+970]
        BL       __LCD_SetPixl
//  652     __Point_SCR(i, MAX_Y+1);
        MOVS     R1,#+214
        UXTH     R0,R6
        BL       __Point_SCR
//  653     __LCD_SetPixl(Color[SCRN]);                            // Clear last column
        LDRH     R0,[R4, #+970]
        BL       __LCD_SetPixl
//  654   }
        ADDS     R6,R6,#+1
        CMP      R6,R7
        BLT.N    ??Update_Mark_12
//  655   __Point_SCR(MIN_X-1, Title[V_VERNIE][V1].Value +(MIN_Y - 2));
        LDRSH    R0,[R5, #+656]
        ADD      R1,R0,#+11
        UXTH     R1,R1
        MOVS     R0,#+10
        BL       __Point_SCR
//  656   for(i = 0; i < 5; ++i) __LCD_SetPixl(Color[VERNIE]);
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
//  657   __Point_SCR(MIN_X-1, Title[V_VERNIE][V2].Value +(MIN_Y - 2));
        LDRSH    R0,[R5, #+676]
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
//  659   __Point_SCR(MAX_X+1, Title[V_VERNIE][V1].Value +(MIN_Y - 2));
        LDRSH    R0,[R5, #+656]
        ADD      R1,R0,#+11
        UXTH     R1,R1
        MOV      R0,#+312
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
//  661   __Point_SCR(MAX_X+1, Title[V_VERNIE][V2].Value +(MIN_Y - 2));
        LDRSH    R0,[R5, #+676]
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
//  663   
//  664   Tmp =(MIN_X + 150)- _X_posi.Value;
        LDRH     R0,[R5, #+456]
        RSB      R0,R0,#+161
        SXTH     R0,R0
//  665   if(Tmp > MIN_X){
        CMP      R0,#+12
        BLT.N    ??Update_Mark_13
//  666     for(i = Tmp - 2; i <= Tmp + 2; ++i){
        SUBS     R6,R0,#+2
        SXTH     R6,R6
        ADDS     R7,R0,#+2
        CMP      R7,R6
        BLT.N    ??Update_Mark_13
//  667       __Point_SCR(i, MIN_Y-1);
??Update_Mark_14:
        MOVS     R1,#+12
        UXTH     R0,R6
        BL       __Point_SCR
//  668       __LCD_SetPixl(Color[X_POSI]);
        LDRH     R0,[R4, #+972]
        BL       __LCD_SetPixl
//  669       __Point_SCR(i, MAX_Y+1);
        MOVS     R1,#+214
        UXTH     R0,R6
        BL       __Point_SCR
//  670       __LCD_SetPixl(Color[X_POSI]);
        LDRH     R0,[R4, #+972]
        BL       __LCD_SetPixl
//  671     }
        ADDS     R6,R6,#+1
        SXTH     R6,R6
        CMP      R7,R6
        BGE.N    ??Update_Mark_14
//  672   }
//  673   Tmp = MIN_X + Title[T_VERNIE][T1].Value;
??Update_Mark_13:
        LDRH     R0,[R5, #+816]
        ADDS     R0,R0,#+11
        SXTH     R0,R0
//  674   for(i = Tmp - 2; i <= Tmp + 2; ++i){
        SUBS     R6,R0,#+2
        SXTH     R6,R6
        ADDS     R7,R0,#+2
        CMP      R7,R6
        BLT.N    ??Update_Mark_15
//  675     __Point_SCR(i, MIN_Y-1);
??Update_Mark_16:
        MOVS     R1,#+12
        UXTH     R0,R6
        BL       __Point_SCR
//  676     __LCD_SetPixl(Color[VERNIE]);
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
//  677     __Point_SCR(i, MAX_Y+1);
        MOVS     R1,#+214
        UXTH     R0,R6
        BL       __Point_SCR
//  678     __LCD_SetPixl(Color[VERNIE]);
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
//  679   }
        ADDS     R6,R6,#+1
        SXTH     R6,R6
        CMP      R7,R6
        BGE.N    ??Update_Mark_16
//  680   Tmp = MIN_X + Title[T_VERNIE][T2].Value;
??Update_Mark_15:
        LDRH     R0,[R5, #+836]
        ADDS     R0,R0,#+11
        SXTH     R0,R0
//  681   for(i = Tmp - 2; i <= Tmp + 2; ++i){
        SUBS     R5,R0,#+2
        SXTH     R5,R5
        ADDS     R6,R0,#+2
        CMP      R6,R5
        BLT.N    ??Update_Mark_17
//  682     __Point_SCR(i, MIN_Y-1);
??Update_Mark_18:
        MOVS     R1,#+12
        UXTH     R0,R5
        BL       __Point_SCR
//  683     __LCD_SetPixl(Color[VERNIE]);
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
//  684     __Point_SCR(i, MAX_Y+1);
        MOVS     R1,#+214
        UXTH     R0,R5
        BL       __Point_SCR
//  685     __LCD_SetPixl(Color[VERNIE]);
        LDRH     R0,[R4, #+968]
        BL       __LCD_SetPixl
//  686   }
        ADDS     R5,R5,#+1
        SXTH     R5,R5
        CMP      R6,R5
        BGE.N    ??Update_Mark_18
//  687 }
??Update_Mark_17:
        ADD      SP,SP,#+4
        CFI CFA R13+20
        POP      {R4-R7,PC}       ;; return
        DATA
??Update_Mark_0:
        DC32     LCD_Buffer1
        DC32     Title
        CFI EndBlock cfiBlock7
//  688 /*******************************************************************************
//  689  Update_View_Area: 刷新显示窗口位置指示 
//  690 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function Update_View_Area
        THUMB
//  691 void Update_View_Area(void)
//  692 {  
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
//  693   s16 i, j, k;
//  694   {
//  695     __Point_SCR(89,  0);
        MOVS     R1,#+0
        MOVS     R0,#+89
        BL       __Point_SCR
//  696     for(j=0; j<12; ++j) __LCD_SetPixl(ORANGE); 
        MOVS     R5,#+12
        MOVW     R4,#+1311
??Update_View_Area_0:
        MOVS     R0,R4
        BL       __LCD_SetPixl
        SUBS     R5,R5,#+1
        BNE.N    ??Update_View_Area_0
//  697     __Point_SCR(90,  0);
        MOVS     R1,#+0
        MOVS     R0,#+90
        BL       __Point_SCR
//  698     for(j=0; j<12; ++j) __LCD_SetPixl(ORANGE); 
        MOVS     R5,#+12
??Update_View_Area_1:
        MOVS     R0,R4
        BL       __LCD_SetPixl
        SUBS     R5,R5,#+1
        BNE.N    ??Update_View_Area_1
//  699     __Point_SCR(308, 0);
        MOVS     R1,#+0
        MOV      R0,#+308
        BL       __Point_SCR
//  700     for(j=0; j<12; ++j) __LCD_SetPixl(ORANGE); 
        MOVS     R5,#+12
??Update_View_Area_2:
        MOVS     R0,R4
        BL       __LCD_SetPixl
        SUBS     R5,R5,#+1
        BNE.N    ??Update_View_Area_2
//  701     __Point_SCR(309, 0);
        MOVS     R1,#+0
        MOVW     R0,#+309
        BL       __Point_SCR
//  702     for(j=0; j<12; ++j) __LCD_SetPixl(ORANGE); 
        MOVS     R5,#+12
??Update_View_Area_3:
        MOVS     R0,R4
        BL       __LCD_SetPixl
        SUBS     R5,R5,#+1
        BNE.N    ??Update_View_Area_3
//  703 
//  704     for(i=91; i<307; i+=8){
        MOVS     R5,#+91
        MOVW     R11,#+307
        LDR.N    R6,??Update_View_Area_4  ;; RULE_BASE
//  705       for(j=0; j<8; ++j){
??Update_View_Area_5:
        MOVS     R7,R5
        MOV      R8,R6
        MOV      R9,#+8
//  706         __Point_SCR(i+j, 0);
??Update_View_Area_6:
        MOVS     R1,#+0
        UXTH     R0,R7
        BL       __Point_SCR
//  707         for(k=0; k<12; ++k){
        MOV      R10,#+0
//  708           if((0x01 << k)& RULE_BASE[j]) __LCD_SetPixl(ORANGE);
??Update_View_Area_7:
        MOVS     R0,#+1
        LSL      R0,R0,R10
        LDRH     R1,[R8, #+0]
        TST      R0,R1
        BEQ.N    ??Update_View_Area_8
        MOVS     R0,R4
        B.N      ??Update_View_Area_9
//  709           else                          __LCD_SetPixl(BLACK);
??Update_View_Area_8:
        MOVS     R0,#+0
??Update_View_Area_9:
        BL       __LCD_SetPixl
//  710         }
        ADD      R10,R10,#+1
        CMP      R10,#+12
        BLT.N    ??Update_View_Area_7
//  711       }
        ADD      R8,R8,#+2
        ADDS     R7,R7,#+1
        SUBS     R9,R9,#+1
        BNE.N    ??Update_View_Area_6
//  712     }
        ADDS     R5,R5,#+8
        CMP      R5,R11
        BLT.N    ??Update_View_Area_5
//  713     __Point_SCR(0  + 91 + (_X_posi.Value * 200)/3796, 0); 
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
//  714     for(j=0;j<9;++j) __LCD_SetPixl(WHT);
        MOV      R8,#+9
        MOVW     R7,#+65535
??Update_View_Area_10:
        MOVS     R0,R7
        BL       __LCD_SetPixl
        SUBS     R8,R8,#+1
        BNE.N    ??Update_View_Area_10
//  715     __Point_SCR(15 + 91 + (_X_posi.Value * 200)/3796, 0);
        MOVS     R1,#+0
        LDRSH    R0,[R6, #+456]
        MULS     R0,R0,R5
        SDIV     R0,R0,R4
        ADDS     R0,R0,#+106
        UXTH     R0,R0
        BL       __Point_SCR
//  716     for(j=0;j<9;++j) __LCD_SetPixl(WHT);
        MOV      R8,#+9
??Update_View_Area_11:
        MOVS     R0,R7
        BL       __LCD_SetPixl
        SUBS     R8,R8,#+1
        BNE.N    ??Update_View_Area_11
//  717     for(i=0;i<16;++i){
        MOV      R8,#+0
//  718       __Point_SCR(i + 91 +(_X_posi.Value * 200)/3796, 0);
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
//  719       __LCD_SetPixl(WHT);
        MOVS     R0,R7
        BL       __LCD_SetPixl
//  720       __Point_SCR(i + 91 +(_X_posi.Value * 200)/3796, 9);
        MOVS     R1,#+9
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
//  722     }
        ADD      R8,R8,#+1
        CMP      R8,#+16
        BLT.N    ??Update_View_Area_12
//  723     _X_View.Flag &= !UPDAT;
        ADD      R0,R6,#+478
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  724   }
//  725 }
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
//  726 /******************************** END OF FILE *********************************/
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
