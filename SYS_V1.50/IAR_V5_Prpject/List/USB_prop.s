///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:03:45 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\SYS_V1.50\source\USB_prop.c            /
//    Command line =  E:\Mini-DS\DS203\SYS_V1.50\source\USB_prop.c -lA        /
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
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\USB_prop /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME USB_prop

        EXTERN Bot_Abort
        EXTERN Bot_State
        EXTERN CBW
        EXTERN ClearDTOG_RX
        EXTERN ClearDTOG_TX
        EXTERN Clear_Status_Out
        EXTERN Device_Info
        EXTERN Get_SerialNum
        EXTERN MASS_ConfigDescriptor
        EXTERN MASS_DeviceDescriptor
        EXTERN MASS_StringInterface
        EXTERN MASS_StringLangID
        EXTERN MASS_StringProduct
        EXTERN MASS_StringSerial
        EXTERN MASS_StringVendor
        EXTERN NOP_Process
        EXTERN PowerOn
        EXTERN SetBTABLE
        EXTERN SetDeviceAddress
        EXTERN SetEPRxAddr
        EXTERN SetEPRxCount
        EXTERN SetEPRxStatus
        EXTERN SetEPRxValid
        EXTERN SetEPTxAddr
        EXTERN SetEPTxStatus
        EXTERN SetEPType
        EXTERN Standard_GetDescriptorData
        EXTERN bDeviceState
        EXTERN pInformation
        EXTERN wInterrupt_Mask

        PUBLIC Config_Descriptor
        PUBLIC Device_Descriptor
        PUBLIC Device_Property
        PUBLIC Device_Table
        PUBLIC Get_Max_Lun
        PUBLIC MASS_Data_Setup
        PUBLIC MASS_GetConfigDescriptor
        PUBLIC MASS_GetDeviceDescriptor
        PUBLIC MASS_GetStringDescriptor
        PUBLIC MASS_Get_Interface_Setting
        PUBLIC MASS_NoData_Setup
        PUBLIC MASS_Reset
        PUBLIC MASS_Status_In
        PUBLIC MASS_Status_Out
        PUBLIC MASS_init
        PUBLIC Mass_Storage_ClearFeature
        PUBLIC Mass_Storage_SetConfiguration
        PUBLIC Mass_Storage_SetDeviceAddress
        PUBLIC Max_Lun
        PUBLIC String_Descriptor
        PUBLIC User_Standard_Requests
        
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
        
// E:\Mini-DS\DS203\SYS_V1.50\source\USB_prop.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : usb_prop.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.2.1
//    5 * Date               : 09/22/2008
//    6 * Description        : All processing related to Mass Storage Demo
//    7 *******************************************************************************/
//    8 
//    9 #include "Config.h"
//   10 #include "Memory.h"
//   11 //#include "Mass_mal.h"
//   12 #include "USB_desc.h"
//   13 #include "USB_pwr.h"
//   14 #include "USB_bot.h"
//   15 #include "USB_prop.h"
//   16 #include "USB_lib.h"
//   17 

        SECTION `.bss`:DATA:NOROOT(2)
//   18 u32 Max_Lun = 0;
Max_Lun:
        DS8 4
//   19 

        SECTION `.data`:DATA:NOROOT(2)
//   20 DEVICE Device_Table =
Device_Table:
        DATA
        DC8 3, 1, 0, 0
//   21   {
//   22     EP_NUM,
//   23     1
//   24   };
//   25 

        SECTION `.data`:DATA:NOROOT(2)
//   26 DEVICE_PROP Device_Property =
Device_Property:
        DATA
        DC32 MASS_init, MASS_Reset, MASS_Status_In, MASS_Status_Out
        DC32 MASS_Data_Setup, MASS_NoData_Setup, MASS_Get_Interface_Setting
        DC32 MASS_GetDeviceDescriptor, MASS_GetConfigDescriptor
        DC32 MASS_GetStringDescriptor, 0H
        DC8 64, 0, 0, 0
