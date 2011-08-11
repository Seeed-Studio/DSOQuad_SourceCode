///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:03:48 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\SYS_V1.50\source\scsi_data.c           /
//    Command line =  E:\Mini-DS\DS203\SYS_V1.50\source\scsi_data.c -lA       /
//                    E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\ -o      /
//                    E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\Obj\          /
//                    --no_inline --endian=little --cpu=Cortex-M3 -e          /
//                    --fpu=None --dlib_config "C:\Program Files\IAR          /
//                    Systems\Embedded Workbench 5.0                          /
//                    Evaluation\ARM\INC\DLib_Config_Normal.h" -I             /
//                    E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\..\..\FWLib\i /
//                    nc\ -I E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\..\..\ /
//                    USBLib\inc\ -I E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpjec /
//                    t\..\include\ -I "C:\Program Files\IAR                  /
//                    Systems\Embedded Workbench 5.0 Evaluation\ARM\INC\"     /
//                    -Ohs                                                    /
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\scsi_dat /
//                    a.s                                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME scsi_data

        PUBLIC Mode_Sense10_data
        PUBLIC Mode_Sense6_data
        PUBLIC Page00_Inquiry_Data
        PUBLIC ReadCapacity10_Data
        PUBLIC ReadFormatCapacity_Data
        PUBLIC Scsi_Sense_Data
        PUBLIC Standard_Inquiry_Data
// E:\Mini-DS\DS203\SYS_V1.50\source\scsi_data.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : SCSI_data.c  
//    3  Version   : DS203_SYS Ver 1.3x                                 Author : bure
//    4 *******************************************************************************/
//    5 #include "USB_scsi.h"
//    6 #include "Memory.h"
//    7 

        SECTION `.bss`:DATA:NOROOT(2)
//    8 u8 Page00_Inquiry_Data[] ={    // PERIPHERAL QUALIFIER & PERIPHERAL DEVICE TYPE
Page00_Inquiry_Data:
        DS8 8
//    9     0x00, 0x00, 0x00, 0x00,
//   10     0x00 };                    // Supported Pages 00
//   11   

        SECTION `.data`:DATA:NOROOT(2)
//   12 u8 Standard_Inquiry_Data[] ={
Standard_Inquiry_Data:
        DATA
        DC8 0, 128, 2, 2, 32, 0, 0, 0, 77, 105, 110, 105, 95, 68, 83, 79, 70
        DC8 108, 97, 115, 104, 32, 68, 105, 115, 107, 32, 32, 32, 32, 32, 32
        DC8 32, 0, 0, 0
//   13     0x00,                      // Direct Access Device 
//   14     0x80,                      // RMB = 1: Removable Medium 
//   15     0x02,                      // Version: No conformance claim to standard 
//   16     0x02,
//   17     36 - 4,                    // Additional Length 
//   18     0x00,                      // SCCS = 1: Storage Controller Component 
//   19     0x00,
//   20     0x00,
//   21     'M', 'i', 'n', 'i', '_', 'D', 'S', 'O',           // Vendor Identification 
//   22     'F', 'l', 'a', 's', 'h', ' ', 'D', 'i', 's', 'k', // Product Identification
//   23     ' ', ' ', ' ', ' ', ' ', ' ', ' ' 
//   24 };
//   25 

        SECTION `.data`:DATA:NOROOT(2)
//   26 u8 Mode_Sense6_data[] ={
Mode_Sense6_data:
        DATA
        DC8 3, 0, 0, 0
//   27     0x03, 0x00, 0x00, 0x00};
//   28 

        SECTION `.data`:DATA:NOROOT(2)
//   29 u8 Mode_Sense10_data[] ={
Mode_Sense10_data:
        DATA
        DC8 0, 6, 0, 0, 0, 0, 0, 0
//   30     0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
//   31 

        SECTION `.data`:DATA:NOROOT(2)
//   32 u8 Scsi_Sense_Data[] ={
Scsi_Sense_Data:
        DATA
        DC8 112, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
//   33     0x70,               //RespCode
//   34     0x00,               //SegmentNumber
//   35     NO_SENSE,           // Sens_Key
//   36     0x00, 0x00, 0x00,
//   37     0x00,               //Information
//   38     0x0A,               //AdditionalSenseLength
//   39     0x00, 0x00, 0x00,
//   40     0x00,               //CmdInformation
//   41     NO_SENSE,           //Asc
//   42     0x00,               //ASCQ
//   43     0x00,               //FRUC
//   44     0x00,               //TBD
//   45     0x00,
//   46     0x00 };             //SenseKeySpecific
//   47   

        SECTION `.bss`:DATA:NOROOT(2)
//   48 u8 ReadCapacity10_Data[] ={    // Last Logical Block 
ReadCapacity10_Data:
        DS8 8
//   49     0, 0, 0, 0,                // Block Length 
//   50     0, 0, 0, 0};
//   51   

        SECTION `.data`:DATA:NOROOT(2)
//   52 u8 ReadFormatCapacity_Data [] ={
ReadFormatCapacity_Data:
        DATA
        DC8 0, 0, 0, 8, 0, 0, 0, 0, 2, 0, 0, 0

        END
//   53     0x00, 0x00, 0x00, 0x08,    // Capacity List Length 
//   54     0, 0, 0, 0,                // Block Count 
//   55     0x02,// Block Length 
//   56     0, 0, 0};// Descriptor Code: Formatted Media 
//   57 
//   58 /*********************************  END OF FILE  ******************************/
// 
// 16 bytes in section .bss
// 80 bytes in section .data
// 
// 96 bytes of DATA memory
//
//Errors: none
//Warnings: none
