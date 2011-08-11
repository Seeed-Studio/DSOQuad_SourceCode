///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  11:08:00 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\APP_V2.51\source\Function.c            /
//    Command line =  E:\Mini-DS\DS203\APP_V2.51\source\Function.c -lA        /
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
//    List file    =  E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\List\Function /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Function

        EXTERN Delay_Cnt
        EXTERN Key_Repeat_Cnt
        EXTERN Key_Status_Last
        EXTERN Key_Wait_Cnt
        EXTERN __Get
        EXTERN __aeabi_memcpy

        PUBLIC Char2Hex
        PUBLIC Delayms
        PUBLIC Int2Str
        PUBLIC Int_sqrt
        PUBLIC Power
        PUBLIC Read_Keys
        PUBLIC Shor2Hex
        PUBLIC Str2Byte
        PUBLIC TestCnt
        PUBLIC Word2Hex
        PUBLIC s8ToPercen
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
        
// E:\Mini-DS\DS203\APP_V2.51\source\Function.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : Function.c  
//    3  Version   : DS203 APP Ver 2.5x                          Author : bure & Kewei
//    4 *******************************************************************************/
//    5 #include "Interrupt.h"
//    6 #include "Function.h"
//    7 #include "BIOS.h"
//    8 

        SECTION `.bss`:DATA:NOROOT(2)
//    9 u32 TestCnt = 0;
TestCnt:
        DS8 4
//   10 
//   11 /*******************************************************************************
//   12  
//   13 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Power
        THUMB
//   14 u32 Power(u8 x, u8 y) 
//   15 { 
Power:
        MOVS     R2,R0
//   16   u32 m = x;
//   17   
//   18   if(y == 0) return 1;
        CBNZ     R1,??Power_0
        MOVS     R0,#+1
        BX       LR
//   19   while (--y) m *= x;
??Power_1:
        MULS     R0,R0,R2
??Power_0:
        SUBS     R1,R1,#+1
        UXTB     R1,R1
        CMP      R1,#+0
        BNE.N    ??Power_1
//   20   return m;
??Power_2:
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//   21 }
//   22 /*******************************************************************************
//   23  delayms: 毫秒（mS）延时程序。 输入: 延时等待的毫秒数值（在72MHz主频情况下）
//   24 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function Delayms
        THUMB
