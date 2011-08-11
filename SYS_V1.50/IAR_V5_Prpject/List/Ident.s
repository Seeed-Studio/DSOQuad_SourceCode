///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:03:36 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\SYS_V1.50\source\Ident.c               /
//    Command line =  E:\Mini-DS\DS203\SYS_V1.50\source\Ident.c -lA           /
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
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\Ident.s  /
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
        
// E:\Mini-DS\DS203\SYS_V1.50\source\Ident.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : Authenticate.c  
//    3  Version   : DS203_SYS Ver 1.5x                          Author : kewei & bure
//    4 *******************************************************************************/
//    5 #include "Function.h"
//    6 #include <string.h>
//    7 #include "Ident.h"
//    8 #include "LCD.h"
//    9 #include "ASM.h"
//   10 
//   11 /************************** Licence Block defination ***************************
//   12 offset 0x00~0x03: ProjectID 4Bytes (example:  0x12345678)  
//   13 offset 0x04~0x07: LicenceNo 4Bytes (example:  0x0A1B2C3D)
//   14 offset 0x08~0x0B: DemoCnt   4Bytes (example:  0~0xFFFFFFFF Sec.)
//   15 offset 0x0C~0x1F: Developer Str 20Bytes (example: "e-Design 2011.3")
//   16 *******************************************************************************/
//   17 
//   18 /*******************************************************************************
//   19  Chk_DemoCnt: Check demo counter limit                       RET: 1 = Time out
//   20 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Chk_DemoCnt
        THUMB
//   21 u8 Chk_DemoCnt(u16 Offset, u32 Sec_Cnt)
//   22 {
//   23   if((*(u32*)(REC_BASE + Offset + 8))>= Sec_Cnt) return 1;
Chk_DemoCnt:
        LDR.N    R2,??DataTable7  ;; 0x8003808
        LDR      R0,[R2, R0]
        CMP      R0,R1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//   24   else                                           return 0;
//   25 }
//   26 /*******************************************************************************
//   27  Get_Cnt: Get demo counter value from recoed                    RET: Cnt value
//   28 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function Get_Cnt
        THUMB
//   29 u8 Get_Cnt(u16 Offset)
//   30 {
Get_Cnt:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
        MOVS     R1,R0
//   31   u8 i, Result = 0;
        MOVS     R0,#+0
//   32   
//   33   for(i=0; i<32; i++){
        MOVS     R2,#+0
        LDR.N    R3,??DataTable8  ;; 0x800380c
        ADDS     R3,R3,R1
        LDR.W    R12,??DataTable7  ;; 0x8003808
        ADD      R1,R12,R1
