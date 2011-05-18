///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  13:39:19 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\APP_V2.32\IAR_V5_Prpject\stm32f10x_vector.c   /
//    Command line =  E:\DS0203\APP_V2.32\IAR_V5_Prpject\stm32f10x_vector.c   /
//                    -lA E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\ -o         /
//                    E:\DS0203\APP_V2.32\IAR_V5_Prpject\Obj\ --debug         /
//                    --endian=little --cpu=Cortex-M3 --fpu=None              /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.0 Evaluation\ARM\INC\DLib_Config_Full.h"    /
//                    -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\..\FWLib\inc\  /
//                    -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\..\USBLib\inc\ /
//                     -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\include\ -I   /
//                    "C:\Program Files\IAR Systems\Embedded Workbench 5.0    /
//                    Evaluation\ARM\INC\" -Ohs                               /
//    List file    =  E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\stm32f10x_vecto /
//                    r.s                                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f10x_vector

        SECTION CSTACK:DATA:NOROOT(0)

        EXTERN ADC1_2_IRQHandler
        EXTERN ADC3_IRQHandler
        EXTERN BusFaultException
        EXTERN CAN_RX1_IRQHandler
        EXTERN CAN_SCE_IRQHandler
        EXTERN DMA1_Channel1_IRQHandler
        EXTERN DMA1_Channel2_IRQHandler
        EXTERN DMA1_Channel3_IRQHandler
        EXTERN DMA1_Channel4_IRQHandler
        EXTERN DMA1_Channel5_IRQHandler
        EXTERN DMA1_Channel6_IRQHandler
        EXTERN DMA1_Channel7_IRQHandler
        EXTERN DMA2_Channel1_IRQHandler
        EXTERN DMA2_Channel2_IRQHandler
        EXTERN DMA2_Channel3_IRQHandler
        EXTERN DMA2_Channel4_5_IRQHandler
        EXTERN DebugMonitor
        EXTERN EXTI0_IRQHandler
        EXTERN EXTI15_10_IRQHandler
        EXTERN EXTI1_IRQHandler
        EXTERN EXTI2_IRQHandler
        EXTERN EXTI3_IRQHandler
        EXTERN EXTI4_IRQHandler
        EXTERN EXTI9_5_IRQHandler
        EXTERN FLASH_IRQHandler
        EXTERN FSMC_IRQHandler
        EXTERN HardFaultException
        EXTERN I2C1_ER_IRQHandler
        EXTERN I2C1_EV_IRQHandler
        EXTERN I2C2_ER_IRQHandler
        EXTERN I2C2_EV_IRQHandler
        EXTERN MemManageException
        EXTERN NMIException
        EXTERN PVD_IRQHandler
        EXTERN PendSVC
        EXTERN RCC_IRQHandler
        EXTERN RTCAlarm_IRQHandler
        EXTERN RTC_IRQHandler
        EXTERN SDIO_IRQHandler
        EXTERN SPI1_IRQHandler
        EXTERN SPI2_IRQHandler
        EXTERN SPI3_IRQHandler
        EXTERN SVCHandler
        EXTERN SysTickHandler
        EXTERN TAMPER_IRQHandler
        EXTERN TIM1_BRK_IRQHandler
        EXTERN TIM1_CC_IRQHandler
        EXTERN TIM1_TRG_COM_IRQHandler
        EXTERN TIM1_UP_IRQHandler
        EXTERN TIM2_IRQHandler
        EXTERN TIM3_IRQHandler
        EXTERN TIM4_IRQHandler
        EXTERN TIM5_IRQHandler
        EXTERN TIM6_IRQHandler
        EXTERN TIM7_IRQHandler
        EXTERN TIM8_BRK_IRQHandler
        EXTERN TIM8_CC_IRQHandler
        EXTERN TIM8_TRG_COM_IRQHandler
        EXTERN TIM8_UP_IRQHandler
        EXTERN UART4_IRQHandler
        EXTERN UART5_IRQHandler
        EXTERN USART1_IRQHandler
        EXTERN USART2_IRQHandler
        EXTERN USART3_IRQHandler
        EXTERN USBWakeUp_IRQHandler
        EXTERN USB_HP_CAN_TX_IRQHandler
        EXTERN USB_LP_CAN_RX0_IRQHandler
        EXTERN UsageFaultException
        EXTERN WWDG_IRQHandler
        EXTERN __iar_program_start

        PUBLIC __vector_table
