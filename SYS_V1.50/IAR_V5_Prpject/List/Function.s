///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:03:34 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\SYS_V1.50\source\Function.c            /
//    Command line =  E:\Mini-DS\DS203\SYS_V1.50\source\Function.c -lA        /
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
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\Function /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Function

        EXTERN Beep_mS
        EXTERN Get
        EXTERN Key_Repeat_Cnt
        EXTERN Key_Status_Last
        EXTERN Key_Wait_Cnt
        EXTERN Set
        EXTERN __aeabi_memcpy

        PUBLIC Beep
        PUBLIC Char2Hex
        PUBLIC Int_sqrt
        PUBLIC Read_Keys
        PUBLIC Str2Byte
        PUBLIC Word2Hex
        PUBLIC u16ToDec5
        PUBLIC u8ToDec2
        PUBLIC u8ToDec3
        
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
        
// E:\Mini-DS\DS203\SYS_V1.50\source\Function.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : Function.c  
//    3  Version   : DS203_SYS Ver 1.3x                          Author : kewei & bure
//    4 *******************************************************************************/
//    5 
//    6 #include "stm32f10x_lib.h"
//    7 #include "Interrupt.h"
//    8 #include "Function.h"
//    9 #include "Config.h"
//   10 #include "BIOS.h"
//   11 #include "ASM.h"
//   12 
//   13                           
//   14 /*******************************************************************************
//   15  Two ASCII character Change to 1 Byte HEX data 
//   16 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Str2Byte
        THUMB
//   17 u8 Str2Byte(u8 x,u8 y) // 双ASCII字符转1字节二进制数
//   18 {
Str2Byte:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+20
        CFI CFA R13+32
        MOVS     R5,R0
        MOVS     R4,R1
//   19   uc8 Hexcode[17]="0123456789ABCDEF";
        ADD      R0,SP,#+0
        LDR.N    R1,??Str2Byte_0  ;; `?<Constant "0123456789ABCDEF">`
        MOVS     R2,#+17
        BL       __aeabi_memcpy
//   20   u8 i, Temp=0;
        MOVS     R0,#+0
//   21   
//   22   if(x>='a' && x<='z')  x-=32;     // 小写改大写
        CMP      R5,#+97
        BCC.N    ??Str2Byte_1
        CMP      R5,#+123
        IT       CC 
        SUBCC    R5,R5,#+32
//   23   if(y>='a' && y<='z')  y-=32;     // 小写改大写
??Str2Byte_1:
        CMP      R4,#+97
        BCC.N    ??Str2Byte_2
        CMP      R4,#+123
        IT       CC 
        SUBCC    R4,R4,#+32
//   24   for(i=0;i<16;i++){
??Str2Byte_2:
        ADD      R1,SP,#+0
        MOVS     R2,#+0
        MOVS     R3,#+16
//   25     if(Hexcode[i]==x)  Temp+=i*16; // 将字符转为高4位十六进制数值
??Str2Byte_3:
        LDRB     R12,[R1, #+0]
        UXTB     R5,R5
        CMP      R12,R5
        BNE.N    ??Str2Byte_4
        ADDS     R0,R2,R0
        UXTB     R0,R0
//   26   }
??Str2Byte_4:
        ADDS     R2,R2,#+16
        ADDS     R1,R1,#+1
        SUBS     R3,R3,#+1
        BNE.N    ??Str2Byte_3
//   27   for(i=0;i<16;i++){
        MOVS     R1,#+0
        ADD      R2,SP,#+0
//   28     if(Hexcode[i]==y)  Temp+=i;    // 将字符转为低4位十六进制数值
??Str2Byte_5:
        LDRB     R3,[R2, #+0]
        UXTB     R4,R4
        CMP      R3,R4
        BNE.N    ??Str2Byte_6
        ADDS     R0,R1,R0
        UXTB     R0,R0
//   29   }
??Str2Byte_6:
        ADDS     R1,R1,#+1
        ADDS     R2,R2,#+1
        UXTB     R3,R1
        CMP      R3,#+16
        BCC.N    ??Str2Byte_5
//   30   return Temp;
        ADD      SP,SP,#+20
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        Nop      
        DATA
??Str2Byte_0:
        DC32     `?<Constant "0123456789ABCDEF">`
        CFI EndBlock cfiBlock0
//   31 }
//   32 
//   33 /*******************************************************************************
//   34  u16ToDec5: Change Byte to 3 decimal number string   
//   35 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function u16ToDec5
        THUMB
//   36 void u16ToDec5(u8 *p, u16 n)
//   37 {
//   38     *p++ = '0'+n/10000;
u16ToDec5:
        MOVW     R2,#+10000
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+0]
//   39     n %= 10000;
        MLS      R1,R3,R2,R1
//   40     *p++ = '0'+n/1000;
        UXTH     R1,R1
        MOV      R2,#+1000
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+1]!
//   41     n %= 1000;
        MLS      R1,R3,R2,R1
