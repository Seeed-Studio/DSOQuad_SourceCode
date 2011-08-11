///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  11:08:02 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\APP_V2.51\source\Interrupt.c           /
//    Command line =  E:\Mini-DS\DS203\APP_V2.51\source\Interrupt.c -lA       /
//                    E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\List\ -o      /
//                    E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\Obj\ --debug  /
//                    --endian=little --cpu=Cortex-M3 --fpu=None              /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.0 Evaluation\ARM\INC\DLib_Config_Full.h"    /
//                    -I E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\..\..\FWLi /
//                    b\inc\ -I E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\..\ /
//                    ..\USBLib\inc\ -I E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prp /
//                    ject\..\include\ -I "C:\Program Files\IAR               /
//                    Systems\Embedded Workbench 5.0 Evaluation\ARM\INC\"     /
//                    -Ohs                                                    /
//    List file    =  E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\List\Interrup /
//                    t.s                                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Interrupt

        EXTERN Read_Keys
        EXTERN Title
        EXTERN __CTR_HP
        EXTERN __Set
        EXTERN __USB_Istr

        PUBLIC ADC1_2_IRQHandler
        PUBLIC ADC3_IRQHandler
        PUBLIC Beep_mS
        PUBLIC Blink
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
        PUBLIC Light
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
        PUBLIC Volume
        PUBLIC WWDG_IRQHandler
        PUBLIC Wait_Cnt
        
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
        
// E:\Mini-DS\DS203\APP_V2.51\source\Interrupt.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : Interrupt.c  
//    3  Version   : DS203_APP Ver 2.3x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include "Interrupt.h"
//    6 #include "Function.h"
//    7 #include "Menu.h"
//    8 #include "BIOS.h"
//    9 
//   10 vu8  Cursor_Cnt, Key_Wait_Cnt, Key_Repeat_Cnt, Key_Buffer, Cnt_mS, Cnt_20mS;
//   11 vu8  Twink, Blink;

        SECTION `.data`:DATA:NOROOT(0)
//   12 u8   Volume=20, Light;
Volume:
        DATA
        DC8 20

        SECTION `.bss`:DATA:NOROOT(2)
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
Blink:
        DS8 1
//   13 vu16 Delay_Cnt, Beep_mS, Key_Status_Last, Sec_Cnt, PD_Cnt;
Delay_Cnt:
        DS8 2
Beep_mS:
        DS8 2
Sec_Cnt:
        DS8 2
PD_Cnt:
        DS8 2
//   14 vu32 Wait_Cnt; 
Wait_Cnt:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(0)
Light:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(1)
Key_Status_Last:
        DS8 2
//   15 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function NMIException
        THUMB
//   16 void NMIException(void)
//   17 {}
NMIException:
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//   18 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function HardFaultException
        THUMB
//   19 void HardFaultException(void)
//   20 {
//   21   while (1) {}
HardFaultException:
??HardFaultException_0:
        B.N      ??HardFaultException_0
        CFI EndBlock cfiBlock1
//   22 }
//   23 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function MemManageException
        THUMB
//   24 void MemManageException(void)
//   25 {
//   26   while (1) {}
MemManageException:
??MemManageException_0:
        B.N      ??MemManageException_0
        CFI EndBlock cfiBlock2
//   27 }
//   28 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function BusFaultException
        THUMB
//   29 void BusFaultException(void)
//   30 {
//   31   while (1) {}
BusFaultException:
??BusFaultException_0:
        B.N      ??BusFaultException_0
        CFI EndBlock cfiBlock3
//   32 }

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function UsageFaultException
        THUMB
//   33 void UsageFaultException(void)
//   34 {
//   35   while (1) {}
UsageFaultException:
??UsageFaultException_0:
        B.N      ??UsageFaultException_0
        CFI EndBlock cfiBlock4
//   36 }
//   37 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function DebugMonitor
        THUMB
//   38 void DebugMonitor(void)
//   39 {}
DebugMonitor:
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//   40 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function SVCHandler
        THUMB
