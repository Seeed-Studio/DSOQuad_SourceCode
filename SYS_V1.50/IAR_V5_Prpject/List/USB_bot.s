///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:03:42 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\SYS_V1.50\source\USB_bot.c             /
//    Command line =  E:\Mini-DS\DS203\SYS_V1.50\source\USB_bot.c -lA         /
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
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\USB_bot. /
//                    s                                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME USB_bot

        EXTERN GetEPRxCount
        EXTERN Max_Lun
        EXTERN PMAToUserBufferCopy
        EXTERN SCSI_Format_Cmd
        EXTERN SCSI_Inquiry_Cmd
        EXTERN SCSI_Invalid_Cmd
        EXTERN SCSI_ModeSense10_Cmd
        EXTERN SCSI_ModeSense6_Cmd
        EXTERN SCSI_Read10_Cmd
        EXTERN SCSI_ReadCapacity10_Cmd
        EXTERN SCSI_ReadFormatCapacity_Cmd
        EXTERN SCSI_RequestSense_Cmd
        EXTERN SCSI_Start_Stop_Unit_Cmd
        EXTERN SCSI_TestUnitReady_Cmd
        EXTERN SCSI_Verify10_Cmd
        EXTERN SCSI_Write10_Cmd
        EXTERN SetEPRxStatus
        EXTERN SetEPTxCount
        EXTERN SetEPTxStatus
        EXTERN Set_Scsi_Sense_Data
        EXTERN UserToPMABufferCopy
        EXTERN __aeabi_memcpy4

        PUBLIC Bot_Abort
        PUBLIC Bot_State
        PUBLIC Bulk_Data_Buff
        PUBLIC CBW
        PUBLIC CBW_Decode
        PUBLIC CSW
        PUBLIC Data_Len
        PUBLIC Mass_Storage_In
        PUBLIC Mass_Storage_Out
        PUBLIC SCSI_BlkLen
        PUBLIC SCSI_LBA
        PUBLIC Set_CSW
        PUBLIC Transfer_Data_Request
        
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
        
// E:\Mini-DS\DS203\SYS_V1.50\source\USB_bot.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : usb_bot.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.2.1
//    5 * Date               : 09/22/2008
//    6 * Description        : BOT State Machine management
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
//   17 #include "USB_scsi.h"
//   18 #include "Config.h"
//   19 #include "USB_regs.h"
//   20 #include "USB_mem.h"
//   21 #include "USB_conf.h"
//   22 #include "USB_bot.h"
//   23 #include "Memory.h"
//   24 /* Private typedef -----------------------------------------------------------*/
//   25 /* Private define ------------------------------------------------------------*/
//   26 /* Private macro -------------------------------------------------------------*/
//   27 /* Private variables ---------------------------------------------------------*/

        SECTION `.bss`:DATA:NOROOT(2)
//   28 u8 Bot_State;
//   29 u8 Bulk_Data_Buff[BULK_MAX_PACKET_SIZE];  /* data buffer*/
//   30 u16 Data_Len;
//   31 Bulk_Only_CBW CBW;
CBW:
        DS8 32
//   32 Bulk_Only_CSW CSW;
CSW:
        DS8 16
Bot_State:
        DS8 1
        DS8 1
Data_Len:
        DS8 2
Bulk_Data_Buff:
        DS8 64
//   33 u32 SCSI_LBA , SCSI_BlkLen;
SCSI_LBA:
        DS8 4
SCSI_BlkLen:
        DS8 4
//   34 extern u32 Max_Lun;
//   35 /* Extern variables ----------------------------------------------------------*/
//   36 /* Private function prototypes -----------------------------------------------*/
//   37 /* Extern function prototypes ------------------------------------------------*/
//   38 /* Private functions ---------------------------------------------------------*/
//   39 
//   40 /*******************************************************************************
//   41 * Function Name  : Mass_Storage_In
//   42 * Description    : Mass Storage IN transfer.
//   43 * Input          : None.
//   44 * Output         : None.
//   45 * Return         : None.
//   46 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Mass_Storage_In
        THUMB
