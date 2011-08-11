///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:03:37 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\SYS_V1.50\source\Interrupt.c           /
//    Command line =  E:\Mini-DS\DS203\SYS_V1.50\source\Interrupt.c -lA       /
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
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\Interrup /
//                    t.s                                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Interrupt

        EXTERN CTR_HP
        EXTERN Read_Keys
        EXTERN Set
        EXTERN USB_Istr

        PUBLIC ADC1_2_IRQHandler
        PUBLIC ADC3_IRQHandler
        PUBLIC Beep_mS
        PUBLIC BusFaultException
        PUBLIC CAN_RX1_IRQHandler
        PUBLIC CAN_SCE_IRQHandler
        PUBLIC Cnt_20mS
        PUBLIC Cnt_mS
        PUBLIC Cursor_Cnt
        PUBLIC DMA1_Channel1_IRQHandler
        PUBLIC DMA1_Channel2_IRQHandler
        PUBLIC DMA1_Channel3_IRQHandler
        PUBLIC DMA1_Channel4_IRQHandler
        PUBLIC DMA1_Channel5_IRQHandler
        PUBLIC DMA1_Channel6_IRQHandler
        PUBLIC DMA1_Channel7_IRQHandler
        PUBLIC DMA2_Channel1_IRQHandler
        PUBLIC DMA2_Channel2_IRQHandler
        PUBLIC DMA2_Channel3_IRQHandler
        PUBLIC DMA2_Channel4_5_IRQHandler
        PUBLIC DebugMonitor
        PUBLIC Delay_Cnt
        PUBLIC Delay_Counter
        PUBLIC EXTI0_IRQHandler
        PUBLIC EXTI15_10_IRQHandler
        PUBLIC EXTI1_IRQHandler
        PUBLIC EXTI2_IRQHandler
        PUBLIC EXTI3_IRQHandler
        PUBLIC EXTI4_IRQHandler
        PUBLIC EXTI9_5_IRQHandler
        PUBLIC FLASH_IRQHandler
        PUBLIC FSMC_IRQHandler
        PUBLIC HardFaultException
        PUBLIC I2C1_ER_IRQHandler
        PUBLIC I2C1_EV_IRQHandler
        PUBLIC I2C2_ER_IRQHandler
        PUBLIC I2C2_EV_IRQHandler
        PUBLIC Key_Buffer
        PUBLIC Key_Repeat_Cnt
        PUBLIC Key_Status_Last
        PUBLIC Key_Wait_Cnt
        PUBLIC MemManageException
        PUBLIC NMIException
        PUBLIC PD_Cnt
        PUBLIC PVD_IRQHandler
        PUBLIC PendSVC
        PUBLIC RCC_IRQHandler
        PUBLIC RTCAlarm_IRQHandler
        PUBLIC RTC_IRQHandler
        PUBLIC SDIO_IRQHandler
        PUBLIC SPI1_IRQHandler
        PUBLIC SPI2_IRQHandler
        PUBLIC SPI3_IRQHandler
        PUBLIC SVCHandler
        PUBLIC Sec_Cnt
        PUBLIC SysTickHandler
        PUBLIC TAMPER_IRQHandler
        PUBLIC TIM1_BRK_IRQHandler
        PUBLIC TIM1_CC_IRQHandler
        PUBLIC TIM1_TRG_COM_IRQHandler
        PUBLIC TIM1_UP_IRQHandler
        PUBLIC TIM2_IRQHandler
        PUBLIC TIM3_IRQHandler
        PUBLIC TIM4_IRQHandler
        PUBLIC TIM5_IRQHandler
        PUBLIC TIM6_IRQHandler
        PUBLIC TIM7_IRQHandler
        PUBLIC TIM8_BRK_IRQHandler
        PUBLIC TIM8_CC_IRQHandler
        PUBLIC TIM8_TRG_COM_IRQHandler
        PUBLIC TIM8_UP_IRQHandler
        PUBLIC Twink
        PUBLIC UART4_IRQHandler
        PUBLIC UART5_IRQHandler
        PUBLIC USART1_IRQHandler
        PUBLIC USART2_IRQHandler
        PUBLIC USART3_IRQHandler
        PUBLIC USBWakeUp_IRQHandler
        PUBLIC USB_HP_CAN_TX_IRQHandler
        PUBLIC USB_LP_CAN_RX0_IRQHandler
        PUBLIC UsageFaultException
        PUBLIC WWDG_IRQHandler
        
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
        