//   41 void SVCHandler(void)
//   42 {}
SVCHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//   43 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function PendSVC
        THUMB
//   44 void PendSVC(void)
//   45 {}
PendSVC:
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//   46 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function SysTickHandler
        THUMB
//   47 void SysTickHandler(void)
//   48 {}
SysTickHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//   49 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function WWDG_IRQHandler
        THUMB
//   50 void WWDG_IRQHandler(void)
//   51 {}
WWDG_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//   52 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function PVD_IRQHandler
        THUMB
//   53 void PVD_IRQHandler(void)
//   54 {}
PVD_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//   55 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function TAMPER_IRQHandler
        THUMB
//   56 void TAMPER_IRQHandler(void)
//   57 {}
TAMPER_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//   58 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function RTC_IRQHandler
        THUMB
//   59 void RTC_IRQHandler(void)
//   60 {}
RTC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock12
//   61 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function FLASH_IRQHandler
        THUMB
//   62 void FLASH_IRQHandler(void)
//   63 {}
FLASH_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock13
//   64 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function RCC_IRQHandler
        THUMB
//   65 void RCC_IRQHandler(void)
//   66 {}
RCC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock14
//   67 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function EXTI0_IRQHandler
        THUMB
//   68 void EXTI0_IRQHandler(void)
//   69 {}
EXTI0_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock15
//   70 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function EXTI1_IRQHandler
        THUMB
//   71 void EXTI1_IRQHandler(void)
//   72 {}
EXTI1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock16
//   73 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function EXTI2_IRQHandler
        THUMB
//   74 void EXTI2_IRQHandler(void)
//   75 {}
EXTI2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock17
//   76 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function EXTI3_IRQHandler
        THUMB
//   77 void EXTI3_IRQHandler(void)
//   78 {}
EXTI3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock18
//   79 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI Function EXTI4_IRQHandler
        THUMB
//   80 void EXTI4_IRQHandler(void)
//   81 {}
EXTI4_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock19
//   82 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock20 Using cfiCommon0
        CFI Function DMA1_Channel1_IRQHandler
        THUMB
//   83 void DMA1_Channel1_IRQHandler(void)
//   84 {}
DMA1_Channel1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock20
//   85 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock21 Using cfiCommon0
        CFI Function DMA1_Channel2_IRQHandler
        THUMB
//   86 void DMA1_Channel2_IRQHandler(void)
//   87 {}
DMA1_Channel2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock21
//   88 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock22 Using cfiCommon0
        CFI Function DMA1_Channel3_IRQHandler
        THUMB
//   89 void DMA1_Channel3_IRQHandler(void)
//   90 {}
DMA1_Channel3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock22
//   91 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock23 Using cfiCommon0
        CFI Function DMA1_Channel4_IRQHandler
        THUMB
//   92 void DMA1_Channel4_IRQHandler(void)
//   93 {}
DMA1_Channel4_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock23
//   94 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock24 Using cfiCommon0
        CFI Function DMA1_Channel5_IRQHandler
        THUMB
//   95 void DMA1_Channel5_IRQHandler(void)
//   96 {}
DMA1_Channel5_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock24
//   97 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock25 Using cfiCommon0
        CFI Function DMA1_Channel6_IRQHandler
        THUMB
//   98 void DMA1_Channel6_IRQHandler(void)
//   99 {}
DMA1_Channel6_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock25
//  100 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock26 Using cfiCommon0
        CFI Function DMA1_Channel7_IRQHandler
        THUMB
//  101 void DMA1_Channel7_IRQHandler(void)
//  102 {}
DMA1_Channel7_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock26
//  103 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock27 Using cfiCommon0
        CFI Function ADC1_2_IRQHandler
        THUMB
//  104 void ADC1_2_IRQHandler(void)
//  105 {}
ADC1_2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock27
//  106 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock28 Using cfiCommon0
        CFI Function USB_HP_CAN_TX_IRQHandler
        THUMB
