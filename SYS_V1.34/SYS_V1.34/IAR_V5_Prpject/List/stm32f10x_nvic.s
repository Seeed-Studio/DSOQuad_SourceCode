///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  14:17:40 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\FWLib\src\stm32f10x_nvic.c                    /
//    Command line =  E:\DS0203\FWLib\src\stm32f10x_nvic.c -lA                /
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
//    List file    =  E:\DS0203\SYS_V1.34\IAR_V5_Prpject\List\stm32f10x_nvic. /
//                    s                                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f10x_nvic

        EXTERN __BASEPRICONFIG
        EXTERN __GetBASEPRI
        EXTERN __RESETFAULTMASK
        EXTERN __RESETPRIMASK
        EXTERN __SETFAULTMASK
        EXTERN __SETPRIMASK
        EXTERN __aeabi_memclr4

        PUBLIC NVIC_BASEPRICONFIG
        PUBLIC NVIC_ClearIRQChannelPendingBit
        PUBLIC NVIC_ClearSystemHandlerPendingBit
        PUBLIC NVIC_DeInit
        PUBLIC NVIC_GenerateCoreReset
        PUBLIC NVIC_GenerateSystemReset
        PUBLIC NVIC_GetBASEPRI
        PUBLIC NVIC_GetCPUID
        PUBLIC NVIC_GetCurrentActiveHandler
        PUBLIC NVIC_GetCurrentPendingIRQChannel
        PUBLIC NVIC_GetFaultAddress
        PUBLIC NVIC_GetFaultHandlerSources
        PUBLIC NVIC_GetIRQChannelActiveBitStatus
        PUBLIC NVIC_GetIRQChannelPendingBitStatus
        PUBLIC NVIC_GetSystemHandlerActiveBitStatus
        PUBLIC NVIC_GetSystemHandlerPendingBitStatus
        PUBLIC NVIC_Init
        PUBLIC NVIC_PriorityGroupConfig
        PUBLIC NVIC_RESETFAULTMASK
        PUBLIC NVIC_RESETPRIMASK
        PUBLIC NVIC_SCBDeInit
        PUBLIC NVIC_SETFAULTMASK
        PUBLIC NVIC_SETPRIMASK
        PUBLIC NVIC_SetIRQChannelPendingBit
        PUBLIC NVIC_SetSystemHandlerPendingBit
        PUBLIC NVIC_SetVectorTable
        PUBLIC NVIC_StructInit
        PUBLIC NVIC_SystemHandlerConfig
        PUBLIC NVIC_SystemHandlerPriorityConfig
        PUBLIC NVIC_SystemLPConfig
        
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
        
// E:\DS0203\FWLib\src\stm32f10x_nvic.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_nvic.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.0.3
//    5 * Date               : 09/22/2008
//    6 * Description        : This file provides all the NVIC firmware functions.
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
//   17 #include "stm32f10x_nvic.h"
//   18 
//   19 /* Private typedef -----------------------------------------------------------*/
//   20 /* Private define ------------------------------------------------------------*/
//   21 #define AIRCR_VECTKEY_MASK    ((u32)0x05FA0000)
//   22 
//   23 /* Private macro -------------------------------------------------------------*/
//   24 /* Private variables ---------------------------------------------------------*/
//   25 /* Private function prototypes -----------------------------------------------*/
//   26 /* Private functions ---------------------------------------------------------*/
//   27 
//   28 /*******************************************************************************
//   29 * Function Name  : NVIC_DeInit
//   30 * Description    : Deinitializes the NVIC peripheral registers to their default
//   31 *                  reset values.
//   32 * Input          : None
//   33 * Output         : None
//   34 * Return         : None
//   35 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function NVIC_DeInit
        THUMB
