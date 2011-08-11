///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:03:46 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\SYS_V1.50\source\USB_pwr.c             /
//    Command line =  E:\Mini-DS\DS203\SYS_V1.50\source\USB_pwr.c -lA         /
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
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\USB_pwr. /
//                    s                                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME USB_pwr

        EXTERN wInterrupt_Mask

        PUBLIC PowerOff
        PUBLIC PowerOn
        PUBLIC Resume
        PUBLIC ResumeS
        PUBLIC Resume_Init
        PUBLIC Suspend
        PUBLIC bDeviceState
        PUBLIC fSuspendEnabled
        
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
        
// E:\Mini-DS\DS203\SYS_V1.50\source\USB_pwr.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : usb_pwr.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.2.1
//    5 * Date               : 09/22/2008
//    6 * Description        : Connection/disconnection & power management
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
//   17 #include "stm32f10x_lib.h"
//   18 #include "USB_lib.h"
//   19 #include "USB_conf.h"
//   20 #include "USB_pwr.h"
//   21 //#include "Config.h"
//   22 
//   23 /* Private typedef -----------------------------------------------------------*/
//   24 /* Private define ------------------------------------------------------------*/
//   25 /* Private macro -------------------------------------------------------------*/
//   26 /* Private variables ---------------------------------------------------------*/

        SECTION `.bss`:DATA:NOROOT(2)
//   27 vu32 bDeviceState = UNCONNECTED; /* USB device status */
bDeviceState:
        DS8 4

        SECTION `.data`:DATA:NOROOT(0)
//   28 volatile bool fSuspendEnabled = TRUE;  /* true when suspend is possible */
fSuspendEnabled:
        DATA
        DC8 1
//   29 
//   30 struct
//   31 {
//   32   volatile RESUME_STATE eState;
//   33   volatile u8 bESOFcnt;
//   34 }

        SECTION `.bss`:DATA:NOROOT(2)
//   35 ResumeS;
ResumeS:
        DS8 4
//   36 
//   37 /* Extern variables ----------------------------------------------------------*/
//   38 /* Private function prototypes -----------------------------------------------*/
//   39 /* Extern function prototypes ------------------------------------------------*/
//   40 /* Private functions ---------------------------------------------------------*/
//   41 
//   42 /*******************************************************************************
//   43 * Function Name  : PowerOn
//   44 * Description    :
//   45 * Input          : None.
//   46 * Output         : None.
//   47 * Return         : USB_SUCCESS.
//   48 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function PowerOn
        THUMB
