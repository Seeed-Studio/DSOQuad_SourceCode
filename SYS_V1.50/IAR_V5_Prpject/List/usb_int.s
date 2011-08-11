///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:04:02 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\USBLib\src\usb_int.c                   /
//    Command line =  E:\Mini-DS\DS203\USBLib\src\usb_int.c -lA               /
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
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\usb_int. /
//                    s                                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME usb_int

        EXTERN EPindex
        EXTERN In0_Process
        EXTERN Out0_Process
        EXTERN Setup0_Process
        EXTERN pEpInt_IN
        EXTERN pEpInt_OUT
        EXTERN wIstr

        PUBLIC CTR_HP
        PUBLIC CTR_LP
        PUBLIC SaveRState
        PUBLIC SaveTState
        
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
        
// E:\Mini-DS\DS203\USBLib\src\usb_int.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : usb_int.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.2.1
//    5 * Date               : 09/22/2008
//    6 * Description        : Endpoint CTR (Low and High) interrupt's service routines
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

        SECTION `.bss`:DATA:NOROOT(1)
//   23 u16 SaveRState;
SaveRState:
        DS8 2
//   24 u16 SaveTState;
SaveTState:
        DS8 2
//   25 
//   26 /* Extern variables ----------------------------------------------------------*/
//   27 extern void (*pEpInt_IN[7])(void);    /*  Handles IN  interrupts   */
//   28 extern void (*pEpInt_OUT[7])(void);   /*  Handles OUT interrupts   */
//   29 
//   30 /* Private function prototypes -----------------------------------------------*/
//   31 /* Private functions ---------------------------------------------------------*/
//   32 
//   33 /*******************************************************************************
//   34 * Function Name  : CTR_LP.
//   35 * Description    : Low priority Endpoint Correct Transfer interrupt's service
//   36 *                  routine.
//   37 * Input          : None.
//   38 * Output         : None.
//   39 * Return         : None.
//   40 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function CTR_LP
        THUMB
//   41 void CTR_LP(void)
//   42 {
CTR_LP:
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
//   43   u32 wEPVal = 0;
        MOVW     R4,#+36799
        MOVW     R5,#+49039
        LDR.N    R6,??CTR_LP_0    ;; SaveRState
        LDR.W    R11,??DataTable6  ;; pEpInt_OUT
        LDR.N    R7,??DataTable13  ;; 0x40005c00
        LDR.W    R8,??DataTable7  ;; EPindex
        LDR.W    R9,??DataTable8  ;; wIstr
        B.N      ??CTR_LP_1
