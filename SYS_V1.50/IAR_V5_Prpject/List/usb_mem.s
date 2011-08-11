///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:04:02 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\USBLib\src\usb_mem.c                   /
//    Command line =  E:\Mini-DS\DS203\USBLib\src\usb_mem.c -lA               /
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
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\usb_mem. /
//                    s                                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME usb_mem

        PUBLIC PMAToUserBufferCopy
        PUBLIC UserToPMABufferCopy
        
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
        
// E:\Mini-DS\DS203\USBLib\src\usb_mem.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : usb_mem.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.2.1
//    5 * Date               : 09/22/2008
//    6 * Description        : Utility functions for memory transfers to/from PMA
//    7 ********************************************************************************
//    8 * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//    9 * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
//   10 * AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
//   11 * INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
//   12 * CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
//   13 * INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   14 *******************************************************************************/
//   15 
//   16 /* Includes ------------------------------------------------------------------*/
//   17 #include "usb_lib.h"
//   18 
//   19 /* Private typedef -----------------------------------------------------------*/
//   20 /* Private define ------------------------------------------------------------*/
//   21 /* Private macro -------------------------------------------------------------*/
//   22 /* Private variables ---------------------------------------------------------*/
//   23 /* Extern variables ----------------------------------------------------------*/
//   24 /* Private function prototypes -----------------------------------------------*/
//   25 /* Private functions ---------------------------------------------------------*/
//   26 /*******************************************************************************
//   27 * Function Name  : UserToPMABufferCopy
//   28 * Description    : Copy a buffer from user memory area to packet memory area (PMA)
//   29 * Input          : - pbUsrBuf: pointer to user memory area.
//   30 *                  - wPMABufAddr: address into PMA.
//   31 *                  - wNBytes: no. of bytes to be copied.
//   32 * Output         : None.
//   33 * Return         : None	.
//   34 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function UserToPMABufferCopy
        THUMB
//   35 void UserToPMABufferCopy(u8 *pbUsrBuf, u16 wPMABufAddr, u16 wNBytes)
//   36 {
//   37   u32 n = (wNBytes + 1) >> 1;   /* n = (wNBytes + 1) / 2 */
//   38   u32 i, temp1, temp2;
//   39   u16 *pdwVal;
//   40   pdwVal = (u16 *)(wPMABufAddr * 2 + PMAAddr);
UserToPMABufferCopy:
        LDR.N    R3,??DataTable1  ;; 0x40006000
        ADD      R1,R3,R1, LSL #+1
//   41   for (i = n; i != 0; i--)
        ADDS     R2,R2,#+1
        ASRS     R2,R2,#+1
        BEQ.N    ??UserToPMABufferCopy_0
//   42   {
//   43     temp1 = (u16) * pbUsrBuf;
??UserToPMABufferCopy_1:
        LDRB     R3,[R0], #+1
//   44     pbUsrBuf++;
//   45     temp2 = temp1 | (u16) * pbUsrBuf << 8;
//   46     *pdwVal++ = temp2;
        LDRB     R12,[R0], #+1
        ORR      R3,R3,R12, LSL #+8
        STRH     R3,[R1], #+2
//   47     pdwVal++;
        ADDS     R1,R1,#+2
//   48     pbUsrBuf++;
//   49   }
        SUBS     R2,R2,#+1
        BNE.N    ??UserToPMABufferCopy_1
//   50 }
??UserToPMABufferCopy_0:
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//   51 /*******************************************************************************
//   52 * Function Name  : PMAToUserBufferCopy
//   53 * Description    : Copy a buffer from user memory area to packet memory area (PMA)
//   54 * Input          : - pbUsrBuf    = pointer to user memory area.
//   55 *                  - wPMABufAddr = address into PMA.
//   56 *                  - wNBytes     = no. of bytes to be copied.
//   57 * Output         : None.
//   58 * Return         : None.
//   59 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function PMAToUserBufferCopy
        THUMB
//   60 void PMAToUserBufferCopy(u8 *pbUsrBuf, u16 wPMABufAddr, u16 wNBytes)
//   61 {
//   62   u32 n = (wNBytes + 1) >> 1;/* /2*/
//   63   u32 i;
//   64   u32 *pdwVal;
//   65   pdwVal = (u32 *)(wPMABufAddr * 2 + PMAAddr);
PMAToUserBufferCopy:
        LDR.N    R3,??DataTable1  ;; 0x40006000
        ADD      R1,R3,R1, LSL #+1
//   66   for (i = n; i != 0; i--)
        ADDS     R2,R2,#+1
        ASRS     R2,R2,#+1
        BEQ.N    ??PMAToUserBufferCopy_0
//   67   {
//   68     *(u16*)pbUsrBuf++ = *pdwVal++;
??PMAToUserBufferCopy_1:
        LDR      R3,[R1], #+4
        STRH     R3,[R0], #+2
//   69     pbUsrBuf++;
//   70   }
        SUBS     R2,R2,#+1
        BNE.N    ??PMAToUserBufferCopy_1
//   71 }
??PMAToUserBufferCopy_0:
        BX       LR               ;; return
        CFI EndBlock cfiBlock1

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable1:
        DC32     0x40006000

        END
//   72 
//   73 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
// 66 bytes in section .text
// 
// 66 bytes of CODE memory
//
//Errors: none
//Warnings: none
