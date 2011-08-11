///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:03:39 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\SYS_V1.50\source\Main.c                /
//    Command line =  E:\Mini-DS\DS203\SYS_V1.50\source\Main.c -lA            /
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
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\Main.s   /
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
        EXTERN Get
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
        PUBLIC SYS_Ver
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
        
// E:\Mini-DS\DS203\SYS_V1.50\source\Main.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : main.c  
//    3  Version   : DS203_SYS Ver 1.5x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include "Function.h"
//    6 #include "USB_lib.h"
//    7 #include "Config.h"
//    8 #include "Ident.h"
//    9 #include "BIOS.h"
//   10 #include "LCD.h"
//   11 #include "ASM.h"
//   12 #include "USB_pwr.h"
//   13 
//   14 typedef  void (*pFunc)(void);
//   15 

        SECTION `.bss`:DATA:NOROOT(2)
//   16 pFunc Jump_To_App;
Jump_To_App:
        DS8 4
//   17 u32 JumpAddr;
JumpAddr:
        DS8 4

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "Hardware Ver ">`:
        DATA
        DC8 "Hardware Ver "
        DC8 0, 0
        DC8 "Serial No: "
        DC8 "     DS203 Mini DSO SYS Ver            "
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
//   18 
//   19 /*******************************************************************************
//   20   版本修改说明
//   21 SYS V1.24: 修改了144MHz交替采样模式下的插值系数(BIOS.c)
//   22            修改了V2.6硬件电路下模拟输入量程档位(BIOS.c)
//   23 SYS V1.30: 将Licence识别函数转移到了DFU模块中(ASM.s,Ident.c)
//   24            修改了Licence权限控制力度(Main.c, Ident.c)
//   25            修改了DFU,SYS库函数向量及其调用方式(ASM.s, VECTOR.c)
//   26            添加了新的SYS库函数(BIOS.c)
//   27 SYS V1.31: 将内部U盘的初始化推迟到Licence识别后进行(Main.c,Config.c)
//   28            修改了U盘扇区读写程序(SPI_flash.c)
//   29            修改了SYS库函数向量表存放起始地址
//   30 SYS V1.32: 修改了Set(T_BASE_ARR, Value)函数中的BUG(BIOS.c)
//   31 SYS V1.33: 增加了对LCD控制芯片ILI9327与R61509V的兼容和自动识别(LCD.c, ASM.s)
//   32 SYS V1.34: 从该版本起 可并行使用 IAR 4.42与５.０版本编译环境(ASM.s)
//   33 SYS V1.35: 修改了LCD控制芯片兼容性相关的BUG(ASM.s)         
//   34            增加了设备硬件、SYS固件及DFU版本信息导出(ASM.s, BIOS.c, Main.c)
//   35            增加了高精度的A,B通道垂直偏移设置功能函数(BIOS.c)
//   36 SYS V1.37: 修改了高精度的A,B通道垂直偏移设置功能函数的BUG(BIOS.c)        
//   37            增加了FPGA2.60以上版本的版本信息导出(BIOS.c)
//   38 SYS V1.40: 增加了U盘文件系统读写相关函数(DOSFS.c)        
//   39 SYS V1.41: 修改了读BUF文件时的BUG(DOSFS.c)
//   40 SYS V1.42: 增加了Row_Fill函数(ASM.s)
//   41 SYS V1.50: 重写了新的FAT12文件系统(FAT12.c, ASM.s)
//   42            修改了Flash读写函数避开与PC机的读写冲突(Memory.c, EXT_Flash.c) 
//   43 *******************************************************************************/
//   44 

        SECTION `.rodata`:CONST:NOROOT(2)
//   45 uc8  SYS_Ver[5]  = "1.50"; 
SYS_Ver:
        DATA
        DC8 "1.50"
        DC8 0, 0, 0
//   46 
//   47 /*******************************************************************************
//   48   main : Main routine.
//   49 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function main
        THUMB
//   50 int main(void)
//   51 { 
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
//   52   u32 Licence;
//   53   u8  NumStr[9];
//   54   
//   55   Set_System();
        BL       Set_System
//   56   NVIC_Config();
        BL       NVIC_Config
//   57   GPIO_Config();
        BL       GPIO_Config
//   58   Timer_Config();
        BL       Timer_Config
//   59   FSMC_Config();
        BL       FSMC_Config
//   60   SPI_Config();
        BL       SPI_Config
//   61 
//   62   DMA_Config();
        BL       DMA_Config
//   63   ADC_Config();
        BL       ADC_Config
//   64   DAC_Config();
        BL       DAC_Config
//   65   
//   66   Beep(20, 500); 
        MOV      R1,#+500
        MOVS     R0,#+20
        BL       Beep
//   67   LCD_Initial();
        BL       LCD_Initial
//   68   Clear_Screen(0x0000);
        MOVS     R0,#+0
        BL       Clear_Screen
//   69 
//   70   Display_Logo(70,150); 
        MOVS     R1,#+150
        MOVS     R0,#+70
        BL       Display_Logo
//   71   
//   72   Display_Str( 5*8, 90, GRN, PRN,  "Hardware Ver " );
        LDR.N    R4,??main_0      ;; `?<Constant "Hardware Ver ">`
        PUSH     {R4,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
        MOVS     R1,#+90
        MOVS     R0,#+40
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   73   Display_Str(18*8, 90, GRN, PRN,  (u8*)Get(HDWVER, 0));
        MOVS     R1,#+0
        MOVS     R0,#+13
        BL       Get
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
        MOVS     R1,#+90
        MOVS     R0,#+144
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   74   Display_Str(25*8, 90, GRN, PRN, "Serial No: ");
        ADD      R0,R4,#+16
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
        MOVS     R1,#+90
        MOVS     R0,#+200
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   75   Word2Hex(NumStr, __Dev_SN());            
        BL       __Dev_SN
        MOVS     R1,R0
        ADD      R0,SP,#+0
        BL       Word2Hex
//   76   Display_Str(36*8, 90, YEL, PRN, NumStr);      // 显示读取到的设备序列号
        MOVW     R5,#+2047
        ADD      R0,SP,#+0
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOVS     R2,R5
        MOVS     R1,#+90
        MOV      R0,#+288
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   77 
//   78   Display_Str( 6*8, 70, GRN, PRN, "     DS203 Mini DSO SYS Ver            ");
        ADD      R0,R4,#+28
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
        MOVS     R1,#+70
        MOVS     R0,#+48
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   79   Display_Str(34*8, 70, GRN, PRN, (u8*)Get(SYSVER, 0)); // 显示SYS固件版本号
        MOVS     R1,#+0
        MOVS     R0,#+15
        BL       Get
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
        MOVS     R1,#+70
        MOV      R0,#+272
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   80   
//   81   if((KEY2_OFF)&&(KEY3_OFF)&&(KEY4_OFF)){       // 开机无按键按下
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
//   82     Key_Buffer = 0;                             // 清除按键状态，开始等待新的按键
        LDR.N    R6,??main_0+0x8  ;; Key_Buffer
        MOVS     R0,#+0
        STRB     R0,[R6, #+0]
//   83     Licence = Get_Lic(SYS_LIC_OFFSET);          // Get master licence
        BL       Get_Lic
//   84     if(__Chk_SYS(Licence)!= 1){                 // No master licence 
        BL       __Chk_SYS
        CMP      R0,#+1
        BEQ.N    ??main_2
//   85       Display_Str(6*8,50,GRN,PRN,     "Please input master licence: 00000000");
        ADD      R0,R4,#+68
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
        MOVS     R1,#+50
        MOVS     R0,#+48
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   86       Licence = Input_Lic(48+29*8, 50);         // Input Licence
        MOVS     R1,#+50
        MOV      R0,#+280
        BL       Input_Lic
        MOVS     R7,R0
//   87       if(__Chk_SYS(Licence)!= 1){               // Licence error
        BL       __Chk_SYS
        CMP      R0,#+1
        BEQ.N    ??main_3
//   88         Display_Str(6*8,50,YEL,PRN,   "        Licence input error          ");
        ADD      R0,R4,#+108
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOVS     R2,R5
        B.N      ??main_4
        CFI CFA R13+32
//   89       } else {                                  // Licence ok
//   90         if(Add_Lic(Licence, SYS_LIC_OFFSET)== 1)// Licence writen ok
??main_3:
        MOVS     R1,#+0
        MOVS     R0,R7
        BL       Add_Lic
        CMP      R0,#+1
        BNE.N    ??main_5
//   91           Display_Str(6*8,50,GRN,PRN, "         Licence writen ok           ");
        ADD      R0,R4,#+148
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
        B.N      ??main_4
        CFI CFA R13+32
//   92         else  
//   93           Display_Str(6*8,50,GRN,PRN, "        Licence writen error         ");
??main_5:
        ADD      R0,R4,#+188
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
//   94       }
//   95       Display_Str(6*8,30,GRN,PRN,     "      Push any key to next step      ");
        ADD      R0,R4,#+228
        PUSH     {R0,LR}
        CFI CFA R13+40
        MOVS     R3,#+0
        MOV      R2,#+2016
        MOVS     R1,#+30
        MOVS     R0,#+48
        BL       Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+32
//   96       while (Key_Buffer == 0){};
??main_6:
        LDRB     R0,[R6, #+0]
        CMP      R0,#+0
        BEQ.N    ??main_6
//   97     }
//   98     JumpAddr = *(vu32*) (APP1_BASE + 4);
??main_2:
        LDR.N    R0,??main_0+0xC  ;; 0x800c000
        LDR      R0,[R0, #+4]
        LDR.N    R1,??main_0+0x10  ;; Jump_To_App
        STR      R0,[R1, #+4]
//   99     Jump_To_App = (pFunc) JumpAddr;
        STR      R0,[R1, #+0]
//  100     __MSR_MSP(*(vu32*) APP1_BASE);
        LDR.N    R0,??main_0+0xC  ;; 0x800c000
        B.N      ??main_7
//  101   } else if(KEY2_ON){                           // 开机按下K2键  
??main_1:
        LDR.N    R0,??main_0+0x4  ;; 0x40010804
        LDR      R0,[R0, #+2052]
        TST      R0,#0x400
        BNE.N    ??main_8
//  102     JumpAddr = *(vu32*) (APP2_BASE + 4);
        LDR.N    R0,??main_0+0x14  ;; 0x8014000
        LDR      R0,[R0, #+4]
        LDR.N    R1,??main_0+0x10  ;; Jump_To_App
        STR      R0,[R1, #+4]
//  103     Jump_To_App = (pFunc) JumpAddr;
        STR      R0,[R1, #+0]
//  104     __MSR_MSP(*(vu32*) APP2_BASE);
        LDR.N    R0,??main_0+0x14  ;; 0x8014000
        B.N      ??main_7
//  105   } else if(KEY3_ON){                           // 开机按下K3键 
??main_8:
        LDR.N    R0,??main_0+0x4  ;; 0x40010804
        LDR      R0,[R0, #+2052]
        TST      R0,#0x200
        BNE.N    ??main_9
//  106     JumpAddr = *(vu32*) (APP3_BASE + 4);
        LDR.N    R0,??main_0+0x18  ;; 0x801c000
        LDR      R0,[R0, #+4]
        LDR.N    R1,??main_0+0x10  ;; Jump_To_App
        STR      R0,[R1, #+4]
//  107     Jump_To_App = (pFunc) JumpAddr;
        STR      R0,[R1, #+0]
//  108     __MSR_MSP(*(vu32*) APP3_BASE);
        LDR.N    R0,??main_0+0x18  ;; 0x801c000
        B.N      ??main_7
//  109   } else if(KEY4_ON){                           // 开机按下K4键 
??main_9:
        LDR.N    R0,??main_0+0x4  ;; 0x40010804
        LDR      R0,[R0, #+2052]
        TST      R0,#0x100
        BNE.N    ??main_10
//  110     JumpAddr = *(vu32*) (APP4_BASE + 4);
        LDR.N    R0,??main_0+0x1C  ;; 0x8024000
        LDR      R0,[R0, #+4]
        LDR.N    R1,??main_0+0x10  ;; Jump_To_App
        STR      R0,[R1, #+4]
//  111     Jump_To_App = (pFunc) JumpAddr;
        STR      R0,[R1, #+0]
//  112     __MSR_MSP(*(vu32*) APP4_BASE);
        LDR.N    R0,??main_0+0x1C  ;; 0x8024000
??main_7:
        LDR      R0,[R0, #+0]
        BL       __MSR_MSP
//  113   }
//  114   USB_EN();
??main_10:
        LDR.N    R0,??main_0+0x4  ;; 0x40010804
        LDR.N    R1,??main_0+0x20  ;; 0x888bbbbb
        STR      R1,[R0, #+0]
//  115   USB_Init();  
        BL       USB_Init
//  116   Jump_To_App();
        LDR.N    R0,??main_0+0x10  ;; Jump_To_App
        LDR      R0,[R0, #+0]
        BLX      R0
//  117 }
        MOVS     R0,#+0
        ADD      SP,SP,#+12
        CFI CFA R13+20
        POP      {R4-R7,PC}       ;; return
        DATA
??main_0:
        DC32     `?<Constant "Hardware Ver ">`
        DC32     0x40010804
        DC32     Key_Buffer
        DC32     0x800c000
        DC32     Jump_To_App
        DC32     0x8014000
        DC32     0x801c000
        DC32     0x8024000
        DC32     0x888bbbbb
        CFI EndBlock cfiBlock0

        END
//  118 /*********************************  END OF FILE  ******************************/
// 
//   8 bytes in section .bss
// 276 bytes in section .rodata
// 560 bytes in section .text
// 
// 560 bytes of CODE  memory
// 276 bytes of CONST memory
//   8 bytes of DATA  memory
//
//Errors: none
//Warnings: none
