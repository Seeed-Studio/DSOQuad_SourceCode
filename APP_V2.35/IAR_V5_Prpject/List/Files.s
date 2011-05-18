///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  13:45:31 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\APP_V2.32\source\Files.c                      /
//    Command line =  E:\DS0203\APP_V2.32\source\Files.c -lA                  /
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
//    List file    =  E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\Files.s         /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Files

        EXTERN Current
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
        EXTERN __Disk_Buff_RD
        EXTERN __Disk_Buff_WR
        EXTERN __LCD_GetPixl
        EXTERN __Param_Area_RD
        EXTERN __Param_Area_WR
        EXTERN __Point_SCR
        EXTERN __aeabi_memclr4
        EXTERN __aeabi_memcpy
        EXTERN u8ToDec3

        PUBLIC BMP_Color
        PUBLIC ClusterNum
        PUBLIC Color_Num
        PUBLIC Count
        PUBLIC DirSecNum
        PUBLIC DiskStart
        PUBLIC FAT_Size16
        PUBLIC FAT_Size32
        PUBLIC FileBuff
        PUBLIC File_Addr
        PUBLIC File_Size
        PUBLIC Hidden_Sec
        PUBLIC Load_Dat
        PUBLIC Load_Parameter
        PUBLIC MaxNum
        PUBLIC Offset
        PUBLIC Open_File
        PUBLIC Root_Addr
        PUBLIC RsvdSecCnt
        PUBLIC Save_Bmp
        PUBLIC Save_Dat
        PUBLIC Save_Parameter
        PUBLIC SecBuff
        PUBLIC SecPerClus
        PUBLIC SectorSize
        
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
        
// E:\DS0203\APP_V2.32\source\Files.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : file.c  
//    3  Version   : DS203_APP Ver 2.3x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include <string.h>
//    6 #include "Interrupt.h"
//    7 #include "Function.h"
//    8 #include "Process.h"
//    9 #include "BIOS.h"
//   10 #include "File.h"
//   11 #include "Draw.h"
//   12 #include "Menu.h"
//   13 
//   14 /*******************************************************************************
//   15 
//   16 U盘导引扇区内容：0x00      如果为 0xEB 或 0xE9 则表示该扇区同时也是逻辑分区零扇区
//   17                  0x01C6~0x01C9 4字节为逻辑分区开始位置（高位在后）  DiskStart    
//   18 
//   19 分区零扇区内容：0x000B,0x000C 2字节该盘扇区字节长度（高位在后）    SectorsLen   
//   20                        0x000D 1字节该盘每簇的扇区数（2的整数次幂） SecPerClus   
//   21                 0x000E,0x000F 2字节该盘的保留扇区数（高位在后）    RsvdSecCnt    
//   22 （FAT16）       0x0016,0x0017 2字节 FAT占用的扇区数（高位在后）    FAT_Size16   FAT32时该值为 0x0000
//   23                 0x001C~0x001F 4字节该盘的隐藏扇区数（高位在后）    Hidden_Sec    
//   24 （FAT32）       0x0024,0x0025 2字节 FAT占用的扇区数（高位在后）    FAT_Size32   
//   25 
//   26 FAT表的长度   ：FAT_LEN   = FAT_Size16 ×SectorsLen           
//   27 FAT1开始扇区  ：FAT1_Sect = DiskStart + RsvdSecCnt           
//   28 FAT2开始扇区  ：FAT2_Sect = FAT1_Sect + FAT_Size16           
//   29 根目录开始扇区：Root_Sect = FAT2_Sect + FAT_Size16           
//   30 根目录开始地址：Root_Addr = Root_Sect ×SectorsLen   
//   31 
//   32 根目录扇区内容：Root_Addr + 0x0020 开始，每条目录项长度为 0x20，
//   33                 FAT16根目录占用扇区数 SecPerRoot = 0x20 
//   34                 FAT32根目录占用扇区数 SecPerRoot = 0x01 × SecPerClus 
//   35 
//   36 目录项中的内容：0x00~0x07 8字节文件名   
//   37                 0x08~0x0A 3字节扩展名
//   38                 0x16,0x17 2字节最近修改时间（ = Hour << 11 + Minute << 5 + Second >> 1 ）
//   39                 0x18,0x19 2字节最近修改日期（ =（ Year - 1980 ）<< 9 + Month << 5 + Day ）
//   40 （FAT32）       0x14,0x15 文件开始簇号Bit 16~31（高位字节在后）Cluster_Hi
//   41 （FAT16）       0x1A,0x1B 文件开始簇号Bit  0~15（高位字节在后）Cluster     0x12E5
//   42                 0x1C-0x1F 4字节的文件字节长度 （高位在后）
//   43                   
//   44 文件开始地址  ：File_Addr =（ Root_Sect + SecPerRoot +（Cluster -0x02）×SecPerClus ）×Sectors_LEN
//   45 
//   46 *******************************************************************************/
//   47 u32 DiskStart, Hidden_Sec, Root_Addr, ClusterNum, File_Addr, File_Size; 

        SECTION `.bss`:DATA:NOROOT(1)
//   48 u16 RsvdSecCnt, SectorSize, FAT_Size16, FAT_Size32; 
FAT_Size32:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(1)
//   49 u16 SecPerClus, /*DirFliePtr, DirFlieSec, */DirSecNum, MaxNum;
MaxNum:
        DS8 2
//   50 u8  SecBuff[512];
//   51 u8  FileBuff[1200];

        SECTION `.bss`:DATA:NOROOT(2)
//   52 u32 Offset, Count;
Offset:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
Count:
        DS8 4

        SECTION `.data`:DATA:NOROOT(2)
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
RsvdSecCnt:
        DC8 0, 0
SectorSize:
        DC8 0, 0