//   47 void Mass_Storage_In (void)
//   48 {
Mass_Storage_In:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//   49   switch (Bot_State)
        LDR.N    R0,??DataTable4  ;; CBW
        LDRB     R1,[R0, #+48]
        SUBS     R1,R1,#+2
        BEQ.N    ??Mass_Storage_In_0
        SUBS     R1,R1,#+1
        BEQ.N    ??Mass_Storage_In_1
        SUBS     R1,R1,#+1
        CMP      R1,#+1
        BHI.N    ??Mass_Storage_In_2
//   50   {
//   51     case BOT_CSW_Send:
//   52     case BOT_ERROR:
//   53       Bot_State = BOT_IDLE;
        MOVS     R1,#+0
        STRB     R1,[R0, #+48]
//   54       SetEPRxStatus(ENDP2, EP_RX_VALID);/* enable the Endpoint to recive the next cmd*/
        MOV      R1,#+12288
        B.N      ??Mass_Storage_In_3
//   55       break;
//   56     case BOT_DATA_IN:
//   57       switch (CBW.CB[0])
??Mass_Storage_In_0:
        LDRB     R1,[R0, #+15]
        CMP      R1,#+40
        BNE.N    ??Mass_Storage_In_2
//   58       {
//   59         case SCSI_READ10:
//   60           SCSI_Read10_Cmd(SCSI_LBA , SCSI_BlkLen);
        LDR      R1,[R0, #+120]
        LDR      R0,[R0, #+116]
        BL       SCSI_Read10_Cmd
        B.N      ??Mass_Storage_In_2
//   61           break;
//   62       }
//   63       break;
//   64     case BOT_DATA_IN_LAST:
//   65       Set_CSW (CSW_CMD_PASSED, SEND_CSW_ENABLE);
??Mass_Storage_In_1:
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       Set_CSW
//   66       SetEPRxStatus(ENDP2, EP_RX_VALID);
        MOV      R1,#+12288
??Mass_Storage_In_3:
        MOVS     R0,#+2
        BL       SetEPRxStatus
//   67       break;
//   68 
//   69     default:
//   70       break;
//   71   }
//   72 }
??Mass_Storage_In_2:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock0
//   73 
//   74 /*******************************************************************************
//   75 * Function Name  : Mass_Storage_Out
//   76 * Description    : Mass Storage OUT transfer.
//   77 * Input          : None.
//   78 * Output         : None.
//   79 * Return         : None.
//   80 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function Mass_Storage_Out
        THUMB
//   81 void Mass_Storage_Out (void)
//   82 {
Mass_Storage_Out:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//   83   u8 CMD;
//   84   CMD = CBW.CB[0];
        LDR.N    R4,??DataTable4  ;; CBW
        LDRB     R5,[R4, #+15]
//   85   Data_Len = GetEPRxCount(ENDP2);
        MOVS     R0,#+2
        BL       GetEPRxCount
        STRH     R0,[R4, #+50]
//   86 
//   87   PMAToUserBufferCopy(Bulk_Data_Buff, ENDP2_RXADDR, Data_Len);
        MOV      R2,R0
        MOVS     R1,#+216
        ADD      R0,R4,#+52
        BL       PMAToUserBufferCopy
//   88 
//   89   switch (Bot_State)
        LDRB     R0,[R4, #+48]
        CBZ      R0,??Mass_Storage_Out_0
        CMP      R0,#+1
        BEQ.N    ??Mass_Storage_Out_1
        B.N      ??Mass_Storage_Out_2
//   90   {
//   91     case BOT_IDLE:
//   92       CBW_Decode();
??Mass_Storage_Out_0:
        BL       CBW_Decode
        B.N      ??Mass_Storage_Out_3
//   93       break;
//   94     case BOT_DATA_OUT:
//   95       if (CMD == SCSI_WRITE10)
??Mass_Storage_Out_1:
        CMP      R5,#+42
        BNE.N    ??Mass_Storage_Out_4
//   96       {
//   97         SCSI_Write10_Cmd(SCSI_LBA , SCSI_BlkLen);
        LDR      R1,[R4, #+120]
        LDR      R0,[R4, #+116]
        BL       SCSI_Write10_Cmd
//   98         break;
        B.N      ??Mass_Storage_Out_3
//   99       }
//  100       Bot_Abort(DIR_OUT);
//  101       Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_FIELED_IN_COMMAND);
//  102       Set_CSW (CSW_PHASE_ERROR, SEND_CSW_DISABLE);
//  103       break;
//  104     default:
//  105       Bot_Abort(BOTH_DIR);
??Mass_Storage_Out_2:
        MOVS     R0,#+2
??Mass_Storage_Out_4:
        BL       Bot_Abort
//  106       Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_FIELED_IN_COMMAND);
        MOVS     R1,#+36
        MOVS     R0,#+5
        BL       Set_Scsi_Sense_Data
//  107       Set_CSW (CSW_PHASE_ERROR, SEND_CSW_DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+2
        BL       Set_CSW
//  108       break;
//  109   }
//  110 }
??Mass_Storage_Out_3:
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        CFI EndBlock cfiBlock1
//  111 
//  112 /*******************************************************************************
//  113 * Function Name  : CBW_Decode
//  114 * Description    : Decode the received CBW and call the related SCSI command
//  115 *                 routine.
//  116 * Input          : None.
//  117 * Output         : None.
//  118 * Return         : None.
//  119 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function CBW_Decode
        THUMB
//  120 void CBW_Decode(void)
//  121 {
CBW_Decode:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  122   u32 Counter;
//  123 
//  124   for (Counter = 0; Counter < Data_Len; Counter++)
        LDR.N    R4,??DataTable4  ;; CBW
        LDRH     R2,[R4, #+50]
        CBZ      R2,??CBW_Decode_0
//  125   {
//  126     *((u8 *)&CBW + Counter) = Bulk_Data_Buff[Counter];
        ADD      R1,R4,#+52
        MOVS     R0,R4
        BL       __aeabi_memcpy4
//  127   }
//  128   CSW.dTag = CBW.dTag;
??CBW_Decode_0:
        LDR      R0,[R4, #+4]
        STR      R0,[R4, #+36]
//  129   CSW.dDataResidue = CBW.dDataLength;
        LDR      R0,[R4, #+8]
        STR      R0,[R4, #+40]
//  130   if (Data_Len != BOT_CBW_PACKET_LENGTH)
        LDRH     R0,[R4, #+50]
        CMP      R0,#+31
        BEQ.N    ??CBW_Decode_1
//  131   {
//  132     Bot_Abort(BOTH_DIR);
        MOVS     R0,#+2
        BL       Bot_Abort
//  133     /* reset the CBW.dSignature to desible the clear feature until receiving a Mass storage reset*/
//  134     CBW.dSignature = 0;
        MOVS     R0,#+0
        STR      R0,[R4, #+0]
//  135     Set_Scsi_Sense_Data(ILLEGAL_REQUEST, PARAMETER_LIST_LENGTH_ERROR);
        MOVS     R1,#+26
        B.N      ??CBW_Decode_2
//  136     Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
//  137     return;
//  138   }
//  139 
//  140   if ((CBW.CB[0] == SCSI_READ10 ) || (CBW.CB[0] == SCSI_WRITE10 ))
??CBW_Decode_1:
        LDRB     R0,[R4, #+15]
        CMP      R0,#+40
        BEQ.N    ??CBW_Decode_3
        CMP      R0,#+42
        BNE.N    ??CBW_Decode_4
//  141   {
//  142     /* Calculate Logical Block Address */
//  143     SCSI_LBA = (CBW.CB[2] << 24) | (CBW.CB[3] << 16) | (CBW.CB[4] <<  8) | CBW.CB[5];
??CBW_Decode_3:
        LDRB     R1,[R4, #+17]
        LDRB     R2,[R4, #+18]
        LSLS     R2,R2,#+16
        ORR      R1,R2,R1, LSL #+24
        LDRB     R2,[R4, #+19]
        ORR      R1,R1,R2, LSL #+8
        LDRB     R2,[R4, #+20]
        ORRS     R1,R2,R1
        STR      R1,[R4, #+116]
//  144     /* Calculate the Number of Blocks to transfer */
//  145     SCSI_BlkLen = (CBW.CB[7] <<  8) | CBW.CB[8];
        LDRB     R1,[R4, #+22]
        LDRB     R2,[R4, #+23]
        ORR      R1,R2,R1, LSL #+8
        STR      R1,[R4, #+120]
//  146   }
//  147 
//  148   if (CBW.dSignature == BOT_CBW_SIGNATURE)
??CBW_Decode_4:
        LDR      R1,[R4, #+0]
        LDR.N    R2,??CBW_Decode_5  ;; 0x43425355
        CMP      R1,R2
        BNE.N    ??CBW_Decode_6
//  149   {
//  150     /* Valid CBW */
//  151     if ((CBW.bLUN > Max_Lun) || (CBW.bCBLength < 1) || (CBW.bCBLength > 16))
        LDR.N    R1,??CBW_Decode_5+0x4  ;; Max_Lun
        LDR      R1,[R1, #+0]
        LDRB     R2,[R4, #+13]
        CMP      R1,R2
        BCC.N    ??CBW_Decode_7
        LDRB     R1,[R4, #+14]
        CBZ      R1,??CBW_Decode_7
        CMP      R1,#+17
        BCC.N    ??CBW_Decode_8
//  152     {
//  153       Bot_Abort(BOTH_DIR);
??CBW_Decode_7:
        MOVS     R0,#+2
        BL       Bot_Abort
//  154       Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_FIELED_IN_COMMAND);
        MOVS     R1,#+36
        B.N      ??CBW_Decode_2
//  155       Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
//  156     }
//  157     else
//  158     {
//  159       switch (CBW.CB[0])
??CBW_Decode_8:
        CMP      R0,#+0
        BEQ.N    ??CBW_Decode_9
        CMP      R0,#+3
        BEQ.N    ??CBW_Decode_10
        CMP      R0,#+4
        BEQ.N    ??CBW_Decode_11
        CMP      R0,#+8
        BEQ.N    ??CBW_Decode_12
        CMP      R0,#+10
        BEQ.N    ??CBW_Decode_12
        CMP      R0,#+18
        BEQ.N    ??CBW_Decode_13
        CMP      R0,#+21
        BEQ.N    ??CBW_Decode_12
        CMP      R0,#+26
        BEQ.N    ??CBW_Decode_14
        CMP      R0,#+27
        BEQ.N    ??CBW_Decode_15
        CMP      R0,#+29
        BEQ.N    ??CBW_Decode_12
        CMP      R0,#+30
        BEQ.N    ??CBW_Decode_15
        CMP      R0,#+35
        BEQ.N    ??CBW_Decode_16
        CMP      R0,#+37
        BEQ.N    ??CBW_Decode_17
        CMP      R0,#+40
        BEQ.N    ??CBW_Decode_18
        CMP      R0,#+42
        BEQ.N    ??CBW_Decode_19
        CMP      R0,#+47
        BEQ.N    ??CBW_Decode_20
        CMP      R0,#+85
        BEQ.N    ??CBW_Decode_12
        CMP      R0,#+90
        BEQ.N    ??CBW_Decode_21
        CMP      R0,#+136
        BEQ.N    ??CBW_Decode_12
        CMP      R0,#+138
        BEQ.N    ??CBW_Decode_12
        CMP      R0,#+143
        BEQ.N    ??CBW_Decode_12
        CMP      R0,#+158
        BEQ.N    ??CBW_Decode_12
        CMP      R0,#+168
        BEQ.N    ??CBW_Decode_12
        CMP      R0,#+170
        BEQ.N    ??CBW_Decode_12
        CMP      R0,#+175
        BEQ.N    ??CBW_Decode_12
        B.N      ??CBW_Decode_6
//  160       {
//  161         case SCSI_REQUEST_SENSE:
//  162           SCSI_RequestSense_Cmd ();
??CBW_Decode_10:
        BL       SCSI_RequestSense_Cmd
        POP      {R4,PC}
//  163           break;
//  164         case SCSI_INQUIRY:
//  165           SCSI_Inquiry_Cmd();
??CBW_Decode_13:
        BL       SCSI_Inquiry_Cmd
        POP      {R4,PC}
//  166           break;
//  167         case SCSI_START_STOP_UNIT:
//  168           SCSI_Start_Stop_Unit_Cmd();
??CBW_Decode_15:
        BL       SCSI_Start_Stop_Unit_Cmd
        POP      {R4,PC}
//  169           break;
//  170         case SCSI_ALLOW_MEDIUM_REMOVAL:
//  171           SCSI_Start_Stop_Unit_Cmd();
//  172           break;
//  173         case SCSI_MODE_SENSE6:
//  174           SCSI_ModeSense6_Cmd ();
??CBW_Decode_14:
        BL       SCSI_ModeSense6_Cmd
        POP      {R4,PC}
//  175           break;
//  176         case SCSI_MODE_SENSE10:
//  177           SCSI_ModeSense10_Cmd ();
??CBW_Decode_21:
        BL       SCSI_ModeSense10_Cmd
        POP      {R4,PC}
//  178           break;
//  179         case SCSI_READ_FORMAT_CAPACITIES:
//  180           SCSI_ReadFormatCapacity_Cmd();
??CBW_Decode_16:
        BL       SCSI_ReadFormatCapacity_Cmd
        POP      {R4,PC}
//  181           break;
//  182         case SCSI_READ_CAPACITY10:
//  183           SCSI_ReadCapacity10_Cmd();
??CBW_Decode_17:
        BL       SCSI_ReadCapacity10_Cmd
        POP      {R4,PC}
//  184           break;
//  185         case SCSI_TEST_UNIT_READY:
//  186           SCSI_TestUnitReady_Cmd();
??CBW_Decode_9:
        BL       SCSI_TestUnitReady_Cmd
        POP      {R4,PC}
//  187           break;
//  188         case SCSI_READ10:
//  189           SCSI_Read10_Cmd(SCSI_LBA , SCSI_BlkLen);
??CBW_Decode_18:
        LDR      R1,[R4, #+120]
        LDR      R0,[R4, #+116]
        BL       SCSI_Read10_Cmd
        POP      {R4,PC}
//  190           break;
//  191         case SCSI_WRITE10:
//  192           SCSI_Write10_Cmd(SCSI_LBA , SCSI_BlkLen);
??CBW_Decode_19:
        LDR      R1,[R4, #+120]
        LDR      R0,[R4, #+116]
        BL       SCSI_Write10_Cmd
        POP      {R4,PC}
//  193           break;
//  194         case SCSI_VERIFY10:
//  195           SCSI_Verify10_Cmd();
??CBW_Decode_20:
        BL       SCSI_Verify10_Cmd
        POP      {R4,PC}
//  196           break;
//  197         case SCSI_FORMAT_UNIT:
//  198           SCSI_Format_Cmd();
??CBW_Decode_11:
        BL       SCSI_Format_Cmd
        POP      {R4,PC}
//  199           break;
//  200           /*Unsupported command*/
//  201 
//  202         case SCSI_MODE_SELECT10:
//  203           SCSI_Mode_Select10_Cmd();
??CBW_Decode_12:
        BL       SCSI_Invalid_Cmd
        POP      {R4,PC}
//  204           break;
//  205         case SCSI_MODE_SELECT6:
//  206           SCSI_Mode_Select6_Cmd();
//  207           break;
//  208 
//  209         case SCSI_SEND_DIAGNOSTIC:
//  210           SCSI_Send_Diagnostic_Cmd();
//  211           break;
//  212         case SCSI_READ6:
//  213           SCSI_Read6_Cmd();
//  214           break;
//  215         case SCSI_READ12:
//  216           SCSI_Read12_Cmd();
//  217           break;
//  218         case SCSI_READ16:
//  219           SCSI_Read16_Cmd();
//  220           break;
//  221         case SCSI_READ_CAPACITY16:
//  222           SCSI_READ_CAPACITY16_Cmd();
//  223           break;
//  224         case SCSI_WRITE6:
//  225           SCSI_Write6_Cmd();
//  226           break;
//  227         case SCSI_WRITE12:
//  228           SCSI_Write12_Cmd();
//  229           break;
//  230         case SCSI_WRITE16:
//  231           SCSI_Write16_Cmd();
//  232           break;
//  233         case SCSI_VERIFY12:
//  234           SCSI_Verify12_Cmd();
//  235           break;
//  236         case SCSI_VERIFY16:
//  237           SCSI_Verify16_Cmd();
//  238           break;
//  239 
//  240         default:
//  241         {
//  242           Bot_Abort(BOTH_DIR);
??CBW_Decode_6:
        MOVS     R0,#+2
        BL       Bot_Abort
//  243           Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_COMMAND);
        MOVS     R1,#+32
??CBW_Decode_2:
        MOVS     R0,#+5
        BL       Set_Scsi_Sense_Data
//  244           Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       Set_CSW
??CBW_Decode_22:
        POP      {R4,PC}          ;; return
        DATA
??CBW_Decode_5:
        DC32     0x43425355
        DC32     Max_Lun
        CFI EndBlock cfiBlock2
//  245         }
//  246       }
//  247     }
//  248   }
//  249   else
//  250   {
//  251     /* Invalid CBW */
//  252     Bot_Abort(BOTH_DIR);
//  253     Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_COMMAND);
//  254     Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
//  255   }
//  256 }
//  257 
//  258 /*******************************************************************************
//  259 * Function Name  : Transfer_Data_Request
//  260 * Description    : Send the request response to the PC HOST.
//  261 * Input          : u8* Data_Address : point to the data to transfer.
//  262 *                  u16 Data_Length : the nember of Bytes to transfer.
//  263 * Output         : None.
//  264 * Return         : None.
//  265 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Transfer_Data_Request
        THUMB
//  266 void Transfer_Data_Request(u8* Data_Pointer, u16 Data_Len)
//  267 {
Transfer_Data_Request:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        MOVS     R4,R1
//  268   UserToPMABufferCopy(Data_Pointer, ENDP1_TXADDR, Data_Len);
        MOVS     R2,R4
        MOVS     R1,#+152
        BL       UserToPMABufferCopy
//  269 
//  270   SetEPTxCount(ENDP1, Data_Len);
        MOVS     R1,R4
        MOVS     R0,#+1
        BL       SetEPTxCount
//  271   SetEPTxStatus(ENDP1, EP_TX_VALID);
        MOVS     R1,#+48
        MOVS     R0,#+1
        BL       SetEPTxStatus
//  272   Bot_State = BOT_DATA_IN_LAST;
        LDR.N    R0,??DataTable4  ;; CBW
        MOVS     R1,#+3
        STRB     R1,[R0, #+48]
//  273   CSW.dDataResidue -= Data_Len;
        LDR      R1,[R0, #+40]
        SUBS     R1,R1,R4
        STR      R1,[R0, #+40]
//  274   CSW.bStatus = CSW_CMD_PASSED;
        MOVS     R1,#+0
        STRB     R1,[R0, #+44]
//  275 }
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock3
//  276 
//  277 /*******************************************************************************
//  278 * Function Name  : Set_CSW
//  279 * Description    : Set the SCW with the needed fields.
//  280 * Input          : u8 CSW_Status this filed can be CSW_CMD_PASSED,CSW_CMD_FAILED,
//  281 *                  or CSW_PHASE_ERROR.
//  282 * Output         : None.
//  283 * Return         : None.
//  284 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Set_CSW
        THUMB
//  285 void Set_CSW (u8 CSW_Status, u8 Send_Permission)
//  286 {
Set_CSW:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
        MOVS     R4,R1
//  287   CSW.dSignature = BOT_CSW_SIGNATURE;
        LDR.N    R5,??DataTable4  ;; CBW
        LDR.N    R1,??Set_CSW_0   ;; 0x53425355
        STR      R1,[R5, #+32]
//  288   CSW.bStatus = CSW_Status;
        STRB     R0,[R5, #+44]
//  289 
//  290   UserToPMABufferCopy(((u8 *)& CSW), ENDP1_TXADDR, CSW_DATA_LENGTH);
        MOVS     R2,#+13
        MOVS     R1,#+152
        ADD      R0,R5,#+32
        BL       UserToPMABufferCopy
//  291 
//  292   SetEPTxCount(ENDP1, CSW_DATA_LENGTH);
        MOVS     R1,#+13
        MOVS     R0,#+1
        BL       SetEPTxCount
//  293   Bot_State = BOT_ERROR;
        MOVS     R0,#+5
        STRB     R0,[R5, #+48]
//  294   if (Send_Permission)
        CBZ      R4,??Set_CSW_1
//  295   {
//  296     Bot_State = BOT_CSW_Send;
        MOVS     R0,#+4
        STRB     R0,[R5, #+48]
//  297     SetEPTxStatus(ENDP1, EP_TX_VALID);
        MOVS     R1,#+48
        MOVS     R0,#+1
        BL       SetEPTxStatus
//  298   }
//  299 
//  300 }
??Set_CSW_1:
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        Nop      
        DATA
??Set_CSW_0:
        DC32     0x53425355
        CFI EndBlock cfiBlock4

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable4:
        DC32     CBW
//  301 
//  302 /*******************************************************************************
//  303 * Function Name  : Bot_Abort
//  304 * Description    : Stall the needed Endpoint according to the selected direction.
//  305 * Input          : Endpoint direction IN, OUT or both directions
//  306 * Output         : None.
//  307 * Return         : None.
//  308 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function Bot_Abort
        THUMB
//  309 void Bot_Abort(u8 Direction)
//  310 {
Bot_Abort:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  311   switch (Direction)
        CBZ      R0,??Bot_Abort_0
        CMP      R0,#+1
        BEQ.N    ??Bot_Abort_1
        CMP      R0,#+2
        BEQ.N    ??Bot_Abort_2
        B.N      ??Bot_Abort_3
//  312   {
//  313     case DIR_IN :
//  314       SetEPTxStatus(ENDP1, EP_TX_STALL);
??Bot_Abort_0:
        MOVS     R1,#+16
        MOVS     R0,#+1
        BL       SetEPTxStatus
        B.N      ??Bot_Abort_3
//  315       break;
//  316     case DIR_OUT :
//  317       SetEPRxStatus(ENDP2, EP_RX_STALL);
??Bot_Abort_1:
        MOV      R1,#+4096
        B.N      ??Bot_Abort_4
//  318       break;
//  319     case BOTH_DIR :
//  320       SetEPTxStatus(ENDP1, EP_TX_STALL);
??Bot_Abort_2:
        MOVS     R1,#+16
        MOVS     R0,#+1
        BL       SetEPTxStatus
//  321       SetEPRxStatus(ENDP2, EP_RX_STALL);
        MOV      R1,#+4096
??Bot_Abort_4:
        MOVS     R0,#+2
        BL       SetEPRxStatus
//  322       break;
//  323     default:
//  324       break;
//  325   }
//  326 }
??Bot_Abort_3:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock5

        END
//  327 
//  328 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
// 124 bytes in section .bss
// 680 bytes in section .text
// 
// 680 bytes of CODE memory
// 124 bytes of DATA memory
//
//Errors: none
//Warnings: none
