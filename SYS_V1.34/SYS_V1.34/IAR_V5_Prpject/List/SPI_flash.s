///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  14:17:19 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\SYS_V1.34\source\SPI_flash.c                  /
//    Command line =  E:\DS0203\SYS_V1.34\source\SPI_flash.c -lA              /
//                    E:\DS0203\SYS_V1.34\IAR_V5_Prpject\List\ -o             /
//                    E:\DS0203\SYS_V1.34\IAR_V5_Prpject\Obj\ --no_inline     /
//                    --endian=little --cpu=Cortex-M3 --fpu=None              /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.0 Evaluation\ARM\INC\DLib_Config_Full.h"    /
//                    -I E:\DS0203\SYS_V1.34\IAR_V5_Prpject\..\..\FWLib\inc\  /
//                    -I E:\DS0203\SYS_V1.34\IAR_V5_Prpject\..\..\USBLib\inc\ /
//                     -I E:\DS0203\SYS_V1.34\IAR_V5_Prpject\..\include\ -I   /
//                    "C:\Program Files\IAR Systems\Embedded Workbench 5.0    /
//                    Evaluation\ARM\INC\" -Ohs                               /
//    List file    =  E:\DS0203\SYS_V1.34\IAR_V5_Prpject\List\SPI_flash.s     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME SPI_flash

        EXTERN GPIO_ResetBits
        EXTERN GPIO_SetBits
        EXTERN SPI_GetFlagStatus
        EXTERN SPI_ReceiveData
        EXTERN SPI_SendData

        PUBLIC MAL_GetStatus
        PUBLIC Mass_Block_Count
        PUBLIC Mass_Block_Size
        PUBLIC Mass_Memory_Size
        PUBLIC Param_PageRead
        PUBLIC Param_PageWrite
        PUBLIC SPI_FLASH_BufferRead
        PUBLIC SPI_FLASH_PageErase
        PUBLIC SPI_FLASH_PageWrite
        PUBLIC SPI_FLASH_ReadByte
        PUBLIC SPI_FLASH_SendByte
        PUBLIC SPI_FLASH_WaitForWriteEnd
        PUBLIC SPI_FLASH_WriteEnable
        
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
        
// E:\DS0203\SYS_V1.34\source\SPI_flash.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : SPI_flash.c  
//    3  Version   : DS203_SYS Ver 1.3x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include "SPI_flash.h"
//    6 

        SECTION `.bss`:DATA:NOROOT(2)
//    7 u32 Mass_Memory_Size;
Mass_Memory_Size:
        DS8 4
//    8 u32 Mass_Block_Size;
Mass_Block_Size:
        DS8 4
//    9 u32 Mass_Block_Count;
Mass_Block_Count:
        DS8 4
//   10 
//   11 /*******************************************************************************
//   12  SPI_FLASH_PageErase  : Erases the specified FLASH Page.
//   13 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function SPI_FLASH_PageErase
        THUMB
//   14 void SPI_FLASH_PageErase(u32 PageAddr)
//   15 {
SPI_FLASH_PageErase:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
        MOVS     R4,R0
//   16   SPI_FLASH_WriteEnable();
        BL       SPI_FLASH_WriteEnable
//   17   SPI_FLASH_CS_LOW();
        LDR.N    R5,??DataTable6  ;; 0x40010c00
        MOVS     R1,#+128
        MOVS     R0,R5
        BL       GPIO_ResetBits
//   18   SPI_FLASH_SendByte(PE);
        MOVS     R0,#+219
        BL       SPI_FLASH_SendByte
//   19   SPI_FLASH_SendByte((PageAddr & 0xFF0000) >> 16);   //Send high address byte
        LSRS     R0,R4,#+16
        UXTB     R0,R0
        BL       SPI_FLASH_SendByte
//   20   SPI_FLASH_SendByte((PageAddr & 0xFF00) >> 8);      //Send medium address byte
        LSRS     R0,R4,#+8
        UXTB     R0,R0
        BL       SPI_FLASH_SendByte