FAT_Size16:
        DC8 0, 0
SecPerClus:
        DC8 0, 0
DirSecNum:
        DC8 0, 0
        DC8 0, 0
DiskStart:
        DC8 0, 0, 0, 0
Hidden_Sec:
        DC8 0, 0, 0, 0
Root_Addr:
        DC8 0, 0, 0, 0
ClusterNum:
        DC8 0, 0, 0, 0
File_Addr:
        DC8 0, 0, 0, 0
File_Size:
        DC8 0, 0, 0, 0
//   53 u16 BMP_Color[16] = { WHT,  CYAN,  CYAN_,  YEL,   
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
//   54                       YEL_, PURPL, PURPL_, GRN,    
//   55                       GRN_, GRAY,  ORANGE, BLUE,    
//   56                       RED,  BLACK, BLACK,  BLACK,}; 
//   57 
//   58   
//   59 #define WHT        0xFFFF
//   60 #define CYAN       0xFFE0
//   61 #define CYAN_      0xBDE0
//   62 #define YEL        0x07FF
//   63 #define YEL_       0x05F7
//   64 #define PURPL      0xF81F
//   65 #define PURPL_     0xB817
//   66 #define GRN        0x07E0
//   67 #define GRN_       0x05E0
//   68 #define GRAY       0x7BEF   
//   69 #define ORANGE     0x051F
//   70 #define BLUE       0xF800
//   71 #define RED        0x001F
//   72 #define BLACK      0x0000
//   73 
//   74 /*******************************************************************************
//   75  打开指定扩展名的文件            输入：文件扩展名             返回值：0x00=成功 
//   76 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Open_File
        THUMB
//   77 u8 Open_File(u8 FileNum, u8 *ExtName)
//   78 {
Open_File:
        PUSH     {R4-R8,LR}
        CFI R14 Frame(CFA, -4)
        CFI R8 Frame(CFA, -8)
        CFI R7 Frame(CFA, -12)
        CFI R6 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
        SUB      SP,SP,#+16
        CFI CFA R13+40
        MOVS     R5,R0
        MOVS     R4,R1
//   79   u8 i, j, k; 
//   80   u16 SectorCnt;
//   81   u8 FileName[12]="FILE    BMP", Num[4];
        ADD      R0,SP,#+4
        LDR.N    R1,??Open_File_0  ;; `?<Constant "FILE    BMP">`
        MOVS     R2,#+12
        BL       __aeabi_memcpy
//   82   
//   83                // ------------生成文件名------------ //      
//   84   u8ToDec3(Num, FileNum);
        MOVS     R1,R5
        ADD      R0,SP,#+0
        BL       u8ToDec3