// E:\Mini-DS\DS203\SYS_V1.50\source\Interrupt.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : Interrupt.c  
//    3  Version   : DS203_SYS Ver 1.3x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include "Interrupt.h"
//    6 #include "Function.h"
//    7 #include "Config.h"
//    8 #include "BIOS.h"
//    9 #include "ASM.h"
//   10 #include "USB_istr.h"
//   11 #include "USB_int.h"
//   12 

        SECTION `.bss`:DATA:NOROOT(1)
//   13 vu8  Cursor_Cnt, Key_Wait_Cnt, Key_Repeat_Cnt, Key_Buffer, Cnt_mS, Cnt_20mS, Twink;
Cursor_Cnt:
        DS8 1
Key_Wait_Cnt:
        DS8 1
Key_Repeat_Cnt:
        DS8 1
Key_Buffer:
        DS8 1
Cnt_mS:
        DS8 1
Cnt_20mS:
        DS8 1
Twink:
        DS8 1
        DS8 1
//   14 vu16 Delay_Cnt, Beep_mS, Key_Status_Last, Sec_Cnt, PD_Cnt;
Delay_Cnt:
        DS8 2
Sec_Cnt:
        DS8 2
PD_Cnt:
        DS8 2
//   15 
//   16 vu16 Delay_Counter, Beep_mS, Key_Status_Last;
Beep_mS:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(1)
Delay_Counter:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(1)
Key_Status_Last:
        DS8 2
//   17 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function NMIException
        THUMB
//   18 void NMIException(void)
//   19 {}
NMIException:
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//   20 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function HardFaultException
        THUMB
//   21 void HardFaultException(void)
//   22 {
//   23   while (1) {}
HardFaultException:
??HardFaultException_0:
        B.N      ??HardFaultException_0
        CFI EndBlock cfiBlock1
//   24 }
//   25 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function MemManageException
        THUMB
//   26 void MemManageException(void)
//   27 {
//   28   while (1) {}
MemManageException:
??MemManageException_0:
        B.N      ??MemManageException_0
        CFI EndBlock cfiBlock2
//   29 }
//   30 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function BusFaultException
        THUMB
//   31 void BusFaultException(void)
//   32 {
//   33   while (1) {}
BusFaultException:
??BusFaultException_0:
        B.N      ??BusFaultException_0
        CFI EndBlock cfiBlock3
//   34 }

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function UsageFaultException
        THUMB
//   35 void UsageFaultException(void)
//   36 {
//   37   while (1) {}
UsageFaultException:
??UsageFaultException_0:
        B.N      ??UsageFaultException_0
        CFI EndBlock cfiBlock4
//   38 }
//   39 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function DebugMonitor
        THUMB
//   40 void DebugMonitor(void)
//   41 {}
DebugMonitor:
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//   42 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function SVCHandler
        THUMB
//   43 void SVCHandler(void)
//   44 {}
SVCHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//   45 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function PendSVC
        THUMB
//   46 void PendSVC(void)
//   47 {}
PendSVC:
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//   48 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function SysTickHandler
        THUMB
//   49 void SysTickHandler(void)
//   50 {}
SysTickHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//   51 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function WWDG_IRQHandler
        THUMB
//   52 void WWDG_IRQHandler(void)
//   53 {}
WWDG_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//   54 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function PVD_IRQHandler
        THUMB
//   55 void PVD_IRQHandler(void)
//   56 {}
PVD_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//   57 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function TAMPER_IRQHandler
        THUMB
//   58 void TAMPER_IRQHandler(void)
//   59 {}
TAMPER_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//   60 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function RTC_IRQHandler
        THUMB
//   61 void RTC_IRQHandler(void)
//   62 {}
RTC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock12
//   63 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function FLASH_IRQHandler
        THUMB
//   64 void FLASH_IRQHandler(void)
//   65 {}
FLASH_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock13
//   66 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function RCC_IRQHandler
        THUMB
//   67 void RCC_IRQHandler(void)
//   68 {}
RCC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock14
//   69 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function EXTI0_IRQHandler
        THUMB
//   70 void EXTI0_IRQHandler(void)
//   71 {}
EXTI0_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock15
//   72 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function EXTI1_IRQHandler
        THUMB
//   73 void EXTI1_IRQHandler(void)
//   74 {}
EXTI1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock16
//   75 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function EXTI2_IRQHandler
        THUMB