// E:\DS0203\APP_V2.32\IAR_V5_Prpject\stm32f10x_vector.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_vector.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.2.1
//    5 * Date               : 09/22/2008
//    6 * Description        : STM32F10x vector table for EWARM4.x toolchain.
//    7 *                      This module performs:
//    8 *                      - Set the initial SP
//    9 *                      - Set the initial PC == __program_start,
//   10 *                      - Set the vector table entries with the exceptions ISR address,
//   11 *                     - Configure external SRAM mounted on STM3210E-EVAL board
//   12 *                       to be used as data memory (optional, to be enabled by user)
//   13 *                      After Reset the Cortex-M3 processor is in Thread mode,
//   14 *                      priority is Privileged, and the Stack is set to Main.
//   15 ********************************************************************************
//   16 * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//   17 * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
//   18 * AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
//   19 * INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
//   20 * CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
//   21 * INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   22 *******************************************************************************/
//   23 
//   24 /* Includes ------------------------------------------------------------------*/
//   25 #include "stm32f10x_lib.h"
//   26 #include "Interrupt.h"
//   27 
//   28 /* Private typedef -----------------------------------------------------------*/
//   29 typedef void( *intfunc )( void );
//   30 typedef union { intfunc __fun; void * __ptr; } intvec_elem;
//   31 
//   32 /* Private define ------------------------------------------------------------*/
//   33 /* Uncomment the following line if you need to use external SRAM mounted on
//   34    STM3210E-EVAL board as data memory */
//   35 
//   36 /* #define DATA_IN_ExtSRAM */
//   37 
//   38 /* Private macro -------------------------------------------------------------*/
//   39 /* Private variables ---------------------------------------------------------*/
//   40 /* Private function prototypes -----------------------------------------------*/
//   41 /* Private functions ---------------------------------------------------------*/
//   42 
//   43 
//   44 #pragma language=extended
//   45 #pragma segment="CSTACK"
//   46 
//   47 void __iar_program_start( void );
//   48 
//   49 //#pragma location = "INTVEC"
//   50 
//   51 
//   52 #pragma location = ".intvec"
//   53 /* STM32F10x Vector Table entries */

        SECTION `.intvec`:CONST:NOROOT(2)
//   54 const intvec_elem __vector_table[] =
__vector_table:
        DATA
        DC32 SFE(CSTACK), __iar_program_start, NMIException, HardFaultException
        DC32 MemManageException, BusFaultException, UsageFaultException, 0H, 0H
        DC32 0H, 0H, SVCHandler, DebugMonitor, 0H, PendSVC, SysTickHandler
        DC32 WWDG_IRQHandler, PVD_IRQHandler, TAMPER_IRQHandler, RTC_IRQHandler
        DC32 FLASH_IRQHandler, RCC_IRQHandler, EXTI0_IRQHandler
        DC32 EXTI1_IRQHandler, EXTI2_IRQHandler, EXTI3_IRQHandler
        DC32 EXTI4_IRQHandler, DMA1_Channel1_IRQHandler
        DC32 DMA1_Channel2_IRQHandler, DMA1_Channel3_IRQHandler
        DC32 DMA1_Channel4_IRQHandler, DMA1_Channel5_IRQHandler
        DC32 DMA1_Channel6_IRQHandler, DMA1_Channel7_IRQHandler
        DC32 ADC1_2_IRQHandler, USB_HP_CAN_TX_IRQHandler
        DC32 USB_LP_CAN_RX0_IRQHandler, CAN_RX1_IRQHandler, CAN_SCE_IRQHandler
        DC32 EXTI9_5_IRQHandler, TIM1_BRK_IRQHandler, TIM1_UP_IRQHandler
        DC32 TIM1_TRG_COM_IRQHandler, TIM1_CC_IRQHandler, TIM2_IRQHandler
        DC32 TIM3_IRQHandler, TIM4_IRQHandler, I2C1_EV_IRQHandler
        DC32 I2C1_ER_IRQHandler, I2C2_EV_IRQHandler, I2C2_ER_IRQHandler
        DC32 SPI1_IRQHandler, SPI2_IRQHandler, USART1_IRQHandler
        DC32 USART2_IRQHandler, USART3_IRQHandler, EXTI15_10_IRQHandler
        DC32 RTCAlarm_IRQHandler, USBWakeUp_IRQHandler, TIM8_BRK_IRQHandler
        DC32 TIM8_UP_IRQHandler, TIM8_TRG_COM_IRQHandler, TIM8_CC_IRQHandler
        DC32 ADC3_IRQHandler, FSMC_IRQHandler, SDIO_IRQHandler, TIM5_IRQHandler
        DC32 SPI3_IRQHandler, UART4_IRQHandler, UART5_IRQHandler
        DC32 TIM6_IRQHandler, TIM7_IRQHandler, DMA2_Channel1_IRQHandler
        DC32 DMA2_Channel2_IRQHandler, DMA2_Channel3_IRQHandler
        DC32 DMA2_Channel4_5_IRQHandler

        SECTION CSTACK:DATA:NOROOT(0)

        END