//  107 void USB_HP_CAN_TX_IRQHandler(void)
//  108 {
//  109   __CTR_HP();
USB_HP_CAN_TX_IRQHandler:
        B.W      __CTR_HP
        CFI EndBlock cfiBlock28
//  110 }
//  111 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock29 Using cfiCommon0
        CFI Function USB_LP_CAN_RX0_IRQHandler
        THUMB
//  112 void USB_LP_CAN_RX0_IRQHandler(void)
//  113 {
//  114   __USB_Istr();
USB_LP_CAN_RX0_IRQHandler:
        B.W      __USB_Istr
        CFI EndBlock cfiBlock29
//  115 }
//  116 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock30 Using cfiCommon0
        CFI Function CAN_RX1_IRQHandler
        THUMB
//  117 void CAN_RX1_IRQHandler(void)
//  118 {}
CAN_RX1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock30
//  119 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock31 Using cfiCommon0
        CFI Function CAN_SCE_IRQHandler
        THUMB
//  120 void CAN_SCE_IRQHandler(void)
//  121 {}
CAN_SCE_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock31
//  122 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock32 Using cfiCommon0
        CFI Function EXTI9_5_IRQHandler
        THUMB
//  123 void EXTI9_5_IRQHandler(void)
//  124 {}
EXTI9_5_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock32
//  125 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock33 Using cfiCommon0
        CFI Function TIM1_BRK_IRQHandler
        THUMB
//  126 void TIM1_BRK_IRQHandler(void)
//  127 {}
TIM1_BRK_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock33
//  128 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock34 Using cfiCommon0
        CFI Function TIM1_UP_IRQHandler
        THUMB
//  129 void TIM1_UP_IRQHandler(void)
//  130 {}
TIM1_UP_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock34
//  131 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock35 Using cfiCommon0
        CFI Function TIM1_TRG_COM_IRQHandler
        THUMB
//  132 void TIM1_TRG_COM_IRQHandler(void)
//  133 {}
TIM1_TRG_COM_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock35
//  134 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock36 Using cfiCommon0
        CFI Function TIM1_CC_IRQHandler
        THUMB
//  135 void TIM1_CC_IRQHandler(void)
//  136 {}
TIM1_CC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock36
//  137 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock37 Using cfiCommon0
        CFI Function TIM2_IRQHandler
        THUMB
//  138 void TIM2_IRQHandler(void)
//  139 {}
TIM2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock37
//  140 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock38 Using cfiCommon0
        CFI Function TIM3_IRQHandler
        THUMB
//  141 void TIM3_IRQHandler(void)
//  142 {
TIM3_IRQHandler:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  143   u8 KeyCode;
//  144   __Set(KEY_IF_RST, 0);                      //Clear TIM3 interrupt flag
        MOVS     R1,#+0
        MOVS     R0,#+19
        BL       __Set