//   34     if(((*(u32*)(REC_BASE + Offset +  8))&(1<<i))!=0)  Result++;
??Get_Cnt_0:
        MOV      R12,#+1
        LSL      R12,R12,R2
        LDR      LR,[R1, #+0]
        TST      R12,LR
        BEQ.N    ??Get_Cnt_1
        ADDS     R0,R0,#+1
        UXTB     R0,R0
//   35     if(((*(u32*)(REC_BASE + Offset + 12))&(1<<i))!=0)  Result++;
??Get_Cnt_1:
        LDR      LR,[R3, #+0]
        TST      R12,LR
        BEQ.N    ??Get_Cnt_2
        ADDS     R0,R0,#+1
        UXTB     R0,R0
//   36   }  
??Get_Cnt_2:
        ADDS     R2,R2,#+1
        UXTB     R12,R2
        CMP      R12,#+32
        BCC.N    ??Get_Cnt_0
//   37   return Result; 
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock1
//   38 }
//   39 /*******************************************************************************
//   40  Get_Lic: Get licence number from recoed                   RET: licence number
//   41 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Get_Lic
        THUMB
//   42 u32 Get_Lic(u16 Offset)
//   43 {
//   44       return *(u32*)(REC_BASE + Offset + 4); 
Get_Lic:
        LDR.N    R1,??DataTable9  ;; 0x8003804
        LDR      R0,[R1, R0]
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//   45 }
//   46 /*******************************************************************************
//   47  Seek_Proj: Seek Project ID from recoeds         RET: offset, 2048 = Not found 
//   48 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Seek_Proj
        THUMB
//   49 u16 Seek_Proj(u32 Proj_ID)
//   50 {
Seek_Proj:
        MOVS     R1,R0
//   51   u16 i;
//   52   for(i=32; i<2048; i+=32){
        MOVS     R0,#+32
        LDR.N    R2,??DataTable6  ;; 0x8003800
        MOV      R12,#+2048
//   53     if(Proj_ID ==(*(u32*)(REC_BASE+i)))  return i;
??Seek_Proj_0:
        LDR      R3,[R2, R0]
        CMP      R1,R3
        BEQ.N    ??Seek_Proj_1
//   54   }
        ADDS     R0,R0,#+32
        UXTH     R0,R0
        CMP      R0,R12
        BCC.N    ??Seek_Proj_0
//   55   return 2048;
        MOV      R0,R12
??Seek_Proj_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//   56 }
//   57 /*******************************************************************************
//   58  Seek_Blank: Seek Blank from recoeds             RET: offset, 2048 = Not found 
//   59 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Seek_Blank
        THUMB
//   60 u16 Seek_Blank(void)
//   61 {
Seek_Blank:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//   62   u16 i, j;
//   63   u32 Tmp;
//   64   
//   65   for(i=32; i<2048; i+=32){
        MOVS     R0,#+32
        LDR.N    R1,??DataTable6  ;; 0x8003800
        MOV      R2,#-1
//   66     Tmp = 0xFFFFFFFF;
??Seek_Blank_0:
        MOVS     R3,R2
//   67     for(j=0; j<32; j+=4)  Tmp &= *(u32*)(REC_BASE+i+j);
        ADD      R12,R1,R0
        MOV      LR,#+8
??Seek_Blank_1:
        LDR      R4,[R12], #+4
        ANDS     R3,R4,R3
        SUBS     LR,LR,#+1
        BNE.N    ??Seek_Blank_1
//   68     if(Tmp == 0xFFFFFFFF)  return i;
        CMP      R3,R2
        BEQ.N    ??Seek_Blank_2
//   69   }
        ADDS     R0,R0,#+32
        UXTH     R0,R0
        MOV      R12,#+2048
        CMP      R0,R12
        BCC.N    ??Seek_Blank_0
//   70   return 2048;
        MOV      R0,R12
??Seek_Blank_2:
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock4
//   71 }
//   72 /*******************************************************************************
//   73  Add_Proj: Add a Project ID into recoed                  RET: 1 = Ok, 0 = Fail
//   74 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function Add_Proj
        THUMB
//   75 u8 Add_Proj(u32 ProjectID, u16 Offset) 
//   76 {
Add_Proj:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOVS     R4,R0
        MOVS     R5,R1
//   77   u16 Result;
//   78   
//   79   FLASH_Unlock();
        BL       FLASH_Unlock
//   80   Result  = FLASH_Prog(REC_BASE + Offset + 0, ProjectID & 0xFFFF);
        UXTH     R1,R4
        LDR.N    R0,??DataTable6  ;; 0x8003800
        ADDS     R0,R0,R5
        BL       FLASH_Prog
        MOVS     R6,R0
//   81   Result &= FLASH_Prog(REC_BASE + Offset + 2, ProjectID >> 16);
        LSRS     R1,R4,#+16
        LDR.N    R0,??Add_Proj_0  ;; 0x8003802
        ADDS     R0,R0,R5
        BL       FLASH_Prog
        AND      R4,R0,R6
//   82   FLASH_Lock();
        BL       FLASH_Lock
//   83   return Result;
        MOVS     R0,R4
        POP      {R4-R6,PC}       ;; return
        DATA
??Add_Proj_0:
        DC32     0x8003802
        CFI EndBlock cfiBlock5
//   84 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable6:
        DC32     0x8003800
//   85 /*******************************************************************************
//   86  Add_Str: Add a Project string into recoed               RET: 1 = Ok, 0 = Fail
//   87 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function Add_Str
        THUMB
//   88 u8 Add_Str(u32 ProjStrAddr, u16 Offset) 
//   89 {
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
//   90   u8 i, Result = FLASH_COMPLETE;
        MOVS     R5,#+4
//   91   u16 Data;
//   92   FLASH_Unlock();
        BL       FLASH_Unlock
//   93   for(i=0; i<16; i+=2){
        LDR.N    R0,??Add_Str_0   ;; 0x8003810
        ADDS     R4,R0,R4
        MOVS     R7,#+8
//   94     Data  = *(u8*)ProjStrAddr;
??Add_Str_1:
        LDRB     R0,[R6, #+0]
//   95     (u8*)ProjStrAddr++;
        ADDS     R2,R6,#+1
//   96     Data |= (*(u8*)ProjStrAddr)<<8;
        LDRB     R1,[R2, #+0]
        ORR      R1,R0,R1, LSL #+8
//   97     (u8*)ProjStrAddr++;
        ADDS     R6,R2,#+1
//   98     Result &= FLASH_Prog(REC_BASE + Offset + i + 16, Data);
        MOVS     R0,R4
        BL       FLASH_Prog
        ANDS     R5,R0,R5
//   99   }
        ADDS     R4,R4,#+2
        SUBS     R7,R7,#+1
        BNE.N    ??Add_Str_1
//  100   FLASH_Lock();
        BL       FLASH_Lock
//  101   return Result;
        MOVS     R0,R5
        ADD      SP,SP,#+4
        CFI CFA R13+20
        POP      {R4-R7,PC}       ;; return
        DATA
??Add_Str_0:
        DC32     0x8003810
        CFI EndBlock cfiBlock6
//  102 }
//  103 /*******************************************************************************
//  104  Add_Cnt: Add demo counter value into recoed             RET: 1 = Ok, 0 = Fail
//  105 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function Add_Cnt
        THUMB
//  106 u8 Add_Cnt(u8 DemoCnt, u16 Offset)
//  107 {
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
//  108   u32 TmpL, TmpH;
//  109   u8  i, Result;
//  110   
//  111   FLASH_Unlock();
        BL       FLASH_Unlock
//  112   TmpH = 0;
        MOVS     R5,#+0
//  113   TmpL = 0;
        MOVS     R4,#+0
//  114   if(DemoCnt != 0){
        CBZ      R7,??Add_Cnt_0
//  115     if(DemoCnt <= 32)  for(i=0; i<DemoCnt; i++)  TmpL |= 1<<i; 
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
//  116     else {
//  117       TmpL = 0xFFFFFFFF;
??Add_Cnt_1:
        MOV      R4,#-1
//  118       for(i=0; i<(DemoCnt-32); i++)  TmpH |= 1<<i;
        MOVS     R0,#+0
        SUB      R1,R7,#+32
??Add_Cnt_3:
        MOVS     R2,#+1
        LSLS     R2,R2,R0
        ORRS     R5,R2,R5
        ADDS     R0,R0,#+1
        CMP      R0,R1
        BLT.N    ??Add_Cnt_3
//  119     }
//  120   }
//  121   Result  = FLASH_Prog(REC_BASE + Offset +  8, TmpL & 0xFFFF);
??Add_Cnt_0:
        UXTH     R1,R4
        LDR.N    R0,??DataTable7  ;; 0x8003808
        ADDS     R0,R0,R6
        BL       FLASH_Prog
        MOVS     R7,R0
//  122   Result &= FLASH_Prog(REC_BASE + Offset + 10, TmpL >> 16);
        LSRS     R1,R4,#+16
        LDR.N    R0,??Add_Cnt_4   ;; 0x800380a
        ADDS     R0,R0,R6
        BL       FLASH_Prog
        AND      R4,R0,R7
//  123   Result &= FLASH_Prog(REC_BASE + Offset + 12, TmpH & 0xFFFF);
        UXTH     R1,R5
        LDR.N    R0,??DataTable8  ;; 0x800380c
        ADDS     R0,R0,R6
        BL       FLASH_Prog
        ANDS     R4,R0,R4
//  124   Result &= FLASH_Prog(REC_BASE + Offset + 14, TmpH >> 16);
        LSRS     R1,R5,#+16
        LDR.N    R0,??Add_Cnt_4+0x4  ;; 0x800380e
        ADDS     R0,R0,R6
        BL       FLASH_Prog
        ANDS     R4,R0,R4
//  125   FLASH_Lock();
        BL       FLASH_Lock
//  126   return Result;
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
//  127 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7:
        DC32     0x8003808

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     0x800380c
//  128 /*******************************************************************************
//  129  Add_Lic: Add Licence number into recoed                 RET: 1 = Ok, 0 = Fail
//  130 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function Add_Lic
        THUMB
//  131 u8 Add_Lic(u32 LicenceNo, u32 Offsaet) 
//  132 {
Add_Lic:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOVS     R4,R0
        MOVS     R5,R1
//  133   u8 Result;
//  134   
//  135   FLASH_Unlock();
        BL       FLASH_Unlock
//  136   Result  = FLASH_Prog(REC_BASE+Offsaet+4, LicenceNo & 0xFFFF);
        UXTH     R1,R4
        LDR.N    R0,??DataTable9  ;; 0x8003804
        ADDS     R0,R0,R5
        BL       FLASH_Prog
        MOVS     R6,R0
//  137   Result &= FLASH_Prog(REC_BASE+Offsaet+6, LicenceNo >> 16);
        LSRS     R1,R4,#+16
        LDR.N    R0,??Add_Lic_0   ;; 0x8003806
        ADDS     R0,R0,R5
        BL       FLASH_Prog
        AND      R4,R0,R6
//  138   FLASH_Lock();
        BL       FLASH_Lock
//  139   return Result;
        MOVS     R0,R4
        POP      {R4-R6,PC}       ;; return
        DATA
??Add_Lic_0:
        DC32     0x8003806
        CFI EndBlock cfiBlock8
//  140 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable9:
        DC32     0x8003804
//  141 /*******************************************************************************
//  142  Input_Lic: Input 32 Bytes Licence                         RET: licence number
//  143 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function Input_Lic
        THUMB
//  144 u32 Input_Lic(u16 x0, u8 y0) // Return: 32Bits Lic 
//  145 {
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
//  146   u8  i=0, j, n[2]={"0"};
        MOVS     R4,#+0
        ADD      R0,SP,#+0
        LDR.N    R1,??Input_Lic_0  ;; `?<Constant "0">`
        LDRB     R2,[R1, #0]
        STRB     R2,[R0, #+0]
        LDRB     R2,[R1, #+1]
        STRB     R2,[R0, #+1]
//  147   u32 Lic=0;
        MOVS     R5,#+0
//  148   u8  NumStr[9], Type;
//  149   
//  150   Word2Hex(NumStr, Lic);
        MOV      R1,R4
        ADD      R0,SP,#+4
        BL       Word2Hex
//  151   Display_Str(x0, y0, WHT, PRN, NumStr);
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
//  152   
//  153   while (i<8){
//  154     Word2Hex(NumStr, Lic);
??Input_Lic_1:
        MOVS     R1,R5
        ADD      R0,SP,#+4
        BL       Word2Hex
//  155     if( Type != Twink ){  // Blink current number each 0.5 Sec.
        LDR.N    R1,??Input_Lic_0+0x4  ;; Twink
        LDRB     R1,[R1, #+0]
        UXTB     R0,R11
        CMP      R0,R1
        BEQ.N    ??Input_Lic_2
//  156       Type = Twink;
        LDR.N    R0,??Input_Lic_0+0x4  ;; Twink
        LDRB     R11,[R0, #+0]
//  157       for(j=0; j<8; ++j){ // 刷新显示8位数字，当前位闪烁
        MOVS     R6,#+0
        ADD      R8,SP,#+4
        LDRH     R7,[SP, #+16]
//  158         n[0] = NumStr[j];
??Input_Lic_3:
        LDRB     R0,[R8, #+0]
        STRB     R0,[SP, #+0]
//  159         if(i==j) Display_Str(j*8+ x0, y0, WHT, Type, n);
        UXTB     R1,R6
        CMP      R4,R1
        ADD      R0,SP,#+0
        PUSH     {R0,LR}
        CFI CFA R13+64
        BNE.N    ??Input_Lic_4
        MOV      R3,R11
        B.N      ??Input_Lic_5
//  160         else     Display_Str(j*8+ x0, y0, WHT, PRN,  n);
??Input_Lic_4:
        MOVS     R3,#+0
??Input_Lic_5:
        MOV      R2,R9
        MOV      R1,R10
        UXTH     R0,R7
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+56
//  161       }
        ADDS     R6,R6,#+1
        ADDS     R7,R7,#+8
        ADD      R8,R8,#+1
        UXTB     R0,R6
        CMP      R0,#+8
        BCC.N    ??Input_Lic_3
//  162     }
//  163     if(Key_Buffer != 0){
??Input_Lic_2:
        LDR.N    R0,??Input_Lic_0+0x8  ;; Key_Buffer
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Input_Lic_6
//  164       switch (Key_Buffer){  
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
//  165       case K_INDEX_DEC:
//  166         if(((Lic >>((7-i)*4))& 0x0F )> 0) Lic -= 0x01<<((7-i)*4);
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
//  167         else                              Lic += 0x0F<<((7-i)*4);
??Input_Lic_13:
        MOVS     R1,#+15
        LSL      R0,R1,R0
??Input_Lic_15:
        ADDS     R5,R0,R5
        B.N      ??Input_Lic_12
//  168         break;
//  169       case K_INDEX_INC:
//  170         if(((Lic >>((7-i)*4))& 0x0F )<15) Lic += 0x01<<((7-i)*4);
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
//  171         else                              Lic -= 0x0F<<((7-i)*4);
??Input_Lic_16:
        MOVS     R1,#+15
        LSL      R0,R1,R0
        B.N      ??Input_Lic_14
//  172         break;
//  173       case K_ITEM_INC:
//  174         if(i<7) i++;
??Input_Lic_10:
        CMP      R4,#+7
        BCS.N    ??Input_Lic_17
        ADDS     R4,R4,#+1
??Input_Lic_18:
        UXTB     R4,R4
        B.N      ??Input_Lic_12
//  175         else    i=0;
??Input_Lic_17:
        MOVS     R4,#+0
        B.N      ??Input_Lic_12
//  176         break;
//  177       case K_ITEM_DEC:
//  178         if(i>0) i--;
??Input_Lic_11:
        MOVS     R0,R4
        BEQ.N    ??Input_Lic_19
        SUBS     R4,R4,#+1
        B.N      ??Input_Lic_18
//  179         else    i=7;
??Input_Lic_19:
        MOVS     R4,#+7
        B.N      ??Input_Lic_12
//  180         break;
//  181       case K_SELE:
//  182         i = 8;        // Exit 
??Input_Lic_7:
        MOVS     R4,#+8
//  183         break;
//  184       }
//  185       Key_Buffer = NO_KEY;
??Input_Lic_12:
        LDR.N    R0,??Input_Lic_0+0x8  ;; Key_Buffer
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  186     }
//  187   }
??Input_Lic_6:
        CMP      R4,#+8
        BCC.N    ??Input_Lic_1
//  188   return Lic;
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
//  189 }
//  190 /*******************************************************************************
//  191  FLASH_Prog:
//  192 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function FLASH_Prog
        THUMB
//  193 u8 FLASH_Prog(u32 Address, u16 Data)    
//  194 {
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
//  195   if(FLASH_WaitForLastOperation(WAIT_TIMES)!=FLASH_TIMEOUT) 
        LDR.N    R0,??DataTable11  ;; 0x186a0
        BL       FLASH_WaitForLastOperation
        CMP      R0,#+5
        BEQ.N    ??FLASH_Prog_0
//  196     FLASH_ClearFlag(FLASH_FLAG_EOP|FLASH_FLAG_PGERR|FLASH_FLAG_WRPRTERR); 
        MOVS     R0,#+52
        BL       FLASH_ClearFlag
//  197   if(FLASH_ProgramHalfWord(Address, Data)== FLASH_COMPLETE) return 1;
??FLASH_Prog_0:
        MOVS     R1,R4
        MOVS     R0,R5
        BL       FLASH_ProgramHalfWord
        CMP      R0,#+4
        BNE.N    ??FLASH_Prog_1
        MOVS     R0,#+1
        B.N      ??FLASH_Prog_2
//  198   else                                                      return 0;
??FLASH_Prog_1:
        MOVS     R0,#+0
??FLASH_Prog_2:
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        CFI EndBlock cfiBlock10
//  199 }
//  200 /*******************************************************************************
//  201  FLASH_Erase:
//  202 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function FLASH_Erase
        THUMB
//  203 u8 FLASH_Erase(u32 Address)    
//  204 {
FLASH_Erase:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        MOVS     R4,R0
//  205   if(Address%PAGE_SIZE == 0){                               // FLASH Page start
        LSLS     R0,R4,#+21
        BNE.N    ??FLASH_Erase_0
//  206     if(FLASH_WaitForLastOperation(WAIT_TIMES)!=FLASH_TIMEOUT) 
        LDR.N    R0,??DataTable11  ;; 0x186a0
        BL       FLASH_WaitForLastOperation
        CMP      R0,#+5
        BEQ.N    ??FLASH_Erase_1
//  207       FLASH_ClearFlag(FLASH_FLAG_EOP|FLASH_FLAG_PGERR|FLASH_FLAG_WRPRTERR); 
        MOVS     R0,#+52
        BL       FLASH_ClearFlag
//  208     if(FLASH_ErasePage(Address)== FLASH_COMPLETE) return 1; // FLASH Page erase 
??FLASH_Erase_1:
        MOVS     R0,R4
        BL       FLASH_ErasePage
        CMP      R0,#+4
        BEQ.N    ??FLASH_Erase_0
//  209     else                                          return 0;
??FLASH_Erase_2:
        MOVS     R0,#+0
        POP      {R4,PC}
//  210   }
//  211   return 1;
??FLASH_Erase_0:
        MOVS     R0,#+1
??FLASH_Erase_3:
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock11
//  212 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable11:
        DC32     0x186a0

        SECTION `.rodata`:CONST:NOROOT(1)
`?<Constant "0">`:
        DATA
        DC8 "0"

        END
//  213 /********************************* END OF FILE ********************************/
// 
//   2 bytes in section .rodata
// 880 bytes in section .text
// 
// 880 bytes of CODE  memory
//   2 bytes of CONST memory
//
//Errors: none
//Warnings: none
