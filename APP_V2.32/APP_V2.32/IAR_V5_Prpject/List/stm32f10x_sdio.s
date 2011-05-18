///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  13:39:17 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\FWLib\src\stm32f10x_sdio.c                    /
//    Command line =  E:\DS0203\FWLib\src\stm32f10x_sdio.c -lA                /
//                    E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\ -o             /
//                    E:\DS0203\APP_V2.32\IAR_V5_Prpject\Obj\ --debug         /
//                    --endian=little --cpu=Cortex-M3 --fpu=None              /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.0 Evaluation\ARM\INC\DLib_Config_Full.h"    /
//                    -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\..\FWLib\inc\  /
//                    -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\..\USBLib\inc\ /
//                     -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\include\ -I   /
//                    "C:\Program Files\IAR Systems\Embedded Workbench 5.0    /
//                    Evaluation\ARM\INC\" -Ohs                               /
//    List file    =  E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\stm32f10x_sdio. /
//                    s                                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f10x_sdio

        PUBLIC SDIO_CEATAITCmd
        PUBLIC SDIO_ClearFlag
        PUBLIC SDIO_ClearITPendingBit
        PUBLIC SDIO_ClockCmd
        PUBLIC SDIO_CmdStructInit
        PUBLIC SDIO_CommandCompletionCmd
        PUBLIC SDIO_DMACmd
        PUBLIC SDIO_DataConfig
        PUBLIC SDIO_DataStructInit
        PUBLIC SDIO_DeInit
        PUBLIC SDIO_GetCommandResponse
        PUBLIC SDIO_GetDataCounter
        PUBLIC SDIO_GetFIFOCount
        PUBLIC SDIO_GetFlagStatus
        PUBLIC SDIO_GetITStatus
        PUBLIC SDIO_GetPowerState
        PUBLIC SDIO_GetResponse
        PUBLIC SDIO_ITConfig
        PUBLIC SDIO_Init
        PUBLIC SDIO_ReadData
        PUBLIC SDIO_SendCEATACmd
        PUBLIC SDIO_SendCommand
        PUBLIC SDIO_SendSDIOSuspendCmd
        PUBLIC SDIO_SetPowerState
        PUBLIC SDIO_SetSDIOOperation
        PUBLIC SDIO_SetSDIOReadWaitMode
        PUBLIC SDIO_StartSDIOReadWait
        PUBLIC SDIO_StopSDIOReadWait
        PUBLIC SDIO_StructInit
        PUBLIC SDIO_WriteData
        
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
        
// E:\DS0203\FWLib\src\stm32f10x_sdio.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_sdio.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.0.3
//    5 * Date               : 09/22/2008
//    6 * Description        : This file provides all the SDIO firmware functions.
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
//   17 #include "stm32f10x_sdio.h"
//   18 #include "stm32f10x_rcc.h"
//   19 
//   20 /* Private typedef -----------------------------------------------------------*/
//   21 /* ------------ SDIO registers bit address in the alias region ----------- */
//   22 #define SDIO_OFFSET                (SDIO_BASE - PERIPH_BASE)
//   23 
//   24 /* --- CLKCR Register ---*/
//   25 /* Alias word address of CLKEN bit */
//   26 #define CLKCR_OFFSET              (SDIO_OFFSET + 0x04)
//   27 #define CLKEN_BitNumber           0x08
//   28 #define CLKCR_CLKEN_BB            (PERIPH_BB_BASE + (CLKCR_OFFSET * 32) + (CLKEN_BitNumber * 4))
//   29 
//   30 /* --- CMD Register ---*/
//   31 /* Alias word address of SDIOSUSPEND bit */
//   32 #define CMD_OFFSET                (SDIO_OFFSET + 0x0C)
//   33 #define SDIOSUSPEND_BitNumber     0x0B
//   34 #define CMD_SDIOSUSPEND_BB        (PERIPH_BB_BASE + (CMD_OFFSET * 32) + (SDIOSUSPEND_BitNumber * 4))
//   35 
//   36 /* Alias word address of ENCMDCOMPL bit */
//   37 #define ENCMDCOMPL_BitNumber      0x0C
//   38 #define CMD_ENCMDCOMPL_BB         (PERIPH_BB_BASE + (CMD_OFFSET * 32) + (ENCMDCOMPL_BitNumber * 4))
//   39 
//   40 /* Alias word address of NIEN bit */
//   41 #define NIEN_BitNumber            0x0D
//   42 #define CMD_NIEN_BB               (PERIPH_BB_BASE + (CMD_OFFSET * 32) + (NIEN_BitNumber * 4))
//   43 
//   44 /* Alias word address of ATACMD bit */
//   45 #define ATACMD_BitNumber          0x0E
//   46 #define CMD_ATACMD_BB             (PERIPH_BB_BASE + (CMD_OFFSET * 32) + (ATACMD_BitNumber * 4))
//   47 
//   48 /* --- DCTRL Register ---*/
//   49 /* Alias word address of DMAEN bit */
//   50 #define DCTRL_OFFSET              (SDIO_OFFSET + 0x2C)
//   51 #define DMAEN_BitNumber           0x03
//   52 #define DCTRL_DMAEN_BB            (PERIPH_BB_BASE + (DCTRL_OFFSET * 32) + (DMAEN_BitNumber * 4))
//   53 
//   54 /* Alias word address of RWSTART bit */
//   55 #define RWSTART_BitNumber         0x08
//   56 #define DCTRL_RWSTART_BB          (PERIPH_BB_BASE + (DCTRL_OFFSET * 32) + (RWSTART_BitNumber * 4))
//   57 
//   58 /* Alias word address of RWSTOP bit */
//   59 #define RWSTOP_BitNumber          0x09
//   60 #define DCTRL_RWSTOP_BB           (PERIPH_BB_BASE + (DCTRL_OFFSET * 32) + (RWSTOP_BitNumber * 4))
//   61 
//   62 /* Alias word address of RWMOD bit */
//   63 #define RWMOD_BitNumber           0x0A
//   64 #define DCTRL_RWMOD_BB            (PERIPH_BB_BASE + (DCTRL_OFFSET * 32) + (RWMOD_BitNumber * 4))
//   65 
//   66 /* Alias word address of SDIOEN bit */
//   67 #define SDIOEN_BitNumber          0x0B
//   68 #define DCTRL_SDIOEN_BB           (PERIPH_BB_BASE + (DCTRL_OFFSET * 32) + (SDIOEN_BitNumber * 4))
//   69 
//   70 
//   71 /* ---------------------- SDIO registers bit mask ------------------------ */
//   72 /* --- CLKCR Register ---*/
//   73 /* CLKCR register clear mask */
//   74 #define CLKCR_CLEAR_MASK         ((u32)0xFFFF8100) 
//   75 
//   76 /* --- PWRCTRL Register ---*/
//   77 /* SDIO PWRCTRL Mask */
//   78 #define PWR_PWRCTRL_MASK         ((u32)0xFFFFFFFC)
//   79 
//   80 /* --- DCTRL Register ---*/
//   81 /* SDIO DCTRL Clear Mask */
//   82 #define DCTRL_CLEAR_MASK         ((u32)0xFFFFFF08)
//   83 
//   84 /* --- CMD Register ---*/
//   85 /* CMD Register clear mask */
//   86 #define CMD_CLEAR_MASK           ((u32)0xFFFFF800)
//   87 
//   88 /* SDIO RESP Registers Address */
//   89 #define SDIO_RESP_ADDR           ((u32)(SDIO_BASE + 0x14))
//   90 
//   91 /* Private define ------------------------------------------------------------*/
//   92 /* Private macro -------------------------------------------------------------*/
//   93 /* Private variables ---------------------------------------------------------*/
//   94 /* Private function prototypes -----------------------------------------------*/
//   95 /* Private functions ---------------------------------------------------------*/
//   96 
//   97 /*******************************************************************************
//   98 * Function Name  : SDIO_DeInit
//   99 * Description    : Deinitializes the SDIO peripheral registers to their default
//  100 *                  reset values.
//  101 * Input          : None
//  102 * Output         : None
//  103 * Return         : None
//  104 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function SDIO_DeInit
        THUMB
