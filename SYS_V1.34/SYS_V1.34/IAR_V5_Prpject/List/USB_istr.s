///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  14:17:23 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\SYS_V1.34\source\USB_istr.c                   /
//    Command line =  E:\DS0203\SYS_V1.34\source\USB_istr.c -lA               /
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
//    List file    =  E:\DS0203\SYS_V1.34\IAR_V5_Prpject\List\USB_istr.s      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME USB_istr

        EXTERN CTR_LP
        EXTERN Device_Property
        EXTERN EP1_IN_Callback
        EXTERN EP2_OUT_Callback
        EXTERN NOP_Process
        EXTERN wInterrupt_Mask

        PUBLIC USB_Istr
        PUBLIC bIntPackSOF
        PUBLIC pEpInt_IN
        PUBLIC pEpInt_OUT
        PUBLIC wIstr
        
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
        
// E:\DS0203\SYS_V1.34\source\USB_istr.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : usb_istr.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.2.1
//    5 * Date               : 09/22/2008
//    6 * Description        : ISTR events interrupt service routines
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
//   17 #include "USB_type.h"
//   18 #include "USB_regs.h"
//   19 #include "USB_pwr.h"
//   20 #include "USB_istr.h"
//   21 #include "USB_init.h"
//   22 #include "USB_int.h"
//   23 
//   24 /* Private typedef -----------------------------------------------------------*/
//   25 /* Private define ------------------------------------------------------------*/
//   26 /* Private macro -------------------------------------------------------------*/
//   27 /* Private variables ---------------------------------------------------------*/

        SECTION `.bss`:DATA:NOROOT(1)
//   28 volatile u16 wIstr;  /* ISTR register last read value */
wIstr:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(0)
//   29 volatile u8 bIntPackSOF = 0;  /* SOFs received between 2 consecutive packets */
bIntPackSOF:
        DS8 1
//   30 
//   31 /* Extern variables ----------------------------------------------------------*/
//   32 /* Private function prototypes -----------------------------------------------*/
//   33 /* Private functions ---------------------------------------------------------*/
//   34 /* function pointers to non-control endpoints service routines */

        SECTION `.data`:DATA:NOROOT(2)
//   35 void (*pEpInt_IN[7])(void) =
pEpInt_IN:
        DATA
        DC32 EP1_IN_Callback, NOP_Process, NOP_Process, NOP_Process
        DC32 NOP_Process, NOP_Process, NOP_Process
//   36   {
//   37     EP1_IN_Callback,
//   38     EP2_IN_Callback,
//   39     EP3_IN_Callback,
//   40     EP4_IN_Callback,
//   41     EP5_IN_Callback,
//   42     EP6_IN_Callback,
//   43     EP7_IN_Callback,
//   44   };
//   45 

        SECTION `.data`:DATA:NOROOT(2)
//   46 void (*pEpInt_OUT[7])(void) =
pEpInt_OUT:
        DATA
        DC32 NOP_Process, EP2_OUT_Callback, NOP_Process, NOP_Process
        DC32 NOP_Process, NOP_Process, NOP_Process
//   47   {
//   48     EP1_OUT_Callback,
//   49     EP2_OUT_Callback,
//   50     EP3_OUT_Callback,
//   51     EP4_OUT_Callback,
//   52     EP5_OUT_Callback,
//   53     EP6_OUT_Callback,
//   54     EP7_OUT_Callback,
//   55   };
//   56 
//   57 
//   58 /*******************************************************************************
//   59 * Function Name  : USB_Istr
//   60 * Description    : ISTR events interrupt service routine
//   61 * Input          : None.
//   62 * Output         : None.
//   63 * Return         : None.
//   64 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function USB_Istr
        THUMB