//   42     *p++ = '0'+n/100;
        UXTH     R1,R1
        MOVS     R2,#+100
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+1]!
//   43     n %= 100;
        MLS      R1,R3,R2,R1
//   44     *p++ = '0'+n/10;
        UXTH     R1,R1
        MOVS     R2,#+10
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+1]!
//   45     n %= 10;
        MLS      R1,R3,R2,R1
//   46     *p++ = '0'+n;
        ADDS     R1,R1,#+48
        STRB     R1,[R0, #+1]!
//   47     *p = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]!
//   48 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//   49 /*******************************************************************************
//   50  Char2Dec3: Change Byte to 3 decimal number string   
//   51 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function u8ToDec3
        THUMB
//   52 void u8ToDec3(u8 *p, u8 n)
//   53 {
//   54     *p++ = '0'+n/100;
u8ToDec3:
        MOVS     R2,#+100
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+0]
//   55     n %= 100;
        MLS      R1,R3,R2,R1
//   56     *p++ = '0'+n/10;
        UXTB     R1,R1
        MOVS     R2,#+10
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+1]!
//   57     n %= 10;
        MLS      R1,R3,R2,R1
//   58     *p++ = '0'+n;
        ADDS     R1,R1,#+48
        STRB     R1,[R0, #+1]!
//   59     *p = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]!
//   60 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//   61 /*******************************************************************************
//   62  Char2Dec2: Change Byte to 2 decimal number string   
//   63 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function u8ToDec2
        THUMB
//   64 void u8ToDec2(u8 *p, u8 n)
//   65 {
//   66 //    *p++ = '0'+n/100;
//   67     n %= 100;
u8ToDec2:
        MOVS     R2,#+100
        SDIV     R3,R1,R2
        MLS      R1,R3,R2,R1
//   68     *p++ = '0'+n/10;
        UXTB     R1,R1
        MOVS     R2,#+10
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+0]
//   69     n %= 10;
        MLS      R1,R3,R2,R1
