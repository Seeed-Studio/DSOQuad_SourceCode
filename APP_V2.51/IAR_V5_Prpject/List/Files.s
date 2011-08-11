///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  11:07:58 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\APP_V2.51\source\Files.c               /
//    Command line =  E:\Mini-DS\DS203\APP_V2.51\source\Files.c -lA           /
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
//    List file    =  E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\List\Files.s  /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Files

        EXTERN Current
        EXTERN DataBuf
        EXTERN Detail
        EXTERN Ka1
        EXTERN Ka2
        EXTERN Ka3
        EXTERN Kb1
        EXTERN Kb2
        EXTERN Kb3
        EXTERN Meter
        EXTERN Print_Clk
        EXTERN Title
        EXTERN TrackBuff
        EXTERN V_Trigg
        EXTERN Vertical
        EXTERN Word2Hex
        EXTERN __CloseFile
        EXTERN __GetDev_SN
        EXTERN __LCD_GetPixl
        EXTERN __OpenFileRd
        EXTERN __OpenFileWr
        EXTERN __Point_SCR
        EXTERN __ProgFileSec
        EXTERN __ReadFileSec
        EXTERN __aeabi_memclr
        EXTERN __aeabi_memclr4
        EXTERN __aeabi_memcpy
        EXTERN __aeabi_memcpy4
        EXTERN u8ToDec3

        PUBLIC BMP_Color
        PUBLIC BmpHead
        PUBLIC Color_Num
        PUBLIC FileBuff
        PUBLIC Load_Buf
        PUBLIC Load_Dat
        PUBLIC Load_Param
        PUBLIC Make_Filename
        PUBLIC Save_Bmp
        PUBLIC Save_Buf
        PUBLIC Save_Csv
        PUBLIC Save_Dat
        PUBLIC Save_Param
        PUBLIC SecBuff
        PUBLIC TempPar
        PUBLIC make_Vertical
        PUBLIC reset_parameter
        
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
        
// E:\Mini-DS\DS203\APP_V2.51\source\Files.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : File.c  
//    3  Version   : DS203_APP Ver 2.5x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include <string.h>
//    6 #include "Function.h"
//    7 #include "Process.h"
//    8 #include "BIOS.h"
//    9 #include "File.h"
//   10 #include "Menu.h"
//   11 
//   12 

        SECTION `.data`:DATA:NOROOT(2)
//   13 u8  SecBuff[512];
SecBuff:
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
//   14 u8  FileBuff[1200];
//   15 u16 TempPar[66];
TempPar:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
//   16 u16 BMP_Color[16] = { WHT,  CYAN, CYAN_,  YEL,  YEL_, PURPL, PURPL_, GRN,   
BMP_Color:
        DC16 65535, 65504, 48608, 2047, 1527, 63519, 47127, 2016, 1504, 31727
        DC16 1311, 63488, 31, 0, 0, 0
FileBuff:
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
//   17                       GRN_, GRAY, ORANGE, BLUE, RED,  BLACK, BLACK,  BLACK};    
//   18 u8  BmpHead[54]   = { 0X42, 0X4D, 0XF8, 0XB, 0X00, 0X00, 0X00, 0X00, 
BmpHead:
        DC8 66, 77, 248, 11, 0, 0, 0, 0, 0, 0, 118, 0, 0, 0, 40, 0, 0, 0, 144
        DC8 1, 0, 0, 240, 0, 0, 0, 1, 0, 4, 0, 0, 0, 0, 0, 130, 11, 0, 0, 18
        DC8 11, 0, 0, 18, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
//   19                       0X00, 0X00, 0X76, 0X0, 0X00, 0X00, 0X28, 0X00,
//   20                       0X00, 0X00, 0X90, 0X1, 0X00, 0X00, 0XF0, 0X00,
//   21                       0X00, 0X00, 0X01, 0X0, 0X04, 0X00, 0X00, 0X00,
//   22                       0X00, 0X00, 0X82, 0XB, 0X00, 0X00, 0X12, 0X0B,
//   23                       0X00, 0X00, 0X12, 0XB, 0X00, 0X00, 0X00, 0X00,
//   24                       0X00, 0X00, 0X00, 0X0, 0X00, 0X00};
//   25 
//   26 /*******************************************************************************
//   27  打开指定扩展名的文件            输入：文件扩展名             返回值：0x00=成功 
//   28 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Make_Filename
        THUMB
//   29 u8 Make_Filename(u8 FileNum, u8* FileName)
//   30 {
Make_Filename:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        SUB      SP,SP,#+8
        CFI CFA R13+16
        MOVS     R4,R1
//   31   u8 Num[4];
//   32   
//   33   u8ToDec3(Num, FileNum);
        MOVS     R1,R0
        ADD      R0,SP,#+0
        BL       u8ToDec3