//   76 void EXTI2_IRQHandler(void)
//   77 {}
EXTI2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock17
//   78 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function EXTI3_IRQHandler
        THUMB
//   79 void EXTI3_IRQHandler(void)
//   80 {}
EXTI3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock18
//   81 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI Function EXTI4_IRQHandler
        THUMB
//   82 void EXTI4_IRQHandler(void)
//   83 {}
EXTI4_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock19
//   84 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock20 Using cfiCommon0
        CFI Function DMA1_Channel1_IRQHandler
        THUMB
//   85 void DMA1_Channel1_IRQHandler(void)
//   86 {}
DMA1_Channel1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock20
//   87 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock21 Using cfiCommon0
        CFI Function DMA1_Channel2_IRQHandler
        THUMB
//   88 void DMA1_Channel2_IRQHandler(void)
//   89 {}
DMA1_Channel2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock21
//   90 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock22 Using cfiCommon0
        CFI Function DMA1_Channel3_IRQHandler
        THUMB
//   91 void DMA1_Channel3_IRQHandler(void)
//   92 {}
DMA1_Channel3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock22
//   93 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock23 Using cfiCommon0
        CFI Function DMA1_Channel4_IRQHandler
        THUMB
//   94 void DMA1_Channel4_IRQHandler(void)
//   95 {}
DMA1_Channel4_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock23
//   96 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock24 Using cfiCommon0
        CFI Function DMA1_Channel5_IRQHandler
        THUMB
//   97 void DMA1_Channel5_IRQHandler(void)
//   98 {}
DMA1_Channel5_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock24
//   99 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock25 Using cfiCommon0
        CFI Function DMA1_Channel6_IRQHandler
        THUMB
//  100 void DMA1_Channel6_IRQHandler(void)
//  101 {}
DMA1_Channel6_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock25
//  102 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock26 Using cfiCommon0
        CFI Function DMA1_Channel7_IRQHandler
        THUMB
//  103 void DMA1_Channel7_IRQHandler(void)
//  104 {}
DMA1_Channel7_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock26
//  105 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock27 Using cfiCommon0
        CFI Function ADC1_2_IRQHandler
        THUMB
//  106 void ADC1_2_IRQHandler(void)
//  107 {}
ADC1_2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock27
//  108 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock28 Using cfiCommon0
        CFI Function USB_HP_CAN_TX_IRQHandler
        THUMB
//  109 void USB_HP_CAN_TX_IRQHandler(void)
//  110 {
//  111   CTR_HP();
USB_HP_CAN_TX_IRQHandler:
        B.W      CTR_HP
        CFI EndBlock cfiBlock28
//  112 }
//  113 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock29 Using cfiCommon0
        CFI Function USB_LP_CAN_RX0_IRQHandler
        THUMB
//  114 void USB_LP_CAN_RX0_IRQHandler(void)
//  115 {
//  116   USB_Istr();
USB_LP_CAN_RX0_IRQHandler:
        B.W      USB_Istr
        CFI EndBlock cfiBlock29
//  117 }
//  118 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock30 Using cfiCommon0
        CFI Function CAN_RX1_IRQHandler
        THUMB
//  119 void CAN_RX1_IRQHandler(void)
//  120 {}
CAN_RX1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock30
//  121 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock31 Using cfiCommon0
        CFI Function CAN_SCE_IRQHandler
        THUMB
//  122 void CAN_SCE_IRQHandler(void)
//  123 {}
CAN_SCE_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock31
//  124 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock32 Using cfiCommon0
        CFI Function EXTI9_5_IRQHandler
        THUMB
//  125 void EXTI9_5_IRQHandler(void)
//  126 {}
EXTI9_5_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock32
//  127 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock33 Using cfiCommon0
        CFI Function TIM1_BRK_IRQHandler
        THUMB
//  128 void TIM1_BRK_IRQHandler(void)
//  129 {}
TIM1_BRK_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock33
//  130 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock34 Using cfiCommon0
        CFI Function TIM1_UP_IRQHandler
        THUMB
//  131 void TIM1_UP_IRQHandler(void)
//  132 {}
TIM1_UP_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock34
//  133 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock35 Using cfiCommon0
        CFI Function TIM1_TRG_COM_IRQHandler
        THUMB
