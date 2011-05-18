///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  13:39:12 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\FWLib\src\stm32f10x_fsmc.c                    /
//    Command line =  E:\DS0203\FWLib\src\stm32f10x_fsmc.c -lA                /
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
//    List file    =  E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\stm32f10x_fsmc. /
//                    s                                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f10x_fsmc

        PUBLIC FSMC_ClearFlag
        PUBLIC FSMC_ClearITPendingBit
        PUBLIC FSMC_GetECC
        PUBLIC FSMC_GetFlagStatus
        PUBLIC FSMC_GetITStatus
        PUBLIC FSMC_ITConfig
        PUBLIC FSMC_NANDCmd
        PUBLIC FSMC_NANDDeInit
        PUBLIC FSMC_NANDECCCmd
        PUBLIC FSMC_NANDInit
        PUBLIC FSMC_NANDStructInit
        PUBLIC FSMC_NORSRAMCmd
        PUBLIC FSMC_NORSRAMDeInit
        PUBLIC FSMC_NORSRAMInit
        PUBLIC FSMC_NORSRAMStructInit
        PUBLIC FSMC_PCCARDCmd
        PUBLIC FSMC_PCCARDDeInit
        PUBLIC FSMC_PCCARDInit
        PUBLIC FSMC_PCCARDStructInit
        
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
        
// E:\DS0203\FWLib\src\stm32f10x_fsmc.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_fsmc.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.0.3
//    5 * Date               : 09/22/2008
//    6 * Description        : This file provides all the FSMC firmware functions.
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
//   17 #include "stm32f10x_fsmc.h"
//   18 #include "stm32f10x_rcc.h"
//   19 
//   20 /* Private typedef -----------------------------------------------------------*/
//   21 /* Private define ------------------------------------------------------------*/
//   22 /* --------------------- FSMC registers bit mask ---------------------------- */
//   23 /* FSMC BCRx Mask */
//   24 #define BCR_MBKEN_Set                       ((u32)0x00000001)
//   25 #define BCR_MBKEN_Reset                     ((u32)0x000FFFFE)
//   26 #define BCR_FACCEN_Set                      ((u32)0x00000040)
//   27 
//   28 /* FSMC PCRx Mask */
//   29 #define PCR_PBKEN_Set                       ((u32)0x00000004)
//   30 #define PCR_PBKEN_Reset                     ((u32)0x000FFFFB)
//   31 #define PCR_ECCEN_Set                       ((u32)0x00000040)
//   32 #define PCR_ECCEN_Reset                     ((u32)0x000FFFBF)
//   33 #define PCR_MemoryType_NAND                 ((u32)0x00000008)
//   34 
//   35 /* Private macro -------------------------------------------------------------*/
//   36 /* Private variables ---------------------------------------------------------*/
//   37 /* Private function prototypes -----------------------------------------------*/
//   38 /* Private functions ---------------------------------------------------------*/
//   39 
//   40 /*******************************************************************************
//   41 * Function Name  : FSMC_NORSRAMDeInit
//   42 * Description    : Deinitializes the FSMC NOR/SRAM Banks registers to their default 
//   43 *                  reset values.
//   44 * Input          : - FSMC_Bank: specifies the FSMC Bank to be used
//   45 *                    This parameter can be one of the following values:
//   46 *                       - FSMC_Bank1_NORSRAM1: FSMC Bank1 NOR/SRAM1  
//   47 *                       - FSMC_Bank1_NORSRAM2: FSMC Bank1 NOR/SRAM2 
//   48 *                       - FSMC_Bank1_NORSRAM3: FSMC Bank1 NOR/SRAM3 
//   49 *                       - FSMC_Bank1_NORSRAM4: FSMC Bank1 NOR/SRAM4                       
//   50 * Output         : None
//   51 * Return         : None
//   52 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function FSMC_NORSRAMDeInit
        THUMB
//   53 void FSMC_NORSRAMDeInit(u32 FSMC_Bank)
//   54 {
//   55   /* Check the parameter */
//   56   assert_param(IS_FSMC_NORSRAM_BANK(FSMC_Bank));
//   57   
//   58   /* FSMC_Bank1_NORSRAM1 */
//   59   if(FSMC_Bank == FSMC_Bank1_NORSRAM1)
FSMC_NORSRAMDeInit:
        CBNZ     R0,??FSMC_NORSRAMDeInit_0