//   34   FileName[4]  = Num[0];
        LDRB     R0,[SP, #+0]
        STRB     R0,[R4, #+4]
//   35   FileName[5]  = Num[1];
        LDRB     R0,[SP, #+1]
        STRB     R0,[R4, #+5]
//   36   FileName[6]  = Num[2];
        LDRB     R0,[SP, #+2]
        STRB     R0,[R4, #+6]
//   37 //  FileName[12] = 0;
//   38   return 0;
        MOVS     R0,#+0
        ADD      SP,SP,#+8
        CFI CFA R13+8
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock0
//   39 } 
//   40 /*******************************************************************************
//   41  求出当前颜色的对应调色板编号
//   42 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function Color_Num
        THUMB
//   43 u8 Color_Num(u16 Color)
//   44 {
//   45   if(Color == WHT)                   return 0;
Color_Num:
        MOVW     R1,#+65535
        CMP      R0,R1
        BNE.N    ??Color_Num_0
        MOVS     R0,#+0
        BX       LR
//   46   else if((Color & CYAN  )== CYAN  ) return 1;
??Color_Num_0:
        MOVW     R1,#+65504
        AND      R2,R1,R0
        CMP      R2,R1
        BNE.N    ??Color_Num_1
        MOVS     R0,#+1
        BX       LR
//   47   else if((Color & YEL   )== YEL   ) return 3;
??Color_Num_1:
        LSLS     R1,R0,#+21
        LSRS     R1,R1,#+21
        MOVW     R2,#+2047
        CMP      R1,R2
        BNE.N    ??Color_Num_2
        MOVS     R0,#+3
        BX       LR
//   48   else if((Color & PURPL )== PURPL ) return 5;
??Color_Num_2:
        MOVW     R1,#+63519
        AND      R2,R1,R0
        CMP      R2,R1
        BNE.N    ??Color_Num_3
        MOVS     R0,#+5
        BX       LR
//   49   else if((Color & GRN   )== GRN   ) return 7;
??Color_Num_3:
        AND      R1,R0,#0x7E0
        CMP      R1,#+2016
        BNE.N    ??Color_Num_4
        MOVS     R0,#+7
        BX       LR
//   50   else if((Color & CYAN_ )== CYAN_ ) return 2;
??Color_Num_4:
        MOVW     R1,#+48608
        AND      R2,R1,R0
        CMP      R2,R1
        BNE.N    ??Color_Num_5
        MOVS     R0,#+2
        BX       LR
//   51   else if((Color & YEL_  )== YEL_  ) return 4;
??Color_Num_5:
        MOVW     R1,#+1527
        ANDS     R1,R1,R0
        MOVW     R2,#+1527
        CMP      R1,R2
        BNE.N    ??Color_Num_6
        MOVS     R0,#+4
        BX       LR
//   52   else if((Color & PURPL_)== PURPL_) return 6;
??Color_Num_6:
        MOVW     R1,#+47127
        AND      R2,R1,R0
        CMP      R2,R1
        BNE.N    ??Color_Num_7
        MOVS     R0,#+6
        BX       LR
//   53   else if((Color & GRN_  )== GRN_  ) return 8;
??Color_Num_7:
        AND      R1,R0,#0x5E0
        CMP      R1,#+1504
        BNE.N    ??Color_Num_8
        MOVS     R0,#+8
        BX       LR
//   54   else if((Color & GRAY  )== GRAY  ) return 9;
??Color_Num_8:
        MOVW     R1,#+31727
        AND      R2,R1,R0
        CMP      R2,R1
        BNE.N    ??Color_Num_9
        MOVS     R0,#+9
        BX       LR
//   55   else if((Color & ORANGE)== ORANGE) return 10;
??Color_Num_9:
        MOVW     R1,#+1311
        ANDS     R1,R1,R0
        MOVW     R2,#+1311
        CMP      R1,R2
        BNE.N    ??Color_Num_10
        MOVS     R0,#+10
        BX       LR
//   56   else if((Color & BLUE  )== BLUE  ) return 11;
??Color_Num_10:
        AND      R1,R0,#0xF800
        CMP      R1,#+63488
        BNE.N    ??Color_Num_11
        MOVS     R0,#+11
        BX       LR
//   57   else if((Color & RED   )== RED   ) return 12;
??Color_Num_11:
        AND      R0,R0,#0x1F
        CMP      R0,#+31
        BNE.N    ??Color_Num_12
        MOVS     R0,#+12
        BX       LR
//   58   else                               return 13;
??Color_Num_12:
        MOVS     R0,#+13
??Color_Num_13:
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//   59 }
//   60 /*******************************************************************************
//   61 Load_Dat: 加载保存过的屏幕图像原始数据    输入：文件编号     返回值：0x00=成功 
//   62 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Load_Dat
        THUMB
//   63 u8 Load_Dat(u8 FileNum)
//   64 {
Load_Dat:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        SUB      SP,SP,#+32
        CFI CFA R13+48
        MOVS     R4,R0
//   65   u8  Filename[12] = "FILE    DAT"; 
        ADD      R0,SP,#+8
        LDR.N    R1,??Load_Dat_0  ;; `?<Constant "FILE    DAT">`
        MOVS     R2,#+12
        BL       __aeabi_memcpy
//   66   u16 i;
//   67   
//   68   u16 pCluster[3];
//   69   u32 pDirAddr[1]; 
//   70   
//   71   Make_Filename(FileNum, Filename);
        MOVS     R1,R4
        ADD      R0,SP,#+0
        BL       u8ToDec3
        LDRB     R0,[SP, #+0]
        STRB     R0,[SP, #+12]
        LDRB     R0,[SP, #+1]
        STRB     R0,[SP, #+13]
        LDRB     R0,[SP, #+2]
        STRB     R0,[SP, #+14]
//   72   i = __OpenFileRd(SecBuff, Filename, pCluster, pDirAddr);
        LDR.W    R4,??DataTable25  ;; SecBuff
        ADD      R3,SP,#+4
        ADD      R2,SP,#+20
        ADD      R1,SP,#+8
        MOVS     R0,R4
        BL       __OpenFileRd
        MOVS     R5,R0
//   73   if(i != OK) return i;
        BNE.N    ??Load_Dat_1
//   74   for(i=0; i<4; i++){
        MOVS     R5,#+0
        ADD      R6,R4,#+676
//   75     if(__ReadFileSec(SecBuff, pCluster)!= OK) return RD_ERR;
??Load_Dat_2:
        ADD      R1,SP,#+20
        MOVS     R0,R4
        BL       __ReadFileSec
        CBZ      R0,??Load_Dat_3
        MOVS     R0,#+8
        B.N      ??Load_Dat_1
//   76     memcpy(&FileBuff[i*300], SecBuff,300);
??Load_Dat_3:
        MOV      R2,#+300
        MOVS     R1,R4
        MOVS     R0,R6
        BL       __aeabi_memcpy
//   77   }
        ADDS     R5,R5,#+1
        ADD      R6,R6,#+300
        UXTH     R0,R5
        CMP      R0,#+4
        BCC.N    ??Load_Dat_2
//   78   return 0;
        MOVS     R0,#+0
??Load_Dat_1:
        ADD      SP,SP,#+32
        CFI CFA R13+16
        POP      {R4-R6,PC}       ;; return
        Nop      
        DATA
??Load_Dat_0:
        DC32     `?<Constant "FILE    DAT">`
        CFI EndBlock cfiBlock2
//   79 }
//   80 /*******************************************************************************
//   81 Save_Dat: 保存当前屏幕显示图像原始数据    输入：文件编号     返回值：0x00=成功 
//   82 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Save_Dat
        THUMB
//   83 u8 Save_Dat(u8 FileNum)
//   84 {
Save_Dat:
        PUSH     {R4-R8,LR}
        CFI R14 Frame(CFA, -4)
        CFI R8 Frame(CFA, -8)
        CFI R7 Frame(CFA, -12)
        CFI R6 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
        SUB      SP,SP,#+32
        CFI CFA R13+56
        MOVS     R4,R0
//   85   u8  Filename[13] = "FILE    DAT"; 
        ADD      R0,SP,#+16
        LDR.N    R1,??Save_Dat_0  ;; `?<Constant "FILE    DAT">_1`
        MOVS     R2,#+13
        BL       __aeabi_memcpy
//   86   u16 i, j;
//   87   u16 pCluster[3];
//   88   u32 pDirAddr[1]; 
//   89   
//   90   Make_Filename(FileNum, Filename);
        MOVS     R1,R4
        ADD      R0,SP,#+0
        BL       u8ToDec3
        LDRB     R0,[SP, #+0]
        STRB     R0,[SP, #+20]
        LDRB     R0,[SP, #+1]
        STRB     R0,[SP, #+21]
        LDRB     R0,[SP, #+2]
        STRB     R0,[SP, #+22]
//   91   if(__OpenFileWr(SecBuff, Filename, pCluster, pDirAddr)!=OK) return DISK_ERR;
        LDR.W    R4,??DataTable25  ;; SecBuff
        ADD      R3,SP,#+4
        ADD      R2,SP,#+8
        ADD      R1,SP,#+16
        MOVS     R0,R4
        BL       __OpenFileWr
        CBZ      R0,??Save_Dat_1
        MOVS     R0,#+10
        B.N      ??Save_Dat_2
//   92   memset(SecBuff, 0, 512);
??Save_Dat_1:
        MOV      R1,#+512
        MOVS     R0,R4
        BL       __aeabi_memclr4
//   93   for(j=0; j<4; j++){
        MOVS     R5,#+0
        LDR.N    R6,??Save_Dat_0+0x4  ;; TrackBuff
        LDR.N    R7,??Save_Dat_0+0x8  ;; Title + 76
        MOVW     R8,#+1290
//   94     for(i=0; i<299; i++)  SecBuff[i] = TrackBuff[i*4 + j];
??Save_Dat_3:
        LDRB     R0,[R6, #+0]
        STRB     R0,[R4, #+0]
        ADDS     R0,R4,#+1
        ADDS     R1,R6,#+4
        MOVS     R2,#+149
??Save_Dat_4:
        LDRB     R3,[R1], #+4
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+4
        STRB     R3,[R0], #+1
        SUBS     R2,R2,#+1
        BNE.N    ??Save_Dat_4
//   95     SecBuff[299] = Title[j][POSI].Value;
        LDRH     R0,[R7], #+80
        STRB     R0,[R4, #+299]
//   96     if(__ProgFileSec(SecBuff, pCluster)!= OK) return WR_ERR; // 写入数据
        ADD      R1,SP,#+8
        MOVS     R0,R4
        BL       __ProgFileSec
        CBNZ     R0,??Save_Dat_5
//   97     Print_Clk(254, 0, (SCRN<<8)+ TEXT1, j & 3);              // 进度指示
??Save_Dat_6:
        AND      R3,R5,#0x3
        MOV      R2,R8
        MOVS     R1,#+0
        MOVS     R0,#+254
        BL       Print_Clk
//   98   }
        ADDS     R5,R5,#+1
        ADDS     R6,R6,#+1
        UXTH     R0,R5
        CMP      R0,#+4
        BCC.N    ??Save_Dat_3
//   99   if(__CloseFile(SecBuff, 0x0800, pCluster, pDirAddr)!= OK) return WR_ERR;
        ADD      R3,SP,#+4
        ADD      R2,SP,#+8
        MOV      R1,#+2048
        MOVS     R0,R4
        BL       __CloseFile
        CBZ      R0,??Save_Dat_2
??Save_Dat_5:
        MOVS     R0,#+9
//  100   return OK;
??Save_Dat_2:
        ADD      SP,SP,#+32
        CFI CFA R13+24
        POP      {R4-R8,PC}       ;; return
        DATA
??Save_Dat_0:
        DC32     `?<Constant "FILE    DAT">_1`
        DC32     TrackBuff
        DC32     Title + 76
        CFI EndBlock cfiBlock3
//  101 }
//  102 /*******************************************************************************
//  103 Save_Bmp: 保存当前屏幕显示图像为BMP格式    输入：文件编号     返回值：0x00=成功 
//  104 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Save_Bmp
        THUMB
//  105 u8 Save_Bmp(u8 FileNum)
//  106 {
Save_Bmp:
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
        SUB      SP,SP,#+28
        CFI CFA R13+64
        MOVS     R4,R0
//  107   u8  Filename[12] = "IMAG    BMP"; 
        ADD      R0,SP,#+16
        LDR.N    R1,??Save_Bmp_0  ;; `?<Constant "IMAG    BMP">`
        MOVS     R2,#+12
        BL       __aeabi_memcpy
//  108   u16 k, i, j, x=0, y=0, ColorH, ColorL;
//  109 
//  110   u16 pCluster[3];
//  111   u32 pDirAddr[1]; 
//  112 
//  113 //   u8 Num[10];  
//  114 /* 
//  115   Make_Filename(FileNum, Filename);
//  116   if(__OpenFileWr(SecBuff, Filename, pCluster, pDirAddr)!=OK) return DISK_ERR;
//  117 //  
//  118   Shor2Hex(Num, *pCluster); /////////////////////////////// 
//  119   __Display_Str( 0*8, 220, WHT, PRN, Num);/////////////////
//  120   Shor2Hex(Num, *(pCluster+1)); /////////////////////////// 
//  121   __Display_Str( 5*8, 220, GRN, PRN, Num);////////////////
//  122 //  
//  123   memcpy(SecBuff, BmpHead, 54);
//  124   i = 0x0036; // 调色板存放开始地址
//  125   for(j=0; j<16; ++j){
//  126     SecBuff[j*4 +i+0]=(BMP_Color[j]& 0xF800)>>8; // Bule
//  127     SecBuff[j*4 +i+1]=(BMP_Color[j]& 0x07E0)>>3; // Green
//  128     SecBuff[j*4 +i+2]=(BMP_Color[j]& 0x001F)<<3; // Red
//  129     SecBuff[j*4 +i+3]= 0;                        // Alpha
//  130   }
//  131   i = 0x0076; // 图像数据开始存放地址
//  132   k = 0;
//  133   for(y=0; y<240; y++){
//  134     for(x=0; x<400 ; x+=2){
//  135       __Point_SCR(x, y);
//  136       ColorH =__LCD_GetPixl();
//  137       __Point_SCR(x+1, y);
//  138       ColorL =__LCD_GetPixl();
//  139       SecBuff[i] =(Color_Num(ColorH)<<4)+ Color_Num(ColorL);
//  140       i++;
//  141       if(i>=512){
//  142         if(__ProgFileSec(SecBuff, pCluster)!= OK) return WR_ERR; // 写入数据
//  143         Print_Clk(254, 0, (SCRN<<8)+ TEXT1, (k++ >>1)& 3);    // 进度指示
//  144         i=0; 
//  145 //   
//  146 //  Filename[11] = 0;  
//  147 //  __Display_Str(10*8, 220, WHT, PRN, Filename);
//  148   Char2Hex(Num, *pCluster);  
//  149   __Display_Str(k*4*8, 220, WHT, PRN, Num);
//  150 //  Char2Hex(Num, *(pCluster+1));  
//  151 //  __Display_Str(28*8, 220, WHT, PRN, Num);
//  152   while(1);
//  153   Char2Hex(Num, k);////////////////////////////////  
//  154   __Display_Str(20*8, 215, YEL, PRN, Num);/////////
//  155   Shor2Hex(Num, *pCluster); /////////////////////// 
//  156   __Display_Str(25*8, 215, WHT, PRN, Num);/////////
//  157   Shor2Hex(Num, *(pCluster+1));///////////////////  
//  158   __Display_Str(30*8, 215, GRN, PRN, Num);////////
//  159   Key_Buffer = 0;/////////////////////////////////
//  160   while(!Key_Buffer);/////////////////////////////
//  161 //
//  162       }
//  163     }
//  164   }
//  165   if(i!=0) if(__ProgFileSec(SecBuff, pCluster)!= OK) return WR_ERR; // 写入数据
//  166 //  while(1);
//  167   if(__CloseFile(SecBuff, 0xBC00, pCluster, pDirAddr)!= OK) return WR_ERR;
//  168   return 0; 
//  169   k=0;
//  170  Char2Hex(Num, *(pCluster+1)); __Display_Str((k%24)*16, (k/24)*15, WHT, PRN, Num); k++;
//  171  Char2Hex(Num, *pCluster    ); __Display_Str((k%24)*16, (k/24)*15, GRN, PRN, Num); k++;
//  172  if(*pCluster > 0x154){Key_Buffer = 0; while(Key_Buffer == 0) {} }
//  173 // if(k >= 16*24){__Clear_Screen(BLACK); k = 0;}
//  174 */ 
//  175   
//  176   Make_Filename(FileNum, Filename);
        MOVS     R1,R4
        ADD      R0,SP,#+0
        BL       u8ToDec3
        LDRB     R0,[SP, #+0]
        STRB     R0,[SP, #+20]
        ADD      R0,SP,#+0
        LDRB     R1,[R0, #+1]
        STRB     R1,[SP, #+21]
        LDRB     R0,[R0, #+2]
        STRB     R0,[SP, #+22]
//  177   if(__OpenFileWr(SecBuff, Filename, pCluster, pDirAddr)!=OK) return DISK_ERR;
        LDR.W    R4,??DataTable25  ;; SecBuff
        ADD      R3,SP,#+4
        ADD      R2,SP,#+8
        ADD      R1,SP,#+16
        MOVS     R0,R4
        BL       __OpenFileWr
        CBZ      R0,??Save_Bmp_1
        MOVS     R0,#+10
        B.N      ??Save_Bmp_2
//  178   memcpy(SecBuff, BmpHead, 54);
??Save_Bmp_1:
        MOVS     R2,#+54
        ADDW     R1,R4,#+1876
        MOVS     R0,R4
        BL       __aeabi_memcpy4
//  179   i = 0x0036; // 调色板存放开始地址
//  180   for(j=0; j<16; ++j){
        ADD      R0,R4,#+644
        ADD      R1,R4,#+54
        MOVS     R2,#+8
//  181     SecBuff[j*4 +i+0]=(BMP_Color[j]& 0xF800)>>8; // Bule
??Save_Bmp_3:
        LDRH     R3,[R0, #+0]
        AND      R3,R3,#0xF800
        LSRS     R3,R3,#+8
        STRB     R3,[R1], #+1
//  182     SecBuff[j*4 +i+1]=(BMP_Color[j]& 0x07E0)>>3; // Green
        LDRH     R3,[R0, #+0]
        AND      R3,R3,#0x7E0
        LSRS     R3,R3,#+3
        STRB     R3,[R1], #+1
//  183     SecBuff[j*4 +i+2]=(BMP_Color[j]& 0x001F)<<3; // Red
        LDRH     R3,[R0], #+2
        LSLS     R3,R3,#+24
        LSRS     R3,R3,#+21
        STRB     R3,[R1], #+1
//  184     SecBuff[j*4 +i+3]= 0;                        // Alpha
        MOVS     R3,#+0
        STRB     R3,[R1], #+1
        LDRH     R3,[R0, #+0]
        AND      R3,R3,#0xF800
        LSRS     R3,R3,#+8
        STRB     R3,[R1], #+1
        LDRH     R3,[R0, #+0]
        AND      R3,R3,#0x7E0
        LSRS     R3,R3,#+3
        STRB     R3,[R1], #+1
        LDRH     R3,[R0], #+2
        LSLS     R3,R3,#+24
        LSRS     R3,R3,#+21
        STRB     R3,[R1], #+1
        MOVS     R3,#+0
        STRB     R3,[R1], #+1
//  185   }
        SUBS     R2,R2,#+1
        BNE.N    ??Save_Bmp_3
//  186   i = 0x0076; // 图像数据开始存放地址
        MOV      R8,#+118
//  187   k = 0;
        MOVS     R5,#+0
//  188   for(y=0; y<240; y++){
        MOV      R6,R3
        MOVW     R11,#+1290
//  189     for(x=0; x<400 ; x+=2){
??Save_Bmp_4:
        MOVS     R7,#+0
//  190       __Point_SCR(x, y);
??Save_Bmp_5:
        UXTH     R1,R6
        MOVS     R0,R7
        BL       __Point_SCR
//  191       ColorH =__LCD_GetPixl();
        BL       __LCD_GetPixl
        MOV      R9,R0
//  192       __Point_SCR(x+1, y);
        UXTH     R1,R6
        ADDS     R0,R7,#+1
        UXTH     R0,R0
        BL       __Point_SCR
//  193       ColorL =__LCD_GetPixl();
        BL       __LCD_GetPixl
        MOV      R10,R0
//  194       SecBuff[i] =(Color_Num(ColorH)<<4)+ Color_Num(ColorL);
        MOV      R0,R9
        BL       Color_Num
        MOV      R9,R0
        MOV      R0,R10
        BL       Color_Num
        ADD      R0,R0,R9, LSL #+4
        MOV      R1,R8
        STRB     R0,[R1, R4]
//  195       i++;
        ADD      R8,R8,#+1
        UXTH     R8,R8
//  196       if(i>=512){
        MOV      R1,#+512
        CMP      R8,R1
        BCC.N    ??Save_Bmp_6
//  197         if(__ProgFileSec(SecBuff, pCluster)!= OK) return WR_ERR; // 写入数据
        ADD      R1,SP,#+8
        MOVS     R0,R4
        BL       __ProgFileSec
        CBNZ     R0,??Save_Bmp_7
//  198 // Char2Hex(Num, *(pCluster+1)); __Display_Str((k%24)*16, (k/24)*15, WHT, PRN, Num); k++;
//  199 // Char2Hex(Num, *pCluster    ); __Display_Str((k%24)*16, (k/24)*15, GRN, PRN, Num); k++;
//  200 // if(*pCluster > 0){Key_Buffer = 0; while(Key_Buffer == 0) {} }
//  201 // if(k >= 16*24){__Clear_Screen(BLACK); k = 0;}
//  202         Print_Clk(254, 0, (SCRN<<8)+ TEXT1, (k++ >>1)& 3);    // 进度指示
??Save_Bmp_8:
        ASRS     R0,R5,#+1
        AND      R3,R0,#0x3
        MOV      R2,R11
        MOVS     R1,#+0
        MOVS     R0,#+254
        BL       Print_Clk
        ADDS     R5,R5,#+1
        UXTH     R5,R5
//  203         i=0; 
        MOV      R8,#+0
//  204       }
//  205     }
??Save_Bmp_6:
        ADDS     R7,R7,#+2
        UXTH     R7,R7
        MOV      R1,#+400
        CMP      R7,R1
        BCC.N    ??Save_Bmp_5
//  206   }
        ADDS     R6,R6,#+1
        UXTH     R0,R6
        CMP      R0,#+240
        BCC.N    ??Save_Bmp_4
//  207   if(i!=0) if(__ProgFileSec(SecBuff, pCluster)!= OK) return WR_ERR; // 写入数据
        CMP      R8,#+0
        BEQ.N    ??Save_Bmp_9
        ADD      R1,SP,#+8
        MOVS     R0,R4
        BL       __ProgFileSec
        CBNZ     R0,??Save_Bmp_7
//  208   if(__CloseFile(SecBuff, 0xBC00, pCluster, pDirAddr)!= OK) return WR_ERR;
??Save_Bmp_9:
        ADD      R3,SP,#+4
        ADD      R2,SP,#+8
        MOV      R1,#+48128
        MOVS     R0,R4
        BL       __CloseFile
        CBZ      R0,??Save_Bmp_2
??Save_Bmp_7:
        MOVS     R0,#+9
//  209   return 0; 
??Save_Bmp_2:
        ADD      SP,SP,#+28
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        DATA
??Save_Bmp_0:
        DC32     `?<Constant "IMAG    BMP">`
        CFI EndBlock cfiBlock4
//  210 }
//  211 /*******************************************************************************
//  212 Save_Buf: 保存采集数据缓存区为BUF格式    输入：文件编号     返回值：0x00=成功      
//  213 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function Save_Buf
        THUMB
//  214 u8 Save_Buf(u8 FileNum)
//  215 {
Save_Buf:
        PUSH     {R4-R8,LR}
        CFI R14 Frame(CFA, -4)
        CFI R8 Frame(CFA, -8)
        CFI R7 Frame(CFA, -12)
        CFI R6 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
        SUB      SP,SP,#+32
        CFI CFA R13+56
        MOVS     R4,R0
//  216   u8   i, Filename[12] = "DATA    BUF"; 
        ADD      R0,SP,#+16
        LDR.N    R1,??Save_Buf_0  ;; `?<Constant "DATA    BUF">`
        MOVS     R2,#+12
        BL       __aeabi_memcpy
//  217   u16* p ;
//  218   
//  219   u16 pCluster[3];
//  220   u32 pDirAddr[1]; 
//  221   
//  222   Make_Filename(FileNum, Filename);
        MOVS     R1,R4
        ADD      R0,SP,#+0
        BL       u8ToDec3
        LDRB     R0,[SP, #+0]
        STRB     R0,[SP, #+20]
        ADD      R0,SP,#+0
        LDRB     R1,[R0, #+1]
        STRB     R1,[SP, #+21]
        LDRB     R0,[R0, #+2]
        STRB     R0,[SP, #+22]
//  223   if(__OpenFileWr(SecBuff, Filename, pCluster, pDirAddr)!=OK) return DISK_ERR;
        LDR.W    R4,??DataTable25  ;; SecBuff
        ADD      R3,SP,#+4
        ADD      R2,SP,#+8
        ADD      R1,SP,#+16
        MOVS     R0,R4
        BL       __OpenFileWr
        CBZ      R0,??Save_Buf_1
        MOVS     R0,#+10
        B.N      ??Save_Buf_2
//  224   for(i=0; i<32; i++){
??Save_Buf_1:
        MOVS     R5,#+0
        MOVS     R6,#+0
        MOVW     R8,#+1290
        LDR.W    R7,??DataTable29  ;; DataBuf
//  225     memcpy(SecBuff, &(DataBuf[i*512/4]), 512);
??Save_Buf_3:
        MOV      R2,#+512
        ASRS     R0,R6,#+1
        ADD      R0,R6,R0, LSR #+30
        ASRS     R0,R0,#+2
        ADD      R1,R7,R0, LSL #+2
        MOVS     R0,R4
        BL       __aeabi_memcpy
//  226     if(__ProgFileSec(SecBuff, pCluster)!= OK) return WR_ERR; // 写入数据
        ADD      R1,SP,#+8
        MOVS     R0,R4
        BL       __ProgFileSec
        CMP      R0,#+0
        BNE.N    ??Save_Buf_4
//  227     Print_Clk(254, 0, (SCRN<<8)+ TEXT1, (i >>1)& 3);        // 进度指示
??Save_Buf_5:
        ASRS     R0,R5,#+1
        AND      R3,R0,#0x3
        MOV      R2,R8
        MOVS     R1,#+0
        MOVS     R0,#+254
        BL       Print_Clk
//  228   }
        ADDS     R5,R5,#+1
        ADD      R6,R6,#+512
        UXTB     R0,R5
        CMP      R0,#+32
        BCC.N    ??Save_Buf_3
//  229   memset(SecBuff, 0, 512);
        MOV      R1,#+512
        MOVS     R0,R4
        BL       __aeabi_memclr4
//  230   p =(u16*)SecBuff;
        MOVS     R0,R4
//  231   for(i=0; i<4; i++){                     // 保存显示菜单中各个对应项的值
        LDR.W    R1,??DataTable40  ;; Title
        ADD      R2,R1,#+16
        MOVS     R3,#+2
//  232     *p++ = Title[i][0].Value;
??Save_Buf_6:
        LDRH     R12,[R2], #+20
        STRH     R12,[R0], #+2
//  233     *p++ = Title[i][1].Value;
        LDRH     R12,[R2], #+20
        STRH     R12,[R0], #+2
//  234     *p++ = Title[i][2].Value;
        LDRH     R12,[R2], #+20
        STRH     R12,[R0], #+2
//  235     *p++ = Title[i][3].Value;
        LDRH     R12,[R2], #+20
        STRH     R12,[R0], #+2
        LDRH     R12,[R2], #+20
        STRH     R12,[R0], #+2
        LDRH     R12,[R2], #+20
        STRH     R12,[R0], #+2
        LDRH     R12,[R2], #+20
        STRH     R12,[R0], #+2
        LDRH     R12,[R2], #+20
        STRH     R12,[R0], #+2
//  236   }
        SUBS     R3,R3,#+1
        BNE.N    ??Save_Buf_6
//  237   *p++ = Title[5][0].Value;
        LDRH     R2,[R1, #+416]
        STRH     R2,[R0, #+0]
//  238   *p++ = Title[5][1].Value;
        LDRH     R2,[R1, #+436]
        STRH     R2,[R0, #+2]!
//  239 
//  240   *p++ = 0x00FF & Ka1[_A_Range];
        LDRSH    R2,[R1, #+56]
        LDR.W    R3,??DataTable42  ;; Ka1
        LDRSB    R2,[R2, R3]
        UXTB     R2,R2
        STRH     R2,[R0, #+2]!
//  241   *p++ = Ka2[_A_Range];
        LDRSH    R2,[R1, #+56]
        LDR.W    R3,??DataTable46  ;; Ka2
        LDRH     R2,[R3, R2, LSL #+1]
        STRH     R2,[R0, #+2]!
//  242   *p++ = 0x00FF & Kb1[_B_Range];
        LDRSH    R2,[R1, #+136]
        LDR.W    R3,??DataTable43  ;; Kb1
        LDRSB    R2,[R2, R3]
        UXTB     R2,R2
        STRH     R2,[R0, #+2]!
//  243   *p++ = Kb2[_B_Range];
        LDRSH    R1,[R1, #+136]
        LDR.W    R2,??DataTable47  ;; Kb2
        LDRH     R1,[R2, R1, LSL #+1]
        STRH     R1,[R0, #+2]!
//  244 
//  245   if(__ProgFileSec(SecBuff, pCluster)!= OK) return WR_ERR; // 写入数据
        ADD      R1,SP,#+8
        MOVS     R0,R4
        BL       __ProgFileSec
        CBNZ     R0,??Save_Buf_4
//  246   if(__CloseFile(SecBuff, 0x4200, pCluster, pDirAddr)!= OK) return WR_ERR;
??Save_Buf_7:
        ADD      R3,SP,#+4
        ADD      R2,SP,#+8
        MOV      R1,#+16896
        MOVS     R0,R4
        BL       __CloseFile
        CBZ      R0,??Save_Buf_2
??Save_Buf_4:
        MOVS     R0,#+9
//  247   return 0;
??Save_Buf_2:
        ADD      SP,SP,#+32
        CFI CFA R13+24
        POP      {R4-R8,PC}       ;; return
        Nop      
        DATA
??Save_Buf_0:
        DC32     `?<Constant "DATA    BUF">`
        CFI EndBlock cfiBlock5
//  248 }
//  249 /*******************************************************************************
//  250 Load_Dat: 加载保存过的采集数据缓冲区    输入：文件编号     返回值：0x00=成功 
//  251 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function Load_Buf
        THUMB
//  252 u8 Load_Buf(u8 FileNum)
//  253 {
Load_Buf:
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
        MOVS     R6,R0
//  254   u8  i, Filename[13] = "DATA    BUF"; 
        ADD      R0,SP,#+16
        LDR.N    R1,??Load_Buf_0  ;; `?<Constant "DATA    BUF">_1`
        MOVS     R2,#+13
        BL       __aeabi_memcpy
//  255   u16 *p;
//  256   
//  257   u16 pCluster[3];
//  258   u32 pDirAddr[1]; 
//  259   
//  260   p = TempPar;
//  261   *p++ = 0xAA55;
        LDR.W    R4,??DataTable25  ;; SecBuff
        MOVW     R0,#+43605
        STRH     R0,[R4, #+512]
        ADDW     R0,R4,#+514
//  262   for(i=0; i<4; i++){                     // 保存显示菜单中各个对应项的值
        LDR.W    R5,??DataTable40  ;; Title
        ADD      R1,R5,#+16
        MOVS     R2,#+2
//  263     *p++ = Title[i][0].Value;
??Load_Buf_1:
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
//  264     *p++ = Title[i][1].Value;
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
//  265     *p++ = Title[i][2].Value;
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
//  266     *p++ = Title[i][3].Value;
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
//  267   }
        SUBS     R2,R2,#+1
        BNE.N    ??Load_Buf_1
//  268   *p++ = Title[5][0].Value;
        LDRH     R1,[R5, #+416]
        STRH     R1,[R0], #+2
//  269   *p++ = Title[5][1].Value;
        LDRH     R1,[R5, #+436]
        STRH     R1,[R0], #+2
//  270   for(i=0; i<8; i++){
        LDR.W    R11,??DataTable42  ;; Ka1
        MOV      R1,R11
        LDR.W    R10,??DataTable43  ;; Kb1
        MOV      R2,R10
        LDR.W    R9,??DataTable46  ;; Ka2
        MOV      R3,R9
        LDR.W    R8,??DataTable47  ;; Kb2
        MOV      R12,R8
        MOV      LR,#+4
//  271     *p++ = 0x00FF & Ka1[i];
??Load_Buf_2:
        LDRSB    R7,[R1], #+1
        UXTB     R7,R7
        STRH     R7,[R0], #+2
//  272     *p++ = Ka2[i];
        LDRH     R7,[R3], #+2
        STRH     R7,[R0], #+2
//  273     *p++ = 0x00FF & Kb1[i];
        LDRSB    R7,[R2], #+1
        UXTB     R7,R7
        STRH     R7,[R0], #+2
//  274     *p++ = Kb2[i];
        LDRH     R7,[R12], #+2
        STRH     R7,[R0], #+2
        LDRSB    R7,[R1], #+1
        UXTB     R7,R7
        STRH     R7,[R0], #+2
        LDRH     R7,[R3], #+2
        STRH     R7,[R0], #+2
        LDRSB    R7,[R2], #+1
        UXTB     R7,R7
        STRH     R7,[R0], #+2
        LDRH     R7,[R12], #+2
        STRH     R7,[R0], #+2
//  275   }
        SUBS     LR,LR,#+1
        BNE.N    ??Load_Buf_2
//  276   Make_Filename(FileNum, Filename);
        MOVS     R1,R6
        ADD      R0,SP,#+0
        BL       u8ToDec3
        LDRB     R0,[SP, #+0]
        STRB     R0,[SP, #+20]
        ADD      R0,SP,#+0
        LDRB     R1,[R0, #+1]
        STRB     R1,[SP, #+21]
        LDRB     R0,[R0, #+2]
        STRB     R0,[SP, #+22]
//  277   i = __OpenFileRd(SecBuff, Filename, pCluster, pDirAddr);
        ADD      R3,SP,#+12
        ADD      R2,SP,#+4
        ADD      R1,SP,#+16
        MOVS     R0,R4
        BL       __OpenFileRd
        MOVS     R6,R0
//  278   if(i != OK) return i;
        BNE.W    ??Load_Buf_3
//  279   for(i=0; i<32; i++){
        MOVS     R6,#+0
        MOVS     R7,#+0
//  280     if(__ReadFileSec(SecBuff, pCluster)!= OK) return RD_ERR;
??Load_Buf_4:
        ADD      R1,SP,#+4
        MOVS     R0,R4
        BL       __ReadFileSec
        CBZ      R0,??Load_Buf_5
??Load_Buf_6:
        MOVS     R0,#+8
        B.N      ??Load_Buf_3
//  281     memcpy(&(DataBuf[i*512/4]),SecBuff,512);
??Load_Buf_5:
        MOV      R2,#+512
        MOVS     R1,R4
        ASRS     R0,R7,#+1
        ADD      R0,R7,R0, LSR #+30
        ASRS     R0,R0,#+2
        LDR.W    R3,??DataTable29  ;; DataBuf
        ADD      R0,R3,R0, LSL #+2
        BL       __aeabi_memcpy
//  282   }
        ADDS     R6,R6,#+1
        ADD      R7,R7,#+512
        UXTB     R0,R6
        CMP      R0,#+32
        BCC.N    ??Load_Buf_4
//  283   if(__ReadFileSec(SecBuff, pCluster)!= OK) return RD_ERR;
        ADD      R1,SP,#+4
        MOVS     R0,R4
        BL       __ReadFileSec
        CMP      R0,#+0
        BNE.N    ??Load_Buf_6
//  284   p =(u16*)SecBuff;
        MOVS     R0,R4
//  285   for(i=0; i<4; i++){
        ADD      R1,R5,#+16
        MOVS     R2,#+2
//  286     Title[i][0].Value = *p++;             // 加载之前的显示菜单中各个对应项的值
??Load_Buf_7:
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #+20
//  287     Title[i][1].Value = *p++ ;
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #+20
//  288     Title[i][2].Value = *p++;
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #+20
//  289     Title[i][3].Value = *p++;
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #-58
//  290     Title[i][0].Flag  = UPDAT;
        MOVS     R3,#+2
        STRB     R3,[R1], #+20
//  291     Title[i][1].Flag  = UPDAT;
        STRB     R3,[R1], #+20
//  292     Title[i][2].Flag  = UPDAT;
        STRB     R3,[R1], #+20
//  293     Title[i][3].Flag  = UPDAT;
        STRB     R3,[R1], #+18
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #+20
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #+20
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #+20
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #-58
        MOVS     R3,#+2
        STRB     R3,[R1], #+20
        STRB     R3,[R1], #+20
        STRB     R3,[R1], #+20
        STRB     R3,[R1], #+18
//  294   }
        SUBS     R2,R2,#+1
        BNE.N    ??Load_Buf_7
//  295   Title[5][0].Value = *p++;
        LDRSH    R1,[R0, #+0]
        STRH     R1,[R5, #+416]
//  296   Title[5][1].Value = *p++;
        LDRSH    R1,[R0, #+2]!
        STRH     R1,[R5, #+436]
//  297   Title[5][0].Flag  = UPDAT;
        ADD      R1,R5,#+418
        STRB     R3,[R1, #+0]
//  298   Title[5][1].Flag  = UPDAT;
        ADD      R1,R5,#+438
        STRB     R3,[R1, #+0]
        LDRSH    R1,[R5, #+56]
        LDRH     R2,[R0, #+2]!
        STRB     R2,[R1, R11]
//  299       
//  300   Ka1[_A_Range] = (*p++ );
//  301   Ka2[_A_Range] = (*p++ );
        LDRH     R2,[R0, #+2]!
        STRH     R2,[R9, R1, LSL #+1]
        LDRSH    R1,[R5, #+136]
        LDRH     R2,[R0, #+2]!
        STRB     R2,[R1, R10]
//  302   Kb1[_B_Range] = (*p++);
//  303   Kb2[_B_Range] = (*p++); /**/
        LDRH     R2,[R0, #+2]!
        STRH     R2,[R8, R1, LSL #+1]
//  304 
//  305   Title[RUNNING][STATE].Value = 1;                 // 置"HOLD" 状态
        MOVS     R0,#+1
        STRH     R0,[R5, #+336]
//  306   Title[RUNNING][STATE].Flag |= UPDAT;             // 置相应的更新标志
        ADD      R0,R5,#+338
        LDRB     R0,[R0, #+0]
        ORR      R0,R0,#0x2
        ADD      R1,R5,#+338
        STRB     R0,[R1, #+0]
//  307   return 0;
        MOVS     R0,#+0
??Load_Buf_3:
        ADD      SP,SP,#+36
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        DATA
??Load_Buf_0:
        DC32     `?<Constant "DATA    BUF">_1`
        CFI EndBlock cfiBlock6
//  308 }
//  309 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function reset_parameter
        THUMB
//  310 void reset_parameter(void)
//  311 {
reset_parameter:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//  312   u16* p;
//  313   u8   i;
//  314   
//  315   p=TempPar;
//  316   p++;
        LDR.W    R0,??DataTable25  ;; SecBuff
        ADDW     R1,R0,#+514
//  317   if(TempPar[0]!=0xAA55) return;
        LDRH     R2,[R0, #+512]
        MOVW     R3,#+43605
        CMP      R2,R3
        BNE.W    ??reset_parameter_0
//  318   for(i=0; i<4; i++){
        LDR.W    R2,??DataTable40  ;; Title
        ADD      R3,R2,#+16
        MOV      R12,#+2
//  319     Title[i][0].Value = *p++;             // 加载之前的显示菜单中各个对应项的值
??reset_parameter_1:
        LDRSH    LR,[R1], #+2
        STRH     LR,[R3], #+20
//  320     Title[i][1].Value = *p++;
        LDRSH    LR,[R1], #+2
        STRH     LR,[R3], #+20
//  321     Title[i][2].Value = *p++;
        LDRSH    LR,[R1], #+2
        STRH     LR,[R3], #+20
//  322     Title[i][3].Value = *p++;
        LDRSH    LR,[R1], #+2
        STRH     LR,[R3], #-58
//  323     Title[i][0].Flag  = UPDAT;
        MOV      LR,#+2
        STRB     LR,[R3], #+20
//  324     Title[i][1].Flag  = UPDAT;
        STRB     LR,[R3], #+20
//  325     Title[i][2].Flag  = UPDAT;
        STRB     LR,[R3], #+20
//  326     Title[i][3].Flag  = UPDAT;
        STRB     LR,[R3], #+18
        LDRSH    LR,[R1], #+2
        STRH     LR,[R3], #+20
        LDRSH    LR,[R1], #+2
        STRH     LR,[R3], #+20
        LDRSH    LR,[R1], #+2
        STRH     LR,[R3], #+20
        LDRSH    LR,[R1], #+2
        STRH     LR,[R3], #-58
        MOV      LR,#+2
        STRB     LR,[R3], #+20
        STRB     LR,[R3], #+20
        STRB     LR,[R3], #+20
        STRB     LR,[R3], #+18
//  327   }
        SUBS     R12,R12,#+1
        BNE.N    ??reset_parameter_1
//  328   Title[5][0].Value = *p++;
        LDRSH    R3,[R1], #+2
        STRH     R3,[R2, #+416]
//  329   Title[5][1].Value = *p++;
        LDRSH    R3,[R1], #+2
        STRH     R3,[R2, #+436]
//  330   Title[5][0].Flag  = UPDAT;
        ADD      R3,R2,#+418
        MOV      R12,LR
        STRB     R12,[R3, #+0]
//  331   Title[5][1].Flag  = UPDAT;
        ADD      R2,R2,#+438
        MOVS     R3,#+2
        STRB     R3,[R2, #+0]
//  332   
//  333   for(i=0; i<8; i++){
        LDR.W    R2,??DataTable42  ;; Ka1
        LDR.W    R3,??DataTable43  ;; Kb1
        LDR.W    R12,??DataTable46  ;; Ka2
        LDR.W    LR,??DataTable47  ;; Kb2
        MOVS     R4,#+2
//  334     Ka1[i] = (s8)(*p++ );//& 0xff);
??reset_parameter_2:
        LDRH     R5,[R1], #+2
        STRB     R5,[R2], #+1
//  335     Ka2[i] = (*p++ );
        LDRH     R5,[R1], #+2
        STRH     R5,[R12], #+2
//  336     Kb1[i] = (s8)(*p++);// & 0xff);
        LDRH     R5,[R1], #+2
        STRB     R5,[R3], #+1
//  337     Kb2[i] = (*p++);
        LDRH     R5,[R1], #+2
        STRH     R5,[LR], #+2
        LDRH     R5,[R1], #+2
        STRB     R5,[R2], #+1
        LDRH     R5,[R1], #+2
        STRH     R5,[R12], #+2
        LDRH     R5,[R1], #+2
        STRB     R5,[R3], #+1
        LDRH     R5,[R1], #+2
        STRH     R5,[LR], #+2
        LDRH     R5,[R1], #+2
        STRB     R5,[R2], #+1
        LDRH     R5,[R1], #+2
        STRH     R5,[R12], #+2
        LDRH     R5,[R1], #+2
        STRB     R5,[R3], #+1
        LDRH     R5,[R1], #+2
        STRH     R5,[LR], #+2
        LDRH     R5,[R1], #+2
        STRB     R5,[R2], #+1
        LDRH     R5,[R1], #+2
        STRH     R5,[R12], #+2
        LDRH     R5,[R1], #+2
        STRB     R5,[R3], #+1
        LDRH     R5,[R1], #+2
        STRH     R5,[LR], #+2
//  338   }
        SUBS     R4,R4,#+1
        BNE.N    ??reset_parameter_2
//  339   p = TempPar;
//  340   *p++ = 0;
        MOVS     R1,#+0
        STRH     R1,[R0, #+512]
//  341 }
??reset_parameter_0:
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        CFI EndBlock cfiBlock7
//  342 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function make_Vertical
        THUMB
//  343 void make_Vertical(u8 TRACK,u8* buf,u8* len)
//  344 {
make_Vertical:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  345   u8 i=0;
        MOVS     R3,#+0
//  346   u8* ptr;
//  347 
//  348   ptr = &Vertical[0][0] + 10*Title[TRACK][2].Value;
        MOV      R12,#+80
        LDR.W    LR,??DataTable40  ;; Title
        MLA      R0,R0,R12,LR
        LDRSH    R0,[R0, #+56]
        MOV      R12,#+10
        LDR.W    LR,??DataTable26  ;; Vertical
        MLA      R0,R0,R12,LR
        MOV      R12,R1
        B.N      ??make_Vertical_0
//  349   while(*ptr != 0){
//  350     if(*ptr == 0x21)  buf[i] = 0x20;
//  351     else              buf[i] = *ptr;
??make_Vertical_1:
        STRB     LR,[R12], #+1
//  352     ptr++;
        ADDS     R0,R0,#+1
//  353     i++;
        ADDS     R3,R3,#+1
        UXTB     R3,R3
??make_Vertical_0:
        LDRB     LR,[R0, #+0]
        CMP      LR,#+0
        BEQ.N    ??make_Vertical_2
        CMP      LR,#+33
        BNE.N    ??make_Vertical_1
        MOV      LR,#+32
        B.N      ??make_Vertical_1
//  354   };
//  355   buf[i]   = 0x2c;
??make_Vertical_2:
        MOV      R12,#+44
        STRB     R12,[R3, R1]
//  356   buf[i+1] = 0;
        ADDS     R0,R3,R1
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]
//  357   *len = i+1;
        ADDS     R0,R3,#+1
        STRB     R0,[R2, #+0]
//  358 }
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock8
//  359 /*******************************************************************************
//  360 Save_Csv: 保存采集数据缓存区为CSV格式    输入：文件编号     返回值：0x00=成功      
//  361 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function Save_Csv
        THUMB
//  362 u8 Save_Csv(u8 FileNum)
//  363 {
Save_Csv:
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
        MOVS     R5,R0
//  364   u8  Num[4], track[4], Filename[12] = "DATA    CSV"; 
        ADD      R0,SP,#+24
        LDR.N    R1,??Save_Csv_0  ;; `?<Constant "DATA    CSV">`
        MOVS     R2,#+12
        BL       __aeabi_memcpy
//  365   u32 i, k = 0;
//  366   s16 temp;
//  367   u8  count, j, n = 0;
        MOVS     R4,#+0
//  368   
//  369   u16 pCluster[3];
//  370   u32 pDirAddr[1]; 
//  371 
//  372   Make_Filename(FileNum, Filename);
        MOVS     R1,R5
        ADD      R0,SP,#+4
        BL       u8ToDec3
        LDRB     R0,[SP, #+4]
        STRB     R0,[SP, #+28]
        ADD      R0,SP,#+4
        LDRB     R1,[R0, #+1]
        STRB     R1,[SP, #+29]
        LDRB     R0,[R0, #+2]
        STRB     R0,[SP, #+30]
//  373   if(__OpenFileWr(SecBuff, Filename, pCluster, pDirAddr)!=OK) return DISK_ERR;
        LDR.N    R5,??DataTable25  ;; SecBuff
        ADD      R3,SP,#+20
        ADD      R2,SP,#+8
        ADD      R1,SP,#+24
        MOVS     R0,R5
        BL       __OpenFileWr
        CBZ      R0,??Save_Csv_1
        MOVS     R0,#+10
        B.N      ??Save_Csv_2
//  374   memcpy(SecBuff, "TRACK1 ", 7);
??Save_Csv_1:
        MOVS     R2,#+7
        LDR.N    R1,??Save_Csv_0+0x4  ;; `?<Constant "TRACK1 ">`
        MOVS     R0,R5
        BL       __aeabi_memcpy4
//  375   make_Vertical(TRACK1, &SecBuff[7], &count);
        MOVS     R0,#+0
        MOVS     R6,#+10
        LDR.N    R7,??DataTable26  ;; Vertical
        LDR.W    R1,??DataTable40  ;; Title
        LDRSH    R1,[R1, #+56]
        MLA      R1,R1,R6,R7
        MOVS     R2,R5
        B.N      ??Save_Csv_3
??Save_Csv_4:
        STRB     R3,[R2, #+7]
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R2,R2,#+1
??Save_Csv_3:
        LDRB     R3,[R1, #+0]
        CBZ      R3,??Save_Csv_5
        CMP      R3,#+33
        BNE.N    ??Save_Csv_4
        MOVS     R3,#+32
        B.N      ??Save_Csv_4
??Save_Csv_5:
        ADDS     R1,R0,R5
        MOVS     R2,#+44
        STRB     R2,[R1, #+7]
        STRB     R4,[R1, #+8]
//  376   k = 7 + count;
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADD      R8,R0,#+7
//  377   memcpy(&SecBuff[k], "TRACK2 ", 7);
        ADD      R9,R8,R5
        MOVS     R2,#+7
        LDR.N    R1,??Save_Csv_0+0x8  ;; `?<Constant "TRACK2 ">`
        MOV      R0,R9
        BL       __aeabi_memcpy
//  378   make_Vertical(TRACK2, &SecBuff[k+7], &count);
        ADD      R1,R9,#+7
        MOVS     R0,#+0
        LDR.W    R2,??DataTable40  ;; Title
        LDRSH    R2,[R2, #+136]
        MLA      R2,R2,R6,R7
        MOVS     R3,R1
        B.N      ??Save_Csv_6
??Save_Csv_7:
        STRB     R12,[R3], #+1
        ADDS     R2,R2,#+1
        ADDS     R0,R0,#+1
        UXTB     R0,R0
??Save_Csv_6:
        LDRB     R12,[R2, #+0]
        CMP      R12,#+0
        BEQ.N    ??Save_Csv_8
        CMP      R12,#+33
        BNE.N    ??Save_Csv_7
        MOV      R12,#+32
        B.N      ??Save_Csv_7
??Save_Csv_8:
        MOVS     R3,#+44
        STRB     R3,[R0, R1]
        ADDS     R1,R0,R1
        STRB     R4,[R1, #+1]
//  379   k += 7 + count;
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R0,R0,#+7
        ADD      R6,R0,R8
//  380   memcpy(&SecBuff[k], "TRACK3,TRACK4,\r\n", 15);
        MOVS     R2,#+15
        LDR.N    R1,??Save_Csv_0+0xC  ;; `?<Constant "TRACK3,TRACK4,\\r\\n">`
        ADDS     R0,R6,R5
        BL       __aeabi_memcpy
//  381   k += 15;
        ADD      R9,R6,#+15
//  382   for(i=0; i<4096; i++){
        MOV      R11,R4
        LDR.N    R0,??DataTable29  ;; DataBuf
        STR      R0,[SP, #+4]
//  383     temp=Ka1[_A_Range]+((Ka2[_A_Range]*(DataBuf[i] & 0xff))+512)/1024;
??Save_Csv_9:
        LDR.W    R0,??DataTable40  ;; Title
        LDRSH    R1,[R0, #+56]
        LDR      R0,[SP, #+4]
        LDR      R0,[R0, #+0]
        LDR.W    R2,??DataTable42  ;; Ka1
        LDRSB    R2,[R1, R2]
        LDR.W    R3,??DataTable46  ;; Ka2
        LDRH     R1,[R3, R1, LSL #+1]
        UXTB     R3,R0
        MOV      R12,#+512
        MLA      R1,R1,R3,R12
        ADD      R1,R2,R1, LSR #+10
        SXTH     R1,R1
//  384     if(temp > 0){
        CMP      R1,#+1
        BLT.N    ??Save_Csv_10
//  385       if(temp > 200)  track[0] = 199;
        CMP      R1,#+201
        BLT.N    ??Save_Csv_11
        MOVS     R1,#+199
        STRB     R1,[SP, #+0]
        B.N      ??Save_Csv_12
//  386       else            track[0] = temp;
??Save_Csv_11:
        STRB     R1,[SP, #+0]
        B.N      ??Save_Csv_12
//  387     } else            track[0] = 0;
??Save_Csv_10:
        MOVS     R1,#+0
        STRB     R1,[SP, #+0]
//  388     temp = Kb1[_B_Range]+((Kb2[_B_Range]*(DataBuf[i] & 0xff00)>>8)+512)/1024;
??Save_Csv_12:
        LDR.W    R1,??DataTable40  ;; Title
        LDRSH    R1,[R1, #+136]
        LDR.W    R2,??DataTable43  ;; Kb1
        LDRSB    R2,[R1, R2]
        LDR.W    R3,??DataTable47  ;; Kb2
        LDRH     R1,[R3, R1, LSL #+1]
        AND      R3,R0,#0xFF00
        MULS     R1,R1,R3
        LSRS     R1,R1,#+8
        ADD      R1,R1,#+512
        ADD      R1,R2,R1, LSR #+10
        SXTH     R1,R1
//  389     if(temp > 0){
        CMP      R1,#+1
        BLT.N    ??Save_Csv_13
//  390       if(temp > 200)  track[1] = 199;
        CMP      R1,#+201
        BLT.N    ??Save_Csv_14
        MOVS     R1,#+199
        STRB     R1,[SP, #+1]
        B.N      ??Save_Csv_15
//  391       else            track[1] = temp;
??Save_Csv_14:
        STRB     R1,[SP, #+1]
        B.N      ??Save_Csv_15
//  392     } else            track[1] = 0;
??Save_Csv_13:
        MOVS     R1,#+0
        STRB     R1,[SP, #+1]
//  393     if((DataBuf[i] & 0x010000)==0)  track[2] = Title[TRACK3][POSI].Value;
??Save_Csv_15:
        LDR.W    R1,??DataTable40  ;; Title
        LDRSH    R1,[R1, #+236]
        TST      R0,#0x10000
        BNE.N    ??Save_Csv_16
        STRB     R1,[SP, #+2]
        B.N      ??Save_Csv_17
//  394     else                            track[2] = 20 + Title[TRACK3][POSI].Value;
??Save_Csv_16:
        ADDS     R1,R1,#+20
        STRB     R1,[SP, #+2]
//  395     if((DataBuf[i] & 0x020000)==0)  track[3] = Title[TRACK4][POSI].Value;
??Save_Csv_17:
        LDR.W    R1,??DataTable40  ;; Title
        LDRSH    R1,[R1, #+316]
        TST      R0,#0x20000
        ITTE     NE 
        ADDNE    R0,R1,#+20
        STRBNE   R0,[SP, #+3]
        STRBEQ   R1,[SP, #+3]
//  396     else                            track[3] = 20 + Title[TRACK4][POSI].Value;
//  397     for(j=0; j<4; j++){
        MOV      R8,#+0
        ADD      R10,SP,#+0
//  398       u8ToDec3(Num, track[j]);
??Save_Csv_18:
        LDRB     R1,[R10, #+0]
        ADD      R0,SP,#+16
        BL       u8ToDec3
//  399       for(count=0; count<3; count++){
        MOVS     R6,#+0
        ADD      R7,SP,#+16
//  400         if(Num[count] == 0) break;
??Save_Csv_19:
        LDRB     R0,[R7, #+0]
        CBZ      R0,??Save_Csv_20
//  401         SecBuff[k++] = Num[count];
        STRB     R0,[R9, R5]
        ADD      R9,R9,#+1
//  402         if(k >= 512){
        CMP      R9,#+512
        BCC.N    ??Save_Csv_21
//  403           if(__ProgFileSec(SecBuff, pCluster)!= OK) return WR_ERR; // 写入数据
        ADD      R1,SP,#+8
        MOVS     R0,R5
        BL       __ProgFileSec
        CMP      R0,#+0
        BNE.W    ??Save_Csv_22
//  404           Print_Clk(254, 0, (SCRN<<8)+ TEXT1, (n++ >>1)& 3);    // 进度指示
??Save_Csv_23:
        ASRS     R0,R4,#+1
        AND      R3,R0,#0x3
        MOVW     R2,#+1290
        MOVS     R1,#+0
        MOVS     R0,#+254
        BL       Print_Clk
        ADDS     R4,R4,#+1
        UXTB     R4,R4
//  405           k = 0;
        MOV      R9,#+0
//  406         }
//  407       }
??Save_Csv_21:
        ADDS     R6,R6,#+1
        ADDS     R7,R7,#+1
        UXTB     R6,R6
        CMP      R6,#+3
        BCC.N    ??Save_Csv_19
//  408       SecBuff[k++] = 0x2c;
??Save_Csv_20:
        MOVS     R0,#+44
        STRB     R0,[R9, R5]
        ADD      R9,R9,#+1
//  409       if(k >= 512){
        CMP      R9,#+512
        BCC.N    ??Save_Csv_24
//  410         if(__ProgFileSec(SecBuff, pCluster)!= OK) return WR_ERR; // 写入数据
        ADD      R1,SP,#+8
        MOVS     R0,R5
        BL       __ProgFileSec
        CMP      R0,#+0
        BNE.N    ??Save_Csv_22
//  411         Print_Clk(254, 0, (SCRN<<8)+ TEXT1, (n++ >>1)& 3);    // 进度指示
??Save_Csv_25:
        ASRS     R0,R4,#+1
        AND      R3,R0,#0x3
        MOVW     R2,#+1290
        MOVS     R1,#+0
        MOVS     R0,#+254
        BL       Print_Clk
        ADDS     R4,R4,#+1
        UXTB     R4,R4
//  412         k = 0;
        MOV      R9,#+0
//  413       }
//  414     }
??Save_Csv_24:
        ADD      R8,R8,#+1
        ADD      R10,R10,#+1
        UXTB     R0,R8
        CMP      R0,#+4
        BCC.N    ??Save_Csv_18
//  415     SecBuff[k++] = 0x0d;
        MOVS     R0,#+13
        STRB     R0,[R9, R5]
        ADD      R9,R9,#+1
//  416     if(k >= 512){
        CMP      R9,#+512
        BCC.N    ??Save_Csv_26
//  417       if(__ProgFileSec(SecBuff, pCluster)!= OK) return WR_ERR; // 写入数据
        ADD      R1,SP,#+8
        MOVS     R0,R5
        BL       __ProgFileSec
        CMP      R0,#+0
        BNE.N    ??Save_Csv_22
//  418       Print_Clk(254, 0, (SCRN<<8)+ TEXT1, (n++ >>1)& 3);    // 进度指示
??Save_Csv_27:
        ASRS     R0,R4,#+1
        AND      R3,R0,#0x3
        MOVW     R2,#+1290
        MOVS     R1,#+0
        MOVS     R0,#+254
        BL       Print_Clk
        ADDS     R4,R4,#+1
        UXTB     R4,R4
//  419       k = 0;
        MOV      R9,#+0
//  420     }
//  421     SecBuff[k++] = 0x0a;
??Save_Csv_26:
        MOVS     R0,#+10
        STRB     R0,[R9, R5]
        ADD      R9,R9,#+1
//  422     if(k >= 512){
        CMP      R9,#+512
        BCC.N    ??Save_Csv_28
//  423       if(__ProgFileSec(SecBuff, pCluster)!= OK) return WR_ERR; // 写入数据
        ADD      R1,SP,#+8
        MOVS     R0,R5
        BL       __ProgFileSec
        CBNZ     R0,??Save_Csv_22
//  424       Print_Clk(254, 0, (SCRN<<8)+ TEXT1, (n++ >>1)& 3);    // 进度指示
??Save_Csv_29:
        ASRS     R0,R4,#+1
        AND      R3,R0,#0x3
        MOVW     R2,#+1290
        MOVS     R1,#+0
        MOVS     R0,#+254
        BL       Print_Clk
        ADDS     R4,R4,#+1
        UXTB     R4,R4
//  425       k = 0;
        MOV      R9,#+0
//  426     }
//  427   }
??Save_Csv_28:
        ADD      R11,R11,#+1
        LDR      R0,[SP, #+4]
        ADDS     R0,R0,#+4
        STR      R0,[SP, #+4]
        CMP      R11,#+4096
        BCC.W    ??Save_Csv_9
//  428   if(k != 0){
        CMP      R9,#+0
        BEQ.N    ??Save_Csv_30
//  429     SecBuff[k++]=0x0d;
        MOVS     R0,#+13
        STRB     R0,[R9, R5]
        ADD      R0,R9,#+1
//  430     SecBuff[k++]=0x0a;
        MOVS     R1,#+10
        STRB     R1,[R0, R5]
        ADD      R9,R0,#+1
//  431     memset(&SecBuff[k],0,(512-k));
        RSB      R1,R9,#+512
        ADD      R0,R9,R5
        BL       __aeabi_memclr
//  432     k=0;
//  433     if(__ProgFileSec(SecBuff, pCluster)!= OK) return WR_ERR; // 写入数据
        ADD      R1,SP,#+8
        MOVS     R0,R5
        BL       __ProgFileSec
        CBNZ     R0,??Save_Csv_22
//  434     Print_Clk(254, 0, (SCRN<<8)+ TEXT1, (n >>1)& 3);    // 进度指示
??Save_Csv_31:
        ASRS     R0,R4,#+1
        AND      R3,R0,#0x3
        MOVW     R2,#+1290
        MOVS     R1,#+0
        MOVS     R0,#+254
        BL       Print_Clk
//  435   }
//  436   if(__CloseFile(SecBuff, n*512, pCluster, pDirAddr)!= OK) return WR_ERR;
??Save_Csv_30:
        ADD      R3,SP,#+20
        ADD      R2,SP,#+8
        LSLS     R1,R4,#+9
        MOVS     R0,R5
        BL       __CloseFile
        CBZ      R0,??Save_Csv_2
??Save_Csv_22:
        MOVS     R0,#+9
//  437   return OK;
??Save_Csv_2:
        ADD      SP,SP,#+36
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        Nop      
        DATA
??Save_Csv_0:
        DC32     `?<Constant "DATA    CSV">`
        DC32     `?<Constant "TRACK1 ">`
        DC32     `?<Constant "TRACK2 ">`
        DC32     `?<Constant "TRACK3,TRACK4,\\r\\n">`
        CFI EndBlock cfiBlock9
//  438 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable25:
        DC32     SecBuff

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable26:
        DC32     Vertical

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable29:
        DC32     DataBuf
//  439 /*******************************************************************************
//  440 Load_Parameter: 加载之前的工作参数                           Return: 0= Success
//  441 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function Load_Param
        THUMB
//  442 u8 Load_Param(void)
//  443 { 
Load_Param:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        SUB      SP,SP,#+24
        CFI CFA R13+40
//  444   u8  Sum = 0, Filename[12], Versions = 0x06; 
        MOVS     R4,#+0
//  445   u16 i;
//  446   u16* p =(u16*)SecBuff;
//  447   
//  448   u16 pCluster[3];
//  449   u32 pDirAddr[1]; 
//  450   
//  451   Word2Hex(Filename, __GetDev_SN());
        BL       __GetDev_SN
        MOVS     R1,R0
        ADD      R0,SP,#+0
        BL       Word2Hex
//  452   Filename[8] = 'W'; Filename[9] = 'P'; Filename[10] = 'T'; Filename[11] = 0; 
        MOVS     R0,#+87
        STRB     R0,[SP, #+8]
        MOVS     R0,#+80
        STRB     R0,[SP, #+9]
        MOVS     R0,#+84
        STRB     R0,[SP, #+10]
        MOVS     R0,#+0
        STRB     R0,[SP, #+11]
//  453   i = __OpenFileRd(SecBuff, Filename, pCluster, pDirAddr);
        LDR.N    R5,??Load_Param_0  ;; SecBuff
        ADD      R3,SP,#+12
        ADD      R2,SP,#+16
        ADD      R1,SP,#+0
        MOVS     R0,R5
        BL       __OpenFileRd
//  454   if(i != OK) return i;
        MOVS     R1,R0
        BNE.W    ??Load_Param_1
//  455 //  if(__OpenFileRd(SecBuff, Filename, pCluster, pDirAddr) != OK) return NO_FILE;
//  456   if(__ReadFileSec(SecBuff, pCluster)!= OK) return RD_ERR;
        ADD      R1,SP,#+16
        MOVS     R0,R5
        BL       __ReadFileSec
        CBZ      R0,??Load_Param_2
        MOVS     R0,#+8
        B.N      ??Load_Param_1
//  457   if(Versions !=(*p & 0xFF)) return VER_ERR;          // 版本出错返回
??Load_Param_2:
        LDRH     R0,[R5, #+0]
        UXTB     R0,R0
        CMP      R0,#+6
        BEQ.N    ??Load_Param_3
        MOVS     R0,#+5
        B.N      ??Load_Param_1
//  458   for(i=0; i<512; ++i) Sum += SecBuff[i];
??Load_Param_3:
        MOVS     R0,R5
        MOVS     R1,#+128
??Load_Param_4:
        LDRB     R2,[R0], #+1
        ADDS     R2,R2,R4
        UXTB     R2,R2
        LDRB     R3,[R0], #+1
        ADDS     R2,R3,R2
        UXTB     R2,R2
        LDRB     R3,[R0], #+1
        ADDS     R2,R3,R2
        UXTB     R2,R2
        LDRB     R3,[R0], #+1
        ADDS     R4,R3,R2
        UXTB     R4,R4
        SUBS     R1,R1,#+1
        BNE.N    ??Load_Param_4
//  459   if(Sum != 0) return SUM_ERR;                        // 校验和出错返回
        CBZ      R4,??Load_Param_5
        MOVS     R0,#+6
        B.N      ??Load_Param_1
//  460   Current =(*p++ >>8);                                // 加载之前的 Current Title
??Load_Param_5:
        LDRH     R0,[R5, #+0]
        LSRS     R0,R0,#+8
        LDR.N    R1,??DataTable38  ;; Current
        STRB     R0,[R1, #+0]
//  461   for(i=0; i<7; i++){ 
//  462     Detail[i*2]  = *p;
        LDR.N    R1,??DataTable39  ;; Detail
        LDRH     R0,[R5, #+2]
        STRB     R0,[R1, #+0]
//  463     Detail[i*2+1]= (*p++ >>8);                        // 加载之前的 Detail
        LSRS     R0,R0,#+8
        STRB     R0,[R1, #+1]
        ADDS     R0,R5,#+4
        ADDS     R1,R1,#+2
        MOVS     R2,#+2
??Load_Param_6:
        LDRH     R3,[R0, #+0]
        STRB     R3,[R1], #+1
        LSRS     R3,R3,#+8
        STRB     R3,[R1], #+1
        LDRH     R3,[R0, #+2]!
        STRB     R3,[R1], #+1
        LDRH     R3,[R0, #+0]
        LSRS     R3,R3,#+8
        STRB     R3,[R1], #+1
        LDRH     R3,[R0, #+2]!
        STRB     R3,[R1], #+1
        LDRH     R3,[R0], #+2
        LSRS     R3,R3,#+8
        STRB     R3,[R1], #+1
//  464   }
        SUBS     R2,R2,#+1
        BNE.N    ??Load_Param_6
//  465   for(i=0; i<13; i++){
//  466     Title[i][0].Value = *p++;                         // 加载之前的显示菜单中各个对应项的值
        LDR.N    R1,??DataTable40  ;; Title
        LDRSH    R2,[R0], #+2
        STRH     R2,[R1, #+16]
//  467     Title[i][1].Value = *p++;
        LDRSH    R2,[R0], #+2
        STRH     R2,[R1, #+36]
//  468     Title[i][2].Value = *p++;
        LDRSH    R2,[R0], #+2
        STRH     R2,[R1, #+56]
//  469     Title[i][3].Value = *p++;
        LDRSH    R2,[R0], #+2
        STRH     R2,[R1, #+76]
        ADDS     R1,R1,#+96
        MOVS     R2,#+6
??Load_Param_7:
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #+20
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #+20
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #+20
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #+20
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #+20
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #+20
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #+20
        LDRSH    R3,[R0], #+2
        STRH     R3,[R1], #+20
//  470   }
        SUBS     R2,R2,#+1
        BNE.N    ??Load_Param_7
//  471   for(i=0; i<9; i++){
        LDR.N    R1,??DataTable41  ;; Meter + 4
        MOVS     R2,#+3
//  472     Meter[i].Item     = *p;
??Load_Param_8:
        LDRH     R3,[R0, #+0]
        STRB     R3,[R1, #+1]
//  473     Meter[i].Track    =(*p++ >>8);       // 加载之前的测量项目及测量对象
        LSRS     R3,R3,#+8
        STRB     R3,[R1, #+0]
        LDRH     R3,[R0, #+2]!
        STRB     R3,[R1, #+13]
        LDRH     R3,[R0, #+0]
        LSRS     R3,R3,#+8
        STRB     R3,[R1, #+12]
        LDRH     R3,[R0, #+2]!
        STRB     R3,[R1, #+25]
        LDRH     R3,[R0], #+2
        LSRS     R3,R3,#+8
        STRB     R3,[R1, #+24]
//  474   }
        ADDS     R1,R1,#+36
        SUBS     R2,R2,#+1
        BNE.N    ??Load_Param_8
//  475   for(i=0; i<10; i++){
        LDR.N    R1,??DataTable42  ;; Ka1
        LDR.N    R2,??DataTable43  ;; Kb1
        LDR.N    R3,??DataTable44  ;; Ka3
        LDR.W    R12,??DataTable45  ;; Kb3
        LDR.W    LR,??DataTable46  ;; Ka2
        LDR.N    R4,??DataTable47  ;; Kb2
        MOVS     R5,#+5
//  476     Ka1[i] = *p;                         // 恢复原来的 A 通道低位误差校正系数
??Load_Param_9:
        LDRH     R6,[R0, #+0]
        STRB     R6,[R1], #+1
//  477     Kb1[i] =(*p++ >>8);                  // 恢复原来的 B 通道低位误差校正系数
        LSRS     R6,R6,#+8
        STRB     R6,[R2], #+1
//  478     Ka2[i] = *p++;                       // 恢复原来的 A 通道增益误差校正系数
        LDRH     R6,[R0, #+2]!
        STRH     R6,[LR], #+2
//  479     Kb2[i] = *p++;                       // 加载之前的 B 通道增益误差校正系数
        LDRH     R6,[R0, #+2]!
        STRH     R6,[R4], #+2
//  480     Ka3[i] = *p;                         // 恢复原来的 A 通道高位误差校正系数
        LDRH     R6,[R0, #+2]!
        STRB     R6,[R3], #+1
//  481     Kb3[i] =(*p++ >>8);                  // 恢复原来的 B 通道高位误差校正系数
        LDRH     R6,[R0, #+0]
        LSRS     R6,R6,#+8
        STRB     R6,[R12], #+1
        LDRH     R6,[R0, #+2]!
        STRB     R6,[R1], #+1
        LDRH     R6,[R0, #+0]
        LSRS     R6,R6,#+8
        STRB     R6,[R2], #+1
        LDRH     R6,[R0, #+2]!
        STRH     R6,[LR], #+2
        LDRH     R6,[R0, #+2]!
        STRH     R6,[R4], #+2
        LDRH     R6,[R0, #+2]!
        STRB     R6,[R3], #+1
        LDRH     R6,[R0], #+2
        LSRS     R6,R6,#+8
        STRB     R6,[R12], #+1
//  482   }
        SUBS     R5,R5,#+1
        BNE.N    ??Load_Param_9
//  483   V_Trigg[A].Value = *p++;
        LDR.N    R1,??DataTable48  ;; V_Trigg
        LDRSH    R2,[R0, #+0]
        STRH     R2,[R1, #+0]
//  484   V_Trigg[B].Value = *p++;               // 恢复原来A,B通道触发阈值
        LDRSH    R2,[R0, #+2]!
        STRH     R2,[R1, #+4]
//  485   return OK;
        MOVS     R0,#+0
??Load_Param_1:
        ADD      SP,SP,#+24
        CFI CFA R13+16
        POP      {R4-R6,PC}       ;; return
        DATA
??Load_Param_0:
        DC32     SecBuff
        CFI EndBlock cfiBlock10
//  486 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable38:
        DC32     Current

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable39:
        DC32     Detail

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable40:
        DC32     Title

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable41:
        DC32     Meter + 4

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable42:
        DC32     Ka1

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable43:
        DC32     Kb1

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable44:
        DC32     Ka3

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable45:
        DC32     Kb3

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable46:
        DC32     Ka2

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable47:
        DC32     Kb2

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable48:
        DC32     V_Trigg
//  487 /*******************************************************************************
//  488  Save_Parameter: 保存当前的工作参数                          Return: 0= Success
//  489 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function Save_Param
        THUMB
//  490 u8 Save_Param(void)             // 保存工作参数表文件
//  491 {
Save_Param:
        PUSH     {R4-R9,LR}
        CFI R14 Frame(CFA, -4)
        CFI R9 Frame(CFA, -8)
        CFI R8 Frame(CFA, -12)
        CFI R7 Frame(CFA, -16)
        CFI R6 Frame(CFA, -20)
        CFI R5 Frame(CFA, -24)
        CFI R4 Frame(CFA, -28)
        CFI CFA R13+28
        SUB      SP,SP,#+28
        CFI CFA R13+56
//  492   u8  Sum = 0, Filename[12], Versions = 0x06; 
        MOVS     R4,#+0
//  493   u16 i, Tmp[2];
//  494   u16* p =(u16*)SecBuff;
//  495   
//  496   u16 pCluster[3];
//  497   u32 pDirAddr[1]; 
//  498 
//  499   Word2Hex(Filename, __GetDev_SN());
        BL       __GetDev_SN
        MOVS     R1,R0
        ADD      R0,SP,#+16
        BL       Word2Hex
//  500   Filename[8] = 'W'; Filename[9] = 'P'; Filename[10] = 'T';
        ADD      R6,SP,#+16
        MOVS     R0,#+87
        STRB     R0,[R6, #+8]
        MOVS     R0,#+80
        STRB     R0,[R6, #+9]
        MOVS     R0,#+84
        STRB     R0,[R6, #+10]
//  501   switch (__OpenFileRd(SecBuff, Filename, pCluster, pDirAddr)){
        LDR.N    R5,??Save_Param_0  ;; SecBuff
        ADD      R3,SP,#+0
        ADD      R2,SP,#+4
        ADD      R1,SP,#+16
        MOVS     R0,R5
        BL       __OpenFileRd
        CBZ      R0,??Save_Param_1
        CMP      R0,#+4
        BEQ.N    ??Save_Param_2
        B.N      ??Save_Param_3
//  502   case OK:                                                     // 原WPT文件存在
//  503     Tmp[0] = *pCluster;
??Save_Param_1:
        LDRH     R0,[SP, #+4]
        STRH     R0,[SP, #+12]
//  504     Filename[8] = 'B'; Filename[9] = 'A'; Filename[10] = 'K';  // 转成BAK文件
        MOVS     R0,#+66
        STRB     R0,[R6, #+8]
        MOVS     R0,#+65
        STRB     R0,[R6, #+9]
        MOVS     R0,#+75
        STRB     R0,[R6, #+10]
//  505     if(__OpenFileWr(SecBuff, Filename, pCluster, pDirAddr)!= OK) return DISK_ERR;
        ADD      R3,SP,#+0
        ADD      R2,SP,#+4
        ADD      R1,SP,#+16
        MOVS     R0,R5
        BL       __OpenFileWr
        CBZ      R0,??Save_Param_4
??Save_Param_5:
        MOVS     R0,#+10
        B.N      ??Save_Param_6
//  506     if(__ReadFileSec(SecBuff, Tmp     )!= OK) return RD_ERR;
??Save_Param_4:
        ADD      R1,SP,#+12
        MOVS     R0,R5
        BL       __ReadFileSec
        CBZ      R0,??Save_Param_7
        MOVS     R0,#+8
        B.N      ??Save_Param_6
//  507     if(__ProgFileSec(SecBuff, pCluster)!= OK) return WR_ERR;  // 保存BAK文件
??Save_Param_7:
        ADD      R1,SP,#+4
        MOVS     R0,R5
        BL       __ProgFileSec
        CMP      R0,#+0
        BNE.W    ??Save_Param_3
//  508     if(__CloseFile(SecBuff, 512, pCluster, pDirAddr)!= OK) return WR_ERR;/**/
??Save_Param_8:
        ADD      R3,SP,#+0
        ADD      R2,SP,#+4
        MOV      R1,#+512
        MOVS     R0,R5
        BL       __CloseFile
        CMP      R0,#+0
        BNE.W    ??Save_Param_3
//  509   case NEW:                                                    // 原WPT文件不存在
//  510     Filename[8] = 'W'; Filename[9] = 'P'; Filename[10] = 'T';  // 创建WPT文件
??Save_Param_2:
        MOVS     R0,#+87
        STRB     R0,[R6, #+8]
        MOVS     R0,#+80
        STRB     R0,[R6, #+9]
        MOVS     R0,#+84
        STRB     R0,[R6, #+10]
//  511     if(__OpenFileWr(SecBuff, Filename, pCluster, pDirAddr)!= OK) return DISK_ERR;
        ADD      R3,SP,#+0
        ADD      R2,SP,#+4
        ADD      R1,SP,#+16
        MOVS     R0,R5
        BL       __OpenFileWr
        CMP      R0,#+0
        BNE.N    ??Save_Param_5
//  512     memset(SecBuff, 0, 512);
        MOV      R1,#+512
        MOVS     R0,R5
        BL       __aeabi_memclr4
//  513     *p++ =(Current <<8)+ Versions;           // 保存参数表版本号及当前的 Title
        LDR.N    R0,??Save_Param_0+0x4  ;; Current
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+8
        ADDS     R0,R0,#+6
        STRH     R0,[R5, #+0]
//  514     for(i=0; i<7; i++){ 
//  515       *p++ =(Detail[i*2+1]<<8)+ Detail[i*2]; // 保存当前的 Detail
        LDR.N    R1,??Save_Param_0+0x8  ;; Detail
        LDRB     R0,[R1, #+1]
        LDRB     R2,[R1], #+2
        ADD      R0,R2,R0, LSL #+8
        STRH     R0,[R5, #+2]
        ADDS     R0,R5,#+4
        MOVS     R2,#+2
??Save_Param_9:
        LDRB     R3,[R1, #+1]
        LDRB     R12,[R1, #+0]
        ADD      R3,R12,R3, LSL #+8
        STRH     R3,[R0], #+2
        LDRB     R3,[R1, #+3]
        LDRB     R12,[R1, #+2]
        ADD      R3,R12,R3, LSL #+8
        STRH     R3,[R0], #+2
        LDRB     R3,[R1, #+5]
        LDRB     R12,[R1, #+4]
        ADD      R3,R12,R3, LSL #+8
        STRH     R3,[R0], #+2
//  516     }
        ADDS     R1,R1,#+6
        SUBS     R2,R2,#+1
        BNE.N    ??Save_Param_9
//  517     for(i=0; i<13; i++){                     // 保存显示菜单中各个对应项的值
//  518       *p++ = Title[i][0].Value;
        LDR.N    R1,??Save_Param_0+0xC  ;; Title
        LDRH     R2,[R1, #+16]
        STRH     R2,[R0], #+2
//  519       *p++ = Title[i][1].Value;
        LDRH     R2,[R1, #+36]
        STRH     R2,[R0], #+2
//  520       *p++ = Title[i][2].Value;
        LDRH     R2,[R1, #+56]
        STRH     R2,[R0], #+2
//  521       *p++ = Title[i][3].Value;
        LDRH     R2,[R1, #+76]
        STRH     R2,[R0], #+2
        ADDS     R1,R1,#+96
        MOVS     R2,#+6
??Save_Param_10:
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
        LDRH     R3,[R1], #+20
        STRH     R3,[R0], #+2
//  522     }
        SUBS     R2,R2,#+1
        BNE.N    ??Save_Param_10
//  523     for(i=0; i<9; i++){
        LDR.N    R1,??Save_Param_0+0x10  ;; Meter + 4
        MOVS     R2,#+3
//  524       *p++ =(Meter[i].Track<<8)+ Meter[i].Item; // 保存测量项目及测量对象
??Save_Param_11:
        LDRB     R3,[R1, #+0]
        LDRB     R12,[R1, #+1]
        ADD      R3,R12,R3, LSL #+8
        STRH     R3,[R0], #+2
        LDRB     R3,[R1, #+12]
        LDRB     R12,[R1, #+13]
        ADD      R3,R12,R3, LSL #+8
        STRH     R3,[R0], #+2
        LDRB     R3,[R1, #+24]
        LDRB     R12,[R1, #+25]
        ADD      R3,R12,R3, LSL #+8
        STRH     R3,[R0], #+2
//  525     }
        ADDS     R1,R1,#+36
        SUBS     R2,R2,#+1
        BNE.N    ??Save_Param_11
//  526     for(i=0; i<10; i++){
        LDR.N    R1,??Save_Param_0+0x14  ;; Kb1
        LDR.N    R2,??Save_Param_0+0x18  ;; Ka1
        LDR.N    R3,??Save_Param_0+0x1C  ;; Kb3
        LDR.W    R12,??Save_Param_0+0x20  ;; Ka3
        LDR.W    LR,??Save_Param_0+0x24  ;; Ka2
        LDR.N    R6,??Save_Param_0+0x28  ;; Kb2
        MOVS     R7,#+5
//  527       *p++ = (Kb1[i]<<8)+ Ka1[i];             // 保存当前 A,B 通道低位误差校正系数
??Save_Param_12:
        LDRSB    R8,[R1], #+1
        LDRSB    R9,[R2], #+1
        ADD      R8,R9,R8, LSL #+8
        STRH     R8,[R0], #+2
//  528       *p++ =  Ka2[i];                         // 保存当前 A 通道增益误差校正系数
        LDRH     R8,[LR], #+2
        STRH     R8,[R0], #+2
//  529       *p++ =  Kb2[i];                         // 保存当前 B 通道增益误差校正系数
        LDRH     R8,[R6], #+2
        STRH     R8,[R0], #+2
//  530       *p++ = (Kb3[i]<<8)+ Ka3[i];             // 保存当前 A,B 通道高位误差校正系数
        LDRSB    R8,[R3], #+1
        LDRSB    R9,[R12], #+1
        ADD      R8,R9,R8, LSL #+8
        STRH     R8,[R0], #+2
        LDRSB    R8,[R1], #+1
        LDRSB    R9,[R2], #+1
        ADD      R8,R9,R8, LSL #+8
        STRH     R8,[R0], #+2
        LDRH     R8,[LR], #+2
        STRH     R8,[R0], #+2
        LDRH     R8,[R6], #+2
        STRH     R8,[R0], #+2
        LDRSB    R8,[R3], #+1
        LDRSB    R9,[R12], #+1
        ADD      R8,R9,R8, LSL #+8
        STRH     R8,[R0], #+2
//  531     }
        SUBS     R7,R7,#+1
        BNE.N    ??Save_Param_12
//  532     *p++ = V_Trigg[A].Value;
        LDR.N    R1,??Save_Param_0+0x2C  ;; V_Trigg
        LDRH     R2,[R1, #+0]
        STRH     R2,[R0, #+0]
//  533     *p++ = V_Trigg[B].Value;                  // 保存当前A,B通道触发阈值   
        LDRH     R1,[R1, #+4]
        STRH     R1,[R0, #+2]!
//  534     for(i=0; i<511; i++)  Sum += SecBuff[i];  // 计算参数表校验和
        MOVS     R0,R5
        MOVS     R1,#+73
??Save_Param_13:
        LDRB     R2,[R0], #+1
        ADDS     R2,R2,R4
        UXTB     R2,R2
        LDRB     R3,[R0], #+1
        ADDS     R2,R3,R2
        UXTB     R2,R2
        LDRB     R3,[R0], #+1
        ADDS     R2,R3,R2
        UXTB     R2,R2
        LDRB     R3,[R0], #+1
        ADDS     R2,R3,R2
        UXTB     R2,R2
        LDRB     R3,[R0], #+1
        ADDS     R2,R3,R2
        UXTB     R2,R2
        LDRB     R3,[R0], #+1
        ADDS     R2,R3,R2
        UXTB     R2,R2
        LDRB     R3,[R0], #+1
        ADDS     R4,R3,R2
        UXTB     R4,R4
        SUBS     R1,R1,#+1
        BNE.N    ??Save_Param_13
//  535     SecBuff[511] = (~Sum)+ 1;
        MVNS     R0,R4
        ADDS     R0,R0,#+1
        STRB     R0,[R5, #+511]
//  536     if(__ProgFileSec(SecBuff, pCluster)!= OK) return WR_ERR; // 写入数据
        ADD      R1,SP,#+4
        MOVS     R0,R5
        BL       __ProgFileSec
        CBNZ     R0,??Save_Param_3
//  537     if(__CloseFile(SecBuff, 512, pCluster, pDirAddr)!= OK) return WR_ERR;
??Save_Param_14:
        ADD      R3,SP,#+0
        ADD      R2,SP,#+4
        MOV      R1,#+512
        MOVS     R0,R5
        BL       __CloseFile
        CBZ      R0,??Save_Param_6
//  538     return OK;
//  539     default:  return WR_ERR;
??Save_Param_3:
        MOVS     R0,#+9
??Save_Param_6:
        ADD      SP,SP,#+28
        CFI CFA R13+28
        POP      {R4-R9,PC}       ;; return
        DATA
??Save_Param_0:
        DC32     SecBuff
        DC32     Current
        DC32     Detail
        DC32     Title
        DC32     Meter + 4
        DC32     Kb1
        DC32     Ka1
        DC32     Kb3
        DC32     Ka3
        DC32     Ka2
        DC32     Kb2
        DC32     V_Trigg
        CFI EndBlock cfiBlock11
//  540   }
//  541 }

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "FILE    DAT">`:
        DATA
        DC8 "FILE    DAT"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "FILE    DAT">_1`:
        DATA
        DC8 "FILE    DAT"
        DC8 0, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "IMAG    BMP">`:
        DATA
        DC8 "IMAG    BMP"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "DATA    BUF">`:
        DATA
        DC8 "DATA    BUF"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "DATA    BUF">_1`:
        DATA
        DC8 "DATA    BUF"
        DC8 0, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "DATA    CSV">`:
        DATA
        DC8 "DATA    CSV"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "TRACK1 ">`:
        DATA
        DC8 "TRACK1 "

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "TRACK2 ">`:
        DATA
        DC8 "TRACK2 "

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "TRACK3,TRACK4,\\r\\n">`:
        DATA
        DC8 "TRACK3,TRACK4,\015\012"
        DC8 0, 0, 0

        END
//  542 
//  543 /******************************** END OF FILE *********************************/
//  544 
// 
// 1 932 bytes in section .data
//   116 bytes in section .rodata
// 4 338 bytes in section .text
// 
// 4 338 bytes of CODE  memory
//   116 bytes of CONST memory
// 1 932 bytes of DATA  memory
//
//Errors: none
//Warnings: none