//   85   FileName[4] = Num[0];
        LDRB     R0,[SP, #+0]
        STRB     R0,[SP, #+8]
//   86   FileName[5] = Num[1];
        ADD      R0,SP,#+4
        ADD      R1,SP,#+0
        LDRB     R2,[R1, #+1]
        STRB     R2,[R0, #+5]
//   87   FileName[6] = Num[2];
        LDRB     R1,[R1, #+2]
        STRB     R1,[SP, #+10]
//   88   FileName[8] = ExtName[0];
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+8]
//   89   FileName[9] = ExtName[1];
        LDRB     R1,[R4, #+1]
        STRB     R1,[R0, #+9]
//   90   FileName[10]= ExtName[2];
        LDRB     R0,[R4, #+2]
        STRB     R0,[SP, #+14]
//   91   
//   92                // ------------读取U盘参数----------- //      
//   93   DiskStart =0;
        LDR.W    R4,??DataTable16  ;; SecBuff
        MOVS     R0,#+0
        STR      R0,[R4, #+524]
//   94   DirSecNum = 0x20;             
        MOVS     R0,#+32
        STRH     R0,[R4, #+520]
//   95   __Disk_Buff_RD(SecBuff, 0, 256);
        MOV      R2,#+256
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       __Disk_Buff_RD
//   96   SectorSize =(SecBuff[0x0C]<<8)+(SecBuff[0x0B]);     // 0200
        LDRB     R0,[R4, #+12]
        LDRB     R1,[R4, #+11]
        ADD      R0,R1,R0, LSL #+8
        STRH     R0,[R4, #+514]
//   97   SecPerClus = SecBuff[0x0D];                            // 01
        LDRB     R0,[R4, #+13]
        STRH     R0,[R4, #+518]
//   98   RsvdSecCnt =(SecBuff[0x0F]<<8)+(SecBuff[0x0E]);     // 0008
        LDRB     R0,[R4, #+15]
        LDRB     R1,[R4, #+14]
        ADD      R0,R1,R0, LSL #+8
        STRH     R0,[R4, #+512]
//   99   FAT_Size16 =(SecBuff[0x17]<<8)+(SecBuff[0x16]);     // 000C
        LDRB     R0,[R4, #+23]
        LDRB     R1,[R4, #+22]
        ADD      R0,R1,R0, LSL #+8
        STRH     R0,[R4, #+516]
//  100   Hidden_Sec =(SecBuff[0x1F]<<24)+(SecBuff[0x1E]<<16)
//  101     +(SecBuff[0x1D]<<8)+(SecBuff[0x1C]);              // 0000
        LDRB     R0,[R4, #+31]
        LDRB     R1,[R4, #+30]
        LSLS     R1,R1,#+16
        ADD      R0,R1,R0, LSL #+24
        LDRB     R1,[R4, #+29]
        ADD      R0,R0,R1, LSL #+8
        LDRB     R1,[R4, #+28]
        ADDS     R0,R1,R0
        STR      R0,[R4, #+528]
        LDR      R0,[R4, #+524]
        LDRH     R1,[R4, #+512]
        ADDS     R0,R1,R0
        LDRH     R1,[R4, #+516]
        ADD      R0,R0,R1, LSL #+1
        LDRH     R1,[R4, #+514]
        MULS     R1,R0,R1
        STR      R1,[R4, #+532]
//  102 
//  103                // ------------读取根目录----------- //      
//  104   Root_Addr =(DiskStart + RsvdSecCnt + 2*FAT_Size16)*SectorSize; // 4000 
//  105   __Disk_Buff_RD(SecBuff, Root_Addr, 512);
        MOV      R2,#+512
        MOVS     R0,R4
        BL       __Disk_Buff_RD
//  106 
//  107                // ------------查找文件名----------- //      
//  108   for(SectorCnt =0; SectorCnt < DirSecNum; SectorCnt++){
        MOVS     R5,#+0
        MOVS     R6,#+0
        B.N      ??Open_File_1
//  109     __Disk_Buff_RD(SecBuff, Root_Addr + SectorCnt*512, 512);
//  110     for(i=0; i<16; i++){
??Open_File_2:
        ADDS     R0,R0,#+1
        ADDS     R1,R1,#+32
        UXTB     R2,R0
        CMP      R2,#+16
        BCC.N    ??Open_File_3
        ADDS     R5,R5,#+1
        UXTH     R5,R5
        ADD      R6,R6,#+512
??Open_File_1:
        LDRH     R1,[R4, #+520]
        CMP      R5,R1
        BCS.N    ??Open_File_4
        MOV      R2,#+512
        LDR      R0,[R4, #+532]
        ADDS     R1,R6,R0
        MOVS     R0,R4
        BL       __Disk_Buff_RD
        MOVS     R0,#+0
        MOVS     R1,R4
//  111       if(SecBuff[i*32] == 0xE5)  k = 0xFF;  // 已删除的文件项
??Open_File_3:
        LDRB     R2,[R1, #+0]
        CMP      R2,#+229
        BNE.N    ??Open_File_5
        MOVS     R2,#+255
        B.N      ??Open_File_6
//  112       else                       k = 0;     // 正常的文件项
??Open_File_5:
        MOVS     R2,#+0
//  113       for(j=0; j<11; j++){
??Open_File_6:
        MOVS     R3,R1
        ADD      R12,SP,#+4
        MOV      LR,#+11
//  114         if(SecBuff[i*32+j] != FileName[j])  k |= 0xFF; // 
??Open_File_7:
        LDRB     R7,[R3, #+0]
        LDRB     R8,[R12, #+0]
        CMP      R7,R8
        IT       NE 
        MOVNE    R2,#+255
//  115       }
        ADD      R12,R12,#+1
        ADDS     R3,R3,#+1
        SUBS     LR,LR,#+1
        BNE.N    ??Open_File_7
//  116       if(k == 0) {                              // File is found
        CMP      R2,#+0
        BNE.N    ??Open_File_2
//  117         
//  118                // ------计算文件大小及存放地址----- //      
//  119         ClusterNum =((SecBuff[i*32+0x1B]<<8)+(SecBuff[i*32+0x1A])); // 00E5
        UXTB     R0,R0
        ADD      R0,R4,R0, LSL #+5
        LDRB     R1,[R0, #+27]
        LDRB     R2,[R0, #+26]
        ADD      R1,R2,R1, LSL #+8
        STR      R1,[R4, #+536]
//  120         File_Addr  = Root_Addr +(DirSecNum +(ClusterNum -2)*SecPerClus)*512;// 4000+(20+(E5-2))*200
        LDR      R1,[R4, #+532]
        LDRH     R2,[R4, #+520]
        LDR      R3,[R4, #+536]
        SUBS     R3,R3,#+2
        LDRH     R12,[R4, #+518]
        MLA      R2,R3,R12,R2
        ADD      R1,R1,R2, LSL #+9
        STR      R1,[R4, #+540]
//  121         File_Size  =((SecBuff[i*32+0x1C])+(SecBuff[i*32+0x1D]<<8)+
//  122                     (SecBuff[i*32+0x1E]<<16)+(SecBuff[i*32+0x1F]<<24));
        LDRB     R1,[R0, #+28]
        LDRB     R2,[R0, #+29]
        ADD      R1,R1,R2, LSL #+8
        LDRB     R2,[R0, #+30]
        ADD      R1,R1,R2, LSL #+16
        LDRB     R0,[R0, #+31]
        ADD      R0,R1,R0, LSL #+24
        STR      R0,[R4, #+544]
//  123         return 0;
        MOVS     R0,#+0
        B.N      ??Open_File_8
//  124       }
//  125     }
//  126   }
//  127   return 0xFF;
??Open_File_4:
        MOVS     R0,#+255
??Open_File_8:
        ADD      SP,SP,#+16
        CFI CFA R13+24
        POP      {R4-R8,PC}       ;; return
        Nop      
        DATA
??Open_File_0:
        DC32     `?<Constant "FILE    BMP">`
        CFI EndBlock cfiBlock0
//  128 }
//  129 /*******************************************************************************
//  130 Save_Dat: 保存当前屏幕显示图像原始数据    输入：文件编号     返回值：0x00=成功 
//  131 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function Save_Dat
        THUMB
//  132 u8 Save_Dat(u8 FileNum)
//  133 {
Save_Dat:
        PUSH     {R4-R8,LR}
        CFI R14 Frame(CFA, -4)
        CFI R8 Frame(CFA, -8)
        CFI R7 Frame(CFA, -12)
        CFI R6 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
//  134   u16 i, j, Rvalue; 
//  135   
//  136   Rvalue = Open_File(FileNum, "DAT");  // 2 KB data lenght : 4 *300 = 1.2KBytes
        ADR.N    R1,??Save_Dat_0  ;; "DAT"
        BL       Open_File
//  137   if(Rvalue != 0) return Rvalue;
        MOVS     R1,R0
        BNE.N    ??Save_Dat_1
//  138   
//  139   for(j=0; j<4; j++){
        LDR.N    R4,??Save_Dat_0+0x4  ;; TrackBuff
        LDR.N    R5,??Save_Dat_0+0x8  ;; Title + 76
        MOVS     R6,#+0
        MOVS     R7,#+4
        LDR.W    R8,??DataTable16  ;; SecBuff
//  140     for(i=0; i<299; i++){
//  141       SecBuff[i] = TrackBuff[i*4 + j];
??Save_Dat_2:
        LDRB     R0,[R4, #+0]
        STRB     R0,[R8, #+0]
        ADD      R0,R8,#+1
        ADDS     R1,R4,#+4
        MOVS     R2,#+149
??Save_Dat_3:
        LDRB     R3,[R1], #+4
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+4
        STRB     R3,[R0], #+1
//  142     }
        SUBS     R2,R2,#+1
        BNE.N    ??Save_Dat_3
//  143     SecBuff[299] = Title[j][POSI].Value;
        LDRH     R0,[R5], #+80
        STRB     R0,[R8, #+299]
//  144     __Disk_Buff_WR(SecBuff, File_Addr + j*512);
        LDR      R0,[R8, #+540]
        ADDS     R1,R6,R0
        MOV      R0,R8
        BL       __Disk_Buff_WR
//  145     __Disk_Buff_WR(SecBuff + 256, File_Addr + 256 +j*512);
        LDR      R0,[R8, #+540]
        ADDS     R0,R0,R6
        ADD      R1,R0,#+256
        ADD      R0,R8,#+256
        BL       __Disk_Buff_WR
//  146   }
        ADD      R6,R6,#+512
        ADDS     R4,R4,#+1
        SUBS     R7,R7,#+1
        BNE.N    ??Save_Dat_2
//  147   
//  148   return 0;
        MOVS     R0,#+0
??Save_Dat_1:
        POP      {R4-R8,PC}       ;; return
        Nop      
        DATA
??Save_Dat_0:
        DC8      "DAT"
        DC32     TrackBuff
        DC32     Title + 76
        CFI EndBlock cfiBlock1
//  149 }
//  150 /*******************************************************************************
//  151 Load_Dat: 加载保存过的屏幕图像原始数据    输入：文件编号     返回值：0x00=成功 
//  152 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Load_Dat
        THUMB
//  153 u8 Load_Dat(u8 FileNum)
//  154 {
Load_Dat:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  155   u16  Rvalue;
//  156 
//  157   Rvalue = Open_File(FileNum, "DAT");  // 2 KB data lenght : 4 *300 = 1.2KBytes
        ADR.N    R1,??Load_Dat_0  ;; "DAT"
        BL       Open_File
//  158   if(Rvalue != 0) return Rvalue;
        MOVS     R1,R0
        BNE.N    ??Load_Dat_1
//  159   
//  160   __Disk_Buff_RD(FileBuff,         File_Addr,     300);
        LDR.W    R4,??DataTable16  ;; SecBuff
        MOV      R2,#+300
        LDR      R1,[R4, #+540]
        ADD      R0,R4,#+580
        BL       __Disk_Buff_RD
//  161   
//  162   __Disk_Buff_RD(FileBuff+300,     File_Addr+2*256, 300);
        MOV      R2,#+300
        LDR      R0,[R4, #+540]
        ADD      R1,R0,#+512
        ADD      R0,R4,#+880
        BL       __Disk_Buff_RD
//  163 
//  164   __Disk_Buff_RD(FileBuff+600,     File_Addr+4*256, 300);
        MOV      R2,#+300
        LDR      R0,[R4, #+540]
        ADD      R1,R0,#+1024
        ADDW     R0,R4,#+1180
        BL       __Disk_Buff_RD
//  165 
//  166   __Disk_Buff_RD(FileBuff+900,     File_Addr+6*256, 300);
        MOV      R2,#+300
        LDR      R0,[R4, #+540]
        ADD      R1,R0,#+1536
        ADD      R0,R4,#+1480
        BL       __Disk_Buff_RD
//  167   
//  168   return 0;
        MOVS     R0,#+0
??Load_Dat_1:
        POP      {R4,PC}          ;; return
        DATA
??Load_Dat_0:
        DC8      "DAT"
        CFI EndBlock cfiBlock2
//  169 }
//  170 /*******************************************************************************
//  171 Save_Bmp: 保存当前屏幕显示图像为BMP格式    输入：文件编号     返回值：0x00=成功 
//  172 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Save_Bmp
        THUMB
//  173 u8 Save_Bmp(u8 FileNum)
//  174 {
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
        SUB      SP,SP,#+4
        CFI CFA R13+40
//  175   u16  x=0, y=0, ColorH, ColorL, Rvalue;
//  176   u8   i, j, k; 
//  177 
//  178   Rvalue = Open_File(FileNum, "BMP");  // 47 KB data lenght = 256*188 = 48128 Bytes
        ADR.N    R1,??Save_Bmp_0  ;; "BMP"
        BL       Open_File
//  179   if(Rvalue != 0) return Rvalue;
        MOVS     R1,R0
        BNE.W    ??Save_Bmp_1
//  180   __Disk_Buff_RD(SecBuff, File_Addr, 256);
        LDR.W    R11,??DataTable16  ;; SecBuff
        MOV      R2,#+256
        LDR      R1,[R11, #+540]
        MOV      R0,R11
        BL       __Disk_Buff_RD
//  181   
//  182   i = 0x0036; // 调色板存放开始地址
//  183   for(j=0; j<16; ++j){
        ADD      R0,R11,#+548
        ADD      R1,R11,#+54
        MOVS     R2,#+8
//  184     SecBuff[j*4 +i+0]=(BMP_Color[j]& 0xF800)>>8; // Bule
??Save_Bmp_2:
        LDRH     R3,[R0, #+0]
        AND      R3,R3,#0xF800
        LSRS     R3,R3,#+8
        STRB     R3,[R1], #+1
//  185     SecBuff[j*4 +i+1]=(BMP_Color[j]& 0x07E0)>>3; // Green
        LDRH     R3,[R0, #+0]
        AND      R3,R3,#0x7E0
        LSRS     R3,R3,#+3
        STRB     R3,[R1], #+1
//  186     SecBuff[j*4 +i+2]=(BMP_Color[j]& 0x001F)<<3; // Red
        LDRH     R3,[R0], #+2
        LSLS     R3,R3,#+24
        LSRS     R3,R3,#+21
        STRB     R3,[R1], #+1
//  187     SecBuff[j*4 +i+3]= 0;                        // Alpha
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
//  188   }
        SUBS     R2,R2,#+1
        BNE.N    ??Save_Bmp_2
//  189   i = 0x0076; // 图像数据开始存放地址
        MOVS     R4,#+118
//  190   k = 0;
        MOVS     R5,#+0
//  191   for(y=0; y<240; y++){
        MOV      R6,R3
//  192     for(x=0; x<400 ; x+=2){  
??Save_Bmp_3:
        MOVS     R7,#+0
        ADD      R8,R4,R11
//  193       __Point_SCR(x, y);
??Save_Bmp_4:
        UXTH     R1,R6
        UXTH     R0,R7
        BL       __Point_SCR
//  194       ColorH =__LCD_GetPixl();
        BL       __LCD_GetPixl
        MOV      R9,R0
//  195       __Point_SCR(x+1, y);
        UXTH     R1,R6
        ADDS     R0,R7,#+1
        UXTH     R0,R0
        BL       __Point_SCR
//  196       ColorL =__LCD_GetPixl();
        BL       __LCD_GetPixl
        MOV      R10,R0
//  197       SecBuff[i] =(Color_Num(ColorH)<<4)+ Color_Num(ColorL);
        MOV      R0,R9
        BL       Color_Num
        MOV      R9,R0
        MOV      R0,R10
        BL       Color_Num
        ADD      R0,R0,R9, LSL #+4
        STRB     R0,[R8, #+0]
//  198       i++;
        ADDS     R4,R4,#+1
        UXTB     R4,R4
//  199       if(i==0){
        MOVS     R0,R4
        BNE.N    ??Save_Bmp_5
//  200         __Disk_Buff_WR(SecBuff, File_Addr +(k <<8));
        LDR      R0,[R11, #+540]
        ADD      R1,R0,R5, LSL #+8
        MOV      R0,R11
        BL       __Disk_Buff_WR
//  201         Print_Clk(254, 0, (SCRN<<8)+ TEXT1, (k >>2)& 3);    // 进度指示
        ASRS     R0,R5,#+2
        AND      R3,R0,#0x3
        MOVW     R2,#+1290
        MOVS     R1,#+0
        MOVS     R0,#+254
        BL       Print_Clk
//  202         k++;
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  203       }
//  204     }
??Save_Bmp_5:
        ADDS     R7,R7,#+2
        ADD      R8,R8,#+1
        MOV      R1,#+400
        UXTH     R0,R7
        CMP      R0,R1
        BCC.N    ??Save_Bmp_4
//  205   }
        ADDS     R6,R6,#+1
        UXTH     R0,R6
        CMP      R0,#+240
        BCC.N    ??Save_Bmp_3
//  206   __Disk_Buff_WR(SecBuff, File_Addr +(k <<8));
        LDR      R0,[R11, #+540]
        ADD      R1,R0,R5, LSL #+8
        MOV      R0,R11
        BL       __Disk_Buff_WR
//  207   return 0;
        MOVS     R0,#+0
??Save_Bmp_1:
        ADD      SP,SP,#+4
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        DATA
??Save_Bmp_0:
        DC8      "BMP"
        CFI EndBlock cfiBlock3
//  208 }

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Color_Num
        THUMB
//  209 u8 Color_Num(u16 Color)
//  210 {
//  211   if(Color == WHT)                   return 0;
Color_Num:
        MOVW     R1,#+65535
        CMP      R0,R1
        BNE.N    ??Color_Num_0
        MOVS     R0,#+0
        BX       LR
//  212   else if((Color & CYAN  )== CYAN  ) return 1;
??Color_Num_0:
        MOVW     R1,#+65504
        AND      R2,R1,R0
        CMP      R2,R1
        BNE.N    ??Color_Num_1
        MOVS     R0,#+1
        BX       LR
//  213   else if((Color & YEL   )== YEL   ) return 3;
??Color_Num_1:
        LSLS     R1,R0,#+21
        LSRS     R1,R1,#+21
        MOVW     R2,#+2047
        CMP      R1,R2
        BNE.N    ??Color_Num_2
        MOVS     R0,#+3
        BX       LR
//  214   else if((Color & PURPL )== PURPL ) return 5;
??Color_Num_2:
        MOVW     R1,#+63519
        AND      R2,R1,R0
        CMP      R2,R1
        BNE.N    ??Color_Num_3
        MOVS     R0,#+5
        BX       LR
//  215   else if((Color & GRN   )== GRN   ) return 7;
??Color_Num_3:
        AND      R1,R0,#0x7E0
        CMP      R1,#+2016
        BNE.N    ??Color_Num_4
        MOVS     R0,#+7
        BX       LR
//  216   else if((Color & CYAN_ )== CYAN_ ) return 2;
??Color_Num_4:
        MOVW     R1,#+48608
        AND      R2,R1,R0
        CMP      R2,R1
        BNE.N    ??Color_Num_5
        MOVS     R0,#+2
        BX       LR
//  217   else if((Color & YEL_  )== YEL_  ) return 4;
??Color_Num_5:
        MOVW     R1,#+1527
        ANDS     R1,R1,R0
        MOVW     R2,#+1527
        CMP      R1,R2
        BNE.N    ??Color_Num_6
        MOVS     R0,#+4
        BX       LR
//  218   else if((Color & PURPL_)== PURPL_) return 6;
??Color_Num_6:
        MOVW     R1,#+47127
        AND      R2,R1,R0
        CMP      R2,R1
        BNE.N    ??Color_Num_7
        MOVS     R0,#+6
        BX       LR
//  219   else if((Color & GRN_  )== GRN_  ) return 8;
??Color_Num_7:
        AND      R1,R0,#0x5E0
        CMP      R1,#+1504
        BNE.N    ??Color_Num_8
        MOVS     R0,#+8
        BX       LR
//  220   else if((Color & GRAY  )== GRAY  ) return 9;
??Color_Num_8:
        MOVW     R1,#+31727
        AND      R2,R1,R0
        CMP      R2,R1
        BNE.N    ??Color_Num_9
        MOVS     R0,#+9
        BX       LR
//  221   else if((Color & ORANGE)== ORANGE) return 10;
??Color_Num_9:
        MOVW     R1,#+1311
        ANDS     R1,R1,R0
        MOVW     R2,#+1311
        CMP      R1,R2
        BNE.N    ??Color_Num_10
        MOVS     R0,#+10
        BX       LR
//  222   else if((Color & BLUE  )== BLUE  ) return 11;
??Color_Num_10:
        AND      R1,R0,#0xF800
        CMP      R1,#+63488
        BNE.N    ??Color_Num_11
        MOVS     R0,#+11
        BX       LR
//  223   else if((Color & RED   )== RED   ) return 12;
??Color_Num_11:
        AND      R0,R0,#0x1F
        CMP      R0,#+31
        BNE.N    ??Color_Num_12
        MOVS     R0,#+12
        BX       LR
//  224   else                               return 13;
??Color_Num_12:
        MOVS     R0,#+13
??Color_Num_13:
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  225 }
//  226 /*******************************************************************************
//  227 Load_Parameter: 加载之前的工作参数                           Return: 0= Success
//  228 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function Load_Parameter
        THUMB
//  229 u8 Load_Parameter(void)            // 参数区共有4页，每页 256 Byte
//  230 { 
Load_Parameter:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//  231   u8 Versions =0x03, Sum =0;
        MOVS     R5,#+0
//  232   u16 i;
//  233   u16* p = (u16*)SecBuff;
//  234   
//  235   __Param_Area_RD(SecBuff, PAGE_0);
        LDR.N    R4,??DataTable16  ;; SecBuff
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       __Param_Area_RD
//  236  
//  237   if(Versions !=(*p & 0xFF)) return 1;          // 版本出错返回
        LDRH     R0,[R4, #+0]
        UXTB     R0,R0
        CMP      R0,#+3
        BEQ.N    ??Load_Parameter_0
        MOVS     R0,#+1
        B.N      ??Load_Parameter_1
//  238   for(i=0; i<256; ++i) Sum += SecBuff[i];
??Load_Parameter_0:
        MOVS     R0,R4
        MOVS     R1,#+64
??Load_Parameter_2:
        LDRB     R2,[R0], #+1
        ADDS     R2,R2,R5
        UXTB     R2,R2
        LDRB     R3,[R0], #+1
        ADDS     R2,R3,R2
        UXTB     R2,R2
        LDRB     R3,[R0], #+1
        ADDS     R2,R3,R2
        UXTB     R2,R2
        LDRB     R3,[R0], #+1
        ADDS     R5,R3,R2
        UXTB     R5,R5
        SUBS     R1,R1,#+1
        BNE.N    ??Load_Parameter_2
//  239   if(Sum != 0) return 2;                  // 校验和出错返回
        CBZ      R5,??Load_Parameter_3
        MOVS     R0,#+2
        B.N      ??Load_Parameter_1
//  240   
//  241   Current =(*p++ >>8);                    // 加载之前的 Current Title
??Load_Parameter_3:
        LDRH     R0,[R4, #+0]
        LSRS     R0,R0,#+8
        LDR.N    R1,??DataTable17  ;; Current
        STRB     R0,[R1, #+0]
//  242   
//  243   for(i=0; i<7; i++){ 
//  244     Detail[i*2]  = *p;
        LDR.N    R1,??DataTable18  ;; Detail
        LDRH     R0,[R4, #+2]
        STRB     R0,[R1, #+0]
//  245     Detail[i*2+1]= (*p++ >>8);             // 加载之前的 Detail
        LSRS     R0,R0,#+8
        STRB     R0,[R1, #+1]
        ADDS     R0,R4,#+4
        ADDS     R1,R1,#+2
        MOVS     R2,#+2
??Load_Parameter_4:
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
//  246   }
        SUBS     R2,R2,#+1
        BNE.N    ??Load_Parameter_4
//  247   for(i=0; i<13; i++){
//  248     Title[i][0].Value = *p++;             // 加载之前的显示菜单中各个对应项的值
        LDR.N    R1,??DataTable19  ;; Title
        LDRSH    R2,[R0], #+2
        STRH     R2,[R1, #+16]
//  249     Title[i][1].Value = *p++;
        LDRSH    R2,[R0], #+2
        STRH     R2,[R1, #+36]
//  250     Title[i][2].Value = *p++;
        LDRSH    R2,[R0], #+2
        STRH     R2,[R1, #+56]
//  251     Title[i][3].Value = *p++;
        LDRSH    R2,[R0], #+2
        STRH     R2,[R1, #+76]
        ADDS     R1,R1,#+96
        MOVS     R2,#+6
??Load_Parameter_5:
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
//  252   }
        SUBS     R2,R2,#+1
        BNE.N    ??Load_Parameter_5
//  253   for(i=0; i<9; i++){
        LDR.N    R1,??DataTable20  ;; Meter + 4
        MOVS     R2,#+3
//  254     Meter[i].Item     = *p;
??Load_Parameter_6:
        LDRH     R3,[R0, #+0]
        STRB     R3,[R1, #+1]
//  255     Meter[i].Track    =(*p++ >>8);        // 加载之前的测量项目及测量对象
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
//  256   }
        ADDS     R1,R1,#+36
        SUBS     R2,R2,#+1
        BNE.N    ??Load_Parameter_6
//  257   for(i=0; i<10; i++){
        LDR.N    R1,??DataTable22  ;; Ka1
        LDR.N    R2,??DataTable21  ;; Kb1
        LDR.N    R3,??DataTable23  ;; Ka2
        LDR.W    R12,??DataTable24  ;; Kb2
        MOV      LR,#+5
//  258     Ka1[i] = *p;                         // 恢复原来的 A 通道零点误差校正系数
??Load_Parameter_7:
        LDRH     R4,[R0, #+0]
        STRB     R4,[R1], #+1
//  259     Kb1[i] =(*p++ >>8);                  // 恢复原来的 B 通道零点误差校正系数
        LSRS     R4,R4,#+8
        STRB     R4,[R2], #+1
//  260     Ka2[i] = *p++;                       // 恢复原来的 A 通道增益误差校正系数
        LDRH     R4,[R0, #+2]!
        STRH     R4,[R3], #+2
//  261     Kb2[i] = *p++;                       // 加载之前的 B 通道增益误差校正系数
        LDRH     R4,[R0, #+2]!
        STRH     R4,[R12], #+2
        LDRH     R4,[R0, #+2]!
        STRB     R4,[R1], #+1
        LDRH     R4,[R0], #+2
        LSRS     R4,R4,#+8
        STRB     R4,[R2], #+1
        LDRH     R4,[R0], #+2
        STRH     R4,[R3], #+2
        LDRH     R4,[R0], #+2
        STRH     R4,[R12], #+2
//  262   }
        SUBS     LR,LR,#+1
        BNE.N    ??Load_Parameter_7
//  263   Ka3 = *p++;                            // 恢复原来的 A 通道位移误差校正系数
        LDR.N    R1,??DataTable25  ;; Ka3
        LDRH     R2,[R0, #+0]
        STRH     R2,[R1, #+0]
//  264   Kb3 = *p++;                            // 恢复原来的 B 通道位移误差校正系数
        LDRH     R1,[R0, #+2]!
        LDR.N    R2,??DataTable26  ;; Kb3
        STRH     R1,[R2, #+0]
//  265 
//  266   V_Trigg[A].Value = *p++;
        LDR.N    R1,??DataTable27  ;; V_Trigg
        LDRSH    R2,[R0, #+2]!
        STRH     R2,[R1, #+0]
//  267   V_Trigg[B].Value = *p++;               // 恢复原来A,B通道触发阈值
        LDRSH    R2,[R0, #+2]!
        STRH     R2,[R1, #+4]
//  268   
//  269   return 0;
        MOVS     R0,#+0
??Load_Parameter_1:
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        CFI EndBlock cfiBlock5
//  270 }
//  271 /*******************************************************************************
//  272  Save_Parameter: 保存当前的工作参数                          Return: 0= Success
//  273 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function Save_Parameter
        THUMB
//  274 u8 Save_Parameter(u8 Default)             // 参数区共有4页，每页 256 Byte
//  275 {                                          // 目前只用了第0页
Save_Parameter:
        PUSH     {R4-R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI R7 Frame(CFA, -8)
        CFI R6 Frame(CFA, -12)
        CFI R5 Frame(CFA, -16)
        CFI R4 Frame(CFA, -20)
        CFI CFA R13+20
        SUB      SP,SP,#+4
        CFI CFA R13+24
        MOVS     R6,R0
//  276   u8 Versions =0x03, Sum =0;
        MOVS     R7,#+3
        MOVS     R4,#+0
//  277   u16* p =(u16*)SecBuff;
//  278   u16  i;
//  279   
//  280   memset(SecBuff,0,256);  
        LDR.N    R5,??DataTable16  ;; SecBuff
        MOV      R1,#+256
        MOVS     R0,R5
        BL       __aeabi_memclr4
//  281   
//  282   if(Default) Versions =0xFF;
        CBZ      R6,??Save_Parameter_0
        MOVS     R7,#+255
//  283   *p++ =(Current <<8)+ Versions;            // 保存参数版本号及当前的 Title
??Save_Parameter_0:
        LDR.N    R0,??DataTable17  ;; Current
        LDRB     R0,[R0, #+0]
        ADD      R0,R7,R0, LSL #+8
        STRH     R0,[R5, #+0]
//  284   
//  285   for(i=0; i<7; i++) 
//  286     *p++ =(Detail[i*2+1]<<8)+ Detail[i*2]; // 保存当前的 Detail
        LDR.N    R1,??DataTable18  ;; Detail
        LDRB     R0,[R1, #+1]
        LDRB     R2,[R1], #+2
        ADD      R0,R2,R0, LSL #+8
        STRH     R0,[R5, #+2]
        ADDS     R0,R5,#+4
        MOVS     R2,#+2
??Save_Parameter_1:
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
        ADDS     R1,R1,#+6
        SUBS     R2,R2,#+1
        BNE.N    ??Save_Parameter_1
//  287   
//  288   for(i=0; i<13; i++){                     // 保存显示菜单中各个对应项的值
//  289     *p++ = Title[i][0].Value;
        LDR.N    R1,??DataTable19  ;; Title
        LDRH     R2,[R1, #+16]
        STRH     R2,[R0], #+2
//  290     *p++ = Title[i][1].Value;
        LDRH     R2,[R1, #+36]
        STRH     R2,[R0], #+2
//  291     *p++ = Title[i][2].Value;
        LDRH     R2,[R1, #+56]
        STRH     R2,[R0], #+2
//  292     *p++ = Title[i][3].Value;
        LDRH     R2,[R1, #+76]
        STRH     R2,[R0], #+2
        ADDS     R1,R1,#+96
        MOVS     R2,#+6
??Save_Parameter_2:
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
//  293   }
        SUBS     R2,R2,#+1
        BNE.N    ??Save_Parameter_2
//  294   for(i=0; i<9; i++){
        LDR.N    R1,??DataTable20  ;; Meter + 4
        MOVS     R2,#+3
//  295     *p++ =(Meter[i].Track<<8)+ Meter[i].Item; // 保存测量项目及测量对象
??Save_Parameter_3:
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
//  296   }
        ADDS     R1,R1,#+36
        SUBS     R2,R2,#+1
        BNE.N    ??Save_Parameter_3
//  297   for(i=0; i<10; i++){
        LDR.N    R1,??DataTable21  ;; Kb1
        LDR.N    R2,??DataTable22  ;; Ka1
        LDR.N    R3,??DataTable23  ;; Ka2
        LDR.W    R12,??DataTable24  ;; Kb2
        MOV      LR,#+5
//  298     *p++ =(Kb1[i]<<8)+ Ka1[i];             // 保存当前 A,B 通道零点误差校正系数
??Save_Parameter_4:
        LDRSB    R6,[R1], #+1
        LDRSB    R7,[R2], #+1
        ADD      R6,R7,R6, LSL #+8
        STRH     R6,[R0], #+2
//  299     *p++ = Ka2[i];                         // 保存当前 A 通道增益误差校正系数
        LDRH     R6,[R3], #+2
        STRH     R6,[R0], #+2
//  300     *p++ = Kb2[i];                         // 保存当前 B 通道增益误差校正系数
        LDRH     R6,[R12], #+2
        STRH     R6,[R0], #+2
        LDRSB    R6,[R1], #+1
        LDRSB    R7,[R2], #+1
        ADD      R6,R7,R6, LSL #+8
        STRH     R6,[R0], #+2
        LDRH     R6,[R3], #+2
        STRH     R6,[R0], #+2
        LDRH     R6,[R12], #+2
        STRH     R6,[R0], #+2
//  301   }
        SUBS     LR,LR,#+1
        BNE.N    ??Save_Parameter_4
//  302   *p++ = Ka3;                              // 保存当前 A 通道位移误差校正系数
        LDR.N    R1,??DataTable25  ;; Ka3
        LDRH     R1,[R1, #+0]
        STRH     R1,[R0, #+0]
//  303   *p++ = Kb3;                              // 保存当前 B 通道位移误差校正系数
        LDR.N    R1,??DataTable26  ;; Kb3
        LDRH     R1,[R1, #+0]
        STRH     R1,[R0, #+2]!
//  304   
//  305   *p++ = V_Trigg[A].Value;
        LDR.N    R1,??DataTable27  ;; V_Trigg
        LDRH     R2,[R1, #+0]
        STRH     R2,[R0, #+2]!
//  306   *p++ = V_Trigg[B].Value;                 // 保存当前A,B通道触发阈值   
        LDRH     R1,[R1, #+4]
        STRH     R1,[R0, #+2]!
//  307   
//  308   for(i=0; i<255; i++)  Sum += SecBuff[i]; //计算参数区校验和
        MOVS     R0,R5
        MOVS     R1,#+51
??Save_Parameter_5:
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
        ADDS     R4,R3,R2
        UXTB     R4,R4
        SUBS     R1,R1,#+1
        BNE.N    ??Save_Parameter_5
//  309   SecBuff[255] = (~Sum)+ 1;
        MVNS     R0,R4
        ADDS     R0,R0,#+1
        STRB     R0,[R5, #+255]
//  310   __Param_Area_WR(SecBuff, PAGE_0); 
        MOVS     R1,#+0
        MOVS     R0,R5
        BL       __Param_Area_WR
//  311   return 0;
        MOVS     R0,#+0
        ADD      SP,SP,#+4
        CFI CFA R13+20
        POP      {R4-R7,PC}       ;; return
        CFI EndBlock cfiBlock6
//  312 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable16:
        DC32     SecBuff

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable17:
        DC32     Current

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable18:
        DC32     Detail

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable19:
        DC32     Title

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable20:
        DC32     Meter + 4

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable21:
        DC32     Kb1

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable22:
        DC32     Ka1

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable23:
        DC32     Ka2

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable24:
        DC32     Kb2

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable25:
        DC32     Ka3

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable26:
        DC32     Kb3

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable27:
        DC32     V_Trigg

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "FILE    BMP">`:
        DATA
        DC8 "FILE    BMP"

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
        DC8 "DAT"

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
        DC8 "BMP"

        END
//  313 
//  314 /******************************** END OF FILE *********************************/
//  315 
// 
//    12 bytes in section .bss
// 1 780 bytes in section .data
//    20 bytes in section .rodata
// 2 002 bytes in section .text
// 
// 2 002 bytes of CODE  memory
//    20 bytes of CONST memory
// 1 792 bytes of DATA  memory
//
//Errors: none
//Warnings: none
