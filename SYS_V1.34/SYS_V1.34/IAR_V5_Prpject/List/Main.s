///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  14:17:16 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\SYS_V1.34\source\Main.c                       /
//    Command line =  E:\DS0203\SYS_V1.34\source\Main.c -lA                   /
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
//    List file    =  E:\DS0203\SYS_V1.34\IAR_V5_Prpject\List\Main.s          /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Main

        EXTERN ADC_Config
        EXTERN Add_Lic
        EXTERN Beep
        EXTERN Clear_Screen
        EXTERN DAC_Config
        EXTERN DMA_Config
        EXTERN Display_Logo
        EXTERN Display_Str
        EXTERN FSMC_Config
        EXTERN GPIO_Config
        EXTERN Get_Lic
        EXTERN Input_Lic
        EXTERN Key_Buffer
        EXTERN LCD_Initial
        EXTERN NVIC_Config
        EXTERN SPI_Config
        EXTERN Set_System
        EXTERN Timer_Config
        EXTERN USB_Init
        EXTERN Word2Hex
        EXTERN __Chk_SYS
        EXTERN __Dev_SN
        EXTERN __MSR_MSP

        PUBLIC JumpAddr
        PUBLIC Jump_To_App
        PUBLIC main
        
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
        
// E:\DS0203\SYS_V1.34\source\Main.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : main.c  
//    3  Version   : DS203_SYS Ver 1.3x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include "SPI_flash.h"
//    6 #include "Function.h"
//    7 #include "USB_lib.h"
//    8 #include "Config.h"
//    9 #include "Ident.h"
//   10 #include "BIOS.h"
//   11 #include "LCD.h"
//   12 #include "ASM.h"
//   13 #include "USB_pwr.h"
//   14 
//   15 typedef  void (*pFunc)(void);
//   16 

        SECTION `.bss`:DATA:NOROOT(2)
//   17 pFunc Jump_To_App;
Jump_To_App:
        DS8 4
//   18 u32 JumpAddr;
JumpAddr:
        DS8 4
//   19 
//   20 /*******************************************************************************
//   21   版本修改说明
//   22 SYS V1.24: 修改了144MHz交替采样模式下的插值系数(BIOS.C)
//   23            修改了V2.6硬件电路下模拟输入量程档位(BIOS.C)
//   24 SYS V1.30: 将Licence识别函数转移到了DFU模块中(ASM.s,Ident.c)
//   25            修改了Licence权限控制力度(Main.c, Ident.c)
//   26            修改了DFU,SYS库函数向量及其调用方式(ASM.s, VECTOR.c)
//   27            添加了新的SYS库函数(BIOS.C)
//   28 SYS V1.31: 将内部U盘的初始化推迟到Licence识别后进行(Main.c,Config.c)
//   29            修改了U盘扇区读写程序(SPI_flash.c)
//   30            修改了SYS库函数向量表存放起始地址
//   31 SYS V1.32: 修改了Set(T_BASE_ARR, Value)函数中的BUG(BIOS.C)
//   32 SYS V1.33: 增加了对LCD控制芯片ILI9327与R61509V的兼容和自动识别(LCD.c, ASM.s)
//   33 SYS V1.34: 从该版本起 可并行使用 IAR 4.42与５.０版本 增加了文件夹　IAR_V5_Prpject
//   34           修改了ASM.s文件
//   35           
//   36 
//   37 *******************************************************************************/
//   38 
//   39 /*******************************************************************************
//   40   main : Main routine.
//   41 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function main
        THUMB
