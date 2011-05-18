///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  14:17:36 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\FWLib\src\stm32f10x_gpio.c                    /
//    Command line =  E:\DS0203\FWLib\src\stm32f10x_gpio.c -lA                /
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
//    List file    =  E:\DS0203\SYS_V1.34\IAR_V5_Prpject\List\stm32f10x_gpio. /
//                    s                                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f10x_gpio

        EXTERN RCC_APB2PeriphResetCmd

        PUBLIC GPIO_AFIODeInit
        PUBLIC GPIO_DeInit
        PUBLIC GPIO_EXTILineConfig
        PUBLIC GPIO_EventOutputCmd
        PUBLIC GPIO_EventOutputConfig
        PUBLIC GPIO_Init
        PUBLIC GPIO_PinLockConfig
        PUBLIC GPIO_PinRemapConfig
        PUBLIC GPIO_ReadInputData
        PUBLIC GPIO_ReadInputDataBit
        PUBLIC GPIO_ReadOutputData
        PUBLIC GPIO_ReadOutputDataBit
        PUBLIC GPIO_ResetBits
        PUBLIC GPIO_SetBits
        PUBLIC GPIO_StructInit
        PUBLIC GPIO_Write
        PUBLIC GPIO_WriteBit
        
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
        
// E:\DS0203\FWLib\src\stm32f10x_gpio.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_gpio.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.0.3
//    5 * Date               : 09/22/2008
//    6 * Description        : This file provides all the GPIO firmware functions.
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
//   17 #include "stm32f10x_gpio.h"
//   18 #include "stm32f10x_rcc.h"
//   19 
//   20 /* Private typedef -----------------------------------------------------------*/
//   21 /* Private define ------------------------------------------------------------*/
//   22 /* ------------ RCC registers bit address in the alias region ----------- */
//   23 #define AFIO_OFFSET                 (AFIO_BASE - PERIPH_BASE)
//   24 
//   25 /* --- EVENTCR Register ---*/
//   26 /* Alias word address of EVOE bit */
//   27 #define EVCR_OFFSET                 (AFIO_OFFSET + 0x00)
//   28 #define EVOE_BitNumber              ((u8)0x07)
//   29 #define EVCR_EVOE_BB                (PERIPH_BB_BASE + (EVCR_OFFSET * 32) + (EVOE_BitNumber * 4))
//   30 
//   31 #define EVCR_PORTPINCONFIG_MASK     ((u16)0xFF80)
//   32 #define LSB_MASK                    ((u16)0xFFFF)
//   33 #define DBGAFR_POSITION_MASK        ((u32)0x000F0000)
//   34 #define DBGAFR_SWJCFG_MASK          ((u32)0xF0FFFFFF)
//   35 #define DBGAFR_LOCATION_MASK        ((u32)0x00200000)
//   36 #define DBGAFR_NUMBITS_MASK         ((u32)0x00100000)
//   37 
//   38 /* Private macro -------------------------------------------------------------*/
//   39 /* Private variables ---------------------------------------------------------*/
//   40 /* Private function prototypes -----------------------------------------------*/
//   41 /* Private functions ---------------------------------------------------------*/
//   42 
//   43 /*******************************************************************************
//   44 * Function Name  : GPIO_DeInit
//   45 * Description    : Deinitializes the GPIOx peripheral registers to their default
//   46 *                  reset values.
//   47 * Input          : - GPIOx: where x can be (A..G) to select the GPIO peripheral.
//   48 * Output         : None
//   49 * Return         : None
//   50 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function GPIO_DeInit
        THUMB
//   51 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
//   52 {
GPIO_DeInit:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//   53   /* Check the parameters */
//   54   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//   55   
//   56   switch (*(u32*)&GPIOx)
        LDR.N    R1,??GPIO_DeInit_0  ;; 0x40010800
        SUBS     R0,R0,R1
        BEQ.N    ??GPIO_DeInit_1
        MOV      R1,#+1024
        SUBS     R0,R0,R1
        BEQ.N    ??GPIO_DeInit_2
        SUBS     R0,R0,R1
        BEQ.N    ??GPIO_DeInit_3
        SUBS     R0,R0,R1
        BEQ.N    ??GPIO_DeInit_4
        SUBS     R0,R0,R1
        BEQ.N    ??GPIO_DeInit_5
        SUBS     R0,R0,R1
        BEQ.N    ??GPIO_DeInit_6
        SUBS     R0,R0,R1
        BEQ.N    ??GPIO_DeInit_7
        B.N      ??GPIO_DeInit_8
//   57   {
//   58     case GPIOA_BASE:
//   59       RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOA, ENABLE);
??GPIO_DeInit_1:
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       RCC_APB2PeriphResetCmd
//   60       RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOA, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+4
        B.N      ??GPIO_DeInit_9