//  105 void SDIO_DeInit(void)
//  106 {
//  107   SDIO->POWER = 0x00000000;
SDIO_DeInit:
        LDR.N    R0,??DataTable2  ;; 0x40018000
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  108   SDIO->CLKCR = 0x00000000;
        STR      R1,[R0, #+4]
//  109   SDIO->ARG = 0x00000000;
        STR      R1,[R0, #+8]
//  110   SDIO->CMD = 0x00000000;
        STR      R1,[R0, #+12]
//  111   SDIO->DTIMER = 0x00000000;
        STR      R1,[R0, #+36]
//  112   SDIO->DLEN = 0x00000000;
        STR      R1,[R0, #+40]
//  113   SDIO->DCTRL = 0x00000000;
        STR      R1,[R0, #+44]
//  114   SDIO->ICR = 0x00C007FF;
        LDR.N    R1,??SDIO_DeInit_0  ;; 0xc007ff
        STR      R1,[R0, #+56]
//  115   SDIO->MASK = 0x00000000;
        MOVS     R1,#+0
        STR      R1,[R0, #+60]
//  116 }
        BX       LR               ;; return
        DATA
??SDIO_DeInit_0:
        DC32     0xc007ff
        CFI EndBlock cfiBlock0
//  117 
//  118 /*******************************************************************************
//  119 * Function Name  : SDIO_Init
//  120 * Description    : Initializes the SDIO peripheral according to the specified 
//  121 *                  parameters in the SDIO_InitStruct.
//  122 * Input          : SDIO_InitStruct : pointer to a SDIO_InitTypeDef structure 
//  123 *                  that contains the configuration information for the SDIO 
//  124 *                  peripheral.
//  125 * Output         : None
//  126 * Return         : None
//  127 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function SDIO_Init
        THUMB
//  128 void SDIO_Init(SDIO_InitTypeDef* SDIO_InitStruct)
//  129 {
//  130   u32 tmpreg = 0;
//  131     
//  132   /* Check the parameters */
//  133   assert_param(IS_SDIO_CLOCK_EDGE(SDIO_InitStruct->SDIO_ClockEdge));
//  134   assert_param(IS_SDIO_CLOCK_BYPASS(SDIO_InitStruct->SDIO_ClockBypass));
//  135   assert_param(IS_SDIO_CLOCK_POWER_SAVE(SDIO_InitStruct->SDIO_ClockPowerSave));
//  136   assert_param(IS_SDIO_BUS_WIDE(SDIO_InitStruct->SDIO_BusWide));
//  137   assert_param(IS_SDIO_HARDWARE_FLOW_CONTROL(SDIO_InitStruct->SDIO_HardwareFlowControl)); 
//  138    
//  139 /*---------------------------- SDIO CLKCR Configuration ------------------------*/  
//  140   /* Get the SDIO CLKCR value */
//  141   tmpreg = SDIO->CLKCR;
SDIO_Init:
        LDR.N    R1,??SDIO_Init_0  ;; 0x40018004
        LDR      R2,[R1, #+0]
//  142   
//  143   /* Clear CLKDIV, PWRSAV, BYPASS, WIDBUS, NEGEDGE, HWFC_EN bits */
//  144   tmpreg &= CLKCR_CLEAR_MASK;
//  145   
//  146   /* Set CLKDIV bits according to SDIO_ClockDiv value */
//  147   /* Set PWRSAV bit according to SDIO_ClockPowerSave value */
//  148   /* Set BYPASS bit according to SDIO_ClockBypass value */
//  149   /* Set WIDBUS bits according to SDIO_BusWide value */
//  150   /* Set NEGEDGE bits according to SDIO_ClockEdge value */
//  151   /* Set HWFC_EN bits according to SDIO_HardwareFlowControl value */
//  152   tmpreg |= (SDIO_InitStruct->SDIO_ClockDiv  | SDIO_InitStruct->SDIO_ClockPowerSave |
//  153              SDIO_InitStruct->SDIO_ClockBypass | SDIO_InitStruct->SDIO_BusWide |
//  154              SDIO_InitStruct->SDIO_ClockEdge | SDIO_InitStruct->SDIO_HardwareFlowControl); 
//  155   
//  156   /* Write to SDIO CLKCR */
//  157   SDIO->CLKCR = tmpreg;             
        LDR.N    R3,??SDIO_Init_0+0x4  ;; 0xffff8100
        ANDS     R2,R3,R2
        LDRB     R3,[R0, #+0]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+12]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+8]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+16]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+4]
        ORRS     R2,R3,R2
        LDR      R0,[R0, #+20]
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
//  158 }
        BX       LR               ;; return
        DATA
??SDIO_Init_0:
        DC32     0x40018004
        DC32     0xffff8100
        CFI EndBlock cfiBlock1
//  159 
//  160 /*******************************************************************************
//  161 * Function Name  : SDIO_StructInit
//  162 * Description    : Fills each SDIO_InitStruct member with its default value.
//  163 * Input          : SDIO_InitStruct: pointer to an SDIO_InitTypeDef structure which 
//  164 *                  will be initialized.
//  165 * Output         : None
//  166 * Return         : None
//  167 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function SDIO_StructInit
        THUMB
//  168 void SDIO_StructInit(SDIO_InitTypeDef* SDIO_InitStruct)
//  169 {
//  170   /* SDIO_InitStruct members default value */
//  171   SDIO_InitStruct->SDIO_ClockDiv = 0x00;
SDIO_StructInit:
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  172   SDIO_InitStruct->SDIO_ClockEdge = SDIO_ClockEdge_Rising;
        STR      R1,[R0, #+4]
//  173   SDIO_InitStruct->SDIO_ClockBypass = SDIO_ClockBypass_Disable;
        STR      R1,[R0, #+8]
//  174   SDIO_InitStruct->SDIO_ClockPowerSave = SDIO_ClockPowerSave_Disable;
        STR      R1,[R0, #+12]
//  175   SDIO_InitStruct->SDIO_BusWide = SDIO_BusWide_1b;
        STR      R1,[R0, #+16]
//  176   SDIO_InitStruct->SDIO_HardwareFlowControl = SDIO_HardwareFlowControl_Disable;
        STR      R1,[R0, #+20]
//  177 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//  178 
//  179 /*******************************************************************************
//  180 * Function Name  : SDIO_ClockCmd
//  181 * Description    : Enables or disables the SDIO Clock.
//  182 * Input          : NewState: new state of the SDIO Clock.
//  183 *                  This parameter can be: ENABLE or DISABLE.
//  184 * Output         : None
//  185 * Return         : None
//  186 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function SDIO_ClockCmd
        THUMB
//  187 void SDIO_ClockCmd(FunctionalState NewState)
//  188 {
//  189   /* Check the parameters */
//  190   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  191   
//  192   *(vu32 *) CLKCR_CLKEN_BB = (u32)NewState;
SDIO_ClockCmd:
        LDR.N    R1,??SDIO_ClockCmd_0  ;; 0x423000a0
        STR      R0,[R1, #+0]
//  193 }
        BX       LR               ;; return
        Nop      
        DATA
??SDIO_ClockCmd_0:
        DC32     0x423000a0
        CFI EndBlock cfiBlock3
//  194 
//  195 /*******************************************************************************
//  196 * Function Name  : SDIO_SetPowerState
//  197 * Description    : Sets the power status of the controller.
//  198 * Input          : SDIO_PowerState: new state of the Power state. 
//  199 *                  This parameter can be one of the following values:
//  200 *                   - SDIO_PowerState_OFF
//  201 *                   - SDIO_PowerState_ON
//  202 * Output         : None
//  203 * Return         : None
//  204 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function SDIO_SetPowerState
        THUMB
//  205 void SDIO_SetPowerState(u32 SDIO_PowerState)
//  206 {
//  207   /* Check the parameters */
//  208   assert_param(IS_SDIO_POWER_STATE(SDIO_PowerState));
//  209   
//  210   SDIO->POWER &= PWR_PWRCTRL_MASK;
SDIO_SetPowerState:
        LDR.N    R1,??DataTable2  ;; 0x40018000
        LDR      R2,[R1, #+0]
        MOVS     R3,#+3
        BICS     R2,R2,R3
        STR      R2,[R1, #+0]
//  211   SDIO->POWER |= SDIO_PowerState;
        LDR      R2,[R1, #+0]
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
//  212 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  213 
//  214 /*******************************************************************************
//  215 * Function Name  : SDIO_GetPowerState
//  216 * Description    : Gets the power status of the controller.
//  217 * Input          : None
//  218 * Output         : None
//  219 * Return         : Power status of the controller. The returned value can
//  220 *                  be one of the following:
//  221 *                       - 0x00: Power OFF
//  222 *                       - 0x02: Power UP
//  223 *                       - 0x03: Power ON 
//  224 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function SDIO_GetPowerState
        THUMB
//  225 u32 SDIO_GetPowerState(void)
//  226 {
//  227   return (SDIO->POWER & (~PWR_PWRCTRL_MASK));
SDIO_GetPowerState:
        LDR.N    R0,??DataTable2  ;; 0x40018000
        LDR      R0,[R0, #+0]
        AND      R0,R0,#0x3
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  228 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2:
        DC32     0x40018000
//  229 
//  230 /*******************************************************************************
//  231 * Function Name  : SDIO_ITConfig
//  232 * Description    : Enables or disables the SDIO interrupts.
//  233 * Input          : - SDIO_IT: specifies the SDIO interrupt sources to be 
//  234 *                    enabled or disabled.
//  235 *                    This parameter can be one or a combination of the following
//  236 *                    values:
//  237 *                      - SDIO_IT_CCRCFAIL: Command response received (CRC check
//  238 *                                          failed) interrupt    
//  239 *                      - SDIO_IT_DCRCFAIL: Data block sent/received (CRC check 
//  240 *                                          failed) interrupt    
//  241 *                      - SDIO_IT_CTIMEOUT: Command response timeout interrupt    
//  242 *                      - SDIO_IT_DTIMEOUT: Data timeout interrupt    
//  243 *                      - SDIO_IT_TXUNDERR: Transmit FIFO underrun error interrupt    
//  244 *                      - SDIO_IT_RXOVERR:  Received FIFO overrun error interrupt     
//  245 *                      - SDIO_IT_CMDREND:  Command response received (CRC check 
//  246 *                                          passed) interrupt     
//  247 *                      - SDIO_IT_CMDSENT:  Command sent (no response required) 
//  248 *                                          interrupt     
//  249 *                      - SDIO_IT_DATAEND:  Data end (data counter, SDIDCOUNT, is 
//  250 *                                          zero) interrupt     
//  251 *                      - SDIO_IT_STBITERR: Start bit not detected on all data 
//  252 *                                          signals in wide bus mode interrupt    
//  253 *                      - SDIO_IT_DBCKEND:  Data block sent/received (CRC check 
//  254 *                                          passed) interrupt    
//  255 *                      - SDIO_IT_CMDACT:   Command transfer in progress interrupt     
//  256 *                      - SDIO_IT_TXACT:    Data transmit in progress interrupt       
//  257 *                      - SDIO_IT_RXACT:    Data receive in progress interrupt      
//  258 *                      - SDIO_IT_TXFIFOHE: Transmit FIFO Half Empty interrupt    
//  259 *                      - SDIO_IT_RXFIFOHF: Receive FIFO Half Full interrupt   
//  260 *                      - SDIO_IT_TXFIFOF:  Transmit FIFO full interrupt     
//  261 *                      - SDIO_IT_RXFIFOF:  Receive FIFO full interrupt     
//  262 *                      - SDIO_IT_TXFIFOE:  Transmit FIFO empty interrupt      
//  263 *                      - SDIO_IT_RXFIFOE:  Receive FIFO empty interrupt     
//  264 *                      - SDIO_IT_TXDAVL:   Data available in transmit FIFO interrupt      
//  265 *                      - SDIO_IT_RXDAVL:   Data available in receive FIFO interrupt      
//  266 *                      - SDIO_IT_SDIOIT:   SD I/O interrupt received interrupt      
//  267 *                      - SDIO_IT_CEATAEND: CE-ATA command completion signal 
//  268 *                                          received for CMD61 interrupt
//  269 *                  - NewState: new state of the specified SDIO interrupts.
//  270 *                  This parameter can be: ENABLE or DISABLE.  
//  271 * Output         : None
//  272 * Return         : None 
//  273 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function SDIO_ITConfig
        THUMB
//  274 void SDIO_ITConfig(u32 SDIO_IT, FunctionalState NewState)
//  275 {
//  276   /* Check the parameters */
//  277   assert_param(IS_SDIO_IT(SDIO_IT));
//  278   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  279   
//  280   if (NewState != DISABLE)
SDIO_ITConfig:
        LDR.N    R2,??SDIO_ITConfig_0  ;; 0x4001803c
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        BEQ.N    ??SDIO_ITConfig_1
//  281   {
//  282     /* Enable the SDIO interrupts */
//  283     SDIO->MASK |= SDIO_IT;
        ORRS     R0,R0,R1
        B.N      ??SDIO_ITConfig_2
//  284   }
//  285   else
//  286   {
//  287     /* Disable the SDIO interrupts */
//  288     SDIO->MASK &= ~SDIO_IT;
??SDIO_ITConfig_1:
        MVNS     R0,R0
        ANDS     R0,R0,R1
??SDIO_ITConfig_2:
        STR      R0,[R2, #+0]
//  289   } 
//  290 }
        BX       LR               ;; return
        DATA
??SDIO_ITConfig_0:
        DC32     0x4001803c
        CFI EndBlock cfiBlock6
//  291 
//  292 /*******************************************************************************
//  293 * Function Name  : SDIO_DMACmd
//  294 * Description    : Enables or disables the SDIO DMA request.
//  295 * Input          : NewState: new state of the selected SDIO DMA request.
//  296 *                  This parameter can be: ENABLE or DISABLE.
//  297 * Output         : None
//  298 * Return         : None
//  299 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function SDIO_DMACmd
        THUMB
//  300 void SDIO_DMACmd(FunctionalState NewState)
//  301 {
//  302   /* Check the parameters */
//  303   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  304   
//  305   *(vu32 *) DCTRL_DMAEN_BB = (u32)NewState;
SDIO_DMACmd:
        LDR.N    R1,??SDIO_DMACmd_0  ;; 0x4230058c
        STR      R0,[R1, #+0]
//  306 }
        BX       LR               ;; return
        Nop      
        DATA
??SDIO_DMACmd_0:
        DC32     0x4230058c
        CFI EndBlock cfiBlock7
//  307 
//  308 /*******************************************************************************
//  309 * Function Name  : SDIO_SendCommand
//  310 * Description    : Initializes the SDIO Command according to the specified 
//  311 *                  parameters in the SDIO_CmdInitStruct and send the command.
//  312 * Input          : SDIO_CmdInitStruct : pointer to a SDIO_CmdInitTypeDef 
//  313 *                  structure that contains the configuration information 
//  314 *                  for the SDIO command.
//  315 * Output         : None
//  316 * Return         : None
//  317 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function SDIO_SendCommand
        THUMB
//  318 void SDIO_SendCommand(SDIO_CmdInitTypeDef *SDIO_CmdInitStruct)
//  319 {
//  320   u32 tmpreg = 0;
//  321   
//  322   /* Check the parameters */
//  323   assert_param(IS_SDIO_CMD_INDEX(SDIO_CmdInitStruct->SDIO_CmdIndex));
//  324   assert_param(IS_SDIO_RESPONSE(SDIO_CmdInitStruct->SDIO_Response));
//  325   assert_param(IS_SDIO_WAIT(SDIO_CmdInitStruct->SDIO_Wait));
//  326   assert_param(IS_SDIO_CPSM(SDIO_CmdInitStruct->SDIO_CPSM));
//  327   
//  328 /*---------------------------- SDIO ARG Configuration ------------------------*/
//  329   /* Set the SDIO Argument value */
//  330   SDIO->ARG = SDIO_CmdInitStruct->SDIO_Argument;
SDIO_SendCommand:
        LDR.N    R1,??SDIO_SendCommand_0  ;; 0x40018008
        LDR      R2,[R0, #+0]
        STR      R2,[R1, #+0]
//  331   
//  332 /*---------------------------- SDIO CMD Configuration ------------------------*/  
//  333   /* Get the SDIO CMD value */
//  334   tmpreg = SDIO->CMD;
        LDR      R1,[R1, #+4]
//  335 
//  336   /* Clear CMDINDEX, WAITRESP, WAITINT, WAITPEND, CPSMEN bits */
//  337   tmpreg &= CMD_CLEAR_MASK;
//  338   /* Set CMDINDEX bits according to SDIO_CmdIndex value */
//  339   /* Set WAITRESP bits according to SDIO_Response value */
//  340   /* Set WAITINT and WAITPEND bits according to SDIO_Wait value */
//  341   /* Set CPSMEN bits according to SDIO_CPSM value */
//  342   tmpreg |= (u32)SDIO_CmdInitStruct->SDIO_CmdIndex | SDIO_CmdInitStruct->SDIO_Response
//  343            | SDIO_CmdInitStruct->SDIO_Wait | SDIO_CmdInitStruct->SDIO_CPSM;
//  344   
//  345   /* Write to SDIO CMD */
//  346   SDIO->CMD = tmpreg;
        LSRS     R1,R1,#+11
        LSLS     R1,R1,#+11
        LDR      R2,[R0, #+4]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+8]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+12]
        ORRS     R1,R2,R1
        LDR      R0,[R0, #+16]
        ORRS     R0,R0,R1
        LDR.N    R1,??SDIO_SendCommand_0  ;; 0x40018008
        STR      R0,[R1, #+4]
//  347 }
        BX       LR               ;; return
        Nop      
        DATA
??SDIO_SendCommand_0:
        DC32     0x40018008
        CFI EndBlock cfiBlock8
//  348 
//  349 /*******************************************************************************
//  350 * Function Name  : SDIO_CmdStructInit
//  351 * Description    : Fills each SDIO_CmdInitStruct member with its default value.
//  352 * Input          : SDIO_CmdInitStruct: pointer to an SDIO_CmdInitTypeDef 
//  353 *                  structure which will be initialized.
//  354 * Output         : None
//  355 * Return         : None
//  356 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function SDIO_CmdStructInit
        THUMB
//  357 void SDIO_CmdStructInit(SDIO_CmdInitTypeDef* SDIO_CmdInitStruct)
//  358 {
//  359   /* SDIO_CmdInitStruct members default value */
//  360   SDIO_CmdInitStruct->SDIO_Argument = 0x00;
SDIO_CmdStructInit:
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  361   SDIO_CmdInitStruct->SDIO_CmdIndex = 0x00;
        STR      R1,[R0, #+4]
//  362   SDIO_CmdInitStruct->SDIO_Response = SDIO_Response_No;
        STR      R1,[R0, #+8]
//  363   SDIO_CmdInitStruct->SDIO_Wait = SDIO_Wait_No;
        STR      R1,[R0, #+12]
//  364   SDIO_CmdInitStruct->SDIO_CPSM = SDIO_CPSM_Disable;
        STR      R1,[R0, #+16]
//  365 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//  366 
//  367 /*******************************************************************************
//  368 * Function Name  : SDIO_GetCommandResponse
//  369 * Description    : Returns command index of last command for which response 
//  370 *                  received.
//  371 * Input          : None
//  372 * Output         : None
//  373 * Return         : Returns the command index of the last command response received.
//  374 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function SDIO_GetCommandResponse
        THUMB
//  375 u8 SDIO_GetCommandResponse(void)
//  376 {
//  377   return (u8)(SDIO->RESPCMD);
SDIO_GetCommandResponse:
        LDR.N    R0,??SDIO_GetCommandResponse_0  ;; 0x40018010
        LDR      R0,[R0, #+0]
        UXTB     R0,R0
        BX       LR               ;; return
        DATA
??SDIO_GetCommandResponse_0:
        DC32     0x40018010
        CFI EndBlock cfiBlock10
//  378 }
//  379 
//  380 /*******************************************************************************
//  381 * Function Name  : SDIO_GetResponse
//  382 * Description    : Returns response received from the card for the last command.
//  383 * Input          : - SDIO_RESP: Specifies the SDIO response register. 
//  384 *                     This parameter can be one of the following values:
//  385 *                       - SDIO_RESP1: Response Register 1
//  386 *                       - SDIO_RESP2: Response Register 2
//  387 *                       - SDIO_RESP3: Response Register 3
//  388 *                       - SDIO_RESP4: Response Register 4                       
//  389 * Output         : None
//  390 * Return         : The Corresponding response register value.
//  391 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function SDIO_GetResponse
        THUMB
//  392 u32 SDIO_GetResponse(u32 SDIO_RESP)
//  393 {
//  394   /* Check the parameters */
//  395   assert_param(IS_SDIO_RESP(SDIO_RESP));
//  396   
//  397   return (*(vu32 *)(SDIO_RESP_ADDR + SDIO_RESP)); 
SDIO_GetResponse:
        LDR.N    R1,??SDIO_GetResponse_0  ;; 0x40018014
        LDR      R0,[R1, R0]
        BX       LR               ;; return
        Nop      
        DATA
??SDIO_GetResponse_0:
        DC32     0x40018014
        CFI EndBlock cfiBlock11
//  398 }
//  399 
//  400 /*******************************************************************************
//  401 * Function Name  : SDIO_DataConfig
//  402 * Description    : Initializes the SDIO data path according to the specified 
//  403 *                  parameters in the SDIO_DataInitStruct.
//  404 * Input          : SDIO_DataInitStruct : pointer to a SDIO_DataInitTypeDef 
//  405 *                  structure that contains the configuration information 
//  406 *                  for the SDIO command.
//  407 * Output         : None
//  408 * Return         : None
//  409 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function SDIO_DataConfig
        THUMB
//  410 void SDIO_DataConfig(SDIO_DataInitTypeDef* SDIO_DataInitStruct)
//  411 {
//  412   u32 tmpreg = 0;
//  413   
//  414   /* Check the parameters */
//  415   assert_param(IS_SDIO_DATA_LENGTH(SDIO_DataInitStruct->SDIO_DataLength));
//  416   assert_param(IS_SDIO_BLOCK_SIZE(SDIO_DataInitStruct->SDIO_DataBlockSize));
//  417   assert_param(IS_SDIO_TRANSFER_DIR(SDIO_DataInitStruct->SDIO_TransferDir));
//  418   assert_param(IS_SDIO_TRANSFER_MODE(SDIO_DataInitStruct->SDIO_TransferMode));
//  419   assert_param(IS_SDIO_DPSM(SDIO_DataInitStruct->SDIO_DPSM));
//  420 
//  421 /*---------------------------- SDIO DTIMER Configuration ---------------------*/
//  422   /* Set the SDIO Data TimeOut value */
//  423   SDIO->DTIMER = SDIO_DataInitStruct->SDIO_DataTimeOut;
SDIO_DataConfig:
        LDR.N    R1,??SDIO_DataConfig_0  ;; 0x40018024
        LDR      R2,[R0, #+0]
        STR      R2,[R1, #+0]
//  424     
//  425 /*---------------------------- SDIO DLEN Configuration -----------------------*/
//  426   /* Set the SDIO DataLength value */
//  427   SDIO->DLEN = SDIO_DataInitStruct->SDIO_DataLength;
        LDR      R2,[R0, #+4]
        STR      R2,[R1, #+4]
//  428   
//  429 /*---------------------------- SDIO DCTRL Configuration ----------------------*/  
//  430   /* Get the SDIO DCTRL value */
//  431   tmpreg = SDIO->DCTRL;
        LDR      R1,[R1, #+8]
//  432 
//  433   /* Clear DEN, DTMODE, DTDIR and DBCKSIZE bits */
//  434   tmpreg &= DCTRL_CLEAR_MASK;
//  435   /* Set DEN bit according to SDIO_DPSM value */
//  436   /* Set DTMODE bit according to SDIO_TransferMode value */
//  437   /* Set DTDIR bit according to SDIO_TransferDir value */
//  438   /* Set DBCKSIZE bits according to SDIO_DataBlockSize value */
//  439   tmpreg |= (u32)SDIO_DataInitStruct->SDIO_DataBlockSize | SDIO_DataInitStruct->SDIO_TransferDir
//  440            | SDIO_DataInitStruct->SDIO_TransferMode | SDIO_DataInitStruct->SDIO_DPSM;
//  441   
//  442   /* Write to SDIO DCTRL */
//  443   SDIO->DCTRL = tmpreg;
        MOVS     R2,#+247
        BICS     R1,R1,R2
        LDR      R2,[R0, #+8]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+12]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+16]
        ORRS     R1,R2,R1
        LDR      R0,[R0, #+20]
        ORRS     R0,R0,R1
        LDR.N    R1,??SDIO_DataConfig_0  ;; 0x40018024
        STR      R0,[R1, #+8]
//  444 }
        BX       LR               ;; return
        Nop      
        DATA
??SDIO_DataConfig_0:
        DC32     0x40018024
        CFI EndBlock cfiBlock12
//  445 
//  446 /*******************************************************************************
//  447 * Function Name  : SDIO_DataStructInit
//  448 * Description    : Fills each SDIO_DataInitStruct member with its default value.
//  449 * Input          : SDIO_DataInitStruct: pointer to an SDIO_DataInitTypeDef 
//  450 *                  structure which will be initialized.
//  451 * Output         : None
//  452 * Return         : None
//  453 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function SDIO_DataStructInit
        THUMB
//  454 void SDIO_DataStructInit(SDIO_DataInitTypeDef* SDIO_DataInitStruct)
//  455 {
//  456   /* SDIO_DataInitStruct members default value */
//  457   SDIO_DataInitStruct->SDIO_DataTimeOut = 0xFFFFFFFF;
SDIO_DataStructInit:
        MOV      R1,#-1
        STR      R1,[R0, #+0]
//  458   SDIO_DataInitStruct->SDIO_DataLength = 0x00;
        MOVS     R1,#+0
        STR      R1,[R0, #+4]
//  459   SDIO_DataInitStruct->SDIO_DataBlockSize = SDIO_DataBlockSize_1b;
        STR      R1,[R0, #+8]
//  460   SDIO_DataInitStruct->SDIO_TransferDir = SDIO_TransferDir_ToCard;
        STR      R1,[R0, #+12]
//  461   SDIO_DataInitStruct->SDIO_TransferMode = SDIO_TransferMode_Block;  
        STR      R1,[R0, #+16]
//  462   SDIO_DataInitStruct->SDIO_DPSM = SDIO_DPSM_Disable;
        STR      R1,[R0, #+20]
//  463 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock13
//  464 
//  465 /*******************************************************************************
//  466 * Function Name  : SDIO_GetDataCounter
//  467 * Description    : Returns number of remaining data bytes to be transferred.
//  468 * Input          : None
//  469 * Output         : None
//  470 * Return         : Number of remaining data bytes to be transferred
//  471 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function SDIO_GetDataCounter
        THUMB
//  472 u32 SDIO_GetDataCounter(void)
//  473 { 
//  474   return SDIO->DCOUNT;
SDIO_GetDataCounter:
        LDR.N    R0,??SDIO_GetDataCounter_0  ;; 0x40018030
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
        Nop      
        DATA
??SDIO_GetDataCounter_0:
        DC32     0x40018030
        CFI EndBlock cfiBlock14
//  475 }
//  476 
//  477 /*******************************************************************************
//  478 * Function Name  : SDIO_ReadData
//  479 * Description    : Read one data word from Rx FIFO.
//  480 * Input          : None
//  481 * Output         : None
//  482 * Return         : Data received
//  483 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function SDIO_ReadData
        THUMB
//  484 u32 SDIO_ReadData(void)
//  485 { 
//  486   return SDIO->FIFO;
SDIO_ReadData:
        LDR.N    R0,??DataTable4  ;; 0x40018080
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
        CFI EndBlock cfiBlock15
//  487 }
//  488 
//  489 /*******************************************************************************
//  490 * Function Name  : SDIO_WriteData
//  491 * Description    : Write one data word to Tx FIFO.
//  492 * Input          : Data: 32-bit data word to write.
//  493 * Output         : None
//  494 * Return         : None
//  495 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function SDIO_WriteData
        THUMB
//  496 void SDIO_WriteData(u32 Data)
//  497 { 
//  498   SDIO->FIFO = Data;
SDIO_WriteData:
        LDR.N    R1,??DataTable4  ;; 0x40018080
        STR      R0,[R1, #+0]
//  499 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock16

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable4:
        DC32     0x40018080
//  500 
//  501 /*******************************************************************************
//  502 * Function Name  : SDIO_GetFIFOCount
//  503 * Description    : Returns the number of words left to be written to or read
//  504 *                  from FIFO.	
//  505 * Input          : None
//  506 * Output         : None
//  507 * Return         : Remaining number of words.
//  508 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function SDIO_GetFIFOCount
        THUMB
//  509 u32 SDIO_GetFIFOCount(void)
//  510 { 
//  511   return SDIO->FIFOCNT;
SDIO_GetFIFOCount:
        LDR.N    R0,??SDIO_GetFIFOCount_0  ;; 0x40018048
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
        Nop      
        DATA
??SDIO_GetFIFOCount_0:
        DC32     0x40018048
        CFI EndBlock cfiBlock17
//  512 }
//  513 
//  514 /*******************************************************************************
//  515 * Function Name  : SDIO_StartSDIOReadWait
//  516 * Description    : Starts the SD I/O Read Wait operation.	
//  517 * Input          : NewState: new state of the Start SDIO Read Wait operation. 
//  518 *                  This parameter can be: ENABLE or DISABLE.
//  519 * Output         : None
//  520 * Return         : None
//  521 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function SDIO_StartSDIOReadWait
        THUMB
//  522 void SDIO_StartSDIOReadWait(FunctionalState NewState)
//  523 { 
//  524   /* Check the parameters */
//  525   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  526   
//  527   *(vu32 *) DCTRL_RWSTART_BB = (u32) NewState;
SDIO_StartSDIOReadWait:
        LDR.N    R1,??SDIO_StartSDIOReadWait_0  ;; 0x423005a0
        STR      R0,[R1, #+0]
//  528 }
        BX       LR               ;; return
        Nop      
        DATA
??SDIO_StartSDIOReadWait_0:
        DC32     0x423005a0
        CFI EndBlock cfiBlock18
//  529 
//  530 /*******************************************************************************
//  531 * Function Name  : SDIO_StopSDIOReadWait
//  532 * Description    : Stops the SD I/O Read Wait operation.	
//  533 * Input          : NewState: new state of the Stop SDIO Read Wait operation. 
//  534 *                  This parameter can be: ENABLE or DISABLE.
//  535 * Output         : None
//  536 * Return         : None
//  537 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI Function SDIO_StopSDIOReadWait
        THUMB
//  538 void SDIO_StopSDIOReadWait(FunctionalState NewState)
//  539 { 
//  540   /* Check the parameters */
//  541   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  542   
//  543   *(vu32 *) DCTRL_RWSTOP_BB = (u32) NewState;
SDIO_StopSDIOReadWait:
        LDR.N    R1,??SDIO_StopSDIOReadWait_0  ;; 0x423005a4
        STR      R0,[R1, #+0]
//  544 }
        BX       LR               ;; return
        Nop      
        DATA
??SDIO_StopSDIOReadWait_0:
        DC32     0x423005a4
        CFI EndBlock cfiBlock19
//  545 
//  546 /*******************************************************************************
//  547 * Function Name  : SDIO_SetSDIOReadWaitMode
//  548 * Description    : Sets one of the two options of inserting read wait interval.	
//  549 * Input          : SDIOReadWaitMode: SD I/O Read Wait operation mode.
//  550 *                  This parametre can be:
//  551 *                    - SDIO_ReadWaitMode_CLK: Read Wait control by stopping SDIOCLK
//  552 *                    - SDIO_ReadWaitMode_DATA2: Read Wait control using SDIO_DATA2
//  553 * Output         : None
//  554 * Return         : None
//  555 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock20 Using cfiCommon0
        CFI Function SDIO_SetSDIOReadWaitMode
        THUMB
//  556 void SDIO_SetSDIOReadWaitMode(u32 SDIO_ReadWaitMode)
//  557 {
//  558   /* Check the parameters */
//  559   assert_param(IS_SDIO_READWAIT_MODE(SDIO_ReadWaitMode));
//  560   
//  561   *(vu32 *) DCTRL_RWMOD_BB = SDIO_ReadWaitMode;
SDIO_SetSDIOReadWaitMode:
        LDR.N    R1,??SDIO_SetSDIOReadWaitMode_0  ;; 0x423005a8
        STR      R0,[R1, #+0]
//  562 }
        BX       LR               ;; return
        Nop      
        DATA
??SDIO_SetSDIOReadWaitMode_0:
        DC32     0x423005a8
        CFI EndBlock cfiBlock20
//  563 
//  564 /*******************************************************************************
//  565 * Function Name  : SDIO_SetSDIOOperation
//  566 * Description    : Enables or disables the SD I/O Mode Operation.	
//  567 * Input          : NewState: new state of SDIO specific operation. 
//  568 *                  This parameter can be: ENABLE or DISABLE.
//  569 * Output         : None
//  570 * Return         : None
//  571 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock21 Using cfiCommon0
        CFI Function SDIO_SetSDIOOperation
        THUMB
//  572 void SDIO_SetSDIOOperation(FunctionalState NewState)
//  573 { 
//  574   /* Check the parameters */
//  575   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  576   
//  577   *(vu32 *) DCTRL_SDIOEN_BB = (u32)NewState;
SDIO_SetSDIOOperation:
        LDR.N    R1,??SDIO_SetSDIOOperation_0  ;; 0x423005ac
        STR      R0,[R1, #+0]
//  578 }
        BX       LR               ;; return
        Nop      
        DATA
??SDIO_SetSDIOOperation_0:
        DC32     0x423005ac
        CFI EndBlock cfiBlock21
//  579 
//  580 /*******************************************************************************
//  581 * Function Name  : SDIO_SendSDIOSuspendCmd
//  582 * Description    : Enables or disables the SD I/O Mode suspend command sending.
//  583 * Input          : NewState: new state of the SD I/O Mode suspend command.
//  584 *                  This parameter can be: ENABLE or DISABLE.
//  585 * Output         : None
//  586 * Return         : None
//  587 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock22 Using cfiCommon0
        CFI Function SDIO_SendSDIOSuspendCmd
        THUMB
//  588 void SDIO_SendSDIOSuspendCmd(FunctionalState NewState)
//  589 { 
//  590   /* Check the parameters */
//  591   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  592   
//  593   *(vu32 *) CMD_SDIOSUSPEND_BB = (u32)NewState;
SDIO_SendSDIOSuspendCmd:
        LDR.N    R1,??SDIO_SendSDIOSuspendCmd_0  ;; 0x423001ac
        STR      R0,[R1, #+0]
//  594 }
        BX       LR               ;; return
        Nop      
        DATA
??SDIO_SendSDIOSuspendCmd_0:
        DC32     0x423001ac
        CFI EndBlock cfiBlock22
//  595 
//  596 /*******************************************************************************
//  597 * Function Name  : SDIO_CommandCompletionCmd
//  598 * Description    : Enables or disables the command completion signal.
//  599 * Input          : NewState: new state of command completion signal. 
//  600 *                  This parameter can be: ENABLE or DISABLE.
//  601 * Output         : None
//  602 * Return         : None
//  603 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock23 Using cfiCommon0
        CFI Function SDIO_CommandCompletionCmd
        THUMB
//  604 void SDIO_CommandCompletionCmd(FunctionalState NewState)
//  605 { 
//  606   /* Check the parameters */
//  607   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  608   
//  609   *(vu32 *) CMD_ENCMDCOMPL_BB = (u32)NewState;
SDIO_CommandCompletionCmd:
        LDR.N    R1,??SDIO_CommandCompletionCmd_0  ;; 0x423001b0
        STR      R0,[R1, #+0]
//  610 }
        BX       LR               ;; return
        Nop      
        DATA
??SDIO_CommandCompletionCmd_0:
        DC32     0x423001b0
        CFI EndBlock cfiBlock23
//  611 
//  612 /*******************************************************************************
//  613 * Function Name  : SDIO_CEATAITCmd
//  614 * Description    : Enables or disables the CE-ATA interrupt.
//  615 * Input          : NewState: new state of CE-ATA interrupt. 
//  616 *                  This parameter can be: ENABLE or DISABLE.
//  617 * Output         : None
//  618 * Return         : None
//  619 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock24 Using cfiCommon0
        CFI Function SDIO_CEATAITCmd
        THUMB
//  620 void SDIO_CEATAITCmd(FunctionalState NewState)
//  621 { 
//  622   /* Check the parameters */
//  623   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  624   
//  625   *(vu32 *) CMD_NIEN_BB = (u32)((~((u32)NewState)) & ((u32)0x1));
SDIO_CEATAITCmd:
        MVNS     R0,R0
        AND      R0,R0,#0x1
        LDR.N    R1,??SDIO_CEATAITCmd_0  ;; 0x423001b4
        STR      R0,[R1, #+0]
//  626 }
        BX       LR               ;; return
        DATA
??SDIO_CEATAITCmd_0:
        DC32     0x423001b4
        CFI EndBlock cfiBlock24
//  627 
//  628 /*******************************************************************************
//  629 * Function Name  : SDIO_SendCEATACmd
//  630 * Description    : Sends CE-ATA command (CMD61).
//  631 * Input          : NewState: new state of CE-ATA command. 
//  632 *                  This parameter can be: ENABLE or DISABLE.
//  633 * Output         : None
//  634 * Return         : None
//  635 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock25 Using cfiCommon0
        CFI Function SDIO_SendCEATACmd
        THUMB
//  636 void SDIO_SendCEATACmd(FunctionalState NewState)
//  637 { 
//  638   /* Check the parameters */
//  639   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  640   
//  641   *(vu32 *) CMD_ATACMD_BB = (u32)NewState;
SDIO_SendCEATACmd:
        LDR.N    R1,??SDIO_SendCEATACmd_0  ;; 0x423001b8
        STR      R0,[R1, #+0]
//  642 }
        BX       LR               ;; return
        Nop      
        DATA
??SDIO_SendCEATACmd_0:
        DC32     0x423001b8
        CFI EndBlock cfiBlock25
//  643 
//  644 /*******************************************************************************
//  645 * Function Name  : SDIO_GetFlagStatus
//  646 * Description    : Checks whether the specified SDIO flag is set or not.	
//  647 * Input          : SDIO_FLAG: specifies the flag to check. 
//  648 *                  This parameter can be one of the following values:
//  649 *                     - SDIO_FLAG_CCRCFAIL: Command response received (CRC check
//  650 *                                           failed)    
//  651 *                     - SDIO_FLAG_DCRCFAIL: Data block sent/received (CRC check 
//  652 *                                           failed)    
//  653 *                     - SDIO_FLAG_CTIMEOUT: Command response timeout    
//  654 *                     - SDIO_FLAG_DTIMEOUT: Data timeou   
//  655 *                     - SDIO_FLAG_TXUNDERR: Transmit FIFO underrun error   
//  656 *                     - SDIO_FLAG_RXOVERR:  Received FIFO overrun error    
//  657 *                     - SDIO_FLAG_CMDREND:  Command response received (CRC check 
//  658 *                                           passed)    
//  659 *                     - SDIO_FLAG_CMDSENT:  Command sent (no response required)    
//  660 *                     - SDIO_FLAG_DATAEND:  Data end (data counter, SDIDCOUNT, is
//  661 *                                           zero)    
//  662 *                     - SDIO_FLAG_STBITERR: Start bit not detected on all data 
//  663 *                                           signals in wide bus mode   
//  664 *                     - SDIO_FLAG_DBCKEND:  Data block sent/received (CRC check 
//  665 *                                           passed)    
//  666 *                     - SDIO_FLAG_CMDACT:   Command transfer in progress     
//  667 *                     - SDIO_FLAG_TXACT:    Data transmit in progress      
//  668 *                     - SDIO_FLAG_RXACT:    Data receive in progress      
//  669 *                     - SDIO_FLAG_TXFIFOHE: Transmit FIFO Half Empty   
//  670 *                     - SDIO_FLAG_RXFIFOHF: Receive FIFO Half Full   
//  671 *                     - SDIO_FLAG_TXFIFOF:  Transmit FIFO full    
//  672 *                     - SDIO_FLAG_RXFIFOF:  Receive FIFO full     
//  673 *                     - SDIO_FLAG_TXFIFOE:  Transmit FIFO empty    
//  674 *                     - SDIO_FLAG_RXFIFOE:  Receive FIFO empty    
//  675 *                     - SDIO_FLAG_TXDAVL:   Data available in transmit FIFO     
//  676 *                     - SDIO_FLAG_RXDAVL:   Data available in receive FIFO     
//  677 *                     - SDIO_FLAG_SDIOIT:   SD I/O interrupt received     
//  678 *                     - SDIO_FLAG_CEATAEND: CE-ATA command completion signal 
//  679 *                                           received for CMD61    
//  680 * Output         : None
//  681 * Return         : The new state of SDIO_FLAG (SET or RESET).
//  682 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock26 Using cfiCommon0
        CFI Function SDIO_GetFlagStatus
        THUMB
//  683 FlagStatus SDIO_GetFlagStatus(u32 SDIO_FLAG)
//  684 { 
//  685   FlagStatus bitstatus = RESET;
//  686   
//  687   /* Check the parameters */
//  688   assert_param(IS_SDIO_FLAG(SDIO_FLAG));
//  689   
//  690   if ((SDIO->STA & SDIO_FLAG) != (u32)RESET)
SDIO_GetFlagStatus:
        LDR.N    R1,??DataTable7  ;; 0x40018034
        LDR      R1,[R1, #+0]
        ANDS     R0,R0,R1
        SUBS     R0,R0,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  691   {
//  692     bitstatus = SET;
//  693   }
//  694   else
//  695   {
//  696     bitstatus = RESET;
//  697   }
//  698   return bitstatus;
        BX       LR               ;; return
        CFI EndBlock cfiBlock26
//  699 }
//  700 
//  701 /*******************************************************************************
//  702 * Function Name  : SDIO_ClearFlag
//  703 * Description    : Clears the SDIO's pending flags.	
//  704 * Input          : SDIO_FLAG: specifies the flag to clear.  
//  705 *                  This parameter can be one or a combination of the following
//  706 *                  values:
//  707 *                     - SDIO_FLAG_CCRCFAIL: Command response received (CRC check
//  708 *                                           failed)    
//  709 *                     - SDIO_FLAG_DCRCFAIL: Data block sent/received (CRC check 
//  710 *                                           failed)    
//  711 *                     - SDIO_FLAG_CTIMEOUT: Command response timeout    
//  712 *                     - SDIO_FLAG_DTIMEOUT: Data timeou   
//  713 *                     - SDIO_FLAG_TXUNDERR: Transmit FIFO underrun error   
//  714 *                     - SDIO_FLAG_RXOVERR:  Received FIFO overrun error    
//  715 *                     - SDIO_FLAG_CMDREND:  Command response received (CRC check 
//  716 *                                           passed)    
//  717 *                     - SDIO_FLAG_CMDSENT:  Command sent (no response required)    
//  718 *                     - SDIO_FLAG_DATAEND:  Data end (data counter, SDIDCOUNT, is
//  719 *                                           zero)    
//  720 *                     - SDIO_FLAG_STBITERR: Start bit not detected on all data 
//  721 *                                           signals in wide bus mode   
//  722 *                     - SDIO_FLAG_DBCKEND:  Data block sent/received (CRC check 
//  723 *                                           passed)         
//  724 *                     - SDIO_FLAG_SDIOIT:   SD I/O interrupt received     
//  725 *                     - SDIO_FLAG_CEATAEND: CE-ATA command completion signal 
//  726 *                                           received for CMD61    
//  727 * Output         : None
//  728 * Return         : None
//  729 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock27 Using cfiCommon0
        CFI Function SDIO_ClearFlag
        THUMB
//  730 void SDIO_ClearFlag(u32 SDIO_FLAG)
//  731 { 
//  732   /* Check the parameters */
//  733   assert_param(IS_SDIO_CLEAR_FLAG(SDIO_FLAG));
//  734    
//  735   SDIO->ICR = SDIO_FLAG;
SDIO_ClearFlag:
        LDR.N    R1,??DataTable8  ;; 0x40018038
        STR      R0,[R1, #+0]
//  736 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock27
//  737 
//  738 /*******************************************************************************
//  739 * Function Name  : SDIO_GetITStatus
//  740 * Description    : Checks whether the specified SDIO interrupt has occurred or not.	
//  741 * Input          : SDIO_IT: specifies the SDIO interrupt source to check. 
//  742 *                  This parameter can be one of the following values:
//  743 *                      - SDIO_IT_CCRCFAIL: Command response received (CRC check
//  744 *                                          failed) interrupt    
//  745 *                      - SDIO_IT_DCRCFAIL: Data block sent/received (CRC check 
//  746 *                                          failed) interrupt    
//  747 *                      - SDIO_IT_CTIMEOUT: Command response timeout interrupt    
//  748 *                      - SDIO_IT_DTIMEOUT: Data timeout interrupt    
//  749 *                      - SDIO_IT_TXUNDERR: Transmit FIFO underrun error interrupt    
//  750 *                      - SDIO_IT_RXOVERR:  Received FIFO overrun error interrupt     
//  751 *                      - SDIO_IT_CMDREND:  Command response received (CRC check 
//  752 *                                          passed) interrupt     
//  753 *                      - SDIO_IT_CMDSENT:  Command sent (no response required) 
//  754 *                                          interrupt     
//  755 *                      - SDIO_IT_DATAEND:  Data end (data counter, SDIDCOUNT, is 
//  756 *                                          zero) interrupt     
//  757 *                      - SDIO_IT_STBITERR: Start bit not detected on all data 
//  758 *                                          signals in wide bus mode interrupt    
//  759 *                      - SDIO_IT_DBCKEND:  Data block sent/received (CRC check 
//  760 *                                          passed) interrupt    
//  761 *                      - SDIO_IT_CMDACT:   Command transfer in progress interrupt     
//  762 *                      - SDIO_IT_TXACT:    Data transmit in progress interrupt       
//  763 *                      - SDIO_IT_RXACT:    Data receive in progress interrupt      
//  764 *                      - SDIO_IT_TXFIFOHE: Transmit FIFO Half Empty interrupt    
//  765 *                      - SDIO_IT_RXFIFOHF: Receive FIFO Half Full interrupt   
//  766 *                      - SDIO_IT_TXFIFOF:  Transmit FIFO full interrupt     
//  767 *                      - SDIO_IT_RXFIFOF:  Receive FIFO full interrupt     
//  768 *                      - SDIO_IT_TXFIFOE:  Transmit FIFO empty interrupt      
//  769 *                      - SDIO_IT_RXFIFOE:  Receive FIFO empty interrupt     
//  770 *                      - SDIO_IT_TXDAVL:   Data available in transmit FIFO interrupt      
//  771 *                      - SDIO_IT_RXDAVL:   Data available in receive FIFO interrupt      
//  772 *                      - SDIO_IT_SDIOIT:   SD I/O interrupt received interrupt      
//  773 *                      - SDIO_IT_CEATAEND: CE-ATA command completion signal 
//  774 *                                          received for CMD61 interrupt
//  775 * Output         : None
//  776 * Return         : The new state of SDIO_IT (SET or RESET).
//  777 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock28 Using cfiCommon0
        CFI Function SDIO_GetITStatus
        THUMB
//  778 ITStatus SDIO_GetITStatus(u32 SDIO_IT)
//  779 { 
//  780   ITStatus bitstatus = RESET;
//  781   
//  782   /* Check the parameters */
//  783   assert_param(IS_SDIO_GET_IT(SDIO_IT));
//  784 
//  785   if ((SDIO->STA & SDIO_IT) != (u32)RESET)  
SDIO_GetITStatus:
        LDR.N    R1,??DataTable7  ;; 0x40018034
        LDR      R1,[R1, #+0]
        ANDS     R0,R0,R1
        SUBS     R0,R0,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  786   {
//  787     bitstatus = SET;
//  788   }
//  789   else
//  790   {
//  791     bitstatus = RESET;
//  792   }
//  793   return bitstatus;
        BX       LR               ;; return
        CFI EndBlock cfiBlock28
//  794 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7:
        DC32     0x40018034
//  795 
//  796 /*******************************************************************************
//  797 * Function Name  : SDIO_ClearITPendingBit
//  798 * Description    : Clears the SDIO’s interrupt pending bits.	
//  799 * Input          : SDIO_IT: specifies the interrupt pending bit to clear. 
//  800 *                   This parameter can be one or a combination of the following
//  801 *                   values:
//  802 *                      - SDIO_IT_CCRCFAIL: Command response received (CRC check
//  803 *                                          failed) interrupt    
//  804 *                      - SDIO_IT_DCRCFAIL: Data block sent/received (CRC check 
//  805 *                                          failed) interrupt    
//  806 *                      - SDIO_IT_CTIMEOUT: Command response timeout interrupt    
//  807 *                      - SDIO_IT_DTIMEOUT: Data timeout interrupt    
//  808 *                      - SDIO_IT_TXUNDERR: Transmit FIFO underrun error interrupt    
//  809 *                      - SDIO_IT_RXOVERR:  Received FIFO overrun error interrupt     
//  810 *                      - SDIO_IT_CMDREND:  Command response received (CRC check 
//  811 *                                          passed) interrupt     
//  812 *                      - SDIO_IT_CMDSENT:  Command sent (no response required) 
//  813 *                                          interrupt     
//  814 *                      - SDIO_IT_DATAEND:  Data end (data counter, SDIDCOUNT, is 
//  815 *                                          zero) interrupt     
//  816 *                      - SDIO_IT_STBITERR: Start bit not detected on all data 
//  817 *                                          signals in wide bus mode interrupt          
//  818 *                      - SDIO_IT_SDIOIT:   SD I/O interrupt received interrupt      
//  819 *                      - SDIO_IT_CEATAEND: CE-ATA command completion signal 
//  820 *                                          received for CMD61 
//  821 * Output         : None
//  822 * Return         : None
//  823 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock29 Using cfiCommon0
        CFI Function SDIO_ClearITPendingBit
        THUMB
//  824 void SDIO_ClearITPendingBit(u32 SDIO_IT)
//  825 { 
//  826   /* Check the parameters */
//  827   assert_param(IS_SDIO_CLEAR_IT(SDIO_IT));
//  828    
//  829   SDIO->ICR = SDIO_IT;
SDIO_ClearITPendingBit:
        LDR.N    R1,??DataTable8  ;; 0x40018038
        STR      R0,[R1, #+0]
//  830 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock29

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     0x40018038

        END
//  831 
//  832 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
// 506 bytes in section .text
// 
// 506 bytes of CODE memory
//
//Errors: none
//Warnings: none