//   49 RESULT PowerOn(void)
//   50 {
//   51   u16 wRegVal;
//   52 
//   53   /*** cable plugged-in ? ***/
//   54   /*while(!CablePluggedIn());*/
//   55 //  USB_Cable_Config(ENABLE);
//   56 
//   57   /*** CNTR_PWDN = 0 ***/
//   58   wRegVal = CNTR_FRES;
//   59   _SetCNTR(wRegVal);
PowerOn:
        LDR.N    R0,??DataTable5  ;; 0x40005c40
        MOVS     R1,#+1
        STR      R1,[R0, #+0]
//   60 
//   61   /*** CNTR_FRES = 0 ***/
//   62   wInterrupt_Mask = 0;
//   63   _SetCNTR(wInterrupt_Mask);
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//   64   /*** Clear pending interrupts ***/
//   65   _SetISTR(0);
        MOVS     R2,#+0
        STR      R2,[R0, #+4]
//   66   /*** Set interrupt mask ***/
//   67   wInterrupt_Mask = CNTR_RESETM | CNTR_SUSPM | CNTR_WKUPM;
        LDR.N    R1,??PowerOn_0   ;; wInterrupt_Mask
        MOV      R2,#+7168
        STRH     R2,[R1, #+0]
//   68   _SetCNTR(wInterrupt_Mask);
        STR      R2,[R0, #+0]
//   69 
//   70   return USB_SUCCESS;
        MOVS     R0,#+0
        BX       LR               ;; return
        DATA
??PowerOn_0:
        DC32     wInterrupt_Mask
        CFI EndBlock cfiBlock0
//   71 }
//   72 
//   73 /*******************************************************************************
//   74 * Function Name  : PowerOff
//   75 * Description    : handles switch-off conditions
//   76 * Input          : None.
//   77 * Output         : None.
//   78 * Return         : USB_SUCCESS.
//   79 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function PowerOff
        THUMB
//   80 RESULT PowerOff()
//   81 {
//   82   /* disable all ints and force USB reset */
//   83   _SetCNTR(CNTR_FRES);
PowerOff:
        LDR.N    R0,??DataTable5  ;; 0x40005c40
        MOVS     R1,#+1
        STR      R1,[R0, #+0]
//   84   /* clear interrupt status register */
//   85   _SetISTR(0);
        MOVS     R2,#+0
        STR      R2,[R0, #+4]
//   86   /* Disable the Pull-Up*/
//   87 //  USB_Cable_Config(DISABLE);
//   88   /* switch-off device */
//   89   _SetCNTR(CNTR_FRES + CNTR_PDWN);
        MOVS     R1,#+3
        STR      R1,[R0, #+0]
//   90   /* sw variables reset */
//   91   /* ... */
//   92 
//   93   return USB_SUCCESS;
        MOVS     R0,#+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//   94 }
//   95 
//   96 /*******************************************************************************
//   97 * Function Name  : Suspend
//   98 * Description    : sets suspend mode operating conditions
//   99 * Input          : None.
//  100 * Output         : None.
//  101 * Return         : USB_SUCCESS.
//  102 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Suspend
        THUMB
//  103 void Suspend(void)
//  104 {
//  105   u16 wCNTR;
//  106   /* suspend preparation */
//  107   /* ... */
//  108 
//  109   /* macrocell enters suspend mode */
//  110   wCNTR = _GetCNTR();
Suspend:
        LDR.N    R0,??DataTable5  ;; 0x40005c40
        LDR      R1,[R0, #+0]
        UXTH     R1,R1
//  111   wCNTR |= CNTR_FSUSP;
//  112   _SetCNTR(wCNTR);
        ORR      R1,R1,#0x8
        STR      R1,[R0, #+0]
//  113 
//  114   /* ------------------ ONLY WITH BUS-POWERED DEVICES ---------------------- */
//  115   /* power reduction */
//  116   /* ... on connected devices */
//  117 
//  118 
//  119   /* force low-power mode in the macrocell */
//  120   wCNTR = _GetCNTR();
        LDR      R1,[R0, #+0]
        UXTH     R1,R1
//  121   wCNTR |= CNTR_LPMODE;
//  122   _SetCNTR(wCNTR);
        ORR      R1,R1,#0x4
        STR      R1,[R0, #+0]
//  123 
//  124   /* switch-off the clocks */
//  125   /* ... */
//  126 //  Enter_LowPowerMode();
//  127 
//  128 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//  129 
//  130 /*******************************************************************************
//  131 * Function Name  : Resume_Init
//  132 * Description    : Handles wake-up restoring normal operations
//  133 * Input          : None.
//  134 * Output         : None.
//  135 * Return         : USB_SUCCESS.
//  136 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Resume_Init
        THUMB
//  137 void Resume_Init(void)
//  138 {
//  139   u16 wCNTR;
//  140   /* ------------------ ONLY WITH BUS-POWERED DEVICES ---------------------- */
//  141   /* restart the clocks */
//  142   /* ...  */
//  143 
//  144   /* CNTR_LPMODE = 0 */
//  145   wCNTR = _GetCNTR();
Resume_Init:
        LDR.N    R0,??DataTable5  ;; 0x40005c40
        LDR      R1,[R0, #+0]
//  146   wCNTR &= (~CNTR_LPMODE);
//  147   _SetCNTR(wCNTR);
        MOVW     R2,#+65531
        ANDS     R1,R2,R1
        STR      R1,[R0, #+0]
//  148 
//  149   /* restore full power */
//  150   /* ... on connected devices */
//  151 //  Leave_LowPowerMode();
//  152 
//  153   /* reset FSUSP bit */
//  154   _SetCNTR(IMR_MSK);
        MOV      R1,#+33792
        STR      R1,[R0, #+0]
//  155 
//  156   /* reverse suspend preparation */
//  157   /* ... */
//  158 
//  159 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//  160 
//  161 /*******************************************************************************
//  162 * Function Name  : Resume
//  163 * Description    : This is the state machine handling resume operations and
//  164 *                 timing sequence. The control is based on the Resume structure
//  165 *                 variables and on the ESOF interrupt calling this subroutine
//  166 *                 without changing machine state.
//  167 * Input          : a state machine value (RESUME_STATE)
//  168 *                  RESUME_ESOF doesn't change ResumeS.eState allowing
//  169 *                  decrementing of the ESOF counter in different states.
//  170 * Output         : None.
//  171 * Return         : None.
//  172 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Resume
        THUMB
//  173 void Resume(RESUME_STATE eResumeSetVal)
//  174 {
Resume:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  175   u16 wCNTR;
//  176 
//  177   if (eResumeSetVal != RESUME_ESOF)
        LDR.N    R4,??Resume_1    ;; ResumeS
        CMP      R0,#+7
        IT       NE 
//  178     ResumeS.eState = eResumeSetVal;
        STRBNE   R0,[R4, #+0]
//  179 
//  180   switch (ResumeS.eState)
        LDRB     R0,[R4, #+0]
        CMP      R0,#+5
        BHI.N    ??Resume_2
        TBB      [PC, R0]
        DATA
??Resume_0:
        DC8      +3,+6,+10,+14
        DC8      +21,+32
        THUMB
//  181   {
//  182     case RESUME_EXTERNAL:
//  183       Resume_Init();
??Resume_3:
        BL       Resume_Init
//  184       ResumeS.eState = RESUME_OFF;
        B.N      ??Resume_2
//  185       break;
//  186     case RESUME_INTERNAL:
//  187       Resume_Init();
??Resume_4:
        BL       Resume_Init
//  188       ResumeS.eState = RESUME_START;
        MOVS     R0,#+4
        B.N      ??Resume_5
//  189       break;
//  190     case RESUME_LATER:
//  191       ResumeS.bESOFcnt = 2;
??Resume_6:
        MOVS     R0,#+2
        STRB     R0,[R4, #+1]
//  192       ResumeS.eState = RESUME_WAIT;
        MOVS     R0,#+3
        B.N      ??Resume_5
//  193       break;
//  194     case RESUME_WAIT:
//  195       ResumeS.bESOFcnt--;
??Resume_7:
        LDRB     R0,[R4, #+1]
        SUBS     R0,R0,#+1
        STRB     R0,[R4, #+1]
//  196       if (ResumeS.bESOFcnt == 0)
        LDRB     R0,[R4, #+1]
        CBNZ     R0,??Resume_8
//  197         ResumeS.eState = RESUME_START;
        MOVS     R0,#+4
        B.N      ??Resume_5
//  198       break;
//  199     case RESUME_START:
//  200       wCNTR = _GetCNTR();
??Resume_9:
        LDR.N    R0,??DataTable5  ;; 0x40005c40
        LDR      R1,[R0, #+0]
        UXTH     R1,R1
//  201       wCNTR |= CNTR_RESUME;
//  202       _SetCNTR(wCNTR);
        ORR      R1,R1,#0x10
        STR      R1,[R0, #+0]
//  203       ResumeS.eState = RESUME_ON;
        MOVS     R0,#+5
        STRB     R0,[R4, #+0]
//  204       ResumeS.bESOFcnt = 10;
        MOVS     R0,#+10
        STRB     R0,[R4, #+1]
        POP      {R4,PC}
//  205       break;
//  206     case RESUME_ON:
//  207       ResumeS.bESOFcnt--;
??Resume_10:
        LDRB     R0,[R4, #+1]
        SUBS     R0,R0,#+1
        STRB     R0,[R4, #+1]
//  208       if (ResumeS.bESOFcnt == 0)
        LDRB     R0,[R4, #+1]
        CBNZ     R0,??Resume_8
//  209       {
//  210         wCNTR = _GetCNTR();
        LDR.N    R0,??DataTable5  ;; 0x40005c40
        LDR      R1,[R0, #+0]
//  211         wCNTR &= (~CNTR_RESUME);
//  212         _SetCNTR(wCNTR);
        MOVW     R2,#+65519
        ANDS     R1,R2,R1
        STR      R1,[R0, #+0]
//  213         ResumeS.eState = RESUME_OFF;
        MOVS     R0,#+6
        B.N      ??Resume_5
//  214       }
//  215       break;
//  216     case RESUME_OFF:
//  217     case RESUME_ESOF:
//  218     default:
//  219       ResumeS.eState = RESUME_OFF;
??Resume_2:
        MOVS     R0,#+6
??Resume_5:
        STRB     R0,[R4, #+0]
//  220       break;
//  221   }
//  222 }
??Resume_8:
        POP      {R4,PC}          ;; return
        DATA
??Resume_1:
        DC32     ResumeS
        CFI EndBlock cfiBlock4

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable5:
        DC32     0x40005c40

        END
//  223 
//  224 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
//   8 bytes in section .bss
//   1 byte  in section .data
// 218 bytes in section .text
// 
// 218 bytes of CODE memory
//   9 bytes of DATA memory
//
//Errors: none
//Warnings: none