//   60   {
//   61     FSMC_Bank1->BTCR[FSMC_Bank] = 0x000030DB;    
        MOV      R1,#-1610612736
        MOVW     R2,#+12507
        STR      R2,[R1, #+0]
        B.N      ??FSMC_NORSRAMDeInit_1
//   62   }
//   63   /* FSMC_Bank1_NORSRAM2,  FSMC_Bank1_NORSRAM3 or FSMC_Bank1_NORSRAM4 */
//   64   else
//   65   {   
//   66     FSMC_Bank1->BTCR[FSMC_Bank] = 0x000030D2; 
??FSMC_NORSRAMDeInit_0:
        MOV      R1,#-1610612736
        MOVW     R2,#+12498
        STR      R2,[R1, R0, LSL #+2]
//   67   }
//   68 
//   69   FSMC_Bank1->BTCR[FSMC_Bank + 1] = 0x0FFFFFFF;
??FSMC_NORSRAMDeInit_1:
        MVN      R1,#-268435456
        LSLS     R2,R0,#+2
        ADD      R2,R2,#-1610612736
        STR      R1,[R2, #+4]
//   70   FSMC_Bank1E->BWTR[FSMC_Bank] = 0x0FFFFFFF;  
        LDR.N    R2,??DataTable6  ;; 0xa0000104
        STR      R1,[R2, R0, LSL #+2]
//   71 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//   72 
//   73 /*******************************************************************************
//   74 * Function Name  : FSMC_NANDDeInit
//   75 * Description    : Deinitializes the FSMC NAND Banks registers to their default 
//   76 *                  reset values.
//   77 * Input          : - FSMC_Bank: specifies the FSMC Bank to be used
//   78 *                    This parameter can be one of the following values:
//   79 *                       - FSMC_Bank2_NAND: FSMC Bank2 NAND 
//   80 *                       - FSMC_Bank3_NAND: FSMC Bank3 NAND                       
//   81 * Output         : None
//   82 * Return         : None
//   83 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function FSMC_NANDDeInit
        THUMB
//   84 void FSMC_NANDDeInit(u32 FSMC_Bank)
//   85 {
//   86   /* Check the parameter */
//   87   assert_param(IS_FSMC_NAND_BANK(FSMC_Bank));
//   88   
//   89   if(FSMC_Bank == FSMC_Bank2_NAND)
FSMC_NANDDeInit:
        MOV      R1,#-50529028
        CMP      R0,#+16
        BNE.N    ??FSMC_NANDDeInit_0
//   90   {
//   91     /* Set the FSMC_Bank2 registers to their reset values */
//   92     FSMC_Bank2->PCR2 = 0x00000018;
        LDR.N    R0,??DataTable27  ;; 0xa0000060
        MOVS     R2,#+24
        STR      R2,[R0, #+0]
//   93     FSMC_Bank2->SR2 = 0x00000040;
        MOVS     R2,#+64
        STR      R2,[R0, #+4]
//   94     FSMC_Bank2->PMEM2 = 0xFCFCFCFC;
        STR      R1,[R0, #+8]
//   95     FSMC_Bank2->PATT2 = 0xFCFCFCFC;  
        STR      R1,[R0, #+12]
        BX       LR
//   96   }
//   97   /* FSMC_Bank3_NAND */  
//   98   else
//   99   {
//  100     /* Set the FSMC_Bank3 registers to their reset values */
//  101     FSMC_Bank3->PCR3 = 0x00000018;
??FSMC_NANDDeInit_0:
        LDR.N    R0,??DataTable27  ;; 0xa0000060
        MOVS     R2,#+24
        STR      R2,[R0, #+32]
//  102     FSMC_Bank3->SR3 = 0x00000040;
        MOVS     R2,#+64
        STR      R2,[R0, #+36]
//  103     FSMC_Bank3->PMEM3 = 0xFCFCFCFC;
        STR      R1,[R0, #+40]
//  104     FSMC_Bank3->PATT3 = 0xFCFCFCFC; 
        STR      R1,[R0, #+44]
//  105   }  
//  106 }
??FSMC_NANDDeInit_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//  107 
//  108 /*******************************************************************************
//  109 * Function Name  : FSMC_PCCARDDeInit
//  110 * Description    : Deinitializes the FSMC PCCARD Bank registers to their default 
//  111 *                  reset values.
//  112 * Input          : None                       
//  113 * Output         : None
//  114 * Return         : None
//  115 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function FSMC_PCCARDDeInit
        THUMB
//  116 void FSMC_PCCARDDeInit(void)
//  117 {
//  118   /* Set the FSMC_Bank4 registers to their reset values */
//  119   FSMC_Bank4->PCR4 = 0x00000018; 
FSMC_PCCARDDeInit:
        LDR.N    R0,??DataTable20  ;; 0xa00000a0
        MOVS     R1,#+24
        STR      R1,[R0, #+0]
//  120   FSMC_Bank4->SR4 = 0x00000000;	
        MOVS     R1,#+0
        STR      R1,[R0, #+4]
//  121   FSMC_Bank4->PMEM4 = 0xFCFCFCFC;
        MOV      R0,#-50529028
        LDR.N    R1,??DataTable20  ;; 0xa00000a0
        STR      R0,[R1, #+8]
//  122   FSMC_Bank4->PATT4 = 0xFCFCFCFC;
        STR      R0,[R1, #+12]
//  123   FSMC_Bank4->PIO4 = 0xFCFCFCFC;
        STR      R0,[R1, #+16]
//  124 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//  125 
//  126 /*******************************************************************************
//  127 * Function Name  : FSMC_NORSRAMInit
//  128 * Description    : Initializes the FSMC NOR/SRAM Banks according to the 
//  129 *                  specified parameters in the FSMC_NORSRAMInitStruct.
//  130 * Input          : - FSMC_NORSRAMInitStruct : pointer to a FSMC_NORSRAMInitTypeDef
//  131 *                  structure that contains the configuration information for 
//  132 *                  the FSMC NOR/SRAM specified Banks.                       
//  133 * Output         : None
//  134 * Return         : None
//  135 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function FSMC_NORSRAMInit
        THUMB
//  136 void FSMC_NORSRAMInit(FSMC_NORSRAMInitTypeDef* FSMC_NORSRAMInitStruct)
//  137 { 
//  138   /* Check the parameters */
//  139   assert_param(IS_FSMC_NORSRAM_BANK(FSMC_NORSRAMInitStruct->FSMC_Bank));
//  140   assert_param(IS_FSMC_MUX(FSMC_NORSRAMInitStruct->FSMC_DataAddressMux));
//  141   assert_param(IS_FSMC_MEMORY(FSMC_NORSRAMInitStruct->FSMC_MemoryType));
//  142   assert_param(IS_FSMC_MEMORY_WIDTH(FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth));
//  143   assert_param(IS_FSMC_BURSTMODE(FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode));
//  144   assert_param(IS_FSMC_WAIT_POLARITY(FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity));
//  145   assert_param(IS_FSMC_WRAP_MODE(FSMC_NORSRAMInitStruct->FSMC_WrapMode));
//  146   assert_param(IS_FSMC_WAIT_SIGNAL_ACTIVE(FSMC_NORSRAMInitStruct->FSMC_WaitSignalActive));
//  147   assert_param(IS_FSMC_WRITE_OPERATION(FSMC_NORSRAMInitStruct->FSMC_WriteOperation));
//  148   assert_param(IS_FSMC_WAITE_SIGNAL(FSMC_NORSRAMInitStruct->FSMC_WaitSignal));
//  149   assert_param(IS_FSMC_EXTENDED_MODE(FSMC_NORSRAMInitStruct->FSMC_ExtendedMode));
//  150   assert_param(IS_FSMC_WRITE_BURST(FSMC_NORSRAMInitStruct->FSMC_WriteBurst));  
//  151   assert_param(IS_FSMC_ADDRESS_SETUP_TIME(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressSetupTime));
//  152   assert_param(IS_FSMC_ADDRESS_HOLD_TIME(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressHoldTime));
//  153   assert_param(IS_FSMC_DATASETUP_TIME(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataSetupTime));
//  154   assert_param(IS_FSMC_TURNAROUND_TIME(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_BusTurnAroundDuration));
//  155   assert_param(IS_FSMC_CLK_DIV(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_CLKDivision));
//  156   assert_param(IS_FSMC_DATA_LATENCY(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataLatency));
//  157   assert_param(IS_FSMC_ACCESS_MODE(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AccessMode)); 
//  158   
//  159   /* Bank1 NOR/SRAM control register configuration */ 
//  160   FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
//  161             (u32)FSMC_NORSRAMInitStruct->FSMC_DataAddressMux |
//  162             FSMC_NORSRAMInitStruct->FSMC_MemoryType |
//  163             FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth |
//  164             FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode |
//  165             FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity |
//  166             FSMC_NORSRAMInitStruct->FSMC_WrapMode |
//  167             FSMC_NORSRAMInitStruct->FSMC_WaitSignalActive |
//  168             FSMC_NORSRAMInitStruct->FSMC_WriteOperation |
//  169             FSMC_NORSRAMInitStruct->FSMC_WaitSignal |
//  170             FSMC_NORSRAMInitStruct->FSMC_ExtendedMode |
//  171             FSMC_NORSRAMInitStruct->FSMC_WriteBurst;
FSMC_NORSRAMInit:
        LDR      R1,[R0, #+4]
        LDR      R2,[R0, #+8]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+12]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+16]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+20]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+24]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+28]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+32]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+36]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+40]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+44]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+0]
        MOV      R3,#-1610612736
        STR      R1,[R3, R2, LSL #+2]
//  172 
//  173   if(FSMC_NORSRAMInitStruct->FSMC_MemoryType == FSMC_MemoryType_NOR)
        LDR      R1,[R0, #+8]
        CMP      R1,#+8
        BNE.N    ??FSMC_NORSRAMInit_0
//  174   {
//  175     FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank] |= (u32)BCR_FACCEN_Set;
        LDR      R1,[R0, #+0]
        LDR      R2,[R3, R1, LSL #+2]
        ORR      R2,R2,#0x40
        STR      R2,[R3, R1, LSL #+2]
//  176   }
//  177 
//  178   /* Bank1 NOR/SRAM timing register configuration */
//  179   FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank+1] = 
//  180             (u32)FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressSetupTime |
//  181             (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressHoldTime << 4) |
//  182             (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataSetupTime << 8) |
//  183             (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_BusTurnAroundDuration << 16) |
//  184             (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_CLKDivision << 20) |
//  185             (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataLatency << 24) |
//  186              FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AccessMode;
??FSMC_NORSRAMInit_0:
        LDR      R1,[R0, #+48]
        LDR      R2,[R1, #+0]
        LDR      R3,[R1, #+4]
        ORR      R2,R2,R3, LSL #+4
        LDR      R3,[R1, #+8]
        ORR      R2,R2,R3, LSL #+8
        LDR      R3,[R1, #+12]
        ORR      R2,R2,R3, LSL #+16
        LDR      R3,[R1, #+16]
        ORR      R2,R2,R3, LSL #+20
        LDR      R3,[R1, #+20]
        ORR      R2,R2,R3, LSL #+24
        LDR      R1,[R1, #+24]
        ORRS     R1,R1,R2
        LDR      R2,[R0, #+0]
        LSLS     R2,R2,#+2
        ADD      R2,R2,#-1610612736
        STR      R1,[R2, #+4]
//  187             
//  188 
//  189     
//  190   /* Bank1 NOR/SRAM timing register for write configuration, if extended mode is used */
//  191   if(FSMC_NORSRAMInitStruct->FSMC_ExtendedMode == FSMC_ExtendedMode_Enable)
        LDR      R1,[R0, #+0]
        LDR      R2,[R0, #+40]
        CMP      R2,#+16384
        BNE.N    ??FSMC_NORSRAMInit_1
//  192   {
//  193     assert_param(IS_FSMC_ADDRESS_SETUP_TIME(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressSetupTime));
//  194     assert_param(IS_FSMC_ADDRESS_HOLD_TIME(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime));
//  195     assert_param(IS_FSMC_DATASETUP_TIME(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime));
//  196     assert_param(IS_FSMC_CLK_DIV(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision));
//  197     assert_param(IS_FSMC_DATA_LATENCY(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency));
//  198     assert_param(IS_FSMC_ACCESS_MODE(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode));
//  199 
//  200     FSMC_Bank1E->BWTR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
//  201               (u32)FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressSetupTime |
//  202               (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime << 4 )|
//  203               (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime << 8) |
//  204               (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision << 20) |
//  205               (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency << 24) |
//  206                FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode;
        LDR      R0,[R0, #+52]
        LDR      R2,[R0, #+0]
        LDR      R3,[R0, #+4]
        ORR      R2,R2,R3, LSL #+4
        LDR      R3,[R0, #+8]
        ORR      R2,R2,R3, LSL #+8
        LDR      R3,[R0, #+16]
        ORR      R2,R2,R3, LSL #+20
        LDR      R3,[R0, #+20]
        ORR      R2,R2,R3, LSL #+24
        LDR      R0,[R0, #+24]
        ORRS     R0,R0,R2
        LDR.N    R2,??DataTable6  ;; 0xa0000104
        STR      R0,[R2, R1, LSL #+2]
        BX       LR
//  207   }
//  208   else
//  209   {
//  210     FSMC_Bank1E->BWTR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 0x0FFFFFFF;
??FSMC_NORSRAMInit_1:
        LDR.N    R0,??DataTable6  ;; 0xa0000104
        MVN      R2,#-268435456
        STR      R2,[R0, R1, LSL #+2]
//  211   }
//  212 }
??FSMC_NORSRAMInit_2:
        BX       LR               ;; return
        CFI EndBlock cfiBlock3

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable6:
        DC32     0xa0000104
//  213 
//  214 /*******************************************************************************
//  215 * Function Name  : FSMC_NANDInit
//  216 * Description    : Initializes the FSMC NAND Banks according to the specified 
//  217 *                  parameters in the FSMC_NANDInitStruct.
//  218 * Input          : - FSMC_NANDInitStruct : pointer to a FSMC_NANDInitTypeDef 
//  219 *                    structure that contains the configuration information for 
//  220 *                    the FSMC NAND specified Banks.                       
//  221 * Output         : None
//  222 * Return         : None
//  223 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function FSMC_NANDInit
        THUMB
//  224 void FSMC_NANDInit(FSMC_NANDInitTypeDef* FSMC_NANDInitStruct)
//  225 {
FSMC_NANDInit:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  226   u32 tmppcr = 0x00000000, tmppmem = 0x00000000, tmppatt = 0x00000000; 
//  227     
//  228   /* Check the parameters */
//  229   assert_param( IS_FSMC_NAND_BANK(FSMC_NANDInitStruct->FSMC_Bank));
//  230   assert_param( IS_FSMC_WAIT_FEATURE(FSMC_NANDInitStruct->FSMC_Waitfeature));
//  231   assert_param( IS_FSMC_DATA_WIDTH(FSMC_NANDInitStruct->FSMC_MemoryDataWidth));
//  232   assert_param( IS_FSMC_ECC_STATE(FSMC_NANDInitStruct->FSMC_ECC));
//  233   assert_param( IS_FSMC_ECCPAGE_SIZE(FSMC_NANDInitStruct->FSMC_ECCPageSize));
//  234   assert_param( IS_FSMC_ADDRESS_LOW_MAPPING(FSMC_NANDInitStruct->FSMC_AddressLowMapping));
//  235   assert_param( IS_FSMC_TCLR_TIME(FSMC_NANDInitStruct->FSMC_TCLRSetupTime));
//  236   assert_param( IS_FSMC_TAR_TIME(FSMC_NANDInitStruct->FSMC_TARSetupTime));
//  237 
//  238   assert_param(IS_FSMC_SETUP_TIME(FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime));
//  239   assert_param(IS_FSMC_WAIT_TIME(FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime));
//  240   assert_param(IS_FSMC_HOLD_TIME(FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime));
//  241   assert_param(IS_FSMC_HIZ_TIME(FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime));
//  242 
//  243   assert_param(IS_FSMC_SETUP_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime));
//  244   assert_param(IS_FSMC_WAIT_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime));
//  245   assert_param(IS_FSMC_HOLD_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime));
//  246   assert_param(IS_FSMC_HIZ_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime));
//  247   
//  248   /* Set the tmppcr value according to FSMC_NANDInitStruct parameters */
//  249   tmppcr = (u32)FSMC_NANDInitStruct->FSMC_Waitfeature |
//  250             PCR_MemoryType_NAND |
//  251             FSMC_NANDInitStruct->FSMC_MemoryDataWidth |
//  252             FSMC_NANDInitStruct->FSMC_ECC |
//  253             FSMC_NANDInitStruct->FSMC_ECCPageSize |
//  254             FSMC_NANDInitStruct->FSMC_AddressLowMapping |
//  255             (FSMC_NANDInitStruct->FSMC_TCLRSetupTime << 9 )|
//  256             (FSMC_NANDInitStruct->FSMC_TARSetupTime << 13);
        LDR      R1,[R0, #+4]
        LDR      R2,[R0, #+8]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+12]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+16]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+20]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+24]
        ORR      R1,R1,R2, LSL #+9
        LDR      R2,[R0, #+28]
        ORR      R1,R1,R2, LSL #+13
        ORR      R1,R1,#0x8
//  257             
//  258   /* Set tmppmem value according to FSMC_CommonSpaceTimingStructure parameters */
//  259   tmppmem = (u32)FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime |
//  260             (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
//  261             (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
//  262             (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
        LDR      R2,[R0, #+32]
        LDR      R3,[R2, #+0]
        LDR      R12,[R2, #+4]
        ORR      R3,R3,R12, LSL #+8
        LDR      R12,[R2, #+8]
        ORR      R3,R3,R12, LSL #+16
        LDR      R2,[R2, #+12]
        ORR      R2,R3,R2, LSL #+24
//  263             
//  264   /* Set tmppatt value according to FSMC_AttributeSpaceTimingStructure parameters */
//  265   tmppatt = (u32)FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime |
//  266             (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
//  267             (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
//  268             (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime << 24);
        LDR      R3,[R0, #+36]
        LDR      R12,[R3, #+0]
        LDR      LR,[R3, #+4]
        ORR      R12,R12,LR, LSL #+8
        LDR      LR,[R3, #+8]
        ORR      R12,R12,LR, LSL #+16
        LDR      R3,[R3, #+12]
        ORR      R3,R12,R3, LSL #+24
//  269   
//  270   if(FSMC_NANDInitStruct->FSMC_Bank == FSMC_Bank2_NAND)
        LDR      R0,[R0, #+0]
        CMP      R0,#+16
        BNE.N    ??FSMC_NANDInit_0
//  271   {
//  272     /* FSMC_Bank2_NAND registers configuration */
//  273     FSMC_Bank2->PCR2 = tmppcr;
        LDR.N    R0,??DataTable27  ;; 0xa0000060
        STR      R1,[R0, #+0]
//  274     FSMC_Bank2->PMEM2 = tmppmem;
        STR      R2,[R0, #+8]
//  275     FSMC_Bank2->PATT2 = tmppatt;
        STR      R3,[R0, #+12]
        B.N      ??FSMC_NANDInit_1
//  276   }
//  277   else
//  278   {
//  279     /* FSMC_Bank3_NAND registers configuration */
//  280     FSMC_Bank3->PCR3 = tmppcr;
??FSMC_NANDInit_0:
        LDR.N    R0,??DataTable27  ;; 0xa0000060
        STR      R1,[R0, #+32]
//  281     FSMC_Bank3->PMEM3 = tmppmem;
        STR      R2,[R0, #+40]
//  282     FSMC_Bank3->PATT3 = tmppatt;
        STR      R3,[R0, #+44]
//  283   }
//  284 }
??FSMC_NANDInit_1:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock4
//  285 
//  286 /*******************************************************************************
//  287 * Function Name  : FSMC_PCCARDInit
//  288 * Description    : Initializes the FSMC PCCARD Bank according to the specified 
//  289 *                  parameters in the FSMC_PCCARDInitStruct.
//  290 * Input          : - FSMC_PCCARDInitStruct : pointer to a FSMC_PCCARDInitTypeDef
//  291 *                    structure that contains the configuration information for 
//  292 *                    the FSMC PCCARD Bank.                       
//  293 * Output         : None
//  294 * Return         : None
//  295 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function FSMC_PCCARDInit
        THUMB
//  296 void FSMC_PCCARDInit(FSMC_PCCARDInitTypeDef* FSMC_PCCARDInitStruct)
//  297 {
//  298   /* Check the parameters */
//  299   assert_param(IS_FSMC_WAIT_FEATURE(FSMC_PCCARDInitStruct->FSMC_Waitfeature));
//  300   assert_param(IS_FSMC_ADDRESS_LOW_MAPPING(FSMC_PCCARDInitStruct->FSMC_AddressLowMapping));
//  301   assert_param(IS_FSMC_TCLR_TIME(FSMC_PCCARDInitStruct->FSMC_TCLRSetupTime));
//  302   assert_param(IS_FSMC_TAR_TIME(FSMC_PCCARDInitStruct->FSMC_TARSetupTime));
//  303 
//  304  
//  305   assert_param(IS_FSMC_SETUP_TIME(FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime));
//  306   assert_param(IS_FSMC_WAIT_TIME(FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime));
//  307   assert_param(IS_FSMC_HOLD_TIME(FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime));
//  308   assert_param(IS_FSMC_HIZ_TIME(FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime));
//  309   
//  310   assert_param(IS_FSMC_SETUP_TIME(FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime));
//  311   assert_param(IS_FSMC_WAIT_TIME(FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime));
//  312   assert_param(IS_FSMC_HOLD_TIME(FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime));
//  313   assert_param(IS_FSMC_HIZ_TIME(FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime));
//  314 
//  315   assert_param(IS_FSMC_SETUP_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_SetupTime));
//  316   assert_param(IS_FSMC_WAIT_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_WaitSetupTime));
//  317   assert_param(IS_FSMC_HOLD_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HoldSetupTime));
//  318   assert_param(IS_FSMC_HIZ_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HiZSetupTime));
//  319   
//  320   /* Set the PCR4 register value according to FSMC_PCCARDInitStruct parameters */
//  321   FSMC_Bank4->PCR4 = (u32)FSMC_PCCARDInitStruct->FSMC_Waitfeature |
//  322                      FSMC_MemoryDataWidth_16b |  
//  323                      FSMC_PCCARDInitStruct->FSMC_AddressLowMapping |
//  324                      (FSMC_PCCARDInitStruct->FSMC_TCLRSetupTime << 9) |
//  325                      (FSMC_PCCARDInitStruct->FSMC_TARSetupTime << 13);
FSMC_PCCARDInit:
        LDR      R1,[R0, #+0]
        LDR      R2,[R0, #+4]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+8]
        ORR      R1,R1,R2, LSL #+9
        LDR      R2,[R0, #+12]
        ORR      R1,R1,R2, LSL #+13
        ORR      R1,R1,#0x10
        LDR.N    R2,??DataTable20  ;; 0xa00000a0
        STR      R1,[R2, #+0]
//  326             
//  327   /* Set PMEM4 register value according to FSMC_CommonSpaceTimingStructure parameters */
//  328   FSMC_Bank4->PMEM4 = (u32)FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime |
//  329                       (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
//  330                       (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
//  331                       (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
        LDR      R1,[R0, #+16]
        LDR      R2,[R1, #+0]
        LDR      R3,[R1, #+4]
        ORR      R2,R2,R3, LSL #+8
        LDR      R3,[R1, #+8]
        ORR      R2,R2,R3, LSL #+16
        LDR      R1,[R1, #+12]
        ORR      R1,R2,R1, LSL #+24
        LDR.N    R2,??DataTable20  ;; 0xa00000a0
        STR      R1,[R2, #+8]
//  332             
//  333   /* Set PATT4 register value according to FSMC_AttributeSpaceTimingStructure parameters */
//  334   FSMC_Bank4->PATT4 = (u32)FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime |
//  335                       (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
//  336                       (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
//  337                       (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime << 24);	
        LDR      R1,[R0, #+20]
        LDR      R2,[R1, #+0]
        LDR      R3,[R1, #+4]
        ORR      R2,R2,R3, LSL #+8
        LDR      R3,[R1, #+8]
        ORR      R2,R2,R3, LSL #+16
        LDR      R1,[R1, #+12]
        ORR      R1,R2,R1, LSL #+24
        LDR.N    R2,??DataTable20  ;; 0xa00000a0
        STR      R1,[R2, #+12]
//  338             
//  339   /* Set PIO4 register value according to FSMC_IOSpaceTimingStructure parameters */
//  340   FSMC_Bank4->PIO4 = (u32)FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_SetupTime |
//  341                      (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
//  342                      (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
//  343                      (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HiZSetupTime << 24);             
        LDR      R0,[R0, #+24]
        LDR      R1,[R0, #+0]
        LDR      R2,[R0, #+4]
        ORR      R1,R1,R2, LSL #+8
        LDR      R2,[R0, #+8]
        ORR      R1,R1,R2, LSL #+16
        LDR      R0,[R0, #+12]
        ORR      R0,R1,R0, LSL #+24
        LDR.N    R1,??DataTable20  ;; 0xa00000a0
        STR      R0,[R1, #+16]
//  344 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  345 
//  346 /*******************************************************************************
//  347 * Function Name  : FSMC_NORSRAMStructInit
//  348 * Description    : Fills each FSMC_NORSRAMInitStruct member with its default value.
//  349 * Input          : - FSMC_NORSRAMInitStruct: pointer to a FSMC_NORSRAMInitTypeDef 
//  350 *                    structure which will be initialized.
//  351 * Output         : None
//  352 * Return         : None
//  353 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function FSMC_NORSRAMStructInit
        THUMB
//  354 void FSMC_NORSRAMStructInit(FSMC_NORSRAMInitTypeDef* FSMC_NORSRAMInitStruct)
//  355 {  
//  356   /* Reset NOR/SRAM Init structure parameters values */
//  357   FSMC_NORSRAMInitStruct->FSMC_Bank = FSMC_Bank1_NORSRAM1;
FSMC_NORSRAMStructInit:
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  358   FSMC_NORSRAMInitStruct->FSMC_DataAddressMux = FSMC_DataAddressMux_Enable;
        MOVS     R1,#+2
        STR      R1,[R0, #+4]
//  359   FSMC_NORSRAMInitStruct->FSMC_MemoryType = FSMC_MemoryType_SRAM;
        MOVS     R1,#+0
        STR      R1,[R0, #+8]
//  360   FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth = FSMC_MemoryDataWidth_8b;
        STR      R1,[R0, #+12]
//  361   FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode = FSMC_BurstAccessMode_Disable;
        STR      R1,[R0, #+16]
//  362   FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity = FSMC_WaitSignalPolarity_Low;
        STR      R1,[R0, #+20]
//  363   FSMC_NORSRAMInitStruct->FSMC_WrapMode = FSMC_WrapMode_Disable;
        STR      R1,[R0, #+24]
//  364   FSMC_NORSRAMInitStruct->FSMC_WaitSignalActive = FSMC_WaitSignalActive_BeforeWaitState;
        STR      R1,[R0, #+28]
//  365   FSMC_NORSRAMInitStruct->FSMC_WriteOperation = FSMC_WriteOperation_Enable;
        MOV      R1,#+4096
        STR      R1,[R0, #+32]
//  366   FSMC_NORSRAMInitStruct->FSMC_WaitSignal = FSMC_WaitSignal_Enable;
        MOV      R1,#+8192
        STR      R1,[R0, #+36]
//  367   FSMC_NORSRAMInitStruct->FSMC_ExtendedMode = FSMC_ExtendedMode_Disable;
        MOVS     R1,#+0
        STR      R1,[R0, #+40]
//  368   FSMC_NORSRAMInitStruct->FSMC_WriteBurst = FSMC_WriteBurst_Disable;
        STR      R1,[R0, #+44]
//  369   FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressSetupTime = 0xF;
        LDR      R1,[R0, #+48]
        MOVS     R2,#+15
        STR      R2,[R1, #+0]
//  370   FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressHoldTime = 0xF;
        STR      R2,[R1, #+4]
//  371   FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataSetupTime = 0xFF;
        MOVS     R2,#+255
        STR      R2,[R1, #+8]
//  372   FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_BusTurnAroundDuration = 0xF;
        MOVS     R2,#+15
        STR      R2,[R1, #+12]
//  373   FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_CLKDivision = 0xF;
        STR      R2,[R1, #+16]
//  374   FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataLatency = 0xF;
        STR      R2,[R1, #+20]
//  375   FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AccessMode = FSMC_AccessMode_A; 
        MOVS     R2,#+0
        STR      R2,[R1, #+24]
//  376   FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressSetupTime = 0xF;
        LDR      R0,[R0, #+52]
        MOVS     R1,#+15
        STR      R1,[R0, #+0]
//  377   FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime = 0xF;
        STR      R1,[R0, #+4]
//  378   FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime = 0xFF;
        MOVS     R1,#+255
        STR      R1,[R0, #+8]
//  379   FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_BusTurnAroundDuration = 0xF;
        MOVS     R1,#+15
        STR      R1,[R0, #+12]
//  380   FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision = 0xF;
        STR      R1,[R0, #+16]
//  381   FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency = 0xF;
        STR      R1,[R0, #+20]
//  382   FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode = FSMC_AccessMode_A;
        STR      R2,[R0, #+24]
//  383 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  384 
//  385 /*******************************************************************************
//  386 * Function Name  : FSMC_NANDStructInit
//  387 * Description    : Fills each FSMC_NANDInitStruct member with its default value.
//  388 * Input          : - FSMC_NORSRAMInitStruct: pointer to a FSMC_NANDInitTypeDef 
//  389 *                    structure which will be initialized.
//  390 * Output         : None
//  391 * Return         : None
//  392 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function FSMC_NANDStructInit
        THUMB
//  393 void FSMC_NANDStructInit(FSMC_NANDInitTypeDef* FSMC_NANDInitStruct)
//  394 { 
//  395   /* Reset NAND Init structure parameters values */
//  396   FSMC_NANDInitStruct->FSMC_Bank = FSMC_Bank2_NAND;
FSMC_NANDStructInit:
        MOVS     R1,#+16
        STR      R1,[R0, #+0]
//  397   FSMC_NANDInitStruct->FSMC_Waitfeature = FSMC_Waitfeature_Disable;
        MOVS     R1,#+0
        STR      R1,[R0, #+4]
//  398   FSMC_NANDInitStruct->FSMC_MemoryDataWidth = FSMC_MemoryDataWidth_8b;
        STR      R1,[R0, #+8]
//  399   FSMC_NANDInitStruct->FSMC_ECC = FSMC_ECC_Disable;
        STR      R1,[R0, #+12]
//  400   FSMC_NANDInitStruct->FSMC_ECCPageSize = FSMC_ECCPageSize_256Bytes;
        STR      R1,[R0, #+16]
//  401   FSMC_NANDInitStruct->FSMC_AddressLowMapping = FSMC_AddressLowMapping_Direct;
        STR      R1,[R0, #+20]
//  402   FSMC_NANDInitStruct->FSMC_TCLRSetupTime = 0x0;
        STR      R1,[R0, #+24]
//  403   FSMC_NANDInitStruct->FSMC_TARSetupTime = 0x0;
        STR      R1,[R0, #+28]
//  404   FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime = 0xFC;
        LDR      R1,[R0, #+32]
        MOVS     R2,#+252
        STR      R2,[R1, #+0]
//  405   FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
        STR      R2,[R1, #+4]
//  406   FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
        STR      R2,[R1, #+8]
//  407   FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;
        STR      R2,[R1, #+12]
//  408   FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime = 0xFC;
        LDR      R0,[R0, #+36]
        STR      R2,[R0, #+0]
//  409   FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
        STR      R2,[R0, #+4]
//  410   FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
        STR      R2,[R0, #+8]
//  411   FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;	  
        STR      R2,[R0, #+12]
//  412 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  413 
//  414 /*******************************************************************************
//  415 * Function Name  : FSMC_PCCARDStructInit
//  416 * Description    : Fills each FSMC_PCCARDInitStruct member with its default value.
//  417 * Input          : - FSMC_PCCARDInitStruct: pointer to a FSMC_PCCARDInitTypeDef 
//  418 *                    structure which will be initialized.
//  419 * Output         : None
//  420 * Return         : None
//  421 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function FSMC_PCCARDStructInit
        THUMB
//  422 void FSMC_PCCARDStructInit(FSMC_PCCARDInitTypeDef* FSMC_PCCARDInitStruct)
//  423 {
//  424   /* Reset PCCARD Init structure parameters values */
//  425   FSMC_PCCARDInitStruct->FSMC_Waitfeature = FSMC_Waitfeature_Disable;
FSMC_PCCARDStructInit:
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  426   FSMC_PCCARDInitStruct->FSMC_AddressLowMapping = FSMC_AddressLowMapping_Direct;
        STR      R1,[R0, #+4]
//  427   FSMC_PCCARDInitStruct->FSMC_TCLRSetupTime = 0x0;
        STR      R1,[R0, #+8]
//  428   FSMC_PCCARDInitStruct->FSMC_TARSetupTime = 0x0;
        STR      R1,[R0, #+12]
//  429   FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime = 0xFC;
        LDR      R1,[R0, #+16]
        MOVS     R2,#+252
        STR      R2,[R1, #+0]
//  430   FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
        STR      R2,[R1, #+4]
//  431   FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
        STR      R2,[R1, #+8]
//  432   FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;
        STR      R2,[R1, #+12]
//  433   FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime = 0xFC;
        LDR      R1,[R0, #+20]
        STR      R2,[R1, #+0]
//  434   FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
        STR      R2,[R1, #+4]
//  435   FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
        STR      R2,[R1, #+8]
//  436   FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;	
        STR      R2,[R1, #+12]
//  437   FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_SetupTime = 0xFC;
        LDR      R0,[R0, #+24]
        STR      R2,[R0, #+0]
//  438   FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
        STR      R2,[R0, #+4]
//  439   FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
        STR      R2,[R0, #+8]
//  440   FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;
        STR      R2,[R0, #+12]
//  441 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  442 
//  443 /*******************************************************************************
//  444 * Function Name  : FSMC_NORSRAMCmd
//  445 * Description    : Enables or disables the specified NOR/SRAM Memory Bank.
//  446 * Input          : - FSMC_Bank: specifies the FSMC Bank to be used
//  447 *                    This parameter can be one of the following values:
//  448 *                       - FSMC_Bank1_NORSRAM1: FSMC Bank1 NOR/SRAM1  
//  449 *                       - FSMC_Bank1_NORSRAM2: FSMC Bank1 NOR/SRAM2 
//  450 *                       - FSMC_Bank1_NORSRAM3: FSMC Bank1 NOR/SRAM3 
//  451 *                       - FSMC_Bank1_NORSRAM4: FSMC Bank1 NOR/SRAM4 
//  452 *                : - NewState: new state of the FSMC_Bank.
//  453 *                    This parameter can be: ENABLE or DISABLE.
//  454 * Output         : None
//  455 * Return         : None
//  456 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function FSMC_NORSRAMCmd
        THUMB
//  457 void FSMC_NORSRAMCmd(u32 FSMC_Bank, FunctionalState NewState)
//  458 {
//  459   assert_param(IS_FSMC_NORSRAM_BANK(FSMC_Bank));
//  460   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  461   
//  462   if (NewState != DISABLE)
FSMC_NORSRAMCmd:
        CBZ      R1,??FSMC_NORSRAMCmd_0
//  463   {
//  464     /* Enable the selected NOR/SRAM Bank by setting the PBKEN bit in the BCRx register */
//  465     FSMC_Bank1->BTCR[FSMC_Bank] |= BCR_MBKEN_Set;
        MOV      R1,#-1610612736
        LDR      R1,[R1, R0, LSL #+2]
        ORR      R1,R1,#0x1
        MOV      R2,#-1610612736
        STR      R1,[R2, R0, LSL #+2]
        BX       LR
//  466   }
//  467   else
//  468   {
//  469     /* Disable the selected NOR/SRAM Bank by clearing the PBKEN bit in the BCRx register */
//  470     FSMC_Bank1->BTCR[FSMC_Bank] &= BCR_MBKEN_Reset;
??FSMC_NORSRAMCmd_0:
        MOV      R1,#-1610612736
        LDR      R1,[R1, R0, LSL #+2]
        LDR.N    R2,??FSMC_NORSRAMCmd_1  ;; 0xffffe
        ANDS     R1,R2,R1
        MOV      R2,#-1610612736
        STR      R1,[R2, R0, LSL #+2]
//  471   }
//  472 }
??FSMC_NORSRAMCmd_2:
        BX       LR               ;; return
        Nop      
        DATA
??FSMC_NORSRAMCmd_1:
        DC32     0xffffe
        CFI EndBlock cfiBlock9
//  473 
//  474 /*******************************************************************************
//  475 * Function Name  : FSMC_NANDCmd
//  476 * Description    : Enables or disables the specified NAND Memory Bank.
//  477 * Input          : - FSMC_Bank: specifies the FSMC Bank to be used
//  478 *                    This parameter can be one of the following values:
//  479 *                       - FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  480 *                       - FSMC_Bank3_NAND: FSMC Bank3 NAND
//  481 *                : - NewState: new state of the FSMC_Bank.
//  482 *                    This parameter can be: ENABLE or DISABLE.
//  483 * Output         : None
//  484 * Return         : None
//  485 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function FSMC_NANDCmd
        THUMB
//  486 void FSMC_NANDCmd(u32 FSMC_Bank, FunctionalState NewState)
//  487 {
//  488   assert_param(IS_FSMC_NAND_BANK(FSMC_Bank));
//  489   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  490   
//  491   if (NewState != DISABLE)
FSMC_NANDCmd:
        CBZ      R1,??FSMC_NANDCmd_0
//  492   {
//  493     /* Enable the selected NAND Bank by setting the PBKEN bit in the PCRx register */
//  494     if(FSMC_Bank == FSMC_Bank2_NAND)
        CMP      R0,#+16
        BNE.N    ??FSMC_NANDCmd_1
//  495     {
//  496       FSMC_Bank2->PCR2 |= PCR_PBKEN_Set;
        LDR.N    R0,??DataTable27  ;; 0xa0000060
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x4
??FSMC_NANDCmd_2:
        STR      R1,[R0, #+0]
        BX       LR
//  497     }
//  498     else
//  499     {
//  500       FSMC_Bank3->PCR3 |= PCR_PBKEN_Set;
??FSMC_NANDCmd_1:
        LDR.N    R0,??DataTable27  ;; 0xa0000060
        LDR      R0,[R0, #+32]
        ORR      R0,R0,#0x4
        LDR.N    R1,??DataTable27  ;; 0xa0000060
        B.N      ??FSMC_NANDCmd_3
//  501     }
//  502   }
//  503   else
//  504   {
//  505     /* Disable the selected NAND Bank by clearing the PBKEN bit in the PCRx register */
//  506     if(FSMC_Bank == FSMC_Bank2_NAND)
??FSMC_NANDCmd_0:
        LDR.N    R1,??DataTable21  ;; 0xffffb
        CMP      R0,#+16
        BNE.N    ??FSMC_NANDCmd_4
//  507     {
//  508       FSMC_Bank2->PCR2 &= PCR_PBKEN_Reset;
        LDR.N    R0,??DataTable27  ;; 0xa0000060
        LDR      R2,[R0, #+0]
        ANDS     R1,R1,R2
        B.N      ??FSMC_NANDCmd_2
//  509     }
//  510     else
//  511     {
//  512       FSMC_Bank3->PCR3 &= PCR_PBKEN_Reset;
??FSMC_NANDCmd_4:
        LDR.N    R0,??DataTable27  ;; 0xa0000060
        LDR      R0,[R0, #+32]
        ANDS     R0,R1,R0
        LDR.N    R1,??DataTable27  ;; 0xa0000060
??FSMC_NANDCmd_3:
        STR      R0,[R1, #+32]
//  513     }
//  514   }
//  515 }
??FSMC_NANDCmd_5:
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  516 
//  517 /*******************************************************************************
//  518 * Function Name  : FSMC_PCCARDCmd
//  519 * Description    : Enables or disables the PCCARD Memory Bank.
//  520 * Input          : - NewState: new state of the PCCARD Memory Bank.  
//  521 *                    This parameter can be: ENABLE or DISABLE.
//  522 * Output         : None
//  523 * Return         : None
//  524 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function FSMC_PCCARDCmd
        THUMB
//  525 void FSMC_PCCARDCmd(FunctionalState NewState)
//  526 {
//  527   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  528   
//  529   if (NewState != DISABLE)
FSMC_PCCARDCmd:
        LDR.N    R1,??DataTable20  ;; 0xa00000a0
        CMP      R0,#+0
        LDR      R0,[R1, #+0]
        BEQ.N    ??FSMC_PCCARDCmd_0
//  530   {
//  531     /* Enable the PCCARD Bank by setting the PBKEN bit in the PCR4 register */
//  532     FSMC_Bank4->PCR4 |= PCR_PBKEN_Set;
        ORR      R0,R0,#0x4
        B.N      ??FSMC_PCCARDCmd_1
//  533   }
//  534   else
//  535   {
//  536     /* Disable the PCCARD Bank by clearing the PBKEN bit in the PCR4 register */
//  537     FSMC_Bank4->PCR4 &= PCR_PBKEN_Reset;
??FSMC_PCCARDCmd_0:
        LDR.N    R2,??DataTable21  ;; 0xffffb
        ANDS     R0,R2,R0
??FSMC_PCCARDCmd_1:
        STR      R0,[R1, #+0]
//  538   }
//  539 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock11

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable20:
        DC32     0xa00000a0

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable21:
        DC32     0xffffb
//  540 
//  541 /*******************************************************************************
//  542 * Function Name  : FSMC_NANDECCCmd
//  543 * Description    : Enables or disables the FSMC NAND ECC feature.
//  544 * Input          : - FSMC_Bank: specifies the FSMC Bank to be used
//  545 *                    This parameter can be one of the following values:
//  546 *                       - FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  547 *                       - FSMC_Bank3_NAND: FSMC Bank3 NAND
//  548 *                : - NewState: new state of the FSMC NAND ECC feature.  
//  549 *                    This parameter can be: ENABLE or DISABLE.
//  550 * Output         : None
//  551 * Return         : None
//  552 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function FSMC_NANDECCCmd
        THUMB
//  553 void FSMC_NANDECCCmd(u32 FSMC_Bank, FunctionalState NewState)
//  554 {
//  555   assert_param(IS_FSMC_NAND_BANK(FSMC_Bank));
//  556   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  557   
//  558   if (NewState != DISABLE)
FSMC_NANDECCCmd:
        CBZ      R1,??FSMC_NANDECCCmd_0
//  559   {
//  560     /* Enable the selected NAND Bank ECC function by setting the ECCEN bit in the PCRx register */
//  561     if(FSMC_Bank == FSMC_Bank2_NAND)
        CMP      R0,#+16
        BNE.N    ??FSMC_NANDECCCmd_1
//  562     {
//  563       FSMC_Bank2->PCR2 |= PCR_ECCEN_Set;
        LDR.N    R0,??DataTable27  ;; 0xa0000060
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x40
??FSMC_NANDECCCmd_2:
        STR      R1,[R0, #+0]
        BX       LR
//  564     }
//  565     else
//  566     {
//  567       FSMC_Bank3->PCR3 |= PCR_ECCEN_Set;
??FSMC_NANDECCCmd_1:
        LDR.N    R0,??DataTable27  ;; 0xa0000060
        LDR      R0,[R0, #+32]
        ORR      R0,R0,#0x40
        LDR.N    R1,??DataTable27  ;; 0xa0000060
        B.N      ??FSMC_NANDECCCmd_3
//  568     }
//  569   }
//  570   else
//  571   {
//  572     /* Disable the selected NAND Bank ECC function by clearing the ECCEN bit in the PCRx register */
//  573     if(FSMC_Bank == FSMC_Bank2_NAND)
??FSMC_NANDECCCmd_0:
        LDR.N    R1,??FSMC_NANDECCCmd_4  ;; 0xfffbf
        CMP      R0,#+16
        BNE.N    ??FSMC_NANDECCCmd_5
//  574     {
//  575       FSMC_Bank2->PCR2 &= PCR_ECCEN_Reset;
        LDR.N    R0,??DataTable27  ;; 0xa0000060
        LDR      R2,[R0, #+0]
        ANDS     R1,R1,R2
        B.N      ??FSMC_NANDECCCmd_2
//  576     }
//  577     else
//  578     {
//  579       FSMC_Bank3->PCR3 &= PCR_ECCEN_Reset;
??FSMC_NANDECCCmd_5:
        LDR.N    R0,??DataTable27  ;; 0xa0000060
        LDR      R0,[R0, #+32]
        ANDS     R0,R1,R0
        LDR.N    R1,??DataTable27  ;; 0xa0000060
??FSMC_NANDECCCmd_3:
        STR      R0,[R1, #+32]
//  580     }
//  581   }
//  582 }
??FSMC_NANDECCCmd_6:
        BX       LR               ;; return
        DATA
??FSMC_NANDECCCmd_4:
        DC32     0xfffbf
        CFI EndBlock cfiBlock12

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable27:
        DC32     0xa0000060
//  583 
//  584 /*******************************************************************************
//  585 * Function Name  : FSMC_GetECC
//  586 * Description    : Returns the error correction code register value.
//  587 * Input          : - FSMC_Bank: specifies the FSMC Bank to be used
//  588 *                    This parameter can be one of the following values:
//  589 *                       - FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  590 *                       - FSMC_Bank3_NAND: FSMC Bank3 NAND
//  591 * Output         : None
//  592 * Return         : The Error Correction Code (ECC) value.
//  593 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function FSMC_GetECC
        THUMB
//  594 u32 FSMC_GetECC(u32 FSMC_Bank)
//  595 {
//  596   u32 eccval = 0x00000000;
//  597   
//  598   if(FSMC_Bank == FSMC_Bank2_NAND)
FSMC_GetECC:
        CMP      R0,#+16
        ITTEE    NE 
        LDRNE.N  R0,??FSMC_GetECC_0  ;; 0xa0000074
        LDRNE    R0,[R0, #+32]
//  599   {
//  600     /* Get the ECCR2 register value */
//  601     eccval = FSMC_Bank2->ECCR2;
        LDREQ.N  R0,??FSMC_GetECC_0  ;; 0xa0000074
        LDREQ    R0,[R0, #+0]
//  602   }
//  603   else
//  604   {
//  605     /* Get the ECCR3 register value */
//  606     eccval = FSMC_Bank3->ECCR3;
//  607   }
//  608   /* Return the error correction code value */
//  609   return(eccval);
        BX       LR               ;; return
        Nop      
        DATA
??FSMC_GetECC_0:
        DC32     0xa0000074
        CFI EndBlock cfiBlock13
//  610 }
//  611 
//  612 /*******************************************************************************
//  613 * Function Name  : FSMC_ITConfig
//  614 * Description    : Enables or disables the specified FSMC interrupts.
//  615 * Input          : - FSMC_Bank: specifies the FSMC Bank to be used
//  616 *                    This parameter can be one of the following values:
//  617 *                       - FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  618 *                       - FSMC_Bank3_NAND: FSMC Bank3 NAND
//  619 *                       - FSMC_Bank4_PCCARD: FSMC Bank4 PCCARD
//  620 *                  - FSMC_IT: specifies the FSMC interrupt sources to be
//  621 *                    enabled or disabled.
//  622 *                    This parameter can be any combination of the following values:
//  623 *                       - FSMC_IT_RisingEdge: Rising edge detection interrupt. 
//  624 *                       - FSMC_IT_Level: Level edge detection interrupt.                                  
//  625 *                       - FSMC_IT_FallingEdge: Falling edge detection interrupt.
//  626 *                  - NewState: new state of the specified FSMC interrupts.
//  627 *                    This parameter can be: ENABLE or DISABLE.
//  628 * Output         : None
//  629 * Return         : None
//  630 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function FSMC_ITConfig
        THUMB
//  631 void FSMC_ITConfig(u32 FSMC_Bank, u32 FSMC_IT, FunctionalState NewState)
//  632 {
//  633   assert_param(IS_FSMC_IT_BANK(FSMC_Bank));
//  634   assert_param(IS_FSMC_IT(FSMC_IT));	
//  635   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  636   
//  637   if (NewState != DISABLE)
FSMC_ITConfig:
        CBZ      R2,??FSMC_ITConfig_0
//  638   {
//  639     /* Enable the selected FSMC_Bank2 interrupts */
//  640     if(FSMC_Bank == FSMC_Bank2_NAND)
        CMP      R0,#+16
        BNE.N    ??FSMC_ITConfig_1
//  641     {
//  642       FSMC_Bank2->SR2 |= FSMC_IT;
        LDR.N    R0,??DataTable53  ;; 0xa0000064
        LDR      R2,[R0, #+0]
        ORRS     R1,R1,R2
??FSMC_ITConfig_2:
        STR      R1,[R0, #+0]
        BX       LR
//  643     }
//  644     /* Enable the selected FSMC_Bank3 interrupts */
//  645     else if (FSMC_Bank == FSMC_Bank3_NAND)
??FSMC_ITConfig_1:
        CMP      R0,#+256
        BNE.N    ??FSMC_ITConfig_3
//  646     {
//  647       FSMC_Bank3->SR3 |= FSMC_IT;
        LDR.N    R0,??DataTable53  ;; 0xa0000064
        LDR      R0,[R0, #+32]
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable53  ;; 0xa0000064
??FSMC_ITConfig_4:
        STR      R0,[R1, #+32]
        BX       LR
//  648     }
//  649     /* Enable the selected FSMC_Bank4 interrupts */
//  650     else
//  651     {
//  652       FSMC_Bank4->SR4 |= FSMC_IT;    
??FSMC_ITConfig_3:
        LDR.N    R0,??DataTable53  ;; 0xa0000064
        LDR      R0,[R0, #+64]
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable53  ;; 0xa0000064
        B.N      ??FSMC_ITConfig_5
//  653     }
//  654   }
//  655   else
//  656   {
//  657     /* Disable the selected FSMC_Bank2 interrupts */
//  658     if(FSMC_Bank == FSMC_Bank2_NAND)
??FSMC_ITConfig_0:
        MVNS     R1,R1
        CMP      R0,#+16
        BNE.N    ??FSMC_ITConfig_6
//  659     {
//  660       
//  661       FSMC_Bank2->SR2 &= (u32)~FSMC_IT;
        LDR.N    R0,??DataTable53  ;; 0xa0000064
        LDR      R2,[R0, #+0]
        ANDS     R1,R1,R2
        B.N      ??FSMC_ITConfig_2
//  662     }
//  663     /* Disable the selected FSMC_Bank3 interrupts */
//  664     else if (FSMC_Bank == FSMC_Bank3_NAND)
??FSMC_ITConfig_6:
        CMP      R0,#+256
        BNE.N    ??FSMC_ITConfig_7
//  665     {
//  666       FSMC_Bank3->SR3 &= (u32)~FSMC_IT;
        LDR.N    R0,??DataTable53  ;; 0xa0000064
        LDR      R0,[R0, #+32]
        ANDS     R0,R1,R0
        LDR.N    R1,??DataTable53  ;; 0xa0000064
        B.N      ??FSMC_ITConfig_4
//  667     }
//  668     /* Disable the selected FSMC_Bank4 interrupts */
//  669     else
//  670     {
//  671       FSMC_Bank4->SR4 &= (u32)~FSMC_IT;    
??FSMC_ITConfig_7:
        LDR.N    R0,??DataTable53  ;; 0xa0000064
        LDR      R0,[R0, #+64]
        ANDS     R0,R1,R0
        LDR.N    R1,??DataTable53  ;; 0xa0000064
??FSMC_ITConfig_5:
        STR      R0,[R1, #+64]
//  672     }
//  673   }
//  674 }
??FSMC_ITConfig_8:
        BX       LR               ;; return
        CFI EndBlock cfiBlock14
//  675                   
//  676 /*******************************************************************************
//  677 * Function Name  : FSMC_GetFlagStatus
//  678 * Description    : Checks whether the specified FSMC flag is set or not.
//  679 * Input          : - FSMC_Bank: specifies the FSMC Bank to be used
//  680 *                    This parameter can be one of the following values:
//  681 *                       - FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  682 *                       - FSMC_Bank3_NAND: FSMC Bank3 NAND
//  683 *                       - FSMC_Bank4_PCCARD: FSMC Bank4 PCCARD
//  684 *                  - FSMC_FLAG: specifies the flag to check.
//  685 *                    This parameter can be one of the following values:
//  686 *                       - FSMC_FLAG_RisingEdge: Rising egde detection Flag.
//  687 *                       - FSMC_FLAG_Level: Level detection Flag.
//  688 *                       - FSMC_FLAG_FallingEdge: Falling egde detection Flag.
//  689 *                       - FSMC_FLAG_FEMPT: Fifo empty Flag. 
//  690 * Output         : None
//  691 * Return         : The new state of FSMC_FLAG (SET or RESET).
//  692 *******************************************************************************/                   

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function FSMC_GetFlagStatus
        THUMB
//  693 FlagStatus FSMC_GetFlagStatus(u32 FSMC_Bank, u32 FSMC_FLAG)
//  694 {
//  695   FlagStatus bitstatus = RESET;
//  696   u32 tmpsr = 0x00000000;
//  697   
//  698   /* Check the parameters */
//  699   assert_param(IS_FSMC_GETFLAG_BANK(FSMC_Bank));
//  700   assert_param(IS_FSMC_GET_FLAG(FSMC_FLAG));
//  701   
//  702   if(FSMC_Bank == FSMC_Bank2_NAND)
FSMC_GetFlagStatus:
        CMP      R0,#+16
        BNE.N    ??FSMC_GetFlagStatus_0
//  703   {
//  704     tmpsr = FSMC_Bank2->SR2;
        LDR.N    R0,??DataTable53  ;; 0xa0000064
        LDR      R0,[R0, #+0]
        B.N      ??FSMC_GetFlagStatus_1
//  705   }  
//  706   else if(FSMC_Bank == FSMC_Bank3_NAND)
??FSMC_GetFlagStatus_0:
        CMP      R0,#+256
        ITTEE    NE 
        LDRNE.N  R0,??DataTable53  ;; 0xa0000064
        LDRNE    R0,[R0, #+64]
//  707   {
//  708     tmpsr = FSMC_Bank3->SR3;
        LDREQ.N  R0,??DataTable53  ;; 0xa0000064
        LDREQ    R0,[R0, #+32]
//  709   }
//  710   /* FSMC_Bank4_PCCARD*/
//  711   else
//  712   {
//  713     tmpsr = FSMC_Bank4->SR4;
//  714   } 
//  715   
//  716   /* Get the flag status */
//  717   if ((tmpsr & FSMC_FLAG) != (u16)RESET )
??FSMC_GetFlagStatus_1:
        ANDS     R0,R1,R0
        SUBS     R0,R0,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  718   {
//  719     bitstatus = SET;
//  720   }
//  721   else
//  722   {
//  723     bitstatus = RESET;
//  724   }
//  725   /* Return the flag status */
//  726   return bitstatus;
        BX       LR               ;; return
        CFI EndBlock cfiBlock15
//  727 }
//  728 
//  729 /*******************************************************************************
//  730 * Function Name  : FSMC_ClearFlag
//  731 * Description    : Clears the FSMC’s pending flags.
//  732 * Input          : - FSMC_Bank: specifies the FSMC Bank to be used
//  733 *                    This parameter can be one of the following values:
//  734 *                       - FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  735 *                       - FSMC_Bank3_NAND: FSMC Bank3 NAND
//  736 *                       - FSMC_Bank4_PCCARD: FSMC Bank4 PCCARD
//  737 *                  - FSMC_FLAG: specifies the flag to clear.
//  738 *                    This parameter can be any combination of the following values:
//  739 *                       - FSMC_FLAG_RisingEdge: Rising egde detection Flag.
//  740 *                       - FSMC_FLAG_Level: Level detection Flag.
//  741 *                       - FSMC_FLAG_FallingEdge: Falling egde detection Flag.
//  742 * Output         : None
//  743 * Return         : None
//  744 *******************************************************************************/                   

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function FSMC_ClearFlag
        THUMB
//  745 void FSMC_ClearFlag(u32 FSMC_Bank, u32 FSMC_FLAG)
//  746 {
//  747  /* Check the parameters */
//  748   assert_param(IS_FSMC_GETFLAG_BANK(FSMC_Bank));
//  749   assert_param(IS_FSMC_CLEAR_FLAG(FSMC_FLAG)) ;
//  750     
//  751   if(FSMC_Bank == FSMC_Bank2_NAND)
FSMC_ClearFlag:
        MVNS     R1,R1
        CMP      R0,#+16
        BNE.N    ??FSMC_ClearFlag_0
//  752   {
//  753     FSMC_Bank2->SR2 &= ~FSMC_FLAG; 
        LDR.N    R0,??DataTable53  ;; 0xa0000064
        LDR      R2,[R0, #+0]
        ANDS     R1,R1,R2
        STR      R1,[R0, #+0]
        BX       LR
//  754   }  
//  755   else if(FSMC_Bank == FSMC_Bank3_NAND)
??FSMC_ClearFlag_0:
        CMP      R0,#+256
        BNE.N    ??FSMC_ClearFlag_1
//  756   {
//  757     FSMC_Bank3->SR3 &= ~FSMC_FLAG;
        LDR.N    R0,??DataTable53  ;; 0xa0000064
        LDR      R0,[R0, #+32]
        ANDS     R0,R1,R0
        LDR.N    R1,??DataTable53  ;; 0xa0000064
        STR      R0,[R1, #+32]
        BX       LR
//  758   }
//  759   /* FSMC_Bank4_PCCARD*/
//  760   else
//  761   {
//  762     FSMC_Bank4->SR4 &= ~FSMC_FLAG;
??FSMC_ClearFlag_1:
        LDR.N    R0,??DataTable53  ;; 0xa0000064
        LDR      R0,[R0, #+64]
        ANDS     R0,R1,R0
        LDR.N    R1,??DataTable53  ;; 0xa0000064
        STR      R0,[R1, #+64]
//  763   }
//  764 }
??FSMC_ClearFlag_2:
        BX       LR               ;; return
        CFI EndBlock cfiBlock16
//  765 
//  766 /*******************************************************************************
//  767 * Function Name  : FSMC_GetITStatus
//  768 * Description    : Checks whether the specified FSMC interrupt has occurred or not.
//  769 * Input          : - FSMC_Bank: specifies the FSMC Bank to be used
//  770 *                    This parameter can be one of the following values:
//  771 *                       - FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  772 *                       - FSMC_Bank3_NAND: FSMC Bank3 NAND
//  773 *                       - FSMC_Bank4_PCCARD: FSMC Bank4 PCCARD
//  774 *                  - FSMC_IT: specifies the FSMC interrupt source to check.
//  775 *                    This parameter can be one of the following values:
//  776 *                       - FSMC_IT_RisingEdge: Rising edge detection interrupt. 
//  777 *                       - FSMC_IT_Level: Level edge detection interrupt.                                  
//  778 *                       - FSMC_IT_FallingEdge: Falling edge detection interrupt. 
//  779 * Output         : None
//  780 * Return         : The new state of FSMC_IT (SET or RESET).
//  781 *******************************************************************************/ 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function FSMC_GetITStatus
        THUMB
//  782 ITStatus FSMC_GetITStatus(u32 FSMC_Bank, u32 FSMC_IT)
//  783 {
//  784   ITStatus bitstatus = RESET;
//  785   u32 tmpsr = 0x0, itstatus = 0x0, itenable = 0x0; 
//  786   
//  787   /* Check the parameters */
//  788   assert_param(IS_FSMC_IT_BANK(FSMC_Bank));
//  789   assert_param(IS_FSMC_GET_IT(FSMC_IT));
//  790   
//  791   if(FSMC_Bank == FSMC_Bank2_NAND)
FSMC_GetITStatus:
        CMP      R0,#+16
        BNE.N    ??FSMC_GetITStatus_0
//  792   {
//  793     tmpsr = FSMC_Bank2->SR2;
        LDR.N    R0,??DataTable53  ;; 0xa0000064
        LDR      R0,[R0, #+0]
        B.N      ??FSMC_GetITStatus_1
//  794   }  
//  795   else if(FSMC_Bank == FSMC_Bank3_NAND)
??FSMC_GetITStatus_0:
        CMP      R0,#+256
        ITTEE    NE 
        LDRNE.N  R0,??DataTable53  ;; 0xa0000064
        LDRNE    R0,[R0, #+64]
//  796   {
//  797     tmpsr = FSMC_Bank3->SR3;
        LDREQ.N  R0,??DataTable53  ;; 0xa0000064
        LDREQ    R0,[R0, #+32]
//  798   }
//  799   /* FSMC_Bank4_PCCARD*/
//  800   else
//  801   {
//  802     tmpsr = FSMC_Bank4->SR4;
//  803   } 
//  804   
//  805   itstatus = tmpsr & FSMC_IT;
//  806   
//  807   itenable = tmpsr & (FSMC_IT >> 3);
??FSMC_GetITStatus_1:
        AND      R2,R0,R1, LSR #+3
//  808 
//  809   if ((itstatus != (u32)RESET)  && (itenable != (u32)RESET))
        TST      R1,R0
        BEQ.N    ??FSMC_GetITStatus_2
        SUBS     R0,R2,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
        BX       LR
//  810   {
//  811     bitstatus = SET;
//  812   }
//  813   else
//  814   {
//  815     bitstatus = RESET;
??FSMC_GetITStatus_2:
        MOVS     R0,#+0
//  816   }
//  817   return bitstatus; 
??FSMC_GetITStatus_3:
        BX       LR               ;; return
        CFI EndBlock cfiBlock17
//  818 }
//  819 
//  820 /*******************************************************************************
//  821 * Function Name  : FSMC_ClearITPendingBit
//  822 * Description    : Clears the FSMC’s interrupt pending bits.
//  823 * Input          : - FSMC_Bank: specifies the FSMC Bank to be used
//  824 *                    This parameter can be one of the following values:
//  825 *                       - FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  826 *                       - FSMC_Bank3_NAND: FSMC Bank3 NAND
//  827 *                       - FSMC_Bank4_PCCARD: FSMC Bank4 PCCARD
//  828 *                  - FSMC_IT: specifies the interrupt pending bit to clear.
//  829 *                    This parameter can be any combination of the following values:
//  830 *                       - FSMC_IT_RisingEdge: Rising edge detection interrupt. 
//  831 *                       - FSMC_IT_Level: Level edge detection interrupt.                                  
//  832 *                       - FSMC_IT_FallingEdge: Falling edge detection interrupt.
//  833 * Output         : None
//  834 * Return         : None
//  835 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function FSMC_ClearITPendingBit
        THUMB
//  836 void FSMC_ClearITPendingBit(u32 FSMC_Bank, u32 FSMC_IT)
//  837 {
//  838   /* Check the parameters */
//  839   assert_param(IS_FSMC_IT_BANK(FSMC_Bank));
//  840   assert_param(IS_FSMC_IT(FSMC_IT));
//  841     
//  842   if(FSMC_Bank == FSMC_Bank2_NAND)
FSMC_ClearITPendingBit:
        MVN      R1,R1, LSR #+3
        CMP      R0,#+16
        BNE.N    ??FSMC_ClearITPendingBit_0
//  843   {
//  844     FSMC_Bank2->SR2 &= ~(FSMC_IT >> 3); 
        LDR.N    R0,??DataTable53  ;; 0xa0000064
        LDR      R2,[R0, #+0]
        ANDS     R1,R1,R2
        STR      R1,[R0, #+0]
        BX       LR
//  845   }  
//  846   else if(FSMC_Bank == FSMC_Bank3_NAND)
??FSMC_ClearITPendingBit_0:
        CMP      R0,#+256
        BNE.N    ??FSMC_ClearITPendingBit_1
//  847   {
//  848     FSMC_Bank3->SR3 &= ~(FSMC_IT >> 3);
        LDR.N    R0,??DataTable53  ;; 0xa0000064
        LDR      R0,[R0, #+32]
        ANDS     R0,R1,R0
        LDR.N    R1,??DataTable53  ;; 0xa0000064
        STR      R0,[R1, #+32]
        BX       LR
//  849   }
//  850   /* FSMC_Bank4_PCCARD*/
//  851   else
//  852   {
//  853     FSMC_Bank4->SR4 &= ~(FSMC_IT >> 3);
??FSMC_ClearITPendingBit_1:
        LDR.N    R0,??DataTable53  ;; 0xa0000064
        LDR      R0,[R0, #+64]
        ANDS     R0,R1,R0
        LDR.N    R1,??DataTable53  ;; 0xa0000064
        STR      R0,[R1, #+64]
//  854   }
//  855 }
??FSMC_ClearITPendingBit_2:
        BX       LR               ;; return
        CFI EndBlock cfiBlock18

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable53:
        DC32     0xa0000064

        END
//  856 
//  857 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
// 1 186 bytes in section .text
// 
// 1 186 bytes of CODE memory
//
//Errors: none
//Warnings: none