//   21   SPI_FLASH_SendByte(PageAddr & 0xFF);               //Send low address byte
        UXTB     R0,R4
        BL       SPI_FLASH_SendByte
//   22   SPI_FLASH_CS_HIGH();
        MOVS     R1,#+128
        MOVS     R0,R5
        BL       GPIO_SetBits
//   23 
//   24   SPI_FLASH_WaitForWriteEnd();                // Wait the end of Flash writing 
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,LR}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.N      SPI_FLASH_WaitForWriteEnd
        CFI EndBlock cfiBlock0
//   25 }
//   26 /*******************************************************************************
//   27  SPI_FLASH_PageWrite : 
//   28 
//   29  SPI FLASH 的2~16页被定义成参数区
//   30 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function Param_PageWrite
        THUMB
//   31 void Param_PageWrite(u8* pBuffer, u8 PageNum)
//   32 {
Param_PageWrite:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOVS     R4,R0
//   33   u16 Lenght;
//   34   u32 WriteAddr;
//   35   
//   36   Lenght = 0x100;
//   37   WriteAddr = 0x200 * (1 + PageNum);
        ADDS     R0,R1,#+1
        LSLS     R5,R0,#+9
//   38 //  SPI_FLASH_PageErase(WriteAddr);
//   39   SPI_FLASH_WriteEnable();
        BL       SPI_FLASH_WriteEnable
//   40   SPI_FLASH_CS_LOW();
        LDR.N    R6,??DataTable6  ;; 0x40010c00
        MOVS     R1,#+128
        MOVS     R0,R6
        BL       GPIO_ResetBits
//   41   SPI_FLASH_SendByte(PW);
        MOVS     R0,#+10
        BL       SPI_FLASH_SendByte
//   42   SPI_FLASH_SendByte((WriteAddr & 0xFF0000) >> 16);
        LSRS     R0,R5,#+16
        UXTB     R0,R0
        BL       SPI_FLASH_SendByte
//   43   SPI_FLASH_SendByte((WriteAddr & 0xFF00) >> 8);  
        LSRS     R0,R5,#+8
        UXTB     R0,R0
        BL       SPI_FLASH_SendByte
//   44   SPI_FLASH_SendByte(WriteAddr & 0xFF);
        UXTB     R0,R5
        BL       SPI_FLASH_SendByte
        MOV      R5,#+256
//   45   while(Lenght--) {         // while there is data to be written on the FLASH 
//   46     SPI_FLASH_SendByte(*pBuffer);
??Param_PageWrite_0:
        LDRB     R0,[R4], #+1
        BL       SPI_FLASH_SendByte
//   47     pBuffer++; 
        SUBS     R5,R5,#+1
//   48   }
        BNE.N    ??Param_PageWrite_0
//   49   SPI_FLASH_CS_HIGH();
        MOVS     R1,#+128
        MOVS     R0,R6
        BL       GPIO_SetBits
//   50   SPI_FLASH_WaitForWriteEnd();
        POP      {R4-R6,LR}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.N      SPI_FLASH_WaitForWriteEnd
        CFI EndBlock cfiBlock1
//   51 }
//   52 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function SPI_FLASH_PageWrite
        THUMB
//   53 void SPI_FLASH_PageWrite(u8* pBuffer, u32 WriteAddr)
//   54 {
SPI_FLASH_PageWrite:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOVS     R4,R0
        MOVS     R5,R1
//   55   u16 Lenght = 0x100;
//   56   SPI_FLASH_WriteEnable();
        BL       SPI_FLASH_WriteEnable
//   57   SPI_FLASH_CS_LOW();
        LDR.N    R6,??DataTable6  ;; 0x40010c00
        MOVS     R1,#+128
        MOVS     R0,R6
        BL       GPIO_ResetBits
//   58   SPI_FLASH_SendByte(PW);
        MOVS     R0,#+10
        BL       SPI_FLASH_SendByte