//   61       break;
//   62 
//   63     case GPIOB_BASE:
//   64       RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOB, ENABLE);
??GPIO_DeInit_2:
        MOVS     R1,#+1
        MOVS     R0,#+8
        BL       RCC_APB2PeriphResetCmd
//   65       RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOB, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+8
        B.N      ??GPIO_DeInit_9
//   66       break;
//   67 
//   68     case GPIOC_BASE:
//   69       RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOC, ENABLE);
??GPIO_DeInit_3:
        MOVS     R1,#+1
        MOVS     R0,#+16
        BL       RCC_APB2PeriphResetCmd
//   70       RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOC, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+16
        B.N      ??GPIO_DeInit_9
//   71       break;
//   72 
//   73     case GPIOD_BASE:
//   74       RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOD, ENABLE);
??GPIO_DeInit_4:
        MOVS     R1,#+1
        MOVS     R0,#+32
        BL       RCC_APB2PeriphResetCmd
//   75       RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOD, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+32
        B.N      ??GPIO_DeInit_9
//   76       break;
//   77       
//   78     case GPIOE_BASE:
//   79       RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOE, ENABLE);
??GPIO_DeInit_5:
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       RCC_APB2PeriphResetCmd
//   80       RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOE, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+64
        B.N      ??GPIO_DeInit_9
//   81       break; 
//   82 
//   83     case GPIOF_BASE:
//   84       RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOF, ENABLE);
??GPIO_DeInit_6:
        MOVS     R1,#+1
        MOVS     R0,#+128
        BL       RCC_APB2PeriphResetCmd
//   85       RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOF, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+128
        B.N      ??GPIO_DeInit_9
//   86       break;
//   87 
//   88     case GPIOG_BASE:
//   89       RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOG, ENABLE);
??GPIO_DeInit_7:
        MOVS     R1,#+1
        MOV      R0,#+256
        BL       RCC_APB2PeriphResetCmd
//   90       RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOG, DISABLE);
        MOVS     R1,#+0
        MOV      R0,#+256
??GPIO_DeInit_9:
        BL       RCC_APB2PeriphResetCmd
//   91       break;                       
//   92 
//   93     default:
//   94       break;
//   95   }
//   96 }
??GPIO_DeInit_8:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        DATA
??GPIO_DeInit_0:
        DC32     0x40010800
        CFI EndBlock cfiBlock0
//   97 
//   98 /*******************************************************************************
//   99 * Function Name  : GPIO_AFIODeInit
//  100 * Description    : Deinitializes the Alternate Functions (remap, event control
//  101 *                  and EXTI configuration) registers to their default reset
//  102 *                  values.
//  103 * Input          : None
//  104 * Output         : None
//  105 * Return         : None
//  106 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function GPIO_AFIODeInit
        THUMB
