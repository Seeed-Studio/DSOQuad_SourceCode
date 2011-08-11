///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:03:58 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\stm32f10x_vec /
//                    tor.c                                                   /
//    Command line =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\stm32f10x_vec /
//                    tor.c -lA E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\Lis /
//                    t\ -o E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\Obj\    /
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
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\stm32f10 /
//                    x_vector.s                                              /
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
// E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\stm32f10x_vector.c
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
//   15 *******************************************************************************/
//   16 #include "stm32f10x_lib.h"
//   17 #include "Interrupt.h"
//   18 
//   19 typedef void( *intfunc )( void );
//   20 typedef union { intfunc __fun; void * __ptr; } intvec_elem;
//   21 
//   22 #pragma language=extended
//   23 #pragma segment="CSTACK"
//   24 
//   25 void __iar_program_start( void );
//   26 #pragma location = ".intvec"
//   27 
//   28 //======================= STM32F10x Vector Table entries =======================

        SECTION `.intvec`:CONST:NOROOT(2)
//   29 const intvec_elem __vector_table[] =
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
//   30 {
//   31   { .__ptr = __sfe( "CSTACK" ) },
//   32   __iar_program_start,
//   33   NMIException,
//   34   HardFaultException,
//   35   MemManageException,
//   36   BusFaultException,
//   37   UsageFaultException,
//   38   0, 0, 0, 0,            /* Reserved */ 
//   39   SVCHandler,
//   40   DebugMonitor,
//   41   0,                      /* Reserved */
//   42   PendSVC,
//   43   SysTickHandler,
//   44   WWDG_IRQHandler,
//   45   PVD_IRQHandler,
//   46   TAMPER_IRQHandler,
//   47   RTC_IRQHandler,
//   48   FLASH_IRQHandler,
//   49   RCC_IRQHandler,
//   50   EXTI0_IRQHandler,
//   51   EXTI1_IRQHandler,
//   52   EXTI2_IRQHandler,
//   53   EXTI3_IRQHandler,
//   54   EXTI4_IRQHandler,
//   55   DMA1_Channel1_IRQHandler,
//   56   DMA1_Channel2_IRQHandler,
//   57   DMA1_Channel3_IRQHandler,
//   58   DMA1_Channel4_IRQHandler,
//   59   DMA1_Channel5_IRQHandler,
//   60   DMA1_Channel6_IRQHandler,
//   61   DMA1_Channel7_IRQHandler,
//   62   ADC1_2_IRQHandler,
//   63   USB_HP_CAN_TX_IRQHandler,
//   64   USB_LP_CAN_RX0_IRQHandler,
//   65   CAN_RX1_IRQHandler,
//   66   CAN_SCE_IRQHandler,
//   67   EXTI9_5_IRQHandler,
//   68   TIM1_BRK_IRQHandler,
//   69   TIM1_UP_IRQHandler,
//   70   TIM1_TRG_COM_IRQHandler,
//   71   TIM1_CC_IRQHandler,
//   72   TIM2_IRQHandler,
//   73   TIM3_IRQHandler,
//   74   TIM4_IRQHandler,
//   75   I2C1_EV_IRQHandler,
//   76   I2C1_ER_IRQHandler,
//   77   I2C2_EV_IRQHandler,
//   78   I2C2_ER_IRQHandler,
//   79   SPI1_IRQHandler,
//   80   SPI2_IRQHandler,
//   81   USART1_IRQHandler,
//   82   USART2_IRQHandler,
//   83   USART3_IRQHandler,
//   84   EXTI15_10_IRQHandler,
//   85   RTCAlarm_IRQHandler,
//   86   USBWakeUp_IRQHandler,
//   87   TIM8_BRK_IRQHandler,
//   88   TIM8_UP_IRQHandler,
//   89   TIM8_TRG_COM_IRQHandler,
//   90   TIM8_CC_IRQHandler,
//   91   ADC3_IRQHandler,
//   92   FSMC_IRQHandler,
//   93   SDIO_IRQHandler,
//   94   TIM5_IRQHandler,
//   95   SPI3_IRQHandler,
//   96   UART4_IRQHandler,
//   97   UART5_IRQHandler,
//   98   TIM6_IRQHandler,
//   99   TIM7_IRQHandler,
//  100   DMA2_Channel1_IRQHandler,
//  101   DMA2_Channel2_IRQHandler,
//  102   DMA2_Channel3_IRQHandler,
//  103   DMA2_Channel4_5_IRQHandler,
//  104 /*  
//  105   __CTR_HP,
//  106   __USB_Istr,
//  107   __USB_Init,
//  108   __Point_SCR,
//  109   __LCD_SetPixl,
//  110   __LCD_GetPixl,
//  111   __LCD_Copy,
//  112   __LCD_Fill,
//  113   __Row_Copy,
//  114   __Read_FIFO,
//  115   __Disk_Buff_WR,
//  116   __Disk_Buff_RD,
//  117 */  
//  118   
//  119 };
//  120 #ifdef DATA_IN_ExtSRAM
//  121 #pragma language=extended
//  122 
//  123 __interwork int __low_level_init(void);
//  124 
//  125 #pragma location="ICODE"
//  126 __interwork int __low_level_init(void)
//  127 {
//  128    
//  129 /* FSMC Bank1 NOR/SRAM3 is used for the STM3210E-EVAL, if another Bank is 
//  130   required, then adjust the Register Addresses*/
//  131 
//  132   /* Enable FSMC clock */
//  133   *(vu32 *)0x40021014 = 0x00000114;
//  134   
//  135   /* Enable GPIOD, GPIOE, GPIOF and GPIOG clocks */  
//  136   *(vu32 *)0x40021018 = 0x000001E0;
//  137   
//  138 /* ---------------  SRAM Data lines, NOE and NWE configuration ---------------*/
//  139 /*----------------  SRAM Address lines configuration -------------------------*/
//  140 /*----------------  NOE and NWE configuration --------------------------------*/  
//  141 /*----------------  NE3 configuration ----------------------------------------*/
//  142 /*----------------  NBL0, NBL1 configuration ---------------------------------*/
//  143   
//  144   *(vu32 *)0x40011400 = 0x44BB44BB;
//  145   *(vu32 *)0x40011404 = 0xBBBBBBBB;
//  146   
//  147   *(vu32 *)0x40011800 = 0xB44444BB;
//  148   *(vu32 *)0x40011804 = 0xBBBBBBBB;
//  149    
//  150   *(vu32 *)0x40011C00 = 0x44BBBBBB;
//  151   *(vu32 *)0x40011C04 = 0xBBBB4444;  
//  152 
//  153   *(vu32 *)0x40012000 = 0x44BBBBBB;
//  154   *(vu32 *)0x40012004 = 0x44444B44;
//  155   
//  156 /*----------------  FSMC Configuration ---------------------------------------*/  
//  157 /*----------------  Enable FSMC Bank1_SRAM Bank ------------------------------*/
//  158   
//  159   *(vu32 *)0xA0000010 = 0x00001011;
//  160   *(vu32 *)0xA0000014 = 0x00000200;
//  161   
//  162 
//  163   return (1);
//  164 }
//  165 #endif /*DATA_IN_ExtSRAM*/
//  166 
//  167 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
//  168 
// 
// 304 bytes in section .intvec
// 
// 304 bytes of CONST memory
//
//Errors: none
//Warnings: none
