///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  11:09:37 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\FWLib\src\stm32f10x_spi.c              /
//    Command line =  E:\Mini-DS\DS203\FWLib\src\stm32f10x_spi.c -lA          /
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
//    List file    =  E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\List\stm32f10 /
//                    x_spi.s                                                 /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f10x_spi

        EXTERN RCC_APB1PeriphResetCmd
        EXTERN RCC_APB2PeriphResetCmd

        PUBLIC SPI_BiDirectionalLineConfig
        PUBLIC SPI_CalculateCRC
        PUBLIC SPI_ClearFlag
        PUBLIC SPI_ClearITPendingBit
        PUBLIC SPI_Cmd
        PUBLIC SPI_DMACmd
        PUBLIC SPI_DataSizeConfig
        PUBLIC SPI_DeInit
        PUBLIC SPI_GetCRC
        PUBLIC SPI_GetCRCPolynomial
        PUBLIC SPI_GetFlagStatus
        PUBLIC SPI_GetITStatus
        PUBLIC SPI_ITConfig
        PUBLIC SPI_Init
        PUBLIC SPI_NSSInternalSoftwareConfig
        PUBLIC SPI_ReceiveData
        PUBLIC SPI_SSOutputCmd
        PUBLIC SPI_SendData
        PUBLIC SPI_StructInit
        PUBLIC SPI_TransmitCRC
        
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
        
// E:\Mini-DS\DS203\FWLib\src\stm32f10x_spi.c
//    1 /******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_spi.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V1.0
//    5 * Date               : 10/08/2007
//    6 * Description        : This file provides all the SPI firmware functions.
//    7 ********************************************************************************
//    8 * THE PRESENT SOFTWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//    9 * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
//   10 * AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
//   11 * INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
//   12 * CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
//   13 * INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   14 *******************************************************************************/
//   15 
//   16 /* Includes ------------------------------------------------------------------*/
//   17 #include "stm32f10x_spi.h"
//   18 #include "stm32f10x_rcc.h"
//   19 
//   20 /* Private typedef -----------------------------------------------------------*/
//   21 /* Private define ------------------------------------------------------------*/
//   22 /* SPI SPE mask */
//   23 #define CR1_SPE_Set          ((u16)0x0040)
//   24 #define CR1_SPE_Reset        ((u16)0xFFBF)
//   25 
//   26 /* SPI CRCNext mask */
//   27 #define CR1_CRCNext_Set      ((u16)0x1000)
//   28 
//   29 /* SPI CRCEN mask */
//   30 #define CR1_CRCEN_Set        ((u16)0x2000)
//   31 #define CR1_CRCEN_Reset      ((u16)0xDFFF)
//   32 
//   33 /* SPI SSOE mask */
//   34 #define CR2_SSOE_Set        ((u16)0x0004)
//   35 #define CR2_SSOE_Reset      ((u16)0xFFFB)
//   36 
//   37 /* SPI registers Masks */
//   38 #define CR1_CLEAR_Mask       ((u16)0x3040)
//   39 
//   40 /* Private macro -------------------------------------------------------------*/
//   41 /* Private variables ---------------------------------------------------------*/
//   42 /* Private function prototypes -----------------------------------------------*/
//   43 /* Private functions ---------------------------------------------------------*/
//   44 
//   45 /*******************************************************************************
//   46 * Function Name  : SPI_DeInit
//   47 * Description    : Deinitializes the SPIx peripheral registers to their default
//   48 *                  reset values.
//   49 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//   50 * Output         : None
//   51 * Return         : None
//   52 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function SPI_DeInit
        THUMB
//   53 void SPI_DeInit(SPI_TypeDef* SPIx)
//   54 {
SPI_DeInit:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//   55   switch (*(u32*)&SPIx)
        LDR.N    R1,??SPI_DeInit_0  ;; 0x40003800
        SUBS     R0,R0,R1
        BEQ.N    ??SPI_DeInit_1
        MOV      R1,#+63488
        SUBS     R0,R0,R1
        BNE.N    ??SPI_DeInit_2
//   56   {
//   57     case SPI1_BASE:
//   58       /* Enable SPI1 reset state */
//   59       RCC_APB2PeriphResetCmd(RCC_APB2Periph_SPI1, ENABLE);
        MOVS     R1,#+1
        MOV      R0,#+4096
        BL       RCC_APB2PeriphResetCmd
//   60       /* Release SPI1 from reset state */
//   61       RCC_APB2PeriphResetCmd(RCC_APB2Periph_SPI1, DISABLE);
        MOVS     R1,#+0
        MOV      R0,#+4096
        BL       RCC_APB2PeriphResetCmd
        B.N      ??SPI_DeInit_2
//   62       break;
//   63 
//   64     case SPI2_BASE:
//   65       /* Enable SPI2 reset state */
//   66       RCC_APB1PeriphResetCmd(RCC_APB1Periph_SPI2, ENABLE);
??SPI_DeInit_1:
        MOVS     R1,#+1
        MOV      R0,#+16384
        BL       RCC_APB1PeriphResetCmd