//  107 void GPIO_AFIODeInit(void)
//  108 {
GPIO_AFIODeInit:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  109   RCC_APB2PeriphResetCmd(RCC_APB2Periph_AFIO, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+1
        BL       RCC_APB2PeriphResetCmd
//  110   RCC_APB2PeriphResetCmd(RCC_APB2Periph_AFIO, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+1
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {LR}
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      RCC_APB2PeriphResetCmd
        CFI EndBlock cfiBlock1
//  111 }
//  112 
//  113 /*******************************************************************************
//  114 * Function Name  : GPIO_Init
//  115 * Description    : Initializes the GPIOx peripheral according to the specified
//  116 *                  parameters in the GPIO_InitStruct.
//  117 * Input          : - GPIOx: where x can be (A..G) to select the GPIO peripheral.
//  118 *                  - GPIO_InitStruct: pointer to a GPIO_InitTypeDef structure that
//  119 *                    contains the configuration information for the specified GPIO
//  120 *                    peripheral.
//  121 * Output         : None
//  122 * Return         : None
//  123 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function GPIO_Init
        THUMB
//  124 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_InitTypeDef* GPIO_InitStruct)
//  125 {
GPIO_Init:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
//  126   u32 currentmode = 0x00, currentpin = 0x00, pinpos = 0x00, pos = 0x00;
//  127   u32 tmpreg = 0x00, pinmask = 0x00;
//  128 
//  129   /* Check the parameters */
//  130   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  131   assert_param(IS_GPIO_MODE(GPIO_InitStruct->GPIO_Mode));
//  132   assert_param(IS_GPIO_PIN(GPIO_InitStruct->GPIO_Pin));  
//  133   
//  134 /*---------------------------- GPIO Mode Configuration -----------------------*/
//  135   currentmode = ((u32)GPIO_InitStruct->GPIO_Mode) & ((u32)0x0F);
        LDRB     R3,[R1, #+3]
        AND      R2,R3,#0xF
//  136 
//  137   if ((((u32)GPIO_InitStruct->GPIO_Mode) & ((u32)0x10)) != 0x00)
        TST      R3,#0x10
        ITT      NE 
//  138   { 
//  139     /* Check the parameters */
//  140     assert_param(IS_GPIO_SPEED(GPIO_InitStruct->GPIO_Speed));
//  141     /* Output mode */
//  142     currentmode |= (u32)GPIO_InitStruct->GPIO_Speed;
        LDRBNE   R3,[R1, #+2]
        ORRNE    R2,R3,R2
//  143   }
//  144 
//  145 /*---------------------------- GPIO CRL Configuration ------------------------*/
//  146   /* Configure the eight low port pins */
//  147   if (((u32)GPIO_InitStruct->GPIO_Pin & ((u32)0x00FF)) != 0x00)
        LDRH     R3,[R1, #+0]
        UXTB     R12,R3
        CMP      R12,#+0
        BEQ.N    ??GPIO_Init_0
//  148   {
//  149     tmpreg = GPIOx->CRL;
        LDR      LR,[R0, #+0]
//  150 
//  151     for (pinpos = 0x00; pinpos < 0x08; pinpos++)
        MOV      R12,#+0
//  152     {
//  153       pos = ((u32)0x01) << pinpos;
??GPIO_Init_1:
        MOVS     R5,#+1
        LSL      R5,R5,R12
//  154       /* Get the port pins position */
//  155       currentpin = (GPIO_InitStruct->GPIO_Pin) & pos;
//  156 
//  157       if (currentpin == pos)
        AND      R6,R5,R3
        CMP      R6,R5
        BNE.N    ??GPIO_Init_2
//  158       {
//  159         pos = pinpos << 2;
        LSL      R4,R12,#+2
//  160         /* Clear the corresponding low control register bits */
//  161         pinmask = ((u32)0x0F) << pos;
//  162         tmpreg &= ~pinmask;
//  163 
//  164         /* Write the mode configuration in the corresponding bits */
//  165         tmpreg |= (currentmode << pos);
        MOVS     R6,#+15
        LSLS     R6,R6,R4
        MVNS     R6,R6
        AND      LR,R6,LR
        LSL      R4,R2,R4
        ORR      LR,R4,LR
//  166 
//  167         /* Reset the corresponding ODR bit */
//  168         if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPD)
        LDRB     R4,[R1, #+3]
        CMP      R4,#+40
        BNE.N    ??GPIO_Init_3
//  169         {
//  170           GPIOx->BRR = (((u32)0x01) << pinpos);
        STR      R5,[R0, #+20]
        B.N      ??GPIO_Init_2
//  171         }
//  172         else
//  173         {
//  174           /* Set the corresponding ODR bit */
//  175           if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPU)
??GPIO_Init_3:
        CMP      R4,#+72
        IT       EQ 
//  176           {
//  177             GPIOx->BSRR = (((u32)0x01) << pinpos);
        STREQ    R5,[R0, #+16]
//  178           }
//  179         }
//  180       }
//  181     }
??GPIO_Init_2:
        ADD      R12,R12,#+1
        CMP      R12,#+8
        BCC.N    ??GPIO_Init_1
//  182     GPIOx->CRL = tmpreg;
        STR      LR,[R0, #+0]
//  183   }
//  184 
//  185 /*---------------------------- GPIO CRH Configuration ------------------------*/
//  186   /* Configure the eight high port pins */
//  187   if (GPIO_InitStruct->GPIO_Pin > 0x00FF)
??GPIO_Init_0:
        MOV      R12,#+256
        CMP      R3,R12
        BCC.N    ??GPIO_Init_4
//  188   {
//  189     tmpreg = GPIOx->CRH;
        LDR      LR,[R0, #+4]
//  190     for (pinpos = 0x00; pinpos < 0x08; pinpos++)
        MOV      R12,#+0
//  191     {
//  192       pos = (((u32)0x01) << (pinpos + 0x08));
??GPIO_Init_5:
        MOVS     R4,#+1
        MOV      R5,R12
        ADDS     R5,R5,#+8
        LSL      R5,R4,R5
//  193       /* Get the port pins position */
//  194       currentpin = ((GPIO_InitStruct->GPIO_Pin) & pos);
//  195       if (currentpin == pos)
        AND      R6,R5,R3
        CMP      R6,R5
        BNE.N    ??GPIO_Init_6
//  196       {
//  197         pos = pinpos << 2;
        LSL      R4,R12,#+2
//  198         /* Clear the corresponding high control register bits */
//  199         pinmask = ((u32)0x0F) << pos;
//  200         tmpreg &= ~pinmask;
//  201 
//  202         /* Write the mode configuration in the corresponding bits */
//  203         tmpreg |= (currentmode << pos);
        MOVS     R6,#+15
        LSLS     R6,R6,R4
        MVNS     R6,R6
        AND      LR,R6,LR
        LSL      R4,R2,R4
        ORR      LR,R4,LR
//  204 
//  205         /* Reset the corresponding ODR bit */
//  206         if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPD)
        LDRB     R4,[R1, #+3]
        CMP      R4,#+40
        IT       EQ 
//  207         {
//  208           GPIOx->BRR = (((u32)0x01) << (pinpos + 0x08));
        STREQ    R5,[R0, #+20]
//  209         }
//  210         /* Set the corresponding ODR bit */
//  211         if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPU)
        LDRB     R4,[R1, #+3]
        CMP      R4,#+72
        IT       EQ 
//  212         {
//  213           GPIOx->BSRR = (((u32)0x01) << (pinpos + 0x08));
        STREQ    R5,[R0, #+16]
//  214         }
//  215       }
//  216     }
??GPIO_Init_6:
        ADD      R12,R12,#+1
        CMP      R12,#+8
        BCC.N    ??GPIO_Init_5
//  217     GPIOx->CRH = tmpreg;
        STR      LR,[R0, #+4]
//  218   }
//  219 }
??GPIO_Init_4:
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock2
//  220 
//  221 /*******************************************************************************
//  222 * Function Name  : GPIO_StructInit
//  223 * Description    : Fills each GPIO_InitStruct member with its default value.
//  224 * Input          : - GPIO_InitStruct : pointer to a GPIO_InitTypeDef structure
//  225 *                    which will be initialized.
//  226 * Output         : None
//  227 * Return         : None
//  228 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function GPIO_StructInit
        THUMB
//  229 void GPIO_StructInit(GPIO_InitTypeDef* GPIO_InitStruct)
//  230 {
//  231   /* Reset GPIO init structure parameters values */
//  232   GPIO_InitStruct->GPIO_Pin  = GPIO_Pin_All;
GPIO_StructInit:
        MOVW     R1,#+65535
        STRH     R1,[R0, #+0]
//  233   GPIO_InitStruct->GPIO_Speed = GPIO_Speed_2MHz;
        MOVS     R1,#+2
        STRB     R1,[R0, #+2]
//  234   GPIO_InitStruct->GPIO_Mode = GPIO_Mode_IN_FLOATING;
        MOVS     R1,#+4
        STRB     R1,[R0, #+3]
//  235 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//  236 
//  237 /*******************************************************************************
//  238 * Function Name  : GPIO_ReadInputDataBit
//  239 * Description    : Reads the specified input port pin.
//  240 * Input          : - GPIOx: where x can be (A..G) to select the GPIO peripheral.
//  241 *                : - GPIO_Pin:  specifies the port bit to read.
//  242 *                    This parameter can be GPIO_Pin_x where x can be (0..15).
//  243 * Output         : None
//  244 * Return         : The input port pin value.
//  245 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function GPIO_ReadInputDataBit
        THUMB
//  246 u8 GPIO_ReadInputDataBit(GPIO_TypeDef* GPIOx, u16 GPIO_Pin)
//  247 {
//  248   u8 bitstatus = 0x00;
//  249   
//  250   /* Check the parameters */
//  251   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  252   assert_param(IS_GET_GPIO_PIN(GPIO_Pin)); 
//  253   
//  254   if ((GPIOx->IDR & GPIO_Pin) != (u32)Bit_RESET)
GPIO_ReadInputDataBit:
        LDR      R0,[R0, #+8]
        ANDS     R1,R1,R0
        SUBS     R0,R1,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  255   {
//  256     bitstatus = (u8)Bit_SET;
//  257   }
//  258   else
//  259   {
//  260     bitstatus = (u8)Bit_RESET;
//  261   }
//  262   return bitstatus;
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  263 }
//  264 
//  265 /*******************************************************************************
//  266 * Function Name  : GPIO_ReadInputData
//  267 * Description    : Reads the specified GPIO input data port.
//  268 * Input          : - GPIOx: where x can be (A..G) to select the GPIO peripheral.
//  269 * Output         : None
//  270 * Return         : GPIO input data port value.
//  271 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function GPIO_ReadInputData
        THUMB
//  272 u16 GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
//  273 {
//  274   /* Check the parameters */
//  275   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  276   
//  277   return ((u16)GPIOx->IDR);
GPIO_ReadInputData:
        LDR      R0,[R0, #+8]
        UXTH     R0,R0
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  278 }
//  279 
//  280 /*******************************************************************************
//  281 * Function Name  : GPIO_ReadOutputDataBit
//  282 * Description    : Reads the specified output data port bit.
//  283 * Input          : - GPIOx: where x can be (A..G) to select the GPIO peripheral.
//  284 *                : - GPIO_Pin:  specifies the port bit to read.
//  285 *                    This parameter can be GPIO_Pin_x where x can be (0..15).
//  286 * Output         : None
//  287 * Return         : The output port pin value.
//  288 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function GPIO_ReadOutputDataBit
        THUMB
//  289 u8 GPIO_ReadOutputDataBit(GPIO_TypeDef* GPIOx, u16 GPIO_Pin)
//  290 {
//  291   u8 bitstatus = 0x00;
//  292 
//  293   /* Check the parameters */
//  294   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  295   assert_param(IS_GET_GPIO_PIN(GPIO_Pin)); 
//  296   
//  297   if ((GPIOx->ODR & GPIO_Pin) != (u32)Bit_RESET)
GPIO_ReadOutputDataBit:
        LDR      R0,[R0, #+12]
        ANDS     R1,R1,R0
        SUBS     R0,R1,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  298   {
//  299     bitstatus = (u8)Bit_SET;
//  300   }
//  301   else
//  302   {
//  303     bitstatus = (u8)Bit_RESET;
//  304   }
//  305   return bitstatus;
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  306 }
//  307 
//  308 /*******************************************************************************
//  309 * Function Name  : GPIO_ReadOutputData
//  310 * Description    : Reads the specified GPIO output data port.
//  311 * Input          : - GPIOx: where x can be (A..G) to select the GPIO peripheral.
//  312 * Output         : None
//  313 * Return         : GPIO output data port value.
//  314 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function GPIO_ReadOutputData
        THUMB
//  315 u16 GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
//  316 {
//  317   /* Check the parameters */
//  318   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  319     
//  320   return ((u16)GPIOx->ODR);
GPIO_ReadOutputData:
        LDR      R0,[R0, #+12]
        UXTH     R0,R0
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  321 }
//  322 
//  323 /*******************************************************************************
//  324 * Function Name  : GPIO_SetBits
//  325 * Description    : Sets the selected data port bits.
//  326 * Input          : - GPIOx: where x can be (A..G) to select the GPIO peripheral.
//  327 *                  - GPIO_Pin: specifies the port bits to be written.
//  328 *                    This parameter can be any combination of GPIO_Pin_x where 
//  329 *                    x can be (0..15).
//  330 * Output         : None
//  331 * Return         : None
//  332 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function GPIO_SetBits
        THUMB
//  333 void GPIO_SetBits(GPIO_TypeDef* GPIOx, u16 GPIO_Pin)
//  334 {
//  335   /* Check the parameters */
//  336   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  337   assert_param(IS_GPIO_PIN(GPIO_Pin));
//  338   
//  339   GPIOx->BSRR = GPIO_Pin;
GPIO_SetBits:
        STR      R1,[R0, #+16]
//  340 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  341 
//  342 /*******************************************************************************
//  343 * Function Name  : GPIO_ResetBits
//  344 * Description    : Clears the selected data port bits.
//  345 * Input          : - GPIOx: where x can be (A..G) to select the GPIO peripheral.
//  346 *                  - GPIO_Pin: specifies the port bits to be written.
//  347 *                    This parameter can be any combination of GPIO_Pin_x where 
//  348 *                    x can be (0..15).
//  349 * Output         : None
//  350 * Return         : None
//  351 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function GPIO_ResetBits
        THUMB
//  352 void GPIO_ResetBits(GPIO_TypeDef* GPIOx, u16 GPIO_Pin)
//  353 {
//  354   /* Check the parameters */
//  355   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  356   assert_param(IS_GPIO_PIN(GPIO_Pin));
//  357   
//  358   GPIOx->BRR = GPIO_Pin;
GPIO_ResetBits:
        STR      R1,[R0, #+20]
//  359 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//  360 
//  361 /*******************************************************************************
//  362 * Function Name  : GPIO_WriteBit
//  363 * Description    : Sets or clears the selected data port bit.
//  364 * Input          : - GPIOx: where x can be (A..G) to select the GPIO peripheral.
//  365 *                  - GPIO_Pin: specifies the port bit to be written.
//  366 *                    This parameter can be one of GPIO_Pin_x where x can be (0..15).
//  367 *                  - BitVal: specifies the value to be written to the selected bit.
//  368 *                    This parameter can be one of the BitAction enum values:
//  369 *                       - Bit_RESET: to clear the port pin
//  370 *                       - Bit_SET: to set the port pin
//  371 * Output         : None
//  372 * Return         : None
//  373 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function GPIO_WriteBit
        THUMB
//  374 void GPIO_WriteBit(GPIO_TypeDef* GPIOx, u16 GPIO_Pin, BitAction BitVal)
//  375 {
//  376   /* Check the parameters */
//  377   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  378   assert_param(IS_GET_GPIO_PIN(GPIO_Pin));
//  379   assert_param(IS_GPIO_BIT_ACTION(BitVal)); 
//  380   
//  381   if (BitVal != Bit_RESET)
GPIO_WriteBit:
        CMP      R2,#+0
        ITE      EQ 
        STREQ    R1,[R0, #+20]
//  382   {
//  383     GPIOx->BSRR = GPIO_Pin;
        STRNE    R1,[R0, #+16]
//  384   }
//  385   else
//  386   {
//  387     GPIOx->BRR = GPIO_Pin;
//  388   }
//  389 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  390 
//  391 /*******************************************************************************
//  392 * Function Name  : GPIO_Write
//  393 * Description    : Writes data to the specified GPIO data port.
//  394 * Input          : - GPIOx: where x can be (A..G) to select the GPIO peripheral.
//  395 *                  - PortVal: specifies the value to be written to the port output
//  396 *                    data register.
//  397 * Output         : None
//  398 * Return         : None
//  399 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function GPIO_Write
        THUMB
//  400 void GPIO_Write(GPIO_TypeDef* GPIOx, u16 PortVal)
//  401 {
//  402   /* Check the parameters */
//  403   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  404   
//  405   GPIOx->ODR = PortVal;
GPIO_Write:
        STR      R1,[R0, #+12]
//  406 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//  407 
//  408 /*******************************************************************************
//  409 * Function Name  : GPIO_PinLockConfig
//  410 * Description    : Locks GPIO Pins configuration registers.
//  411 * Input          : - GPIOx: where x can be (A..G) to select the GPIO peripheral.
//  412 *                  - GPIO_Pin: specifies the port bit to be written.
//  413 *                    This parameter can be any combination of GPIO_Pin_x where 
//  414 *                    x can be (0..15).
//  415 * Output         : None
//  416 * Return         : None
//  417 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function GPIO_PinLockConfig
        THUMB
//  418 void GPIO_PinLockConfig(GPIO_TypeDef* GPIOx, u16 GPIO_Pin)
//  419 {
//  420   u32 tmp = 0x00010000;
//  421   
//  422   /* Check the parameters */
//  423   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  424   assert_param(IS_GPIO_PIN(GPIO_Pin));
//  425   
//  426   tmp |= GPIO_Pin;
GPIO_PinLockConfig:
        ORR      R2,R1,#0x10000
//  427   /* Set LCKK bit */
//  428   GPIOx->LCKR = tmp;
        STR      R2,[R0, #+24]
//  429   /* Reset LCKK bit */
//  430   GPIOx->LCKR =  GPIO_Pin;
        STR      R1,[R0, #+24]
//  431   /* Set LCKK bit */
//  432   GPIOx->LCKR = tmp;
        STR      R2,[R0, #+24]
//  433   /* Read LCKK bit*/
//  434   tmp = GPIOx->LCKR;
        LDR      R1,[R0, #+24]
//  435   /* Read LCKK bit*/
//  436   tmp = GPIOx->LCKR;
        LDR      R0,[R0, #+24]
//  437 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock12
//  438 
//  439 /*******************************************************************************
//  440 * Function Name  : GPIO_EventOutputConfig
//  441 * Description    : Selects the GPIO pin used as Event output.
//  442 * Input          : - GPIO_PortSource: selects the GPIO port to be used as source
//  443 *                    for Event output.
//  444 *                    This parameter can be GPIO_PortSourceGPIOx where x can be
//  445 *                    (A..E).
//  446 *                  - GPIO_PinSource: specifies the pin for the Event output.
//  447 *                    This parameter can be GPIO_PinSourcex where x can be (0..15).
//  448 * Output         : None
//  449 * Return         : None
//  450 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function GPIO_EventOutputConfig
        THUMB
//  451 void GPIO_EventOutputConfig(u8 GPIO_PortSource, u8 GPIO_PinSource)
//  452 {
//  453   u32 tmpreg = 0x00;
//  454 
//  455   /* Check the parameters */
//  456   assert_param(IS_GPIO_EVENTOUT_PORT_SOURCE(GPIO_PortSource));
//  457   assert_param(IS_GPIO_PIN_SOURCE(GPIO_PinSource));
//  458     
//  459   tmpreg = AFIO->EVCR;
GPIO_EventOutputConfig:
        LDR.N    R2,??GPIO_EventOutputConfig_0  ;; 0x40010000
        LDR      R3,[R2, #+0]
//  460   /* Clear the PORT[6:4] and PIN[3:0] bits */
//  461   tmpreg &= EVCR_PORTPINCONFIG_MASK;
//  462   tmpreg |= (u32)GPIO_PortSource << 0x04;
//  463   tmpreg |= GPIO_PinSource;
//  464 
//  465   AFIO->EVCR = tmpreg;
        MOVW     R12,#+65408
        AND      R3,R12,R3
        ORR      R0,R3,R0, LSL #+4
        ORRS     R0,R1,R0
        STR      R0,[R2, #+0]
//  466 }
        BX       LR               ;; return
        Nop      
        DATA
??GPIO_EventOutputConfig_0:
        DC32     0x40010000
        CFI EndBlock cfiBlock13
//  467 
//  468 /*******************************************************************************
//  469 * Function Name  : GPIO_EventOutputCmd
//  470 * Description    : Enables or disables the Event Output.
//  471 * Input          : - NewState: new state of the Event output.
//  472 *                    This parameter can be: ENABLE or DISABLE.
//  473 * Output         : None
//  474 * Return         : None
//  475 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function GPIO_EventOutputCmd
        THUMB
//  476 void GPIO_EventOutputCmd(FunctionalState NewState)
//  477 {
//  478   /* Check the parameters */
//  479   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  480   
//  481   *(vu32 *) EVCR_EVOE_BB = (u32)NewState;
GPIO_EventOutputCmd:
        LDR.N    R1,??GPIO_EventOutputCmd_0  ;; 0x4220001c
        STR      R0,[R1, #+0]
//  482 }
        BX       LR               ;; return
        Nop      
        DATA
??GPIO_EventOutputCmd_0:
        DC32     0x4220001c
        CFI EndBlock cfiBlock14
//  483 
//  484 /*******************************************************************************
//  485 * Function Name  : GPIO_PinRemapConfig
//  486 * Description    : Changes the mapping of the specified pin.
//  487 * Input          : - GPIO_Remap: selects the pin to remap.
//  488 *                    This parameter can be one of the following values:
//  489 *                       - GPIO_Remap_SPI1
//  490 *                       - GPIO_Remap_I2C1
//  491 *                       - GPIO_Remap_USART1
//  492 *                       - GPIO_Remap_USART2
//  493 *                       - GPIO_PartialRemap_USART3
//  494 *                       - GPIO_FullRemap_USART3
//  495 *                       - GPIO_PartialRemap_TIM1
//  496 *                       - GPIO_FullRemap_TIM1
//  497 *                       - GPIO_PartialRemap1_TIM2
//  498 *                       - GPIO_PartialRemap2_TIM2
//  499 *                       - GPIO_FullRemap_TIM2
//  500 *                       - GPIO_PartialRemap_TIM3
//  501 *                       - GPIO_FullRemap_TIM3
//  502 *                       - GPIO_Remap_TIM4
//  503 *                       - GPIO_Remap1_CAN
//  504 *                       - GPIO_Remap2_CAN
//  505 *                       - GPIO_Remap_PD01
//  506 *                       - GPIO_Remap_TIM5CH4_LSI
//  507 *                       - GPIO_Remap_ADC1_ETRGINJ
//  508 *                       - GPIO_Remap_ADC1_ETRGREG
//  509 *                       - GPIO_Remap_ADC2_ETRGINJ
//  510 *                       - GPIO_Remap_ADC2_ETRGREG
//  511 *                       - GPIO_Remap_SWJ_NoJTRST
//  512 *                       - GPIO_Remap_SWJ_JTAGDisable
//  513 *                       - GPIO_Remap_SWJ_Disable
//  514 *                  - NewState: new state of the port pin remapping.
//  515 *                    This parameter can be: ENABLE or DISABLE.
//  516 * Output         : None
//  517 * Return         : None
//  518 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function GPIO_PinRemapConfig
        THUMB
//  519 void GPIO_PinRemapConfig(u32 GPIO_Remap, FunctionalState NewState)
//  520 {
GPIO_PinRemapConfig:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  521   u32 tmp = 0x00, tmp1 = 0x00, tmpreg = 0x00, tmpmask = 0x00;
//  522 
//  523   /* Check the parameters */
//  524   assert_param(IS_GPIO_REMAP(GPIO_Remap));
//  525   assert_param(IS_FUNCTIONAL_STATE(NewState));  
//  526   
//  527   tmpreg = AFIO->MAPR;
        LDR.N    R2,??GPIO_PinRemapConfig_0  ;; 0x40010004
        LDR      R12,[R2, #+0]
//  528 
//  529   tmpmask = (GPIO_Remap & DBGAFR_POSITION_MASK) >> 0x10;
        AND      R3,R0,#0xF0000
        LSR      LR,R3,#+16
//  530   tmp = GPIO_Remap & LSB_MASK;
        UXTH     R3,R0
//  531 
//  532   if ((GPIO_Remap & (DBGAFR_LOCATION_MASK | DBGAFR_NUMBITS_MASK)) == (DBGAFR_LOCATION_MASK | DBGAFR_NUMBITS_MASK))
        AND      R4,R0,#0x300000
        CMP      R4,#+3145728
        BNE.N    ??GPIO_PinRemapConfig_1
//  533   {
//  534     tmpreg &= DBGAFR_SWJCFG_MASK;
        MVN      LR,#+251658240
        AND      R12,LR,R12
//  535     AFIO->MAPR &= DBGAFR_SWJCFG_MASK;
        LDR      R4,[R2, #+0]
        AND      LR,LR,R4
        STR      LR,[R2, #+0]
        B.N      ??GPIO_PinRemapConfig_2
//  536   }
//  537   else if ((GPIO_Remap & DBGAFR_NUMBITS_MASK) == DBGAFR_NUMBITS_MASK)
??GPIO_PinRemapConfig_1:
        TST      R0,#0x100000
        BEQ.N    ??GPIO_PinRemapConfig_3
//  538   {
//  539     tmp1 = ((u32)0x03) << tmpmask;
//  540     tmpreg &= ~tmp1;
//  541     tmpreg |= ~DBGAFR_SWJCFG_MASK;
        MOVS     R4,#+3
        LSL      LR,R4,LR
        MVN      LR,LR
        AND      R12,LR,R12
        ORR      R12,R12,#0xF000000
        B.N      ??GPIO_PinRemapConfig_2
//  542   }
//  543   else
//  544   {
//  545     tmpreg &= ~(tmp << ((GPIO_Remap >> 0x15)*0x10));
//  546     tmpreg |= ~DBGAFR_SWJCFG_MASK;
??GPIO_PinRemapConfig_3:
        LSR      LR,R0,#+21
        LSL      LR,LR,#+24
        LSR      LR,LR,#+20
        LSL      LR,R3,LR
        MVN      LR,LR
        AND      R12,LR,R12
        ORR      R12,R12,#0xF000000
//  547   }
//  548 
//  549   if (NewState != DISABLE)
??GPIO_PinRemapConfig_2:
        CBZ      R1,??GPIO_PinRemapConfig_4
//  550   {
//  551     tmpreg |= (tmp << ((GPIO_Remap >> 0x15)*0x10));
        LSLS     R0,R0,#+3
        LSRS     R0,R0,#+24
        LSLS     R0,R0,#+4
        LSL      R0,R3,R0
        ORR      R12,R0,R12
//  552   }
//  553 
//  554   AFIO->MAPR = tmpreg;
??GPIO_PinRemapConfig_4:
        STR      R12,[R2, #+0]
//  555 }
        POP      {R4,PC}          ;; return
        DATA
??GPIO_PinRemapConfig_0:
        DC32     0x40010004
        CFI EndBlock cfiBlock15
//  556 
//  557 /*******************************************************************************
//  558 * Function Name  : GPIO_EXTILineConfig
//  559 * Description    : Selects the GPIO pin used as EXTI Line.
//  560 * Input          : - GPIO_PortSource: selects the GPIO port to be used as
//  561 *                    source for EXTI lines.
//  562 *                    This parameter can be GPIO_PortSourceGPIOx where x can be
//  563 *                    (A..G).
//  564 *                  - GPIO_PinSource: specifies the EXTI line to be configured.
//  565 *                   This parameter can be GPIO_PinSourcex where x can be (0..15).
//  566 * Output         : None
//  567 * Return         : None
//  568 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function GPIO_EXTILineConfig
        THUMB
//  569 void GPIO_EXTILineConfig(u8 GPIO_PortSource, u8 GPIO_PinSource)
//  570 {
//  571   u32 tmp = 0x00;
//  572 
//  573   /* Check the parameters */
//  574   assert_param(IS_GPIO_EXTI_PORT_SOURCE(GPIO_PortSource));
//  575   assert_param(IS_GPIO_PIN_SOURCE(GPIO_PinSource));
//  576   
//  577   tmp = ((u32)0x0F) << (0x04 * (GPIO_PinSource & (u8)0x03));
//  578 
//  579   AFIO->EXTICR[GPIO_PinSource >> 0x02] &= ~tmp;
GPIO_EXTILineConfig:
        AND      R2,R1,#0x3
        LSLS     R2,R2,#+2
        ASRS     R1,R1,#+2
        LDR.N    R3,??GPIO_EXTILineConfig_0  ;; 0x40010008
        LDR      R3,[R3, R1, LSL #+2]
        MOV      R12,#+15
        LSL      R12,R12,R2
        MVN      R12,R12
        AND      R3,R12,R3
        LDR.W    R12,??GPIO_EXTILineConfig_0  ;; 0x40010008
        STR      R3,[R12, R1, LSL #+2]
//  580   AFIO->EXTICR[GPIO_PinSource >> 0x02] |= (((u32)GPIO_PortSource) << (0x04 * (GPIO_PinSource & (u8)0x03)));
        LDR      R3,[R12, R1, LSL #+2]
        LSLS     R0,R0,R2
        ORRS     R0,R0,R3
        STR      R0,[R12, R1, LSL #+2]
//  581 }
        BX       LR               ;; return
        DATA
??GPIO_EXTILineConfig_0:
        DC32     0x40010008
        CFI EndBlock cfiBlock16

        END
//  582 
//  583 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
// 688 bytes in section .text
// 
// 688 bytes of CODE memory
//
//Errors: none
//Warnings: none