//   27   {
//   28     MASS_init,
//   29     MASS_Reset,
//   30     MASS_Status_In,
//   31     MASS_Status_Out,
//   32     MASS_Data_Setup,
//   33     MASS_NoData_Setup,
//   34     MASS_Get_Interface_Setting,
//   35     MASS_GetDeviceDescriptor,
//   36     MASS_GetConfigDescriptor,
//   37     MASS_GetStringDescriptor,
//   38     0,
//   39     0x40 /*MAX PACKET SIZE*/
//   40   };
//   41 

        SECTION `.data`:DATA:NOROOT(2)
//   42 USER_STANDARD_REQUESTS User_Standard_Requests =
User_Standard_Requests:
        DATA
        DC32 NOP_Process, Mass_Storage_SetConfiguration, NOP_Process
        DC32 NOP_Process, NOP_Process, Mass_Storage_ClearFeature, NOP_Process
        DC32 NOP_Process, Mass_Storage_SetDeviceAddress
//   43   {
//   44     Mass_Storage_GetConfiguration,
//   45     Mass_Storage_SetConfiguration,
//   46     Mass_Storage_GetInterface,
//   47     Mass_Storage_SetInterface,
//   48     Mass_Storage_GetStatus,
//   49     Mass_Storage_ClearFeature,
//   50     Mass_Storage_SetEndPointFeature,
//   51     Mass_Storage_SetDeviceFeature,
//   52     Mass_Storage_SetDeviceAddress
//   53   };
//   54 

        SECTION `.data`:DATA:NOROOT(2)
//   55 ONE_DESCRIPTOR Device_Descriptor =
Device_Descriptor:
        DATA
        DC32 MASS_DeviceDescriptor
        DC16 18
        DC8 0, 0
//   56   {
//   57     (u8*)MASS_DeviceDescriptor,
//   58     MASS_SIZ_DEVICE_DESC
//   59   };
//   60 

        SECTION `.data`:DATA:NOROOT(2)
//   61 ONE_DESCRIPTOR Config_Descriptor =
Config_Descriptor:
        DATA
        DC32 MASS_ConfigDescriptor
        DC16 32
        DC8 0, 0
//   62   {
//   63     (u8*)MASS_ConfigDescriptor,
//   64     MASS_SIZ_CONFIG_DESC
//   65   };
//   66 

        SECTION `.data`:DATA:NOROOT(2)
//   67 ONE_DESCRIPTOR String_Descriptor[5] =
String_Descriptor:
        DATA
        DC32 MASS_StringLangID
        DC16 4
        DC8 0, 0
        DC32 MASS_StringVendor
        DC16 38
        DC8 0, 0
        DC32 MASS_StringProduct
        DC16 38
        DC8 0, 0
        DC32 MASS_StringSerial
        DC16 26
        DC8 0, 0
        DC32 MASS_StringInterface
        DC16 16
        DC8 0, 0
//   68   {
//   69     {(u8*)MASS_StringLangID, MASS_SIZ_STRING_LANGID},
//   70     {(u8*)MASS_StringVendor, MASS_SIZ_STRING_VENDOR},
//   71     {(u8*)MASS_StringProduct, MASS_SIZ_STRING_PRODUCT},
//   72     {(u8*)MASS_StringSerial, MASS_SIZ_STRING_SERIAL},
//   73     {(u8*)MASS_StringInterface, MASS_SIZ_STRING_INTERFACE},
//   74   };
//   75 
//   76 extern unsigned char Bot_State;
//   77 extern Bulk_Only_CBW CBW;
//   78 
//   79 /*******************************************************************************
//   80 * Function Name  : MASS_init
//   81 * Description    : Mass Storage init routine.
//   82 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function MASS_init
        THUMB
//   83 void MASS_init()
//   84 {
MASS_init:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//   85   /* Update the serial number string descriptor with the data from the unique
//   86   ID*/
//   87   Get_SerialNum();
        BL       Get_SerialNum