//  145   if(Cnt_mS > 0)   Cnt_mS--;
        LDR.N    R4,??TIM3_IRQHandler_0  ;; Cursor_Cnt
        LDRB     R0,[R4, #+4]
        CBZ      R0,??TIM3_IRQHandler_1
        LDRB     R0,[R4, #+4]
        SUBS     R0,R0,#+1
        STRB     R0,[R4, #+4]
        POP      {R4,PC}
//  146   else {                                     //Read keys per 20mS
//  147     Cnt_mS =20;
??TIM3_IRQHandler_1:
        MOVS     R0,#+20
        STRB     R0,[R4, #+4]
//  148     if(Wait_Cnt >0)  Wait_Cnt--;
        LDR      R0,[R4, #+16]
        CBZ      R0,??TIM3_IRQHandler_2
        LDR      R0,[R4, #+16]
        SUBS     R0,R0,#+1
        STR      R0,[R4, #+16]
//  149     if(Delay_Cnt >20) Delay_Cnt -= 20;
??TIM3_IRQHandler_2:
        LDRH     R0,[R4, #+8]
        CMP      R0,#+21
        BCC.N    ??TIM3_IRQHandler_3
        LDRH     R0,[R4, #+8]
        SUBS     R0,R0,#+20
        B.N      ??TIM3_IRQHandler_4
//  150     else              Delay_Cnt  = 0;
??TIM3_IRQHandler_3:
        MOVS     R0,#+0
??TIM3_IRQHandler_4:
        STRH     R0,[R4, #+8]
//  151     if(Beep_mS >=20)  Beep_mS   -= 20;
        LDRH     R0,[R4, #+10]
        CMP      R0,#+20
        BCC.N    ??TIM3_IRQHandler_5
        LDRH     R0,[R4, #+10]
        SUBS     R0,R0,#+20
        STRH     R0,[R4, #+10]
        B.N      ??TIM3_IRQHandler_6
//  152     else              __Set(BEEP_VOLUME, 0); // Beep off
??TIM3_IRQHandler_5:
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       __Set
//  153     if(Cnt_20mS < 50) Cnt_20mS++;
??TIM3_IRQHandler_6:
        LDRB     R0,[R4, #+5]
        CMP      R0,#+50
        BCS.N    ??TIM3_IRQHandler_7
        LDRB     R0,[R4, #+5]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+5]
        B.N      ??TIM3_IRQHandler_8
//  154     else {                                   // Do it pre sec.
//  155       Cnt_20mS = 0;
??TIM3_IRQHandler_7:
        MOVS     R0,#+0
        STRB     R0,[R4, #+5]
//  156       __Set(BETTERY_DT, 1);                  //Battery Detect
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       __Set
//  157       Sec_Cnt++;
        LDRH     R0,[R4, #+12]
        ADDS     R0,R0,#+1
        STRH     R0,[R4, #+12]
//  158       if(PD_Cnt > 0) PD_Cnt--;
        LDRH     R0,[R4, #+14]
        CBZ      R0,??TIM3_IRQHandler_8
        LDRH     R0,[R4, #+14]
        SUBS     R0,R0,#+1
        STRH     R0,[R4, #+14]
//  159     }
//  160     Cursor_Cnt++;
??TIM3_IRQHandler_8:
        LDRB     R0,[R4, #+0]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+0]
//  161     if(Cursor_Cnt >= 12) {                   //12*20mS=240mS
        LDRB     R0,[R4, #+0]
        CMP      R0,#+12
        BCC.N    ??TIM3_IRQHandler_9
//  162       Cursor_Cnt=0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  163       Twink=!Twink;
        LDRB     R1,[R4, #+6]
        SUBS     R0,R1,#+1
        SBCS     R0,R0,R0
        LSRS     R0,R0,#+31
        STRB     R0,[R4, #+6]
//  164       Blink = BLINK;
        MOVS     R0,#+1
        STRB     R0,[R4, #+7]
//  165     }
//  166     if(Key_Wait_Cnt)    Key_Wait_Cnt--;
??TIM3_IRQHandler_9:
        LDRB     R0,[R4, #+1]
        CBZ      R0,??TIM3_IRQHandler_10
        LDRB     R0,[R4, #+1]
        SUBS     R0,R0,#+1
        STRB     R0,[R4, #+1]
//  167     if(Key_Repeat_Cnt)  Key_Repeat_Cnt--;
??TIM3_IRQHandler_10:
        LDRB     R0,[R4, #+2]
        CBZ      R0,??TIM3_IRQHandler_11
        LDRB     R0,[R4, #+2]
        SUBS     R0,R0,#+1
        STRB     R0,[R4, #+2]
//  168     KeyCode=Read_Keys();
??TIM3_IRQHandler_11:
        BL       Read_Keys
//  169     if(KeyCode !=0) {
        MOVS     R1,R0
        BEQ.N    ??TIM3_IRQHandler_12
//  170       Key_Buffer = KeyCode;
        STRB     R0,[R4, #+3]
//  171       __Set(BEEP_VOLUME, 5*(Title[VOLUME][CLASS].Value-1));// Volume
        LDR.N    R0,??TIM3_IRQHandler_0+0x4  ;; Title
        LDRSH    R0,[R0, #+996]
        SUBS     R0,R0,#+1
        MOVS     R1,#+5
        MULS     R1,R0,R1
        MOVS     R0,#+3
        BL       __Set
//  172       Beep_mS = 60; 
        MOVS     R0,#+60
        STRH     R0,[R4, #+10]
//  173     }
//  174   }
//  175 }
??TIM3_IRQHandler_12:
        POP      {R4,PC}          ;; return
        Nop      
        DATA
??TIM3_IRQHandler_0:
        DC32     Cursor_Cnt
        DC32     Title
        CFI EndBlock cfiBlock38
//  176 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock39 Using cfiCommon0
        CFI Function TIM4_IRQHandler
        THUMB
//  177 void TIM4_IRQHandler(void)
//  178 {}
TIM4_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock39
//  179 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock40 Using cfiCommon0
        CFI Function I2C1_EV_IRQHandler
        THUMB
//  180 void I2C1_EV_IRQHandler(void)
//  181 {}
I2C1_EV_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock40
//  182 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock41 Using cfiCommon0
        CFI Function I2C1_ER_IRQHandler
        THUMB
//  183 void I2C1_ER_IRQHandler(void)
//  184 {}
I2C1_ER_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock41
//  185 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock42 Using cfiCommon0
        CFI Function I2C2_EV_IRQHandler
        THUMB
//  186 void I2C2_EV_IRQHandler(void)
//  187 {}
I2C2_EV_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock42
//  188 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock43 Using cfiCommon0
        CFI Function I2C2_ER_IRQHandler
        THUMB
//  189 void I2C2_ER_IRQHandler(void)
//  190 {}
I2C2_ER_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock43
//  191 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock44 Using cfiCommon0
        CFI Function SPI1_IRQHandler
        THUMB
//  192 void SPI1_IRQHandler(void)
//  193 {}
SPI1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock44
//  194 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock45 Using cfiCommon0
        CFI Function SPI2_IRQHandler
        THUMB
//  195 void SPI2_IRQHandler(void)
//  196 {}
SPI2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock45
//  197 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock46 Using cfiCommon0
        CFI Function USART1_IRQHandler
        THUMB
//  198 void USART1_IRQHandler(void)
//  199 {}
USART1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock46
//  200 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock47 Using cfiCommon0
        CFI Function USART2_IRQHandler
        THUMB
//  201 void USART2_IRQHandler(void)
//  202 {}
USART2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock47
//  203 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock48 Using cfiCommon0
        CFI Function USART3_IRQHandler
        THUMB
//  204 void USART3_IRQHandler(void)
//  205 {}
USART3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock48
//  206 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock49 Using cfiCommon0
        CFI Function EXTI15_10_IRQHandler
        THUMB
//  207 void EXTI15_10_IRQHandler(void)
//  208 {}
EXTI15_10_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock49
//  209 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock50 Using cfiCommon0
        CFI Function RTCAlarm_IRQHandler
        THUMB
//  210 void RTCAlarm_IRQHandler(void)
//  211 {}
RTCAlarm_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock50
//  212 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock51 Using cfiCommon0
        CFI Function USBWakeUp_IRQHandler
        THUMB
//  213 void USBWakeUp_IRQHandler(void)
//  214 {}
USBWakeUp_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock51
//  215 /*******************************************************************************
//  216 * Function Name  : TIM8_BRK_IRQHandler
//  217 * Description    : This function handles TIM8 Break interrupt request.
//  218 * Input          : None
//  219 * Output         : None
//  220 * Return         : None
//  221 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock52 Using cfiCommon0
        CFI Function TIM8_BRK_IRQHandler
        THUMB
//  222 void TIM8_BRK_IRQHandler(void)
//  223 {}
TIM8_BRK_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock52
//  224 
//  225 /*******************************************************************************
//  226 * Function Name  : TIM8_UP_IRQHandler
//  227 * Description    : This function handles TIM8 overflow and update interrupt
//  228 *                  request.
//  229 * Input          : None
//  230 * Output         : None
//  231 * Return         : None
//  232 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock53 Using cfiCommon0
        CFI Function TIM8_UP_IRQHandler
        THUMB
//  233 void TIM8_UP_IRQHandler(void)
//  234 {}
TIM8_UP_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock53
//  235 
//  236 /*******************************************************************************
//  237 * Function Name  : TIM8_TRG_COM_IRQHandler
//  238 * Description    : This function handles TIM8 Trigger and commutation interrupts
//  239 *                  requests.
//  240 * Input          : None
//  241 * Output         : None
//  242 * Return         : None
//  243 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock54 Using cfiCommon0
        CFI Function TIM8_TRG_COM_IRQHandler
        THUMB
//  244 void TIM8_TRG_COM_IRQHandler(void)
//  245 {}
TIM8_TRG_COM_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock54
//  246 
//  247 /*******************************************************************************
//  248 * Function Name  : TIM8_CC_IRQHandler
//  249 * Description    : This function handles TIM8 capture compare interrupt request.
//  250 * Input          : None
//  251 * Output         : None
//  252 * Return         : None
//  253 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock55 Using cfiCommon0
        CFI Function TIM8_CC_IRQHandler
        THUMB
//  254 void TIM8_CC_IRQHandler(void)
//  255 {}
TIM8_CC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock55
//  256 
//  257 /*******************************************************************************
//  258 * Function Name  : ADC3_IRQHandler
//  259 * Description    : This function handles ADC3 global interrupt request.
//  260 * Input          : None
//  261 * Output         : None
//  262 * Return         : None
//  263 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock56 Using cfiCommon0
        CFI Function ADC3_IRQHandler
        THUMB
//  264 void ADC3_IRQHandler(void)
//  265 {}
ADC3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock56
//  266 
//  267 /*******************************************************************************
//  268 * Function Name  : FSMC_IRQHandler
//  269 * Description    : This function handles FSMC global interrupt request.
//  270 * Input          : None
//  271 * Output         : None
//  272 * Return         : None
//  273 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock57 Using cfiCommon0
        CFI Function FSMC_IRQHandler
        THUMB
//  274 void FSMC_IRQHandler(void)
//  275 {}
FSMC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock57
//  276 
//  277 /*******************************************************************************
//  278 * Function Name  : SDIO_IRQHandler
//  279 * Description    : This function handles SDIO global interrupt request.
//  280 * Input          : None
//  281 * Output         : None
//  282 * Return         : None
//  283 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock58 Using cfiCommon0
        CFI Function SDIO_IRQHandler
        THUMB
//  284 void SDIO_IRQHandler(void)
//  285 { 
//  286   /* Process All SDIO Interrupt Sources */
//  287 //  SD_ProcessIRQSrc();
//  288   
//  289 }
SDIO_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock58
//  290 
//  291 /*******************************************************************************
//  292 * Function Name  : TIM5_IRQHandler
//  293 * Description    : This function handles TIM5 global interrupt request.
//  294 * Input          : None
//  295 * Output         : None
//  296 * Return         : None
//  297 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock59 Using cfiCommon0
        CFI Function TIM5_IRQHandler
        THUMB
//  298 void TIM5_IRQHandler(void)
//  299 {}
TIM5_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock59
//  300 
//  301 /*******************************************************************************
//  302 * Function Name  : SPI3_IRQHandler
//  303 * Description    : This function handles SPI3 global interrupt request.
//  304 * Input          : None
//  305 * Output         : None
//  306 * Return         : None
//  307 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock60 Using cfiCommon0
        CFI Function SPI3_IRQHandler
        THUMB
//  308 void SPI3_IRQHandler(void)
//  309 {}
SPI3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock60
//  310 
//  311 /*******************************************************************************
//  312 * Function Name  : UART4_IRQHandler
//  313 * Description    : This function handles UART4 global interrupt request.
//  314 * Input          : None
//  315 * Output         : None
//  316 * Return         : None
//  317 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock61 Using cfiCommon0
        CFI Function UART4_IRQHandler
        THUMB
//  318 void UART4_IRQHandler(void)
//  319 {}
UART4_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock61
//  320 
//  321 /*******************************************************************************
//  322 * Function Name  : UART5_IRQHandler
//  323 * Description    : This function handles UART5 global interrupt request.
//  324 * Input          : None
//  325 * Output         : None
//  326 * Return         : None
//  327 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock62 Using cfiCommon0
        CFI Function UART5_IRQHandler
        THUMB
//  328 void UART5_IRQHandler(void)
//  329 {}
UART5_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock62
//  330 
//  331 /*******************************************************************************
//  332 * Function Name  : TIM6_IRQHandler
//  333 * Description    : This function handles TIM6 global interrupt request.
//  334 * Input          : None
//  335 * Output         : None
//  336 * Return         : None
//  337 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock63 Using cfiCommon0
        CFI Function TIM6_IRQHandler
        THUMB
//  338 void TIM6_IRQHandler(void)
//  339 {}
TIM6_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock63
//  340 
//  341 /*******************************************************************************
//  342 * Function Name  : TIM7_IRQHandler
//  343 * Description    : This function handles TIM7 global interrupt request.
//  344 * Input          : None
//  345 * Output         : None
//  346 * Return         : None
//  347 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock64 Using cfiCommon0
        CFI Function TIM7_IRQHandler
        THUMB
//  348 void TIM7_IRQHandler(void)
//  349 {}
TIM7_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock64
//  350 
//  351 /*******************************************************************************
//  352 * Function Name  : DMA2_Channel1_IRQHandler
//  353 * Description    : This function handles DMA2 Channel 1 interrupt request.
//  354 * Input          : None
//  355 * Output         : None
//  356 * Return         : None
//  357 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock65 Using cfiCommon0
        CFI Function DMA2_Channel1_IRQHandler
        THUMB
//  358 void DMA2_Channel1_IRQHandler(void)
//  359 {}
DMA2_Channel1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock65
//  360 
//  361 /*******************************************************************************
//  362 * Function Name  : DMA2_Channel2_IRQHandler
//  363 * Description    : This function handles DMA2 Channel 2 interrupt request.
//  364 * Input          : None
//  365 * Output         : None
//  366 * Return         : None
//  367 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock66 Using cfiCommon0
        CFI Function DMA2_Channel2_IRQHandler
        THUMB
//  368 void DMA2_Channel2_IRQHandler(void)
//  369 {}
DMA2_Channel2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock66
//  370 
//  371 /*******************************************************************************
//  372 * Function Name  : DMA2_Channel3_IRQHandler
//  373 * Description    : This function handles DMA2 Channel 3 interrupt request.
//  374 * Input          : None
//  375 * Output         : None
//  376 * Return         : None
//  377 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock67 Using cfiCommon0
        CFI Function DMA2_Channel3_IRQHandler
        THUMB
//  378 void DMA2_Channel3_IRQHandler(void)
//  379 {}
DMA2_Channel3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock67
//  380 
//  381 /*******************************************************************************
//  382 * Function Name  : DMA2_Channel4_5_IRQHandler
//  383 * Description    : This function handles DMA2 Channel 4 and DMA2 Channel 5
//  384 *                  interrupt request.
//  385 * Input          : None
//  386 * Output         : None
//  387 * Return         : None
//  388 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock68 Using cfiCommon0
        CFI Function DMA2_Channel4_5_IRQHandler
        THUMB
//  389 void DMA2_Channel4_5_IRQHandler(void)
//  390 {}
DMA2_Channel4_5_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock68

        END
//  391 
//  392 /********************************* END OF FILE ********************************/
// 
//  23 bytes in section .bss
//   1 byte  in section .data
// 352 bytes in section .text
// 
// 352 bytes of CODE memory
//  24 bytes of DATA memory
//
//Errors: none
//Warnings: none