//   25 void Delayms(u16 mS) 
//   26 { 
//   27   Delay_Cnt = mS;
Delayms:
        LDR.N    R1,??Delayms_0   ;; Delay_Cnt
        STRH     R0,[R1, #+0]
//   28   while (Delay_Cnt > 0){}
??Delayms_1:
        LDRH     R0,[R1, #+0]
        CMP      R0,#+0
        BNE.N    ??Delayms_1
//   29 }
        BX       LR               ;; return
        DATA
??Delayms_0:
        DC32     Delay_Cnt
        CFI EndBlock cfiBlock1
//   30 /*******************************************************************************
//   31  Sign_int2Str: 32位数转e位有效数字符串 + 量纲字符串
//   32 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Int2Str
        THUMB
//   33 void Int2Str(u8 *p, s32 n, uc8 *pUnit, u8 e, u8 Mode)
//   34 {
Int2Str:
        PUSH     {R4-R8,LR}
        CFI R14 Frame(CFA, -4)
        CFI R8 Frame(CFA, -8)
        CFI R7 Frame(CFA, -12)
        CFI R6 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
        SUB      SP,SP,#+8
        CFI CFA R13+32
        LDRB     LR,[SP, #+32]
//   35   s32 i, j, m, c;
//   36   u8  *k;
//   37   
//   38   if(n == 0x80000000){               // 该数值定义为无效数值
        CMP      R1,#-2147483648
        BNE.N    ??Int2Str_0
//   39     *p++ = ' '; *p++ = '.';
        MOVS     R1,#+32
        STRB     R1,[R0], #+1
        MOVS     R1,#+46
        STRB     R1,[R0], #+1
        MOVS     R1,#+32
        B.N      ??Int2Str_1
//   40     while(--e)  *p++ = ' '; 
??Int2Str_2:
        STRB     R1,[R0], #+1
??Int2Str_1:
        SUBS     R3,R3,#+1
        UXTB     R3,R3
        CMP      R3,#+0
        BNE.N    ??Int2Str_2
//   41     *p = 0;  return;
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
        B.N      ??Int2Str_3
//   42   }
//   43   if(Mode == SIGN){
??Int2Str_0:
        CMP      LR,#+0
        BNE.N    ??Int2Str_4
//   44     if(n == 0) *p++ = '0';
        CBNZ     R1,??Int2Str_5
        MOV      R12,#+48
        STRB     R12,[R0], #+1
        B.N      ??Int2Str_4
//   45     if(n >  0) *p++ = '+';
??Int2Str_5:
        CMP      R1,#+1
        BLT.N    ??Int2Str_6
        MOV      R12,#+43
        STRB     R12,[R0], #+1
        B.N      ??Int2Str_4
//   46     if(n <  0){*p++ = '-';  n = -n;}
??Int2Str_6:
        CMP      R1,#+0
        ITTT     MI 
        MOVMI    R12,#+45
        STRBMI   R12,[R0], #+1
        RSBMI    R1,R1,#+0
//   47   }
//   48   m = n; i = 0; c = 5;
??Int2Str_4:
        MOVS     R5,R1
        MOVS     R6,#+0
        MOVS     R7,#+5
        MOV      R12,#+10
        B.N      ??Int2Str_7
//   49   while(m >= 10){                    // 检测 n 的有效位数
//   50     m /= 10;  if(++i > e) c *= 10;   // 有效位数大于e则计算四舍五入位数
??Int2Str_8:
        SDIV     R5,R5,R12
        ADDS     R6,R6,#+1
        CMP      R3,R6
        IT       LT 
        MULLT    R7,R7,R12
//   51   }
??Int2Str_7:
        CMP      R5,#+10
        BGE.N    ??Int2Str_8
//   52   if(i >= e) n += c;                 // 加上四舍五入值
        CMP      R6,R3
        IT       GE 
        ADDGE    R1,R7,R1
//   53   m = n; i = 0;
        MOVS     R5,R1
        MOVS     R7,#+0
        B.N      ??Int2Str_9
//   54   while(m >= 10){                    // 重新检测 n 的有效位数
//   55     m /= 10; i++;
??Int2Str_10:
        SDIV     R5,R5,R12
//   56   }
??Int2Str_9:
        ADDS     R7,R7,#+1
        CMP      R5,#+10
        BGE.N    ??Int2Str_10
//   57   i++;   
//   58   if(e > 3){
        MOV      R12,#+3
        SDIV     R5,R7,R12
        MLS      R6,R5,R12,R7
        CMP      R3,#+4
        BCC.N    ??Int2Str_11
//   59     m = (i-1)/3;
        SUBS     R5,R7,#+1
        SDIV     R5,R5,R12
//   60     i %= 3;
//   61     if(i == 0) i = 3;
        CBNZ     R6,??Int2Str_11
        MOVS     R6,#+3
//   62   } else {
//   63     m = i/3;
//   64     i %= 3;
//   65   }
//   66   p += e; k = p+1;  
??Int2Str_11:
        ADDS     R0,R3,R0
        ADDS     R4,R0,#+1
        MOV      R12,#+10
        B.N      ??Int2Str_12
//   67   while(n >= Power(10, e)) n /= 10;  // 截取最高e位有效位数
??Int2Str_13:
        SDIV     R1,R1,R12
??Int2Str_12:
        MOVS     R7,R3
        MOV      R8,R12
        BNE.N    ??Int2Str_14
        MOV      R8,#+1
        B.N      ??Int2Str_15
??Int2Str_16:
        MUL      R8,R8,R12
??Int2Str_14:
        SUBS     R7,R7,#+1
        UXTB     R7,R7
        CMP      R7,#+0
        BNE.N    ??Int2Str_16
??Int2Str_15:
        CMP      R1,R8
        BCS.N    ??Int2Str_13
//   68   for(j=0; j<m; j++) while(*pUnit++);
        CMP      R5,#+1
        BLT.N    ??Int2Str_17
        MOV      R12,R5
        B.N      ??Int2Str_18
??Int2Str_19:
        ADDS     R2,R2,#+1
??Int2Str_18:
        LDRB     R7,[R2, #+0]
        CMP      R7,#+0
        BNE.N    ??Int2Str_19
        ADDS     R2,R2,#+1
        SUBS     R12,R12,#+1
        BNE.N    ??Int2Str_18
//   69   do *k++ = *pUnit; while(*pUnit++); // 量纲字符字符串  
??Int2Str_17:
        LDRB     R12,[R2, #+0]
        STRB     R12,[R4], #+1
        LDRB     R12,[R2], #+1
        CMP      R12,#+0
        BNE.N    ??Int2Str_17
        CBZ      R3,??Int2Str_20
        MOV      R12,#+10
??Int2Str_21:
        SUBS     R3,R3,#+1
//   70   while(e--){
//   71     *p-- = '0'+(n%10); n /= 10;
        SDIV     R2,R1,R12
        MLS      R1,R2,R12,R1
        ADDS     R1,R1,#+48
        STRB     R1,[R0], #-1
        MOVS     R1,R2
//   72     if((Mode != STD)&&(m > 0)&&(i == e)) *p-- = '.';
        CMP      LR,#+2
        BEQ.N    ??Int2Str_22
        CMP      R5,#+1
        BLT.N    ??Int2Str_22
        UXTB     R3,R3
        CMP      R6,R3
        BNE.N    ??Int2Str_22
        MOVS     R2,#+46
        STRB     R2,[R0], #-1
//   73 //    if((m > 0)&&(i == e)) *p-- = '.';
//   74   }
??Int2Str_22:
        UXTB     R3,R3
        CMP      R3,#+0
        BNE.N    ??Int2Str_21
//   75   if((Mode != STD)&&(m == 0)) *p-- = '.';
??Int2Str_20:
        CMP      LR,#+2
        BEQ.N    ??Int2Str_23
        CBNZ     R5,??Int2Str_3
        MOVS     R1,#+46
        STRB     R1,[R0], #-1
        B.N      ??Int2Str_3
??Int2Str_23:
        CBNZ     R5,??Int2Str_3
//   76   if((Mode == STD)&&(m == 0)) *p-- = ' ';
        MOVS     R1,#+32
        STRB     R1,[R0], #-1
??Int2Str_3:
        ADD      SP,SP,#+8
        CFI CFA R13+24
        POP      {R4-R8,PC}       ;; return
        CFI EndBlock cfiBlock2
//   77 }
//   78 /*******************************************************************************
//   79  Int32String_sign:带符号32位数转3位有效数字字符串  
//   80 ******************************************************************************
//   81 void Int32String_sign(I32STR_RES *r, s32 n)
//   82 {
//   83   u32 i, m, c, e=3, fixlen;
//   84   u8 *p = r->str;
//   85   
//   86   fixlen = e+2;
//   87   if(n == 0x80000000){
//   88     *p++ = ' ';
//   89     *p++ = '.';
//   90     *p++ = ' ';
//   91     *p++ = ' ';
//   92     *p++ = ' ';
//   93     *p = 0;
//   94     r->decPos = 4;
//   95     r->len = p-r->str;
//   96     return;
//   97   }
//   98   if ( n == 0 ) {
//   99     *p++ = '+';
//  100     *p++ = '0';
//  101     *p++ = '.';
//  102     *p++ = '0';
//  103     *p++ = '0';
//  104     *p = 0;
//  105     r->decPos = 0;
//  106     r->len = p-r->str;
//  107     return;
//  108   }  
//  109   if ( n > 0 ) *p++ = '+';
//  110   else {
//  111     *p++ = '-';
//  112     n = -n;
//  113   }
//  114   m = n;
//  115   i = 0;
//  116   c = 5;
//  117   while ( m >= 10 ) {
//  118     m /= 10;
//  119     if ( ++i > e ) c *= 10;
//  120   }
//  121   if ( i >= e ) n += c;
//  122   m = n;
//  123   i = 0;
//  124   while ( m >= 10 ) {
//  125     m /= 10;
//  126     i++;
//  127   }
//  128   r->decPos = i/3;   
//  129   switch ( i ) {
//  130   case 9:
//  131     *p++ = '0'+n/1000000000;
//  132     if ( --e == 0 ) break;
//  133     n %= 1000000000;
//  134     *p++ = '.', i = 0;
//  135   case 8:
//  136     *p++ = '0'+n/100000000;
//  137     if ( --e == 0 ) break;
//  138     n %= 100000000;
//  139   case 7:
//  140     *p++ = '0'+n/10000000;
//  141     if ( --e == 0 ) break;
//  142     n %= 10000000;
//  143   case 6:
//  144     *p++ = '0'+n/1000000;
//  145     if ( --e == 0 ) break;
//  146     n %= 1000000;
//  147     if ( i ) *p++ = '.', i = 0;
//  148   case 5:
//  149     *p++ = '0'+n/100000;
//  150     if ( --e == 0 ) break;
//  151     n %= 100000;
//  152   case 4:
//  153     *p++ = '0'+n/10000;
//  154     if ( --e == 0 ) break;
//  155     n %= 10000;
//  156   case 3:
//  157     *p++ = '0'+n/1000;
//  158     if ( --e == 0 ) break;
//  159     n %= 1000;
//  160     if ( i ) *p++ = '.', i = 0;
//  161   case 2:
//  162     *p++ = '0'+n/100;
//  163     if ( --e == 0 ) break;
//  164     n %= 100;
//  165   case 1:
//  166     *p++ = '0'+n/10;
//  167     if ( --e == 0 ) break;
//  168     n %= 10;
//  169   case 0:
//  170     *p++ = '0'+n;
//  171   }
//  172   while ( p < r->str+fixlen )  *p++ = ' ';
//  173   *p = 0;
//  174   r->len = p-r->str;
//  175 }*/
//  176 /*******************************************************************************
//  177  Int32String:无符号32位数转e位有效数字字符串  
//  178 ******************************************************************************
//  179 void Int32String(I32STR_RES *r, u32 n, u32 e)
//  180 {
//  181   u32 i, m, c, fixlen;
//  182   u8 *p = r->str;
//  183 
//  184 //  fixlen = e+2;
//  185   fixlen = e+1;
//  186   if(n == 0x80000000){
//  187     *p++ = ' ';
//  188     *p++ = '.';
//  189     *p++ = ' ';
//  190     *p++ = ' ';
//  191     *p++ = ' ';
//  192     *p = 0;
//  193     r->decPos = 4;
//  194     r->len = p-r->str;
//  195     return;
//  196   }
//  197   if ( n == 0 ) {
//  198     *p++ = '0';
//  199     *p++ = '.';
//  200     *p++ = '0';
//  201     *p++ = '0';
//  202     *p++ = '0';
//  203     *p = 0;
//  204     r->decPos = 0;
//  205     r->len = p-r->str;
//  206     return;
//  207   }  
//  208   m = n;
//  209   i = 0;
//  210   c = 5;
//  211   while ( m >= 10 ) {
//  212     m /= 10;
//  213     if ( ++i > e ) c *= 10;
//  214   }
//  215   if ( i >= e ) n += c;
//  216   m = n;
//  217   i = 0;
//  218   while ( m >= 10 ) {
//  219     m /= 10;
//  220     i++;
//  221   }
//  222   r->decPos = i/3;   
//  223   switch ( i ) {
//  224   case 9:
//  225     *p++ = '0'+n/1000000000;
//  226     if ( --e == 0 ) break;
//  227     n %= 1000000000;
//  228     *p++ = '.', i = 0;
//  229   case 8:
//  230     *p++ = '0'+n/100000000;
//  231     if ( --e == 0 ) break;
//  232     n %= 100000000;
//  233   case 7:
//  234     *p++ = '0'+n/10000000;
//  235     if ( --e == 0 ) break;
//  236     n %= 10000000;
//  237   case 6:
//  238     *p++ = '0'+n/1000000;
//  239     if ( --e == 0 ) break;
//  240     n %= 1000000;
//  241     if ( i ) *p++ = '.', i = 0;
//  242   case 5:
//  243     *p++ = '0'+n/100000;
//  244     if ( --e == 0 ) break;
//  245     n %= 100000;
//  246   case 4:
//  247     *p++ = '0'+n/10000;
//  248     if ( --e == 0 ) break;
//  249     n %= 10000;
//  250   case 3:
//  251     *p++ = '0'+n/1000;
//  252     if ( --e == 0 ) break;
//  253     n %= 1000;
//  254     if ( i ) *p++ = '.', i = 0;
//  255   case 2:
//  256     *p++ = '0'+n/100;
//  257     if ( --e == 0 ) break;
//  258     n %= 100;
//  259   case 1:
//  260     *p++ = '0'+n/10;
//  261     if ( --e == 0 ) break;
//  262     n %= 10;
//  263   case 0:
//  264     *p++ = '0'+n;
//  265   }
//  266   while ( p < r->str+fixlen )  *p++ = ' ';
//  267   *p = 0;
//  268   r->len = p-r->str;
//  269 }
//  270 */
//  271 /*******************************************************************************
//  272  Two ASCII character Change to 1 Byte HEX data 
//  273 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Str2Byte
        THUMB
//  274 u8 Str2Byte(u8 x,u8 y) // 双ASCII字符转1字节二进制数
//  275 {
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
//  276   uc8 Hexcode[17]="0123456789ABCDEF";
        ADD      R0,SP,#+0
        LDR.N    R1,??Str2Byte_0  ;; `?<Constant "0123456789ABCDEF">`
        MOVS     R2,#+17
        BL       __aeabi_memcpy
//  277   u8 i, Temp=0;
        MOVS     R0,#+0
//  278   
//  279   if(x>='a' && x<='z')  x-=32;     // 小写改大写
        CMP      R5,#+97
        BCC.N    ??Str2Byte_1
        CMP      R5,#+123
        IT       CC 
        SUBCC    R5,R5,#+32
//  280   if(y>='a' && y<='z')  y-=32;     // 小写改大写
??Str2Byte_1:
        CMP      R4,#+97
        BCC.N    ??Str2Byte_2
        CMP      R4,#+123
        IT       CC 
        SUBCC    R4,R4,#+32
//  281   for(i=0;i<16;i++){
??Str2Byte_2:
        ADD      R1,SP,#+0
        MOVS     R2,#+0
        MOVS     R3,#+16
//  282     if(Hexcode[i]==x)  Temp+=i*16; // 将字符转为高4位十六进制数值
??Str2Byte_3:
        LDRB     R12,[R1, #+0]
        UXTB     R5,R5
        CMP      R12,R5
        BNE.N    ??Str2Byte_4
        ADDS     R0,R2,R0
        UXTB     R0,R0
//  283   }
??Str2Byte_4:
        ADDS     R2,R2,#+16
        ADDS     R1,R1,#+1
        SUBS     R3,R3,#+1
        BNE.N    ??Str2Byte_3
//  284   for(i=0;i<16;i++){
        MOVS     R1,#+0
        ADD      R2,SP,#+0
//  285     if(Hexcode[i]==y)  Temp+=i;    // 将字符转为低4位十六进制数值
??Str2Byte_5:
        LDRB     R3,[R2, #+0]
        UXTB     R4,R4
        CMP      R3,R4
        BNE.N    ??Str2Byte_6
        ADDS     R0,R1,R0
        UXTB     R0,R0
//  286   }
??Str2Byte_6:
        ADDS     R1,R1,#+1
        ADDS     R2,R2,#+1
        UXTB     R3,R1
        CMP      R3,#+16
        BCC.N    ??Str2Byte_5
//  287   return Temp;
        ADD      SP,SP,#+20
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        Nop      
        DATA
??Str2Byte_0:
        DC32     `?<Constant "0123456789ABCDEF">`
        CFI EndBlock cfiBlock3
//  288 }
//  289 
//  290 /*******************************************************************************
//  291  u16ToDec5: Change 2 Byte to 5 decimal number string   
//  292 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function u16ToDec5
        THUMB
//  293 void u16ToDec5(u8 *p, u16 n)
//  294 {
//  295     *p++ = '0'+n/10000;
u16ToDec5:
        MOVW     R2,#+10000
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+0]
//  296     n %= 10000;
        MLS      R1,R3,R2,R1
//  297     *p++ = '0'+n/1000;
        UXTH     R1,R1
        MOV      R2,#+1000
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+1]!
//  298     n %= 1000;
        MLS      R1,R3,R2,R1
//  299     *p++ = '0'+n/100;
        UXTH     R1,R1
        MOVS     R2,#+100
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+1]!
//  300     n %= 100;
        MLS      R1,R3,R2,R1
//  301     *p++ = '0'+n/10;
        UXTH     R1,R1
        MOVS     R2,#+10
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+1]!
//  302     n %= 10;
        MLS      R1,R3,R2,R1
//  303     *p++ = '0'+n;
        ADDS     R1,R1,#+48
        STRB     R1,[R0, #+1]!
//  304     *p = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]!
//  305 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  306 /*******************************************************************************
//  307  u8ToDec3: Change Byte to 3 decimal number string   
//  308 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function u8ToDec3
        THUMB
//  309 void u8ToDec3(u8 *p, u8 n)
//  310 {
//  311     *p++ = '0'+n/100;
u8ToDec3:
        MOVS     R2,#+100
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+0]
//  312     n %= 100;
        MLS      R1,R3,R2,R1
//  313     *p++ = '0'+n/10;
        UXTB     R1,R1
        MOVS     R2,#+10
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+1]!
//  314     n %= 10;
        MLS      R1,R3,R2,R1
//  315     *p++ = '0'+n;
        ADDS     R1,R1,#+48
        STRB     R1,[R0, #+1]!
//  316     *p = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]!
//  317 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  318 /*******************************************************************************
//  319  s8ToPercen: Change sign char to +(-)x.xx string   
//  320 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function s8ToPercen
        THUMB
//  321 void s8ToPercen(u8 *p, s8 n)
//  322 {
//  323     if(n >= 0)  *p++ = '+';
s8ToPercen:
        CMP      R1,#+0
        BMI.N    ??s8ToPercen_0
        MOVS     R2,#+43
        STRB     R2,[R0], #+1
        B.N      ??s8ToPercen_1
//  324     else {
//  325       *p++ = '-';
??s8ToPercen_0:
        MOVS     R2,#+45
        STRB     R2,[R0], #+1
//  326       n = -n;
        MOVS     R2,R1
        RSBS     R1,R2,#+0
//  327     }
//  328     *p++ = '0'+n/100;
??s8ToPercen_1:
        SXTB     R1,R1
        MOVS     R2,#+100
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+0]
//  329     n %= 100;
        MLS      R1,R3,R2,R1
//  330     *p++ = '.';
        MOVS     R2,#+46
        STRB     R2,[R0, #+1]!
//  331     *p++ = '0'+n/10;
        SXTB     R1,R1
        MOVS     R2,#+10
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+1]!
//  332     n %= 10;
        MLS      R1,R3,R2,R1
//  333     *p++ = '0'+n;
        ADDS     R1,R1,#+48
        STRB     R1,[R0, #+1]!
//  334     *p = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]!
//  335 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  336 /*******************************************************************************
//  337  u8ToDec2: Change Byte to 2 decimal number string   
//  338 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function u8ToDec2
        THUMB
//  339 void u8ToDec2(u8 *p, u8 n)
//  340 {
//  341 //    *p++ = '0'+n/100;
//  342     n %= 100;
u8ToDec2:
        MOVS     R2,#+100
        SDIV     R3,R1,R2
        MLS      R1,R3,R2,R1
//  343     *p++ = '0'+n/10;
        UXTB     R1,R1
        MOVS     R2,#+10
        SDIV     R3,R1,R2
        ADD      R12,R3,#+48
        STRB     R12,[R0, #+0]
//  344     n %= 10;
        MLS      R1,R3,R2,R1
//  345     *p++ = '0'+n;
        ADDS     R1,R1,#+48
        STRB     R1,[R0, #+1]!
//  346     *p = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]!
//  347 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  348 /*******************************************************************************
//  349  Char2Hex: Change Byte to 2 hex number string  
//  350 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function Char2Hex
        THUMB
//  351 void Char2Hex(u8 *p, u8 n)
//  352 {
//  353     if(n/16>9) *p++ = 'A'+(n/16-10);
Char2Hex:
        LSRS     R2,R1,#+4
        CMP      R2,#+10
        ITTEE    CC 
        ADDCC    R3,R2,#+48
        STRBCC   R3,[R0], #+1
        ADDCS    R3,R2,#+55
        STRBCS   R3,[R0], #+1
//  354     else       *p++ = '0'+n/16;
//  355     n %= 16;
        SUB      R1,R1,R2, LSL #+4
//  356     if(n>9)    *p++ = 'A'+(n-10);
        UXTB     R1,R1
        CMP      R1,#+10
        BCC.N    ??Char2Hex_0
        ADDS     R1,R1,#+55
        STRB     R1,[R0], #+1
        B.N      ??Char2Hex_1
//  357     else       *p++ = '0'+n;
??Char2Hex_0:
        ADDS     R1,R1,#+48
        STRB     R1,[R0], #+1
//  358     *p = 0;
??Char2Hex_1:
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  359 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  360 /*******************************************************************************
//  361  Shor2Hex: Change 2Bytes to 4 hex number string  
//  362 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function Shor2Hex
        THUMB
//  363 void Shor2Hex(u8 *p, u16 n)
//  364 {
//  365     if(n/0x1000 >9) *p++ = 'A'+(n/0x1000-10);
Shor2Hex:
        LSRS     R2,R1,#+12
        MOVS     R3,R2
        CMP      R3,#+10
        BCC.N    ??Shor2Hex_0
        ADDS     R3,R3,#+55
        STRB     R3,[R0], #+1
        B.N      ??Shor2Hex_1
//  366     else            *p++ = '0'+ n/0x1000;
??Shor2Hex_0:
        ADDS     R3,R3,#+48
        STRB     R3,[R0], #+1
//  367     n %= 0x1000;
??Shor2Hex_1:
        SUB      R1,R1,R2, LSL #+12
//  368     if(n/0x100 >9)  *p++ = 'A'+(n/0x100-10);
        UXTH     R1,R1
        LSRS     R2,R1,#+8
        MOVS     R3,R2
        CMP      R3,#+10
        BCC.N    ??Shor2Hex_2
        ADDS     R3,R3,#+55
        STRB     R3,[R0], #+1
        B.N      ??Shor2Hex_3
//  369     else            *p++ = '0'+ n/0x100;
??Shor2Hex_2:
        ADDS     R3,R3,#+48
        STRB     R3,[R0], #+1
//  370     n %= 0x100;
??Shor2Hex_3:
        SUB      R1,R1,R2, LSL #+8
//  371     if(n/0x10 >9)   *p++ = 'A'+(n/0x10-10);
        UXTH     R1,R1
        LSRS     R2,R1,#+4
        CMP      R2,#+10
        BCC.N    ??Shor2Hex_4
        MOVS     R3,R2
        ADDS     R3,R3,#+55
        STRB     R3,[R0], #+1
        B.N      ??Shor2Hex_5
//  372     else            *p++ = '0'+ n/0x10;
??Shor2Hex_4:
        MOVS     R3,R2
        ADDS     R3,R3,#+48
        STRB     R3,[R0], #+1
//  373     n %= 0x10;
??Shor2Hex_5:
        SUB      R1,R1,R2, LSL #+4
//  374     if(n >9)        *p++ = 'A'+(n-10);
        UXTH     R1,R1
        CMP      R1,#+10
        BCC.N    ??Shor2Hex_6
        ADDS     R1,R1,#+55
        STRB     R1,[R0], #+1
        B.N      ??Shor2Hex_7
//  375     else            *p++ = '0'+n;
??Shor2Hex_6:
        ADDS     R1,R1,#+48
        STRB     R1,[R0], #+1
//  376     *p = 0;
??Shor2Hex_7:
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  377 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//  378 /*******************************************************************************
//  379  Word2Hex: Change 4 Bytes to 8 hex number string  
//  380 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function Word2Hex
        THUMB
//  381 void Word2Hex(u8 *p, u32 n)
//  382 {
//  383     if(n/0x10000000>9) *p++ = 'A'+(n/0x10000000-10);
Word2Hex:
        LSRS     R2,R1,#+28
        CMP      R2,#+10
        BCC.N    ??Word2Hex_0
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_1
//  384     else               *p++ = '0'+ n/0x10000000;
??Word2Hex_0:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  385     n %= 0x10000000;
??Word2Hex_1:
        LSLS     R1,R1,#+4
        LSRS     R1,R1,#+4
//  386     if(n/0x01000000>9) *p++ = 'A'+(n/0x01000000-10);
        LSRS     R2,R1,#+24
        CMP      R2,#+10
        BCC.N    ??Word2Hex_2
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_3
//  387     else               *p++ = '0'+ n/0x01000000;
??Word2Hex_2:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  388     n %= 0x01000000;
??Word2Hex_3:
        LSLS     R1,R1,#+8
        LSRS     R1,R1,#+8
//  389     if(n/0x00100000>9) *p++ = 'A'+(n/0x00100000-10);
        LSRS     R2,R1,#+20
        CMP      R2,#+10
        BCC.N    ??Word2Hex_4
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_5
//  390     else               *p++ = '0'+ n/0x00100000;
??Word2Hex_4:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  391     n %= 0x00100000;
??Word2Hex_5:
        LSLS     R1,R1,#+12
        LSRS     R1,R1,#+12
//  392     if(n/0x00010000>9) *p++ = 'A'+(n/0x00010000-10);
        LSRS     R2,R1,#+16
        CMP      R2,#+10
        BCC.N    ??Word2Hex_6
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_7
//  393     else               *p++ = '0'+ n/0x00010000;
??Word2Hex_6:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  394     n %= 0x00010000;
??Word2Hex_7:
        UXTH     R1,R1
//  395     if(n/0x00001000>9) *p++ = 'A'+(n/0x00001000-10);
        LSRS     R2,R1,#+12
        CMP      R2,#+10
        BCC.N    ??Word2Hex_8
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_9
//  396     else               *p++ = '0'+ n/0x00001000;
??Word2Hex_8:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  397     n %= 0x00001000;
??Word2Hex_9:
        LSLS     R1,R1,#+20
        LSRS     R1,R1,#+20
//  398     if(n/0x00000100>9) *p++ = 'A'+(n/0x00000100-10);
        LSRS     R2,R1,#+8
        CMP      R2,#+10
        BCC.N    ??Word2Hex_10
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_11
//  399     else               *p++ = '0'+ n/0x00000100;
??Word2Hex_10:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  400     n %= 0x00000100;
??Word2Hex_11:
        UXTB     R1,R1
//  401     if(n/0x00000010>9) *p++ = 'A'+(n/0x00000010-10);
        LSRS     R2,R1,#+4
        CMP      R2,#+10
        BCC.N    ??Word2Hex_12
        ADDS     R2,R2,#+55
        STRB     R2,[R0], #+1
        B.N      ??Word2Hex_13
//  402     else               *p++ = '0'+ n/0x00000010;
??Word2Hex_12:
        ADDS     R2,R2,#+48
        STRB     R2,[R0], #+1
//  403     n %= 0x00000010;
??Word2Hex_13:
        AND      R1,R1,#0xF
//  404     if(n/0x00000001>9) *p++ = 'A'+(n/0x00000001-10);
        CMP      R1,#+10
        BCC.N    ??Word2Hex_14
        ADDS     R1,R1,#+55
        STRB     R1,[R0], #+1
        B.N      ??Word2Hex_15
//  405     else               *p++ = '0'+ n/0x00000001;
??Word2Hex_14:
        ADDS     R1,R1,#+48
        STRB     R1,[R0], #+1
//  406     n %= 0x10000000;
//  407     *p = 0;
??Word2Hex_15:
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  408 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  409 /*******************************************************************************
//  410  Int_sqrt: unsigned int square root
//  411 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function Int_sqrt
        THUMB
//  412 u32 Int_sqrt(u32 n)
//  413 { u32 k;
Int_sqrt:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        MOVS     R4,R0
//  414   if ( n == 0 ) return 0;
        BNE.N    ??Int_sqrt_0
        MOVS     R0,#+0
        POP      {R4,PC}
//  415   k = 2*Int_sqrt(n/4)+1;
??Int_sqrt_0:
        LSRS     R0,R4,#+2
        BL       Int_sqrt
        LSLS     R0,R0,#+1
        ADDS     R0,R0,#+1
//  416   if ( k*k > n ) return k-1;
        MUL      R1,R0,R0
        CMP      R4,R1
        IT       CC 
        SUBCC    R0,R0,#+1
//  417   else return k;
??Int_sqrt_1:
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock11
//  418 }
//  419 /*******************************************************************************
//  420 Read_Keys:    Key status process                                Return: KeyCode
//  421 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function Read_Keys
        THUMB
//  422 u8 Read_Keys(void)
//  423 {
Read_Keys:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  424   u16 Key_Status, Key_Status_Now;
//  425   u8  KeyCode=0;
        MOVS     R4,#+0
//  426   
//  427   Key_Status_Now = ~__Get(KEY_STATUS);//~KeyScan();
        MOVS     R0,#+4
        BL       __Get
        MVNS     R0,R0
        UXTH     R0,R0
//  428   Key_Status = Key_Status_Now &(~Key_Status_Last);
        LDR.N    R1,??Read_Keys_0  ;; Key_Status_Last
        MOVS     R2,R0
        LDRH     R3,[R1, #+0]
        MVNS     R3,R3
        ANDS     R2,R3,R2
//  429   if(Key_Status){                               // New key push on
        BEQ.N    ??Read_Keys_1
//  430     Key_Wait_Cnt=25;                        // Close auto repeat 500mS
        LDR.N    R3,??Read_Keys_0+0x4  ;; Key_Wait_Cnt
        MOV      R12,#+25
        STRB     R12,[R3, #+0]
//  431     if(Key_Status & K_ITEM_D_STATUS)   KeyCode = K_ITEM_DEC;    // K9
        TST      R2,#0x8
        IT       NE 
        MOVNE    R4,#+9
//  432     if(Key_Status & K_ITEM_S_STATUS)   KeyCode = K_ITEM_S;      // K10
        TST      R2,#0x40
        IT       NE 
        MOVNE    R4,#+10
//  433     if(Key_Status & KEY3_STATUS)       KeyCode = KEY3;          // K3 
        TST      R2,#0x100
        IT       NE 
        MOVNE    R4,#+3
//  434     if(Key_Status & KEY4_STATUS)       KeyCode = KEY4;          // K4 
        TST      R2,#0x200
        IT       NE 
        MOVNE    R4,#+4
//  435     if(Key_Status & K_INDEX_D_STATUS)  KeyCode = K_INDEX_DEC;   // K5 
        TST      R2,#0x400
        IT       NE 
        MOVNE    R4,#+5
//  436     if(Key_Status & K_INDEX_I_STATUS)  KeyCode = K_INDEX_INC;   // K6  
        TST      R2,#0x800
        IT       NE 
        MOVNE    R4,#+6
//  437     if(Key_Status & K_INDEX_S_STATUS)  KeyCode = K_INDEX_S;     // K7  
        TST      R2,#0x1000
        IT       NE 
        MOVNE    R4,#+7
//  438     if(Key_Status & KEY2_STATUS)       KeyCode = KEY2;          // K2
        TST      R2,#0x2000
        IT       NE 
        MOVNE    R4,#+2
//  439     if(Key_Status & KEY1_STATUS)       KeyCode = KEY_P;         // K1
        TST      R2,#0x4000
        IT       NE 
        MOVNE    R4,#+1
//  440     if(Key_Status & K_ITEM_I_STATUS)   KeyCode = K_ITEM_INC;    // K8
        TST      R2,#0x8000
        BEQ.N    ??Read_Keys_2
        MOVS     R4,#+8
        B.N      ??Read_Keys_2
//  441   } else {
//  442     if(Key_Status_Now & Key_Status_Last){       // Key push hold on
??Read_Keys_1:
        LDRH     R2,[R1, #+0]
        TST      R0,R2
        BEQ.N    ??Read_Keys_2
//  443       if((Key_Wait_Cnt || Key_Repeat_Cnt)==0){
        LDR.N    R2,??Read_Keys_0+0x4  ;; Key_Wait_Cnt
        LDRB     R2,[R2, #+0]
        CBNZ     R2,??Read_Keys_2
        LDR.N    R2,??Read_Keys_0+0x8  ;; Key_Repeat_Cnt
        LDRB     R3,[R2, #+0]
        CBNZ     R3,??Read_Keys_2
//  444         if(Key_Status_Now & K_INDEX_D_STATUS)  KeyCode = K_INDEX_DEC;    // K5 
        TST      R0,#0x400
        IT       NE 
        MOVNE    R4,#+5
//  445         if(Key_Status_Now & K_INDEX_I_STATUS)  KeyCode = K_INDEX_INC;    // K6
        TST      R0,#0x800
        IT       NE 
        MOVNE    R4,#+6
//  446         if(Key_Status_Now & K_ITEM_D_STATUS)   KeyCode = K_ITEM_DEC;     // K9 
        TST      R0,#0x8
        IT       NE 
        MOVNE    R4,#+9
//  447         if(Key_Status_Now & K_ITEM_I_STATUS)   KeyCode = K_ITEM_INC;     // K8 
        TST      R0,#0x8000
        IT       NE 
        MOVNE    R4,#+8
//  448         Key_Repeat_Cnt = 5;                 // Auto repeat per 100mS
        MOVS     R3,#+5
        STRB     R3,[R2, #+0]
//  449       }
//  450     }
//  451   }
//  452   Key_Status_Last = Key_Status_Now;
??Read_Keys_2:
        STRH     R0,[R1, #+0]
//  453   return KeyCode;
        MOVS     R0,R4
        POP      {R4,PC}          ;; return
        Nop      
        DATA
??Read_Keys_0:
        DC32     Key_Status_Last
        DC32     Key_Wait_Cnt
        DC32     Key_Repeat_Cnt
        CFI EndBlock cfiBlock12
//  454 } 

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "0123456789ABCDEF">`:
        DATA
        DC8 "0123456789ABCDEF"
        DC8 0, 0, 0

        END
//  455 
//  456 /********************************* END OF FILE ********************************/
// 
//     4 bytes in section .bss
//    20 bytes in section .rodata
// 1 328 bytes in section .text
// 
// 1 328 bytes of CODE  memory
//    20 bytes of CONST memory
//     4 bytes of DATA  memory
//
//Errors: none
//Warnings: none