//   42 int main(void)
//   43 { 
main:
        PUSH     {R4-R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI R7 Frame(CFA, -8)
        CFI R6 Frame(CFA, -12)
        CFI R5 Frame(CFA, -16)
        CFI R4 Frame(CFA, -20)
        CFI CFA R13+20
        SUB      SP,SP,#+12
        CFI CFA R13+32
//   44   u32 Licence;
//   45   u8  NumStr[9];
//   46   
//   47   Set_System();
        BL       Set_System
//   48   NVIC_Config();
        BL       NVIC_Config
//   49   GPIO_Config();
        BL       GPIO_Config
//   50   Timer_Config();
        BL       Timer_Config
//   51   FSMC_Config();
        BL       FSMC_Config
//   52   SPI_Config();
        BL       SPI_Config
//   53 
//   54   DMA_Config();
        BL       DMA_Config
//   55   ADC_Config();
        BL       ADC_Config
//   56   DAC_Config();
        BL       DAC_Config
//   57   
//   58   Beep(20, 500); 
        MOV      R1,#+500
        MOVS     R0,#+20
        BL       Beep
//   59   LCD_Initial();
        BL       LCD_Initial
//   60   Clear_Screen(0x0000);
        MOVS     R0,#+0
        BL       Clear_Screen
//   61 
//   62   Display_Logo(70,150); 
        MOVS     R1,#+150
        MOVS     R0,#+70
        BL       Display_Logo
//   63   
//   64   Display_Str( 6*8, 90, GRN, PRN,  HDW_VERSION );
        LDR.N    R4,??main_0      ;; `?<Constant "Hardware Ver 2.6  ">`
        PUSH     {R4,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
        MOVS     R1,#+90
        MOVS     R0,#+48
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   65   Display_Str(24*8, 90, GRN, PRN, "Serial No: ");
        ADD      R0,R4,#+20
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
        MOVS     R1,#+90
        MOVS     R0,#+192
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   66   Word2Hex(NumStr, __Dev_SN());            
        BL       __Dev_SN
        MOVS     R1,R0
        ADD      R0,SP,#+0
        BL       Word2Hex
//   67   Display_Str(35*8, 90, YEL, PRN, NumStr);    // 显示读取到的设备序列号
        MOVW     R5,#+2047
        ADD      R0,SP,#+0
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOVS     R2,R5
        MOVS     R1,#+90
        MOV      R0,#+280
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   68   Display_Str(6*8, 70, GRN, PRN,   SYS_VERSION);
        ADD      R0,R4,#+32
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
        MOVS     R1,#+70
        MOVS     R0,#+48
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   69 
//   70   if((KEY2_OFF)&&(KEY3_OFF)&&(KEY4_OFF)){       // 开机无按键按下
        LDR.N    R0,??main_0+0x4  ;; 0x40010804
        LDR      R0,[R0, #+2052]
        TST      R0,#0x400
        BEQ.N    ??main_1
        LDR.N    R0,??main_0+0x4  ;; 0x40010804
        LDR      R0,[R0, #+2052]
        TST      R0,#0x200
        BEQ.N    ??main_1
        LDR.N    R0,??main_0+0x4  ;; 0x40010804
        LDR      R0,[R0, #+2052]
        TST      R0,#0x100
        BEQ.N    ??main_1
//   71     Key_Buffer = 0;                             // 清除按键状态，开始等待新的按键
        LDR.N    R6,??main_0+0x8  ;; Key_Buffer
        MOVS     R0,#+0
        STRB     R0,[R6, #+0]
//   72     Licence = Get_Lic(SYS_LIC_OFFSET);          // Get master licence
        BL       Get_Lic
//   73     if(__Chk_SYS(Licence)!= 1){                 // No master licence 
        BL       __Chk_SYS
        CMP      R0,#+1
        BEQ.N    ??main_2
//   74       Display_Str(6*8,50,GRN,PRN,     "Please input master licence: 00000000");
        ADD      R0,R4,#+72
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
        MOVS     R1,#+50
        MOVS     R0,#+48
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   75       Licence = Input_Lic(48+29*8, 50);         // Input Licence
        MOVS     R1,#+50
        MOV      R0,#+280
        BL       Input_Lic
        MOVS     R7,R0
//   76       if(__Chk_SYS(Licence)!= 1){               // Licence error
        BL       __Chk_SYS
        CMP      R0,#+1
        BEQ.N    ??main_3
//   77         Display_Str(6*8,50,YEL,PRN,   "        Licence input error          ");
        ADD      R0,R4,#+112
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOVS     R2,R5
        B.N      ??main_4
        CFI CFA R13+32
//   78       } else {                                  // Licence ok
//   79         if(Add_Lic(Licence, SYS_LIC_OFFSET)== 1)// Licence writen ok
??main_3:
        MOVS     R1,#+0
        MOVS     R0,R7
        BL       Add_Lic
        CMP      R0,#+1
        BNE.N    ??main_5
//   80           Display_Str(6*8,50,GRN,PRN, "         Licence writen ok           ");
        ADD      R0,R4,#+152
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
        B.N      ??main_4
        CFI CFA R13+32
//   81         else  
//   82           Display_Str(6*8,50,GRN,PRN, "        Licence writen error         ");
??main_5:
        ADD      R0,R4,#+192
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
??main_4:
        MOVS     R1,#+50
        MOVS     R0,#+48
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   83       }
//   84       Display_Str(6*8,30,GRN,PRN,     "      Push any key to next step      ");
        ADD      R0,R4,#+232
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
        MOVS     R1,#+30
        MOVS     R0,#+48
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   85       while (Key_Buffer == 0){};
??main_6:
        LDRB     R0,[R6, #+0]
        CMP      R0,#+0
        BEQ.N    ??main_6
//   86     }
//   87     JumpAddr = *(vu32*) (APP1_BASE + 4);
??main_2:
        LDR.N    R0,??main_0+0xC  ;; 0x800c000
        LDR      R0,[R0, #+4]
        LDR.N    R1,??main_0+0x10  ;; Jump_To_App
        STR      R0,[R1, #+4]
//   88     Jump_To_App = (pFunc) JumpAddr;
        STR      R0,[R1, #+0]
//   89     __MSR_MSP(*(vu32*) APP1_BASE);
        LDR.N    R0,??main_0+0xC  ;; 0x800c000
        B.N      ??main_7
//   90   } else if(KEY2_ON){                           // 开机按下K2键  
??main_1:
        LDR.N    R0,??main_0+0x4  ;; 0x40010804
        LDR      R0,[R0, #+2052]
        TST      R0,#0x400
        BNE.N    ??main_8
//   91     JumpAddr = *(vu32*) (APP2_BASE + 4);
        LDR.N    R0,??main_0+0x14  ;; 0x8014000
        LDR      R0,[R0, #+4]
        LDR.N    R1,??main_0+0x10  ;; Jump_To_App
        STR      R0,[R1, #+4]
//   92     Jump_To_App = (pFunc) JumpAddr;
        STR      R0,[R1, #+0]
//   93     __MSR_MSP(*(vu32*) APP2_BASE);
        LDR.N    R0,??main_0+0x14  ;; 0x8014000
        B.N      ??main_7
//   94   } else if(KEY3_ON){                           // 开机按下K3键 
??main_8:
        LDR.N    R0,??main_0+0x4  ;; 0x40010804
        LDR      R0,[R0, #+2052]
        TST      R0,#0x200
        BNE.N    ??main_9
//   95     JumpAddr = *(vu32*) (APP3_BASE + 4);
        LDR.N    R0,??main_0+0x18  ;; 0x801c000
        LDR      R0,[R0, #+4]
        LDR.N    R1,??main_0+0x10  ;; Jump_To_App
        STR      R0,[R1, #+4]
//   96     Jump_To_App = (pFunc) JumpAddr;
        STR      R0,[R1, #+0]
//   97     __MSR_MSP(*(vu32*) APP3_BASE);
        LDR.N    R0,??main_0+0x18  ;; 0x801c000
        B.N      ??main_7
//   98   } else if(KEY4_ON){                           // 开机按下K4键 
??main_9:
        LDR.N    R0,??main_0+0x4  ;; 0x40010804
        LDR      R0,[R0, #+2052]
        TST      R0,#0x100
        BNE.N    ??main_10
//   99     JumpAddr = *(vu32*) (APP4_BASE + 4);
        LDR.N    R0,??main_0+0x1C  ;; 0x8024000
        LDR      R0,[R0, #+4]
        LDR.N    R1,??main_0+0x10  ;; Jump_To_App
        STR      R0,[R1, #+4]
//  100     Jump_To_App = (pFunc) JumpAddr;
        STR      R0,[R1, #+0]
//  101     __MSR_MSP(*(vu32*) APP4_BASE);
        LDR.N    R0,??main_0+0x1C  ;; 0x8024000
??main_7:
        LDR      R0,[R0, #+0]
        BL       __MSR_MSP
//  102   }
//  103   USB_EN();
??main_10:
        LDR.N    R0,??main_0+0x4  ;; 0x40010804
        LDR.N    R1,??main_0+0x20  ;; 0x888bbbbb
        STR      R1,[R0, #+0]
//  104   USB_Init();  
        BL       USB_Init
//  105   Jump_To_App();
        LDR.N    R0,??main_0+0x10  ;; Jump_To_App
        LDR      R0,[R0, #+0]
        BLX      R0
//  106 }
        MOVS     R0,#+0
        ADD      SP,SP,#+12
        CFI CFA R13+20
        POP      {R4-R7,PC}       ;; return
        Nop      
        DATA
??main_0:
        DC32     `?<Constant "Hardware Ver 2.6  ">`
        DC32     0x40010804
        DC32     Key_Buffer
        DC32     0x800c000
        DC32     Jump_To_App
        DC32     0x8014000
        DC32     0x801c000
        DC32     0x8024000
        DC32     0x888bbbbb
        CFI EndBlock cfiBlock0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "Hardware Ver 2.6  ">`:
        DATA
        DC8 "Hardware Ver 2.6  "
        DC8 0
        DC8 "Serial No: "
        DC8 "     DS203 Mini DSO SYS Ver 1.34       "
        DC8 "Please input master licence: 00000000"
        DC8 0, 0
        DC8 "        Licence input error          "
        DC8 0, 0
        DC8 "         Licence writen ok           "
        DC8 0, 0
        DC8 "        Licence writen error         "
        DC8 0, 0
        DC8 "      Push any key to next step      "
        DC8 0, 0

        END
//  107 /*********************************  END OF FILE  ******************************/
// 
//   8 bytes in section .bss
// 272 bytes in section .rodata
// 508 bytes in section .text
// 
// 508 bytes of CODE  memory
// 272 bytes of CONST memory
//   8 bytes of DATA  memory
//
//Errors: none
//Warnings: none
