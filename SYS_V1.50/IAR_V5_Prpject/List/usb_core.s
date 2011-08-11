///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:04:00 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\USBLib\src\usb_core.c                  /
//    Command line =  E:\Mini-DS\DS203\USBLib\src\usb_core.c -lA              /
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
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\usb_core /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME usb_core

        EXTERN ByteSwap
        EXTERN ClearDTOG_RX
        EXTERN ClearDTOG_TX
        EXTERN Device_Property
        EXTERN Device_Table
        EXTERN GetEPRxAddr
        EXTERN GetEPTxAddr
        EXTERN PMAToUserBufferCopy
        EXTERN SaveRState
        EXTERN SaveTState
        EXTERN SetEPRxCount
        EXTERN SetEPTxCount
        EXTERN SetEPTxStatus
        EXTERN UserToPMABufferCopy
        EXTERN pInformation
        EXTERN pProperty
        EXTERN pUser_Standard_Requests

        PUBLIC Data_Mul_MaxPacketSize
        PUBLIC In0_Process
        PUBLIC NOP_Process
        PUBLIC Out0_Process
        PUBLIC Post0_Process
        PUBLIC SetDeviceAddress
        PUBLIC Setup0_Process
        PUBLIC Standard_ClearFeature
        PUBLIC Standard_GetConfiguration
        PUBLIC Standard_GetDescriptorData
        PUBLIC Standard_GetInterface
        PUBLIC Standard_GetStatus
        PUBLIC Standard_SetConfiguration
        PUBLIC Standard_SetDeviceFeature
        PUBLIC Standard_SetEndPointFeature
        PUBLIC Standard_SetInterface
        PUBLIC StatusInfo
        
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
        
// E:\Mini-DS\DS203\USBLib\src\usb_core.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : usb_core.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.2.1
//    5 * Date               : 09/22/2008
//    6 * Description        : Standard protocol processing (USB v2.0)
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
//   17 #include "usb_lib.h"
//   18 /* Private typedef -----------------------------------------------------------*/
//   19 /* Private define ------------------------------------------------------------*/
//   20 #define ValBit(VAR,Place)    (VAR & (1 << Place))
//   21 #define SetBit(VAR,Place)    (VAR |= (1 << Place))
//   22 #define ClrBit(VAR,Place)    (VAR &= ((1 << Place) ^ 255))
//   23 
//   24 #define Send0LengthData() { _SetEPTxCount(ENDP0, 0); \ 
//   25     vSetEPTxStatus(EP_TX_VALID); \ 
//   26   }
//   27 
//   28 #define vSetEPRxStatus(st) (SaveRState = st)
//   29 #define vSetEPTxStatus(st) (SaveTState = st)
//   30 
//   31 #define USB_StatusIn() Send0LengthData()
//   32 #define USB_StatusOut() vSetEPRxStatus(EP_RX_VALID)
//   33 
//   34 #define StatusInfo0 StatusInfo.bw.bb1 /* Reverse bb0 & bb1 */
//   35 #define StatusInfo1 StatusInfo.bw.bb0
//   36 
//   37 /* Private macro -------------------------------------------------------------*/
//   38 /* Private variables ---------------------------------------------------------*/

        SECTION `.bss`:DATA:NOROOT(2)
//   39 u16_u8 StatusInfo;
StatusInfo:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(0)
//   40 bool Data_Mul_MaxPacketSize = FALSE;
Data_Mul_MaxPacketSize:
        DS8 1
//   41 /* Private function prototypes -----------------------------------------------*/
//   42 static void DataStageOut(void);
//   43 static void DataStageIn(void);
//   44 static void NoData_Setup0(void);
//   45 static void Data_Setup0(void);
//   46 /* Private functions ---------------------------------------------------------*/
//   47 
//   48 /*******************************************************************************
//   49 * Function Name  : Standard_GetConfiguration.
//   50 * Description    : Return the current configuration variable address.
//   51 * Input          : Length - How many bytes are needed.
//   52 * Output         : None.
//   53 * Return         : Return 1 , if the request is invalid when "Length" is 0.
//   54 *                  Return "Buffer" if the "Length" is not 0.
//   55 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Standard_GetConfiguration
        THUMB
//   56 u8 *Standard_GetConfiguration(u16 Length)
//   57 {
Standard_GetConfiguration:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//   58   if (Length == 0)
        LDR.W    R4,??DataTable77  ;; pInformation
        CBNZ     R0,??Standard_GetConfiguration_0