//   59   SPI_FLASH_SendByte((WriteAddr & 0xFF0000) >> 16);
        LSRS     R0,R5,#+16
        UXTB     R0,R0
        BL       SPI_FLASH_SendByte
//   60   SPI_FLASH_SendByte((WriteAddr & 0xFF00) >> 8);  
        LSRS     R0,R5,#+8
        UXTB     R0,R0
        BL       SPI_FLASH_SendByte
//   61   SPI_FLASH_SendByte(WriteAddr & 0xFF);
        UXTB     R0,R5
        BL       SPI_FLASH_SendByte
        MOV      R5,#+256
//   62   while(Lenght--) {         // while there is data to be written on the FLASH 
//   63     SPI_FLASH_SendByte(*pBuffer);
??SPI_FLASH_PageWrite_0:
        LDRB     R0,[R4], #+1
        BL       SPI_FLASH_SendByte
//   64     pBuffer++; 
        SUBS     R5,R5,#+1
//   65   }
        BNE.N    ??SPI_FLASH_PageWrite_0
//   66   SPI_FLASH_CS_HIGH();
        MOVS     R1,#+128
        MOVS     R0,R6
        BL       GPIO_SetBits
//   67   SPI_FLASH_WaitForWriteEnd();
        POP      {R4-R6,LR}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.N      SPI_FLASH_WaitForWriteEnd
        CFI EndBlock cfiBlock2
//   68 }
//   69 
//   70 /*******************************************************************************
//   71  SPI_FLASH_BufferRead
//   72 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function SPI_FLASH_BufferRead
        THUMB
