///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  14:17:11 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\SYS_V1.34\source\Ident.c                      /
//    Command line =  E:\DS0203\SYS_V1.34\source\Ident.c -lA                  /
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
//    List file    =  E:\DS0203\SYS_V1.34\IAR_V5_Prpject\List\Ident.s         /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Ident

        EXTERN Display_Str
        EXTERN FLASH_ClearFlag
        EXTERN FLASH_ErasePage
        EXTERN FLASH_Lock
        EXTERN FLASH_ProgramHalfWord
        EXTERN FLASH_Unlock
        EXTERN FLASH_WaitForLastOperation
        EXTERN Key_Buffer
        EXTERN Twink
        EXTERN Word2Hex

        PUBLIC Add_Cnt
        PUBLIC Add_Lic
        PUBLIC Add_Proj
        PUBLIC Add_Str
        PUBLIC Chk_DemoCnt
        PUBLIC FLASH_Erase
        PUBLIC FLASH_Prog
        PUBLIC Get_Cnt
        PUBLIC Get_Lic
        PUBLIC Input_Lic
        PUBLIC Seek_Blank
        PUBLIC Seek_Proj
        
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
        
// E:\DS0203\SYS_V1.34\source\Ident.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : Authenticate.c  
//    3  Version   : DS203_SYS Ver 1.3x                          Author : kewei & bure
//    4 *******************************************************************************/
//    5 #include "SPI_flash.h"
//    6 #include "Function.h"
//    7 #include <string.h>
//    8 #include "Ident.h"
//    9 #include "LCD.h"
//   10 #include "ASM.h"
//   11 
//   12 /************************** Licence Block defination ***************************
//   13 offset 0x00~0x03: ProjectID 4Bytes (example:  0x12345678)  
//   14 offset 0x04~0x07: LicenceNo 4Bytes (example:  0x0A1B2C3D)
//   15 offset 0x08~0x0B: DemoCnt   4Bytes (example:  0~0xFFFFFFFF Sec.)
//   16 offset 0x0C~0x1F: Developer Str 20Bytes (example: "e-Design 2011.3")
//   17 *******************************************************************************/
//   18 
//   19 /*******************************************************************************
//   20  Chk_DemoCnt: Check demo counter limit                       RET: 1 = Time out
//   21 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Chk_DemoCnt
        THUMB
//   22 u8 Chk_DemoCnt(u16 Offset, u32 Sec_Cnt)
//   23 {
//   24   if((*(u32*)(REC_BASE + Offset + 8))>= Sec_Cnt) return 1;
Chk_DemoCnt:
        LDR.N    R2,??DataTable7  ;; 0x8003808
        LDR      R0,[R2, R0]
        CMP      R0,R1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//   25   else                                           return 0;
//   26 }
//   27 /*******************************************************************************
//   28  Get_Cnt: Get demo counter value from recoed                    RET: Cnt value
//   29 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function Get_Cnt
        THUMB
//   30 u8 Get_Cnt(u16 Offset)
//   31 {
Get_Cnt:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
        MOVS     R1,R0
//   32   u8 i, Result = 0;
        MOVS     R0,#+0
//   33   
//   34   for(i=0; i<32; i++){
        MOVS     R2,#+0
        LDR.N    R3,??DataTable8  ;; 0x800380c
        ADDS     R3,R3,R1
        LDR.W    R12,??DataTable7  ;; 0x8003808
        ADD      R1,R12,R1