//   59   {
//   60     pInformation->Ctrl_Info.Usb_wLength =
//   61       sizeof(pInformation->Current_Configuration);
        LDR      R0,[R4, #+0]
        MOVS     R1,#+1
        STRH     R1,[R0, #+16]
//   62     return 0;
        MOVS     R0,#+0
        POP      {R4,PC}
//   63   }
//   64   pUser_Standard_Requests->User_GetConfiguration();
??Standard_GetConfiguration_0:
        LDR.W    R0,??DataTable72  ;; pUser_Standard_Requests
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+0]
        BLX      R0
//   65   return (u8 *)&pInformation->Current_Configuration;
        LDR      R0,[R4, #+0]
        ADDS     R0,R0,#+10
??Standard_GetConfiguration_1:
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock0
//   66 }
//   67 
//   68 /*******************************************************************************
//   69 * Function Name  : Standard_SetConfiguration.
//   70 * Description    : This routine is called to set the configuration value
//   71 *                  Then each class should configure device themself.
//   72 * Input          : None.
//   73 * Output         : None.
//   74 * Return         : Return USB_SUCCESS, if the request is performed.
//   75 *                  Return USB_UNSUPPORT, if the request is invalid.
//   76 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function Standard_SetConfiguration
        THUMB
//   77 RESULT Standard_SetConfiguration(void)
//   78 {
Standard_SetConfiguration:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//   79 
//   80   if ((pInformation->USBwValue0 <=
//   81       Device_Table.Total_Configuration) && (pInformation->USBwValue1 == 0)
//   82       && (pInformation->USBwIndex == 0)) /*call Back usb spec 2.0*/
        LDR.W    R0,??DataTable77  ;; pInformation
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+3]
        LDR.W    R2,??DataTable80  ;; Device_Table
        LDRB     R2,[R2, #+1]
        CMP      R2,R1
        BCC.N    ??Standard_SetConfiguration_0
        LDRB     R2,[R0, #+2]
        CBNZ     R2,??Standard_SetConfiguration_0
        LDRH     R2,[R0, #+4]
        CBNZ     R2,??Standard_SetConfiguration_0
//   83   {
//   84     pInformation->Current_Configuration = pInformation->USBwValue0;
        STRB     R1,[R0, #+10]
//   85     pUser_Standard_Requests->User_SetConfiguration();
        LDR.W    R0,??DataTable72  ;; pUser_Standard_Requests
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+4]
        BLX      R0
//   86     return USB_SUCCESS;
        MOVS     R0,#+0
        B.N      ??Standard_SetConfiguration_1
//   87   }
//   88   else
//   89   {
//   90     return USB_UNSUPPORT;
??Standard_SetConfiguration_0:
        MOVS     R0,#+2
??Standard_SetConfiguration_1:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock1
//   91   }
//   92 }
//   93 
//   94 /*******************************************************************************
//   95 * Function Name  : Standard_GetInterface.
//   96 * Description    : Return the Alternate Setting of the current interface.
//   97 * Input          : Length - How many bytes are needed.
//   98 * Output         : None.
//   99 * Return         : Return 0, if the request is invalid when "Length" is 0.
//  100 *                  Return "Buffer" if the "Length" is not 0.
//  101 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Standard_GetInterface
        THUMB
//  102 u8 *Standard_GetInterface(u16 Length)
//  103 {
Standard_GetInterface:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  104   if (Length == 0)
        LDR.W    R4,??DataTable77  ;; pInformation
        CBNZ     R0,??Standard_GetInterface_0
//  105   {
//  106     pInformation->Ctrl_Info.Usb_wLength =
//  107       sizeof(pInformation->Current_AlternateSetting);
        LDR      R0,[R4, #+0]
        MOVS     R1,#+1
        STRH     R1,[R0, #+16]
//  108     return 0;
        MOVS     R0,#+0
        POP      {R4,PC}
//  109   }
//  110   pUser_Standard_Requests->User_GetInterface();
??Standard_GetInterface_0:
        LDR.W    R0,??DataTable72  ;; pUser_Standard_Requests
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+8]
        BLX      R0
//  111   return (u8 *)&pInformation->Current_AlternateSetting;
        LDR      R0,[R4, #+0]
        ADDS     R0,R0,#+12
??Standard_GetInterface_1:
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock2
//  112 }
//  113 
//  114 /*******************************************************************************
//  115 * Function Name  : Standard_SetInterface.
//  116 * Description    : This routine is called to set the interface.
//  117 *                  Then each class should configure the interface them self.
//  118 * Input          : None.
//  119 * Output         : None.
//  120 * Return         : - Return USB_SUCCESS, if the request is performed.
//  121 *                  - Return USB_UNSUPPORT, if the request is invalid.
//  122 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Standard_SetInterface
        THUMB
//  123 RESULT Standard_SetInterface(void)
//  124 {
Standard_SetInterface:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  125   RESULT Re;
//  126   /*Test if the specified Interface and Alternate Setting are supported by
//  127     the application Firmware*/
//  128   Re = (*pProperty->Class_Get_Interface_Setting)(pInformation->USBwIndex0, pInformation->USBwValue0);
        LDR.W    R4,??DataTable77  ;; pInformation
        LDR      R0,[R4, #+0]
        LDRB     R1,[R0, #+3]
        LDRB     R0,[R0, #+5]
        LDR.W    R2,??DataTable75  ;; pProperty
        LDR      R2,[R2, #+0]
        LDR      R2,[R2, #+24]
        BLX      R2
//  129 
//  130   if (pInformation->Current_Configuration != 0)
        LDR      R1,[R4, #+0]
        LDRB     R2,[R1, #+10]
        CBZ      R2,??Standard_SetInterface_0
//  131   {
//  132     if ((Re != USB_SUCCESS) || (pInformation->USBwIndex1 != 0)
//  133         || (pInformation->USBwValue1 != 0))
        CBNZ     R0,??Standard_SetInterface_0
        LDRB     R0,[R1, #+4]
        CBNZ     R0,??Standard_SetInterface_0
        LDRB     R0,[R1, #+2]
        CBZ      R0,??Standard_SetInterface_1
//  134     {
//  135       return  USB_UNSUPPORT;
??Standard_SetInterface_0:
        MOVS     R0,#+2
        POP      {R4,PC}
//  136     }
//  137     else if (Re == USB_SUCCESS)
//  138     {
//  139       pUser_Standard_Requests->User_SetInterface();
??Standard_SetInterface_1:
        LDR.W    R0,??DataTable72  ;; pUser_Standard_Requests
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+12]
        BLX      R0
//  140       pInformation->Current_Interface = pInformation->USBwIndex0;
        LDR      R0,[R4, #+0]
        LDRB     R1,[R0, #+5]
        STRB     R1,[R0, #+11]
//  141       pInformation->Current_AlternateSetting = pInformation->USBwValue0;
        LDRB     R1,[R0, #+3]
        STRB     R1,[R0, #+12]
//  142       return USB_SUCCESS;
        MOVS     R0,#+0
??Standard_SetInterface_2:
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock3
//  143     }
//  144 
//  145   }
//  146 
//  147   return USB_UNSUPPORT;
//  148 }
//  149 
//  150 /*******************************************************************************
//  151 * Function Name  : Standard_GetStatus.
//  152 * Description    : Copy the device request data to "StatusInfo buffer".
//  153 * Input          : - Length - How many bytes are needed.
//  154 * Output         : None.
//  155 * Return         : Return 0, if the request is at end of data block,
//  156 *                  or is invalid when "Length" is 0.
//  157 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Standard_GetStatus
        THUMB
//  158 u8 *Standard_GetStatus(u16 Length)
//  159 {
Standard_GetStatus:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  160   if (Length == 0)
        LDR.W    R1,??DataTable77  ;; pInformation
        LDR      R1,[R1, #+0]
        CBNZ     R0,??Standard_GetStatus_0
//  161   {
//  162     pInformation->Ctrl_Info.Usb_wLength = 2;
        MOVS     R0,#+2
        STRH     R0,[R1, #+16]
//  163     return 0;
??Standard_GetStatus_1:
        MOVS     R0,#+0
        POP      {R4,PC}
//  164   }
//  165 
//  166   StatusInfo.w = 0;
??Standard_GetStatus_0:
        LDR.N    R4,??Standard_GetStatus_2  ;; StatusInfo
        MOVS     R0,#+0
        STRH     R0,[R4, #+0]
//  167   /* Reset Status Information */
//  168 
//  169   if (Type_Recipient == (STANDARD_REQUEST | DEVICE_RECIPIENT))
        LDRB     R0,[R1, #+0]
        TST      R0,#0x7F
        BNE.N    ??Standard_GetStatus_3
//  170   {
//  171     /*Get Device Status */
//  172     u8 Feature = pInformation->Current_Feature;
        LDRB     R0,[R1, #+9]
//  173 
//  174     /* Remote Wakeup enabled */
//  175     if (ValBit(Feature, 5))
        TST      R0,#0x20
        ITTT     NE 
//  176     {
//  177       SetBit(StatusInfo0, 1);
        LDRBNE   R1,[R4, #+0]
        ORRNE    R1,R1,#0x2
        STRBNE   R1,[R4, #+0]
//  178     }
//  179 
//  180     /* Bus-powered */
//  181     if (ValBit(Feature, 6))
        TST      R0,#0x40
        LDRB     R0,[R4, #+0]
        BEQ.N    ??Standard_GetStatus_4
//  182     {
//  183       ClrBit(StatusInfo0, 0);
        AND      R0,R0,#0xFE
??Standard_GetStatus_5:
        STRB     R0,[R4, #+0]
//  184     }
//  185     else /* Self-powered */
//  186     {
//  187       SetBit(StatusInfo0, 0);
//  188     }
//  189   }
//  190   /*Interface Status*/
//  191   else if (Type_Recipient == (STANDARD_REQUEST | INTERFACE_RECIPIENT))
//  192   {
//  193     return (u8 *)&StatusInfo;
//  194   }
//  195   /*Get EndPoint Status*/
//  196   else if (Type_Recipient == (STANDARD_REQUEST | ENDPOINT_RECIPIENT))
//  197   {
//  198     u8 Related_Endpoint;
//  199     u8 wIndex0 = pInformation->USBwIndex0;
//  200 
//  201     Related_Endpoint = (wIndex0 & 0x0f);
//  202     if (ValBit(wIndex0, 7))
//  203     {
//  204       /* IN endpoint */
//  205       if (_GetTxStallStatus(Related_Endpoint))
//  206       {
//  207         SetBit(StatusInfo0, 0); /* IN Endpoint stalled */
//  208       }
//  209     }
//  210     else
//  211     {
//  212       /* OUT endpoint */
//  213       if (_GetRxStallStatus(Related_Endpoint))
//  214       {
//  215         SetBit(StatusInfo0, 0); /* OUT Endpoint stalled */
//  216       }
//  217     }
//  218 
//  219   }
//  220   else
//  221   {
//  222     return NULL;
//  223   }
//  224   pUser_Standard_Requests->User_GetStatus();
??Standard_GetStatus_6:
        LDR.W    R0,??DataTable72  ;; pUser_Standard_Requests
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+16]
        BLX      R0
//  225   return (u8 *)&StatusInfo;
??Standard_GetStatus_7:
        MOVS     R0,R4
??Standard_GetStatus_8:
        POP      {R4,PC}          ;; return
??Standard_GetStatus_4:
        ORR      R0,R0,#0x1
        B.N      ??Standard_GetStatus_5
??Standard_GetStatus_3:
        AND      R2,R0,#0x7F
        CMP      R2,#+1
        BEQ.N    ??Standard_GetStatus_7
??Standard_GetStatus_9:
        AND      R0,R0,#0x7F
        CMP      R0,#+2
        BNE.N    ??Standard_GetStatus_1
        LDRB     R0,[R1, #+5]
        AND      R1,R0,#0xF
        TST      R0,#0x80
        BEQ.N    ??Standard_GetStatus_10
        LDR.W    R0,??DataTable81  ;; 0x40005c00
        LDR      R0,[R0, R1, LSL #+2]
        AND      R0,R0,#0x30
        CMP      R0,#+16
        BNE.N    ??Standard_GetStatus_6
        LDRB     R0,[R4, #+0]
        ORR      R0,R0,#0x1
        B.N      ??Standard_GetStatus_5
??Standard_GetStatus_10:
        LDR.W    R0,??DataTable81  ;; 0x40005c00
        LDR      R0,[R0, R1, LSL #+2]
        AND      R0,R0,#0x3000
        CMP      R0,#+4096
        BNE.N    ??Standard_GetStatus_6
        LDRB     R0,[R4, #+0]
        ORR      R0,R0,#0x1
        B.N      ??Standard_GetStatus_5
        DATA
??Standard_GetStatus_2:
        DC32     StatusInfo
        CFI EndBlock cfiBlock4
//  226 }
//  227 
//  228 /*******************************************************************************
//  229 * Function Name  : Standard_ClearFeature.
//  230 * Description    : Clear or disable a specific feature.
//  231 * Input          : None.
//  232 * Output         : None.
//  233 * Return         : - Return USB_SUCCESS, if the request is performed.
//  234 *                  - Return USB_UNSUPPORT, if the request is invalid.
//  235 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function Standard_ClearFeature
        THUMB
//  236 RESULT Standard_ClearFeature(void)
//  237 {
Standard_ClearFeature:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//  238   u32     Type_Rec = Type_Recipient;
        LDR.W    R0,??DataTable77  ;; pInformation
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+0]
        ANDS     R1,R1,#0x7F
//  239   u32     Status;
//  240 
//  241 
//  242   if (Type_Rec == (STANDARD_REQUEST | DEVICE_RECIPIENT))
        BNE.N    ??Standard_ClearFeature_0
//  243   {/*Device Clear Feature*/
//  244     ClrBit(pInformation->Current_Feature, 5);
        LDRB     R1,[R0, #+9]
        AND      R1,R1,#0xDF
        STRB     R1,[R0, #+9]
//  245     return USB_SUCCESS;
        B.N      ??Standard_ClearFeature_1
//  246   }
//  247   else if (Type_Rec == (STANDARD_REQUEST | ENDPOINT_RECIPIENT))
??Standard_ClearFeature_0:
        CMP      R1,#+2
        BNE.N    ??Standard_ClearFeature_2
//  248   {/*EndPoint Clear Feature*/
//  249     DEVICE* pDev;
//  250     u32 Related_Endpoint;
//  251     u32 wIndex0;
//  252     u32 rEP;
//  253 
//  254     if ((pInformation->USBwValue != ENDPOINT_STALL)
//  255         || (pInformation->USBwIndex1 != 0))
        LDRH     R1,[R0, #+2]
        CBNZ     R1,??Standard_ClearFeature_2
        LDRB     R1,[R0, #+4]
        CBZ      R1,??Standard_ClearFeature_3
//  256     {
//  257       return USB_UNSUPPORT;
??Standard_ClearFeature_2:
        MOVS     R0,#+2
        B.N      ??Standard_ClearFeature_4
//  258     }
//  259 
//  260     pDev = &Device_Table;
//  261     wIndex0 = pInformation->USBwIndex0;
??Standard_ClearFeature_3:
        LDRB     R1,[R0, #+5]
//  262     rEP = wIndex0 & ~0x80;
        MOVS     R4,R1
        MOVS     R2,#+128
        BICS     R4,R4,R2
//  263     Related_Endpoint = ENDP0 + rEP;
//  264 
//  265     if (ValBit(pInformation->USBwIndex0, 7))
        TST      R1,#0x80
        BEQ.N    ??Standard_ClearFeature_5
//  266     {
//  267       /*Get Status of endpoint & stall the request if the related_ENdpoint
//  268       is Disabled*/
//  269       Status = _GetEPTxStatus(Related_Endpoint);
        LDR.W    R2,??DataTable81  ;; 0x40005c00
        LDR      R2,[R2, R4, LSL #+2]
        AND      R2,R2,#0x30
        B.N      ??Standard_ClearFeature_6
//  270     }
//  271     else
//  272     {
//  273       Status = _GetEPRxStatus(Related_Endpoint);
??Standard_ClearFeature_5:
        LDR.W    R2,??DataTable81  ;; 0x40005c00
        LDR      R2,[R2, R4, LSL #+2]
        AND      R2,R2,#0x3000
//  274     }
//  275 
//  276     if ((rEP >= pDev->Total_Endpoint) || (Status == 0)
//  277         || (pInformation->Current_Configuration == 0))
??Standard_ClearFeature_6:
        LDR.W    R3,??DataTable80  ;; Device_Table
        LDRB     R3,[R3, #+0]
        CMP      R4,R3
        BCS.N    ??Standard_ClearFeature_2
        CMP      R2,#+0
        BEQ.N    ??Standard_ClearFeature_2
        LDRB     R0,[R0, #+10]
        CMP      R0,#+0
        BEQ.N    ??Standard_ClearFeature_2
//  278     {
//  279       return USB_UNSUPPORT;
//  280     }
//  281 
//  282 
//  283     if (wIndex0 & 0x80)
        TST      R1,#0x80
        BEQ.N    ??Standard_ClearFeature_7
//  284     {
//  285       /* IN endpoint */
//  286       if (_GetTxStallStatus(Related_Endpoint ))
        LDR.W    R0,??DataTable81  ;; 0x40005c00
        LDR      R0,[R0, R4, LSL #+2]
        AND      R0,R0,#0x30
        CMP      R0,#+16
        BNE.N    ??Standard_ClearFeature_8
//  287       {
//  288         ClearDTOG_TX(Related_Endpoint);
        MOVS     R0,R4
        BL       ClearDTOG_TX
//  289         SetEPTxStatus(Related_Endpoint, EP_TX_VALID);
        MOVS     R1,#+48
        MOVS     R0,R4
        BL       SetEPTxStatus
        B.N      ??Standard_ClearFeature_8
//  290       }
//  291     }
//  292     else
//  293     {
//  294       /* OUT endpoint */
//  295       if (_GetRxStallStatus(Related_Endpoint))
??Standard_ClearFeature_7:
        LDR.W    R0,??DataTable81  ;; 0x40005c00
        LDR      R0,[R0, R4, LSL #+2]
        AND      R0,R0,#0x3000
        CMP      R0,#+4096
        BNE.N    ??Standard_ClearFeature_8
//  296       {
//  297         if (Related_Endpoint == ENDP0)
        MOVW     R5,#+49039
        CBNZ     R4,??Standard_ClearFeature_9
//  298         {
//  299           /* After clear the STALL, enable the default endpoint receiver */
//  300           SetEPRxCount(Related_Endpoint, Device_Property.MaxPacketSize);
        LDR.W    R0,??DataTable76  ;; Device_Property
        LDRB     R1,[R0, #+44]
        MOVS     R0,#+0
        BL       SetEPRxCount
//  301           _SetEPRxStatus(Related_Endpoint, EP_RX_VALID);
        LDR.W    R0,??DataTable81  ;; 0x40005c00
        LDR      R1,[R0, #+0]
        ANDS     R1,R5,R1
        EOR      R1,R1,#0x3000
        STR      R1,[R0, #+0]
        B.N      ??Standard_ClearFeature_8
//  302         }
//  303         else
//  304         {
//  305           ClearDTOG_RX(Related_Endpoint);
??Standard_ClearFeature_9:
        MOVS     R0,R4
        BL       ClearDTOG_RX
//  306           _SetEPRxStatus(Related_Endpoint, EP_RX_VALID);
        LDR.W    R0,??DataTable81  ;; 0x40005c00
        LDR      R0,[R0, R4, LSL #+2]
        ANDS     R0,R5,R0
        LDR.W    R1,??DataTable81  ;; 0x40005c00
        EOR      R0,R0,#0x3000
        STR      R0,[R1, R4, LSL #+2]
//  307         }
//  308       }
//  309     }
//  310     pUser_Standard_Requests->User_ClearFeature();
??Standard_ClearFeature_8:
        LDR.W    R0,??DataTable72  ;; pUser_Standard_Requests
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+20]
        BLX      R0
//  311     return USB_SUCCESS;
??Standard_ClearFeature_1:
        MOVS     R0,#+0
??Standard_ClearFeature_4:
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        CFI EndBlock cfiBlock5
//  312   }
//  313 
//  314   return USB_UNSUPPORT;
//  315 }
//  316 
//  317 /*******************************************************************************
//  318 * Function Name  : Standard_SetEndPointFeature
//  319 * Description    : Set or enable a specific feature of EndPoint
//  320 * Input          : None.
//  321 * Output         : None.
//  322 * Return         : - Return USB_SUCCESS, if the request is performed.
//  323 *                  - Return USB_UNSUPPORT, if the request is invalid.
//  324 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function Standard_SetEndPointFeature
        THUMB
//  325 RESULT Standard_SetEndPointFeature(void)
//  326 {
Standard_SetEndPointFeature:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  327   u32    wIndex0;
//  328   u32    Related_Endpoint;
//  329   u32    rEP;
//  330   u32   Status;
//  331 
//  332   wIndex0 = pInformation->USBwIndex0;
        LDR.W    R0,??DataTable77  ;; pInformation
        LDR      R1,[R0, #+0]
        LDRB     R2,[R1, #+5]
//  333   rEP = wIndex0 & ~0x80;
//  334   Related_Endpoint = ENDP0 + rEP;
        MOVS     R0,R2
        MOVS     R3,#+128
        BICS     R0,R0,R3
//  335 
//  336   if (ValBit(pInformation->USBwIndex0, 7))
        TST      R2,#0x80
        BEQ.N    ??Standard_SetEndPointFeature_0
//  337   {
//  338     /* get Status of endpoint & stall the request if the related_ENdpoint
//  339     is Disabled*/
//  340     Status = _GetEPTxStatus(Related_Endpoint);
        LDR.W    R3,??DataTable81  ;; 0x40005c00
        LDR      R3,[R3, R0, LSL #+2]
        AND      R3,R3,#0x30
        B.N      ??Standard_SetEndPointFeature_1
//  341   }
//  342   else
//  343   {
//  344     Status = _GetEPRxStatus(Related_Endpoint);
??Standard_SetEndPointFeature_0:
        LDR.W    R3,??DataTable81  ;; 0x40005c00
        LDR      R3,[R3, R0, LSL #+2]
        AND      R3,R3,#0x3000
//  345   }
//  346 
//  347   if (Related_Endpoint >= Device_Table.Total_Endpoint
//  348       || pInformation->USBwValue != 0 || Status == 0
//  349       || pInformation->Current_Configuration == 0)
??Standard_SetEndPointFeature_1:
        LDR.W    R12,??DataTable80  ;; Device_Table
        LDRB     R12,[R12, #+0]
        CMP      R0,R12
        BCS.N    ??Standard_SetEndPointFeature_2
        LDRH     R12,[R1, #+2]
        CMP      R12,#+0
        BNE.N    ??Standard_SetEndPointFeature_2
        CBZ      R3,??Standard_SetEndPointFeature_2
        LDRB     R1,[R1, #+10]
        CBNZ     R1,??Standard_SetEndPointFeature_3
//  350   {
//  351     return USB_UNSUPPORT;
??Standard_SetEndPointFeature_2:
        MOVS     R0,#+2
        B.N      ??Standard_SetEndPointFeature_4
//  352   }
//  353   else
//  354   {
//  355     if (wIndex0 & 0x80)
??Standard_SetEndPointFeature_3:
        TST      R2,#0x80
        BEQ.N    ??Standard_SetEndPointFeature_5
//  356     {
//  357       /* IN endpoint */
//  358       _SetEPTxStatus(Related_Endpoint, EP_TX_STALL);
        LDR.W    R1,??DataTable81  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+36799
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable81  ;; 0x40005c00
        EOR      R1,R1,#0x10
        STR      R1,[R2, R0, LSL #+2]
        B.N      ??Standard_SetEndPointFeature_6
//  359     }
//  360 
//  361     else
//  362     {
//  363       /* OUT endpoint */
//  364       _SetEPRxStatus(Related_Endpoint, EP_RX_STALL);
??Standard_SetEndPointFeature_5:
        LDR.W    R1,??DataTable81  ;; 0x40005c00
        LDR      R1,[R1, R0, LSL #+2]
        MOVW     R2,#+49039
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable81  ;; 0x40005c00
        EOR      R1,R1,#0x1000
        STR      R1,[R2, R0, LSL #+2]
//  365     }
//  366   }
//  367   pUser_Standard_Requests->User_SetEndPointFeature();
??Standard_SetEndPointFeature_6:
        LDR.W    R0,??DataTable72  ;; pUser_Standard_Requests
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+24]
        BLX      R0
//  368   return USB_SUCCESS;
        MOVS     R0,#+0
??Standard_SetEndPointFeature_4:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock6
//  369 }
//  370 
//  371 /*******************************************************************************
//  372 * Function Name  : Standard_SetDeviceFeature.
//  373 * Description    : Set or enable a specific feature of Device.
//  374 * Input          : None.
//  375 * Output         : None.
//  376 * Return         : - Return USB_SUCCESS, if the request is performed.
//  377 *                  - Return USB_UNSUPPORT, if the request is invalid.
//  378 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function Standard_SetDeviceFeature
        THUMB
//  379 RESULT Standard_SetDeviceFeature(void)
//  380 {
Standard_SetDeviceFeature:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  381   SetBit(pInformation->Current_Feature, 5);
        LDR.W    R0,??DataTable77  ;; pInformation
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+9]
        ORR      R1,R1,#0x20
        STRB     R1,[R0, #+9]
//  382   pUser_Standard_Requests->User_SetDeviceFeature();
        LDR.W    R0,??DataTable72  ;; pUser_Standard_Requests
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+28]
        BLX      R0
//  383   return USB_SUCCESS;
        MOVS     R0,#+0
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock7
//  384 }
//  385 
//  386 /*******************************************************************************
//  387 * Function Name  : Standard_GetDescriptorData.
//  388 * Description    : Standard_GetDescriptorData is used for descriptors transfer.
//  389 *                : This routine is used for the descriptors resident in Flash
//  390 *                  or RAM
//  391 *                  pDesc can be in either Flash or RAM
//  392 *                  The purpose of this routine is to have a versatile way to
//  393 *                  response descriptors request. It allows user to generate
//  394 *                  certain descriptors with software or read descriptors from
//  395 *                  external storage part by part.
//  396 * Input          : - Length - Length of the data in this transfer.
//  397 *                  - pDesc - A pointer points to descriptor struct.
//  398 *                  The structure gives the initial address of the descriptor and
//  399 *                  its original size.
//  400 * Output         : None.
//  401 * Return         : Address of a part of the descriptor pointed by the Usb_
//  402 *                  wOffset The buffer pointed by this address contains at least
//  403 *                  Length bytes.
//  404 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function Standard_GetDescriptorData
        THUMB
//  405 u8 *Standard_GetDescriptorData(u16 Length, ONE_DESCRIPTOR *pDesc)
//  406 {
//  407   u32  wOffset;
//  408 
//  409   wOffset = pInformation->Ctrl_Info.Usb_wOffset;
Standard_GetDescriptorData:
        LDR.W    R2,??DataTable77  ;; pInformation
        LDR      R2,[R2, #+0]
        LDRH     R3,[R2, #+18]
//  410   if (Length == 0)
        CBNZ     R0,??Standard_GetDescriptorData_0
//  411   {
//  412     pInformation->Ctrl_Info.Usb_wLength = pDesc->Descriptor_Size - wOffset;
        LDRH     R0,[R1, #+4]
        SUBS     R0,R0,R3
        STRH     R0,[R2, #+16]
//  413     return 0;
        MOVS     R0,#+0
        BX       LR
//  414   }
//  415 
//  416   return pDesc->Descriptor + wOffset;
??Standard_GetDescriptorData_0:
        LDR      R0,[R1, #+0]
        ADDS     R0,R3,R0
??Standard_GetDescriptorData_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  417 }
//  418 
//  419 /*******************************************************************************
//  420 * Function Name  : DataStageOut.
//  421 * Description    : Data stage of a Control Write Transfer.
//  422 * Input          : None.
//  423 * Output         : None.
//  424 * Return         : None.
//  425 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function DataStageOut
        THUMB
//  426 void DataStageOut(void)
//  427 {
DataStageOut:
        PUSH     {R4-R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI R7 Frame(CFA, -8)
        CFI R6 Frame(CFA, -12)
        CFI R5 Frame(CFA, -16)
        CFI R4 Frame(CFA, -20)
        CFI CFA R13+20
        SUB      SP,SP,#+4
        CFI CFA R13+24
//  428   ENDPOINT_INFO *pEPinfo = &pInformation->Ctrl_Info;
        LDR.W    R5,??DataTable77  ;; pInformation
        LDR      R0,[R5, #+0]
        ADD      R6,R0,#+16
//  429   u32 save_rLength;
//  430 
//  431   save_rLength = pEPinfo->Usb_rLength;
        LDRH     R0,[R6, #+0]
//  432 
//  433   if (pEPinfo->CopyData && save_rLength)
        LDR      R1,[R6, #+8]
        MOVS     R2,R1
        BEQ.N    ??DataStageOut_0
        CBZ      R0,??DataStageOut_0
//  434   {
//  435     u8 *Buffer;
//  436     u32 Length;
//  437 
//  438     Length = pEPinfo->PacketSize;
        LDRH     R4,[R6, #+4]
//  439     if (Length > save_rLength)
        CMP      R0,R4
        IT       CC 
//  440     {
//  441       Length = save_rLength;
        MOVCC    R4,R0
//  442     }
//  443 
//  444     Buffer = (*pEPinfo->CopyData)(Length);
        MOVS     R0,R4
        BLX      R1
        MOVS     R7,R0
//  445     pEPinfo->Usb_rLength -= Length;
        LDRH     R0,[R6, #+0]
        SUBS     R0,R0,R4
        STRH     R0,[R6, #+0]
//  446     pEPinfo->Usb_rOffset += Length;
        LDRH     R0,[R6, #+2]
        ADDS     R0,R4,R0
        STRH     R0,[R6, #+2]
//  447 
//  448     PMAToUserBufferCopy(Buffer, GetEPRxAddr(ENDP0), Length);
        MOVS     R0,#+0
        BL       GetEPRxAddr
        MOVS     R2,R4
        MOVS     R1,R0
        MOVS     R0,R7
        BL       PMAToUserBufferCopy
//  449   }
//  450 
//  451   if (pEPinfo->Usb_rLength != 0)
??DataStageOut_0:
        LDRH     R0,[R6, #+0]
        CBZ      R0,??DataStageOut_1
//  452   {
//  453     vSetEPRxStatus(EP_RX_VALID);/* re-enable for next data reception */
        LDR.W    R0,??DataTable78  ;; SaveRState
        MOV      R1,#+12288
        STRH     R1,[R0, #+0]
//  454     SetEPTxCount(ENDP0, 0);
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       SetEPTxCount
//  455     vSetEPTxStatus(EP_TX_VALID);/* Expect the host to abort the data OUT stage */
        LDR.W    R0,??DataTable79  ;; SaveTState
        MOVS     R1,#+48
        STRH     R1,[R0, #+0]
//  456   }
//  457   /* Set the next State*/
//  458   if (pEPinfo->Usb_rLength >= pEPinfo->PacketSize)
??DataStageOut_1:
        LDR      R0,[R5, #+0]
        LDRH     R1,[R6, #+0]
        LDRH     R2,[R6, #+4]
        CMP      R1,R2
        BCC.N    ??DataStageOut_2
//  459   {
//  460     pInformation->ControlState = OUT_DATA;
        MOVS     R1,#+3
??DataStageOut_3:
        STRB     R1,[R0, #+8]
        B.N      ??DataStageOut_4
//  461   }
//  462   else
//  463   {
//  464     if (pEPinfo->Usb_rLength > 0)
??DataStageOut_2:
        CBZ      R1,??DataStageOut_5
//  465     {
//  466       pInformation->ControlState = LAST_OUT_DATA;
        MOVS     R1,#+5
        B.N      ??DataStageOut_3
//  467     }
//  468     else if (pEPinfo->Usb_rLength == 0)
//  469     {
//  470       pInformation->ControlState = WAIT_STATUS_IN;
??DataStageOut_5:
        MOVS     R1,#+6
        STRB     R1,[R0, #+8]
//  471       USB_StatusIn();
        LDR.W    R0,??DataTable69  ;; 0x40005c50
        LDR      R0,[R0, #+0]
        UXTH     R0,R0
        LDR.N    R1,??DataTable52  ;; 0x40006004
        MOVS     R2,#+0
        STR      R2,[R1, R0, LSL #+1]
        LDR.W    R0,??DataTable79  ;; SaveTState
        MOVS     R1,#+48
        STRH     R1,[R0, #+0]
//  472     }
//  473   }
//  474 }
??DataStageOut_4:
        ADD      SP,SP,#+4
        CFI CFA R13+20
        POP      {R4-R7,PC}       ;; return
        CFI EndBlock cfiBlock9
//  475 
//  476 /*******************************************************************************
//  477 * Function Name  : DataStageIn.
//  478 * Description    : Data stage of a Control Read Transfer.
//  479 * Input          : None.
//  480 * Output         : None.
//  481 * Return         : None.
//  482 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function DataStageIn
        THUMB
//  483 void DataStageIn(void)
//  484 {
DataStageIn:
        PUSH     {R4-R8,LR}
        CFI R14 Frame(CFA, -4)
        CFI R8 Frame(CFA, -8)
        CFI R7 Frame(CFA, -12)
        CFI R6 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
//  485   ENDPOINT_INFO *pEPinfo = &pInformation->Ctrl_Info;
        LDR.W    R4,??DataTable77  ;; pInformation
        LDR      R0,[R4, #+0]
        ADD      R5,R0,#+16
//  486   u32 save_wLength = pEPinfo->Usb_wLength;
        LDRH     R1,[R5, #+0]
//  487   u32 ControlState = pInformation->ControlState;
//  488 
//  489   u8 *DataBuffer;
//  490   u32 Length;
//  491 
//  492   if ((save_wLength == 0) && (ControlState == LAST_IN_DATA))
        CBNZ     R1,??DataStageIn_0
        LDRB     R0,[R0, #+8]
        CMP      R0,#+4
        BNE.N    ??DataStageIn_0
//  493   {
//  494     if(Data_Mul_MaxPacketSize == TRUE)
        LDR.W    R0,??DataTable66  ;; Data_Mul_MaxPacketSize
        LDRB     R1,[R0, #+0]
        CMP      R1,#+1
        BNE.N    ??DataStageIn_1
//  495     {
//  496       /* No more data to send and empty packet */
//  497       Send0LengthData();
        LDR.W    R1,??DataTable69  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        LDR.N    R2,??DataTable52  ;; 0x40006004
        MOVS     R3,#+0
        STR      R3,[R2, R1, LSL #+1]
        MOVS     R1,#+48
//  498       ControlState = LAST_IN_DATA;
        MOVS     R6,#+4
//  499       Data_Mul_MaxPacketSize = FALSE;
        STRB     R3,[R0, #+0]
        B.N      ??DataStageIn_2
//  500     }
//  501     else 
//  502     {
//  503       /* No more data to send so STALL the TX Status*/
//  504       ControlState = WAIT_STATUS_OUT;
??DataStageIn_1:
        MOVS     R6,#+7
//  505       vSetEPTxStatus(EP_TX_STALL);
        MOVS     R1,#+16
        B.N      ??DataStageIn_2
//  506     }
//  507     
//  508     goto Expect_Status_Out;
//  509   }
//  510 
//  511   Length = pEPinfo->PacketSize;
??DataStageIn_0:
        LDRH     R7,[R5, #+4]
//  512   ControlState = (save_wLength <= Length) ? LAST_IN_DATA : IN_DATA;
        CMP      R7,R1
        BCC.N    ??DataStageIn_3
        MOVS     R6,#+4
//  513 
//  514   if (Length > save_wLength)
        CMP      R1,R7
        IT       CC 
//  515   {
//  516     Length = save_wLength;
        MOVCC    R7,R1
//  517   }
//  518 
//  519   DataBuffer = (*pEPinfo->CopyData)(Length);
??DataStageIn_4:
        UXTH     R0,R7
        LDR      R1,[R5, #+8]
        BLX      R1
        MOV      R8,R0
//  520 
//  521   UserToPMABufferCopy(DataBuffer, GetEPTxAddr(ENDP0), Length);
        MOVS     R0,#+0
        BL       GetEPTxAddr
        UXTH     R2,R7
        MOVS     R1,R0
        MOV      R0,R8
        BL       UserToPMABufferCopy
//  522 
//  523   SetEPTxCount(ENDP0, Length);
        UXTH     R1,R7
        MOVS     R0,#+0
        BL       SetEPTxCount
//  524 
//  525   pEPinfo->Usb_wLength -= Length;
        LDRH     R0,[R5, #+0]
        SUBS     R0,R0,R7
        STRH     R0,[R5, #+0]
//  526   pEPinfo->Usb_wOffset += Length;
        LDRH     R0,[R5, #+2]
        ADDS     R0,R7,R0
        STRH     R0,[R5, #+2]
//  527   vSetEPTxStatus(EP_TX_VALID);
        MOVS     R1,#+48
//  528 
//  529   USB_StatusOut();/* Expect the host to abort the data IN stage */
        LDR.W    R0,??DataTable78  ;; SaveRState
        MOV      R2,#+12288
        STRH     R2,[R0, #+0]
??DataStageIn_2:
        LDR.W    R0,??DataTable79  ;; SaveTState
        STRH     R1,[R0, #+0]
//  530 
//  531 Expect_Status_Out:
//  532   pInformation->ControlState = ControlState;
        LDR      R0,[R4, #+0]
        STRB     R6,[R0, #+8]
//  533 }
        POP      {R4-R8,PC}       ;; return
??DataStageIn_3:
        MOVS     R6,#+2
        B.N      ??DataStageIn_4
        CFI EndBlock cfiBlock10
//  534 
//  535 /*******************************************************************************
//  536 * Function Name  : NoData_Setup0.
//  537 * Description    : Proceed the processing of setup request without data stage.
//  538 * Input          : None.
//  539 * Output         : None.
//  540 * Return         : None.
//  541 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function NoData_Setup0
        THUMB
//  542 void NoData_Setup0(void)
//  543 {
NoData_Setup0:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//  544   RESULT Result = USB_UNSUPPORT;
//  545   u32 RequestNo = pInformation->USBbRequest;
        LDR.W    R4,??DataTable77  ;; pInformation
        LDR      R0,[R4, #+0]
        LDRB     R5,[R0, #+1]
//  546   u32 ControlState;
//  547 
//  548   if (Type_Recipient == (STANDARD_REQUEST | DEVICE_RECIPIENT))
        LDRB     R1,[R0, #+0]
        TST      R1,#0x7F
        BNE.N    ??NoData_Setup0_0
//  549   {
//  550     /* Device Request*/
//  551     /* SET_CONFIGURATION*/
//  552     if (RequestNo == SET_CONFIGURATION)
        CMP      R5,#+9
        BNE.N    ??NoData_Setup0_1
//  553     {
//  554       Result = Standard_SetConfiguration();
        BL       Standard_SetConfiguration
        B.N      ??NoData_Setup0_2
//  555     }
//  556 
//  557     /*SET ADDRESS*/
//  558     else if (RequestNo == SET_ADDRESS)
??NoData_Setup0_1:
        CMP      R5,#+5
        BNE.N    ??NoData_Setup0_3
//  559     {
//  560       if ((pInformation->USBwValue0 > 127) || (pInformation->USBwValue1 != 0)
//  561           || (pInformation->USBwIndex != 0)
//  562           || (pInformation->Current_Configuration != 0))
        LDRB     R1,[R0, #+3]
        CMP      R1,#+128
        BCS.N    ??NoData_Setup0_4
        LDRB     R1,[R0, #+2]
        CBNZ     R1,??NoData_Setup0_4
        LDRH     R1,[R0, #+4]
        CBNZ     R1,??NoData_Setup0_4
        LDRB     R0,[R0, #+10]
        CMP      R0,#+0
        BEQ.N    ??NoData_Setup0_5
//  563         /* Device Address should be 127 or less*/
//  564       {
//  565         ControlState = STALLED;
??NoData_Setup0_4:
        MOVS     R0,#+8
//  566         goto exit_NoData_Setup0;
        B.N      ??NoData_Setup0_6
//  567       }
//  568       else
//  569       {
//  570         Result = USB_SUCCESS;
//  571       }
//  572     }
//  573     /*SET FEATURE for Device*/
//  574     else if (RequestNo == SET_FEATURE)
??NoData_Setup0_3:
        CMP      R5,#+3
        BNE.N    ??NoData_Setup0_7
//  575     {
//  576       if ((pInformation->USBwValue0 == DEVICE_REMOTE_WAKEUP)
//  577           && (pInformation->USBwIndex == 0)
//  578           && (ValBit(pInformation->Current_Feature, 5)))
        LDRB     R1,[R0, #+3]
        CMP      R1,#+1
        BNE.N    ??NoData_Setup0_8
        LDRH     R1,[R0, #+4]
        CBNZ     R1,??NoData_Setup0_8
        LDRB     R0,[R0, #+9]
        TST      R0,#0x20
        BEQ.N    ??NoData_Setup0_8
//  579       {
//  580         Result = Standard_SetDeviceFeature();
        BL       Standard_SetDeviceFeature
        B.N      ??NoData_Setup0_2
//  581       }
//  582       else
//  583       {
//  584         Result = USB_UNSUPPORT;
//  585       }
//  586     }
//  587     /*Clear FEATURE for Device */
//  588     else if (RequestNo == CLEAR_FEATURE)
??NoData_Setup0_7:
        CMP      R5,#+1
        BNE.N    ??NoData_Setup0_8
//  589     {
//  590       if (pInformation->USBwValue0 == DEVICE_REMOTE_WAKEUP
//  591           && pInformation->USBwIndex == 0
//  592           && ValBit(pInformation->Current_Feature, 5))
        LDRB     R1,[R0, #+3]
        CMP      R1,#+1
        BNE.N    ??NoData_Setup0_8
        LDRH     R1,[R0, #+4]
        CBNZ     R1,??NoData_Setup0_8
        LDRB     R0,[R0, #+9]
        TST      R0,#0x20
        BEQ.N    ??NoData_Setup0_8
//  593       {
//  594         Result = Standard_ClearFeature();
??NoData_Setup0_9:
        BL       Standard_ClearFeature
        B.N      ??NoData_Setup0_2
//  595       }
//  596       else
//  597       {
//  598         Result = USB_UNSUPPORT;
//  599       }
//  600     }
//  601 
//  602   }
//  603 
//  604   /* Interface Request*/
//  605   else if (Type_Recipient == (STANDARD_REQUEST | INTERFACE_RECIPIENT))
??NoData_Setup0_0:
        AND      R0,R1,#0x7F
        CMP      R0,#+1
        BNE.N    ??NoData_Setup0_10
//  606   {
//  607     /*SET INTERFACE*/
//  608     if (RequestNo == SET_INTERFACE)
        CMP      R5,#+11
        BNE.N    ??NoData_Setup0_8
//  609     {
//  610       Result = Standard_SetInterface();
        BL       Standard_SetInterface
        B.N      ??NoData_Setup0_2
//  611     }
//  612   }
//  613 
//  614   /* EndPoint Request*/
//  615   else if (Type_Recipient == (STANDARD_REQUEST | ENDPOINT_RECIPIENT))
??NoData_Setup0_10:
        CMP      R0,#+2
        BNE.N    ??NoData_Setup0_8
//  616   {
//  617     /*CLEAR FEATURE for EndPoint*/
//  618     if (RequestNo == CLEAR_FEATURE)
        CMP      R5,#+1
        BEQ.N    ??NoData_Setup0_9
//  619     {
//  620       Result = Standard_ClearFeature();
//  621     }
//  622     /* SET FEATURE for EndPoint*/
//  623     else if (RequestNo == SET_FEATURE)
        CMP      R5,#+3
        BNE.N    ??NoData_Setup0_8
//  624     {
//  625       Result = Standard_SetEndPointFeature();
        BL       Standard_SetEndPointFeature
//  626     }
//  627   }
//  628   else
//  629   {
//  630     Result = USB_UNSUPPORT;
//  631   }
//  632 
//  633 
//  634   if (Result != USB_SUCCESS)
??NoData_Setup0_2:
        CBZ      R0,??NoData_Setup0_5
//  635   {
//  636     Result = (*pProperty->Class_NoData_Setup)(RequestNo);
??NoData_Setup0_8:
        MOVS     R0,R5
        LDR.W    R1,??DataTable75  ;; pProperty
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+20]
        BLX      R1
//  637     if (Result == USB_NOT_READY)
        CMP      R0,#+3
        BNE.N    ??NoData_Setup0_11
//  638     {
//  639       ControlState = PAUSE;
        MOVS     R0,#+9
//  640       goto exit_NoData_Setup0;
        B.N      ??NoData_Setup0_6
//  641     }
//  642   }
//  643 
//  644   if (Result != USB_SUCCESS)
??NoData_Setup0_11:
        CMP      R0,#+0
        BNE.N    ??NoData_Setup0_4
//  645   {
//  646     ControlState = STALLED;
//  647     goto exit_NoData_Setup0;
//  648   }
//  649 
//  650   ControlState = WAIT_STATUS_IN;/* After no data stage SETUP */
??NoData_Setup0_5:
        MOVS     R0,#+6
//  651 
//  652   USB_StatusIn();
        LDR.N    R1,??DataTable69  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        LDR.N    R2,??DataTable52  ;; 0x40006004
        MOVS     R3,#+0
        STR      R3,[R2, R1, LSL #+1]
        LDR.W    R1,??DataTable79  ;; SaveTState
        MOVS     R2,#+48
        STRH     R2,[R1, #+0]
//  653 
//  654 exit_NoData_Setup0:
//  655   pInformation->ControlState = ControlState;
??NoData_Setup0_6:
        LDR      R1,[R4, #+0]
        STRB     R0,[R1, #+8]
//  656   return;
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        CFI EndBlock cfiBlock11
//  657 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable52:
        DC32     0x40006004
//  658 
//  659 /*******************************************************************************
//  660 * Function Name  : Data_Setup0.
//  661 * Description    : Proceed the processing of setup request with data stage.
//  662 * Input          : None.
//  663 * Output         : None.
//  664 * Return         : None.
//  665 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function Data_Setup0
        THUMB
//  666 void Data_Setup0(void)
//  667 {
Data_Setup0:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        SUB      SP,SP,#+8
        CFI CFA R13+16
//  668   u8 *(*CopyRoutine)(u16);
//  669   RESULT Result;
//  670   u32 Request_No = pInformation->USBbRequest;
        LDR.N    R4,??DataTable77  ;; pInformation
        LDR      R0,[R4, #+0]
        LDRB     R1,[R0, #+1]
//  671 
//  672   u32 Related_Endpoint, Reserved;
//  673   u32 wOffset, Status;
//  674 
//  675 
//  676 
//  677   CopyRoutine = NULL;
//  678   wOffset = 0;
//  679 
//  680   if (Request_No == GET_DESCRIPTOR)
        CMP      R1,#+6
        BNE.N    ??Data_Setup0_0
//  681   {
//  682     if (Type_Recipient == (STANDARD_REQUEST | DEVICE_RECIPIENT))
        LDRB     R1,[R0, #+0]
        TST      R1,#0x7F
        BNE.N    ??Data_Setup0_1
//  683     {
//  684       u8 wValue1 = pInformation->USBwValue1;
        LDRB     R0,[R0, #+2]
//  685       if (wValue1 == DEVICE_DESCRIPTOR)
        CMP      R0,#+1
        BNE.N    ??Data_Setup0_2
//  686       {
//  687         CopyRoutine = pProperty->GetDeviceDescriptor;
        LDR.N    R0,??DataTable75  ;; pProperty
        LDR      R0,[R0, #+0]
        LDR      R1,[R0, #+28]
        B.N      ??Data_Setup0_3
//  688       }
//  689       else if (wValue1 == CONFIG_DESCRIPTOR)
??Data_Setup0_2:
        CMP      R0,#+2
        BNE.N    ??Data_Setup0_4
//  690       {
//  691         CopyRoutine = pProperty->GetConfigDescriptor;
        LDR.N    R0,??DataTable75  ;; pProperty
        LDR      R0,[R0, #+0]
        LDR      R1,[R0, #+32]
        B.N      ??Data_Setup0_3
//  692       }
//  693       else if (wValue1 == STRING_DESCRIPTOR)
??Data_Setup0_4:
        CMP      R0,#+3
        BNE.N    ??Data_Setup0_1
//  694       {
//  695         CopyRoutine = pProperty->GetStringDescriptor;
        LDR.N    R0,??DataTable75  ;; pProperty
        LDR      R0,[R0, #+0]
        LDR      R1,[R0, #+36]
        B.N      ??Data_Setup0_3
//  696       }  /* End of GET_DESCRIPTOR */
//  697     }
//  698   }
//  699 
//  700   /*GET STATUS*/
//  701   else if ((Request_No == GET_STATUS) && (pInformation->USBwValue == 0)
//  702            && (pInformation->USBwLength == 0x0002)
//  703            && (pInformation->USBwIndex1 == 0))
??Data_Setup0_0:
        CMP      R1,#+0
        BNE.N    ??Data_Setup0_5
        LDRH     R1,[R0, #+2]
        CBNZ     R1,??Data_Setup0_1
        LDRH     R1,[R0, #+6]
        CMP      R1,#+2
        BNE.N    ??Data_Setup0_1
        LDRB     R1,[R0, #+4]
        CBNZ     R1,??Data_Setup0_1
//  704   {
//  705     /* GET STATUS for Device*/
//  706     if ((Type_Recipient == (STANDARD_REQUEST | DEVICE_RECIPIENT))
//  707         && (pInformation->USBwIndex == 0))
        LDRB     R1,[R0, #+0]
        TST      R1,#0x7F
        BNE.N    ??Data_Setup0_6
        LDRH     R2,[R0, #+4]
        CBNZ     R2,??Data_Setup0_6
//  708     {
//  709       CopyRoutine = Standard_GetStatus;
??Data_Setup0_7:
        LDR.N    R1,??Data_Setup0_8  ;; Standard_GetStatus
        B.N      ??Data_Setup0_3
//  710     }
//  711 
//  712     /* GET STATUS for Interface*/
//  713     else if (Type_Recipient == (STANDARD_REQUEST | INTERFACE_RECIPIENT))
??Data_Setup0_6:
        AND      R2,R1,#0x7F
        CMP      R2,#+1
        BNE.N    ??Data_Setup0_9
//  714     {
//  715       if (((*pProperty->Class_Get_Interface_Setting)(pInformation->USBwIndex0, 0) == USB_SUCCESS)
//  716           && (pInformation->Current_Configuration != 0))
        MOVS     R1,#+0
        LDRB     R0,[R0, #+5]
        LDR.N    R2,??DataTable75  ;; pProperty
        LDR      R2,[R2, #+0]
        LDR      R2,[R2, #+24]
        BLX      R2
        CBNZ     R0,??Data_Setup0_1
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+10]
        CMP      R0,#+0
        BNE.N    ??Data_Setup0_7
//  717       {
//  718         CopyRoutine = Standard_GetStatus;
//  719       }
//  720     }
//  721 
//  722     /* GET STATUS for EndPoint*/
//  723     else if (Type_Recipient == (STANDARD_REQUEST | ENDPOINT_RECIPIENT))
//  724     {
//  725       Related_Endpoint = (pInformation->USBwIndex0 & 0x0f);
//  726       Reserved = pInformation->USBwIndex0 & 0x70;
//  727 
//  728       if (ValBit(pInformation->USBwIndex0, 7))
//  729       {
//  730         /*Get Status of endpoint & stall the request if the related_ENdpoint
//  731         is Disabled*/
//  732         Status = _GetEPTxStatus(Related_Endpoint);
//  733       }
//  734       else
//  735       {
//  736         Status = _GetEPRxStatus(Related_Endpoint);
//  737       }
//  738 
//  739       if ((Related_Endpoint < Device_Table.Total_Endpoint) && (Reserved == 0)
//  740           && (Status != 0))
//  741       {
//  742         CopyRoutine = Standard_GetStatus;
//  743       }
//  744     }
//  745 
//  746   }
//  747 
//  748   /*GET CONFIGURATION*/
//  749   else if (Request_No == GET_CONFIGURATION)
//  750   {
//  751     if (Type_Recipient == (STANDARD_REQUEST | DEVICE_RECIPIENT))
//  752     {
//  753       CopyRoutine = Standard_GetConfiguration;
//  754     }
//  755   }
//  756   /*GET INTERFACE*/
//  757   else if (Request_No == GET_INTERFACE)
//  758   {
//  759     if ((Type_Recipient == (STANDARD_REQUEST | INTERFACE_RECIPIENT))
//  760         && (pInformation->Current_Configuration != 0) && (pInformation->USBwValue == 0)
//  761         && (pInformation->USBwIndex1 == 0) && (pInformation->USBwLength == 0x0001)
//  762         && ((*pProperty->Class_Get_Interface_Setting)(pInformation->USBwIndex0, 0) == USB_SUCCESS))
//  763     {
//  764       CopyRoutine = Standard_GetInterface;
//  765     }
//  766 
//  767   }
//  768   
//  769   if (CopyRoutine)
//  770   {
//  771     pInformation->Ctrl_Info.Usb_wOffset = wOffset;
//  772     pInformation->Ctrl_Info.CopyData = CopyRoutine;
//  773     /* sb in the original the cast to word was directly */
//  774     /* now the cast is made step by step */
//  775     (*CopyRoutine)(0);
//  776     Result = USB_SUCCESS;
//  777   }
//  778   else
//  779   {
//  780     Result = (*pProperty->Class_Data_Setup)(pInformation->USBbRequest);
??Data_Setup0_1:
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+1]
        LDR.N    R1,??DataTable75  ;; pProperty
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  781     if (Result == USB_NOT_READY)
        CMP      R0,#+3
        BNE.N    ??Data_Setup0_10
//  782     {
//  783       pInformation->ControlState = PAUSE;
        LDR      R0,[R4, #+0]
        MOVS     R1,#+9
        STRB     R1,[R0, #+8]
//  784       return;
        B.N      ??Data_Setup0_11
//  785     }
//  786   }
??Data_Setup0_9:
        AND      R1,R1,#0x7F
        CMP      R1,#+2
        BNE.N    ??Data_Setup0_1
        LDRB     R0,[R0, #+5]
        AND      R1,R0,#0xF
        AND      R2,R0,#0x70
        TST      R0,#0x80
        BEQ.N    ??Data_Setup0_12
        LDR.N    R0,??DataTable81  ;; 0x40005c00
        LDR      R0,[R0, R1, LSL #+2]
        AND      R0,R0,#0x30
        B.N      ??Data_Setup0_13
??Data_Setup0_12:
        LDR.N    R0,??DataTable81  ;; 0x40005c00
        LDR      R0,[R0, R1, LSL #+2]
        AND      R0,R0,#0x3000
??Data_Setup0_13:
        LDR.N    R3,??DataTable80  ;; Device_Table
        LDRB     R3,[R3, #+0]
        CMP      R1,R3
        BCS.N    ??Data_Setup0_1
        CMP      R2,#+0
        BNE.N    ??Data_Setup0_1
        CMP      R0,#+0
        BNE.N    ??Data_Setup0_7
        B.N      ??Data_Setup0_1
??Data_Setup0_5:
        CMP      R1,#+8
        BNE.N    ??Data_Setup0_14
        LDRB     R0,[R0, #+0]
        TST      R0,#0x7F
        BNE.N    ??Data_Setup0_1
        LDR.N    R1,??Data_Setup0_8+0x4  ;; Standard_GetConfiguration
        B.N      ??Data_Setup0_3
??Data_Setup0_14:
        CMP      R1,#+10
        BNE.N    ??Data_Setup0_1
        LDRB     R1,[R0, #+0]
        AND      R1,R1,#0x7F
        CMP      R1,#+1
        BNE.N    ??Data_Setup0_1
        LDRB     R1,[R0, #+10]
        CMP      R1,#+0
        BEQ.N    ??Data_Setup0_1
        LDRH     R1,[R0, #+2]
        CMP      R1,#+0
        BNE.N    ??Data_Setup0_1
        LDRB     R1,[R0, #+4]
        CMP      R1,#+0
        BNE.N    ??Data_Setup0_1
        LDRH     R1,[R0, #+6]
        CMP      R1,#+1
        BNE.N    ??Data_Setup0_1
        MOVS     R1,#+0
        LDRB     R0,[R0, #+5]
        LDR.N    R2,??DataTable75  ;; pProperty
        LDR      R2,[R2, #+0]
        LDR      R2,[R2, #+24]
        BLX      R2
        CMP      R0,#+0
        BNE.N    ??Data_Setup0_1
        LDR.N    R1,??Data_Setup0_8+0x8  ;; Standard_GetInterface
??Data_Setup0_3:
        MOVS     R0,R1
        BEQ.N    ??Data_Setup0_1
        LDR      R0,[R4, #+0]
        MOVS     R2,#+0
        STRH     R2,[R0, #+18]
        STR      R1,[R0, #+24]
        MOVS     R0,#+0
        BLX      R1
        MOVS     R0,#+0
//  787 
//  788   if (pInformation->Ctrl_Info.Usb_wLength == 0xFFFF)
??Data_Setup0_10:
        LDR      R1,[R4, #+0]
        LDRH     R2,[R1, #+16]
        MOVW     R3,#+65535
        CMP      R2,R3
        BNE.N    ??Data_Setup0_15
//  789   {
//  790     /* Data is not ready, wait it */
//  791     pInformation->ControlState = PAUSE;
        MOVS     R0,#+9
??Data_Setup0_16:
        STRB     R0,[R1, #+8]
//  792     return;
        B.N      ??Data_Setup0_11
//  793   }
//  794   if ((Result == USB_UNSUPPORT) || (pInformation->Ctrl_Info.Usb_wLength == 0))
??Data_Setup0_15:
        CMP      R0,#+2
        BEQ.N    ??Data_Setup0_17
        CBNZ     R2,??Data_Setup0_18
//  795   {
//  796     /* Unsupported request */
//  797     pInformation->ControlState = STALLED;
??Data_Setup0_17:
        MOVS     R0,#+8
        B.N      ??Data_Setup0_16
//  798     return;
//  799   }
//  800 
//  801 
//  802   if (ValBit(pInformation->USBbmRequestType, 7))
??Data_Setup0_18:
        LDRB     R0,[R1, #+0]
        TST      R0,#0x80
        BEQ.N    ??Data_Setup0_19
//  803   {
//  804     /* Device ==> Host */
//  805     vu32 wLength = pInformation->USBwLength;
        LDRH     R0,[R1, #+6]
        STR      R0,[SP, #+0]
//  806      
//  807     /* Restrict the data length to be the one host asks */
//  808     if (pInformation->Ctrl_Info.Usb_wLength > wLength)
        LDR      R3,[SP, #+0]
        CMP      R3,R2
        BCS.N    ??Data_Setup0_20
//  809     {
//  810       pInformation->Ctrl_Info.Usb_wLength = wLength;
        LDR      R0,[SP, #+0]
        STRH     R0,[R1, #+16]
        B.N      ??Data_Setup0_21
//  811     }
//  812     
//  813     else if (pInformation->Ctrl_Info.Usb_wLength < pInformation->USBwLength)
??Data_Setup0_20:
        CMP      R2,R0
        BCS.N    ??Data_Setup0_21
        LDR.N    R0,??DataTable75  ;; pProperty
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+44]
        CMP      R2,R0
        BCS.N    ??Data_Setup0_22
//  814     {
//  815       if (pInformation->Ctrl_Info.Usb_wLength < pProperty->MaxPacketSize)
//  816       {
//  817         Data_Mul_MaxPacketSize = FALSE;
        LDR.N    R0,??DataTable66  ;; Data_Mul_MaxPacketSize
        MOVS     R2,#+0
        B.N      ??Data_Setup0_23
//  818       }
//  819       else if ((pInformation->Ctrl_Info.Usb_wLength % pProperty->MaxPacketSize) == 0)
??Data_Setup0_22:
        SDIV     R3,R2,R0
        MLS      R0,R3,R0,R2
        CBNZ     R0,??Data_Setup0_21
//  820       {
//  821         Data_Mul_MaxPacketSize = TRUE;
        LDR.N    R0,??DataTable66  ;; Data_Mul_MaxPacketSize
        MOVS     R2,#+1
??Data_Setup0_23:
        STRB     R2,[R0, #+0]
//  822       }
//  823     }   
//  824 
//  825     pInformation->Ctrl_Info.PacketSize = pProperty->MaxPacketSize;
??Data_Setup0_21:
        LDR.N    R0,??DataTable75  ;; pProperty
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+44]
        STRH     R0,[R1, #+20]
//  826     DataStageIn();
        BL       DataStageIn
        B.N      ??Data_Setup0_11
//  827   }
//  828   else
//  829   {
//  830     pInformation->ControlState = OUT_DATA;
??Data_Setup0_19:
        MOVS     R0,#+3
        STRB     R0,[R1, #+8]
//  831     vSetEPRxStatus(EP_RX_VALID); /* enable for next data reception */
        LDR.N    R0,??DataTable78  ;; SaveRState
        MOV      R1,#+12288
        STRH     R1,[R0, #+0]
??Data_Setup0_11:
        ADD      SP,SP,#+8
        CFI CFA R13+8
        POP      {R4,PC}          ;; return
        DATA
??Data_Setup0_8:
        DC32     Standard_GetStatus
        DC32     Standard_GetConfiguration
        DC32     Standard_GetInterface
        CFI EndBlock cfiBlock12
//  832   }
//  833 
//  834   return;
//  835 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable66:
        DC32     Data_Mul_MaxPacketSize
//  836 
//  837 /*******************************************************************************
//  838 * Function Name  : Setup0_Process
//  839 * Description    : Get the device request data and dispatch to individual process.
//  840 * Input          : None.
//  841 * Output         : None.
//  842 * Return         : Post0_Process.
//  843 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function Setup0_Process
        THUMB
//  844 u8 Setup0_Process(void)
//  845 {
Setup0_Process:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//  846 
//  847   union
//  848   {
//  849     u8* b;
//  850     u16* w;
//  851   } pBuf;
//  852 
//  853   pBuf.b = PMAAddr + (u8 *)(_GetEPRxAddr(ENDP0) * 2); /* *2 for 32 bits addr */
        LDR.N    R0,??Setup0_Process_0  ;; 0x40006000
        LDR.N    R1,??DataTable69  ;; 0x40005c50
        LDR      R1,[R1, #+0]
        UXTH     R1,R1
        LDR.N    R2,??Setup0_Process_0+0x4  ;; 0x40006008
        LDR      R1,[R2, R1, LSL #+1]
        UXTH     R1,R1
        ADD      R4,R0,R1, LSL #+1
//  854 
//  855   if (pInformation->ControlState != PAUSE)
        LDR.N    R5,??DataTable77  ;; pInformation
        LDR      R0,[R5, #+0]
        LDRB     R1,[R0, #+8]
        CMP      R1,#+9
        BEQ.N    ??Setup0_Process_1
//  856   {
//  857     pInformation->USBbmRequestType = *pBuf.b++; /* bmRequestType */
        LDRB     R1,[R4], #+1
        STRB     R1,[R0, #+0]
//  858     pInformation->USBbRequest = *pBuf.b++; /* bRequest */
        LDRB     R1,[R4], #+1
        STRB     R1,[R0, #+1]
//  859     pBuf.w++;  /* word not accessed because of 32 bits addressing */
        ADDS     R4,R4,#+2
//  860     pInformation->USBwValue = ByteSwap(*pBuf.w++); /* wValue */
        LDRH     R0,[R4], #+2
        BL       ByteSwap
        LDR      R1,[R5, #+0]
        STRH     R0,[R1, #+2]
//  861     pBuf.w++;  /* word not accessed because of 32 bits addressing */
        ADDS     R4,R4,#+2
//  862     pInformation->USBwIndex  = ByteSwap(*pBuf.w++); /* wIndex */
        LDRH     R0,[R4], #+2
        BL       ByteSwap
        LDR      R1,[R5, #+0]
        STRH     R0,[R1, #+4]
//  863     pBuf.w++;  /* word not accessed because of 32 bits addressing */
//  864     pInformation->USBwLength = *pBuf.w; /* wLength */
        LDRH     R0,[R4, #+2]
        STRH     R0,[R1, #+6]
//  865   }
//  866 
//  867   pInformation->ControlState = SETTING_UP;
??Setup0_Process_1:
        LDR      R0,[R5, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+8]
//  868   if (pInformation->USBwLength == 0)
        LDRH     R0,[R0, #+6]
        CBNZ     R0,??Setup0_Process_2
//  869   {
//  870     /* Setup with no data stage */
//  871     NoData_Setup0();
        BL       NoData_Setup0
        B.N      ??Setup0_Process_3
//  872   }
//  873   else
//  874   {
//  875     /* Setup with data stage */
//  876     Data_Setup0();
??Setup0_Process_2:
        BL       Data_Setup0
//  877   }
//  878   return Post0_Process();
??Setup0_Process_3:
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,LR}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.N      Post0_Process
        Nop      
        DATA
??Setup0_Process_0:
        DC32     0x40006000
        DC32     0x40006008
        CFI EndBlock cfiBlock13
//  879 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable69:
        DC32     0x40005c50
//  880 
//  881 /*******************************************************************************
//  882 * Function Name  : In0_Process
//  883 * Description    : Process the IN token on all default endpoint.
//  884 * Input          : None.
//  885 * Output         : None.
//  886 * Return         : Post0_Process.
//  887 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function In0_Process
        THUMB
//  888 u8 In0_Process(void)
//  889 {
In0_Process:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  890   u32 ControlState = pInformation->ControlState;
        LDR.N    R4,??DataTable77  ;; pInformation
        LDR      R0,[R4, #+0]
        LDRB     R1,[R0, #+8]
//  891 
//  892   if ((ControlState == IN_DATA) || (ControlState == LAST_IN_DATA))
        CMP      R1,#+2
        BEQ.N    ??In0_Process_0
        CMP      R1,#+4
        BNE.N    ??In0_Process_1
//  893   {
//  894     DataStageIn();
??In0_Process_0:
        BL       DataStageIn
//  895     /* ControlState may be changed outside the function */
//  896     ControlState = pInformation->ControlState;
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+8]
        B.N      ??In0_Process_2
//  897   }
//  898 
//  899   else if (ControlState == WAIT_STATUS_IN)
??In0_Process_1:
        CMP      R1,#+6
        BNE.N    ??In0_Process_3
//  900   {
//  901     if ((pInformation->USBbRequest == SET_ADDRESS) &&
//  902         (Type_Recipient == (STANDARD_REQUEST | DEVICE_RECIPIENT)))
        LDRB     R1,[R0, #+1]
        CMP      R1,#+5
        BNE.N    ??In0_Process_4
        LDRB     R1,[R0, #+0]
        TST      R1,#0x7F
        BNE.N    ??In0_Process_4
//  903     {
//  904       SetDeviceAddress(pInformation->USBwValue0);
        LDRB     R0,[R0, #+3]
        BL       SetDeviceAddress
//  905       pUser_Standard_Requests->User_SetDeviceAddress();
        LDR.N    R0,??DataTable72  ;; pUser_Standard_Requests
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+32]
        BLX      R0
//  906     }
//  907     (*pProperty->Process_Status_IN)();
??In0_Process_4:
        LDR.N    R0,??DataTable75  ;; pProperty
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+8]
        BLX      R0
//  908     ControlState = STALLED;
//  909   }
//  910 
//  911   else
//  912   {
//  913     ControlState = STALLED;
??In0_Process_3:
        MOVS     R0,#+8
//  914   }
//  915 
//  916   pInformation->ControlState = ControlState;
??In0_Process_2:
        LDR      R1,[R4, #+0]
        STRB     R0,[R1, #+8]
//  917 
//  918   return Post0_Process();
        POP      {R4,LR}
        CFI R4 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.N      Post0_Process
        CFI EndBlock cfiBlock14
//  919 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable72:
        DC32     pUser_Standard_Requests
//  920 
//  921 /*******************************************************************************
//  922 * Function Name  : Out0_Process
//  923 * Description    : Process the OUT token on all default endpoint.
//  924 * Input          : None.
//  925 * Output         : None.
//  926 * Return         : Post0_Process.
//  927 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function Out0_Process
        THUMB
//  928 u8 Out0_Process(void)
//  929 {
Out0_Process:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  930   u32 ControlState = pInformation->ControlState;
        LDR.N    R4,??DataTable77  ;; pInformation
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+8]
//  931 
//  932   if ((ControlState == OUT_DATA) || (ControlState == LAST_OUT_DATA))
        CMP      R0,#+3
        BEQ.N    ??Out0_Process_0
        CMP      R0,#+5
        BNE.N    ??Out0_Process_1
//  933   {
//  934     DataStageOut();
??Out0_Process_0:
        BL       DataStageOut
//  935     ControlState = pInformation->ControlState; /* may be changed outside the function */
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+8]
        B.N      ??Out0_Process_2
//  936   }
//  937 
//  938   else if (ControlState == WAIT_STATUS_OUT)
??Out0_Process_1:
        CMP      R0,#+7
        BNE.N    ??Out0_Process_3
//  939   {
//  940     (*pProperty->Process_Status_OUT)();
        LDR.N    R0,??DataTable75  ;; pProperty
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+12]
        BLX      R0
//  941     ControlState = STALLED;
//  942   }
//  943 
//  944   else if ((ControlState == IN_DATA) || (ControlState == LAST_IN_DATA))
//  945   {
//  946     /* host aborts the transfer before finish */
//  947     ControlState = STALLED;
??Out0_Process_3:
        MOVS     R0,#+8
//  948   }
//  949 
//  950   /* Unexpect state, STALL the endpoint */
//  951   else
//  952   {
//  953     ControlState = STALLED;
//  954   }
//  955 
//  956   pInformation->ControlState = ControlState;
??Out0_Process_2:
        LDR      R1,[R4, #+0]
        STRB     R0,[R1, #+8]
//  957 
//  958   return Post0_Process();
        POP      {R4,LR}
        CFI EndBlock cfiBlock15
        REQUIRE Post0_Process
        ;; // Fall through to label Post0_Process
//  959 }
//  960 
//  961 /*******************************************************************************
//  962 * Function Name  : Post0_Process
//  963 * Description    : Stall the Endpoint 0 in case of error.
//  964 * Input          : None.
//  965 * Output         : None.
//  966 * Return         : - 0 if the control State is in PAUSE
//  967 *                  - 1 if not.
//  968 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function Post0_Process
        THUMB
//  969 u8 Post0_Process(void)
//  970 {
Post0_Process:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  971   SetEPRxCount(ENDP0, Device_Property.MaxPacketSize);
        LDR.N    R0,??DataTable76  ;; Device_Property
        LDRB     R1,[R0, #+44]
        MOVS     R0,#+0
        BL       SetEPRxCount
//  972 
//  973   if (pInformation->ControlState == STALLED)
        LDR.N    R0,??DataTable77  ;; pInformation
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+8]
        CMP      R1,#+8
        BNE.N    ??Post0_Process_0
//  974   {
//  975     vSetEPRxStatus(EP_RX_STALL);
        LDR.N    R1,??DataTable78  ;; SaveRState
        MOV      R2,#+4096
        STRH     R2,[R1, #+0]
//  976     vSetEPTxStatus(EP_TX_STALL);
        LDR.N    R1,??DataTable79  ;; SaveTState
        MOVS     R2,#+16
        STRH     R2,[R1, #+0]
//  977   }
//  978 
//  979   return (pInformation->ControlState == PAUSE);
??Post0_Process_0:
        LDRB     R0,[R0, #+8]
        CMP      R0,#+9
        BNE.N    ??Post0_Process_1
        MOVS     R0,#+1
        B.N      ??Post0_Process_2
??Post0_Process_1:
        MOVS     R0,#+0
??Post0_Process_2:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock16
//  980 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable75:
        DC32     pProperty

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable76:
        DC32     Device_Property

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable77:
        DC32     pInformation

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable78:
        DC32     SaveRState

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable79:
        DC32     SaveTState
//  981 
//  982 /*******************************************************************************
//  983 * Function Name  : SetDeviceAddress.
//  984 * Description    : Set the device and all the used Endpoints addresses.
//  985 * Input          : - Val: device adress.
//  986 * Output         : None.
//  987 * Return         : None.
//  988 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function SetDeviceAddress
        THUMB
//  989 void SetDeviceAddress(u8 Val)
//  990 {
SetDeviceAddress:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  991   u32 i;
//  992   u32 nEP = Device_Table.Total_Endpoint;
        LDR.N    R1,??DataTable80  ;; Device_Table
        LDRB     R1,[R1, #+0]
//  993 
//  994   /* set address in every used endpoint */
//  995   for (i = 0; i < nEP; i++)
        MOVS     R2,#+0
        CBZ      R1,??SetDeviceAddress_0
        MOVW     R3,#+36751
        LDR.N    R4,??DataTable81  ;; 0x40005c00
//  996   {
//  997     _SetEPAddress((u8)i, (u8)i);
??SetDeviceAddress_1:
        UXTB     R12,R2
        LDR      LR,[R4, R12, LSL #+2]
        AND      LR,R3,LR
        ORR      LR,R12,LR
        STR      LR,[R4, R12, LSL #+2]
//  998   } /* for */
        ADDS     R2,R2,#+1
        CMP      R2,R1
        BCC.N    ??SetDeviceAddress_1
//  999   _SetDADDR(Val | DADDR_EF); /* set device address and enable function */
??SetDeviceAddress_0:
        ORR      R0,R0,#0x80
        LDR.N    R1,??SetDeviceAddress_2  ;; 0x40005c4c
        STR      R0,[R1, #+0]
// 1000 }
        POP      {R4,PC}          ;; return
        DATA
??SetDeviceAddress_2:
        DC32     0x40005c4c
        CFI EndBlock cfiBlock17

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable80:
        DC32     Device_Table

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable81:
        DC32     0x40005c00
// 1001 
// 1002 /*******************************************************************************
// 1003 * Function Name  : NOP_Process
// 1004 * Description    : No operation function.
// 1005 * Input          : None.
// 1006 * Output         : None.
// 1007 * Return         : None.
// 1008 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function NOP_Process
        THUMB
// 1009 void NOP_Process(void)
// 1010 {
// 1011 }
NOP_Process:
        BX       LR               ;; return
        CFI EndBlock cfiBlock18

        END
// 1012 
// 1013 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
//     5 bytes in section .bss
// 2 152 bytes in section .text
// 
// 2 152 bytes of CODE memory
//     5 bytes of DATA memory
//
//Errors: none
//Warnings: none