//   73 void SPI_FLASH_BufferRead(u8* pBuffer, u32 ReadAddr, u16 NumByteToRead)
//   74 {
SPI_FLASH_BufferRead:
        PUSH     {R4-R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI R7 Frame(CFA, -8)
        CFI R6 Frame(CFA, -12)
        CFI R5 Frame(CFA, -16)
        CFI R4 Frame(CFA, -20)
        CFI CFA R13+20
        SUB      SP,SP,#+4
        CFI CFA R13+24
        MOVS     R5,R0
        MOVS     R6,R1
        MOVS     R4,R2
//   75   SPI_FLASH_CS_LOW();
        LDR.N    R7,??DataTable6  ;; 0x40010c00
        MOVS     R1,#+128
        MOVS     R0,R7
        BL       GPIO_ResetBits
//   76   SPI_FLASH_SendByte(READ);
        MOVS     R0,#+3
        BL       SPI_FLASH_SendByte
//   77   SPI_FLASH_SendByte((ReadAddr & 0xFF0000) >> 16);
        LSRS     R0,R6,#+16
        UXTB     R0,R0
        BL       SPI_FLASH_SendByte
//   78   SPI_FLASH_SendByte((ReadAddr& 0xFF00) >> 8);
        LSRS     R0,R6,#+8
        UXTB     R0,R0
        BL       SPI_FLASH_SendByte
//   79   SPI_FLASH_SendByte(ReadAddr & 0xFF);
        UXTB     R0,R6
        BL       SPI_FLASH_SendByte
        CBZ      R4,??SPI_FLASH_BufferRead_0
        MOVW     R6,#+65535
??SPI_FLASH_BufferRead_1:
        ADDS     R4,R6,R4
//   80 
//   81   while(NumByteToRead--){ // while there is data to be read 
//   82     *pBuffer = SPI_FLASH_SendByte(Dummy_Byte);
        MOVS     R0,#+165
        BL       SPI_FLASH_SendByte
        STRB     R0,[R5], #+1
//   83     pBuffer++;
//   84   }
        UXTH     R4,R4
        CMP      R4,#+0
        BNE.N    ??SPI_FLASH_BufferRead_1
//   85   SPI_FLASH_CS_HIGH();
??SPI_FLASH_BufferRead_0:
        MOVS     R1,#+128
        MOVS     R0,R7
        ADD      SP,SP,#+4
        CFI CFA R13+20
        POP      {R4-R7,LR}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R7 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      GPIO_SetBits
        CFI EndBlock cfiBlock3
//   86 }
//   87 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Param_PageRead
        THUMB
//   88 void Param_PageRead(u8* pBuffer, u8 PageNum)
//   89 {
Param_PageRead:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOVS     R4,R0
//   90   u16 Lenght = 256;
//   91   u32 ReadAddr = 0x200 * (1 + PageNum);
        ADDS     R0,R1,#+1
        LSLS     R5,R0,#+9
//   92   SPI_FLASH_CS_LOW();
        LDR.N    R6,??DataTable6  ;; 0x40010c00
        MOVS     R1,#+128
        MOVS     R0,R6
        BL       GPIO_ResetBits
//   93   SPI_FLASH_SendByte(READ);
        MOVS     R0,#+3
        BL       SPI_FLASH_SendByte
//   94   SPI_FLASH_SendByte((ReadAddr & 0xFF0000) >> 16);
        LSRS     R0,R5,#+16
        UXTB     R0,R0
        BL       SPI_FLASH_SendByte
//   95   SPI_FLASH_SendByte((ReadAddr& 0xFF00) >> 8);
        LSRS     R0,R5,#+8
        UXTB     R0,R0
        BL       SPI_FLASH_SendByte
//   96   SPI_FLASH_SendByte(ReadAddr & 0xFF);
        UXTB     R0,R5
        BL       SPI_FLASH_SendByte
        MOV      R5,#+256
//   97   while(Lenght--){ // while there is data to be read 
//   98     *pBuffer = SPI_FLASH_SendByte(Dummy_Byte);
??Param_PageRead_0:
        MOVS     R0,#+165
        BL       SPI_FLASH_SendByte
        STRB     R0,[R4], #+1
//   99     pBuffer++;
        SUBS     R5,R5,#+1
//  100   }
        BNE.N    ??Param_PageRead_0
//  101   SPI_FLASH_CS_HIGH();
        MOVS     R1,#+128
        MOVS     R0,R6
        POP      {R4-R6,LR}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      GPIO_SetBits
        CFI EndBlock cfiBlock4
//  102 }
//  103 /*******************************************************************************
//  104  SPI_FLASH_ReadByte
//  105 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function SPI_FLASH_ReadByte
        THUMB
//  106 u8 SPI_FLASH_ReadByte(void)
//  107 {
//  108   return (SPI_FLASH_SendByte(Dummy_Byte));
SPI_FLASH_ReadByte:
        MOVS     R0,#+165
        Nop      
        CFI EndBlock cfiBlock5
        REQUIRE SPI_FLASH_SendByte
        ;; // Fall through to label SPI_FLASH_SendByte
//  109 }
//  110 
//  111 /*******************************************************************************
//  112  SPI_FLASH_SendByte
//  113 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function SPI_FLASH_SendByte
        THUMB
//  114 u8 SPI_FLASH_SendByte(u8 byte)
//  115 {
SPI_FLASH_SendByte:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
        MOVS     R4,R0
        LDR.N    R5,??SPI_FLASH_SendByte_0  ;; 0x40003c00
//  116   while(SPI_GetFlagStatus(SPI3, SPI_FLAG_TXE) == RESET);
??SPI_FLASH_SendByte_1:
        MOVS     R1,#+2
        MOVS     R0,R5
        BL       SPI_GetFlagStatus
        CMP      R0,#+0
        BEQ.N    ??SPI_FLASH_SendByte_1
//  117   SPI_SendData(SPI3, byte);
        MOVS     R1,R4
        MOVS     R0,R5
        BL       SPI_SendData
//  118   while(SPI_GetFlagStatus(SPI3, SPI_FLAG_RXNE) == RESET);
??SPI_FLASH_SendByte_2:
        MOVS     R1,#+1
        MOVS     R0,R5
        BL       SPI_GetFlagStatus
        CMP      R0,#+0
        BEQ.N    ??SPI_FLASH_SendByte_2
//  119   return SPI_ReceiveData(SPI3);
        MOVS     R0,R5
        BL       SPI_ReceiveData
        UXTB     R0,R0
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        DATA
??SPI_FLASH_SendByte_0:
        DC32     0x40003c00
        CFI EndBlock cfiBlock6
//  120 }
//  121 /*******************************************************************************
//  122  SPI_FLASH_WriteEnable
//  123 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function SPI_FLASH_WriteEnable
        THUMB
//  124 void SPI_FLASH_WriteEnable(void)
//  125 {
SPI_FLASH_WriteEnable:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  126   SPI_FLASH_CS_LOW();
        LDR.N    R4,??DataTable6  ;; 0x40010c00
        MOVS     R1,#+128
        MOVS     R0,R4
        BL       GPIO_ResetBits
//  127   SPI_FLASH_SendByte(WREN);
        MOVS     R0,#+6
        BL       SPI_FLASH_SendByte
//  128   SPI_FLASH_CS_HIGH();
        MOVS     R1,#+128
        MOVS     R0,R4
        POP      {R4,LR}
        CFI R4 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      GPIO_SetBits
        CFI EndBlock cfiBlock7
//  129 }
//  130 /*******************************************************************************
//  131  SPI_FLASH_WaitForWriteEnd
//  132 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function SPI_FLASH_WaitForWriteEnd
        THUMB
//  133 void SPI_FLASH_WaitForWriteEnd(void)
//  134 {
SPI_FLASH_WaitForWriteEnd:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  135   u8 FLASH_Status = 0;
//  136   SPI_FLASH_CS_LOW();
        LDR.N    R4,??DataTable6  ;; 0x40010c00
        MOVS     R1,#+128
        MOVS     R0,R4
        BL       GPIO_ResetBits
//  137   SPI_FLASH_SendByte(RDSR);
        MOVS     R0,#+5
        BL       SPI_FLASH_SendByte
//  138   do { FLASH_Status = SPI_FLASH_SendByte(Dummy_Byte);                
//  139   } while((FLASH_Status & WIP_Flag) == SET);              // Write in progress 
??SPI_FLASH_WaitForWriteEnd_0:
        MOVS     R0,#+165
        BL       SPI_FLASH_SendByte
        TST      R0,#0x1
        BNE.N    ??SPI_FLASH_WaitForWriteEnd_0
//  140   SPI_FLASH_CS_HIGH();
        MOVS     R1,#+128
        MOVS     R0,R4
        POP      {R4,LR}
        CFI R4 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      GPIO_SetBits
        CFI EndBlock cfiBlock8
//  141 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable6:
        DC32     0x40010c00
//  142 /*******************************************************************************
//  143  MAL_GetStatus
//  144 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function MAL_GetStatus
        THUMB
//  145 void MAL_GetStatus (void)
//  146 {
//  147     Mass_Block_Count = 4096;        //FLASH_SIZE/FLASH_PAGE_SIZE; 
MAL_GetStatus:
        LDR.N    R0,??MAL_GetStatus_0  ;; Mass_Memory_Size
        MOV      R1,#+4096
        STR      R1,[R0, #+8]
//  148     Mass_Block_Size  = 512;         //FLASH_PAGE_SIZE; 
        MOV      R1,#+512
        STR      R1,[R0, #+4]
//  149     Mass_Memory_Size = 0x200000;    //FLASH_SIZE; 
        MOV      R1,#+2097152
        STR      R1,[R0, #+0]
//  150 } 
        BX       LR               ;; return
        Nop      
        DATA
??MAL_GetStatus_0:
        DC32     Mass_Memory_Size
        CFI EndBlock cfiBlock9

        END
//  151 
//  152 /*********************************  END OF FILE  ******************************/
// 
//  12 bytes in section .bss
// 548 bytes in section .text
// 
// 548 bytes of CODE memory
//  12 bytes of DATA memory
//
//Errors: none
//Warnings: none