//   65 void USB_Istr(void)
//   66 {
USB_Istr:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//   67 
//   68   wIstr = _GetISTR();
        LDR.N    R4,??USB_Istr_0  ;; wIstr
        LDR.N    R0,??USB_Istr_0+0x4  ;; 0x40005c44
        LDR      R1,[R0, #+0]
        STRH     R1,[R4, #+0]
//   69 
//   70 #if (IMR_MSK & ISTR_RESET)
//   71   if (wIstr & ISTR_RESET & wInterrupt_Mask)
        LDR.N    R5,??USB_Istr_0+0x8  ;; wInterrupt_Mask
        LDRH     R1,[R4, #+0]
        LDRH     R2,[R5, #+0]
        ANDS     R1,R2,R1
        TST      R1,#0x400
        BEQ.N    ??USB_Istr_1
//   72   {
//   73     _SetISTR((u16)CLR_RESET);
        MOVW     R1,#+64511
        STR      R1,[R0, #+0]
//   74     Device_Property.Reset();
        LDR.N    R0,??USB_Istr_0+0xC  ;; Device_Property
        LDR      R0,[R0, #+4]
        BLX      R0
//   75 #ifdef RESET_CALLBACK
//   76     RESET_Callback();
//   77 #endif
//   78   }
//   79 #endif
//   80   /*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
//   81 #if (IMR_MSK & ISTR_DOVR)
//   82   if (wIstr & ISTR_DOVR & wInterrupt_Mask)
//   83   {
//   84     _SetISTR((u16)CLR_DOVR);
//   85 #ifdef DOVR_CALLBACK
//   86     DOVR_Callback();
//   87 #endif
//   88   }
//   89 #endif
//   90   /*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
//   91 #if (IMR_MSK & ISTR_ERR)
//   92   if (wIstr & ISTR_ERR & wInterrupt_Mask)
//   93   {
//   94     _SetISTR((u16)CLR_ERR);
//   95 #ifdef ERR_CALLBACK
//   96     ERR_Callback();
//   97 #endif
//   98   }
//   99 #endif
//  100   /*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
//  101 #if (IMR_MSK & ISTR_WKUP)
//  102   if (wIstr & ISTR_WKUP & wInterrupt_Mask)
//  103   {
//  104     _SetISTR((u16)CLR_WKUP);
//  105     Resume(RESUME_EXTERNAL);
//  106 #ifdef WKUP_CALLBACK
//  107     WKUP_Callback();
//  108 #endif
//  109   }
//  110 #endif
//  111   /*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
//  112 #if (IMR_MSK & ISTR_SUSP)
//  113   if (wIstr & ISTR_SUSP & wInterrupt_Mask)
//  114   {
//  115 
//  116     /* check if SUSPEND is possible */
//  117     if (fSuspendEnabled)
//  118     {
//  119       Suspend();
//  120     }
//  121     else
//  122     {
//  123       /* if not possible then resume after xx ms */
//  124       Resume(RESUME_LATER);
//  125     }
//  126     /* clear of the ISTR bit must be done after setting of CNTR_FSUSP */
//  127     _SetISTR((u16)CLR_SUSP);
//  128 #ifdef SUSP_CALLBACK
//  129     SUSP_Callback();
//  130 #endif
//  131   }
//  132 #endif
//  133   /*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
//  134 #if (IMR_MSK & ISTR_SOF)
//  135   if (wIstr & ISTR_SOF & wInterrupt_Mask)
//  136   {
//  137     _SetISTR((u16)CLR_SOF);
//  138     bIntPackSOF++;
//  139 
//  140 #ifdef SOF_CALLBACK
//  141     SOF_Callback();
//  142 #endif
//  143   }
//  144 #endif
//  145   /*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
//  146 #if (IMR_MSK & ISTR_ESOF)
//  147   if (wIstr & ISTR_ESOF & wInterrupt_Mask)
//  148   {
//  149     _SetISTR((u16)CLR_ESOF);
//  150     /* resume handling timing is made with ESOFs */
//  151     Resume(RESUME_ESOF); /* request without change of the machine state */
//  152 
//  153 #ifdef ESOF_CALLBACK
//  154     ESOF_Callback();
//  155 #endif
//  156   }
//  157 #endif
//  158   /*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
//  159 #if (IMR_MSK & ISTR_CTR)
//  160   if (wIstr & ISTR_CTR & wInterrupt_Mask)
??USB_Istr_1:
        LDRH     R0,[R4, #+0]
        LDRH     R1,[R5, #+0]
        ANDS     R0,R1,R0
        TST      R0,#0x8000
        IT       NE 
//  161   {
//  162     /* servicing of the endpoint correct transfer interrupt */
//  163     /* clear of the CTR flag into the sub */
//  164     CTR_LP();
        BLNE     CTR_LP
//  165 #ifdef CTR_CALLBACK
//  166     CTR_Callback();
//  167 #endif
//  168   }
//  169 #endif
//  170 } /* USB_Istr */
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        Nop      
        DATA
??USB_Istr_0:
        DC32     wIstr
        DC32     0x40005c44
        DC32     wInterrupt_Mask
        DC32     Device_Property
        CFI EndBlock cfiBlock0

        END
//  171 
//  172 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
//  173 
// 
//  3 bytes in section .bss
// 56 bytes in section .data
// 76 bytes in section .text
// 
// 76 bytes of CODE memory
// 59 bytes of DATA memory
//
//Errors: none
//Warnings: none