//   55 {
//   56   { .__ptr = __sfe( "CSTACK" ) },
//   57   __iar_program_start,
//   58   NMIException,
//   59   HardFaultException,
//   60   MemManageException,
//   61   BusFaultException,
//   62   UsageFaultException,
//   63   0, 0, 0, 0,            /* Reserved */ 
//   64   SVCHandler,
//   65   DebugMonitor,
//   66   0,                      /* Reserved */
//   67   PendSVC,
//   68   SysTickHandler,
//   69   WWDG_IRQHandler,
//   70   PVD_IRQHandler,
//   71   TAMPER_IRQHandler,
//   72   RTC_IRQHandler,
//   73   FLASH_IRQHandler,
//   74   RCC_IRQHandler,
//   75   EXTI0_IRQHandler,
//   76   EXTI1_IRQHandler,
//   77   EXTI2_IRQHandler,
//   78   EXTI3_IRQHandler,
//   79   EXTI4_IRQHandler,
//   80   DMA1_Channel1_IRQHandler,
//   81   DMA1_Channel2_IRQHandler,
//   82   DMA1_Channel3_IRQHandler,
//   83   DMA1_Channel4_IRQHandler,
//   84   DMA1_Channel5_IRQHandler,
//   85   DMA1_Channel6_IRQHandler,
//   86   DMA1_Channel7_IRQHandler,
//   87   ADC1_2_IRQHandler,
//   88   USB_HP_CAN_TX_IRQHandler,
//   89   USB_LP_CAN_RX0_IRQHandler,
//   90   CAN_RX1_IRQHandler,
//   91   CAN_SCE_IRQHandler,
//   92   EXTI9_5_IRQHandler,
//   93   TIM1_BRK_IRQHandler,
//   94   TIM1_UP_IRQHandler,
//   95   TIM1_TRG_COM_IRQHandler,
//   96   TIM1_CC_IRQHandler,
//   97   TIM2_IRQHandler,
//   98   TIM3_IRQHandler,
//   99   TIM4_IRQHandler,
//  100   I2C1_EV_IRQHandler,
//  101   I2C1_ER_IRQHandler,
//  102   I2C2_EV_IRQHandler,
//  103   I2C2_ER_IRQHandler,
//  104   SPI1_IRQHandler,
//  105   SPI2_IRQHandler,
//  106   USART1_IRQHandler,
//  107   USART2_IRQHandler,
//  108   USART3_IRQHandler,
//  109   EXTI15_10_IRQHandler,
//  110   RTCAlarm_IRQHandler,
//  111   USBWakeUp_IRQHandler,
//  112   TIM8_BRK_IRQHandler,
//  113   TIM8_UP_IRQHandler,
//  114   TIM8_TRG_COM_IRQHandler,
//  115   TIM8_CC_IRQHandler,
//  116   ADC3_IRQHandler,
//  117   FSMC_IRQHandler,
//  118   SDIO_IRQHandler,
//  119   TIM5_IRQHandler,
//  120   SPI3_IRQHandler,
//  121   UART4_IRQHandler,
//  122   UART5_IRQHandler,
//  123   TIM6_IRQHandler,
//  124   TIM7_IRQHandler,
//  125   DMA2_Channel1_IRQHandler,
//  126   DMA2_Channel2_IRQHandler,
//  127   DMA2_Channel3_IRQHandler,
//  128   DMA2_Channel4_5_IRQHandler,
//  129 };
//  130 #ifdef DATA_IN_ExtSRAM
//  131 #pragma language=extended
//  132 
//  133 __interwork int __low_level_init(void);
//  134 
//  135 #pragma location="ICODE"
//  136 __interwork int __low_level_init(void)
//  137 {
//  138    
//  139 /* FSMC Bank1 NOR/SRAM3 is used for the STM3210E-EVAL, if another Bank is 
//  140   required, then adjust the Register Addresses*/
//  141 
//  142   /* Enable FSMC clock */
//  143   *(vu32 *)0x40021014 = 0x00000114;
//  144   
//  145   /* Enable GPIOD, GPIOE, GPIOF and GPIOG clocks */  
//  146   *(vu32 *)0x40021018 = 0x000001E0;
//  147   
//  148 /* ---------------  SRAM Data lines, NOE and NWE configuration ---------------*/
//  149 /*----------------  SRAM Address lines configuration -------------------------*/
//  150 /*----------------  NOE and NWE configuration --------------------------------*/  
//  151 /*----------------  NE3 configuration ----------------------------------------*/
//  152 /*----------------  NBL0, NBL1 configuration ---------------------------------*/
//  153   
//  154   *(vu32 *)0x40011400 = 0x44BB44BB;
//  155   *(vu32 *)0x40011404 = 0xBBBBBBBB;
//  156   
//  157   *(vu32 *)0x40011800 = 0xB44444BB;
//  158   *(vu32 *)0x40011804 = 0xBBBBBBBB;
//  159    
//  160   *(vu32 *)0x40011C00 = 0x44BBBBBB;
//  161   *(vu32 *)0x40011C04 = 0xBBBB4444;  
//  162 
//  163   *(vu32 *)0x40012000 = 0x44BBBBBB;
//  164   *(vu32 *)0x40012004 = 0x44444B44;
//  165   
//  166 /*----------------  FSMC Configuration ---------------------------------------*/  
//  167 /*----------------  Enable FSMC Bank1_SRAM Bank ------------------------------*/
//  168   
//  169   *(vu32 *)0xA0000010 = 0x00001011;
//  170   *(vu32 *)0xA0000014 = 0x00000200;
//  171   
//  172 
//  173   return (1);
//  174 }
//  175 #endif /*DATA_IN_ExtSRAM*/
//  176 
//  177 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
//  178 
// 
// 304 bytes in section .intvec
// 
// 304 bytes of CONST memory
//
//Errors: none
//Warnings: none