//   36 void NVIC_DeInit(void)
//   37 {
//   38   u32 index = 0;
//   39   
//   40   NVIC->ICER[0] = 0xFFFFFFFF;
NVIC_DeInit:
        MOV      R0,#-1
        LDR.N    R1,??DataTable8  ;; 0xe000e180
        STR      R0,[R1, #+0]
//   41   NVIC->ICER[1] = 0x0FFFFFFF;
        MVN      R1,#-268435456
        LDR.N    R2,??DataTable8  ;; 0xe000e180
        STR      R1,[R2, #+4]
//   42   NVIC->ICPR[0] = 0xFFFFFFFF;
        STR      R0,[R2, #+256]
//   43   NVIC->ICPR[1] = 0x0FFFFFFF;
        STR      R1,[R2, #+260]
//   44   
//   45   for(index = 0; index < 0x0F; index++)
//   46   {
//   47      NVIC->IPR[index] = 0x00000000;
        MOVS     R1,#+60
        ADD      R0,R2,#+640
        B.W      __aeabi_memclr4
        CFI EndBlock cfiBlock0
//   48   } 
//   49 }
//   50 
//   51 /*******************************************************************************
//   52 * Function Name  : NVIC_SCBDeInit
//   53 * Description    : Deinitializes the SCB peripheral registers to their default 
//   54 *                  reset values.
//   55 * Input          : None
//   56 * Output         : None
//   57 * Return         : None
//   58 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function NVIC_SCBDeInit
        THUMB
//   59 void NVIC_SCBDeInit(void)
//   60 {
//   61   u32 index = 0x00;
//   62   
//   63   SCB->ICSR = 0x0A000000;
NVIC_SCBDeInit:
        LDR.N    R0,??DataTable17  ;; 0xe000ed04
        MOV      R1,#+167772160
        STR      R1,[R0, #+0]
//   64   SCB->VTOR = 0x00000000;
        MOVS     R1,#+0
        STR      R1,[R0, #+4]
//   65   SCB->AIRCR = AIRCR_VECTKEY_MASK;
        LDR.N    R1,??DataTable5  ;; 0x5fa0000
        STR      R1,[R0, #+8]
//   66   SCB->SCR = 0x00000000;
        MOVS     R1,#+0
        STR      R1,[R0, #+12]
//   67   SCB->CCR = 0x00000000;
        STR      R1,[R0, #+16]
//   68   for(index = 0; index < 0x03; index++)
//   69   {
//   70      SCB->SHPR[index] = 0;
        STR      R1,[R0, #+20]
        STR      R1,[R0, #+24]
        STR      R1,[R0, #+28]
//   71   }
//   72   SCB->SHCSR = 0x00000000;
        STR      R1,[R0, #+32]
//   73   SCB->CFSR = 0xFFFFFFFF;
        MOV      R0,#-1
        LDR.N    R1,??DataTable17  ;; 0xe000ed04
        STR      R0,[R1, #+36]
//   74   SCB->HFSR = 0xFFFFFFFF;
        STR      R0,[R1, #+40]
//   75   SCB->DFSR = 0xFFFFFFFF;
        STR      R0,[R1, #+44]
//   76 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//   77 
//   78 /*******************************************************************************
//   79 * Function Name  : NVIC_PriorityGroupConfig
//   80 * Description    : Configures the priority grouping: pre-emption priority
//   81 *                  and subpriority.
//   82 * Input          : - NVIC_PriorityGroup: specifies the priority grouping bits
//   83 *                    length. This parameter can be one of the following values:
//   84 *                       - NVIC_PriorityGroup_0: 0 bits for pre-emption priority
//   85 *                         4 bits for subpriority
//   86 *                       - NVIC_PriorityGroup_1: 1 bits for pre-emption priority
//   87 *                         3 bits for subpriority
//   88 *                       - NVIC_PriorityGroup_2: 2 bits for pre-emption priority
//   89 *                         2 bits for subpriority
//   90 *                       - NVIC_PriorityGroup_3: 3 bits for pre-emption priority
//   91 *                         1 bits for subpriority
//   92 *                       - NVIC_PriorityGroup_4: 4 bits for pre-emption priority
//   93 *                         0 bits for subpriority
//   94 * Output         : None
//   95 * Return         : None
//   96 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function NVIC_PriorityGroupConfig
        THUMB
//   97 void NVIC_PriorityGroupConfig(u32 NVIC_PriorityGroup)
//   98 {
//   99   /* Check the parameters */
//  100   assert_param(IS_NVIC_PRIORITY_GROUP(NVIC_PriorityGroup));
//  101   
//  102   /* Set the PRIGROUP[10:8] bits according to NVIC_PriorityGroup value */
//  103   SCB->AIRCR = AIRCR_VECTKEY_MASK | NVIC_PriorityGroup;
NVIC_PriorityGroupConfig:
        LDR.N    R1,??DataTable5  ;; 0x5fa0000
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable14  ;; 0xe000ed0c
        STR      R0,[R1, #+0]
//  104 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable5:
        DC32     0x5fa0000
//  105 
//  106 /*******************************************************************************
//  107 * Function Name  : NVIC_Init
//  108 * Description    : Initializes the NVIC peripheral according to the specified
//  109 *                  parameters in the NVIC_InitStruct.
//  110 * Input          : - NVIC_InitStruct: pointer to a NVIC_InitTypeDef structure
//  111 *                    that contains the configuration information for the
//  112 *                    specified NVIC peripheral.
//  113 * Output         : None
//  114 * Return         : None
//  115 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function NVIC_Init
        THUMB
//  116 void NVIC_Init(NVIC_InitTypeDef* NVIC_InitStruct)
//  117 {
NVIC_Init:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
//  118   u32 tmppriority = 0x00, tmpreg = 0x00, tmpmask = 0x00;
//  119   u32 tmppre = 0, tmpsub = 0x0F;
//  120 
//  121   /* Check the parameters */
//  122   assert_param(IS_FUNCTIONAL_STATE(NVIC_InitStruct->NVIC_IRQChannelCmd));
//  123   assert_param(IS_NVIC_IRQ_CHANNEL(NVIC_InitStruct->NVIC_IRQChannel));
//  124   assert_param(IS_NVIC_PREEMPTION_PRIORITY(NVIC_InitStruct->NVIC_IRQChannelPreemptionPriority));  
//  125   assert_param(IS_NVIC_SUB_PRIORITY(NVIC_InitStruct->NVIC_IRQChannelSubPriority));
//  126     
//  127   if (NVIC_InitStruct->NVIC_IRQChannelCmd != DISABLE)
        LDRB     R3,[R0, #+0]
        LDRB     R1,[R0, #+3]
        CMP      R1,#+0
        BEQ.N    ??NVIC_Init_0
//  128   {
//  129     /* Compute the Corresponding IRQ Priority --------------------------------*/    
//  130     tmppriority = (0x700 - (SCB->AIRCR & (u32)0x700))>> 0x08;
        LDR.N    R1,??DataTable14  ;; 0xe000ed0c
        LDR      R1,[R1, #+0]
        AND      R1,R1,#0x700
        RSB      R1,R1,#+1792
        LSRS     R1,R1,#+8
//  131     tmppre = (0x4 - tmppriority);
//  132     tmpsub = tmpsub >> tmppriority;
//  133     
//  134     tmppriority = (u32)NVIC_InitStruct->NVIC_IRQChannelPreemptionPriority << tmppre;
//  135     tmppriority |=  NVIC_InitStruct->NVIC_IRQChannelSubPriority & tmpsub;
//  136 
//  137     tmppriority = tmppriority << 0x04;
//  138     tmppriority = ((u32)tmppriority) << ((NVIC_InitStruct->NVIC_IRQChannel & (u8)0x03) * 0x08);
//  139     
//  140     tmpreg = NVIC->IPR[(NVIC_InitStruct->NVIC_IRQChannel >> 0x02)];
        ASRS     R2,R3,#+2
        LDR.W    R12,??NVIC_Init_1  ;; 0xe000e400
        LDR      LR,[R12, R2, LSL #+2]
//  141     tmpmask = (u32)0xFF << ((NVIC_InitStruct->NVIC_IRQChannel & (u8)0x03) * 0x08);
        AND      R3,R3,#0x3
        LSLS     R3,R3,#+3
        MOV      R12,#+255
        LSL      R12,R12,R3
//  142     tmpreg &= ~tmpmask;
//  143     tmppriority &= tmpmask;  
//  144     tmpreg |= tmppriority;
//  145 
//  146     NVIC->IPR[(NVIC_InitStruct->NVIC_IRQChannel >> 0x02)] = tmpreg;
        MVN      R4,R12
        AND      LR,R4,LR
        LDRB     R4,[R0, #+1]
        MOVS     R5,R1
        RSB      R5,R5,#+4
        LSLS     R4,R4,R5
        LDRB     R5,[R0, #+2]
        MOVS     R6,#+15
        LSR      R1,R6,R1
        ANDS     R1,R1,R5
        ORRS     R1,R1,R4
        LSLS     R1,R1,#+4
        LSLS     R1,R1,R3
        AND      R1,R12,R1
        ORR      R1,R1,LR
        LDR.N    R3,??NVIC_Init_1  ;; 0xe000e400
        STR      R1,[R3, R2, LSL #+2]
//  147     
//  148     /* Enable the Selected IRQ Channels --------------------------------------*/
//  149     NVIC->ISER[(NVIC_InitStruct->NVIC_IRQChannel >> 0x05)] =
//  150       (u32)0x01 << (NVIC_InitStruct->NVIC_IRQChannel & (u8)0x1F);
        LDRB     R0,[R0, #+0]
        ASRS     R1,R0,#+5
        LDR.N    R2,??NVIC_Init_1+0x4  ;; 0xe000e100
        MOVS     R3,#+1
        AND      R0,R0,#0x1F
        LSL      R0,R3,R0
        STR      R0,[R2, R1, LSL #+2]
        POP      {R4-R6,PC}
//  151   }
//  152   else
//  153   {
//  154     /* Disable the Selected IRQ Channels -------------------------------------*/
//  155     NVIC->ICER[(NVIC_InitStruct->NVIC_IRQChannel >> 0x05)] =
//  156       (u32)0x01 << (NVIC_InitStruct->NVIC_IRQChannel & (u8)0x1F);
??NVIC_Init_0:
        ASRS     R0,R3,#+5
        LDR.N    R1,??DataTable8  ;; 0xe000e180
        MOVS     R2,#+1
        AND      R3,R3,#0x1F
        LSLS     R2,R2,R3
        STR      R2,[R1, R0, LSL #+2]
//  157   }
//  158 }
??NVIC_Init_2:
        POP      {R4-R6,PC}       ;; return
        DATA
??NVIC_Init_1:
        DC32     0xe000e400
        DC32     0xe000e100
        CFI EndBlock cfiBlock3

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     0xe000e180
//  159 
//  160 /*******************************************************************************
//  161 * Function Name  : NVIC_StructInit
//  162 * Description    : Fills each NVIC_InitStruct member with its default value.
//  163 * Input          : - NVIC_InitStruct: pointer to a NVIC_InitTypeDef structure which
//  164 *                    will be initialized.
//  165 * Output         : None
//  166 * Return         : None
//  167 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function NVIC_StructInit
        THUMB
//  168 void NVIC_StructInit(NVIC_InitTypeDef* NVIC_InitStruct)
//  169 {
//  170   /* NVIC_InitStruct members default value */
//  171   NVIC_InitStruct->NVIC_IRQChannel = 0x00;
NVIC_StructInit:
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  172   NVIC_InitStruct->NVIC_IRQChannelPreemptionPriority = 0x00;
        STRB     R1,[R0, #+1]
//  173   NVIC_InitStruct->NVIC_IRQChannelSubPriority = 0x00;
        STRB     R1,[R0, #+2]
//  174   NVIC_InitStruct->NVIC_IRQChannelCmd = DISABLE;
        STRB     R1,[R0, #+3]
//  175 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  176 
//  177 /*******************************************************************************
//  178 * Function Name  : NVIC_SETPRIMASK
//  179 * Description    : Enables the PRIMASK priority: Raises the execution priority to 0.
//  180 * Input          : None
//  181 * Output         : None
//  182 * Return         : None
//  183 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function NVIC_SETPRIMASK
        THUMB
//  184 void NVIC_SETPRIMASK(void)
//  185 {
//  186   __SETPRIMASK();
NVIC_SETPRIMASK:
        B.W      __SETPRIMASK
        CFI EndBlock cfiBlock5
//  187 }
//  188 
//  189 /*******************************************************************************
//  190 * Function Name  : NVIC_RESETPRIMASK
//  191 * Description    : Disables the PRIMASK priority.
//  192 * Input          : None
//  193 * Output         : None
//  194 * Return         : None
//  195 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function NVIC_RESETPRIMASK
        THUMB
//  196 void NVIC_RESETPRIMASK(void)
//  197 {
//  198   __RESETPRIMASK();
NVIC_RESETPRIMASK:
        B.W      __RESETPRIMASK
        CFI EndBlock cfiBlock6
//  199 }
//  200 
//  201 /*******************************************************************************
//  202 * Function Name  : NVIC_SETFAULTMASK
//  203 * Description    : Enables the FAULTMASK priority: Raises the execution priority to -1.
//  204 * Input          : None
//  205 * Output         : None
//  206 * Return         : None
//  207 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function NVIC_SETFAULTMASK
        THUMB
//  208 void NVIC_SETFAULTMASK(void)
//  209 {
//  210   __SETFAULTMASK();
NVIC_SETFAULTMASK:
        B.W      __SETFAULTMASK
        CFI EndBlock cfiBlock7
//  211 }
//  212 
//  213 /*******************************************************************************
//  214 * Function Name  : NVIC_RESETFAULTMASK
//  215 * Description    : Disables the FAULTMASK priority.
//  216 * Input          : None
//  217 * Output         : None
//  218 * Return         : None
//  219 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function NVIC_RESETFAULTMASK
        THUMB
//  220 void NVIC_RESETFAULTMASK(void)
//  221 {
//  222   __RESETFAULTMASK();
NVIC_RESETFAULTMASK:
        B.W      __RESETFAULTMASK
        CFI EndBlock cfiBlock8
//  223 }
//  224 
//  225 /*******************************************************************************
//  226 * Function Name  : NVIC_BASEPRICONFIG
//  227 * Description    : The execution priority can be changed from 15 (lowest 
//  228                    configurable priority) to 1. Writing a zero  value will disable 
//  229 *                  the mask of execution priority.
//  230 * Input          : None
//  231 * Output         : None
//  232 * Return         : None
//  233 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function NVIC_BASEPRICONFIG
        THUMB
//  234 void NVIC_BASEPRICONFIG(u32 NewPriority)
//  235 {
//  236   /* Check the parameters */
//  237   assert_param(IS_NVIC_BASE_PRI(NewPriority));
//  238   
//  239   __BASEPRICONFIG(NewPriority << 0x04);
NVIC_BASEPRICONFIG:
        LSLS     R0,R0,#+4
        B.W      __BASEPRICONFIG
        CFI EndBlock cfiBlock9
//  240 }
//  241 
//  242 /*******************************************************************************
//  243 * Function Name  : NVIC_GetBASEPRI
//  244 * Description    : Returns the BASEPRI mask value.
//  245 * Input          : None
//  246 * Output         : None
//  247 * Return         : BASEPRI register value
//  248 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function NVIC_GetBASEPRI
        THUMB
//  249 u32 NVIC_GetBASEPRI(void)
//  250 {
//  251   return (__GetBASEPRI());
NVIC_GetBASEPRI:
        B.W      __GetBASEPRI
        CFI EndBlock cfiBlock10
//  252 }
//  253 
//  254 /*******************************************************************************
//  255 * Function Name  : NVIC_GetCurrentPendingIRQChannel
//  256 * Description    : Returns the current pending IRQ channel identifier.
//  257 * Input          : None
//  258 * Output         : None
//  259 * Return         : Pending IRQ Channel Identifier.
//  260 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function NVIC_GetCurrentPendingIRQChannel
        THUMB
//  261 u16 NVIC_GetCurrentPendingIRQChannel(void)
//  262 {
//  263   return ((u16)((SCB->ICSR & (u32)0x003FF000) >> 0x0C));
NVIC_GetCurrentPendingIRQChannel:
        LDR.N    R0,??DataTable17  ;; 0xe000ed04
        LDR      R0,[R0, #+0]
        LDR.N    R1,??NVIC_GetCurrentPendingIRQChannel_0  ;; 0x3ff000
        ANDS     R0,R1,R0
        LSRS     R0,R0,#+12
        BX       LR               ;; return
        DATA
??NVIC_GetCurrentPendingIRQChannel_0:
        DC32     0x3ff000
        CFI EndBlock cfiBlock11
//  264 }
//  265 
//  266 /*******************************************************************************
//  267 * Function Name  : NVIC_GetIRQChannelPendingBitStatus
//  268 * Description    : Checks whether the specified IRQ Channel pending bit is set
//  269 *                  or not.
//  270 * Input          : - NVIC_IRQChannel: specifies the interrupt pending bit to check.
//  271 * Output         : None
//  272 * Return         : The new state of IRQ Channel pending bit(SET or RESET).
//  273 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function NVIC_GetIRQChannelPendingBitStatus
        THUMB
//  274 ITStatus NVIC_GetIRQChannelPendingBitStatus(u8 NVIC_IRQChannel)
//  275 {
//  276   ITStatus pendingirqstatus = RESET;
//  277   u32 tmp = 0x00;
//  278   
//  279   /* Check the parameters */
//  280   assert_param(IS_NVIC_IRQ_CHANNEL(NVIC_IRQChannel));
//  281   
//  282   tmp = ((u32)0x01 << (NVIC_IRQChannel & (u32)0x1F));
NVIC_GetIRQChannelPendingBitStatus:
        MOVS     R1,#+1
        AND      R2,R0,#0x1F
        LSLS     R1,R1,R2
//  283 
//  284   if (((NVIC->ISPR[(NVIC_IRQChannel >> 0x05)]) & tmp) == tmp)
        ASRS     R0,R0,#+5
        LDR.N    R2,??NVIC_GetIRQChannelPendingBitStatus_0  ;; 0xe000e200
        LDR      R0,[R2, R0, LSL #+2]
        ANDS     R0,R1,R0
        CMP      R0,R1
        BNE.N    ??NVIC_GetIRQChannelPendingBitStatus_1
//  285   {
//  286     pendingirqstatus = SET;
        MOVS     R0,#+1
        BX       LR
//  287   }
//  288   else
//  289   {
//  290     pendingirqstatus = RESET;
??NVIC_GetIRQChannelPendingBitStatus_1:
        MOVS     R0,#+0
//  291   }
//  292   return pendingirqstatus;
??NVIC_GetIRQChannelPendingBitStatus_2:
        BX       LR               ;; return
        Nop      
        DATA
??NVIC_GetIRQChannelPendingBitStatus_0:
        DC32     0xe000e200
        CFI EndBlock cfiBlock12
//  293 }
//  294 
//  295 /*******************************************************************************
//  296 * Function Name  : NVIC_SetIRQChannelPendingBit
//  297 * Description    : Sets the NVIC’s interrupt pending bit.
//  298 * Input          : - NVIC_IRQChannel: specifies the interrupt pending bit to Set.
//  299 * Output         : None
//  300 * Return         : None
//  301 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function NVIC_SetIRQChannelPendingBit
        THUMB
//  302 void NVIC_SetIRQChannelPendingBit(u8 NVIC_IRQChannel)
//  303 {
//  304   /* Check the parameters */
//  305   assert_param(IS_NVIC_IRQ_CHANNEL(NVIC_IRQChannel));
//  306   
//  307   *(vu32*) 0xE000EF00 = (u32)NVIC_IRQChannel;
NVIC_SetIRQChannelPendingBit:
        LDR.N    R1,??NVIC_SetIRQChannelPendingBit_0  ;; 0xe000ef00
        STR      R0,[R1, #+0]
//  308 }
        BX       LR               ;; return
        Nop      
        DATA
??NVIC_SetIRQChannelPendingBit_0:
        DC32     0xe000ef00
        CFI EndBlock cfiBlock13
//  309 
//  310 /*******************************************************************************
//  311 * Function Name  : NVIC_ClearIRQChannelPendingBit
//  312 * Description    : Clears the NVIC’s interrupt pending bit.
//  313 * Input          : - NVIC_IRQChannel: specifies the interrupt pending bit to clear.
//  314 * Output         : None
//  315 * Return         : None
//  316 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function NVIC_ClearIRQChannelPendingBit
        THUMB
//  317 void NVIC_ClearIRQChannelPendingBit(u8 NVIC_IRQChannel)
//  318 {
//  319   /* Check the parameters */
//  320   assert_param(IS_NVIC_IRQ_CHANNEL(NVIC_IRQChannel));
//  321   
//  322   NVIC->ICPR[(NVIC_IRQChannel >> 0x05)] = (u32)0x01 << (NVIC_IRQChannel & (u32)0x1F);
NVIC_ClearIRQChannelPendingBit:
        ASRS     R1,R0,#+5
        LDR.N    R2,??NVIC_ClearIRQChannelPendingBit_0  ;; 0xe000e280
        MOVS     R3,#+1
        AND      R0,R0,#0x1F
        LSL      R0,R3,R0
        STR      R0,[R2, R1, LSL #+2]
//  323 }
        BX       LR               ;; return
        DATA
??NVIC_ClearIRQChannelPendingBit_0:
        DC32     0xe000e280
        CFI EndBlock cfiBlock14
//  324 
//  325 /*******************************************************************************
//  326 * Function Name  : NVIC_GetCurrentActiveHandler
//  327 * Description    : Returns the current active Handler (IRQ Channel and
//  328 *                  SystemHandler) identifier.
//  329 * Input          : None
//  330 * Output         : None
//  331 * Return         : Active Handler Identifier.
//  332 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function NVIC_GetCurrentActiveHandler
        THUMB
//  333 u16 NVIC_GetCurrentActiveHandler(void)
//  334 {
//  335   return ((u16)(SCB->ICSR & (u32)0x3FF));
NVIC_GetCurrentActiveHandler:
        LDR.N    R0,??DataTable17  ;; 0xe000ed04
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+22
        LSRS     R0,R0,#+22
        BX       LR               ;; return
        CFI EndBlock cfiBlock15
//  336 }
//  337 
//  338 /*******************************************************************************
//  339 * Function Name  : NVIC_GetIRQChannelActiveBitStatus
//  340 * Description    : Checks whether the specified IRQ Channel active bit is set
//  341 *                  or not.
//  342 * Input          : - NVIC_IRQChannel: specifies the interrupt active bit to check.
//  343 * Output         : None
//  344 * Return         : The new state of IRQ Channel active bit(SET or RESET).
//  345 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function NVIC_GetIRQChannelActiveBitStatus
        THUMB
//  346 ITStatus NVIC_GetIRQChannelActiveBitStatus(u8 NVIC_IRQChannel)
//  347 {
//  348   ITStatus activeirqstatus = RESET;
//  349   u32 tmp = 0x00;
//  350 
//  351   /* Check the parameters */
//  352   assert_param(IS_NVIC_IRQ_CHANNEL(NVIC_IRQChannel));
//  353   
//  354   tmp = ((u32)0x01 << (NVIC_IRQChannel & (u32)0x1F));
NVIC_GetIRQChannelActiveBitStatus:
        MOVS     R1,#+1
        AND      R2,R0,#0x1F
        LSLS     R1,R1,R2
//  355 
//  356   if (((NVIC->IABR[(NVIC_IRQChannel >> 0x05)]) & tmp) == tmp )
        ASRS     R0,R0,#+5
        LDR.N    R2,??NVIC_GetIRQChannelActiveBitStatus_0  ;; 0xe000e300
        LDR      R0,[R2, R0, LSL #+2]
        ANDS     R0,R1,R0
        CMP      R0,R1
        BNE.N    ??NVIC_GetIRQChannelActiveBitStatus_1
//  357   {
//  358     activeirqstatus = SET;
        MOVS     R0,#+1
        BX       LR
//  359   }
//  360   else
//  361   {
//  362     activeirqstatus = RESET;
??NVIC_GetIRQChannelActiveBitStatus_1:
        MOVS     R0,#+0
//  363   }
//  364   return activeirqstatus;
??NVIC_GetIRQChannelActiveBitStatus_2:
        BX       LR               ;; return
        Nop      
        DATA
??NVIC_GetIRQChannelActiveBitStatus_0:
        DC32     0xe000e300
        CFI EndBlock cfiBlock16
//  365 }
//  366 
//  367 /*******************************************************************************
//  368 * Function Name  : NVIC_GetCPUID
//  369 * Description    : Returns the ID number, the version number and the implementation
//  370 *                  details of the Cortex-M3 core.
//  371 * Input          : None
//  372 * Output         : None
//  373 * Return         : CPU ID.
//  374 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function NVIC_GetCPUID
        THUMB
//  375 u32 NVIC_GetCPUID(void)
//  376 {
//  377   return (SCB->CPUID);
NVIC_GetCPUID:
        LDR.N    R0,??NVIC_GetCPUID_0  ;; 0xe000ed00
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
        Nop      
        DATA
??NVIC_GetCPUID_0:
        DC32     0xe000ed00
        CFI EndBlock cfiBlock17
//  378 }
//  379 
//  380 /*******************************************************************************
//  381 * Function Name  : NVIC_SetVectorTable
//  382 * Description    : Sets the vector table location and Offset.
//  383 * Input          : - NVIC_VectTab: specifies if the vector table is in RAM or
//  384 *                    FLASH memory.
//  385 *                    This parameter can be one of the following values:
//  386 *                       - NVIC_VectTab_RAM
//  387 *                       - NVIC_VectTab_FLASH
//  388 *                  - Offset: Vector Table base offset field. 
//  389 *                            This value must be a multiple of 0x100.
//  390 * Output         : None
//  391 * Return         : None
//  392 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function NVIC_SetVectorTable
        THUMB
//  393 void NVIC_SetVectorTable(u32 NVIC_VectTab, u32 Offset)
//  394 { 
//  395   /* Check the parameters */
//  396   assert_param(IS_NVIC_VECTTAB(NVIC_VectTab));
//  397   assert_param(IS_NVIC_OFFSET(Offset));  
//  398    
//  399   SCB->VTOR = NVIC_VectTab | (Offset & (u32)0x1FFFFF80);
NVIC_SetVectorTable:
        LDR.N    R2,??NVIC_SetVectorTable_0  ;; 0x1fffff80
        ANDS     R1,R2,R1
        ORRS     R0,R1,R0
        LDR.N    R1,??NVIC_SetVectorTable_0+0x4  ;; 0xe000ed08
        STR      R0,[R1, #+0]
//  400 }
        BX       LR               ;; return
        DATA
??NVIC_SetVectorTable_0:
        DC32     0x1fffff80
        DC32     0xe000ed08
        CFI EndBlock cfiBlock18
//  401 
//  402 /*******************************************************************************
//  403 * Function Name  : NVIC_GenerateSystemReset
//  404 * Description    : Generates a system reset.
//  405 * Input          : None
//  406 * Output         : None
//  407 * Return         : None
//  408 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI Function NVIC_GenerateSystemReset
        THUMB
//  409 void NVIC_GenerateSystemReset(void)
//  410 {
//  411   SCB->AIRCR = AIRCR_VECTKEY_MASK | (u32)0x04;
NVIC_GenerateSystemReset:
        LDR.N    R0,??DataTable14  ;; 0xe000ed0c
        LDR.N    R1,??NVIC_GenerateSystemReset_0  ;; 0x5fa0004
        STR      R1,[R0, #+0]
//  412 }
        BX       LR               ;; return
        DATA
??NVIC_GenerateSystemReset_0:
        DC32     0x5fa0004
        CFI EndBlock cfiBlock19
//  413 
//  414 /*******************************************************************************
//  415 * Function Name  : NVIC_GenerateCoreReset
//  416 * Description    : Generates a Core (Core + NVIC) reset.
//  417 * Input          : None
//  418 * Output         : None
//  419 * Return         : None
//  420 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock20 Using cfiCommon0
        CFI Function NVIC_GenerateCoreReset
        THUMB
//  421 void NVIC_GenerateCoreReset(void)
//  422 {
//  423   SCB->AIRCR = AIRCR_VECTKEY_MASK | (u32)0x01;
NVIC_GenerateCoreReset:
        LDR.N    R0,??DataTable14  ;; 0xe000ed0c
        LDR.N    R1,??NVIC_GenerateCoreReset_0  ;; 0x5fa0001
        STR      R1,[R0, #+0]
//  424 }
        BX       LR               ;; return
        DATA
??NVIC_GenerateCoreReset_0:
        DC32     0x5fa0001
        CFI EndBlock cfiBlock20
//  425 
//  426 /*******************************************************************************
//  427 * Function Name  : NVIC_SystemLPConfig
//  428 * Description    : Selects the condition for the system to enter low power mode.
//  429 * Input          : - LowPowerMode: Specifies the new mode for the system to enter
//  430 *                    low power mode.
//  431 *                    This parameter can be one of the following values:
//  432 *                       - NVIC_LP_SEVONPEND
//  433 *                       - NVIC_LP_SLEEPDEEP
//  434 *                       - NVIC_LP_SLEEPONEXIT
//  435 *                  - NewState: new state of LP condition.
//  436 *                    This parameter can be: ENABLE or DISABLE.
//  437 * Output         : None
//  438 * Return         : None
//  439 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock21 Using cfiCommon0
        CFI Function NVIC_SystemLPConfig
        THUMB
//  440 void NVIC_SystemLPConfig(u8 LowPowerMode, FunctionalState NewState)
//  441 {
//  442   /* Check the parameters */
//  443   assert_param(IS_NVIC_LP(LowPowerMode));
//  444   assert_param(IS_FUNCTIONAL_STATE(NewState));  
//  445   
//  446   if (NewState != DISABLE)
NVIC_SystemLPConfig:
        LDR.N    R2,??NVIC_SystemLPConfig_0  ;; 0xe000ed10
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        BEQ.N    ??NVIC_SystemLPConfig_1
//  447   {
//  448     SCB->SCR |= LowPowerMode;
        ORRS     R0,R0,R1
        B.N      ??NVIC_SystemLPConfig_2
//  449   }
//  450   else
//  451   {
//  452     SCB->SCR &= (u32)(~(u32)LowPowerMode);
??NVIC_SystemLPConfig_1:
        MVNS     R0,R0
        ANDS     R0,R0,R1
??NVIC_SystemLPConfig_2:
        STR      R0,[R2, #+0]
//  453   }
//  454 }
        BX       LR               ;; return
        DATA
??NVIC_SystemLPConfig_0:
        DC32     0xe000ed10
        CFI EndBlock cfiBlock21
//  455 
//  456 /*******************************************************************************
//  457 * Function Name  : NVIC_SystemHandlerConfig
//  458 * Description    : Enables or disables the specified System Handlers.
//  459 * Input          : - SystemHandler: specifies the system handler to be enabled
//  460 *                    or disabled.
//  461 *                    This parameter can be one of the following values:
//  462 *                       - SystemHandler_MemoryManage
//  463 *                       - SystemHandler_BusFault
//  464 *                       - SystemHandler_UsageFault
//  465 *                  - NewState: new state of  specified System Handlers.
//  466 *                    This parameter can be: ENABLE or DISABLE.
//  467 * Output         : None
//  468 * Return         : None
//  469 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock22 Using cfiCommon0
        CFI Function NVIC_SystemHandlerConfig
        THUMB
//  470 void NVIC_SystemHandlerConfig(u32 SystemHandler, FunctionalState NewState)
//  471 {
//  472   u32 tmpreg = 0x00;
//  473 
//  474   /* Check the parameters */
//  475   assert_param(IS_CONFIG_SYSTEM_HANDLER(SystemHandler));
//  476   assert_param(IS_FUNCTIONAL_STATE(NewState)); 
//  477   
//  478   tmpreg =  (u32)0x01 << (SystemHandler & (u32)0x1F);
NVIC_SystemHandlerConfig:
        MOVS     R2,#+1
        AND      R0,R0,#0x1F
        LSL      R0,R2,R0
//  479 
//  480   if (NewState != DISABLE)
        LDR.N    R2,??DataTable18  ;; 0xe000ed24
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        BEQ.N    ??NVIC_SystemHandlerConfig_0
//  481   {
//  482     SCB->SHCSR |= tmpreg;
        ORRS     R0,R0,R1
        B.N      ??NVIC_SystemHandlerConfig_1
//  483   }
//  484   else
//  485   {
//  486     SCB->SHCSR &= ~tmpreg;
??NVIC_SystemHandlerConfig_0:
        MVNS     R0,R0
        ANDS     R0,R0,R1
??NVIC_SystemHandlerConfig_1:
        STR      R0,[R2, #+0]
//  487   }
//  488 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock22
//  489 
//  490 /*******************************************************************************
//  491 * Function Name  : NVIC_SystemHandlerPriorityConfig
//  492 * Description    : Configures the specified System Handlers priority.
//  493 * Input          : - SystemHandler: specifies the system handler to be
//  494 *                    enabled or disabled.
//  495 *                    This parameter can be one of the following values:
//  496 *                       - SystemHandler_MemoryManage
//  497 *                       - SystemHandler_BusFault
//  498 *                       - SystemHandler_UsageFault
//  499 *                       - SystemHandler_SVCall
//  500 *                       - SystemHandler_DebugMonitor
//  501 *                       - SystemHandler_PSV
//  502 *                       - SystemHandler_SysTick
//  503 *                  - SystemHandlerPreemptionPriority: new priority group of the
//  504 *                    specified system handlers.
//  505 *                  - SystemHandlerSubPriority: new sub priority of the specified
//  506 *                    system handlers.
//  507 * Output         : None
//  508 * Return         : None
//  509 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock23 Using cfiCommon0
        CFI Function NVIC_SystemHandlerPriorityConfig
        THUMB
//  510 void NVIC_SystemHandlerPriorityConfig(u32 SystemHandler, u8 SystemHandlerPreemptionPriority,
//  511                                       u8 SystemHandlerSubPriority)
//  512 {
NVIC_SystemHandlerPriorityConfig:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  513   u32 tmp1 = 0x00, tmp2 = 0xFF, handlermask = 0x00;
//  514   u32 tmppriority = 0x00;
//  515 
//  516   /* Check the parameters */
//  517   assert_param(IS_PRIORITY_SYSTEM_HANDLER(SystemHandler));
//  518   assert_param(IS_NVIC_PREEMPTION_PRIORITY(SystemHandlerPreemptionPriority));  
//  519   assert_param(IS_NVIC_SUB_PRIORITY(SystemHandlerSubPriority));
//  520     
//  521   tmppriority = (0x700 - (SCB->AIRCR & (u32)0x700))>> 0x08;
        LDR.N    R3,??DataTable14  ;; 0xe000ed0c
        LDR      R3,[R3, #+0]
        AND      R3,R3,#0x700
        RSB      R3,R3,#+1792
        LSRS     R3,R3,#+8
//  522   tmp1 = (0x4 - tmppriority);
//  523   tmp2 = tmp2 >> tmppriority;
//  524     
//  525   tmppriority = (u32)SystemHandlerPreemptionPriority << tmp1;
//  526   tmppriority |=  SystemHandlerSubPriority & tmp2;
//  527 
//  528   tmppriority = tmppriority << 0x04;
//  529   tmp1 = SystemHandler & (u32)0xC0;
//  530   tmp1 = tmp1 >> 0x06; 
        AND      R12,R0,#0xC0
        LSR      R12,R12,#+6
//  531   tmp2 = (SystemHandler >> 0x08) & (u32)0x03;
        LSRS     R0,R0,#+8
        AND      R0,R0,#0x3
//  532   tmppriority = tmppriority << (tmp2 * 0x08);
//  533   handlermask = (u32)0xFF << (tmp2 * 0x08);
//  534   
//  535   SCB->SHPR[tmp1] &= ~handlermask;
        LSLS     R0,R0,#+3
        LDR.W    LR,??NVIC_SystemHandlerPriorityConfig_0  ;; 0xe000ed18
        LDR      LR,[LR, R12, LSL #+2]
        MOVS     R4,#+255
        LSLS     R4,R4,R0
        MVNS     R4,R4
        AND      LR,R4,LR
        LDR.N    R4,??NVIC_SystemHandlerPriorityConfig_0  ;; 0xe000ed18
        STR      LR,[R4, R12, LSL #+2]
//  536   SCB->SHPR[tmp1] |= tmppriority;
        LDR      LR,[R4, R12, LSL #+2]
        MOVS     R4,R3
        RSB      R4,R4,#+4
        LSLS     R1,R1,R4
        MOVS     R4,#+255
        LSR      R3,R4,R3
        ANDS     R2,R3,R2
        ORRS     R1,R2,R1
        LSLS     R1,R1,#+4
        LSL      R0,R1,R0
        ORR      R0,R0,LR
        LDR.N    R1,??NVIC_SystemHandlerPriorityConfig_0  ;; 0xe000ed18
        STR      R0,[R1, R12, LSL #+2]
//  537 }
        POP      {R4,PC}          ;; return
        DATA
??NVIC_SystemHandlerPriorityConfig_0:
        DC32     0xe000ed18
        CFI EndBlock cfiBlock23

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14:
        DC32     0xe000ed0c
//  538 
//  539 /*******************************************************************************
//  540 * Function Name  : NVIC_GetSystemHandlerPendingBitStatus
//  541 * Description    : Checks whether the specified System handlers pending bit is
//  542 *                  set or not.
//  543 * Input          : - SystemHandler: specifies the system handler pending bit to
//  544 *                    check.
//  545 *                    This parameter can be one of the following values:
//  546 *                       - SystemHandler_MemoryManage
//  547 *                       - SystemHandler_BusFault
//  548 *                       - SystemHandler_SVCall
//  549 * Output         : None
//  550 * Return         : The new state of System Handler pending bit(SET or RESET).
//  551 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock24 Using cfiCommon0
        CFI Function NVIC_GetSystemHandlerPendingBitStatus
        THUMB
//  552 ITStatus NVIC_GetSystemHandlerPendingBitStatus(u32 SystemHandler)
//  553 {
//  554   ITStatus bitstatus  = RESET;
//  555   u32 tmp = 0x00, tmppos = 0x00;
//  556 
//  557   /* Check the parameters */
//  558   assert_param(IS_GET_PENDING_SYSTEM_HANDLER(SystemHandler));
//  559   
//  560   tmppos = (SystemHandler >> 0x0A);
//  561   tmppos &= (u32)0x0F;
//  562 
//  563   tmppos = (u32)0x01 << tmppos;
NVIC_GetSystemHandlerPendingBitStatus:
        MOVS     R1,#+1
        LSRS     R0,R0,#+10
        AND      R0,R0,#0xF
        LSL      R0,R1,R0
//  564 
//  565   tmp = SCB->SHCSR & tmppos;
        LDR.N    R1,??DataTable18  ;; 0xe000ed24
        LDR      R1,[R1, #+0]
        ANDS     R1,R0,R1
//  566 
//  567   if (tmp == tmppos)
        CMP      R1,R0
        BNE.N    ??NVIC_GetSystemHandlerPendingBitStatus_0
//  568   {
//  569     bitstatus = SET;
        MOVS     R0,#+1
        BX       LR
//  570   }
//  571   else
//  572   {
//  573     bitstatus = RESET;
??NVIC_GetSystemHandlerPendingBitStatus_0:
        MOVS     R0,#+0
//  574   }
//  575   return bitstatus;
??NVIC_GetSystemHandlerPendingBitStatus_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock24
//  576 }
//  577 
//  578 /*******************************************************************************
//  579 * Function Name  : NVIC_SetSystemHandlerPendingBit
//  580 * Description    : Sets System Handler pending bit.
//  581 * Input          : - SystemHandler: specifies the system handler pending bit
//  582 *                    to be set.
//  583 *                    This parameter can be one of the following values:
//  584 *                       - SystemHandler_NMI
//  585 *                       - SystemHandler_PSV
//  586 *                       - SystemHandler_SysTick
//  587 * Output         : None
//  588 * Return         : None
//  589 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock25 Using cfiCommon0
        CFI Function NVIC_SetSystemHandlerPendingBit
        THUMB
//  590 void NVIC_SetSystemHandlerPendingBit(u32 SystemHandler)
//  591 {
//  592   u32 tmp = 0x00;
//  593 
//  594   /* Check the parameters */
//  595   assert_param(IS_SET_PENDING_SYSTEM_HANDLER(SystemHandler));
//  596   
//  597   /* Get the System Handler pending bit position */
//  598   tmp = SystemHandler & (u32)0x1F;
//  599   /* Set the corresponding System Handler pending bit */
//  600   SCB->ICSR |= ((u32)0x01 << tmp);
NVIC_SetSystemHandlerPendingBit:
        LDR.N    R1,??DataTable17  ;; 0xe000ed04
        LDR      R2,[R1, #+0]
        MOVS     R3,#+1
        AND      R0,R0,#0x1F
        LSL      R0,R3,R0
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
//  601 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock25
//  602 
//  603 /*******************************************************************************
//  604 * Function Name  : NVIC_ClearSystemHandlerPendingBit
//  605 * Description    : Clears System Handler pending bit.
//  606 * Input          : - SystemHandler: specifies the system handler pending bit to
//  607 *                    be clear.
//  608 *                    This parameter can be one of the following values:
//  609 *                       - SystemHandler_PSV
//  610 *                       - SystemHandler_SysTick
//  611 * Output         : None
//  612 * Return         : None
//  613 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock26 Using cfiCommon0
        CFI Function NVIC_ClearSystemHandlerPendingBit
        THUMB
//  614 void NVIC_ClearSystemHandlerPendingBit(u32 SystemHandler)
//  615 {
//  616   u32 tmp = 0x00;
//  617 
//  618   /* Check the parameters */
//  619   assert_param(IS_CLEAR_SYSTEM_HANDLER(SystemHandler));
//  620   
//  621   /* Get the System Handler pending bit position */
//  622   tmp = SystemHandler & (u32)0x1F;
//  623   /* Clear the corresponding System Handler pending bit */
//  624   SCB->ICSR |= ((u32)0x01 << (tmp - 0x01));
NVIC_ClearSystemHandlerPendingBit:
        LDR.N    R1,??DataTable17  ;; 0xe000ed04
        LDR      R2,[R1, #+0]
        MOVS     R3,#+1
        AND      R0,R0,#0x1F
        SUBS     R0,R0,#+1
        LSL      R0,R3,R0
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
//  625 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock26

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable17:
        DC32     0xe000ed04
//  626 
//  627 /*******************************************************************************
//  628 * Function Name  : NVIC_GetSystemHandlerActiveBitStatus
//  629 * Description    : Checks whether the specified System handlers active bit is
//  630 *                  set or not.
//  631 * Input          : - SystemHandler: specifies the system handler active bit to
//  632 *                    check.
//  633 *                    This parameter can be one of the following values:
//  634 *                       - SystemHandler_MemoryManage
//  635 *                       - SystemHandler_BusFault
//  636 *                       - SystemHandler_UsageFault
//  637 *                       - SystemHandler_SVCall
//  638 *                       - SystemHandler_DebugMonitor
//  639 *                       - SystemHandler_PSV
//  640 *                       - SystemHandler_SysTick
//  641 * Output         : None
//  642 * Return         : The new state of System Handler active bit(SET or RESET).
//  643 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock27 Using cfiCommon0
        CFI Function NVIC_GetSystemHandlerActiveBitStatus
        THUMB
//  644 ITStatus NVIC_GetSystemHandlerActiveBitStatus(u32 SystemHandler)
//  645 {
//  646   ITStatus bitstatus  = RESET;
//  647 
//  648   u32 tmp = 0x00, tmppos = 0x00;
//  649 
//  650   /* Check the parameters */
//  651   assert_param(IS_GET_ACTIVE_SYSTEM_HANDLER(SystemHandler));
//  652   
//  653   tmppos = (SystemHandler >> 0x0E) & (u32)0x0F;
//  654 
//  655   tmppos = (u32)0x01 << tmppos;
NVIC_GetSystemHandlerActiveBitStatus:
        MOVS     R1,#+1
        LSRS     R0,R0,#+14
        AND      R0,R0,#0xF
        LSL      R0,R1,R0
//  656 
//  657   tmp = SCB->SHCSR & tmppos;
        LDR.N    R1,??DataTable18  ;; 0xe000ed24
        LDR      R1,[R1, #+0]
        ANDS     R1,R0,R1
//  658 
//  659   if (tmp == tmppos)
        CMP      R1,R0
        BNE.N    ??NVIC_GetSystemHandlerActiveBitStatus_0
//  660   {
//  661     bitstatus = SET;
        MOVS     R0,#+1
        BX       LR
//  662   }
//  663   else
//  664   {
//  665     bitstatus = RESET;
??NVIC_GetSystemHandlerActiveBitStatus_0:
        MOVS     R0,#+0
//  666   }
//  667   return bitstatus;
??NVIC_GetSystemHandlerActiveBitStatus_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock27
//  668 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable18:
        DC32     0xe000ed24
//  669 
//  670 /*******************************************************************************
//  671 * Function Name  : NVIC_GetFaultHandlerSources
//  672 * Description    : Returns the system fault handlers sources.
//  673 * Input          : - SystemHandler: specifies the system handler to get its fault
//  674 *                    sources.
//  675 *                    This parameter can be one of the following values:
//  676 *                       - SystemHandler_HardFault
//  677 *                       - SystemHandler_MemoryManage
//  678 *                       - SystemHandler_BusFault
//  679 *                       - SystemHandler_UsageFault
//  680 *                       - SystemHandler_DebugMonitor
//  681 * Output         : None
//  682 * Return         : Source of the fault handler.
//  683 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock28 Using cfiCommon0
        CFI Function NVIC_GetFaultHandlerSources
        THUMB
//  684 u32 NVIC_GetFaultHandlerSources(u32 SystemHandler)
//  685 {
//  686   u32 faultsources = 0x00;
//  687   u32 tmpreg = 0x00, tmppos = 0x00;
//  688 
//  689   /* Check the parameters */
//  690   assert_param(IS_FAULT_SOURCE_SYSTEM_HANDLER(SystemHandler));
//  691   
//  692   tmpreg = (SystemHandler >> 0x12) & (u32)0x03;
NVIC_GetFaultHandlerSources:
        LSRS     R1,R0,#+18
        AND      R1,R1,#0x3
//  693   tmppos = (SystemHandler >> 0x14) & (u32)0x03;
        LSRS     R0,R0,#+20
        AND      R0,R0,#0x3
//  694 
//  695   if (tmpreg == 0x00)
        CBNZ     R1,??NVIC_GetFaultHandlerSources_0
//  696   {
//  697     faultsources = SCB->HFSR;
        LDR.N    R0,??NVIC_GetFaultHandlerSources_1  ;; 0xe000ed28
        LDR      R0,[R0, #+4]
        BX       LR
//  698   }
//  699   else if (tmpreg == 0x01)
??NVIC_GetFaultHandlerSources_0:
        CMP      R1,#+1
        BNE.N    ??NVIC_GetFaultHandlerSources_2
//  700   {
//  701     faultsources = SCB->CFSR >> (tmppos * 0x08);
        LDR.N    R1,??NVIC_GetFaultHandlerSources_1  ;; 0xe000ed28
        LDR      R1,[R1, #+0]
        LSLS     R2,R0,#+3
        LSRS     R1,R1,R2
//  702     if (tmppos != 0x02)
        CMP      R0,#+2
        ITE      EQ 
        UXTBEQ   R0,R1
//  703     {
//  704       faultsources &= (u32)0x0F;
        ANDNE    R0,R1,#0xF
        BX       LR
//  705     }
//  706     else
//  707     {
//  708       faultsources &= (u32)0xFF;
//  709     }
//  710   }
//  711   else
//  712   {
//  713     faultsources = SCB->DFSR;
??NVIC_GetFaultHandlerSources_2:
        LDR.N    R0,??NVIC_GetFaultHandlerSources_1  ;; 0xe000ed28
        LDR      R0,[R0, #+8]
//  714   }
//  715   return faultsources;
??NVIC_GetFaultHandlerSources_3:
        BX       LR               ;; return
        Nop      
        DATA
??NVIC_GetFaultHandlerSources_1:
        DC32     0xe000ed28
        CFI EndBlock cfiBlock28
//  716 }
//  717 
//  718 /*******************************************************************************
//  719 * Function Name  : NVIC_GetFaultAddress
//  720 * Description    : Returns the address of the location that generated a fault
//  721 *                  handler.
//  722 * Input          : - SystemHandler: specifies the system handler to get its
//  723 *                    fault address.
//  724 *                    This parameter can be one of the following values:
//  725 *                       - SystemHandler_MemoryManage
//  726 *                       - SystemHandler_BusFault
//  727 * Output         : None
//  728 * Return         : Fault address.
//  729 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock29 Using cfiCommon0
        CFI Function NVIC_GetFaultAddress
        THUMB
//  730 u32 NVIC_GetFaultAddress(u32 SystemHandler)
//  731 {
//  732   u32 faultaddress = 0x00;
//  733   u32 tmp = 0x00;
//  734 
//  735   /* Check the parameters */
//  736   assert_param(IS_FAULT_ADDRESS_SYSTEM_HANDLER(SystemHandler));
//  737   
//  738   tmp = (SystemHandler >> 0x16) & (u32)0x01;
//  739 
//  740   if (tmp == 0x00)
NVIC_GetFaultAddress:
        TST      R0,#0x400000
        ITTEE    NE 
        LDRNE.N  R0,??NVIC_GetFaultAddress_0  ;; 0xe000ed34
        LDRNE    R0,[R0, #+4]
//  741   {
//  742     faultaddress = SCB->MMFAR;
        LDREQ.N  R0,??NVIC_GetFaultAddress_0  ;; 0xe000ed34
        LDREQ    R0,[R0, #+0]
//  743   }
//  744   else
//  745   {
//  746     faultaddress = SCB->BFAR;
//  747   }
//  748   return faultaddress;
        BX       LR               ;; return
        DATA
??NVIC_GetFaultAddress_0:
        DC32     0xe000ed34
        CFI EndBlock cfiBlock29
//  749 }

        END
//  750 
//  751 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
// 812 bytes in section .text
// 
// 812 bytes of CODE memory
//
//Errors: none
//Warnings: none
