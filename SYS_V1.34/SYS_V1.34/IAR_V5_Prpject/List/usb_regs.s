///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  14:17:55 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\USBLib\src\usb_regs.c                         /
//    Command line =  E:\DS0203\USBLib\src\usb_regs.c -lA                     /
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
//    List file    =  E:\DS0203\SYS_V1.34\IAR_V5_Prpject\List\usb_regs.s      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME usb_regs

        PUBLIC ByteSwap
        PUBLIC ClearDTOG_RX
        PUBLIC ClearDTOG_TX
        PUBLIC ClearEPDoubleBuff
        PUBLIC ClearEP_CTR_RX
        PUBLIC ClearEP_CTR_TX
        PUBLIC ClearEP_KIND
        PUBLIC Clear_Status_Out
        PUBLIC FreeUserBuffer
        PUBLIC GetBTABLE
        PUBLIC GetCNTR
        PUBLIC GetDADDR
        PUBLIC GetENDPOINT
        PUBLIC GetEPAddress
        PUBLIC GetEPDblBuf0Addr
        PUBLIC GetEPDblBuf0Count
        PUBLIC GetEPDblBuf1Addr
        PUBLIC GetEPDblBuf1Count
        PUBLIC GetEPDblBufDir
        PUBLIC GetEPRxAddr
        PUBLIC GetEPRxCount
        PUBLIC GetEPRxStatus
        PUBLIC GetEPTxAddr
        PUBLIC GetEPTxCount
        PUBLIC GetEPTxStatus
        PUBLIC GetEPType
        PUBLIC GetFNR
        PUBLIC GetISTR
        PUBLIC GetRxStallStatus
        PUBLIC GetTxStallStatus
        PUBLIC SetBTABLE
        PUBLIC SetCNTR
        PUBLIC SetDADDR
        PUBLIC SetDouBleBuffEPStall
        PUBLIC SetENDPOINT
        PUBLIC SetEPAddress
        PUBLIC SetEPCountRxReg
        PUBLIC SetEPDblBuf0Addr
        PUBLIC SetEPDblBuf0Count
        PUBLIC SetEPDblBuf1Addr
        PUBLIC SetEPDblBuf1Count
        PUBLIC SetEPDblBuffAddr
        PUBLIC SetEPDblBuffCount
        PUBLIC SetEPDoubleBuff
        PUBLIC SetEPRxAddr
        PUBLIC SetEPRxCount
        PUBLIC SetEPRxStatus
        PUBLIC SetEPRxValid
        PUBLIC SetEPTxAddr
        PUBLIC SetEPTxCount
        PUBLIC SetEPTxStatus
        PUBLIC SetEPTxValid
        PUBLIC SetEPType
        PUBLIC SetEP_KIND
        PUBLIC SetISTR
        PUBLIC Set_Status_Out
        PUBLIC ToWord
        PUBLIC ToggleDTOG_RX
        PUBLIC ToggleDTOG_TX
        
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
        
// E:\DS0203\USBLib\src\usb_regs.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : usb_regs.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.2.1
//    5 * Date               : 09/22/2008
//    6 * Description        : Interface functions to USB cell registers
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
//   26 
//   27 /*******************************************************************************
//   28 * Function Name  : SetCNTR.
//   29 * Description    : Set the CNTR register value.
//   30 * Input          : wRegValue: new register value.
//   31 * Output         : None.
//   32 * Return         : None.
//   33 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function SetCNTR
        THUMB