//   44   /* stay in loop while pending ints */
//   45   while (((wIstr = _GetISTR()) & ISTR_CTR) != 0)
//   46   {
//   47     _SetISTR((u16)CLR_CTR); /* clear CTR flag */
//   48     /* extract highest priority endpoint number */
//   49     EPindex = (u8)(wIstr & ISTR_EP_ID);
//   50     if (EPindex == 0)
//   51     {
//   52       /* Decode and service control endpoint interrupt */
//   53       /* calling related service routine */
//   54       /* (Setup0_Process, In0_Process, Out0_Process) */
//   55 
//   56       /* save RX & TX status */
//   57       /* and set both to NAK */
//   58       SaveRState = _GetEPRxStatus(ENDP0);
//   59       SaveTState = _GetEPTxStatus(ENDP0);
//   60       _SetEPRxStatus(ENDP0, EP_RX_NAK);
//   61       _SetEPTxStatus(ENDP0, EP_TX_NAK);
//   62 
//   63 
//   64       /* DIR bit = origin of the interrupt */
//   65 
//   66       if ((wIstr & ISTR_DIR) == 0)
//   67       {
//   68         /* DIR = 0 */
//   69 
//   70         /* DIR = 0      => IN  int */
//   71         /* DIR = 0 implies that (EP_CTR_TX = 1) always  */
//   72 
//   73 
//   74         _ClearEP_CTR_TX(ENDP0);
//   75         In0_Process();
//   76 
//   77            /* before terminate set Tx & Rx status */
//   78           _SetEPRxStatus(ENDP0, SaveRState);
//   79           _SetEPTxStatus(ENDP0, SaveTState);
//   80           return;
//   81       }
//   82       else
//   83       {
//   84         /* DIR = 1 */
//   85 
//   86         /* DIR = 1 & CTR_RX       => SETUP or OUT int */
//   87         /* DIR = 1 & (CTR_TX | CTR_RX) => 2 int pending */
//   88 
//   89         wEPVal = _GetENDPOINT(ENDP0);
//   90         if ((wEPVal & EP_CTR_TX) != 0)
//   91         {
//   92           _ClearEP_CTR_TX(ENDP0);
//   93           In0_Process();
//   94           /* before terminate set Tx & Rx status */
//   95           _SetEPRxStatus(ENDP0, SaveRState);
//   96           _SetEPTxStatus(ENDP0, SaveTState);
//   97           return;
//   98         }
//   99         else if ((wEPVal &EP_SETUP) != 0)
//  100         {
//  101           _ClearEP_CTR_RX(ENDP0); /* SETUP bit kept frozen while CTR_RX = 1 */
//  102           Setup0_Process();
//  103           /* before terminate set Tx & Rx status */
//  104           _SetEPRxStatus(ENDP0, SaveRState);
//  105           _SetEPTxStatus(ENDP0, SaveTState);
//  106           return;
//  107         }
//  108 
//  109         else if ((wEPVal & EP_CTR_RX) != 0)
//  110         {
//  111           _ClearEP_CTR_RX(ENDP0);
//  112           Out0_Process();
//  113           /* before terminate set Tx & Rx status */
//  114           _SetEPRxStatus(ENDP0, SaveRState);
//  115           _SetEPTxStatus(ENDP0, SaveTState);
//  116           return;
//  117         }
//  118       }
//  119     }/* if(EPindex == 0) */
//  120     else
//  121     {
//  122       /* Decode and service non control endpoints interrupt  */
//  123 
//  124       /* process related endpoint register */
//  125       wEPVal = _GetENDPOINT(EPindex);
??CTR_LP_2:
        LDR      R10,[R7, R0, LSL #+2]
        UXTH     R10,R10
//  126       if ((wEPVal & EP_CTR_RX) != 0)
        TST      R10,#0x8000
        BEQ.N    ??CTR_LP_3
//  127       {
//  128         /* clear int flag */
//  129         _ClearEP_CTR_RX(EPindex);
        LDR      R1,[R7, R0, LSL #+2]
        MOVW     R2,#+3983
        ANDS     R1,R2,R1
        STR      R1,[R7, R0, LSL #+2]
//  130 
//  131         /* call OUT service function */
//  132         (*pEpInt_OUT[EPindex-1])();
        ADD      R0,R11,R0, LSL #+2
        LDR      R0,[R0, #-4]
        BLX      R0
//  133 
//  134       } /* if((wEPVal & EP_CTR_RX) */
//  135 
//  136       if ((wEPVal & EP_CTR_TX) != 0)
??CTR_LP_3:
        TST      R10,#0x80
        BEQ.N    ??CTR_LP_1
        LDRB     R0,[R8, #+0]
        LDR      R1,[R7, R0, LSL #+2]
        MOVW     R2,#+36623
        ANDS     R1,R2,R1
        STR      R1,[R7, R0, LSL #+2]
//  137       {
//  138         /* clear int flag */
//  139         _ClearEP_CTR_TX(EPindex);
//  140 
//  141         /* call IN service function */
//  142         (*pEpInt_IN[EPindex-1])();
        LDR.N    R1,??DataTable5  ;; pEpInt_IN
        ADD      R0,R1,R0, LSL #+2
        LDR      R0,[R0, #-4]
        BLX      R0
//  143       } /* if((wEPVal & EP_CTR_TX) != 0) */
//  144 
//  145     }/* if(EPindex == 0) else */
??CTR_LP_1:
        LDR      R0,[R7, #+68]
        STRH     R0,[R9, #+0]
        TST      R0,#0x8000
        BEQ.W    ??CTR_LP_4
        MOVW     R1,#+32767
        STR      R1,[R7, #+68]
        LDRH     R0,[R9, #+0]
        ANDS     R0,R0,#0xF
        STRB     R0,[R8, #+0]
        BNE.N    ??CTR_LP_2
        LDR      R0,[R7, #+0]
        AND      R0,R0,#0x3000
        STRH     R0,[R6, #+0]
        LDR      R0,[R7, #+0]
        AND      R0,R0,#0x30
        STRH     R0,[R6, #+2]
        LDR      R0,[R7, #+0]
        ANDS     R0,R5,R0
        EOR      R0,R0,#0x2000
        STR      R0,[R7, #+0]
        LDR      R0,[R7, #+0]
        ANDS     R0,R4,R0
        EOR      R0,R0,#0x20
        STR      R0,[R7, #+0]
        LDRH     R0,[R9, #+0]
        TST      R0,#0x10
        BNE.N    ??CTR_LP_5
        LDR      R0,[R7, #+0]
        MOVW     R1,#+36623
        ANDS     R0,R1,R0
        STR      R0,[R7, #+0]
        BL       In0_Process
        LDR      R0,[R7, #+0]
        ANDS     R0,R5,R0
        LDRH     R1,[R6, #+0]
        TST      R1,#0x1000
        IT       NE 
        EORNE    R0,R0,#0x1000
        TST      R1,#0x2000
        ITT      NE 
        EORNE    R0,R0,#0x2000
        UXTHNE   R0,R0
        STR      R0,[R7, #+0]
        LDR      R0,[R7, #+0]
        ANDS     R0,R4,R0
        LDRH     R1,[R6, #+2]
        TST      R1,#0x10
        IT       NE 
        EORNE    R0,R0,#0x10
        TST      R1,#0x20
        ITT      NE 
        EORNE    R0,R0,#0x20
        UXTHNE   R0,R0
        B.N      ??CTR_LP_6
??CTR_LP_5:
        LDR      R10,[R7, #+0]
        UXTH     R10,R10
        TST      R10,#0x80
        BEQ.N    ??CTR_LP_7
        LDR      R0,[R7, #+0]
        MOVW     R1,#+36623
        ANDS     R0,R1,R0
        STR      R0,[R7, #+0]
        BL       In0_Process
        LDR      R0,[R7, #+0]
        ANDS     R0,R5,R0
        LDRH     R1,[R6, #+0]
        TST      R1,#0x1000
        IT       NE 
        EORNE    R0,R0,#0x1000
        TST      R1,#0x2000
        ITT      NE 
        EORNE    R0,R0,#0x2000
        UXTHNE   R0,R0
        STR      R0,[R7, #+0]
        LDR      R0,[R7, #+0]
        ANDS     R0,R4,R0
        LDRH     R1,[R6, #+2]
        TST      R1,#0x10
        IT       NE 
        EORNE    R0,R0,#0x10
        TST      R1,#0x20
        ITT      NE 
        EORNE    R0,R0,#0x20
        UXTHNE   R0,R0
        B.N      ??CTR_LP_6
??CTR_LP_7:
        TST      R10,#0x800
        BEQ.N    ??CTR_LP_8
        LDR      R0,[R7, #+0]
        MOVW     R1,#+3983
        ANDS     R0,R1,R0
        STR      R0,[R7, #+0]
        BL       Setup0_Process
        LDR      R0,[R7, #+0]
        ANDS     R0,R5,R0
        LDRH     R1,[R6, #+0]
        TST      R1,#0x1000
        IT       NE 
        EORNE    R0,R0,#0x1000
        TST      R1,#0x2000
        ITT      NE 
        EORNE    R0,R0,#0x2000
        UXTHNE   R0,R0
        STR      R0,[R7, #+0]
        LDR      R0,[R7, #+0]
        ANDS     R0,R4,R0
        LDRH     R1,[R6, #+2]
        TST      R1,#0x10
        IT       NE 
        EORNE    R0,R0,#0x10
        TST      R1,#0x20
        ITT      NE 
        EORNE    R0,R0,#0x20
        UXTHNE   R0,R0
        B.N      ??CTR_LP_6
??CTR_LP_8:
        TST      R10,#0x8000
        BEQ.W    ??CTR_LP_1
        LDR      R0,[R7, #+0]
        MOVW     R1,#+3983
        ANDS     R0,R1,R0
        STR      R0,[R7, #+0]
        BL       Out0_Process
        LDR      R0,[R7, #+0]
        ANDS     R0,R5,R0
        LDRH     R1,[R6, #+0]
        TST      R1,#0x1000
        IT       NE 
        EORNE    R0,R0,#0x1000
        TST      R1,#0x2000
        ITT      NE 
        EORNE    R0,R0,#0x2000
        UXTHNE   R0,R0
        STR      R0,[R7, #+0]
        LDR      R0,[R7, #+0]
        ANDS     R0,R4,R0
        LDRH     R1,[R6, #+2]
        TST      R1,#0x10
        IT       NE 
        EORNE    R0,R0,#0x10
        TST      R1,#0x20
        ITT      NE 
        EORNE    R0,R0,#0x20
        UXTHNE   R0,R0
??CTR_LP_6:
        STR      R0,[R7, #+0]
??CTR_LP_4:
        ADD      SP,SP,#+4
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        DATA
??CTR_LP_0:
        DC32     SaveRState
        CFI EndBlock cfiBlock0
//  146 
//  147   }/* while(...) */
//  148 }
//  149 
//  150 /*******************************************************************************
//  151 * Function Name  : CTR_HP.
//  152 * Description    : High Priority Endpoint Correct Transfer interrupt's service 
//  153 *                  routine.
//  154 * Input          : None.
//  155 * Output         : None.
//  156 * Return         : None.
//  157 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function CTR_HP
        THUMB
//  158 void CTR_HP(void)
//  159 {
CTR_HP:
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
//  160   u32 wEPVal = 0;
        LDR.N    R4,??DataTable5  ;; pEpInt_IN
        MOVW     R5,#+36623
        LDR.N    R6,??DataTable6  ;; pEpInt_OUT
        LDR.N    R7,??DataTable7  ;; EPindex
        LDR.W    R8,??DataTable8  ;; wIstr
        LDR.W    R9,??CTR_HP_0    ;; 0x40005c44
        B.N      ??CTR_HP_1
//  161 
//  162   while (((wIstr = _GetISTR()) & ISTR_CTR) != 0)
//  163   {
//  164     _SetISTR((u16)CLR_CTR); /* clear CTR flag */
//  165     /* extract highest priority endpoint number */
//  166     EPindex = (u8)(wIstr & ISTR_EP_ID);
//  167     /* process related endpoint register */
//  168     wEPVal = _GetENDPOINT(EPindex);
//  169     if ((wEPVal & EP_CTR_RX) != 0)
//  170     {
//  171       /* clear int flag */
//  172       _ClearEP_CTR_RX(EPindex);
??CTR_HP_2:
        LDR.N    R1,??DataTable13  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+3983
        ANDS     R1,R2,R1
        LDR.N    R2,??DataTable13  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  173 
//  174       /* call OUT service function */
//  175       (*pEpInt_OUT[EPindex-1])();
        ADD      R0,R6,R0, LSL #+2
        LDR      R0,[R0, #-4]
        BLX      R0
//  176 
//  177     } /* if((wEPVal & EP_CTR_RX) */
??CTR_HP_1:
        LDR      R0,[R9, #+0]
        STRH     R0,[R8, #+0]
        TST      R0,#0x8000
        BEQ.N    ??CTR_HP_3
        MOVW     R0,#+32767
        STR      R0,[R9, #+0]
        LDRH     R0,[R8, #+0]
        AND      R0,R0,#0xF
        STRB     R0,[R7, #+0]
        LDR.N    R1,??DataTable13  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        UXTH     R1,R1
        TST      R1,#0x8000
        BNE.N    ??CTR_HP_2
//  178     else if ((wEPVal & EP_CTR_TX) != 0)
        TST      R1,#0x80
        BEQ.N    ??CTR_HP_1
//  179     {
//  180       /* clear int flag */
//  181       _ClearEP_CTR_TX(EPindex);
        LDR.N    R1,??DataTable13  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        ANDS     R1,R5,R1
        LDR.N    R2,??DataTable13  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  182 
//  183       /* call IN service function */
//  184       (*pEpInt_IN[EPindex-1])();
        ADD      R0,R4,R0, LSL #+2
        LDR      R0,[R0, #-4]
        BLX      R0
        B.N      ??CTR_HP_1
//  185 
//  186 
//  187     } /* if((wEPVal & EP_CTR_TX) != 0) */
//  188 
//  189   }/* while(...) */
//  190 }
??CTR_HP_3:
        ADD      SP,SP,#+4
        CFI CFA R13+28
        POP      {R4-R9,PC}       ;; return
        Nop      
        DATA
??CTR_HP_0:
        DC32     0x40005c44
        CFI EndBlock cfiBlock1

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable5:
        DC32     pEpInt_IN

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable6:
        DC32     pEpInt_OUT

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7:
        DC32     EPindex

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     wIstr

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13:
        DC32     0x40005c00

        END
//  191 
//  192 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
//   4 bytes in section .bss
// 684 bytes in section .text
// 
// 684 bytes of CODE memory
//   4 bytes of DATA memory
//
//Errors: none
//Warnings: none
