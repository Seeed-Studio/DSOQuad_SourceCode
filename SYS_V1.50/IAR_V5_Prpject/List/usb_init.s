///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:04:01 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\USBLib\src\usb_init.c                  /
//    Command line =  E:\Mini-DS\DS203\USBLib\src\usb_init.c -lA              /
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
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\usb_init /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME usb_init

        EXTERN Device_Property
        EXTERN User_Standard_Requests

        PUBLIC Device_Info
        PUBLIC EPindex
        PUBLIC SaveState
        PUBLIC USB_Init
        PUBLIC pInformation
        PUBLIC pProperty
        PUBLIC pUser_Standard_Requests
        PUBLIC wInterrupt_Mask
        
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
        
// E:\Mini-DS\DS203\USBLib\src\usb_init.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : usb_init.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.2.1
//    5 * Date               : 09/22/2008
//    6 * Description        : Initialization routines & global variables
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
//   23 /*  The number of current endpoint, it will be used to specify an endpoint */

        SECTION `.bss`:DATA:NOROOT(0)
//   24  u8	EPindex;
EPindex:
        DS8 1
//   25 /*  The number of current device, it is an index to the Device_Table */
//   26 /* u8	Device_no; */
//   27 /*  Points to the DEVICE_INFO structure of current device */
//   28 /*  The purpose of this register is to speed up the execution */

        SECTION `.bss`:DATA:NOROOT(2)
//   29 DEVICE_INFO *pInformation;
//   30 /*  Points to the DEVICE_PROP structure of current device */
//   31 /*  The purpose of this register is to speed up the execution */
//   32 DEVICE_PROP *pProperty;
//   33 /*  Temporary save the state of Rx & Tx status. */
//   34 /*  Whenever the Rx or Tx state is changed, its value is saved */
//   35 /*  in this variable first and will be set to the EPRB or EPRA */
//   36 /*  at the end of interrupt process */
//   37 u16	SaveState ;
//   38 u16  wInterrupt_Mask;
//   39 DEVICE_INFO	Device_Info;
Device_Info:
        DS8 28
pInformation:
        DS8 4
pProperty:
        DS8 4
//   40 USER_STANDARD_REQUESTS  *pUser_Standard_Requests;
pUser_Standard_Requests:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(1)
SaveState:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(1)
wInterrupt_Mask:
        DS8 2
//   41 
//   42 /* Extern variables ----------------------------------------------------------*/
//   43 /* Private function prototypes -----------------------------------------------*/
//   44 /* Private functions ---------------------------------------------------------*/
//   45 
//   46 /*******************************************************************************
//   47 * Function Name  : USB_Init
//   48 * Description    : USB system initialization
//   49 * Input          : None.
//   50 * Output         : None.
//   51 * Return         : None.
//   52 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function USB_Init
        THUMB
//   53 void USB_Init(void)
//   54 {
//   55   pInformation = &Device_Info;
USB_Init:
        LDR.N    R0,??USB_Init_0  ;; Device_Info
        STR      R0,[R0, #+28]
//   56   pInformation->ControlState = 2;
        MOVS     R1,#+2
        STRB     R1,[R0, #+8]
//   57   pProperty = &Device_Property;
        LDR.N    R1,??USB_Init_0+0x4  ;; Device_Property
        STR      R1,[R0, #+32]
//   58   pUser_Standard_Requests = &User_Standard_Requests;
        LDR.N    R2,??USB_Init_0+0x8  ;; User_Standard_Requests
        STR      R2,[R0, #+36]
//   59   /* Initialize devices one by one */
//   60   pProperty->Init();
        LDR      R0,[R1, #+0]
        BX       R0
        DATA
??USB_Init_0:
        DC32     Device_Info
        DC32     Device_Property
        DC32     User_Standard_Requests
        CFI EndBlock cfiBlock0
//   61 }

        END
//   62 
//   63 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
// 45 bytes in section .bss
// 32 bytes in section .text
// 
// 32 bytes of CODE memory
// 45 bytes of DATA memory
//
//Errors: none
//Warnings: none
