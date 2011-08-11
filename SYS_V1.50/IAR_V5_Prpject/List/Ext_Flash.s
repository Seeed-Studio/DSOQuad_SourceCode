///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:03:31 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\SYS_V1.50\source\Ext_Flash.c           /
//    Command line =  E:\Mini-DS\DS203\SYS_V1.50\source\Ext_Flash.c -lA       /
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
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\Ext_Flas /
//                    h.s                                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Ext_Flash

        EXTERN GPIO_ResetBits
        EXTERN GPIO_SetBits
        EXTERN SPI_GetFlagStatus
        EXTERN SPI_ReceiveData
        EXTERN SPI_SendData

        PUBLIC ExtFlash_PageRD
        PUBLIC ExtFlash_PageWR
        PUBLIC ExtFlash_ReadByte
        PUBLIC ExtFlash_SendByte
        PUBLIC ExtFlash_WaitForWriteEnd
        PUBLIC ExtFlash_WriteEnable
        PUBLIC MAL_GetStatus
        PUBLIC Mass_Block_Count
        PUBLIC Mass_Block_Size
        PUBLIC Mass_Memory_Size
        PUBLIC Tout
        
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
        
// E:\Mini-DS\DS203\SYS_V1.50\source\Ext_Flash.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : EXT_Flash.c  
//    3  Version   : DS203_SYS Ver 1.5x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include "Ext_Flash.h"
//    6 #include "BIOS.h"
//    7 
//    8 #define OK           0            // 操作完成
//    9 #define SEC_ERR      1            // 扇区读写错误
//   10 #define TMAX         100000       // 超时限制
//   11 

        SECTION `.bss`:DATA:NOROOT(2)
//   12 u32 Mass_Memory_Size;
Mass_Memory_Size:
        DS8 4
//   13 u32 Mass_Block_Size;
Mass_Block_Size:
        DS8 4
//   14 u32 Mass_Block_Count;
Mass_Block_Count:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
//   15 u32 Tout;
Tout:
        DS8 4
//   16 
//   17 /*******************************************************************************
//   18  写FLASH页(256 Bytes)： Mode=0: 从0变1数据改写   Mode=1: 数据重写
//   19 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function ExtFlash_PageWR
        THUMB
//   20 void ExtFlash_PageWR(u8* pBuffer, u32 WriteAddr)
//   21 {
ExtFlash_PageWR:
        PUSH     {R4-R10,LR}
        CFI R14 Frame(CFA, -4)
        CFI R10 Frame(CFA, -8)
        CFI R9 Frame(CFA, -12)
        CFI R8 Frame(CFA, -16)
        CFI R7 Frame(CFA, -20)
        CFI R6 Frame(CFA, -24)
        CFI R5 Frame(CFA, -28)
        CFI R4 Frame(CFA, -32)
        CFI CFA R13+32
        SUB      SP,SP,#+8
        CFI CFA R13+40
        MOVS     R4,R0
        MOV      R8,R1
//   22   u32  Data1, Data2;
//   23   u16  i, Lenght = 256, Mode = 0; // Mode=0: 从0变1数据改写   Mode=1: 数据重写
        MOVS     R5,#+0
//   24 
//   25   ExtFlash_CS_HIGH();
        LDR.W    R10,??DataTable5  ;; 0x40010c00
        MOVS     R1,#+128
        MOV      R0,R10
        BL       GPIO_SetBits
//   26   ExtFlash_WaitForWriteEnd();
        BL       ExtFlash_WaitForWriteEnd
//   27 
//   28   WriteAddr &= ~0xFF;
        MOVS     R0,#+255
        BIC      R8,R8,R0
//   29   for(i=0; i<64; i++){
        MOV      R9,R8
        MOVS     R6,R4
        MOVS     R7,#+64
//   30     ExtFlash_PageRD((u8*)&Data1, WriteAddr+i*4, 4);
??ExtFlash_PageWR_0:
        MOVS     R2,#+4
        MOV      R1,R9
        ADD      R0,SP,#+0
        BL       ExtFlash_PageRD