//  134 void TIM1_TRG_COM_IRQHandler(void)
//  135 {}
TIM1_TRG_COM_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock35
//  136 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock36 Using cfiCommon0
        CFI Function TIM1_CC_IRQHandler
        THUMB
//  137 void TIM1_CC_IRQHandler(void)
//  138 {}
TIM1_CC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock36
//  139 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock37 Using cfiCommon0
        CFI Function TIM2_IRQHandler
        THUMB
//  140 void TIM2_IRQHandler(void)
//  141 {}
TIM2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock37
//  142 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock38 Using cfiCommon0
        CFI Function TIM3_IRQHandler
        THUMB
//  143 void TIM3_IRQHandler(void)
//  144 {
TIM3_IRQHandler:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  145   u8 KeyCode;
//  146   
//  147   TIM3_SR = 0;                             //Clear TIM3 interrupt flag
        LDR.N    R0,??TIM3_IRQHandler_0  ;; 0x40000410
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  148   if(Cnt_mS > 0)   Cnt_mS--;
        LDR.N    R4,??TIM3_IRQHandler_0+0x4  ;; Cursor_Cnt
        LDRB     R0,[R4, #+4]
        CBZ      R0,??TIM3_IRQHandler_1
        LDRB     R0,[R4, #+4]
        SUBS     R0,R0,#+1
        STRB     R0,[R4, #+4]
        POP      {R4,PC}
//  149   else {                                   //Read keys per 20mS
//  150     Cnt_mS =20;
??TIM3_IRQHandler_1:
        MOVS     R0,#+20
        STRB     R0,[R4, #+4]
//  151     if(Delay_Cnt >20) Delay_Cnt -= 20;
        LDRH     R0,[R4, #+8]
        CMP      R0,#+21
        BCC.N    ??TIM3_IRQHandler_2
        LDRH     R0,[R4, #+8]
        SUBS     R0,R0,#+20
        STRH     R0,[R4, #+8]
        B.N      ??TIM3_IRQHandler_3
//  152     else              Delay_Cnt  = 0;
??TIM3_IRQHandler_2:
        STRH     R1,[R4, #+8]
//  153     if(Beep_mS >20){
??TIM3_IRQHandler_3:
        LDRH     R0,[R4, #+14]
        CMP      R0,#+21
        BCC.N    ??TIM3_IRQHandler_4
//  154       Beep_mS   -= 20; 
        LDRH     R0,[R4, #+14]
        SUBS     R0,R0,#+20
        STRH     R0,[R4, #+14]
//  155       if(Beep_mS <= 20){
        LDRH     R0,[R4, #+14]
        CMP      R0,#+21
        BCS.N    ??TIM3_IRQHandler_5
//  156         Set(BEEP_VOLUME, 0);        // Beep off
        MOVS     R0,#+3
        B.N      ??TIM3_IRQHandler_6
//  157       }
//  158     }
//  159     else 
//  160     if(Cnt_20mS < 50) Cnt_20mS++;
??TIM3_IRQHandler_4:
        LDRB     R0,[R4, #+5]
        CMP      R0,#+50
        BCS.N    ??TIM3_IRQHandler_7
        LDRB     R0,[R4, #+5]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+5]
        B.N      ??TIM3_IRQHandler_5
//  161     else {                                 // Do it pre sec.
//  162       Cnt_20mS = 0;
??TIM3_IRQHandler_7:
        STRB     R1,[R4, #+5]
//  163       Sec_Cnt++;
        LDRH     R0,[R4, #+10]
        ADDS     R0,R0,#+1
        STRH     R0,[R4, #+10]
//  164       Set(BETTERY_DT, 1);           //Battery Detect
        MOVS     R1,#+1
        MOVS     R0,#+4
??TIM3_IRQHandler_6:
        BL       Set
//  165     }
//  166     Cursor_Cnt++;
??TIM3_IRQHandler_5:
        LDRB     R0,[R4, #+0]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+0]
//  167     if(Cursor_Cnt >= 12) {                 //12*20mS=240mS
        LDRB     R0,[R4, #+0]
        CMP      R0,#+12
        BCC.N    ??TIM3_IRQHandler_8
//  168       Cursor_Cnt=0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  169       Twink=!Twink;
        LDRB     R1,[R4, #+6]
        SUBS     R0,R1,#+1
        SBCS     R0,R0,R0
        LSRS     R0,R0,#+31
        STRB     R0,[R4, #+6]
//  170       if(PD_Cnt > 0) PD_Cnt--;
        LDRH     R0,[R4, #+12]
        CBZ      R0,??TIM3_IRQHandler_8
        LDRH     R0,[R4, #+12]
        SUBS     R0,R0,#+1
        STRH     R0,[R4, #+12]
//  171     }
//  172     if(Key_Wait_Cnt)    Key_Wait_Cnt--;
??TIM3_IRQHandler_8:
        LDRB     R0,[R4, #+1]
        CBZ      R0,??TIM3_IRQHandler_9
        LDRB     R0,[R4, #+1]
        SUBS     R0,R0,#+1
        STRB     R0,[R4, #+1]
//  173     if(Key_Repeat_Cnt)  Key_Repeat_Cnt--;
??TIM3_IRQHandler_9:
        LDRB     R0,[R4, #+2]
        CBZ      R0,??TIM3_IRQHandler_10
        LDRB     R0,[R4, #+2]
        SUBS     R0,R0,#+1
        STRB     R0,[R4, #+2]
//  174     KeyCode=Read_Keys();
??TIM3_IRQHandler_10:
        BL       Read_Keys
//  175     if(KeyCode !=0) {
        MOVS     R1,R0
        BEQ.N    ??TIM3_IRQHandler_11
//  176       Key_Buffer = KeyCode;
        STRB     R0,[R4, #+3]
//  177       Set(BEEP_VOLUME, 20);
        MOVS     R1,#+20
        MOVS     R0,#+3
        BL       Set
//  178       Beep_mS = 60; 
        MOVS     R0,#+60
        STRH     R0,[R4, #+14]
//  179     }
//  180   }
//  181 }
??TIM3_IRQHandler_11:
        POP      {R4,PC}          ;; return
        Nop      
        DATA
??TIM3_IRQHandler_0:
        DC32     0x40000410
        DC32     Cursor_Cnt
        CFI EndBlock cfiBlock38
//  182 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock39 Using cfiCommon0
        CFI Function TIM4_IRQHandler
        THUMB
//  183 void TIM4_IRQHandler(void)
//  184 {}
TIM4_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock39
//  185 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock40 Using cfiCommon0
        CFI Function I2C1_EV_IRQHandler
        THUMB
//  186 void I2C1_EV_IRQHandler(void)
//  187 {}
I2C1_EV_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock40
//  188 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock41 Using cfiCommon0
        CFI Function I2C1_ER_IRQHandler
        THUMB
//  189 void I2C1_ER_IRQHandler(void)
//  190 {}
I2C1_ER_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock41
//  191 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock42 Using cfiCommon0
        CFI Function I2C2_EV_IRQHandler
        THUMB
//  192 void I2C2_EV_IRQHandler(void)
//  193 {}
I2C2_EV_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock42
//  194 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock43 Using cfiCommon0
        CFI Function I2C2_ER_IRQHandler
        THUMB
//  195 void I2C2_ER_IRQHandler(void)
//  196 {}
I2C2_ER_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock43
//  197 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock44 Using cfiCommon0
        CFI Function SPI1_IRQHandler
        THUMB
//  198 void SPI1_IRQHandler(void)
//  199 {}
SPI1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock44
//  200 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock45 Using cfiCommon0
        CFI Function SPI2_IRQHandler
        THUMB
//  201 void SPI2_IRQHandler(void)
//  202 {}
SPI2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock45
//  203 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock46 Using cfiCommon0
        CFI Function USART1_IRQHandler
        THUMB
//  204 void USART1_IRQHandler(void)
//  205 {}
USART1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock46
//  206 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock47 Using cfiCommon0
        CFI Function USART2_IRQHandler
        THUMB
//  207 void USART2_IRQHandler(void)
//  208 {}
USART2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock47
//  209 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock48 Using cfiCommon0
        CFI Function USART3_IRQHandler
        THUMB
//  210 void USART3_IRQHandler(void)
//  211 {}
USART3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock48
//  212 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock49 Using cfiCommon0
        CFI Function EXTI15_10_IRQHandler
        THUMB
//  213 void EXTI15_10_IRQHandler(void)
//  214 {}
EXTI15_10_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock49
//  215 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock50 Using cfiCommon0
        CFI Function RTCAlarm_IRQHandler
        THUMB
//  216 void RTCAlarm_IRQHandler(void)
//  217 {}
RTCAlarm_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock50
//  218 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock51 Using cfiCommon0
        CFI Function USBWakeUp_IRQHandler
        THUMB
//  219 void USBWakeUp_IRQHandler(void)
//  220 {}
USBWakeUp_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock51
//  221 /*******************************************************************************
//  222 * Function Name  : TIM8_BRK_IRQHandler
//  223 * Description    : This function handles TIM8 Break interrupt request.
//  224 * Input          : None
//  225 * Output         : None
//  226 * Return         : None
//  227 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock52 Using cfiCommon0
        CFI Function TIM8_BRK_IRQHandler
        THUMB
//  228 void TIM8_BRK_IRQHandler(void)
//  229 {}
TIM8_BRK_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock52
//  230 
//  231 /*******************************************************************************
//  232 * Function Name  : TIM8_UP_IRQHandler
//  233 * Description    : This function handles TIM8 overflow and update interrupt
//  234 *                  request.
//  235 * Input          : None
//  236 * Output         : None
//  237 * Return         : None
//  238 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock53 Using cfiCommon0
        CFI Function TIM8_UP_IRQHandler
        THUMB
//  239 void TIM8_UP_IRQHandler(void)
//  240 {}
TIM8_UP_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock53
//  241 
//  242 /*******************************************************************************
//  243 * Function Name  : TIM8_TRG_COM_IRQHandler
//  244 * Description    : This function handles TIM8 Trigger and commutation interrupts
//  245 *                  requests.
//  246 * Input          : None
//  247 * Output         : None
//  248 * Return         : None
//  249 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock54 Using cfiCommon0
        CFI Function TIM8_TRG_COM_IRQHandler
        THUMB
//  250 void TIM8_TRG_COM_IRQHandler(void)
//  251 {}
TIM8_TRG_COM_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock54
//  252 
//  253 /*******************************************************************************
//  254 * Function Name  : TIM8_CC_IRQHandler
//  255 * Description    : This function handles TIM8 capture compare interrupt request.
//  256 * Input          : None
//  257 * Output         : None
//  258 * Return         : None
//  259 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock55 Using cfiCommon0
        CFI Function TIM8_CC_IRQHandler
        THUMB
//  260 void TIM8_CC_IRQHandler(void)
//  261 {}
TIM8_CC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock55
//  262 
//  263 /*******************************************************************************
//  264 * Function Name  : ADC3_IRQHandler
//  265 * Description    : This function handles ADC3 global interrupt request.
//  266 * Input          : None
//  267 * Output         : None
//  268 * Return         : None
//  269 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock56 Using cfiCommon0
        CFI Function ADC3_IRQHandler
        THUMB
//  270 void ADC3_IRQHandler(void)
//  271 {}
ADC3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock56
//  272 
//  273 /*******************************************************************************
//  274 * Function Name  : FSMC_IRQHandler
//  275 * Description    : This function handles FSMC global interrupt request.
//  276 * Input          : None
//  277 * Output         : None
//  278 * Return         : None
//  279 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock57 Using cfiCommon0
        CFI Function FSMC_IRQHandler
        THUMB
//  280 void FSMC_IRQHandler(void)
//  281 {}
FSMC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock57
//  282 
//  283 /*******************************************************************************
//  284 * Function Name  : SDIO_IRQHandler
//  285 * Description    : This function handles SDIO global interrupt request.
//  286 * Input          : None
//  287 * Output         : None
//  288 * Return         : None
//  289 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock58 Using cfiCommon0
        CFI Function SDIO_IRQHandler
        THUMB
//  290 void SDIO_IRQHandler(void)
//  291 { 
//  292   /* Process All SDIO Interrupt Sources */
//  293 //  SD_ProcessIRQSrc();
//  294   
//  295 }
SDIO_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock58
//  296 
//  297 /*******************************************************************************
//  298 * Function Name  : TIM5_IRQHandler
//  299 * Description    : This function handles TIM5 global interrupt request.
//  300 * Input          : None
//  301 * Output         : None
//  302 * Return         : None
//  303 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock59 Using cfiCommon0
        CFI Function TIM5_IRQHandler
        THUMB
//  304 void TIM5_IRQHandler(void)
//  305 {}
TIM5_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock59
//  306 
//  307 /*******************************************************************************
//  308 * Function Name  : SPI3_IRQHandler
//  309 * Description    : This function handles SPI3 global interrupt request.
//  310 * Input          : None
//  311 * Output         : None
//  312 * Return         : None
//  313 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock60 Using cfiCommon0
        CFI Function SPI3_IRQHandler
        THUMB
//  314 void SPI3_IRQHandler(void)
//  315 {}
SPI3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock60
//  316 
//  317 /*******************************************************************************
//  318 * Function Name  : UART4_IRQHandler
//  319 * Description    : This function handles UART4 global interrupt request.
//  320 * Input          : None
//  321 * Output         : None
//  322 * Return         : None
//  323 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock61 Using cfiCommon0
        CFI Function UART4_IRQHandler
        THUMB
//  324 void UART4_IRQHandler(void)
//  325 {}
UART4_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock61
//  326 
//  327 /*******************************************************************************
//  328 * Function Name  : UART5_IRQHandler
//  329 * Description    : This function handles UART5 global interrupt request.
//  330 * Input          : None
//  331 * Output         : None
//  332 * Return         : None
//  333 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock62 Using cfiCommon0
        CFI Function UART5_IRQHandler
        THUMB
//  334 void UART5_IRQHandler(void)
//  335 {}
UART5_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock62
//  336 
//  337 /*******************************************************************************
//  338 * Function Name  : TIM6_IRQHandler
//  339 * Description    : This function handles TIM6 global interrupt request.
//  340 * Input          : None
//  341 * Output         : None
//  342 * Return         : None
//  343 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock63 Using cfiCommon0
        CFI Function TIM6_IRQHandler
        THUMB
//  344 void TIM6_IRQHandler(void)
//  345 {}
TIM6_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock63
//  346 
//  347 /*******************************************************************************
//  348 * Function Name  : TIM7_IRQHandler
//  349 * Description    : This function handles TIM7 global interrupt request.
//  350 * Input          : None
//  351 * Output         : None
//  352 * Return         : None
//  353 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock64 Using cfiCommon0
        CFI Function TIM7_IRQHandler
        THUMB
//  354 void TIM7_IRQHandler(void)
//  355 {}
TIM7_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock64
//  356 
//  357 /*******************************************************************************
//  358 * Function Name  : DMA2_Channel1_IRQHandler
//  359 * Description    : This function handles DMA2 Channel 1 interrupt request.
//  360 * Input          : None
//  361 * Output         : None
//  362 * Return         : None
//  363 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock65 Using cfiCommon0
        CFI Function DMA2_Channel1_IRQHandler
        THUMB
//  364 void DMA2_Channel1_IRQHandler(void)
//  365 {}
DMA2_Channel1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock65
//  366 
//  367 /*******************************************************************************
//  368 * Function Name  : DMA2_Channel2_IRQHandler
//  369 * Description    : This function handles DMA2 Channel 2 interrupt request.
//  370 * Input          : None
//  371 * Output         : None
//  372 * Return         : None
//  373 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock66 Using cfiCommon0
        CFI Function DMA2_Channel2_IRQHandler
        THUMB
//  374 void DMA2_Channel2_IRQHandler(void)
//  375 {}
DMA2_Channel2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock66
//  376 
//  377 /*******************************************************************************
//  378 * Function Name  : DMA2_Channel3_IRQHandler
//  379 * Description    : This function handles DMA2 Channel 3 interrupt request.
//  380 * Input          : None
//  381 * Output         : None
//  382 * Return         : None
//  383 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock67 Using cfiCommon0
        CFI Function DMA2_Channel3_IRQHandler
        THUMB
//  384 void DMA2_Channel3_IRQHandler(void)
//  385 {}
DMA2_Channel3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock67
//  386 
//  387 /*******************************************************************************
//  388 * Function Name  : DMA2_Channel4_5_IRQHandler
//  389 * Description    : This function handles DMA2 Channel 4 and DMA2 Channel 5
//  390 *                  interrupt request.
//  391 * Input          : None
//  392 * Output         : None
//  393 * Return         : None
//  394 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock68 Using cfiCommon0
        CFI Function DMA2_Channel4_5_IRQHandler
        THUMB
//  395 void DMA2_Channel4_5_IRQHandler(void)
//  396 {}
DMA2_Channel4_5_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock68

        END
//  397 
//  398 /********************************* END OF FILE ********************************/
// 
//  20 bytes in section .bss
// 324 bytes in section .text
// 
// 324 bytes of CODE memory
//  20 bytes of DATA memory
//
//Errors: none
//Warnings: none