//   67       /* Release SPI2 from reset state */
//   68       RCC_APB1PeriphResetCmd(RCC_APB1Periph_SPI2, DISABLE);
        MOVS     R1,#+0
        MOV      R0,#+16384
        BL       RCC_APB1PeriphResetCmd
//   69       break;
//   70 
//   71     default:
//   72       break;
//   73   }
//   74 }
??SPI_DeInit_2:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        DATA
??SPI_DeInit_0:
        DC32     0x40003800
        CFI EndBlock cfiBlock0
//   75 
//   76 /*******************************************************************************
//   77 * Function Name  : SPI_Init
//   78 * Description    : Initializes the SPIx peripheral according to the specified 
//   79 *                  parameters in the SPI_InitStruct.
//   80 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//   81 *                  - SPI_InitStruct: pointer to a SPI_InitTypeDef structure that
//   82 *                    contains the configuration information for the specified
//   83 *                    SPI peripheral.
//   84 * Output         : None
//   85 * Return         : None
//   86 ******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function SPI_Init
        THUMB
//   87 void SPI_Init(SPI_TypeDef* SPIx, SPI_InitTypeDef* SPI_InitStruct)
//   88 {
//   89   u16 tmpreg = 0;
//   90 
//   91   /* Check the parameters */
//   92   assert_param(IS_SPI_DIRECTION_MODE(SPI_InitStruct->SPI_Direction));
//   93   assert_param(IS_SPI_MODE(SPI_InitStruct->SPI_Mode));
//   94   assert_param(IS_SPI_DATASIZE(SPI_InitStruct->SPI_DataSize));
//   95   assert_param(IS_SPI_CPOL(SPI_InitStruct->SPI_CPOL));
//   96   assert_param(IS_SPI_CPHA(SPI_InitStruct->SPI_CPHA));
//   97   assert_param(IS_SPI_NSS(SPI_InitStruct->SPI_NSS));
//   98   assert_param(IS_SPI_BAUDRATE_PRESCALER(SPI_InitStruct->SPI_BaudRatePrescaler));
//   99   assert_param(IS_SPI_FIRST_BIT(SPI_InitStruct->SPI_FirstBit));
//  100   assert_param(IS_SPI_CRC_POLYNOMIAL(SPI_InitStruct->SPI_CRCPolynomial));
//  101 
//  102 /*---------------------------- SPIx CR1 Configuration ------------------------*/
//  103   /* Get the SPIx CR1 value */
//  104   tmpreg = SPIx->CR1;
SPI_Init:
        LDRH     R2,[R0, #+0]
//  105   /* Clear BIDIMode, BIDIOE, RxONLY, SSM, SSI, LSBFirst, BR, MSTR, CPOL and CPHA bits */
//  106   tmpreg &= CR1_CLEAR_Mask;
//  107   /* Configure SPIx: direction, NSS management, first transmitted bit, BaudRate prescaler
//  108      master/salve mode, CPOL and CPHA */
//  109   /* Set BIDImode, BIDIOE and RxONLY bits according to SPI_Direction value */
//  110   /* Set SSM, SSI and MSTR bits according to SPI_Mode and SPI_NSS values */
//  111   /* Set LSBFirst bit according to SPI_FirstBit value */
//  112   /* Set BR bits according to SPI_BaudRatePrescaler value */
//  113   /* Set CPOL bit according to SPI_CPOL value */
//  114   /* Set CPHA bit according to SPI_CPHA value */
//  115   tmpreg |= (u16)((u32)SPI_InitStruct->SPI_Direction | SPI_InitStruct->SPI_Mode |
//  116                   SPI_InitStruct->SPI_DataSize | SPI_InitStruct->SPI_CPOL |  
//  117                   SPI_InitStruct->SPI_CPHA | SPI_InitStruct->SPI_NSS |  
//  118                   SPI_InitStruct->SPI_BaudRatePrescaler | SPI_InitStruct->SPI_FirstBit);
//  119   /* Write to SPIx CR1 */
//  120   SPIx->CR1 = tmpreg;
        AND      R2,R2,#0x3040
        LDRH     R3,[R1, #+0]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+2]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+4]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+6]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+8]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+10]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+12]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+14]
        ORRS     R2,R3,R2
        STRH     R2,[R0, #+0]
//  121 
//  122 /*---------------------------- SPIx CRCPOLY Configuration --------------------*/
//  123   /* Write to SPIx CRCPOLY */
//  124   SPIx->CRCPR = SPI_InitStruct->SPI_CRCPolynomial;
        LDRH     R1,[R1, #+16]
        STRH     R1,[R0, #+16]
//  125 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//  126 
//  127 /*******************************************************************************
//  128 * Function Name  : SPI_StructInit
//  129 * Description    : Fills each SPI_InitStruct member with its default value.
//  130 * Input          : - SPI_InitStruct : pointer to a SPI_InitTypeDef structure
//  131 *                    which will be initialized.
//  132 * Output         : None
//  133 * Return         : None
//  134 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function SPI_StructInit
        THUMB
//  135 void SPI_StructInit(SPI_InitTypeDef* SPI_InitStruct)
//  136 {
//  137 /*--------------- Reset SPI init structure parameters values -----------------*/
//  138   /* Initialize the SPI_Direction member */
//  139   SPI_InitStruct->SPI_Direction = SPI_Direction_2Lines_FullDuplex;
SPI_StructInit:
        MOVS     R1,#+0
        STRH     R1,[R0, #+0]
//  140 
//  141   /* initialize the SPI_Mode member */
//  142   SPI_InitStruct->SPI_Mode = SPI_Mode_Slave;
        STRH     R1,[R0, #+2]
//  143 
//  144   /* initialize the SPI_DataSize member */
//  145   SPI_InitStruct->SPI_DataSize = SPI_DataSize_8b;
        STRH     R1,[R0, #+4]
//  146 
//  147   /* Initialize the SPI_CPOL member */
//  148   SPI_InitStruct->SPI_CPOL = SPI_CPOL_Low;
        STRH     R1,[R0, #+6]
//  149 
//  150   /* Initialize the SPI_CPHA member */
//  151   SPI_InitStruct->SPI_CPHA = SPI_CPHA_1Edge;
        STRH     R1,[R0, #+8]
//  152 
//  153   /* Initialize the SPI_NSS member */
//  154   SPI_InitStruct->SPI_NSS = SPI_NSS_Hard;
        STRH     R1,[R0, #+10]
//  155 
//  156   /* Initialize the SPI_BaudRatePrescaler member */
//  157   SPI_InitStruct->SPI_BaudRatePrescaler = SPI_BaudRatePrescaler_2;
        STRH     R1,[R0, #+12]
//  158 
//  159   /* Initialize the SPI_FirstBit member */
//  160   SPI_InitStruct->SPI_FirstBit = SPI_FirstBit_MSB;
        STRH     R1,[R0, #+14]
//  161 
//  162   /* Initialize the SPI_CRCPolynomial member */
//  163   SPI_InitStruct->SPI_CRCPolynomial = 7;
        MOVS     R1,#+7
        STRH     R1,[R0, #+16]
//  164 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//  165 
//  166 /*******************************************************************************
//  167 * Function Name  : SPI_Cmd
//  168 * Description    : Enables or disables the specified SPI peripheral.
//  169 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  170 *                  - NewState: new state of the SPIx peripheral. 
//  171 *                    This parameter can be: ENABLE or DISABLE.
//  172 * Output         : None
//  173 * Return         : None
//  174 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function SPI_Cmd
        THUMB
//  175 void SPI_Cmd(SPI_TypeDef* SPIx, FunctionalState NewState)
//  176 {
//  177   /* Check the parameters */
//  178   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  179 
//  180   if (NewState != DISABLE)
SPI_Cmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+0]
        BEQ.N    ??SPI_Cmd_0
//  181   {
//  182     /* Enable the selected SPI peripheral */
//  183     SPIx->CR1 |= CR1_SPE_Set;
        ORR      R1,R1,#0x40
        B.N      ??SPI_Cmd_1
//  184   }
//  185   else
//  186   {
//  187     /* Disable the selected SPI peripheral */
//  188     SPIx->CR1 &= CR1_SPE_Reset;
??SPI_Cmd_0:
        MOVW     R2,#+65471
        ANDS     R1,R2,R1
??SPI_Cmd_1:
        STRH     R1,[R0, #+0]
//  189   }
//  190 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//  191 
//  192 /*******************************************************************************
//  193 * Function Name  : SPI_ITConfig
//  194 * Description    : Enables or disables the specified SPI interrupts.
//  195 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  196 *                  - SPI_IT: specifies the SPI interrupt source to be enabled
//  197 *                    or disabled. 
//  198 *                    This parameter can be one of the following values:
//  199 *                       - SPI_IT_TXE: Tx buffer empty interrupt mask
//  200 *                       - SPI_IT_RXNE: Rx buffer not empty interrupt mask
//  201 *                       - SPI_IT_ERR: Error interrupt mask
//  202 *                  - NewState: new state of the specified SPI interrupt.
//  203 *                    This parameter can be: ENABLE or DISABLE.
//  204 * Output         : None
//  205 * Return         : None
//  206 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function SPI_ITConfig
        THUMB
//  207 void SPI_ITConfig(SPI_TypeDef* SPIx, u8 SPI_IT, FunctionalState NewState)
//  208 {
//  209   u16 itpos = 0, itmask = 0 ;
//  210 
//  211   /* Check the parameters */
//  212   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  213   assert_param(IS_SPI_CONFIG_IT(SPI_IT));
//  214 
//  215   /* Get the SPI IT index */
//  216   itpos = SPI_IT >> 4;
//  217   /* Set the IT mask */
//  218   itmask = (u16)((u16)1 << itpos);
SPI_ITConfig:
        MOVS     R3,#+1
        LSRS     R1,R1,#+4
        LSL      R1,R3,R1
        UXTH     R1,R1
//  219 
//  220   if (NewState != DISABLE)
        CMP      R2,#+0
        LDRH     R2,[R0, #+4]
        BEQ.N    ??SPI_ITConfig_0
//  221   {
//  222     /* Enable the selected SPI interrupt */
//  223     SPIx->CR2 |= itmask;
        ORRS     R1,R1,R2
        B.N      ??SPI_ITConfig_1
//  224   }
//  225   else
//  226   {
//  227     /* Disable the selected SPI interrupt */
//  228     SPIx->CR2 &= (u16)~itmask;
??SPI_ITConfig_0:
        MVNS     R1,R1
        ANDS     R1,R1,R2
??SPI_ITConfig_1:
        STRH     R1,[R0, #+4]
//  229   }
//  230 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  231 
//  232 /*******************************************************************************
//  233 * Function Name  : SPI_DMACmd
//  234 * Description    : Enables or disables the SPIx’s DMA interface.
//  235 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  236 *                  - SPI_DMAReq: specifies the SPI DMA transfer request to be
//  237 *                    enabled or disabled. 
//  238 *                    This parameter can be any combination of the following values:
//  239 *                       - SPI_DMAReq_Tx: Tx buffer DMA transfer request
//  240 *                       - SPI_DMAReq_Rx: Rx buffer DMA transfer request
//  241 *                  - NewState: new state of the selected SPI DMA transfer request.
//  242 *                    This parameter can be: ENABLE or DISABLE.
//  243 * Output         : None
//  244 * Return         : None
//  245 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function SPI_DMACmd
        THUMB
//  246 void SPI_DMACmd(SPI_TypeDef* SPIx, u16 SPI_DMAReq, FunctionalState NewState)
//  247 {
//  248   /* Check the parameters */
//  249   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  250   assert_param(IS_SPI_DMA_REQ(SPI_DMAReq));
//  251 
//  252   if (NewState != DISABLE)
SPI_DMACmd:
        CMP      R2,#+0
        LDRH     R2,[R0, #+4]
        BEQ.N    ??SPI_DMACmd_0
//  253   {
//  254     /* Enable the selected SPI DMA requests */
//  255     SPIx->CR2 |= SPI_DMAReq;
        ORRS     R1,R1,R2
        B.N      ??SPI_DMACmd_1
//  256   }
//  257   else
//  258   {
//  259     /* Disable the selected SPI DMA requests */
//  260     SPIx->CR2 &= (u16)~SPI_DMAReq;
??SPI_DMACmd_0:
        MVNS     R1,R1
        ANDS     R1,R1,R2
??SPI_DMACmd_1:
        STRH     R1,[R0, #+4]
//  261   }
//  262 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  263 
//  264 /*******************************************************************************
//  265 * Function Name  : SPI_SendData
//  266 * Description    : Transmits a Data through the SPIx peripheral.
//  267 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  268 *                  - Data : Data to be transmitted..
//  269 * Output         : None
//  270 * Return         : None
//  271 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function SPI_SendData
        THUMB
//  272 void SPI_SendData(SPI_TypeDef* SPIx, u16 Data)
//  273 {
//  274   /* Write in the DR register the data to be sent */
//  275   SPIx->DR = Data;
SPI_SendData:
        STRH     R1,[R0, #+12]
//  276 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  277 
//  278 /*******************************************************************************
//  279 * Function Name  : SPI_ReceiveData
//  280 * Description    : Returns the most recent received data by the SPIx peripheral.
//  281 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  282 * Output         : None
//  283 * Return         : The value of the received data.
//  284 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function SPI_ReceiveData
        THUMB
//  285 u16 SPI_ReceiveData(SPI_TypeDef* SPIx)
//  286 {
//  287   /* Return the data in the DR register */
//  288   return SPIx->DR;
SPI_ReceiveData:
        LDRH     R0,[R0, #+12]
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  289 }
//  290 
//  291 /*******************************************************************************
//  292 * Function Name  : SPI_NSSInternalSoftwareConfig
//  293 * Description    : Configures internally by software the NSS pin for the selected 
//  294 *                  SPI.
//  295 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  296 *                  - SPI_NSSInternalSoft: specifies the SPI NSS internal state.
//  297 *                    This parameter can be one of the following values:
//  298 *                       - SPI_NSSInternalSoft_Set: Set NSS pin internally
//  299 *                       - SPI_NSSInternalSoft_Reset: Reset NSS pin internally
//  300 * Output         : None
//  301 * Return         : None
//  302 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function SPI_NSSInternalSoftwareConfig
        THUMB
//  303 void SPI_NSSInternalSoftwareConfig(SPI_TypeDef* SPIx, u16 SPI_NSSInternalSoft)
//  304 {
//  305   /* Check the parameters */
//  306   assert_param(IS_SPI_NSS_INTERNAL(SPI_NSSInternalSoft));
//  307 
//  308   if (SPI_NSSInternalSoft != SPI_NSSInternalSoft_Reset)
SPI_NSSInternalSoftwareConfig:
        MOVW     R2,#+65279
        CMP      R1,R2
        LDRH     R1,[R0, #+0]
        BEQ.N    ??SPI_NSSInternalSoftwareConfig_0
//  309   {
//  310     /* Set NSS pin internally by software */
//  311     SPIx->CR1 |= SPI_NSSInternalSoft_Set;
        ORR      R1,R1,#0x100
        B.N      ??SPI_NSSInternalSoftwareConfig_1
//  312   }
//  313   else
//  314   {
//  315     /* Reset NSS pin internally by software */
//  316     SPIx->CR1 &= SPI_NSSInternalSoft_Reset;
??SPI_NSSInternalSoftwareConfig_0:
        ANDS     R1,R2,R1
??SPI_NSSInternalSoftwareConfig_1:
        STRH     R1,[R0, #+0]
//  317   }
//  318 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  319 
//  320 /*******************************************************************************
//  321 * Function Name  : SPI_SSOutputCmd
//  322 * Description    : Enables or disables the SS output for the selected SPI.
//  323 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  324 *                  - NewState: new state of the SPIx SS output. 
//  325 *                    This parameter can be: ENABLE or DISABLE.
//  326 * Output         : None
//  327 * Return         : None
//  328 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function SPI_SSOutputCmd
        THUMB
//  329 void SPI_SSOutputCmd(SPI_TypeDef* SPIx, FunctionalState NewState)
//  330 {
//  331   /* Check the parameters */
//  332   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  333 
//  334   if (NewState != DISABLE)
SPI_SSOutputCmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+4]
        BEQ.N    ??SPI_SSOutputCmd_0
//  335   {
//  336     /* Enable the selected SPI SS output */
//  337     SPIx->CR2 |= CR2_SSOE_Set;
        ORR      R1,R1,#0x4
        B.N      ??SPI_SSOutputCmd_1
//  338   }
//  339   else
//  340   {
//  341     /* Disable the selected SPI SS output */
//  342     SPIx->CR2 &= CR2_SSOE_Reset;
??SPI_SSOutputCmd_0:
        MOVW     R2,#+65531
        ANDS     R1,R2,R1
??SPI_SSOutputCmd_1:
        STRH     R1,[R0, #+4]
//  343   }
//  344 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//  345 
//  346 /*******************************************************************************
//  347 * Function Name  : SPI_DataSizeConfig
//  348 * Description    : Configures the data size for the selected SPI.
//  349 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  350 *                  - SPI_DataSize: specifies the SPI data size.
//  351 *                    This parameter can be one of the following values:
//  352 *                       - SPI_DataSize_16b: Set data frame format to 16bit
//  353 *                       - SPI_DataSize_8b: Set data frame format to 8bit
//  354 * Output         : None
//  355 * Return         : None
//  356 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function SPI_DataSizeConfig
        THUMB
//  357 void SPI_DataSizeConfig(SPI_TypeDef* SPIx, u16 SPI_DataSize)
//  358 {
//  359   /* Check the parameters */
//  360   assert_param(IS_SPI_DATASIZE(SPI_DataSize));
//  361 
//  362   /* Clear DFF bit */
//  363   SPIx->CR1 &= (u16)~SPI_DataSize_16b;
SPI_DataSizeConfig:
        LDRH     R2,[R0, #+0]
        MOVW     R3,#+63487
        ANDS     R2,R3,R2
        STRH     R2,[R0, #+0]
//  364   /* Set new DFF bit value */
//  365   SPIx->CR1 |= SPI_DataSize;
        LDRH     R2,[R0, #+0]
        ORRS     R1,R1,R2
        STRH     R1,[R0, #+0]
//  366 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  367 
//  368 /*******************************************************************************
//  369 * Function Name  : SPI_TransmitCRC
//  370 * Description    : Transmit the SPIx CRC value.
//  371 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  372 * Output         : None
//  373 * Return         : None
//  374 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function SPI_TransmitCRC
        THUMB
//  375 void SPI_TransmitCRC(SPI_TypeDef* SPIx)
//  376 {
//  377   /* Enable the selected SPI CRC transmission */
//  378   SPIx->CR1 |= CR1_CRCNext_Set;
SPI_TransmitCRC:
        LDRH     R1,[R0, #+0]
        ORR      R1,R1,#0x1000
        STRH     R1,[R0, #+0]
//  379 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//  380 
//  381 /*******************************************************************************
//  382 * Function Name  : SPI_CalculateCRC
//  383 * Description    : Enables or disables the CRC value calculation of the
//  384 *                  transfered bytes.
//  385 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  386 *                  - NewState: new state of the SPIx CRC value calculation.
//  387 *                    This parameter can be: ENABLE or DISABLE.
//  388 * Output         : None
//  389 * Return         : None
//  390 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function SPI_CalculateCRC
        THUMB
//  391 void SPI_CalculateCRC(SPI_TypeDef* SPIx, FunctionalState NewState)
//  392 {
//  393   /* Check the parameters */
//  394   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  395 
//  396   if (NewState != DISABLE)
SPI_CalculateCRC:
        CMP      R1,#+0
        LDRH     R1,[R0, #+0]
        BEQ.N    ??SPI_CalculateCRC_0
//  397   {
//  398     /* Enable the selected SPI CRC calculation */
//  399     SPIx->CR1 |= CR1_CRCEN_Set;
        ORR      R1,R1,#0x2000
        B.N      ??SPI_CalculateCRC_1
//  400   }
//  401   else
//  402   {
//  403     /* Disable the selected SPI CRC calculation */
//  404     SPIx->CR1 &= CR1_CRCEN_Reset;
??SPI_CalculateCRC_0:
        MOVW     R2,#+57343
        ANDS     R1,R2,R1
??SPI_CalculateCRC_1:
        STRH     R1,[R0, #+0]
//  405   }
//  406 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock12
//  407 
//  408 /*******************************************************************************
//  409 * Function Name  : SPI_GetCRC
//  410 * Description    : Returns the transmit or the receive CRC register value for
//  411 *                  the specified SPI.
//  412 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  413 *                  - SPI_CRC: specifies the CRC register to be read.
//  414 *                    This parameter can be one of the following values:
//  415 *                       - SPI_CRC_Tx: Selects Tx CRC register
//  416 *                       - SPI_CRC_Rx: Selects Rx CRC register
//  417 * Output         : None
//  418 * Return         : The selected CRC register value..
//  419 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function SPI_GetCRC
        THUMB
//  420 u16 SPI_GetCRC(SPI_TypeDef* SPIx, u8 SPI_CRC)
//  421 {
//  422   u16 crcreg = 0;
//  423 
//  424   /* Check the parameters */
//  425   assert_param(IS_SPI_CRC(SPI_CRC));
//  426 
//  427   if (SPI_CRC != SPI_CRC_Rx)
SPI_GetCRC:
        CMP      R1,#+1
        ITE      EQ 
        LDRHEQ   R0,[R0, #+20]
//  428   {
//  429     /* Get the Tx CRC register */
//  430     crcreg = SPIx->TXCRCR;
        LDRHNE   R0,[R0, #+24]
//  431   }
//  432   else
//  433   {
//  434     /* Get the Rx CRC register */
//  435     crcreg = SPIx->RXCRCR;
//  436   }
//  437 
//  438   /* Return the selected CRC register */
//  439   return crcreg;
        BX       LR               ;; return
        CFI EndBlock cfiBlock13
//  440 }
//  441 
//  442 /*******************************************************************************
//  443 * Function Name  : SPI_GetCRCPolynomial
//  444 * Description    : Returns the CRC Polynomial register value for the specified SPI.
//  445 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  446 * Output         : None
//  447 * Return         : The CRC Polynomial register value.
//  448 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function SPI_GetCRCPolynomial
        THUMB
//  449 u16 SPI_GetCRCPolynomial(SPI_TypeDef* SPIx)
//  450 {
//  451   /* Return the CRC polynomial register */
//  452   return SPIx->CRCPR;
SPI_GetCRCPolynomial:
        LDRH     R0,[R0, #+16]
        BX       LR               ;; return
        CFI EndBlock cfiBlock14
//  453 }
//  454 
//  455 /*******************************************************************************
//  456 * Function Name  : SPI_BiDirectionalLineConfig
//  457 * Description    : Selects the data transfer direction in bi-directional mode
//  458 *                  for the specified SPI.
//  459 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  460 *                  - SPI_Direction: specifies the data transfer direction in
//  461 *                    bi-directional mode. 
//  462 *                    This parameter can be one of the following values:
//  463 *                       - SPI_Direction_Tx: Selects Tx transmission direction
//  464 *                       - SPI_Direction_Rx: Selects Rx receive direction
//  465 * Output         : None
//  466 * Return         : None
//  467 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function SPI_BiDirectionalLineConfig
        THUMB
//  468 void SPI_BiDirectionalLineConfig(SPI_TypeDef* SPIx, u16 SPI_Direction)
//  469 {
//  470   /* Check the parameters */
//  471   assert_param(IS_SPI_DIRECTION(SPI_Direction));
//  472 
//  473   if (SPI_Direction == SPI_Direction_Tx)
SPI_BiDirectionalLineConfig:
        MOV      R2,#+16384
        CMP      R1,R2
        LDRH     R1,[R0, #+0]
        BNE.N    ??SPI_BiDirectionalLineConfig_0
//  474   {
//  475     /* Set the Tx only mode */
//  476     SPIx->CR1 |= SPI_Direction_Tx;
        ORR      R1,R1,#0x4000
        B.N      ??SPI_BiDirectionalLineConfig_1
//  477   }
//  478   else
//  479   {
//  480     /* Set the Rx only mode */
//  481     SPIx->CR1 &= SPI_Direction_Rx;
??SPI_BiDirectionalLineConfig_0:
        MOVW     R2,#+49151
        ANDS     R1,R2,R1
??SPI_BiDirectionalLineConfig_1:
        STRH     R1,[R0, #+0]
//  482   }
//  483 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock15
//  484 
//  485 /*******************************************************************************
//  486 * Function Name  : SPI_GetFlagStatus
//  487 * Description    : Checks whether the specified SPI flag is set or not.
//  488 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  489 *                  - SPI_FLAG: specifies the flag to check. 
//  490 *                    This parameter can be one of the following values:
//  491 *                       - SPI_FLAG_BSY: Busy flag.
//  492 *                       - SPI_FLAG_OVR: Overrun flag.
//  493 *                       - SPI_FLAG_MODF: Mode Fault flag.
//  494 *                       - SPI_FLAG_CRCERR: CRC Error flag.
//  495 *                       - SPI_FLAG_TXE: Transmit buffer empty flag.
//  496 *                       - SPI_FLAG_RXNE: Receive buffer not empty flag.
//  497 * Output         : None
//  498 * Return         : The new state of SPI_FLAG (SET or RESET).
//  499 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function SPI_GetFlagStatus
        THUMB
//  500 FlagStatus SPI_GetFlagStatus(SPI_TypeDef* SPIx, u16 SPI_FLAG)
//  501 {
//  502   FlagStatus bitstatus = RESET;
//  503 
//  504   /* Check the parameters */
//  505   assert_param(IS_SPI_GET_FLAG(SPI_FLAG));
//  506 
//  507   /* Check the status of the specified SPI flag */
//  508   if ((SPIx->SR & SPI_FLAG) != (u16)RESET)
SPI_GetFlagStatus:
        LDRH     R0,[R0, #+8]
        ANDS     R1,R1,R0
        SUBS     R0,R1,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  509   {
//  510     /* SPI_FLAG is set */
//  511     bitstatus = SET;
//  512   }
//  513   else
//  514   {
//  515     /* SPI_FLAG is reset */
//  516     bitstatus = RESET;
//  517   }
//  518   /* Return the SPI_FLAG status */
//  519   return  bitstatus;
        BX       LR               ;; return
        CFI EndBlock cfiBlock16
//  520 }
//  521 
//  522 /*******************************************************************************
//  523 * Function Name  : SPI_ClearFlag
//  524 * Description    : Clears the SPIx's pending flags.
//  525 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  526 *                  - SPI_FLAG: specifies the flag to clear. 
//  527 *                    This parameter can be any combination of the following values:
//  528 *                       - SPI_FLAG_OVR: Overrun flag.
//  529 *                       - SPI_FLAG_MODF: Mode Fault flag.
//  530 *                       - SPI_FLAG_CRCERR: CRC Error flag.
//  531 * Output         : None
//  532 * Return         : None
//  533 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function SPI_ClearFlag
        THUMB
//  534 void SPI_ClearFlag(SPI_TypeDef* SPIx, u16 SPI_FLAG)
//  535 {
//  536   /* Check the parameters */
//  537   assert_param(IS_SPI_CLEAR_FLAG(SPI_FLAG));
//  538     
//  539   /* SPI_FLAG_MODF flag clear */
//  540   if(SPI_FLAG == SPI_FLAG_MODF)
SPI_ClearFlag:
        CMP      R1,#+32
        BNE.N    ??SPI_ClearFlag_0
//  541   {
//  542     /* Read SR register */
//  543     (void)SPIx->SR;
        LDRH     R1,[R0, #+8]
//  544     /* Write on CR1 register */
//  545     SPIx->CR1 |= CR1_SPE_Set; 
        LDRH     R1,[R0, #+0]
        ORR      R1,R1,#0x40
        STRH     R1,[R0, #+0]
        BX       LR
//  546   }
//  547   /* SPI_FLAG_OVR flag clear */
//  548   else if(SPI_FLAG == SPI_FLAG_OVR)  
??SPI_ClearFlag_0:
        CMP      R1,#+64
        BNE.N    ??SPI_ClearFlag_1
//  549   {
//  550     /* Read SR register */
//  551     (void)SPIx->SR;
        LDRH     R0,[R0, #+8]
        BX       LR
//  552   }
//  553   else /* SPI_FLAG_CRCERR flag clear */
//  554   {
//  555     /* Clear the selected SPI flag */
//  556     SPIx->SR &= (u16)~SPI_FLAG;
??SPI_ClearFlag_1:
        LDRH     R2,[R0, #+8]
        MVNS     R1,R1
        ANDS     R1,R1,R2
        STRH     R1,[R0, #+8]
//  557   }
//  558 }
??SPI_ClearFlag_2:
        BX       LR               ;; return
        CFI EndBlock cfiBlock17
//  559 
//  560 /*******************************************************************************
//  561 * Function Name  : SPI_GetITStatus
//  562 * Description    : Checks whether the specified SPI interrupt has occurred or not.
//  563 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  564 *                  - SPI_IT: specifies the SPI interrupt source to check. 
//  565 *                    This parameter can be one of the following values:
//  566 *                       - SPI_IT_OVR: Overrun interrupt.
//  567 *                       - SPI_IT_MODF: Mode Fault interrupt.
//  568 *                       - SPI_IT_CRCERR: CRC Error interrupt.
//  569 *                       - SPI_IT_TXE: Transmit buffer empty interrupt.
//  570 *                       - SPI_IT_RXNE: Receive buffer not empty interrupt.
//  571 * Output         : None
//  572 * Return         : The new state of SPI_IT (SET or RESET).
//  573 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function SPI_GetITStatus
        THUMB
//  574 ITStatus SPI_GetITStatus(SPI_TypeDef* SPIx, u8 SPI_IT)
//  575 {
//  576   ITStatus bitstatus = RESET;
//  577   u16 itpos = 0, itmask = 0, enablestatus = 0;
//  578 
//  579   /* Check the parameters */
//  580   assert_param(IS_SPI_GET_IT(SPI_IT));
//  581 
//  582   /* Get the SPI IT index */
//  583   itpos = (u16)((u16)0x01 << (SPI_IT & (u8)0x0F));
//  584 
//  585   /* Get the SPI IT index */
//  586   itmask = SPI_IT >> 4;
//  587   /* Set the IT mask */
//  588   itmask = (u16)((u16)0x01 << itmask);
//  589   /* Get the SPI_IT enable bit status */
//  590   enablestatus = (SPIx->CR2 & itmask) ;
SPI_GetITStatus:
        LDRH     R2,[R0, #+4]
        MOVS     R3,#+1
        LSR      R12,R1,#+4
        LSL      R3,R3,R12
        ANDS     R2,R3,R2
//  591 
//  592   /* Check the status of the specified SPI interrupt */
//  593   if (((SPIx->SR & itpos) != (u16)RESET) && enablestatus)
        LDRH     R0,[R0, #+8]
        MOVS     R3,#+1
        AND      R1,R1,#0xF
        LSL      R1,R3,R1
        TST      R0,R1
        BEQ.N    ??SPI_GetITStatus_0
        SUBS     R0,R2,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
        BX       LR
//  594   {
//  595     /* SPI_IT is set */
//  596     bitstatus = SET;
//  597   }
//  598   else
//  599   {
//  600     /* SPI_IT is reset */
//  601     bitstatus = RESET;
??SPI_GetITStatus_0:
        MOVS     R0,#+0
//  602   }
//  603   /* Return the SPI_IT status */
//  604   return bitstatus;
??SPI_GetITStatus_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock18
//  605 }
//  606 
//  607 /*******************************************************************************
//  608 * Function Name  : SPI_ClearITPendingBit
//  609 * Description    : Clears the SPIx’s interrupt pending bits.
//  610 * Input          : - SPIx: where x can be 1 or 2 to select the SPI peripheral.
//  611 *                  - SPI_IT: specifies the SPI interrupt pending bit to clear.
//  612 *                    This parameter can be one of the following values:
//  613 *                       - SPI_IT_OVR: Overrun interrupt.
//  614 *                       - SPI_IT_MODF: Mode Fault interrupt.
//  615 *                       - SPI_IT_CRCERR: CRC Error interrupt.
//  616 * Output         : None
//  617 * Return         : None
//  618 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI Function SPI_ClearITPendingBit
        THUMB
//  619 void SPI_ClearITPendingBit(SPI_TypeDef* SPIx, u8 SPI_IT)
//  620 {
//  621   u16 itpos = 0;
//  622 
//  623   /* Check the parameters */
//  624   assert_param(IS_SPI_CLEAR_IT(SPI_IT));
//  625 
//  626   /* SPI_IT_MODF pending bit clear */
//  627   if(SPI_IT == SPI_IT_MODF)
SPI_ClearITPendingBit:
        CMP      R1,#+85
        BNE.N    ??SPI_ClearITPendingBit_0
//  628   {
//  629     /* Read SR register */
//  630     (void)SPIx->SR;
        LDRH     R1,[R0, #+8]
//  631     /* Write on CR1 register */
//  632     SPIx->CR1 |= CR1_SPE_Set; 
        LDRH     R1,[R0, #+0]
        ORR      R1,R1,#0x40
        STRH     R1,[R0, #+0]
        BX       LR
//  633   }
//  634   else if(SPI_IT == SPI_IT_OVR)   /* SPI_IT_OVR pending bit clear */ 
??SPI_ClearITPendingBit_0:
        CMP      R1,#+86
        BNE.N    ??SPI_ClearITPendingBit_1
//  635   {
//  636     /* Read SR register */
//  637     (void)(SPIx->SR);
        LDRH     R0,[R0, #+8]
        BX       LR
//  638   }
//  639   else   /* SPI_IT_CRCERR pending bit clear */
//  640   {
//  641     /* Get the SPI IT index */
//  642     itpos = (u16)((u16)0x01 << (SPI_IT & (u8)0x0F));
//  643     /* Clear the selected SPI interrupt pending bits */
//  644     SPIx->SR &= (u16)~itpos;
??SPI_ClearITPendingBit_1:
        LDRH     R2,[R0, #+8]
        MOVS     R3,#+1
        AND      R1,R1,#0xF
        LSL      R1,R3,R1
        MVNS     R1,R1
        ANDS     R1,R1,R2
        STRH     R1,[R0, #+8]
//  645   }
//  646 }
??SPI_ClearITPendingBit_2:
        BX       LR               ;; return
        CFI EndBlock cfiBlock19

        END
//  647 
//  648 /******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
// 
// 484 bytes in section .text
// 
// 484 bytes of CODE memory
//
//Errors: none
//Warnings: none