//   70     *p++ = '0'+n;
        ADDS     R1,R1,#+48
        STRB     R1,[R0, #+1]!
//   71     *p = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]!
//   72 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//   73 /*******************************************************************************
//   74  Char2Hex: Change Byte to 2 hex number string  
//   75 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Char2Hex
        THUMB
//   76 void Char2Hex(u8 *p, u8 n)
//   77 {
//   78     if(n/16>9) *p++ = 'A'+(n/16-10);
Char2Hex:
        LSRS     R2,R1,#+4
        CMP      R2,#+10
        ITTEE    CC 
        ADDCC    R3,R2,#+48
        STRBCC   R3,[R0], #+1
        ADDCS    R3,R2,#+55
        STRBCS   R3,[R0], #+1
//   79     else       *p++ = '0'+n/16;
//   80     n %= 16;
        SUB      R1,R1,R2, LSL #+4
//   81     if(n>9)    *p++ = 'A'+(n-10);
        UXTB     R1,R1
        CMP      R1,#+10
        BCC.N    ??Char2Hex_0
        ADDS     R1,R1,#+55
        STRB     R1,[R0], #+1
        B.N      ??Char2Hex_1
//   82     else       *p++ = '0'+n;
??Char2Hex_0:
        ADDS     R1,R1,#+48
        STRB     R1,[R0], #+1
//   83     *p = 0;
??Char2Hex_1:
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//   84 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//   85 /*******************************************************************************
//   86  Word2Hex: Change 4 Bytes to 8 hex number string  
//   87 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function Word2Hex
        THUMB
//   88 void Word2Hex(u8 *p, u32 n)
//   89 {
//   90     if(n/0x10000000>9) *p++ = 'A'+(n/0x10000000-10);
Word2Hex:
        LSRS     R2,R1,#+28
        CMP      R2,#+10
        BCC.N    ??Word2Hex_0
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_1
//   91     else               *p++ = '0'+ n/0x10000000;
??Word2Hex_0:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//   92     n %= 0x10000000;
??Word2Hex_1:
        LSLS     R1,R1,#+4
        LSRS     R1,R1,#+4
//   93     if(n/0x01000000>9) *p++ = 'A'+(n/0x01000000-10);
        LSRS     R2,R1,#+24
        CMP      R2,#+10
        BCC.N    ??Word2Hex_2
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_3
//   94     else               *p++ = '0'+ n/0x01000000;
??Word2Hex_2:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//   95     n %= 0x01000000;
??Word2Hex_3:
        LSLS     R1,R1,#+8
        LSRS     R1,R1,#+8
//   96     if(n/0x00100000>9) *p++ = 'A'+(n/0x00100000-10);
        LSRS     R2,R1,#+20
        CMP      R2,#+10
        BCC.N    ??Word2Hex_4
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_5
//   97     else               *p++ = '0'+ n/0x00100000;
??Word2Hex_4:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//   98     n %= 0x00100000;
??Word2Hex_5:
        LSLS     R1,R1,#+12
        LSRS     R1,R1,#+12
//   99     if(n/0x00010000>9) *p++ = 'A'+(n/0x00010000-10);
        LSRS     R2,R1,#+16
        CMP      R2,#+10
        BCC.N    ??Word2Hex_6
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_7
//  100     else               *p++ = '0'+ n/0x00010000;
??Word2Hex_6:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  101     n %= 0x00010000;
??Word2Hex_7:
        UXTH     R1,R1
//  102     if(n/0x00001000>9) *p++ = 'A'+(n/0x00001000-10);
        LSRS     R2,R1,#+12
        CMP      R2,#+10
        BCC.N    ??Word2Hex_8
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_9
//  103     else               *p++ = '0'+ n/0x00001000;
??Word2Hex_8:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  104     n %= 0x00001000;
??Word2Hex_9:
        LSLS     R1,R1,#+20
        LSRS     R1,R1,#+20
//  105     if(n/0x00000100>9) *p++ = 'A'+(n/0x00000100-10);
        LSRS     R2,R1,#+8
        CMP      R2,#+10
        BCC.N    ??Word2Hex_10
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_11
//  106     else               *p++ = '0'+ n/0x00000100;
??Word2Hex_10:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  107     n %= 0x00000100;
??Word2Hex_11:
        UXTB     R1,R1
//  108     if(n/0x00000010>9) *p++ = 'A'+(n/0x00000010-10);
        LSRS     R2,R1,#+4
        CMP      R2,#+10
        BCC.N    ??Word2Hex_12
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_13
//  109     else               *p++ = '0'+ n/0x00000010;
??Word2Hex_12:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  110     n %= 0x00000010;
??Word2Hex_13:
        AND      R1,R1,#0xF
//  111     if(n/0x00000001>9) *p++ = 'A'+(n/0x00000001-10);
        CMP      R1,#+10
        BCC.N    ??Word2Hex_14
        ADDS     R1,R1,#+55
        STRB     R1,[R0], #+1
        B.N      ??Word2Hex_15
//  112     else               *p++ = '0'+ n/0x00000001;
??Word2Hex_14:
        ADDS     R1,R1,#+48
        STRB     R1,[R0], #+1
//  113     n %= 0x10000000;
//  114     *p = 0;
??Word2Hex_15:
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  115 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  116 /*******************************************************************************
//  117  Int_sqrt: unsigned int square root
//  118 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function Int_sqrt
        THUMB
//  119 u32 Int_sqrt(u32 n)
//  120 { u32 k;
Int_sqrt:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        MOVS     R4,R0
//  121   if ( n == 0 ) return 0;
        BNE.N    ??Int_sqrt_0
        MOVS     R0,#+0
        POP      {R4,PC}
//  122   k = 2*Int_sqrt(n/4)+1;
??Int_sqrt_0:
        LSRS     R0,R4,#+2
        BL       Int_sqrt
        LSLS     R0,R0,#+1
        ADDS     R0,R0,#+1
//  123   if ( k*k > n ) return k-1;
        MUL      R1,R0,R0
        CMP      R4,R1
        IT       CC 
        SUBCC    R0,R0,#+1
//  124   else return k;
??Int_sqrt_1:
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock6
//  125 }
//  126 /*******************************************************************************
//  127 Read_Keys:    Key status process                                Return: KeyCode
//  128 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function Read_Keys
        THUMB
//  129 u8 Read_Keys(void)
//  130 {
Read_Keys:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  131   u16 Key_Status, Key_Status_Now;
//  132   u8  KeyCode=0;
        MOVS     R4,#+0
//  133   Key_Status_Now = ~Get(KEY_STATUS, 0);
        MOVS     R1,#+0
        MOVS     R0,#+4
        BL       Get
        MVNS     R0,R0
        UXTH     R0,R0
//  134   Key_Status = Key_Status_Now &(~Key_Status_Last);
        LDR.N    R1,??Read_Keys_0  ;; Key_Status_Last
        MOVS     R2,R0
        LDRH     R3,[R1, #+0]
        MVNS     R3,R3
        ANDS     R2,R3,R2
//  135   if(Key_Status){                               // New key push on
        BEQ.N    ??Read_Keys_1
//  136     Key_Wait_Cnt=25;                        // Close auto repeat 500mS
        LDR.N    R3,??Read_Keys_0+0x4  ;; Key_Wait_Cnt
        MOV      R12,#+25
        STRB     R12,[R3, #+0]
//  137     if(Key_Status & 0x0100)  KeyCode = K_FUNC;         // K3 
        TST      R2,#0x100
        IT       NE 
        MOVNE    R4,#+3
//  138     if(Key_Status & 0x0200)  KeyCode = K_MENU;         // K4 
        TST      R2,#0x200
        IT       NE 
        MOVNE    R4,#+4
//  139     if(Key_Status & 0x0400)  KeyCode = K_INDEX_DEC;    // K5 
        TST      R2,#0x400
        IT       NE 
        MOVNE    R4,#+5
//  140     if(Key_Status & 0x0800)  KeyCode = K_INDEX_INC;    // K6  
        TST      R2,#0x800
        IT       NE 
        MOVNE    R4,#+6
//  141     if(Key_Status & 0x1000)  KeyCode = K_INDEX_OK;     // K7  
        TST      R2,#0x1000
        IT       NE 
        MOVNE    R4,#+7
//  142     if(Key_Status & 0x2000)  KeyCode = K_SELE;         // K2
        TST      R2,#0x2000
        IT       NE 
        MOVNE    R4,#+2
//  143     if(Key_Status & 0x4000)  KeyCode = K_PLAY;         // K1
        TST      R2,#0x4000
        IT       NE 
        MOVNE    R4,#+1
//  144     if(Key_Status & 0x8000)  KeyCode = K_ITEM_INC;     // K8
        TST      R2,#0x8000
        IT       NE 
        MOVNE    R4,#+8
//  145     if(Key_Status & 0x0008)  KeyCode = K_ITEM_DEC;     // K9
        TST      R2,#0x8
        IT       NE 
        MOVNE    R4,#+9
//  146     if(Key_Status & 0x0040)  KeyCode = K_ITEM_OK;      // K10
        TST      R2,#0x40
        BEQ.N    ??Read_Keys_2
        MOVS     R4,#+10
        B.N      ??Read_Keys_2
//  147   } else {
//  148     if(Key_Status_Now & Key_Status_Last){       // Key push hold on
??Read_Keys_1:
        LDRH     R2,[R1, #+0]
        TST      R0,R2
        BEQ.N    ??Read_Keys_2
//  149       if((Key_Wait_Cnt ==0)&&(Key_Repeat_Cnt ==0)){
        LDR.N    R2,??Read_Keys_0+0x4  ;; Key_Wait_Cnt
        LDRB     R2,[R2, #+0]
        CBNZ     R2,??Read_Keys_2
        LDR.N    R2,??Read_Keys_0+0x8  ;; Key_Repeat_Cnt
        LDRB     R3,[R2, #+0]
        CBNZ     R3,??Read_Keys_2
//  150         if(Key_Status_Now & 0x0400)  KeyCode = K_INDEX_DEC;    // K5 
        TST      R0,#0x400
        IT       NE 
        MOVNE    R4,#+5
//  151         if(Key_Status_Now & 0x0800)  KeyCode = K_INDEX_INC;    // K6
        TST      R0,#0x800
        IT       NE 
        MOVNE    R4,#+6
//  152         if(Key_Status_Now & 0x0008)  KeyCode = K_ITEM_DEC;     // K9 
        TST      R0,#0x8
        IT       NE 
        MOVNE    R4,#+9
//  153         if(Key_Status_Now & 0x8000)  KeyCode = K_ITEM_INC;     // K8 
        TST      R0,#0x8000
        IT       NE 
        MOVNE    R4,#+8
//  154         Key_Repeat_Cnt = 5;                 // Auto repeat per 100mS
        MOVS     R3,#+5
        STRB     R3,[R2, #+0]
//  155       }
//  156     }
//  157   }
//  158   Key_Status_Last = Key_Status_Now;
??Read_Keys_2:
        STRH     R0,[R1, #+0]
//  159   return KeyCode;
        MOVS     R0,R4
        POP      {R4,PC}          ;; return
        DATA
??Read_Keys_0:
        DC32     Key_Status_Last
        DC32     Key_Wait_Cnt
        DC32     Key_Repeat_Cnt
        CFI EndBlock cfiBlock7
//  160 }    
//  161 /*******************************************************************************
//  162 Beep : Beeper Ctrl  (Volume=0~99, Lenght=1~65535mS)
//  163 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function Beep
        THUMB
//  164 void Beep(u8 Volume, u16 mS)
//  165 {
//  166   Beep_mS = mS; 
Beep:
        LDR.N    R2,??Beep_0      ;; Beep_mS
        STRH     R1,[R2, #+0]
//  167   Set(BEEP_VOLUME, Volume);
        MOVS     R1,R0
        MOVS     R0,#+3
        B.W      Set
        DATA
??Beep_0:
        DC32     Beep_mS
        CFI EndBlock cfiBlock8
//  168 }

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "0123456789ABCDEF">`:
        DATA
        DC8 "0123456789ABCDEF"
        DC8 0, 0, 0

        END
//  169 /********************************* END OF FILE ********************************/
// 
//  20 bytes in section .rodata
// 776 bytes in section .text
// 
// 776 bytes of CODE  memory
//  20 bytes of CONST memory
//
//Errors: none
//Warnings: none