//   31     Data2 =*(u32*)(pBuffer+i*4);
//   32     if((Data1 &(~Data2))!= 0)  Mode = 1; // 判断是否全部满足0->1
        LDR      R0,[SP, #+0]
        LDR      R1,[R6, #+0]
        MVNS     R1,R1
        TST      R1,R0
        IT       NE 
        MOVNE    R5,#+1
//   33   }
        ADDS     R6,R6,#+4
        ADD      R9,R9,#+4
        SUBS     R7,R7,#+1
        BNE.N    ??ExtFlash_PageWR_0
//   34   ExtFlash_WriteEnable();
        BL       ExtFlash_WriteEnable
//   35   ExtFlash_CS_LOW();
        MOVS     R1,#+128
        MOV      R0,R10
        BL       GPIO_ResetBits
//   36   (Mode)?(ExtFlash_SendByte(PW)):(ExtFlash_SendByte(PP));
        CBZ      R5,??ExtFlash_PageWR_1
        MOVS     R0,#+10
        B.N      ??ExtFlash_PageWR_2
??ExtFlash_PageWR_1:
        MOVS     R0,#+2
??ExtFlash_PageWR_2:
        BL       ExtFlash_SendByte
//   37   ExtFlash_SendByte((WriteAddr & 0xFF0000) >> 16);
        LSR      R0,R8,#+16
        UXTB     R0,R0
        BL       ExtFlash_SendByte
//   38   ExtFlash_SendByte((WriteAddr & 0xFF00) >> 8);  
        LSR      R0,R8,#+8
        UXTB     R0,R0
        BL       ExtFlash_SendByte
//   39   ExtFlash_SendByte(WriteAddr & 0xFF);
        UXTB     R0,R8
        BL       ExtFlash_SendByte
        MOV      R5,#+256
//   40   while(Lenght--) {         // while there is data to be written on the FLASH 
//   41     ExtFlash_SendByte(~(*pBuffer));
??ExtFlash_PageWR_3:
        LDRB     R0,[R4], #+1
        MVNS     R0,R0
        UXTB     R0,R0
        BL       ExtFlash_SendByte
//   42     pBuffer++; 
        SUBS     R5,R5,#+1
//   43   }
        BNE.N    ??ExtFlash_PageWR_3
//   44   ExtFlash_CS_HIGH();
        MOVS     R1,#+128
        MOV      R0,R10
        BL       GPIO_SetBits
//   45   ExtFlash_WaitForWriteEnd();
        BL       ExtFlash_WaitForWriteEnd
//   46 }
        ADD      SP,SP,#+8
        CFI CFA R13+32
        POP      {R4-R10,PC}      ;; return
        CFI EndBlock cfiBlock0
//   47 /*******************************************************************************
//   48  SPI_FLASH_BufferRead
//   49 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function ExtFlash_PageRD
        THUMB
//   50 void ExtFlash_PageRD(u8* pBuffer, u32 ReadAddr, u16 Lenght)
//   51 {
ExtFlash_PageRD:
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
//   52   ExtFlash_CS_HIGH();
        LDR.N    R7,??DataTable5  ;; 0x40010c00
        MOVS     R1,#+128
        MOVS     R0,R7
        BL       GPIO_SetBits
//   53   ExtFlash_WaitForWriteEnd();
        BL       ExtFlash_WaitForWriteEnd
//   54 
//   55   ExtFlash_CS_LOW();
        MOVS     R1,#+128
        MOVS     R0,R7
        BL       GPIO_ResetBits
//   56   ExtFlash_SendByte(READ);
        MOVS     R0,#+3
        BL       ExtFlash_SendByte
//   57   ExtFlash_SendByte((ReadAddr & 0xFF0000) >> 16);
        LSRS     R0,R6,#+16
        UXTB     R0,R0
        BL       ExtFlash_SendByte
//   58   ExtFlash_SendByte((ReadAddr& 0xFF00) >> 8);
        LSRS     R0,R6,#+8
        UXTB     R0,R0
        BL       ExtFlash_SendByte
//   59   ExtFlash_SendByte(ReadAddr & 0xFF);
        UXTB     R0,R6
        BL       ExtFlash_SendByte
        CBZ      R4,??ExtFlash_PageRD_0
        MOVW     R6,#+65535
??ExtFlash_PageRD_1:
        ADDS     R4,R6,R4
//   60 
//   61   while(Lenght--){ // while there is data to be read 
//   62     *pBuffer = ~(ExtFlash_SendByte(Dummy_Byte));
        MOVS     R0,#+165
        BL       ExtFlash_SendByte
        MVNS     R0,R0
        STRB     R0,[R5], #+1
//   63     pBuffer++;
//   64   }
        UXTH     R4,R4
        CMP      R4,#+0
        BNE.N    ??ExtFlash_PageRD_1
//   65   ExtFlash_CS_HIGH();
??ExtFlash_PageRD_0:
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
        CFI EndBlock cfiBlock1
//   66 }
//   67 /*******************************************************************************
//   68  SPI_FLASH_ReadByte
//   69 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function ExtFlash_ReadByte
        THUMB
//   70 u8 ExtFlash_ReadByte(void)
//   71 {
//   72   return (ExtFlash_SendByte(Dummy_Byte));
ExtFlash_ReadByte:
        MOVS     R0,#+165
        Nop      
        CFI EndBlock cfiBlock2
        REQUIRE ExtFlash_SendByte
        ;; // Fall through to label ExtFlash_SendByte
//   73 }
//   74 
//   75 /*******************************************************************************
//   76  SPI_FLASH_SendByte
//   77 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function ExtFlash_SendByte
        THUMB
//   78 u8 ExtFlash_SendByte(u8 byte)
//   79 {
ExtFlash_SendByte:
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
//   80   Tout = 0;
        LDR.N    R4,??DataTable6  ;; Tout
        MOVS     R0,#+0
        STR      R0,[R4, #+0]
        LDR.N    R6,??DataTable7  ;; 0x186a1
        LDR.N    R7,??ExtFlash_SendByte_0  ;; 0x40003c00
//   81   while(SPI_GetFlagStatus(SPI3, SPI_FLAG_TXE) == RESET){
??ExtFlash_SendByte_1:
        MOVS     R1,#+2
        MOVS     R0,R7
        BL       SPI_GetFlagStatus
        CBNZ     R0,??ExtFlash_SendByte_2
//   82     if(Tout++ > TMAX) return 255;
        LDR      R0,[R4, #+0]
        ADDS     R1,R0,#+1
        STR      R1,[R4, #+0]
        CMP      R0,R6
        BCC.N    ??ExtFlash_SendByte_1
??ExtFlash_SendByte_3:
        MOVS     R0,#+255
        B.N      ??ExtFlash_SendByte_4
//   83   }
//   84   SPI_SendData(SPI3, byte);
??ExtFlash_SendByte_2:
        MOVS     R1,R5
        MOVS     R0,R7
        BL       SPI_SendData
//   85   Tout = 0;
        MOVS     R0,#+0
        STR      R0,[R4, #+0]
        B.N      ??ExtFlash_SendByte_5
//   86   while(SPI_GetFlagStatus(SPI3, SPI_FLAG_RXNE) == RESET){
//   87     if(Tout++ > TMAX) return 255;
??ExtFlash_SendByte_6:
        LDR      R0,[R4, #+0]
        ADDS     R1,R0,#+1
        STR      R1,[R4, #+0]
        CMP      R0,R6
        BCS.N    ??ExtFlash_SendByte_3
//   88   }
??ExtFlash_SendByte_5:
        MOVS     R1,#+1
        MOVS     R0,R7
        BL       SPI_GetFlagStatus
        CMP      R0,#+0
        BEQ.N    ??ExtFlash_SendByte_6
//   89   return SPI_ReceiveData(SPI3);
        MOVS     R0,R7
        BL       SPI_ReceiveData
        UXTB     R0,R0
??ExtFlash_SendByte_4:
        ADD      SP,SP,#+4
        CFI CFA R13+20
        POP      {R4-R7,PC}       ;; return
        DATA
??ExtFlash_SendByte_0:
        DC32     0x40003c00
        CFI EndBlock cfiBlock3
//   90 }
//   91 /*******************************************************************************
//   92  SPI_FLASH_WriteEnable
//   93 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function ExtFlash_WriteEnable
        THUMB
//   94 void ExtFlash_WriteEnable(void)
//   95 {
ExtFlash_WriteEnable:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//   96   ExtFlash_CS_LOW();
        LDR.N    R4,??DataTable5  ;; 0x40010c00
        MOVS     R1,#+128
        MOVS     R0,R4
        BL       GPIO_ResetBits
//   97   ExtFlash_SendByte(WREN);
        MOVS     R0,#+6
        BL       ExtFlash_SendByte
//   98   ExtFlash_CS_HIGH();
        MOVS     R1,#+128
        MOVS     R0,R4
        POP      {R4,LR}
        CFI R4 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      GPIO_SetBits
        CFI EndBlock cfiBlock4
//   99 }
//  100 /*******************************************************************************
//  101  SPI_FLASH_WaitForWriteEnd
//  102 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function ExtFlash_WaitForWriteEnd
        THUMB
//  103 void ExtFlash_WaitForWriteEnd(void)
//  104 {
ExtFlash_WaitForWriteEnd:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
//  105   u8 FLASH_Status = 0;
//  106   
//  107   ExtFlash_CS_LOW();
        LDR.N    R4,??DataTable5  ;; 0x40010c00
        MOVS     R1,#+128
        MOVS     R0,R4
        BL       GPIO_ResetBits
//  108   ExtFlash_SendByte(RDSR);
        MOVS     R0,#+5
        BL       ExtFlash_SendByte
//  109   Tout = 0;
        LDR.N    R5,??DataTable6  ;; Tout
        MOVS     R0,#+0
        STR      R0,[R5, #+0]
        LDR.N    R6,??DataTable7  ;; 0x186a1
//  110   do { FLASH_Status = ExtFlash_SendByte(Dummy_Byte);
??ExtFlash_WaitForWriteEnd_0:
        MOVS     R0,#+165
        BL       ExtFlash_SendByte
//  111        if(Tout++ > TMAX) return;
        LDR      R1,[R5, #+0]
        ADDS     R2,R1,#+1
        STR      R2,[R5, #+0]
        CMP      R1,R6
        BCS.N    ??ExtFlash_WaitForWriteEnd_1
//  112   } while((FLASH_Status & WIP_Flag) == SET);              // Write in progress
        TST      R0,#0x1
        BNE.N    ??ExtFlash_WaitForWriteEnd_0
//  113   ExtFlash_CS_HIGH();
        MOVS     R1,#+128
        MOVS     R0,R4
        BL       GPIO_SetBits
//  114 }
??ExtFlash_WaitForWriteEnd_1:
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock5

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable5:
        DC32     0x40010c00

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable6:
        DC32     Tout

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7:
        DC32     0x186a1
//  115 /*******************************************************************************
//  116  MAL_GetStatus
//  117 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function MAL_GetStatus
        THUMB
//  118 void MAL_GetStatus (void)
//  119 {
//  120     Mass_Block_Count = 4096;        //FLASH_SIZE/FLASH_PAGE_SIZE; 
MAL_GetStatus:
        LDR.N    R0,??MAL_GetStatus_0  ;; Mass_Memory_Size
        MOV      R1,#+4096
        STR      R1,[R0, #+8]
//  121     Mass_Block_Size  = 512;         //FLASH_PAGE_SIZE; 
        MOV      R1,#+512
        STR      R1,[R0, #+4]
//  122     Mass_Memory_Size = 0x200000;    //FLASH_SIZE; 
        MOV      R1,#+2097152
        STR      R1,[R0, #+0]
//  123 } 
        BX       LR               ;; return
        Nop      
        DATA
??MAL_GetStatus_0:
        DC32     Mass_Memory_Size
        CFI EndBlock cfiBlock6

        END
//  124 
//  125 /*********************************  END OF FILE  ******************************/
// 
//  16 bytes in section .bss
// 486 bytes in section .text
// 
// 486 bytes of CODE memory
//  16 bytes of DATA memory
//
//Errors: none
//Warnings: none