//   34 void SetCNTR(u16 wRegValue)
//   35 {
//   36   _SetCNTR(wRegValue);
SetCNTR:
        LDR.N    R1,??DataTable1  ;; 0x40005c40
        STR      R0,[R1, #+0]
//   37 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//   38 
//   39 /*******************************************************************************
//   40 * Function Name  : GetCNTR.
//   41 * Description    : returns the CNTR register value.
//   42 * Input          : None.
//   43 * Output         : None.
//   44 * Return         : CNTR register Value.
//   45 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function GetCNTR
        THUMB
//   46 u16 GetCNTR(void)
//   47 {
//   48   return(_GetCNTR());
GetCNTR:
        LDR.N    R0,??DataTable1  ;; 0x40005c40
        LDR      R0,[R0, #+0]
        UXTH     R0,R0
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//   49 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable1:
        DC32     0x40005c40
//   50 
//   51 /*******************************************************************************
//   52 * Function Name  : SetISTR.
//   53 * Description    : Set the ISTR register value.
//   54 * Input          : wRegValue: new register value.
//   55 * Output         : None.
//   56 * Return         : None.
//   57 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function SetISTR
        THUMB
//   58 void SetISTR(u16 wRegValue)
//   59 {
//   60   _SetISTR(wRegValue);
SetISTR:
        LDR.N    R1,??DataTable3  ;; 0x40005c44
        STR      R0,[R1, #+0]
//   61 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//   62 
//   63 /*******************************************************************************
//   64 * Function Name  : GetISTR
//   65 * Description    : Returns the ISTR register value.
//   66 * Input          : None.
//   67 * Output         : None.
//   68 * Return         : ISTR register Value
//   69 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function GetISTR
        THUMB
//   70 u16 GetISTR(void)
//   71 {
//   72   return(_GetISTR());
GetISTR:
        LDR.N    R0,??DataTable3  ;; 0x40005c44
        LDR      R0,[R0, #+0]
        UXTH     R0,R0
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//   73 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable3:
        DC32     0x40005c44
//   74 
//   75 /*******************************************************************************
//   76 * Function Name  : GetFNR
//   77 * Description    : Returns the FNR register value.
//   78 * Input          : None.
//   79 * Output         : None.
//   80 * Return         : FNR register Value
//   81 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function GetFNR
        THUMB
//   82 u16 GetFNR(void)
//   83 {
//   84   return(_GetFNR());
GetFNR:
        LDR.N    R0,??GetFNR_0    ;; 0x40005c48
        LDR      R0,[R0, #+0]
        UXTH     R0,R0
        BX       LR               ;; return
        DATA
??GetFNR_0:
        DC32     0x40005c48
        CFI EndBlock cfiBlock4
//   85 }
//   86 
//   87 /*******************************************************************************
//   88 * Function Name  : SetDADDR
//   89 * Description    : Set the DADDR register value.
//   90 * Input          : wRegValue: new register value.
//   91 * Output         : None.
//   92 * Return         : None.
//   93 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function SetDADDR
        THUMB
//   94 void SetDADDR(u16 wRegValue)
//   95 {
//   96   _SetDADDR(wRegValue);
SetDADDR:
        LDR.N    R1,??DataTable5  ;; 0x40005c4c
        STR      R0,[R1, #+0]
//   97 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//   98 
//   99 /*******************************************************************************
//  100 * Function Name  : GetDADDR
//  101 * Description    : Returns the DADDR register value.
//  102 * Input          : None.
//  103 * Output         : None.
//  104 * Return         : DADDR register Value
//  105 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function GetDADDR
        THUMB
//  106 u16 GetDADDR(void)
//  107 {
//  108   return(_GetDADDR());
GetDADDR:
        LDR.N    R0,??DataTable5  ;; 0x40005c4c
        LDR      R0,[R0, #+0]
        UXTH     R0,R0
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  109 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable5:
        DC32     0x40005c4c
//  110 
//  111 /*******************************************************************************
//  112 * Function Name  : SetBTABLE
//  113 * Description    : Set the BTABLE.
//  114 * Input          : wRegValue: New register value.
//  115 * Output         : None.
//  116 * Return         : None.
//  117 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function SetBTABLE
        THUMB
//  118 void SetBTABLE(u16 wRegValue)
//  119 {
//  120   _SetBTABLE(wRegValue);
SetBTABLE:
        MOVW     R1,#+65528
        ANDS     R0,R1,R0
        LDR.W    R1,??DataTable101  ;; 0x40005c50
        STR      R0,[R1, #+0]
//  121 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  122 
//  123 /*******************************************************************************
//  124 * Function Name  : GetBTABLE.
//  125 * Description    : Returns the BTABLE register value.
//  126 * Input          : None. 
//  127 * Output         : None.
//  128 * Return         : BTABLE address.
//  129 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function GetBTABLE
        THUMB
//  130 u16 GetBTABLE(void)
//  131 {
//  132   return(_GetBTABLE());
GetBTABLE:
        LDR.W    R0,??DataTable101  ;; 0x40005c50
        LDR      R0,[R0, #+0]
        UXTH     R0,R0
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  133 }
//  134 
//  135 /*******************************************************************************
//  136 * Function Name  : SetENDPOINT
//  137 * Description    : Setthe Endpoint register value.
//  138 * Input          : bEpNum: Endpoint Number. 
//  139 *                  wRegValue.
//  140 * Output         : None.
//  141 * Return         : None.
//  142 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function SetENDPOINT
        THUMB
//  143 void SetENDPOINT(u8 bEpNum, u16 wRegValue)
//  144 {
//  145   _SetENDPOINT(bEpNum, wRegValue);
SetENDPOINT:
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  146 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//  147 
//  148 /*******************************************************************************
//  149 * Function Name  : GetENDPOINT
//  150 * Description    : Return the Endpoint register value.
//  151 * Input          : bEpNum: Endpoint Number. 
//  152 * Output         : None.
//  153 * Return         : Endpoint register value.
//  154 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function GetENDPOINT
        THUMB
//  155 u16 GetENDPOINT(u8 bEpNum)
//  156 {
//  157   return(_GetENDPOINT(bEpNum));
GetENDPOINT:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R0,[R1, R0, LSL #+2]
        UXTH     R0,R0
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  158 }
//  159 
//  160 /*******************************************************************************
//  161 * Function Name  : SetEPType
//  162 * Description    : sets the type in the endpoint register.
//  163 * Input          : bEpNum: Endpoint Number. 
//  164 *                  wType: type definition.
//  165 * Output         : None.
//  166 * Return         : None.
//  167 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function SetEPType
        THUMB
//  168 void SetEPType(u8 bEpNum, u16 wType)
//  169 {
//  170   _SetEPType(bEpNum, wType);
SetEPType:
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        LDR      R2,[R2, R0, LSL #+2]
        MOVW     R3,#+35215
        ANDS     R2,R3,R2
        ORRS     R1,R1,R2
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  171 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//  172 
//  173 /*******************************************************************************
//  174 * Function Name  : GetEPType
//  175 * Description    : Returns the endpoint type.
//  176 * Input          : bEpNum: Endpoint Number. 
//  177 * Output         : None.
//  178 * Return         : Endpoint Type
//  179 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function GetEPType
        THUMB
//  180 u16 GetEPType(u8 bEpNum)
//  181 {
//  182   return(_GetEPType(bEpNum));
GetEPType:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R0,[R1, R0, LSL #+2]
        AND      R0,R0,#0x600
        BX       LR               ;; return
        CFI EndBlock cfiBlock12
//  183 }
//  184 
//  185 /*******************************************************************************
//  186 * Function Name  : SetEPTxStatus
//  187 * Description    : Set the status of Tx endpoint.
//  188 * Input          : bEpNum: Endpoint Number. 
//  189 *                  wState: new state.
//  190 * Output         : None.
//  191 * Return         : None.
//  192 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function SetEPTxStatus
        THUMB
//  193 void SetEPTxStatus(u8 bEpNum, u16 wState)
//  194 {
//  195   _SetEPTxStatus(bEpNum, wState);
SetEPTxStatus:
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        LDR      R2,[R2, R0, LSL #+2]
        MOVW     R3,#+36799
        ANDS     R2,R3,R2
        TST      R1,#0x10
        IT       NE 
        EORNE    R2,R2,#0x10
        TST      R1,#0x20
        ITT      NE 
        EORNE    R2,R2,#0x20
        UXTHNE   R2,R2
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        STR      R2,[R1, R0, LSL #+2]
//  196 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock13
//  197 
//  198 /*******************************************************************************
//  199 * Function Name  : SetEPRxStatus
//  200 * Description    : Set the status of Rx endpoint.
//  201 * Input          : bEpNum: Endpoint Number. 
//  202 *                  wState: new state.
//  203 * Output         : None.
//  204 * Return         : None.
//  205 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function SetEPRxStatus
        THUMB
//  206 void SetEPRxStatus(u8 bEpNum, u16 wState)
//  207 {
//  208   _SetEPRxStatus(bEpNum, wState);
SetEPRxStatus:
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        LDR      R2,[R2, R0, LSL #+2]
        MOVW     R3,#+49039
        ANDS     R2,R3,R2
        TST      R1,#0x1000
        IT       NE 
        EORNE    R2,R2,#0x1000
        TST      R1,#0x2000
        ITT      NE 
        EORNE    R2,R2,#0x2000
        UXTHNE   R2,R2
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        STR      R2,[R1, R0, LSL #+2]
//  209 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock14
//  210 
//  211 /*******************************************************************************
//  212 * Function Name  : SetDouBleBuffEPStall
//  213 * Description    : sets the status for Double Buffer Endpoint to STALL
//  214 * Input          : bEpNum: Endpoint Number. 
//  215 *                  bDir: Endpoint direction.
//  216 * Output         : None.
//  217 * Return         : None.
//  218 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function SetDouBleBuffEPStall
        THUMB
//  219 void SetDouBleBuffEPStall(u8 bEpNum, u8 bDir)
//  220 {
SetDouBleBuffEPStall:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
        MOVS     R5,R0
        MOVS     R4,R1
//  221   u16 Endpoint_DTOG_Status;
//  222   Endpoint_DTOG_Status = GetENDPOINT(bEpNum);
        BL       GetENDPOINT
//  223   if (bDir == EP_DBUF_OUT)
        CMP      R4,#+1
        BNE.N    ??SetDouBleBuffEPStall_0
//  224   { /* OUT double buffered endpoint */
//  225     _SetENDPOINT(bEpNum, Endpoint_DTOG_Status & ~EPRX_DTOG1);
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        MVN      R2,#+4096
        ANDS     R0,R2,R0
        STR      R0,[R1, R5, LSL #+2]
        B.N      ??SetDouBleBuffEPStall_1
//  226   }
//  227   else if (bDir == EP_DBUF_IN)
??SetDouBleBuffEPStall_0:
        CMP      R4,#+2
        BNE.N    ??SetDouBleBuffEPStall_1
//  228   { /* IN double buffered endpoint */
//  229     _SetENDPOINT(bEpNum, Endpoint_DTOG_Status & ~EPTX_DTOG1);
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        MOVS     R2,#+16
        BICS     R0,R0,R2
        STR      R0,[R1, R5, LSL #+2]
//  230   }
//  231 }
??SetDouBleBuffEPStall_1:
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        CFI EndBlock cfiBlock15
//  232 
//  233 /*******************************************************************************
//  234 * Function Name  : GetEPTxStatus
//  235 * Description    : Returns the endpoint Tx status.
//  236 * Input          : bEpNum: Endpoint Number. 
//  237 * Output         : None.
//  238 * Return         : Endpoint TX Status
//  239 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function GetEPTxStatus
        THUMB
//  240 u16 GetEPTxStatus(u8 bEpNum)
//  241 {
//  242   return(_GetEPTxStatus(bEpNum));
GetEPTxStatus:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R0,[R1, R0, LSL #+2]
        AND      R0,R0,#0x30
        BX       LR               ;; return
        CFI EndBlock cfiBlock16
//  243 }
//  244 
//  245 /*******************************************************************************
//  246 * Function Name  : GetEPRxStatus
//  247 * Description    : Returns the endpoint Rx status.
//  248 * Input          : bEpNum: Endpoint Number. 
//  249 * Output         : None.
//  250 * Return         : Endpoint RX Status
//  251 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function GetEPRxStatus
        THUMB
//  252 u16 GetEPRxStatus(u8 bEpNum)
//  253 {
//  254   return(_GetEPRxStatus(bEpNum));
GetEPRxStatus:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R0,[R1, R0, LSL #+2]
        AND      R0,R0,#0x3000
        BX       LR               ;; return
        CFI EndBlock cfiBlock17
//  255 }
//  256 
//  257 /*******************************************************************************
//  258 * Function Name  : SetEPTxValid
//  259 * Description    : Valid the endpoint Tx Status.
//  260 * Input          : bEpNum: Endpoint Number.  
//  261 * Output         : None.
//  262 * Return         : None.
//  263 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function SetEPTxValid
        THUMB
//  264 void SetEPTxValid(u8 bEpNum)
//  265 {
//  266   _SetEPTxStatus(bEpNum, EP_TX_VALID);
SetEPTxValid:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+36799
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        EOR      R1,R1,#0x30
        STR      R1,[R2, R0, LSL #+2]
//  267 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock18
//  268 
//  269 /*******************************************************************************
//  270 * Function Name  : SetEPRxValid
//  271 * Description    : Valid the endpoint Rx Status.
//  272 * Input          : bEpNum: Endpoint Number. 
//  273 * Output         : None.
//  274 * Return         : None.
//  275 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI Function SetEPRxValid
        THUMB
//  276 void SetEPRxValid(u8 bEpNum)
//  277 {
//  278   _SetEPRxStatus(bEpNum, EP_RX_VALID);
SetEPRxValid:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+49039
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        EOR      R1,R1,#0x3000
        STR      R1,[R2, R0, LSL #+2]
//  279 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock19
//  280 
//  281 /*******************************************************************************
//  282 * Function Name  : SetEP_KIND
//  283 * Description    : Clear the EP_KIND bit.
//  284 * Input          : bEpNum: Endpoint Number. 
//  285 * Output         : None.
//  286 * Return         : None.
//  287 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock20 Using cfiCommon0
        CFI Function SetEP_KIND
        THUMB
//  288 void SetEP_KIND(u8 bEpNum)
//  289 {
//  290   _SetEP_KIND(bEpNum);
SetEP_KIND:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        ORR      R1,R1,#0x100
        MOVW     R2,#+36751
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  291 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock20
//  292 
//  293 /*******************************************************************************
//  294 * Function Name  : ClearEP_KIND
//  295 * Description    : set the  EP_KIND bit.
//  296 * Input          : bEpNum: Endpoint Number. 
//  297 * Output         : None.
//  298 * Return         : None.
//  299 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock21 Using cfiCommon0
        CFI Function ClearEP_KIND
        THUMB
//  300 void ClearEP_KIND(u8 bEpNum)
//  301 {
//  302   _ClearEP_KIND(bEpNum);
ClearEP_KIND:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+36495
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  303 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock21
//  304 /*******************************************************************************
//  305 * Function Name  : Clear_Status_Out
//  306 * Description    : Clear the Status Out of the related Endpoint
//  307 * Input          : bEpNum: Endpoint Number. 
//  308 * Output         : None.
//  309 * Return         : None.
//  310 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock22 Using cfiCommon0
        CFI Function Clear_Status_Out
        THUMB
//  311 void Clear_Status_Out(u8 bEpNum)
//  312 {
//  313   _ClearEP_KIND(bEpNum);
Clear_Status_Out:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+36495
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  314 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock22
//  315 /*******************************************************************************
//  316 * Function Name  : Set_Status_Out
//  317 * Description    : Set the Status Out of the related Endpoint
//  318 * Input          : bEpNum: Endpoint Number. 
//  319 * Output         : None.
//  320 * Return         : None.
//  321 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock23 Using cfiCommon0
        CFI Function Set_Status_Out
        THUMB
//  322 void Set_Status_Out(u8 bEpNum)
//  323 {
//  324   _SetEP_KIND(bEpNum);
Set_Status_Out:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        ORR      R1,R1,#0x100
        MOVW     R2,#+36751
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  325 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock23
//  326 /*******************************************************************************
//  327 * Function Name  : SetEPDoubleBuff
//  328 * Description    : Enable the double buffer feature for the endpoint. 
//  329 * Input          : bEpNum: Endpoint Number. 
//  330 * Output         : None.
//  331 * Return         : None.
//  332 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock24 Using cfiCommon0
        CFI Function SetEPDoubleBuff
        THUMB
//  333 void SetEPDoubleBuff(u8 bEpNum)
//  334 {
//  335   _SetEP_KIND(bEpNum);
SetEPDoubleBuff:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        ORR      R1,R1,#0x100
        MOVW     R2,#+36751
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  336 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock24
//  337 /*******************************************************************************
//  338 * Function Name  : ClearEPDoubleBuff
//  339 * Description    : Disable the double buffer feature for the endpoint. 
//  340 * Input          : bEpNum: Endpoint Number. 
//  341 * Output         : None.
//  342 * Return         : None.
//  343 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock25 Using cfiCommon0
        CFI Function ClearEPDoubleBuff
        THUMB
//  344 void ClearEPDoubleBuff(u8 bEpNum)
//  345 {
//  346   _ClearEP_KIND(bEpNum);
ClearEPDoubleBuff:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+36495
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  347 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock25
//  348 /*******************************************************************************
//  349 * Function Name  : GetTxStallStatus
//  350 * Description    : Returns the Stall status of the Tx endpoint.
//  351 * Input          : bEpNum: Endpoint Number. 
//  352 * Output         : None.
//  353 * Return         : Tx Stall status.
//  354 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock26 Using cfiCommon0
        CFI Function GetTxStallStatus
        THUMB
//  355 u16 GetTxStallStatus(u8 bEpNum)
//  356 {
//  357   return(_GetTxStallStatus(bEpNum));
GetTxStallStatus:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R0,[R1, R0, LSL #+2]
        AND      R0,R0,#0x30
        CMP      R0,#+16
        BNE.N    ??GetTxStallStatus_0
        MOVS     R0,#+1
        BX       LR
??GetTxStallStatus_0:
        MOVS     R0,#+0
??GetTxStallStatus_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock26
//  358 }
//  359 /*******************************************************************************
//  360 * Function Name  : GetRxStallStatus
//  361 * Description    : Returns the Stall status of the Rx endpoint. 
//  362 * Input          : bEpNum: Endpoint Number. 
//  363 * Output         : None.
//  364 * Return         : Rx Stall status.
//  365 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock27 Using cfiCommon0
        CFI Function GetRxStallStatus
        THUMB
//  366 u16 GetRxStallStatus(u8 bEpNum)
//  367 {
//  368   return(_GetRxStallStatus(bEpNum));
GetRxStallStatus:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R0,[R1, R0, LSL #+2]
        AND      R0,R0,#0x3000
        CMP      R0,#+4096
        BNE.N    ??GetRxStallStatus_0
        MOVS     R0,#+1
        BX       LR
??GetRxStallStatus_0:
        MOVS     R0,#+0
??GetRxStallStatus_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock27
//  369 }
//  370 /*******************************************************************************
//  371 * Function Name  : ClearEP_CTR_RX
//  372 * Description    : Clear the CTR_RX bit.
//  373 * Input          : bEpNum: Endpoint Number. 
//  374 * Output         : None.
//  375 * Return         : None.
//  376 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock28 Using cfiCommon0
        CFI Function ClearEP_CTR_RX
        THUMB
//  377 void ClearEP_CTR_RX(u8 bEpNum)
//  378 {
//  379   _ClearEP_CTR_RX(bEpNum);
ClearEP_CTR_RX:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+3983
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  380 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock28
//  381 /*******************************************************************************
//  382 * Function Name  : ClearEP_CTR_TX
//  383 * Description    : Clear the CTR_TX bit.
//  384 * Input          : bEpNum: Endpoint Number. 
//  385 * Output         : None.
//  386 * Return         : None.
//  387 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock29 Using cfiCommon0
        CFI Function ClearEP_CTR_TX
        THUMB
//  388 void ClearEP_CTR_TX(u8 bEpNum)
//  389 {
//  390   _ClearEP_CTR_TX(bEpNum);
ClearEP_CTR_TX:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+36623
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  391 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock29
//  392 /*******************************************************************************
//  393 * Function Name  : ToggleDTOG_RX
//  394 * Description    : Toggle the DTOG_RX bit.
//  395 * Input          : bEpNum: Endpoint Number. 
//  396 * Output         : None.
//  397 * Return         : None.
//  398 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock30 Using cfiCommon0
        CFI Function ToggleDTOG_RX
        THUMB
//  399 void ToggleDTOG_RX(u8 bEpNum)
//  400 {
//  401   _ToggleDTOG_RX(bEpNum);
ToggleDTOG_RX:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+36751
        ANDS     R1,R2,R1
        ORR      R1,R1,#0x4000
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  402 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock30
//  403 /*******************************************************************************
//  404 * Function Name  : ToggleDTOG_TX
//  405 * Description    : Toggle the DTOG_TX bit.
//  406 * Input          : bEpNum: Endpoint Number. 
//  407 * Output         : None.
//  408 * Return         : None.
//  409 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock31 Using cfiCommon0
        CFI Function ToggleDTOG_TX
        THUMB
//  410 void ToggleDTOG_TX(u8 bEpNum)
//  411 {
//  412   _ToggleDTOG_TX(bEpNum);
ToggleDTOG_TX:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+36751
        ANDS     R1,R2,R1
        ORR      R1,R1,#0x40
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  413 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock31
//  414 /*******************************************************************************
//  415 * Function Name  : ClearDTOG_RX.
//  416 * Description    : Clear the DTOG_RX bit.
//  417 * Input          : bEpNum: Endpoint Number. 
//  418 * Output         : None.
//  419 * Return         : None.
//  420 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock32 Using cfiCommon0
        CFI Function ClearDTOG_RX
        THUMB
//  421 void ClearDTOG_RX(u8 bEpNum)
//  422 {
//  423   _ClearDTOG_RX(bEpNum);
ClearDTOG_RX:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        TST      R1,#0x4000
        BEQ.N    ??ClearDTOG_RX_0
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+36751
        ANDS     R1,R2,R1
        ORR      R1,R1,#0x4000
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  424 }
??ClearDTOG_RX_0:
        BX       LR               ;; return
        CFI EndBlock cfiBlock32
//  425 /*******************************************************************************
//  426 * Function Name  : ClearDTOG_TX.
//  427 * Description    : Clear the DTOG_TX bit.
//  428 * Input          : bEpNum: Endpoint Number. 
//  429 * Output         : None.
//  430 * Return         : None.
//  431 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock33 Using cfiCommon0
        CFI Function ClearDTOG_TX
        THUMB
//  432 void ClearDTOG_TX(u8 bEpNum)
//  433 {
//  434   _ClearDTOG_TX(bEpNum);
ClearDTOG_TX:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        TST      R1,#0x40
        BEQ.N    ??ClearDTOG_TX_0
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+36751
        ANDS     R1,R2,R1
        ORR      R1,R1,#0x40
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  435 }
??ClearDTOG_TX_0:
        BX       LR               ;; return
        CFI EndBlock cfiBlock33
//  436 /*******************************************************************************
//  437 * Function Name  : SetEPAddress
//  438 * Description    : Set the endpoint address.
//  439 * Input          : bEpNum: Endpoint Number.
//  440 *                  bAddr: New endpoint address.
//  441 * Output         : None.
//  442 * Return         : None.
//  443 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock34 Using cfiCommon0
        CFI Function SetEPAddress
        THUMB
//  444 void SetEPAddress(u8 bEpNum, u8 bAddr)
//  445 {
//  446   _SetEPAddress(bEpNum, bAddr);
SetEPAddress:
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        LDR      R2,[R2, R0, LSL #+2]
        MOVW     R3,#+36751
        ANDS     R2,R3,R2
        ORRS     R1,R1,R2
        LDR.W    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  447 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock34
//  448 /*******************************************************************************
//  449 * Function Name  : GetEPAddress
//  450 * Description    : Get the endpoint address.
//  451 * Input          : bEpNum: Endpoint Number. 
//  452 * Output         : None.
//  453 * Return         : Endpoint address.
//  454 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock35 Using cfiCommon0
        CFI Function GetEPAddress
        THUMB
//  455 u8 GetEPAddress(u8 bEpNum)
//  456 {
//  457   return(_GetEPAddress(bEpNum));
GetEPAddress:
        LDR.W    R1,??DataTable107  ;; 0x40005c00
        LDR      R0,[R1, R0, LSL #+2]
        AND      R0,R0,#0xF
        BX       LR               ;; return
        CFI EndBlock cfiBlock35
//  458 }
//  459 /*******************************************************************************
//  460 * Function Name  : SetEPTxAddr
//  461 * Description    : Set the endpoint Tx buffer address.
//  462 * Input          : bEpNum: Endpoint Number.
//  463 *                  wAddr: new address. 
//  464 * Output         : None.
//  465 * Return         : None.
//  466 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock36 Using cfiCommon0
        CFI Function SetEPTxAddr
        THUMB
//  467 void SetEPTxAddr(u8 bEpNum, u16 wAddr)
//  468 {
//  469   _SetEPTxAddr(bEpNum, wAddr);
SetEPTxAddr:
        LDR.N    R2,??DataTable101  ;; 0x40005c50
        LDR      R2,[R2, #+0]
        UXTH     R2,R2
        ADD      R0,R2,R0, LSL #+3
        LDR.N    R2,??DataTable80  ;; 0x40006000
        LSRS     R1,R1,#+1
        LSLS     R1,R1,#+1
        STR      R1,[R2, R0, LSL #+1]
//  470 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock36
//  471 /*******************************************************************************
//  472 * Function Name  : SetEPRxAddr
//  473 * Description    : Set the endpoint Rx buffer address.
//  474 * Input          : bEpNum: Endpoint Number.
//  475 *                  wAddr: new address.
//  476 * Output         : None.
//  477 * Return         : None.
//  478 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock37 Using cfiCommon0
        CFI Function SetEPRxAddr
        THUMB
//  479 void SetEPRxAddr(u8 bEpNum, u16 wAddr)
//  480 {
//  481   _SetEPRxAddr(bEpNum, wAddr);
SetEPRxAddr:
        LDR.N    R2,??DataTable101  ;; 0x40005c50
        LDR      R2,[R2, #+0]
        UXTH     R2,R2
        ADD      R0,R2,R0, LSL #+3
        LDR.N    R2,??DataTable82  ;; 0x40006008
        LSRS     R1,R1,#+1
        LSLS     R1,R1,#+1
        STR      R1,[R2, R0, LSL #+1]
//  482 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock37
//  483 /*******************************************************************************
//  484 * Function Name  : GetEPTxAddr
//  485 * Description    : Returns the endpoint Tx buffer address.
//  486 * Input          : bEpNum: Endpoint Number. 
//  487 * Output         : None.
//  488 * Return         : Rx buffer address. 
//  489 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock38 Using cfiCommon0
        CFI Function GetEPTxAddr
        THUMB
//  490 u16 GetEPTxAddr(u8 bEpNum)
//  491 {
//  492   return(_GetEPTxAddr(bEpNum));
GetEPTxAddr:
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable80  ;; 0x40006000
        LDR      R0,[R1, R0, LSL #+1]
        UXTH     R0,R0
        BX       LR               ;; return
        CFI EndBlock cfiBlock38
//  493 }
//  494 /*******************************************************************************
//  495 * Function Name  : GetEPRxAddr.
//  496 * Description    : Returns the endpoint Rx buffer address.
//  497 * Input          : bEpNum: Endpoint Number. 
//  498 * Output         : None.
//  499 * Return         : Rx buffer address.
//  500 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock39 Using cfiCommon0
        CFI Function GetEPRxAddr
        THUMB
//  501 u16 GetEPRxAddr(u8 bEpNum)
//  502 {
//  503   return(_GetEPRxAddr(bEpNum));
GetEPRxAddr:
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable82  ;; 0x40006008
        LDR      R0,[R1, R0, LSL #+1]
        UXTH     R0,R0
        BX       LR               ;; return
        CFI EndBlock cfiBlock39
//  504 }
//  505 /*******************************************************************************
//  506 * Function Name  : SetEPTxCount.
//  507 * Description    : Set the Tx count.
//  508 * Input          : bEpNum: Endpoint Number.
//  509 *                  wCount: new count value.
//  510 * Output         : None.
//  511 * Return         : None.
//  512 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock40 Using cfiCommon0
        CFI Function SetEPTxCount
        THUMB
//  513 void SetEPTxCount(u8 bEpNum, u16 wCount)
//  514 {
//  515   _SetEPTxCount(bEpNum, wCount);
SetEPTxCount:
        LDR.N    R2,??DataTable101  ;; 0x40005c50
        LDR      R2,[R2, #+0]
        UXTH     R2,R2
        ADD      R0,R2,R0, LSL #+3
        LDR.N    R2,??DataTable103  ;; 0x40006004
        STR      R1,[R2, R0, LSL #+1]
//  516 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock40
//  517 /*******************************************************************************
//  518 * Function Name  : SetEPCountRxReg.
//  519 * Description    : Set the Count Rx Register value.
//  520 * Input          : *pdwReg: point to the register.
//  521 *                  wCount: the new register value.
//  522 * Output         : None.
//  523 * Return         : None.
//  524 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock41 Using cfiCommon0
        CFI Function SetEPCountRxReg
        THUMB
//  525 void SetEPCountRxReg(u32 *pdwReg, u16 wCount)
//  526 {
//  527   _SetEPCountRxReg(dwReg, wCount);
SetEPCountRxReg:
        CMP      R1,#+63
        BCC.N    ??SetEPCountRxReg_0
        LSRS     R2,R1,#+5
        TST      R1,#0x1F
        BNE.N    ??SetEPCountRxReg_1
        SUBS     R2,R2,#+1
        UXTH     R2,R2
??SetEPCountRxReg_1:
        LSLS     R1,R2,#+10
        ORR      R1,R1,#0x8000
        B.N      ??SetEPCountRxReg_2
??SetEPCountRxReg_0:
        LSRS     R2,R1,#+1
        TST      R1,#0x1
        BEQ.N    ??SetEPCountRxReg_3
        ADDS     R2,R2,#+1
        UXTH     R2,R2
??SetEPCountRxReg_3:
        LSLS     R1,R2,#+10
??SetEPCountRxReg_2:
        STR      R1,[R0, #+0]
//  528 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock41
//  529 /*******************************************************************************
//  530 * Function Name  : SetEPRxCount
//  531 * Description    : Set the Rx count.
//  532 * Input          : bEpNum: Endpoint Number. 
//  533 *                  wCount: the new count value.
//  534 * Output         : None.
//  535 * Return         : None.
//  536 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock42 Using cfiCommon0
        CFI Function SetEPRxCount
        THUMB
//  537 void SetEPRxCount(u8 bEpNum, u16 wCount)
//  538 {
//  539   _SetEPRxCount(bEpNum, wCount);
SetEPRxCount:
        LDR.N    R2,??DataTable101  ;; 0x40005c50
        LDR      R2,[R2, #+0]
        UXTH     R2,R2
        ADD      R0,R2,R0, LSL #+3
        LDR.N    R2,??DataTable102  ;; 0x4000600c
        ADD      R0,R2,R0, LSL #+1
        CMP      R1,#+63
        BCC.N    ??SetEPRxCount_0
        LSRS     R2,R1,#+5
        TST      R1,#0x1F
        BNE.N    ??SetEPRxCount_1
        SUBS     R2,R2,#+1
        UXTH     R2,R2
??SetEPRxCount_1:
        LSLS     R1,R2,#+10
        ORR      R1,R1,#0x8000
        B.N      ??SetEPRxCount_2
??SetEPRxCount_0:
        LSRS     R2,R1,#+1
        TST      R1,#0x1
        BEQ.N    ??SetEPRxCount_3
        ADDS     R2,R2,#+1
        UXTH     R2,R2
??SetEPRxCount_3:
        LSLS     R1,R2,#+10
??SetEPRxCount_2:
        STR      R1,[R0, #+0]
//  540 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock42
//  541 /*******************************************************************************
//  542 * Function Name  : GetEPTxCount
//  543 * Description    : Get the Tx count.
//  544 * Input          : bEpNum: Endpoint Number. 
//  545 * Output         : None
//  546 * Return         : Tx count value.
//  547 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock43 Using cfiCommon0
        CFI Function GetEPTxCount
        THUMB
//  548 u16 GetEPTxCount(u8 bEpNum)
//  549 {
//  550   return(_GetEPTxCount(bEpNum));
GetEPTxCount:
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable103  ;; 0x40006004
        LDR      R0,[R1, R0, LSL #+1]
        LSLS     R0,R0,#+22
        LSRS     R0,R0,#+22
        BX       LR               ;; return
        CFI EndBlock cfiBlock43
//  551 }
//  552 /*******************************************************************************
//  553 * Function Name  : GetEPRxCount
//  554 * Description    : Get the Rx count.
//  555 * Input          : bEpNum: Endpoint Number. 
//  556 * Output         : None.
//  557 * Return         : Rx count value.
//  558 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock44 Using cfiCommon0
        CFI Function GetEPRxCount
        THUMB
//  559 u16 GetEPRxCount(u8 bEpNum)
//  560 {
//  561   return(_GetEPRxCount(bEpNum));
GetEPRxCount:
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable102  ;; 0x4000600c
        LDR      R0,[R1, R0, LSL #+1]
        LSLS     R0,R0,#+22
        LSRS     R0,R0,#+22
        BX       LR               ;; return
        CFI EndBlock cfiBlock44
//  562 }
//  563 /*******************************************************************************
//  564 * Function Name  : SetEPDblBuffAddr
//  565 * Description    : Set the addresses of the buffer 0 and 1.
//  566 * Input          : bEpNum: Endpoint Number.  
//  567 *                  wBuf0Addr: new address of buffer 0. 
//  568 *                  wBuf1Addr: new address of buffer 1.
//  569 * Output         : None.
//  570 * Return         : None.
//  571 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock45 Using cfiCommon0
        CFI Function SetEPDblBuffAddr
        THUMB
//  572 void SetEPDblBuffAddr(u8 bEpNum, u16 wBuf0Addr, u16 wBuf1Addr)
//  573 {
SetEPDblBuffAddr:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  574   _SetEPDblBuffAddr(bEpNum, wBuf0Addr, wBuf1Addr);
        LSLS     R0,R0,#+3
        LDR.N    R3,??DataTable101  ;; 0x40005c50
        LDR      R12,[R3, #+0]
        UXTH     R12,R12
        ADD      R12,R0,R12
        LDR.W    LR,??DataTable80  ;; 0x40006000
        LSRS     R1,R1,#+1
        LSLS     R1,R1,#+1
        STR      R1,[LR, R12, LSL #+1]
        LDR      R1,[R3, #+0]
        UXTH     R1,R1
        ADDS     R0,R0,R1
        LDR.N    R1,??DataTable82  ;; 0x40006008
        LSRS     R2,R2,#+1
        LSLS     R2,R2,#+1
        STR      R2,[R1, R0, LSL #+1]
//  575 }
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock45
//  576 /*******************************************************************************
//  577 * Function Name  : SetEPDblBuf0Addr
//  578 * Description    : Set the Buffer 1 address.
//  579 * Input          : bEpNum: Endpoint Number
//  580 *                  wBuf0Addr: new address.
//  581 * Output         : None.
//  582 * Return         : None.
//  583 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock46 Using cfiCommon0
        CFI Function SetEPDblBuf0Addr
        THUMB
//  584 void SetEPDblBuf0Addr(u8 bEpNum, u16 wBuf0Addr)
//  585 {
//  586   _SetEPDblBuf0Addr(bEpNum, wBuf0Addr);
SetEPDblBuf0Addr:
        LDR.N    R2,??DataTable101  ;; 0x40005c50
        LDR      R2,[R2, #+0]
        UXTH     R2,R2
        ADD      R0,R2,R0, LSL #+3
        LDR.N    R2,??DataTable80  ;; 0x40006000
        LSRS     R1,R1,#+1
        LSLS     R1,R1,#+1
        STR      R1,[R2, R0, LSL #+1]
//  587 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock46
//  588 /*******************************************************************************
//  589 * Function Name  : SetEPDblBuf1Addr
//  590 * Description    : Set the Buffer 1 address.
//  591 * Input          : bEpNum: Endpoint Number
//  592 *                  wBuf1Addr: new address.
//  593 * Output         : None.
//  594 * Return         : None.
//  595 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock47 Using cfiCommon0
        CFI Function SetEPDblBuf1Addr
        THUMB
//  596 void SetEPDblBuf1Addr(u8 bEpNum, u16 wBuf1Addr)
//  597 {
//  598   _SetEPDblBuf1Addr(bEpNum, wBuf1Addr);
SetEPDblBuf1Addr:
        LDR.N    R2,??DataTable101  ;; 0x40005c50
        LDR      R2,[R2, #+0]
        UXTH     R2,R2
        ADD      R0,R2,R0, LSL #+3
        LDR.N    R2,??DataTable82  ;; 0x40006008
        LSRS     R1,R1,#+1
        LSLS     R1,R1,#+1
        STR      R1,[R2, R0, LSL #+1]
//  599 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock47
//  600 /*******************************************************************************
//  601 * Function Name  : GetEPDblBuf0Addr
//  602 * Description    : Returns the address of the Buffer 0.
//  603 * Input          : bEpNum: Endpoint Number.
//  604 * Output         : None.
//  605 * Return         : None.
//  606 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock48 Using cfiCommon0
        CFI Function GetEPDblBuf0Addr
        THUMB
//  607 u16 GetEPDblBuf0Addr(u8 bEpNum)
//  608 {
//  609   return(_GetEPDblBuf0Addr(bEpNum));
GetEPDblBuf0Addr:
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable80  ;; 0x40006000
        LDR      R0,[R1, R0, LSL #+1]
        UXTH     R0,R0
        BX       LR               ;; return
        CFI EndBlock cfiBlock48
//  610 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable80:
        DC32     0x40006000
//  611 /*******************************************************************************
//  612 * Function Name  : GetEPDblBuf1Addr
//  613 * Description    : Returns the address of the Buffer 1.
//  614 * Input          : bEpNum: Endpoint Number.
//  615 * Output         : None.
//  616 * Return         : Address of the Buffer 1.
//  617 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock49 Using cfiCommon0
        CFI Function GetEPDblBuf1Addr
        THUMB
//  618 u16 GetEPDblBuf1Addr(u8 bEpNum)
//  619 {
//  620   return(_GetEPDblBuf1Addr(bEpNum));
GetEPDblBuf1Addr:
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable82  ;; 0x40006008
        LDR      R0,[R1, R0, LSL #+1]
        UXTH     R0,R0
        BX       LR               ;; return
        CFI EndBlock cfiBlock49
//  621 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable82:
        DC32     0x40006008
//  622 /*******************************************************************************
//  623 * Function Name  : SetEPDblBuffCount
//  624 * Description    : Set the number of bytes for a double Buffer 
//  625 *                  endpoint.
//  626 * Input          : bEpNum,bDir, wCount
//  627 * Output         : None.
//  628 * Return         : None.
//  629 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock50 Using cfiCommon0
        CFI Function SetEPDblBuffCount
        THUMB
//  630 void SetEPDblBuffCount(u8 bEpNum, u8 bDir, u16 wCount)
//  631 {
//  632   _SetEPDblBuffCount(bEpNum, bDir, wCount);
SetEPDblBuffCount:
        CMP      R1,#+1
        BNE.N    ??SetEPDblBuffCount_0
        LSLS     R0,R0,#+3
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R3,[R1, #+0]
        UXTH     R3,R3
        ADDS     R3,R0,R3
        LDR.W    R12,??DataTable103  ;; 0x40006004
        ADD      R3,R12,R3, LSL #+1
        CMP      R2,#+63
        BCC.N    ??SetEPDblBuffCount_1
        LSR      R12,R2,#+5
        TST      R2,#0x1F
        ITT      EQ 
        SUBEQ    R12,R12,#+1
        UXTHEQ   R12,R12
        LSL      R12,R12,#+10
        ORR      R12,R12,#0x8000
        STR      R12,[R3, #+0]
??SetEPDblBuffCount_2:
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADDS     R0,R0,R1
        LDR.N    R1,??DataTable102  ;; 0x4000600c
        ADD      R0,R1,R0, LSL #+1
        CMP      R2,#+63
        BCC.N    ??SetEPDblBuffCount_3
        LSRS     R1,R2,#+5
        TST      R2,#0x1F
        BNE.N    ??SetEPDblBuffCount_4
        SUBS     R1,R1,#+1
        UXTH     R1,R1
??SetEPDblBuffCount_4:
        LSLS     R1,R1,#+10
        ORR      R1,R1,#0x8000
        B.N      ??SetEPDblBuffCount_5
??SetEPDblBuffCount_1:
        LSR      R12,R2,#+1
        TST      R2,#0x1
        ITT      NE 
        ADDNE    R12,R12,#+1
        UXTHNE   R12,R12
        LSL      R12,R12,#+10
        STR      R12,[R3, #+0]
        B.N      ??SetEPDblBuffCount_2
??SetEPDblBuffCount_0:
        CMP      R1,#+2
        BNE.N    ??SetEPDblBuffCount_6
        LSLS     R0,R0,#+3
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R3,[R1, #+0]
        UXTH     R3,R3
        ADDS     R3,R0,R3
        LDR.W    R12,??DataTable103  ;; 0x40006004
        STR      R2,[R12, R3, LSL #+1]
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADDS     R0,R0,R1
        LDR.N    R1,??DataTable102  ;; 0x4000600c
        STR      R2,[R1, R0, LSL #+1]
        BX       LR
??SetEPDblBuffCount_3:
        LSRS     R1,R2,#+1
        TST      R2,#0x1
        BEQ.N    ??SetEPDblBuffCount_7
        ADDS     R1,R1,#+1
        UXTH     R1,R1
??SetEPDblBuffCount_7:
        LSLS     R1,R1,#+10
??SetEPDblBuffCount_5:
        STR      R1,[R0, #+0]
//  633 }
??SetEPDblBuffCount_6:
        BX       LR               ;; return
        CFI EndBlock cfiBlock50
//  634 /*******************************************************************************
//  635 * Function Name  : SetEPDblBuf0Count
//  636 * Description    : Set the number of bytes in the buffer 0 of a double Buffer 
//  637 *                  endpoint.
//  638 * Input          : bEpNum, bDir,  wCount
//  639 * Output         : None.
//  640 * Return         : None.
//  641 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock51 Using cfiCommon0
        CFI Function SetEPDblBuf0Count
        THUMB
//  642 void SetEPDblBuf0Count(u8 bEpNum, u8 bDir, u16 wCount)
//  643 {
//  644   _SetEPDblBuf0Count(bEpNum, bDir, wCount);
SetEPDblBuf0Count:
        CMP      R1,#+1
        BNE.N    ??SetEPDblBuf0Count_0
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable103  ;; 0x40006004
        ADD      R0,R1,R0, LSL #+1
        CMP      R2,#+63
        BCC.N    ??SetEPDblBuf0Count_1
        LSRS     R1,R2,#+5
        TST      R2,#0x1F
        BNE.N    ??SetEPDblBuf0Count_2
        SUBS     R1,R1,#+1
        UXTH     R1,R1
??SetEPDblBuf0Count_2:
        LSLS     R1,R1,#+10
        ORR      R1,R1,#0x8000
??SetEPDblBuf0Count_3:
        STR      R1,[R0, #+0]
        BX       LR
??SetEPDblBuf0Count_1:
        LSRS     R1,R2,#+1
        TST      R2,#0x1
        BEQ.N    ??SetEPDblBuf0Count_4
        ADDS     R1,R1,#+1
        UXTH     R1,R1
??SetEPDblBuf0Count_4:
        LSLS     R1,R1,#+10
        B.N      ??SetEPDblBuf0Count_3
??SetEPDblBuf0Count_0:
        CMP      R1,#+2
        BNE.N    ??SetEPDblBuf0Count_5
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable103  ;; 0x40006004
        STR      R2,[R1, R0, LSL #+1]
//  645 }
??SetEPDblBuf0Count_5:
        BX       LR               ;; return
        CFI EndBlock cfiBlock51
//  646 /*******************************************************************************
//  647 * Function Name  : SetEPDblBuf1Count
//  648 * Description    : Set the number of bytes in the buffer 0 of a double Buffer 
//  649 *                  endpoint.
//  650 * Input          : bEpNum,  bDir,  wCount
//  651 * Output         : None.
//  652 * Return         : None.
//  653 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock52 Using cfiCommon0
        CFI Function SetEPDblBuf1Count
        THUMB
//  654 void SetEPDblBuf1Count(u8 bEpNum, u8 bDir, u16 wCount)
//  655 {
//  656   _SetEPDblBuf1Count(bEpNum, bDir, wCount);
SetEPDblBuf1Count:
        CMP      R1,#+1
        BNE.N    ??SetEPDblBuf1Count_0
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable102  ;; 0x4000600c
        ADD      R0,R1,R0, LSL #+1
        CMP      R2,#+63
        BCC.N    ??SetEPDblBuf1Count_1
        LSRS     R1,R2,#+5
        TST      R2,#0x1F
        BNE.N    ??SetEPDblBuf1Count_2
        SUBS     R1,R1,#+1
        UXTH     R1,R1
??SetEPDblBuf1Count_2:
        LSLS     R1,R1,#+10
        ORR      R1,R1,#0x8000
??SetEPDblBuf1Count_3:
        STR      R1,[R0, #+0]
        BX       LR
??SetEPDblBuf1Count_1:
        LSRS     R1,R2,#+1
        TST      R2,#0x1
        BEQ.N    ??SetEPDblBuf1Count_4
        ADDS     R1,R1,#+1
        UXTH     R1,R1
??SetEPDblBuf1Count_4:
        LSLS     R1,R1,#+10
        B.N      ??SetEPDblBuf1Count_3
??SetEPDblBuf1Count_0:
        CMP      R1,#+2
        BNE.N    ??SetEPDblBuf1Count_5
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable102  ;; 0x4000600c
        STR      R2,[R1, R0, LSL #+1]
//  657 }
??SetEPDblBuf1Count_5:
        BX       LR               ;; return
        CFI EndBlock cfiBlock52
//  658 /*******************************************************************************
//  659 * Function Name  : GetEPDblBuf0Count
//  660 * Description    : Returns the number of byte received in the buffer 0 of a double
//  661 *                  Buffer endpoint.
//  662 * Input          : bEpNum: Endpoint Number.
//  663 * Output         : None.
//  664 * Return         : Endpoint Buffer 0 count
//  665 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock53 Using cfiCommon0
        CFI Function GetEPDblBuf0Count
        THUMB
//  666 u16 GetEPDblBuf0Count(u8 bEpNum)
//  667 {
//  668   return(_GetEPDblBuf0Count(bEpNum));
GetEPDblBuf0Count:
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable103  ;; 0x40006004
        LDR      R0,[R1, R0, LSL #+1]
        LSLS     R0,R0,#+22
        LSRS     R0,R0,#+22
        BX       LR               ;; return
        CFI EndBlock cfiBlock53
//  669 }
//  670 /*******************************************************************************
//  671 * Function Name  : GetEPDblBuf1Count
//  672 * Description    : Returns the number of data received in the buffer 1 of a double
//  673 *                  Buffer endpoint.
//  674 * Input          : bEpNum: Endpoint Number.
//  675 * Output         : None.
//  676 * Return         : Endpoint Buffer 1 count.
//  677 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock54 Using cfiCommon0
        CFI Function GetEPDblBuf1Count
        THUMB
//  678 u16 GetEPDblBuf1Count(u8 bEpNum)
//  679 {
//  680   return(_GetEPDblBuf1Count(bEpNum));
GetEPDblBuf1Count:
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??DataTable102  ;; 0x4000600c
        LDR      R0,[R1, R0, LSL #+1]
        LSLS     R0,R0,#+22
        LSRS     R0,R0,#+22
        BX       LR               ;; return
        CFI EndBlock cfiBlock54
//  681 }
//  682 /*******************************************************************************
//  683 * Function Name  : GetEPDblBufDir
//  684 * Description    : gets direction of the double buffered endpoint
//  685 * Input          : bEpNum: Endpoint Number. 
//  686 * Output         : None.
//  687 * Return         : EP_DBUF_OUT, EP_DBUF_IN,
//  688 *                  EP_DBUF_ERR if the endpoint counter not yet programmed.
//  689 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock55 Using cfiCommon0
        CFI Function GetEPDblBufDir
        THUMB
//  690 EP_DBUF_DIR GetEPDblBufDir(u8 bEpNum)
//  691 {
//  692   if ((u16)(*_pEPRxCount(bEpNum) & 0xFC00) != 0)
GetEPDblBufDir:
        LSLS     R0,R0,#+3
        LDR.N    R1,??DataTable101  ;; 0x40005c50
        LDR      R2,[R1, #+0]
        UXTH     R2,R2
        ADDS     R2,R0,R2
        LDR.N    R3,??DataTable102  ;; 0x4000600c
        LDR      R2,[R3, R2, LSL #+1]
        TST      R2,#0xFC00
        BEQ.N    ??GetEPDblBufDir_0
//  693     return(EP_DBUF_OUT);
        MOVS     R0,#+1
        BX       LR
//  694   else if (((u16)(*_pEPTxCount(bEpNum)) & 0x03FF) != 0)
??GetEPDblBufDir_0:
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        ADDS     R0,R0,R1
        LDR.N    R1,??DataTable103  ;; 0x40006004
        LDR      R0,[R1, R0, LSL #+1]
        LSLS     R0,R0,#+22
        BEQ.N    ??GetEPDblBufDir_1
//  695     return(EP_DBUF_IN);
        MOVS     R0,#+2
        BX       LR
//  696   else
//  697     return(EP_DBUF_ERR);
??GetEPDblBufDir_1:
        MOVS     R0,#+0
??GetEPDblBufDir_2:
        BX       LR               ;; return
        CFI EndBlock cfiBlock55
//  698 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable101:
        DC32     0x40005c50

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable102:
        DC32     0x4000600c

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable103:
        DC32     0x40006004
//  699 /*******************************************************************************
//  700 * Function Name  : FreeUserBuffer
//  701 * Description    : free buffer used from the application realizing it to the line
//  702                    toggles bit SW_BUF in the double buffered endpoint register
//  703 * Input          : bEpNum, bDir
//  704 * Output         : None.
//  705 * Return         : None.
//  706 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock56 Using cfiCommon0
        CFI Function FreeUserBuffer
        THUMB
//  707 void FreeUserBuffer(u8 bEpNum, u8 bDir)
//  708 {
//  709   if (bDir == EP_DBUF_OUT)
FreeUserBuffer:
        CMP      R1,#+1
        BNE.N    ??FreeUserBuffer_0
//  710   { /* OUT double buffered endpoint */
//  711     _ToggleDTOG_TX(bEpNum);
        LDR.N    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+36751
        ANDS     R1,R2,R1
        ORR      R1,R1,#0x40
        LDR.N    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
        BX       LR
//  712   }
//  713   else if (bDir == EP_DBUF_IN)
??FreeUserBuffer_0:
        CMP      R1,#+2
        BNE.N    ??FreeUserBuffer_1
//  714   { /* IN double buffered endpoint */
//  715     _ToggleDTOG_RX(bEpNum);
        LDR.N    R1,??DataTable107  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+36751
        ANDS     R1,R2,R1
        ORR      R1,R1,#0x4000
        LDR.N    R2,??DataTable107  ;; 0x40005c00
        STR      R1,[R2, R0, LSL #+2]
//  716   }
//  717 }
??FreeUserBuffer_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock56

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable107:
        DC32     0x40005c00
//  718 
//  719 /*******************************************************************************
//  720 * Function Name  : ToWord
//  721 * Description    : merge two byte in a word.
//  722 * Input          : bh: byte high, bl: bytes low.
//  723 * Output         : None.
//  724 * Return         : resulted word.
//  725 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock57 Using cfiCommon0
        CFI Function ToWord
        THUMB
//  726 u16 ToWord(u8 bh, u8 bl)
//  727 {
//  728   u16 wRet;
//  729   wRet = (u16)bl | ((u16)bh << 8);
//  730   return(wRet);
ToWord:
        ORR      R0,R1,R0, LSL #+8
        BX       LR               ;; return
        CFI EndBlock cfiBlock57
//  731 }
//  732 /*******************************************************************************
//  733 * Function Name  : ByteSwap
//  734 * Description    : Swap two byte in a word.
//  735 * Input          : wSwW: word to Swap.
//  736 * Output         : None.
//  737 * Return         : resulted word.
//  738 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock58 Using cfiCommon0
        CFI Function ByteSwap
        THUMB
//  739 u16 ByteSwap(u16 wSwW)
//  740 {
//  741   u8 bTemp;
//  742   u16 wRet;
//  743   bTemp = (u8)(wSwW & 0xff);
//  744   wRet =  (wSwW >> 8) | ((u16)bTemp << 8);
//  745   return(wRet);
ByteSwap:
        LSLS     R1,R0,#+24
        LSRS     R1,R1,#+16
        ORR      R0,R1,R0, LSR #+8
        BX       LR               ;; return
        CFI EndBlock cfiBlock58
//  746 }

        END
//  747 
//  748 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
// 1 726 bytes in section .text
// 
// 1 726 bytes of CODE memory
//
//Errors: none
//Warnings: none