//   35     if(((*(u32*)(REC_BASE + Offset +  8))&(1<<i))!=0)  Result++;
??Get_Cnt_0:
        MOV      R12,#+1
        LSL      R12,R12,R2
        LDR      LR,[R1, #+0]
        TST      R12,LR
        BEQ.N    ??Get_Cnt_1
        ADDS     R0,R0,#+1
        UXTB     R0,R0
//   36     if(((*(u32*)(REC_BASE + Offset + 12))&(1<<i))!=0)  Result++;
??Get_Cnt_1:
        LDR      LR,[R3, #+0]
        TST      R12,LR
        BEQ.N    ??Get_Cnt_2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
//   37   }  
??Get_Cnt_2:
        ADDS     R2,R2,#+1
        UXTB     R12,R2
        CMP      R12,#+32
        BCC.N    ??Get_Cnt_0
//   38   return Result; 
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock1
//   39 }
//   40 /*******************************************************************************
//   41  Get_Lic: Get licence number from recoed                   RET: licence number
//   42 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Get_Lic
        THUMB
//   43 u32 Get_Lic(u16 Offset)
//   44 {
//   45       return *(u32*)(REC_BASE + Offset + 4); 
Get_Lic:
        LDR.N    R1,??DataTable9  ;; 0x8003804
        LDR      R0,[R1, R0]
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//   46 }
//   47 /*******************************************************************************
//   48  Seek_Proj: Seek Project ID from recoeds         RET: offset, 2048 = Not found 
//   49 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Seek_Proj
        THUMB
//   50 u16 Seek_Proj(u32 Proj_ID)
//   51 {
Seek_Proj:
        MOVS     R1,R0
//   52   u16 i;
//   53   for(i=32; i<2048; i+=32){
        MOVS     R0,#+32
        LDR.N    R2,??DataTable6  ;; 0x8003800
        MOV      R12,#+2048
//   54     if(Proj_ID ==(*(u32*)(REC_BASE+i)))  return i;
??Seek_Proj_0:
        LDR      R3,[R2, R0]
        CMP      R1,R3
        BEQ.N    ??Seek_Proj_1
//   55   }
        ADDS     R0,R0,#+32
        UXTH     R0,R0
        CMP      R0,R12
        BCC.N    ??Seek_Proj_0
//   56   return 2048;
        MOV      R0,R12
??Seek_Proj_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//   57 }
//   58 /*******************************************************************************
//   59  Seek_Blank: Seek Blank from recoeds             RET: offset, 2048 = Not found 
//   60 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Seek_Blank
        THUMB
//   61 u16 Seek_Blank(void)
//   62 {
Seek_Blank:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//   63   u16 i, j;
//   64   u32 Tmp;
//   65   
//   66   for(i=32; i<2048; i+=32){
        MOVS     R0,#+32
        LDR.N    R1,??DataTable6  ;; 0x8003800
        MOV      R2,#-1
//   67     Tmp = 0xFFFFFFFF;
??Seek_Blank_0:
        MOVS     R3,R2
//   68     for(j=0; j<32; j+=4)  Tmp &= *(u32*)(REC_BASE+i+j);
        ADD      R12,R1,R0
        MOV      LR,#+8
??Seek_Blank_1:
        LDR      R4,[R12], #+4
        ANDS     R3,R4,R3
        SUBS     LR,LR,#+1
        BNE.N    ??Seek_Blank_1
//   69     if(Tmp == 0xFFFFFFFF)  return i;
        CMP      R3,R2
        BEQ.N    ??Seek_Blank_2
//   70   }
        ADDS     R0,R0,#+32
        UXTH     R0,R0
        MOV      R12,#+2048
        CMP      R0,R12
        BCC.N    ??Seek_Blank_0
//   71   return 2048;
        MOV      R0,R12
??Seek_Blank_2:
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock4
//   72 }
//   73 /*******************************************************************************
//   74  Add_Proj: Add a Project ID into recoed                  RET: 1 = Ok, 0 = Fail
//   75 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function Add_Proj
        THUMB
//   76 u8 Add_Proj(u32 ProjectID, u16 Offset) 
//   77 {
Add_Proj:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOVS     R4,R0
        MOVS     R5,R1
//   78   u16 Result;
//   79   
//   80   FLASH_Unlock();
        BL       FLASH_Unlock
//   81   Result  = FLASH_Prog(REC_BASE + Offset + 0, ProjectID & 0xFFFF);
        UXTH     R1,R4
        LDR.N    R0,??DataTable6  ;; 0x8003800
        ADDS     R0,R0,R5
        BL       FLASH_Prog
        MOVS     R6,R0
//   82   Result &= FLASH_Prog(REC_BASE + Offset + 2, ProjectID >> 16);
        LSRS     R1,R4,#+16
        LDR.N    R0,??Add_Proj_0  ;; 0x8003802
        ADDS     R0,R0,R5
        BL       FLASH_Prog
        AND      R4,R0,R6
//   83   FLASH_Lock();
        BL       FLASH_Lock
//   84   return Result;
        MOVS     R0,R4
        POP      {R4-R6,PC}       ;; return
        DATA
??Add_Proj_0:
        DC32     0x8003802
        CFI EndBlock cfiBlock5
//   85 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable6:
        DC32     0x8003800
//   86 /*******************************************************************************
//   87  Add_Str: Add a Project string into recoed               RET: 1 = Ok, 0 = Fail
//   88 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function Add_Str
        THUMB
//   89 u8 Add_Str(u32 ProjStrAddr, u16 Offset) 
//   90 {
Add_Str:
        PUSH     {R4-R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI R7 Frame(CFA, -8)
        CFI R6 Frame(CFA, -12)
        CFI R5 Frame(CFA, -16)
        CFI R4 Frame(CFA, -20)
        CFI CFA R13+20
        SUB      SP,SP,#+4
        CFI CFA R13+24
        MOVS     R6,R0
        MOVS     R4,R1
//   91   u8 i, Result = FLASH_COMPLETE;
        MOVS     R5,#+4
//   92   u16 Data;
//   93   FLASH_Unlock();
        BL       FLASH_Unlock
//   94   for(i=0; i<16; i+=2){
        LDR.N    R0,??Add_Str_0   ;; 0x8003810
        ADDS     R4,R0,R4
        MOVS     R7,#+8
//   95     Data  = *(u8*)ProjStrAddr;
??Add_Str_1:
        LDRB     R0,[R6, #+0]
//   96     (u8*)ProjStrAddr++;
        ADDS     R2,R6,#+1
//   97     Data |= (*(u8*)ProjStrAddr)<<8;
        LDRB     R1,[R2, #+0]
        ORR      R1,R0,R1, LSL #+8
//   98     (u8*)ProjStrAddr++;
        ADDS     R6,R2,#+1
//   99     Result &= FLASH_Prog(REC_BASE + Offset + i + 16, Data);
        MOVS     R0,R4
        BL       FLASH_Prog
        ANDS     R5,R0,R5
//  100   }
        ADDS     R4,R4,#+2
        SUBS     R7,R7,#+1
        BNE.N    ??Add_Str_1
//  101   FLASH_Lock();
        BL       FLASH_Lock
//  102   return Result;
        MOVS     R0,R5
        ADD      SP,SP,#+4
        CFI CFA R13+20
        POP      {R4-R7,PC}       ;; return
        DATA
??Add_Str_0:
        DC32     0x8003810
        CFI EndBlock cfiBlock6
//  103 }
//  104 /*******************************************************************************
//  105  Add_Cnt: Add demo counter value into recoed             RET: 1 = Ok, 0 = Fail
//  106 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function Add_Cnt
        THUMB
//  107 u8 Add_Cnt(u8 DemoCnt, u16 Offset)
//  108 {
Add_Cnt:
        PUSH     {R4-R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI R7 Frame(CFA, -8)
        CFI R6 Frame(CFA, -12)
        CFI R5 Frame(CFA, -16)
        CFI R4 Frame(CFA, -20)
        CFI CFA R13+20
        SUB      SP,SP,#+4
        CFI CFA R13+24
        MOVS     R7,R0
        MOVS     R6,R1
//  109   u32 TmpL, TmpH;
//  110   u8  i, Result;
//  111   
//  112   FLASH_Unlock();
        BL       FLASH_Unlock
//  113   TmpH = 0;
        MOVS     R5,#+0
//  114   TmpL = 0;
        MOVS     R4,#+0
//  115   if(DemoCnt != 0){
        CBZ      R7,??Add_Cnt_0
//  116     if(DemoCnt <= 32)  for(i=0; i<DemoCnt; i++)  TmpL |= 1<<i; 
        CMP      R7,#+33
        BCS.N    ??Add_Cnt_1
        MOVS     R0,#+0
??Add_Cnt_2:
        MOVS     R1,#+1
        LSLS     R1,R1,R0
        ORRS     R4,R1,R4
        ADDS     R0,R0,#+1
        UXTB     R1,R0
        CMP      R1,R7
        BCS.N    ??Add_Cnt_0
        B.N      ??Add_Cnt_2
//  117     else {
//  118       TmpL = 0xFFFFFFFF;
??Add_Cnt_1:
        MOV      R4,#-1
//  119       for(i=0; i<(DemoCnt-32); i++)  TmpH |= 1<<i;
        MOVS     R0,#+0
        SUB      R1,R7,#+32
??Add_Cnt_3:
        MOVS     R2,#+1
        LSLS     R2,R2,R0
        ORRS     R5,R2,R5
        ADDS     R0,R0,#+1
        CMP      R0,R1
        BLT.N    ??Add_Cnt_3
//  120     }
//  121   }
//  122   Result  = FLASH_Prog(REC_BASE + Offset +  8, TmpL & 0xFFFF);
??Add_Cnt_0:
        UXTH     R1,R4
        LDR.N    R0,??DataTable7  ;; 0x8003808
        ADDS     R0,R0,R6
        BL       FLASH_Prog
        MOVS     R7,R0
//  123   Result &= FLASH_Prog(REC_BASE + Offset + 10, TmpL >> 16);
        LSRS     R1,R4,#+16
        LDR.N    R0,??Add_Cnt_4   ;; 0x800380a
        ADDS     R0,R0,R6
        BL       FLASH_Prog
        AND      R4,R0,R7
//  124   Result &= FLASH_Prog(REC_BASE + Offset + 12, TmpH & 0xFFFF);
        UXTH     R1,R5
        LDR.N    R0,??DataTable8  ;; 0x800380c
        ADDS     R0,R0,R6
        BL       FLASH_Prog
        ANDS     R4,R0,R4
//  125   Result &= FLASH_Prog(REC_BASE + Offset + 14, TmpH >> 16);
        LSRS     R1,R5,#+16
        LDR.N    R0,??Add_Cnt_4+0x4  ;; 0x800380e
        ADDS     R0,R0,R6
        BL       FLASH_Prog
        ANDS     R4,R0,R4
//  126   FLASH_Lock();
        BL       FLASH_Lock
//  127   return Result;
        MOVS     R0,R4
        ADD      SP,SP,#+4
        CFI CFA R13+20
        POP      {R4-R7,PC}       ;; return
        Nop      
        DATA
??Add_Cnt_4:
        DC32     0x800380a
        DC32     0x800380e
        CFI EndBlock cfiBlock7
//  128 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7:
        DC32     0x8003808

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     0x800380c
//  129 /*******************************************************************************
//  130  Add_Lic: Add Licence number into recoed                 RET: 1 = Ok, 0 = Fail
//  131 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function Add_Lic
        THUMB
//  132 u8 Add_Lic(u32 LicenceNo, u32 Offsaet) 
//  133 {
Add_Lic:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOVS     R4,R0
        MOVS     R5,R1
//  134   u8 Result;
//  135   
//  136   FLASH_Unlock();
        BL       FLASH_Unlock
//  137   Result  = FLASH_Prog(REC_BASE+Offsaet+4, LicenceNo & 0xFFFF);
        UXTH     R1,R4
        LDR.N    R0,??DataTable9  ;; 0x8003804
        ADDS     R0,R0,R5
        BL       FLASH_Prog
        MOVS     R6,R0
//  138   Result &= FLASH_Prog(REC_BASE+Offsaet+6, LicenceNo >> 16);
        LSRS     R1,R4,#+16
        LDR.N    R0,??Add_Lic_0   ;; 0x8003806
        ADDS     R0,R0,R5
        BL       FLASH_Prog
        AND      R4,R0,R6
//  139   FLASH_Lock();
        BL       FLASH_Lock
//  140   return Result;
        MOVS     R0,R4
        POP      {R4-R6,PC}       ;; return
        DATA
??Add_Lic_0:
        DC32     0x8003806
        CFI EndBlock cfiBlock8
//  141 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable9:
        DC32     0x8003804
//  142 /*******************************************************************************
//  143  Input_Lic: Input 32 Bytes Licence                         RET: licence number
//  144 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function Input_Lic
        THUMB
//  145 u32 Input_Lic(u16 x0, u8 y0) // Return: 32Bits Lic 
//  146 {
Input_Lic:
        PUSH     {R0,R4-R11,LR}
        CFI R14 Frame(CFA, -4)
        CFI R11 Frame(CFA, -8)
        CFI R10 Frame(CFA, -12)
        CFI R9 Frame(CFA, -16)
        CFI R8 Frame(CFA, -20)
        CFI R7 Frame(CFA, -24)
        CFI R6 Frame(CFA, -28)
        CFI R5 Frame(CFA, -32)
        CFI R4 Frame(CFA, -36)
        CFI CFA R13+40
        SUB      SP,SP,#+16
        CFI CFA R13+56
        MOV      R10,R1
//  147   u8  i=0, j, n[2]={"0"};
        MOVS     R4,#+0
        ADD      R0,SP,#+0
        LDR.N    R1,??Input_Lic_0  ;; `?<Constant "0">`
        LDRB     R2,[R1, #0]
        STRB     R2,[R0, #+0]
        LDRB     R2,[R1, #+1]
        STRB     R2,[R0, #+1]
//  148   u32 Lic=0;
        MOVS     R5,#+0
//  149   u8  NumStr[9], Type;
//  150   
//  151   Word2Hex(NumStr, Lic);
        MOV      R1,R4
        ADD      R0,SP,#+4
        BL       Word2Hex
//  152   Display_Str(x0, y0, WHT, PRN, NumStr);
        MOVW     R9,#+65535
        ADD      R0,SP,#+4
        PUSH     {R0,LR}
        CFI CFA R13+64
        MOV      R3,R4
        MOV      R2,R9
        MOV      R1,R10
        LDRH     R0,[SP, #+24]
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+56
//  153   
//  154   while (i<8){
//  155     Word2Hex(NumStr, Lic);
??Input_Lic_1:
        MOVS     R1,R5
        ADD      R0,SP,#+4
        BL       Word2Hex
//  156     if( Type != Twink ){  // Blink current number each 0.5 Sec.
        LDR.N    R1,??Input_Lic_0+0x4  ;; Twink
        LDRB     R1,[R1, #+0]
        UXTB     R0,R11
        CMP      R0,R1
        BEQ.N    ??Input_Lic_2
//  157       Type = Twink;
        LDR.N    R0,??Input_Lic_0+0x4  ;; Twink
        LDRB     R11,[R0, #+0]
//  158       for(j=0; j<8; ++j){ // 刷新显示8位数字，当前位闪烁
        MOVS     R6,#+0
        ADD      R8,SP,#+4
        LDRH     R7,[SP, #+16]
//  159         n[0] = NumStr[j];
??Input_Lic_3:
        LDRB     R0,[R8, #+0]
        STRB     R0,[SP, #+0]
//  160         if(i==j) Display_Str(j*8+ x0, y0, WHT, Type, n);
        UXTB     R1,R6
        CMP      R4,R1
        ADD      R0,SP,#+0
        PUSH     {R0,LR}
        CFI CFA R13+64
        BNE.N    ??Input_Lic_4
        MOV      R3,R11
        B.N      ??Input_Lic_5
//  161         else     Display_Str(j*8+ x0, y0, WHT, PRN,  n);
??Input_Lic_4:
        MOVS     R3,#+0
??Input_Lic_5:
        MOV      R2,R9
        MOV      R1,R10
        UXTH     R0,R7
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+56
//  162       }
        ADDS     R6,R6,#+1
        ADDS     R7,R7,#+8
        ADD      R8,R8,#+1
        UXTB     R0,R6
        CMP      R0,#+8
        BCC.N    ??Input_Lic_3
//  163     }
//  164     if(Key_Buffer != 0){
??Input_Lic_2:
        LDR.N    R0,??Input_Lic_0+0x8  ;; Key_Buffer
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Input_Lic_6
//  165       switch (Key_Buffer){  
        LDR.N    R0,??Input_Lic_0+0x8  ;; Key_Buffer
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BEQ.N    ??Input_Lic_7
        CMP      R0,#+5
        BEQ.N    ??Input_Lic_8
        CMP      R0,#+6
        BEQ.N    ??Input_Lic_9
        CMP      R0,#+8
        BEQ.N    ??Input_Lic_10
        CMP      R0,#+9
        BEQ.N    ??Input_Lic_11
        B.N      ??Input_Lic_12
//  166       case K_INDEX_DEC:
//  167         if(((Lic >>((7-i)*4))& 0x0F )> 0) Lic -= 0x01<<((7-i)*4);
??Input_Lic_8:
        MOVS     R0,R4
        RSB      R0,R0,#+7
        LSLS     R0,R0,#+24
        LSRS     R0,R0,#+22
        LSR      R1,R5,R0
        TST      R1,#0xF
        BEQ.N    ??Input_Lic_13
        MOVS     R1,#+1
        LSL      R0,R1,R0
??Input_Lic_14:
        SUBS     R5,R5,R0
        B.N      ??Input_Lic_12
//  168         else                              Lic += 0x0F<<((7-i)*4);
??Input_Lic_13:
        MOVS     R1,#+15
        LSL      R0,R1,R0
??Input_Lic_15:
        ADDS     R5,R0,R5
        B.N      ??Input_Lic_12
//  169         break;
//  170       case K_INDEX_INC:
//  171         if(((Lic >>((7-i)*4))& 0x0F )<15) Lic += 0x01<<((7-i)*4);
??Input_Lic_9:
        MOVS     R0,R4
        RSB      R0,R0,#+7
        LSLS     R0,R0,#+24
        LSRS     R0,R0,#+22
        LSR      R1,R5,R0
        AND      R1,R1,#0xF
        CMP      R1,#+15
        BCS.N    ??Input_Lic_16
        MOVS     R1,#+1
        LSL      R0,R1,R0
        B.N      ??Input_Lic_15
//  172         else                              Lic -= 0x0F<<((7-i)*4);
??Input_Lic_16:
        MOVS     R1,#+15
        LSL      R0,R1,R0
        B.N      ??Input_Lic_14
//  173         break;
//  174       case K_ITEM_INC:
//  175         if(i<7) i++;
??Input_Lic_10:
        CMP      R4,#+7
        BCS.N    ??Input_Lic_17
        ADDS     R4,R4,#+1
??Input_Lic_18:
        UXTB     R4,R4
        B.N      ??Input_Lic_12
//  176         else    i=0;
??Input_Lic_17:
        MOVS     R4,#+0
        B.N      ??Input_Lic_12
//  177         break;
//  178       case K_ITEM_DEC:
//  179         if(i>0) i--;
??Input_Lic_11:
        MOVS     R0,R4
        BEQ.N    ??Input_Lic_19
        SUBS     R4,R4,#+1
        B.N      ??Input_Lic_18
//  180         else    i=7;
??Input_Lic_19:
        MOVS     R4,#+7
        B.N      ??Input_Lic_12
//  181         break;
//  182       case K_SELE:
//  183         i = 8;        // Exit 
??Input_Lic_7:
        MOVS     R4,#+8
//  184         break;
//  185       }
//  186       Key_Buffer = NO_KEY;
??Input_Lic_12:
        LDR.N    R0,??Input_Lic_0+0x8  ;; Key_Buffer
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  187     }
//  188   }
??Input_Lic_6:
        CMP      R4,#+8
        BCC.N    ??Input_Lic_1
//  189   return Lic;
        MOVS     R0,R5
        ADD      SP,SP,#+20
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        DATA
??Input_Lic_0:
        DC32     `?<Constant "0">`
        DC32     Twink
        DC32     Key_Buffer
        CFI EndBlock cfiBlock9
//  190 }
//  191 /*******************************************************************************
//  192  FLASH_Prog:
//  193 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function FLASH_Prog
        THUMB
//  194 u8 FLASH_Prog(u32 Address, u16 Data)    
//  195 {
FLASH_Prog:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
        MOVS     R5,R0
        MOVS     R4,R1
//  196   if(FLASH_WaitForLastOperation(WAIT_TIMES)!=FLASH_TIMEOUT) 
        LDR.N    R0,??DataTable11  ;; 0x186a0
        BL       FLASH_WaitForLastOperation
        CMP      R0,#+5
        BEQ.N    ??FLASH_Prog_0
//  197     FLASH_ClearFlag(FLASH_FLAG_EOP|FLASH_FLAG_PGERR|FLASH_FLAG_WRPRTERR); 
        MOVS     R0,#+52
        BL       FLASH_ClearFlag
//  198   if(FLASH_ProgramHalfWord(Address, Data)== FLASH_COMPLETE) return 1;
??FLASH_Prog_0:
        MOVS     R1,R4
        MOVS     R0,R5
        BL       FLASH_ProgramHalfWord
        CMP      R0,#+4
        BNE.N    ??FLASH_Prog_1
        MOVS     R0,#+1
        B.N      ??FLASH_Prog_2
//  199   else                                                      return 0;
??FLASH_Prog_1:
        MOVS     R0,#+0
??FLASH_Prog_2:
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        CFI EndBlock cfiBlock10
//  200 }
//  201 /*******************************************************************************
//  202  FLASH_Erase:
//  203 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function FLASH_Erase
        THUMB
//  204 u8 FLASH_Erase(u32 Address)    
//  205 {
FLASH_Erase:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        MOVS     R4,R0
//  206   if(Address%PAGE_SIZE == 0){                               // FLASH Page start
        LSLS     R0,R4,#+21
        BNE.N    ??FLASH_Erase_0
//  207     if(FLASH_WaitForLastOperation(WAIT_TIMES)!=FLASH_TIMEOUT) 
        LDR.N    R0,??DataTable11  ;; 0x186a0
        BL       FLASH_WaitForLastOperation
        CMP      R0,#+5
        BEQ.N    ??FLASH_Erase_1
//  208       FLASH_ClearFlag(FLASH_FLAG_EOP|FLASH_FLAG_PGERR|FLASH_FLAG_WRPRTERR); 
        MOVS     R0,#+52
        BL       FLASH_ClearFlag
//  209     if(FLASH_ErasePage(Address)== FLASH_COMPLETE) return 1; // FLASH Page erase 
??FLASH_Erase_1:
        MOVS     R0,R4
        BL       FLASH_ErasePage
        CMP      R0,#+4
        BEQ.N    ??FLASH_Erase_0
//  210     else                                          return 0;
??FLASH_Erase_2:
        MOVS     R0,#+0
        POP      {R4,PC}
//  211   }
//  212   return 1;
??FLASH_Erase_0:
        MOVS     R0,#+1
??FLASH_Erase_3:
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock11
//  213 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable11:
        DC32     0x186a0

        SECTION `.rodata`:CONST:NOROOT(1)
`?<Constant "0">`:
        DATA
        DC8 "0"

        END
//  214 /********************************* END OF FILE ********************************/
// 
//   2 bytes in section .rodata
// 880 bytes in section .text
// 
// 880 bytes of CODE  memory
//   2 bytes of CONST memory
//
//Errors: none
//Warnings: none