//   88 
//   89   pInformation->Current_Configuration = 0;
        LDR.N    R0,??DataTable19  ;; pInformation
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        STRB     R1,[R0, #+10]
//   90 
//   91   /* Connect the device */
//   92   PowerOn();
        BL       PowerOn
//   93 
//   94   /* USB interrupts initialization */
//   95   /* clear pending interrupts */
//   96   _SetISTR(0);
        LDR.N    R0,??MASS_init_0  ;; 0x40005c40
        MOVS     R1,#+0
        STR      R1,[R0, #+4]
//   97   wInterrupt_Mask = IMR_MSK;
        LDR.N    R0,??MASS_init_0+0x4  ;; wInterrupt_Mask
        MOV      R1,#+33792
        STRH     R1,[R0, #+0]
//   98   /* set interrupts mask */
//   99   _SetCNTR(wInterrupt_Mask);
        LDR.N    R0,??MASS_init_0  ;; 0x40005c40
        STR      R1,[R0, #+0]
//  100 
//  101   bDeviceState = UNCONNECTED;
        LDR.N    R0,??DataTable12  ;; bDeviceState
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  102 }
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        DATA
??MASS_init_0:
        DC32     0x40005c40
        DC32     wInterrupt_Mask
        CFI EndBlock cfiBlock0
//  103 
//  104 /*******************************************************************************
//  105 * Function Name  : MASS_Reset
//  106 * Description    : Mass Storage reset routine.
//  107 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function MASS_Reset
        THUMB
//  108 void MASS_Reset()
//  109 {
MASS_Reset:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  110   /* Set the device as not configured */
//  111   Device_Info.Current_Configuration = 0;
        LDR.N    R0,??MASS_Reset_0  ;; Device_Info
        MOVS     R1,#+0
        STRB     R1,[R0, #+10]
//  112 
//  113   /* Current Feature initialization */
//  114   pInformation->Current_Feature = MASS_ConfigDescriptor[7];
        LDR.N    R0,??DataTable19  ;; pInformation
        LDR      R0,[R0, #+0]
        LDR.N    R1,??MASS_Reset_0+0x4  ;; MASS_ConfigDescriptor
        LDRB     R1,[R1, #+7]
        STRB     R1,[R0, #+9]
//  115 
//  116   SetBTABLE(BTABLE_ADDRESS);
        MOVS     R0,#+0
        BL       SetBTABLE
//  117 
//  118   /* Initialize Endpoint 0 */
//  119   SetEPType(ENDP0, EP_CONTROL);
        MOV      R1,#+512
        MOVS     R0,#+0
        BL       SetEPType
//  120   SetEPTxStatus(ENDP0, EP_TX_NAK);
        MOVS     R1,#+32
        MOVS     R0,#+0
        BL       SetEPTxStatus
//  121   SetEPRxAddr(ENDP0, ENDP0_RXADDR);
        MOVS     R1,#+24
        MOVS     R0,#+0
        BL       SetEPRxAddr
//  122   SetEPRxCount(ENDP0, Device_Property.MaxPacketSize);
        LDR.N    R4,??MASS_Reset_0+0x8  ;; Device_Property
        LDRB     R1,[R4, #+44]
        MOVS     R0,#+0
        BL       SetEPRxCount
//  123   SetEPTxAddr(ENDP0, ENDP0_TXADDR);
        MOVS     R1,#+88
        MOVS     R0,#+0
        BL       SetEPTxAddr
//  124   Clear_Status_Out(ENDP0);
        MOVS     R0,#+0
        BL       Clear_Status_Out
//  125   SetEPRxValid(ENDP0);
        MOVS     R0,#+0
        BL       SetEPRxValid
//  126 
//  127   /* Initialize Endpoint 1 */
//  128   SetEPType(ENDP1, EP_BULK);
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       SetEPType
//  129   SetEPTxAddr(ENDP1, ENDP1_TXADDR);
        MOVS     R1,#+152
        MOVS     R0,#+1
        BL       SetEPTxAddr
//  130   SetEPTxStatus(ENDP1, EP_TX_NAK);
        MOVS     R1,#+32
        MOVS     R0,#+1
        BL       SetEPTxStatus
//  131   SetEPRxStatus(ENDP1, EP_RX_DIS);
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       SetEPRxStatus
//  132 
//  133   /* Initialize Endpoint 2 */
//  134   SetEPType(ENDP2, EP_BULK);
        MOVS     R1,#+0
        MOVS     R0,#+2
        BL       SetEPType
//  135   SetEPRxAddr(ENDP2, ENDP2_RXADDR);
        MOVS     R1,#+216
        MOVS     R0,#+2
        BL       SetEPRxAddr
//  136   SetEPRxCount(ENDP2, Device_Property.MaxPacketSize);
        LDRB     R1,[R4, #+44]
        MOVS     R0,#+2
        BL       SetEPRxCount
//  137   SetEPRxStatus(ENDP2, EP_RX_VALID);
        MOV      R1,#+12288
        MOVS     R0,#+2
        BL       SetEPRxStatus
//  138   SetEPTxStatus(ENDP2, EP_TX_DIS);
        MOVS     R1,#+0
        MOVS     R0,#+2
        BL       SetEPTxStatus
//  139 
//  140 
//  141   SetEPRxCount(ENDP0, Device_Property.MaxPacketSize);
        LDRB     R1,[R4, #+44]
        MOVS     R0,#+0
        BL       SetEPRxCount
//  142   SetEPRxValid(ENDP0);
        MOVS     R0,#+0
        BL       SetEPRxValid
//  143 
//  144   /* Set the device to response on default address */
//  145   SetDeviceAddress(0);
        MOVS     R0,#+0
        BL       SetDeviceAddress
//  146 
//  147   bDeviceState = ATTACHED;
        LDR.N    R0,??DataTable12  ;; bDeviceState
        MOVS     R1,#+1
        STR      R1,[R0, #+0]
//  148 
//  149   CBW.dSignature = BOT_CBW_SIGNATURE;
        LDR.N    R0,??DataTable15  ;; CBW
        LDR.N    R1,??DataTable16  ;; 0x43425355
        STR      R1,[R0, #+0]
//  150   Bot_State = BOT_IDLE;
        LDR.N    R0,??DataTable17  ;; Bot_State
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  151 //  USB_NotConfigured_LED();
//  152 }
        POP      {R4,PC}          ;; return
        DATA
??MASS_Reset_0:
        DC32     Device_Info
        DC32     MASS_ConfigDescriptor
        DC32     Device_Property
        CFI EndBlock cfiBlock1
//  153 
//  154 /*******************************************************************************
//  155 * Function Name  : Mass_Storage_SetConfiguration
//  156 * Description    : Handle the SetConfiguration request.
//  157 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Mass_Storage_SetConfiguration
        THUMB
//  158 void Mass_Storage_SetConfiguration(void)
//  159 {
Mass_Storage_SetConfiguration:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  160   if (pInformation->Current_Configuration != 0)
        LDR.N    R0,??DataTable19  ;; pInformation
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+10]
        CBZ      R0,??Mass_Storage_SetConfiguration_0
//  161   {
//  162     /* Device configured */
//  163     bDeviceState = CONFIGURED;
        LDR.N    R0,??DataTable12  ;; bDeviceState
        MOVS     R1,#+5
        STR      R1,[R0, #+0]
//  164 
//  165     ClearDTOG_TX(ENDP1);
        MOVS     R0,#+1
        BL       ClearDTOG_TX
//  166     ClearDTOG_RX(ENDP2);
        MOVS     R0,#+2
        BL       ClearDTOG_RX
//  167     Bot_State = BOT_IDLE; /* set the Bot state machine to the IDLE state */
        LDR.N    R0,??DataTable17  ;; Bot_State
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  168   }
//  169 }
??Mass_Storage_SetConfiguration_0:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock2
//  170 
//  171 /*******************************************************************************
//  172 * Function Name  : Mass_Storage_ClearFeature
//  173 * Description    : Handle the ClearFeature request.
//  174 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Mass_Storage_ClearFeature
        THUMB
//  175 void Mass_Storage_ClearFeature(void)
//  176 {
Mass_Storage_ClearFeature:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  177   /* when the host send a CBW with invalid signature or invalid length the two
//  178      Endpoints (IN & OUT) shall stall until receiving a Mass Storage Reset     */
//  179   if (CBW.dSignature != BOT_CBW_SIGNATURE)
        LDR.N    R0,??DataTable15  ;; CBW
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable16  ;; 0x43425355
        CMP      R0,R1
        BEQ.N    ??Mass_Storage_ClearFeature_0
//  180     Bot_Abort(BOTH_DIR);
        MOVS     R0,#+2
        BL       Bot_Abort
//  181 }
??Mass_Storage_ClearFeature_0:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock3
//  182 
//  183 /*******************************************************************************
//  184 * Function Name  : Mass_Storage_SetConfiguration.
//  185 * Description    : Udpade the device state to addressed.
//  186 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Mass_Storage_SetDeviceAddress
        THUMB
//  187 void Mass_Storage_SetDeviceAddress (void)
//  188 {
//  189   bDeviceState = ADDRESSED;
Mass_Storage_SetDeviceAddress:
        LDR.N    R0,??DataTable12  ;; bDeviceState
        MOVS     R1,#+4
        STR      R1,[R0, #+0]
//  190 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable12:
        DC32     bDeviceState
//  191 /*******************************************************************************
//  192 * Function Name  : MASS_Status_In
//  193 * Description    : Mass Storage Status IN routine.
//  194 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function MASS_Status_In
        THUMB
//  195 void MASS_Status_In(void)
//  196 {
//  197   return;
MASS_Status_In:
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  198 }
//  199 
//  200 /*******************************************************************************
//  201 * Function Name  : MASS_Status_Out
//  202 * Description    : Mass Storage Status OUT routine.
//  203 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function MASS_Status_Out
        THUMB
//  204 void MASS_Status_Out(void)
//  205 {
//  206   return;
MASS_Status_Out:
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  207 }
//  208 
//  209 /*******************************************************************************
//  210 * Function Name  : MASS_Data_Setup.
//  211 * Description    : Handle the data class specific requests..
//  212 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function MASS_Data_Setup
        THUMB
//  213 RESULT MASS_Data_Setup(u8 RequestNo)
//  214 {
MASS_Data_Setup:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  215   u8    *(*CopyRoutine)(u16);
//  216 
//  217   CopyRoutine = NULL;
//  218   if ((Type_Recipient == (CLASS_REQUEST | INTERFACE_RECIPIENT))
//  219       && (RequestNo == GET_MAX_LUN) && (pInformation->USBwValue == 0)
//  220       && (pInformation->USBwIndex == 0) && (pInformation->USBwLength == 0x01))
        LDR.N    R1,??DataTable19  ;; pInformation
        LDR      R1,[R1, #+0]
        LDRB     R2,[R1, #+0]
        AND      R2,R2,#0x7F
        CMP      R2,#+33
        BNE.N    ??MASS_Data_Setup_0
        CMP      R0,#+254
        BNE.N    ??MASS_Data_Setup_0
        LDRH     R0,[R1, #+2]
        CBNZ     R0,??MASS_Data_Setup_1
        LDRH     R0,[R1, #+4]
        CBNZ     R0,??MASS_Data_Setup_1
        LDRH     R0,[R1, #+6]
        CMP      R0,#+1
        BNE.N    ??MASS_Data_Setup_0
//  221   {
//  222     CopyRoutine = Get_Max_Lun;
//  223   }
//  224   else
//  225   {
//  226     return USB_UNSUPPORT;
//  227   }
//  228 
//  229   if (CopyRoutine == NULL)
        LDR.N    R0,??MASS_Data_Setup_2  ;; Get_Max_Lun
        MOVS     R2,R0
        BNE.N    ??MASS_Data_Setup_3
//  230   {
//  231     return USB_UNSUPPORT;
??MASS_Data_Setup_0:
        MOVS     R0,#+2
        B.N      ??MASS_Data_Setup_4
//  232   }
??MASS_Data_Setup_1:
        B.N      ??MASS_Data_Setup_0
//  233 
//  234   pInformation->Ctrl_Info.CopyData = CopyRoutine;
??MASS_Data_Setup_3:
        STR      R0,[R1, #+24]
//  235   pInformation->Ctrl_Info.Usb_wOffset = 0;
        MOVS     R0,#+0
        STRH     R0,[R1, #+18]
//  236   (*CopyRoutine)(0);
        BL       Get_Max_Lun
//  237 
//  238   return USB_SUCCESS;
        MOVS     R0,#+0
??MASS_Data_Setup_4:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        DATA
??MASS_Data_Setup_2:
        DC32     Get_Max_Lun
        CFI EndBlock cfiBlock7
//  239 
//  240 }
//  241 
//  242 /*******************************************************************************
//  243 * Function Name  : MASS_NoData_Setup.
//  244 * Description    : Handle the no data class specific requests.
//  245 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function MASS_NoData_Setup
        THUMB
//  246 RESULT MASS_NoData_Setup(u8 RequestNo)
//  247 {
MASS_NoData_Setup:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  248   if ((Type_Recipient == (CLASS_REQUEST | INTERFACE_RECIPIENT))
//  249       && (RequestNo == MASS_STORAGE_RESET) && (pInformation->USBwValue == 0)
//  250       && (pInformation->USBwIndex == 0) && (pInformation->USBwLength == 0x00))
        LDR.N    R1,??DataTable19  ;; pInformation
        LDR      R1,[R1, #+0]
        LDRB     R2,[R1, #+0]
        AND      R2,R2,#0x7F
        CMP      R2,#+33
        BNE.N    ??MASS_NoData_Setup_0
        CMP      R0,#+255
        BNE.N    ??MASS_NoData_Setup_0
        LDRH     R0,[R1, #+2]
        CBNZ     R0,??MASS_NoData_Setup_0
        LDRH     R0,[R1, #+4]
        CBNZ     R0,??MASS_NoData_Setup_0
        LDRH     R0,[R1, #+6]
        CBNZ     R0,??MASS_NoData_Setup_0
//  251   {
//  252     /* Initialize Endpoint 1 */
//  253     ClearDTOG_TX(ENDP1);
        MOVS     R0,#+1
        BL       ClearDTOG_TX
//  254 
//  255     /* Initialize Endpoint 2 */
//  256     ClearDTOG_RX(ENDP2);
        MOVS     R0,#+2
        BL       ClearDTOG_RX
//  257 
//  258     /*intialise the CBW signature to enable the clear feature*/
//  259     CBW.dSignature = BOT_CBW_SIGNATURE;
        LDR.N    R0,??DataTable15  ;; CBW
        LDR.N    R1,??DataTable16  ;; 0x43425355
        STR      R1,[R0, #+0]
//  260     Bot_State = BOT_IDLE;
        LDR.N    R0,??DataTable17  ;; Bot_State
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  261 
//  262     return USB_SUCCESS;
        MOVS     R0,#+0
        B.N      ??MASS_NoData_Setup_1
//  263   }
//  264   return USB_UNSUPPORT;
??MASS_NoData_Setup_0:
        MOVS     R0,#+2
??MASS_NoData_Setup_1:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock8
//  265 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable15:
        DC32     CBW

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable16:
        DC32     0x43425355

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable17:
        DC32     Bot_State
//  266 
//  267 /*******************************************************************************
//  268 * Function Name  : MASS_Get_Interface_Setting
//  269 * Description    : Test the interface and the alternate setting according to the
//  270 *                  supported one.
//  271 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function MASS_Get_Interface_Setting
        THUMB
//  272 RESULT MASS_Get_Interface_Setting(u8 Interface, u8 AlternateSetting)
//  273 {
//  274   if (AlternateSetting > 0)
MASS_Get_Interface_Setting:
        CBNZ     R1,??MASS_Get_Interface_Setting_0
//  275   {
//  276     return USB_UNSUPPORT;/* in this application we don't have AlternateSetting*/
//  277   }
//  278   else if (Interface > 0)
??MASS_Get_Interface_Setting_1:
        CBZ      R0,??MASS_Get_Interface_Setting_2
//  279   {
//  280     return USB_UNSUPPORT;/*in this application we have only 1 interfaces*/
??MASS_Get_Interface_Setting_0:
        MOVS     R0,#+2
//  281   }
//  282   return USB_SUCCESS;
??MASS_Get_Interface_Setting_2:
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//  283 }
//  284 
//  285 /*******************************************************************************
//  286 * Function Name  : MASS_GetDeviceDescriptor
//  287 * Description    : Get the device descriptor.
//  288 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function MASS_GetDeviceDescriptor
        THUMB
//  289 u8 *MASS_GetDeviceDescriptor(u16 Length)
//  290 {
//  291   return Standard_GetDescriptorData(Length, &Device_Descriptor );
MASS_GetDeviceDescriptor:
        LDR.N    R1,??MASS_GetDeviceDescriptor_0  ;; Device_Descriptor
        B.W      Standard_GetDescriptorData
        Nop      
        DATA
??MASS_GetDeviceDescriptor_0:
        DC32     Device_Descriptor
        CFI EndBlock cfiBlock10
//  292 }
//  293 
//  294 /*******************************************************************************
//  295 * Function Name  : MASS_GetConfigDescriptor
//  296 * Description    : Get the configuration descriptor.
//  297 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function MASS_GetConfigDescriptor
        THUMB
//  298 u8 *MASS_GetConfigDescriptor(u16 Length)
//  299 {
//  300   return Standard_GetDescriptorData(Length, &Config_Descriptor );
MASS_GetConfigDescriptor:
        LDR.N    R1,??MASS_GetConfigDescriptor_0  ;; Config_Descriptor
        B.W      Standard_GetDescriptorData
        Nop      
        DATA
??MASS_GetConfigDescriptor_0:
        DC32     Config_Descriptor
        CFI EndBlock cfiBlock11
//  301 }
//  302 
//  303 /*******************************************************************************
//  304 * Function Name  : MASS_GetStringDescriptor
//  305 * Description    : Get the string descriptors according to the needed index.
//  306 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function MASS_GetStringDescriptor
        THUMB
//  307 u8 *MASS_GetStringDescriptor(u16 Length)
//  308 {
MASS_GetStringDescriptor:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  309   u8 wValue0 = pInformation->USBwValue0;
        LDR.N    R1,??DataTable19  ;; pInformation
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+3]
//  310 
//  311   if (wValue0 > 5)
        CMP      R1,#+6
        BCC.N    ??MASS_GetStringDescriptor_0
//  312   {
//  313     return NULL;
        MOVS     R0,#+0
        B.N      ??MASS_GetStringDescriptor_1
//  314   }
//  315   else
//  316   {
//  317     return Standard_GetDescriptorData(Length, &String_Descriptor[wValue0]);
??MASS_GetStringDescriptor_0:
        LDR.N    R2,??MASS_GetStringDescriptor_2  ;; String_Descriptor
        ADD      R1,R2,R1, LSL #+3
        BL       Standard_GetDescriptorData
??MASS_GetStringDescriptor_1:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        DATA
??MASS_GetStringDescriptor_2:
        DC32     String_Descriptor
        CFI EndBlock cfiBlock12
//  318   }
//  319 }
//  320 
//  321 /*******************************************************************************
//  322 * Function Name  : Get_Max_Lun
//  323 * Description    : Handle the Get Max Lun request.
//  324 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function Get_Max_Lun
        THUMB
//  325 u8 *Get_Max_Lun(u16 Length)
//  326 {
//  327   if (Length == 0)
Get_Max_Lun:
        CBNZ     R0,??Get_Max_Lun_0
//  328   {
//  329     pInformation->Ctrl_Info.Usb_wLength = LUN_DATA_LENGTH;
        LDR.N    R0,??DataTable19  ;; pInformation
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        STRH     R1,[R0, #+16]
//  330     return 0;
        MOVS     R0,#+0
        BX       LR
//  331   }
//  332   else
//  333   {
//  334     return((u8*)(&Max_Lun));
??Get_Max_Lun_0:
        LDR.N    R0,??Get_Max_Lun_1  ;; Max_Lun
??Get_Max_Lun_2:
        BX       LR               ;; return
        Nop      
        DATA
??Get_Max_Lun_1:
        DC32     Max_Lun
        CFI EndBlock cfiBlock13
//  335   }
//  336 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable19:
        DC32     pInformation

        END
//  337 
//  338 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
//   4 bytes in section .bss
// 144 bytes in section .data
// 592 bytes in section .text
// 
// 592 bytes of CODE memory
// 148 bytes of DATA memory
//
//Errors: none
//Warnings: none
