///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  13:45:40 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\APP_V2.32\source\Menu.c                       /
//    Command line =  E:\DS0203\APP_V2.32\source\Menu.c -lA                   /
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
//    List file    =  E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\Menu.s          /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Menu

        EXTERN A_Max
        EXTERN A_Min
        EXTERN A_Rms
        EXTERN A_Vdc
        EXTERN A_Vpp
        EXTERN B_Max
        EXTERN B_Min
        EXTERN B_Rms
        EXTERN B_Vdc
        EXTERN B_Vpp
        EXTERN Blink
        EXTERN G_Attr
        EXTERN Int32String_sign
        EXTERN Print_Str
        EXTERN Twink
        EXTERN X_Attr
        EXTERN Y_Attr
        EXTERN __Get
        EXTERN strcpy
        EXTERN u8ToDec2
        EXTERN u8ToDec3

        PUBLIC BATT_STR
        PUBLIC BL_Str
        PUBLIC B_COLOR
        PUBLIC BaseStr
        PUBLIC CH_A_STR
        PUBLIC CH_B_STR
        PUBLIC CH_C_STR
        PUBLIC CH_D_STR
        PUBLIC Current
        PUBLIC DELTA_T
        PUBLIC DELTA_V
        PUBLIC Detail
        PUBLIC Display_Meter
        PUBLIC Display_Title
        PUBLIC Display_Value
        PUBLIC FO_STR
        PUBLIC FO_TYPE
        PUBLIC F_EXT
        PUBLIC F_FUNC
        PUBLIC F_INV
        PUBLIC F_Unit
        PUBLIC Load_Attr
        PUBLIC METER
        PUBLIC MODESTR
        PUBLIC Meter
        PUBLIC NO_DEF
        PUBLIC NO_RANGE
        PUBLIC Num
        PUBLIC NumStr
        PUBLIC O_COLOR
        PUBLIC Result_FPS
        PUBLIC STATESTR
        PUBLIC S_Inv
        PUBLIC TRIGSTR
        PUBLIC TR_TYPE
        PUBLIC T_COLOR
        PUBLIC T_INV
        PUBLIC T_Unit
        PUBLIC Title
        PUBLIC TypeA
        PUBLIC Update
        PUBLIC Update_Battery
        PUBLIC VERNIE1
        PUBLIC VERNIE2
        PUBLIC VERNIE3
        PUBLIC VERNIE4
        PUBLIC VT_STR
        PUBLIC V_COLOR
        PUBLIC V_INV
        PUBLIC V_Unit
        PUBLIC Vertical
        PUBLIC Vol_Str
        PUBLIC XCOLOR
        PUBLIC XPOSISTR
        PUBLIC YCOUPLE
        PUBLIC YPOSISTR
        PUBLIC Y_COLOR
        PUBLIC Y_INV
        
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
        
// E:\DS0203\APP_V2.32\source\Menu.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : Menu.c  
//    3  Version   : DS203_APP Ver 2.3x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include <string.h>
//    6 #include "Interrupt.h"
//    7 #include "Function.h"
//    8 #include "Process.h"
//    9 #include "Menu.h"
//   10 #include "Draw.h"
//   11 #include "BIOS.h"
//   12 
//   13 I32STR_RES Num;
//   14 
//   15 u16 Result_FPS;
//   16 
//   17 u8 V_Unit[4][3]={"uV","mV","V ","kV"};
//   18 u8 T_Unit[4][3]={"nS","uS","mS","S "};
//   19 u8 F_Unit[4][4]={"Hz","Hz","KC","MC"};
//   20 
//   21 uc8 STATESTR[2][10] = {"!RUN!", "HOLD"};                          // Running state str
//   22 
//   23 uc16 S_Inv[2]       = {(SCRN<<8)+TEXT2, (SCRN<<8)+NOTE1};         // Running state Color
//   24 
//   25 uc8 BATT_STR[5][10] = {"~``'", "~``}", "~`;}", "~;;}", "{;;}"};   // Battery Status Str
//   26 uc16 B_COLOR[5]     = {(NOTE1<<8)+SCRN, (SIDE <<8)+SCRN,
//   27                        (TEXT2<<8)+SCRN, (TEXT2<<8)+SCRN,
//   28                        (TEXT2<<8)+SCRN};                          // Battery Status Color
//   29 
//   30 uc8 CH_A_STR[2][10]  = {" HIDE ", "!CH(A)!"};
//   31 uc8 CH_B_STR[2][10]  = {" HIDE ", "!CH(B)!"};
//   32 uc8 CH_C_STR[2][10]  = {" HIDE ", "!CH(C)!"};
//   33 uc8 CH_D_STR[10][10] = {" HIDE ", "!CH(D)!", "!(A+B)!", "!(A-B)!",  
//   34                        "!(C&D)!", "!(C|D)!", "FILE_1",  "FILE_2",
//   35                         "FILE_3",  "FILE_4"};                      // Track source Str
//   36 uc8 NO_RANGE[5]      = " -- ";                       
//   37 uc8 NO_DEF[5]        = "--";                       
//   38 
//   39 uc8  YCOUPLE[3][10]  = {"DC", "AC", "!-!"};                        // Track Couple Str                    
//   40 u8   Vertical[15][10];                                             // Track Range Str
//   41 uc8  YPOSISTR[5]    = {"YPOS"};                                   // Track Position Str 
//   42 uc16 Y_INV[5]       = {(SCRN<<8)+TR_1, (SCRN<<8)+TR_2,
//   43                        (SCRN<<8)+TR_3, (SCRN<<8)+TR_4,
//   44                        (SCRN<<8)+VERNIE};                          // Track Color 1

        SECTION `.rodata`:CONST:NOROOT(2)
//   45 uc16 Y_COLOR[5]     = {(TR_1<<8)+SCRN, (TR_2<<8)+SCRN,
Y_COLOR:
        DATA
        DC16 5, 261, 517, 773, 1029
        DC8 0, 0
        DC8 "/Sec."
        DC8 0, 0

        SECTION `.rodata`:CONST:NOROOT(1)
        DATA
        DC8 "%"

        SECTION `.rodata`:CONST:NOROOT(2)
STATESTR:
        DATA
        DC8 "!RUN!"
        DC8 0, 0, 0, 0
        DC8 "HOLD"
        DC8 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
S_Inv:
        DATA
        DC16 1291, 1295

        SECTION `.rodata`:CONST:NOROOT(2)
BATT_STR:
        DATA
        DC8 "~``'"
        DC8 0, 0, 0, 0, 0
        DC8 "~``}"
        DC8 0, 0, 0, 0, 0
        DC8 "~`;}"
        DC8 0, 0, 0, 0, 0
        DC8 "~;;}"
        DC8 0, 0, 0, 0, 0
        DC8 "{;;}"
        DC8 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
B_COLOR:
        DATA
        DC16 3845, 3589, 2821, 2821, 2821
        DC8 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
CH_A_STR:
        DATA
        DC8 " HIDE "
        DC8 0, 0, 0
        DC8 "!CH(A)!"
        DC8 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
CH_B_STR:
        DATA
        DC8 " HIDE "
        DC8 0, 0, 0
        DC8 "!CH(B)!"
        DC8 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
CH_C_STR:
        DATA
        DC8 " HIDE "
        DC8 0, 0, 0
        DC8 "!CH(C)!"
        DC8 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
CH_D_STR:
        DATA
        DC8 " HIDE "
        DC8 0, 0, 0
        DC8 "!CH(D)!"
        DC8 0, 0
        DC8 "!(A+B)!"
        DC8 0, 0
        DC8 "!(A-B)!"
        DC8 0, 0
        DC8 "!(C&D)!"
        DC8 0, 0
        DC8 "!(C|D)!"
        DC8 0, 0
        DC8 "FILE_1"
        DC8 0, 0, 0
        DC8 "FILE_2"
        DC8 0, 0, 0
        DC8 "FILE_3"
        DC8 0, 0, 0
        DC8 "FILE_4"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
NO_RANGE:
        DATA
        DC8 " -- "
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
NO_DEF:
        DATA
        DC8 "--"
        DC8 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
YCOUPLE:
        DATA
        DC8 "DC"
        DC8 0, 0, 0, 0, 0, 0, 0
        DC8 "AC"
        DC8 0, 0, 0, 0, 0, 0, 0
        DC8 "!-!"
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
YPOSISTR:
        DATA
        DC8 "YPOS"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
Y_INV:
        DATA
        DC16 1280, 1281, 1282, 1283, 1284
        DC8 0, 0
//   46                        (TR_3<<8)+SCRN, (TR_4<<8)+SCRN,
//   47                        (VERNIE<<8)+SCRN};                          // Track Color 2
//   48 

        SECTION `.rodata`:CONST:NOROOT(2)
//   49 uc8 MODESTR[5][10]  = {"!AUTO!", "!NORM!", "SINGL", "!NONE!",
MODESTR:
        DATA
        DC8 "!AUTO!"
        DC8 0, 0, 0
        DC8 "!NORM!"
        DC8 0, 0, 0
        DC8 "SINGL"
        DC8 0, 0, 0, 0
        DC8 "!NONE!"
        DC8 0, 0, 0
        DC8 "!SCAN!"
        DC8 0, 0, 0, 0, 0
//   50                        "!SCAN!"};                                 // Sync Mode Str
//   51 u8   BaseStr[30][10];                                              // Time Base b Str

        SECTION `.rodata`:CONST:NOROOT(2)
//   52 uc8  XPOSISTR[5]    = {"XPOS"};
XPOSISTR:
        DATA
        DC8 "XPOS"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
//   53 uc16 XCOLOR[2]      = {(SCRN<<8)+X_POSI, (X_POSI<<8)+SCRN};       // Time Base Color
XCOLOR:
        DATA
        DC16 1286, 1541
//   54 

        SECTION `.rodata`:CONST:NOROOT(2)
//   55 uc8 FO_TYPE[4][10]  = {" SINE ",  "Triang",  " !Saw! ",  "Square"}; // Output Kind Str  "Kd=  %"
FO_TYPE:
        DATA
        DC8 " SINE "
        DC8 0, 0, 0
        DC8 "Triang"
        DC8 0, 0, 0
        DC8 " !Saw! "
        DC8 0, 0
        DC8 "Square"
        DC8 0, 0, 0
//   56 

        SECTION `.rodata`:CONST:NOROOT(2)
//   57 uc8 FO_STR[20][10]  = {" 10Hz ",  " 20Hz ",  " 50Hz ",   " 100Hz",
FO_STR:
        DATA
        DC8 " 10Hz "
        DC8 0, 0, 0
        DC8 " 20Hz "
        DC8 0, 0, 0
        DC8 " 50Hz "
        DC8 0, 0, 0
        DC8 " 100Hz"
        DC8 0, 0, 0
        DC8 "!200Hz!"
        DC8 0, 0
        DC8 "!500Hz!"
        DC8 0, 0
        DC8 " 1KHz "
        DC8 0, 0, 0
        DC8 " 2KHz "
        DC8 0, 0, 0
        DC8 " 5KHz "
        DC8 0, 0, 0
        DC8 "!10KHz!"
        DC8 0, 0
        DC8 "!20KHz!"
        DC8 0, 0
        DC8 "!50KHz!"
        DC8 0, 0
        DC8 "100KHz"
        DC8 0, 0, 0
        DC8 "200KHz"
        DC8 0, 0, 0
        DC8 "500KHz"
        DC8 0, 0, 0
        DC8 " 1MHz "
        DC8 0, 0, 0
        DC8 " 2MHz "
        DC8 0, 0, 0
        DC8 " 4MHz "
        DC8 0, 0, 0
        DC8 " 6MHz "
        DC8 0, 0, 0
        DC8 " 8MHz "
        DC8 0, 0, 0
//   58                        "!200Hz!", "!500Hz!", " 1KHz ",   " 2KHz ",
//   59                        " 5KHz ",  "!10KHz!", "!20KHz!",  "!50KHz!",
//   60                        "100KHz",  "200KHz",  "500KHz",   " 1MHz ",
//   61                        " 2MHz ",  " 4MHz ",  " 6MHz ",   " 8MHz "}; // Output Frequency Str
//   62 

        SECTION `.rodata`:CONST:NOROOT(2)
//   63 uc16 O_COLOR[2]     = {(SCRN<<8)+TEXT3, (TEXT3<<8)+SCRN};         // Output Frequency Color
O_COLOR:
        DATA
        DC16 1292, 3077
//   64 

        SECTION `.rodata`:CONST:NOROOT(2)
//   65 uc8  TRIGSTR[8][10] = {"TRIGG", "TRIGG", "TRIGG", "TRIGG"};      // Trigger source Str
TRIGSTR:
        DATA
        DC8 "TRIGG"
        DC8 0, 0, 0, 0
        DC8 "TRIGG"
        DC8 0, 0, 0, 0
        DC8 "TRIGG"
        DC8 0, 0, 0, 0
        DC8 "TRIGG"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
//   66                           

        SECTION `.rodata`:CONST:NOROOT(2)
//   67 uc8  TR_TYPE[8][10] = {":!\\!", ":!^!", "<Vt", ">Vt",            // Trigger Type Str
TR_TYPE:
        DATA
        DC8 ":!\\!"
        DC8 0, 0, 0, 0, 0
        DC8 ":!^!"
        DC8 0, 0, 0, 0, 0
        DC8 "<Vt"
        DC8 0, 0, 0, 0, 0, 0
        DC8 ">Vt"
        DC8 0, 0, 0, 0, 0, 0
        DC8 "<TL"
        DC8 0, 0, 0, 0, 0, 0
        DC8 ">TL"
        DC8 0, 0, 0, 0, 0, 0
        DC8 "<TH"
        DC8 0, 0, 0, 0, 0, 0
        DC8 ">TH"
        DC8 0, 0, 0, 0, 0, 0
//   68                        "<TL",   ">TL",  "<TH", ">TH"};

        SECTION `.rodata`:CONST:NOROOT(2)
//   69 uc8  VT_STR[9]      =  "THRESHOL";                                // Trigg Voltage Str
VT_STR:
        DATA
        DC8 "THRESHOL"
        DC8 0, 0, 0
//   70                           

        SECTION `.rodata`:CONST:NOROOT(2)
//   71 uc8  VERNIE1[5]     = {"!V1!"};          // V1 Vernie Str
VERNIE1:
        DATA
        DC8 "!V1!"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
//   72 uc8  VERNIE2[5]     = {"!V2!"};          // V2 Vernie Str
VERNIE2:
        DATA
        DC8 "!V2!"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
//   73 uc8  VERNIE3[5]     = {"!T1!"};          // T1 Vernie Str
VERNIE3:
        DATA
        DC8 "!T1!"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
//   74 uc8  VERNIE4[5]     = {"!T2!"};          // T2 Vernie Str
VERNIE4:
        DATA
        DC8 "!T2!"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(1)
//   75 uc16 V_INV[1]       = {(SCRN<<8)+VERNIE};
V_INV:
        DATA
        DC16 1284

        SECTION `.rodata`:CONST:NOROOT(1)
//   76 uc16 V_COLOR[1]     = {(VERNIE<<8)+SCRN};                         // Y Vernie Color
V_COLOR:
        DATA
        DC16 1029

        SECTION `.rodata`:CONST:NOROOT(1)
//   77 uc16 T_INV[1]       = {(SCRN<<8)+VERNIE};
T_INV:
        DATA
        DC16 1284

        SECTION `.rodata`:CONST:NOROOT(1)
//   78 uc16 T_COLOR[1]        = {(VERNIE<<8)+SCRN};                         // X Vernie Color
T_COLOR:
        DATA
        DC16 1029

        SECTION `.rodata`:CONST:NOROOT(2)
//   79 uc8  F_FUNC[2][10]  = {"Save File", "Load File"};                 // File Function Str
F_FUNC:
        DATA
        DC8 "Save File"
        DC8 "Load File"
//   80 

        SECTION `.rodata`:CONST:NOROOT(2)
//   81 uc8  F_EXT[7][10]   = {".BMP?", ".DAT?", ".CVS?", " OK! ",
F_EXT:
        DATA
        DC8 ".BMP?"
        DC8 0, 0, 0, 0
        DC8 ".DAT?"
        DC8 0, 0, 0, 0
        DC8 ".CVS?"
        DC8 0, 0, 0, 0
        DC8 " OK! "
        DC8 0, 0, 0, 0
        DC8 " ERR!"
        DC8 0, 0, 0, 0
        DC8 ".HEX"
        DC8 0, 0, 0, 0, 0
        DC8 ".BIN"
        DC8 0, 0, 0, 0, 0, 0, 0
//   82                          " ERR!",".HEX", ".BIN",};                  // File Ext Name Str

        SECTION `.rodata`:CONST:NOROOT(1)
//   83 uc16 F_INV[1]       = {(SCRN<<8)+TEXT1};                          //  File Color
F_INV:
        DATA
        DC16 1290

        SECTION `.rodata`:CONST:NOROOT(2)
//   84 uc8  DELTA_V[2][10] = {"[V:", "[V:"};
DELTA_V:
        DATA
        DC8 "[V:"
        DC8 0, 0, 0, 0, 0, 0
        DC8 "[V:"
        DC8 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
//   85 uc8  DELTA_T[4]     = "[T:";
DELTA_T:
        DATA
        DC8 "[T:"

        SECTION `.rodata`:CONST:NOROOT(2)
//   86 uc8  METER[11][5]   = {"Vbt", "FPS", "Vpp", "Vdc", "RMS", 
METER:
        DATA
        DC8 "Vbt"
        DC8 0
        DC8 "FPS"
        DC8 0
        DC8 "Vpp"
        DC8 0
        DC8 "Vdc"
        DC8 0
        DC8 "RMS"
        DC8 0
        DC8 "Max"
        DC8 0
        DC8 "Min"
        DC8 0
        DC8 "Frq"
        DC8 0
        DC8 "CIR"
        DC8 0
        DC8 "DUT"
        DC8 0, 0, 0, 0, 0, 0, 0
//   87                        "Max", "Min", "Frq", "CIR", "DUT"};
//   88 
//   89 u8   NumStr[9], Detail[14];

        SECTION `.bss`:DATA:NOROOT(0)
//   90 u8   Current = 0, TypeA = 0, Update = 1;
TypeA:
        DS8 1

        SECTION `.data`:DATA:NOROOT(2)
//   91 u8   BL_Str[5]="B.L", Vol_Str[5]="Vol";
//   92 
//   93 menu Title[13][4]=   
Title:
        DATA
        DC32 CH_A_STR, Y_INV
        DC16 1
        DC8 16, 0
        DC16 35
        DC8 228, 0
        DC16 1
        DC8 2, 0
        DC32 YCOUPLE, Y_COLOR
        DC16 1
        DC8 16, 0
        DC16 35
        DC8 216, 0
        DC16 0
        DC8 2, 0
        DC32 Vertical, Y_COLOR
        DC16 8
        DC8 0, 0
        DC16 51
        DC8 216, 0
        DC16 5
        DC8 2, 0
        DC32 YPOSISTR, Y_INV
        DC16 200
        DC8 32, 0
        DC16 0
        DC8 0, 0
        DC16 150
        DC8 2, 0
        DC32 CH_B_STR, Y_INV + 2H
        DC16 1
        DC8 16, 0
        DC16 86
        DC8 228, 0
        DC16 1
        DC8 2, 0
        DC32 YCOUPLE, Y_COLOR + 2H
        DC16 1
        DC8 16, 0
        DC16 86
        DC8 216, 0
        DC16 1
        DC8 2, 0
        DC32 Vertical, Y_COLOR + 2H
        DC16 8
        DC8 0, 0
        DC16 102
        DC8 216, 0
        DC16 1
        DC8 2, 0
        DC32 YPOSISTR, Y_INV + 2H
        DC16 200
        DC8 32, 0
        DC16 0
        DC8 0, 0
        DC16 100
        DC8 2, 0
        DC32 CH_C_STR, Y_INV + 4H
        DC16 1
        DC8 16, 0
        DC16 137
        DC8 228, 0
        DC16 1
        DC8 2, 0
        DC32 NO_DEF, Y_COLOR + 4H
        DC16 0
        DC8 16, 0
        DC16 137
        DC8 216, 0
        DC16 0
        DC8 2, 0
        DC32 NO_RANGE, Y_COLOR + 4H
        DC16 0
        DC8 0, 0
        DC16 153
        DC8 216, 0
        DC16 0
        DC8 2, 0
        DC32 YPOSISTR, Y_INV + 4H
        DC16 199
        DC8 32, 0
        DC16 0
        DC8 0, 0
        DC16 60
        DC8 2, 0
        DC32 CH_D_STR, Y_INV + 6H
        DC16 9
        DC8 16, 0
        DC16 188
        DC8 228, 0
        DC16 1
        DC8 2, 0
        DC32 NO_DEF, Y_COLOR + 6H
        DC16 0
        DC8 16, 0
        DC16 188
        DC8 216, 0
        DC16 0
        DC8 2, 0
        DC32 NO_RANGE, Y_COLOR + 6H
        DC16 0
        DC8 0, 0
        DC16 204
        DC8 216, 0
        DC16 0
        DC8 2, 0
        DC32 YPOSISTR, Y_INV + 6H
        DC16 199
        DC8 32, 0
        DC16 0
        DC8 0, 0
        DC16 20
        DC8 2, 0
        DC32 STATESTR, S_Inv
        DC16 1
        DC8 0, 0
        DC16 0
        DC8 228, 0
        DC16 0
        DC8 2, 0
        DC32 BATT_STR, B_COLOR
        DC16 4
        DC8 0, 0
        DC16 0
        DC8 216, 0
        DC16 0
        DC8 2, 0
        DC32 BATT_STR, B_COLOR
        DC16 4
        DC8 128, 0
        DC16 0
        DC8 0, 0
        DC16 0
        DC8 4, 0
        DC32 BATT_STR, B_COLOR
        DC16 4
        DC8 128, 0
        DC16 0
        DC8 0, 0
        DC16 0
        DC8 4, 0
        DC32 MODESTR, XCOLOR
        DC16 4
        DC8 16, 0
        DC16 239
        DC8 228, 0
        DC16 0
        DC8 2, 0
        DC32 BaseStr, XCOLOR + 2H
        DC16 26
        DC8 0, 0
        DC16 239
        DC8 216, 0
        DC16 17
        DC8 2, 0
        DC32 XPOSISTR, XCOLOR
        DC16 3795
        DC8 32, 0
        DC16 366
        DC8 0, 0
        DC16 0
        DC8 2, 0
        DC32 XPOSISTR, XCOLOR
        DC16 3795
        DC8 128, 0
        DC16 80
        DC8 0, 0
        DC16 0
        DC8 2, 0
        DC32 FO_TYPE, O_COLOR
        DC16 3
        DC8 16, 0
        DC16 282
        DC8 228, 0
        DC16 3
        DC8 2, 0
        DC32 FO_STR, O_COLOR + 2H
        DC16 19
        DC8 0, 0
        DC16 282
        DC8 216, 0
        DC16 13
        DC8 2, 0
        DC32 NumStr, O_COLOR
        DC16 100
        DC8 128, 0
        DC16 306
        DC8 228, 0
        DC16 50
        DC8 4, 0
        DC32 NumStr, O_COLOR
        DC16 0
        DC8 128, 0
        DC16 0
        DC8 0, 0
        DC16 0
        DC8 4, 0
        DC32 TRIGSTR, Y_INV
        DC16 3
        DC8 16, 0
        DC16 333
        DC8 228, 0
        DC16 1
        DC8 2, 0
        DC32 TR_TYPE, Y_INV
        DC16 7
        DC8 16, 0
        DC16 373
        DC8 228, 0
        DC16 0
        DC8 2, 0
        DC32 VT_STR, Y_COLOR
        DC16 200
        DC8 32, 0
        DC16 333
        DC8 216, 0
        DC16 0
        DC8 2, 0
        DC32 VT_STR, Y_COLOR
        DC16 0
        DC8 128, 0
        DC16 357
        DC8 216, 0
        DC16 0
        DC8 4, 0
        DC32 VERNIE1, V_INV
        DC16 199
        DC8 32, 0
        DC16 35
        DC8 0, 0
        DC16 180
        DC8 2, 0
        DC32 VERNIE2, V_INV
        DC16 199
        DC8 32, 0
        DC16 62
        DC8 0, 0
        DC16 40
        DC8 2, 0
        DC32 DELTA_V, Y_INV
        DC16 1
        DC8 16, 0
        DC16 314
        DC8 197, 0
        DC16 0
        DC8 2, 0
        DC32 NumStr, Y_COLOR
        DC16 240
        DC8 2, 0
        DC16 342
        DC8 197, 0
        DC16 70
        DC8 2, 0
        DC32 F_FUNC, F_INV
        DC16 1
        DC8 16, 0
        DC16 134
        DC8 0, 0
        DC16 0
        DC8 0, 0
        DC32 NumStr, F_INV
        DC16 255
        DC8 2, 0
        DC16 206
        DC8 0, 0
        DC16 0
        DC8 1, 0
        DC32 F_EXT, F_INV
        DC16 1
        DC8 16, 0
        DC16 230
        DC8 0, 0
        DC16 0
        DC8 0, 0
        DC32 F_EXT, F_INV
        DC16 0
        DC8 128, 0
        DC16 0
        DC8 0, 0
        DC16 0
        DC8 4, 0
        DC32 VERNIE3, T_INV
        DC16 300
        DC8 32, 0
        DC16 312
        DC8 0, 0
        DC16 80
        DC8 2, 0
        DC32 VERNIE4, T_INV
        DC16 300
        DC8 32, 0
        DC16 339
        DC8 0, 0
        DC16 280
        DC8 2, 0
        DC32 DELTA_T, T_INV
        DC16 0
        DC8 128, 0
        DC16 314
        DC8 182, 0
        DC16 0
        DC8 2, 0
        DC32 NumStr, T_COLOR
        DC16 300
        DC8 2, 0
        DC16 342
        DC8 182, 0
        DC16 80
        DC8 2, 0
        DC32 BL_Str, V_INV
        DC16 0
        DC8 32, 0
        DC16 314
        DC8 167, 0
        DC16 0
        DC8 2, 0
        DC32 NumStr, V_COLOR
        DC16 9
        DC8 1, 0
        DC16 342
        DC8 167, 0
        DC16 5
        DC8 2, 0
        DC32 NumStr, V_INV
        DC16 0
        DC8 128, 0
        DC16 0
        DC8 0, 0
        DC16 0
        DC8 4, 0
        DC32 NumStr, V_INV
        DC16 0
        DC8 128, 0
        DC16 0
        DC8 0, 0
        DC16 0
        DC8 4, 0
        DC32 Vol_Str, V_INV
        DC16 0
        DC8 32, 0
        DC16 314
        DC8 152, 0
        DC16 0
        DC8 2, 0
        DC32 NumStr, V_COLOR
        DC16 10
        DC8 1, 0
        DC16 342
        DC8 152, 0
        DC16 5
        DC8 2, 0
        DC32 NumStr, V_INV
        DC16 0
        DC8 128, 0
        DC16 0
        DC8 0, 0
        DC16 0
        DC8 4, 0
        DC32 NumStr, V_INV
        DC16 0
        DC8 128, 0
        DC16 0
        DC8 0, 0
        DC16 0
        DC8 4, 0
//   94 {
//   95   //     Item_String,   m_Color,   Limit, Mark, xPos, yPos, Value, Flag 
//   96   {//============================ Title Track1 Group ===========================
//   97     {(u8*)CH_A_STR,(u16*)Y_INV,     2-1, CIRC,   35,  228,     1, UPDAT}, //  Track source
//   98     {(u8*)YCOUPLE, (u16*)Y_COLOR,   2-1, CIRC,   35,  216,     0, UPDAT}, //  Track Couple        
//   99     {(u8*)Vertical,(u16*)Y_COLOR,   9-1,    0,   51,  216,     5, UPDAT}, //  Track Range 
//  100     {(u8*)YPOSISTR,(u16*)Y_INV,     200,  FIX,    0,    0,   150, UPDAT}, //  Adj. Track Position 160
//  101   },
//  102   {//============================ Title Track2 Group ===========================
//  103     {(u8*)CH_B_STR,(u16*)Y_INV+1,   2-1, CIRC,   86,  228,     1, UPDAT}, //  Track source
//  104     {(u8*)YCOUPLE, (u16*)Y_COLOR+1, 2-1, CIRC,   86,  216,     1, UPDAT}, //  Track Couple        
//  105     {(u8*)Vertical,(u16*)Y_COLOR+1, 9-1,    0,  102,  216,     1, UPDAT}, //  Track Range
//  106     {(u8*)YPOSISTR,(u16*)Y_INV+1,   200,  FIX,    0,    0,   100, UPDAT}, //  Adj. Track Position
//  107   },
//  108   {//============================ Title Track3 Group ===========================
//  109     {(u8*)CH_C_STR,(u16*)Y_INV+2,   2-1, CIRC,  137,  228,     1, UPDAT}, //  Track source
//  110     {(u8*)NO_DEF , (u16*)Y_COLOR+2, 1-1, CIRC,  137,  216,     0, UPDAT}, //  Track Couple        
//  111     {(u8*)NO_RANGE,(u16*)Y_COLOR+2, 1-1,    0,  153,  216,     0, UPDAT}, //  Track Range
//  112     {(u8*)YPOSISTR,(u16*)Y_INV+2, 200-1,  FIX,    0,    0,    60, UPDAT}, //  Adj. Track Position
//  113   },
//  114   {//============================ Title Track4 Group ===========================
//  115     {(u8*)CH_D_STR,(u16*)Y_INV+3,  10-1, CIRC,  188,  228,     1, UPDAT}, //  Track source
//  116     {(u8*)NO_DEF , (u16*)Y_COLOR+3, 1-1, CIRC,  188,  216,     0, UPDAT}, //  Track Couple        
//  117     {(u8*)NO_RANGE,(u16*)Y_COLOR+3, 1-1,    0,  204,  216,     0, UPDAT}, //  Track Range
//  118     {(u8*)YPOSISTR,(u16*)Y_INV+3, 200-1,  FIX,    0,    0,    20, UPDAT}, //  Adj. Track Position
//  119   },
//  120   {//================== Running State & Battery Status Group ===================
//  121     {(u8*)STATESTR,(u16*)S_Inv,     2-1,    0,    0,  228,     0, UPDAT}, //  Running state
//  122     {(u8*)BATT_STR,(u16*)B_COLOR,   5-1,    0,    0,  216,     0, UPDAT}, //  Battery status
//  123     {(u8*)BATT_STR,(u16*)B_COLOR,   5-1,  NOT,    0,    0,     0,   HID}, 
//  124     {(u8*)BATT_STR,(u16*)B_COLOR,   5-1,  NOT,    0,    0,     0,   HID},
//  125   },
//  126   {//========================= Title Time Base Group ===========================
//  127     {(u8*)MODESTR, (u16*)XCOLOR,    5-1, CIRC,  239,  228,     0, UPDAT}, //  Sync Mode
//  128     {(u8*)BaseStr, (u16*)XCOLOR+1, 27-1,    0,  239,  216,    17, UPDAT}, //  Time Base Range
//  129     {(u8*)XPOSISTR,(u16*)XCOLOR,   3795,  FIX,  366,    0,     0, UPDAT}, //  Adj. X position
//  130     {(u8*)XPOSISTR,(u16*)XCOLOR,   3795,  NOT,   80,    0,     0, UPDAT}, //  View window rule
//  131   },           
//  132   {//======================= Title Output Signal Group =========================
//  133     {(u8*)FO_TYPE, (u16*)O_COLOR,   4-1, CIRC,  282,  228,     3, UPDAT}, //  Output Wave Kind         
//  134     {(u8*)FO_STR,  (u16*)O_COLOR+1,20-1,    0,  282,  216,    13, UPDAT}, //  Output Frequency         
//  135     {(u8*)NumStr,  (u16*)O_COLOR,   100,  NOT,  306,  228,    50,   HID},        
//  136     {(u8*)NumStr,  (u16*)O_COLOR,     0,  NOT,    0,    0,     0,   HID}, //  Duty value          
//  137   },
//  138   {//=====================;===== Title Trigger Group ====;======================
//  139     {(u8*)TRIGSTR, (u16*)Y_INV,     4-1, CIRC,  333,  228,     1, UPDAT}, //  Trigger source         
//  140     {(u8*)TR_TYPE, (u16*)Y_INV,     8-1, CIRC,  373,  228,     0, UPDAT}, //  Trigger Kine         
//  141     {(u8*)VT_STR,  (u16*)Y_COLOR,   200,  FIX,  333,  216,     0, UPDAT}, //  Adj. Trigger threshold     
//  142     {(u8*)VT_STR,  (u16*)Y_COLOR,     0,  NOT,  357,  216,     0,   HID}, //  Number position     
//  143   },
//  144   {//============================ Title Y Vernie Group =========================
//  145     {(u8*)VERNIE1, (u16*)V_INV,   200-1,  FIX,   35,    0,   180, UPDAT}, //  V1 Vernie         
//  146     {(u8*)VERNIE2, (u16*)V_INV,   200-1,  FIX,   62,    0,    40, UPDAT}, //  V2 Vernie     
//  147     {(u8*)DELTA_V, (u16*)Y_INV,     2-1, CIRC,  314,  197,     0, UPDAT}, //  Measure Track    
//  148     {(u8*)NumStr,  (u16*)Y_COLOR,   240, NUM3,  342,  197,    70, UPDAT}, //  Delta V value    
//  149   },
//  150   {//============================= Title File Group ============================
//  151     {(u8*)F_FUNC,  (u16*)F_INV,     2-1, CIRC,  134,    0,     0,     0}, //  File function    
//  152     {(u8*)NumStr,  (u16*)F_INV,   256-1, NUM3,  206,    0,     0,     1}, //  File number     
//  153     {(u8*)F_EXT,   (u16*)F_INV,     2-1, CIRC,  230,    0,     0,     0}, //  Ext. name     
//  154     {(u8*)F_EXT,   (u16*)F_INV,       0,  NOT,    0,    0,     0,   HID},  
//  155   },
//  156   {//============================ Title X Vernie Group =========================
//  157     {(u8*)VERNIE3, (u16*)T_INV,     300,  FIX,  312,    0,    80, UPDAT}, //  T1 Vernie         
//  158     {(u8*)VERNIE4, (u16*)T_INV,     300,  FIX,  339,    0,   280, UPDAT}, //  T2 Vernie     
//  159     {(u8*)DELTA_T, (u16*)T_INV,       0,  NOT,  314,  182,     0, UPDAT}, //  Delta T Str     
//  160     {(u8*)NumStr,  (u16*)T_COLOR,   300, NUM3,  342,  182,    80, UPDAT}, //  Delta T value    
//  161   },
//  162   {//=========================== Title BackLight Group =========================
//  163     {(u8*)BL_Str,  (u16*)V_INV,     1-1,  FIX,  314,  167,     0, UPDAT}, //  BackLight    
//  164     {(u8*)NumStr,  (u16*)V_COLOR,  10-1, NUM2,  342,  167,     5, UPDAT}, //  Class     
//  165     {(u8*)NumStr,  (u16*)V_INV,       0,  NOT,    0,    0,     0,   HID},     
//  166     {(u8*)NumStr,  (u16*)V_INV,       0,  NOT,    0,    0,     0,   HID},  
//  167   },
//  168   {//============================ Title Volume Group ===========================
//  169     {(u8*)Vol_Str, (u16*)V_INV,     1-1,  FIX,  314,  152,     0, UPDAT}, //  Volume        
//  170     {(u8*)NumStr,  (u16*)V_COLOR,  11-1, NUM2,  342,  152,     5, UPDAT}, //  Class     
//  171     {(u8*)NumStr,  (u16*)V_INV,       0,  NOT,    0,    0,     0,   HID},    
//  172     {(u8*)NumStr,  (u16*)V_INV,       0,  NOT,    0,    0,     0,   HID},    
//  173   },
//  174 };
//  175 
//  176 meter Meter[9] =
Meter:
        DC32 METER
        DC8 4, 0
        DC16 314, 342
        DC8 137, 2
        DC32 METER
        DC8 4, 1
        DC16 314, 342
        DC8 122, 2
        DC32 METER
        DC8 0, 2
        DC16 314, 342
        DC8 107, 2
        DC32 METER
        DC8 0, 3
        DC16 314, 342
        DC8 92, 2
        DC32 METER
        DC8 0, 4
        DC16 314, 342
        DC8 77, 2
        DC32 METER
        DC8 1, 5
        DC16 314, 342
        DC8 62, 2
        DC32 METER
        DC8 1, 6
        DC16 314, 342
        DC8 47, 2
        DC32 METER
        DC8 1, 2
        DC16 314, 342
        DC8 32, 2
        DC32 METER
        DC8 2, 3
        DC16 314, 342
        DC8 17, 2
NumStr:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Current:
        DC8 0
        DC8 0
Result_FPS:
        DC8 0, 0
Num:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Detail:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
V_Unit:
        DC8 "uV"
        DC8 "mV"
        DC8 "V "
        DC8 "kV"
T_Unit:
        DC8 "nS"
        DC8 "uS"
        DC8 "mS"
        DC8 "S "
Vertical:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0
BaseStr:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.data`:DATA:NOROOT(2)
F_Unit:
        DATA
        DC8 "Hz"
        DC8 0
        DC8 "Hz"
        DC8 0
        DC8 "KC"
        DC8 0
        DC8 "MC"
        DC8 0

        SECTION `.data`:DATA:NOROOT(0)
Update:
        DATA
        DC8 1

        SECTION `.data`:DATA:NOROOT(2)
BL_Str:
        DATA
        DC8 "B.L"
        DC8 0, 0, 0, 0

        SECTION `.data`:DATA:NOROOT(2)
Vol_Str:
        DATA
        DC8 "Vol"
        DC8 0, 0, 0, 0
//  177 { {(u8*)METER,      4,    VBT,     314,    342,   137,  UPDAT}, //  Meter #0
//  178   {(u8*)METER,      4,    FPS,     314,    342,   122,  UPDAT}, //  Meter #1
//  179   {(u8*)METER, TRACK1,    VPP,     314,    342,   107,  UPDAT}, //  Meter #2
//  180   {(u8*)METER, TRACK1,    VDC,     314,    342,    92,  UPDAT}, //  Meter #3
//  181   {(u8*)METER, TRACK1,    RMS,     314,    342,    77,  UPDAT}, //  Meter #4
//  182   {(u8*)METER, TRACK2,    MAX,     314,    342,    62,  UPDAT}, //  Meter #5
//  183   {(u8*)METER, TRACK2,    MIN,     314,    342,    47,  UPDAT}, //  Meter #6
//  184   {(u8*)METER, TRACK2,    VPP,     314,    342,    32,  UPDAT}, //  Meter #7
//  185   {(u8*)METER, TRACK3,    VDC,     314,    342,    17,  UPDAT}, //  Meter #8
//  186 };         
//  187 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Display_Meter
        THUMB
//  188 void Display_Meter(void)                  // 每次刷新显示一个测量项
//  189 {
Display_Meter:
        PUSH     {R4-R8,LR}
        CFI R14 Frame(CFA, -4)
        CFI R8 Frame(CFA, -8)
        CFI R7 Frame(CFA, -12)
        CFI R6 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
//  190   u8  i;
//  191   
//  192   for(i=0; i<9; ++i){        
        LDR.W    R4,??DataTable23  ;; Title
        ADDW     R5,R4,#+1044
        MOVS     R6,#+9
        LDR.W    R8,??Display_Meter_0  ;; Y_INV
        MOVS     R7,#+5
//  193     if(Meter[i].Flag & UPDAT){            //-----显示需刷新的测量项目名称
??Display_Meter_1:
        LDRB     R0,[R5, #+7]
        TST      R0,#0x2
        BEQ.N    ??Display_Meter_2
//  194       Meter[i].Flag &= (!UPDAT & !BLINK);       // Clr Update & Blink flag
        MOVS     R0,#+0
        STRB     R0,[R5, #+7]
//  195       Print_Str
//  196         (Meter[i].XPOS1, Meter[i].YPOS,        // 需要显示的坐标
//  197          Y_INV[Meter[i].Track],                // 需要显示的颜色(所属通道)
//  198          PRN,                                  // 需要显示的方式
//  199          Meter[i].Str +(Meter[i].Item * 5));   // 需要显示的项目名称
        LDRB     R0,[R5, #+1]
        LDR      R1,[R5, #-4]
        MLA      R0,R0,R7,R1
        PUSH     {R0,LR}
        CFI CFA R13+32
        MOVS     R3,#+0
        LDRB     R0,[R5, #+0]
        LDRH     R2,[R8, R0, LSL #+1]
        LDRB     R1,[R5, #+6]
        LDRH     R0,[R5, #+2]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+24
//  200     } 
//  201   }
??Display_Meter_2:
        ADDS     R5,R5,#+12
        SUBS     R6,R6,#+1
        BNE.N    ??Display_Meter_1
//  202   if((Current >= METER_0)&&(Current <= METER_8)){
        ADD      R0,R4,#+1160
        LDRB     R0,[R0, #+0]
        CMP      R0,#+13
        BCC.N    ??Display_Meter_3
        CMP      R0,#+22
        BCS.N    ??Display_Meter_3
//  203     if(Blink){                            //-----显示需闪烁的测量项目名称
        LDR.W    R1,??DataTable19  ;; Blink
        LDRB     R2,[R1, #+0]
        CBZ      R2,??Display_Meter_3
//  204       i = Current - METER_0;
        SUBS     R0,R0,#+13
        UXTB     R0,R0
//  205       Blink = 0;                               // Clr Blink Ctrl flag 
        MOVS     R2,#+0
        STRB     R2,[R1, #+0]
//  206       Print_Str(
//  207         Meter[i].XPOS1, Meter[i].YPOS,         // 需要闪烁的坐标 
//  208         Y_INV[Meter[i].Track],                 // 需要闪烁的颜色(所属通道)
//  209         Twink,                                 // 闪烁方式
//  210         Meter[i].Str +(Meter[i].Item *5));     // 需要闪烁的项目名称
        MOVS     R1,#+12
        MLA      R0,R0,R1,R4
        LDRB     R1,[R0, #+1045]
        ADD      R3,R0,#+1040
        LDR      R3,[R3, #+0]
        MLA      R1,R1,R7,R3
        PUSH     {R1,LR}
        CFI CFA R13+32
        LDR.W    R1,??DataTable15  ;; Twink
        LDRB     R3,[R1, #+0]
        LDRB     R1,[R0, #+1044]
        LDR.N    R2,??Display_Meter_0  ;; Y_INV
        LDRH     R2,[R2, R1, LSL #+1]
        LDRB     R1,[R0, #+1050]
        LDRH     R0,[R0, #+1046]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+24
//  211     }
//  212   }
//  213 }
??Display_Meter_3:
        POP      {R4-R8,PC}       ;; return
        Nop      
        DATA
??Display_Meter_0:
        DC32     Y_INV
        CFI EndBlock cfiBlock0
//  214 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function Display_Value
        THUMB
//  215 void Display_Value(u8 i)
//  216 {
Display_Value:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
//  217   switch (Meter[i].Item){  
        LDR.W    R5,??DataTable23  ;; Title
        MOVS     R1,#+12
        MLA      R6,R0,R1,R5
        LDRB     R0,[R6, #+1045]
        CMP      R0,#+6
        BHI.N    ??Display_Value_1
        TBH      [PC, R0, LSL #+1]
        DATA
??Display_Value_0:
        DC16     +7,+53,+92,+179
        DC16     +237,+296,+355
        THUMB
//  218   case VBT://--------------- 计算和显示电池电压 ---------------
//  219     Int32String_sign(&Num, __Get(V_BATTERY)* 1000);
??Display_Value_2:
        MOVS     R0,#+6
        BL       __Get
        MOV      R1,#+1000
        MULS     R1,R0,R1
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
//  220     Print_Str
//  221       (Meter[i].XPOS2, Meter[i].YPOS,
//  222       ((TEXT1 << 8) + SCRN), 
//  223       PRN,
//  224       Num.str);                              // 显示测量数值
        MOVW     R4,#+2565
        ADDW     R0,R5,#+1166
        PUSH     {R0,LR}
        CFI CFA R13+24
        MOVS     R3,#+0
        MOVS     R2,R4
        LDRB     R1,[R6, #+1050]
        ADD      R0,R6,#+1048
        LDRH     R0,[R0, #+0]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+16
//  225     Print_Str
//  226       (Meter[i].XPOS2 +40, Meter[i].YPOS,
//  227       ((TEXT1 << 8) + SCRN), 
//  228       PRN,
//  229       V_Unit[Num.decPos]);   /* */               // 显示测量量纲
        LDRB     R0,[R5, #+1164]
        MOVS     R1,#+3
        MLA      R0,R0,R1,R5
        ADD      R0,R0,#+1192
        PUSH     {R0,LR}
        CFI CFA R13+24
        MOVS     R3,#+0
        MOVS     R2,R4
        LDRB     R1,[R6, #+1050]
        ADD      R0,R6,#+1048
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+40
??Display_Value_3:
        UXTH     R0,R0
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+16
//  230     break;
//  231   case FPS://--------------- 计算和显示帧计数 ---------------
//  232     u8ToDec2(NumStr, Result_FPS & 0xFF);
//  233     Print_Str
//  234       (Meter[i].XPOS2, Meter[i].YPOS,
//  235        Y_COLOR[Meter[i].Track], 
//  236        PRN,
//  237        NumStr);                              // 显示测量数值
//  238     Print_Str
//  239       (Meter[i].XPOS2 +16, Meter[i].YPOS,
//  240        Y_COLOR[Meter[i].Track], 
//  241        PRN,
//  242        "/Sec.");                             // 显示测量量纲
//  243     break;  
//  244   case VPP:
//  245     if(Meter[i].Track == TRACK1)
//  246       Int32String_sign(&Num, A_Vpp * Y_Attr[_A_Range].SCALE);
//  247     if(Meter[i].Track == TRACK2)
//  248       Int32String_sign(&Num, B_Vpp * Y_Attr[_B_Range].SCALE);
//  249     if(Meter[i].Track == TRACK3)
//  250       Int32String_sign(&Num, 0);
//  251     Print_Str
//  252       (Meter[i].XPOS2, Meter[i].YPOS,
//  253       Y_COLOR[Meter[i].Track], 
//  254       PRN,
//  255       Num.str);                              // 显示测量数值
//  256     Print_Str
//  257       (Meter[i].XPOS2 +40, Meter[i].YPOS,
//  258       Y_COLOR[Meter[i].Track], 
//  259       PRN,
//  260       V_Unit[Num.decPos]);                   // 显示测量量纲
//  261     break;
//  262   case VDC:
//  263     if(Meter[i].Track == TRACK1)
//  264       Int32String_sign(&Num, A_Vdc * Y_Attr[_A_Range].SCALE);
//  265     if(Meter[i].Track == TRACK2)
//  266       Int32String_sign(&Num, B_Vdc * Y_Attr[_B_Range].SCALE);
//  267     if(Meter[i].Track == TRACK3)
//  268       Int32String_sign(&Num, 0);
//  269     if(Meter[i].Track == TRACK4)
//  270       Int32String_sign(&Num, 0);
//  271     Print_Str
//  272       (Meter[i].XPOS2, Meter[i].YPOS,
//  273       Y_COLOR[Meter[i].Track], 
//  274       PRN,
//  275       Num.str);                              // 显示测量数值
//  276     Print_Str
//  277       (Meter[i].XPOS2 +40, Meter[i].YPOS,
//  278       Y_COLOR[Meter[i].Track], 
//  279       PRN,
//  280       V_Unit[Num.decPos]);                   // 显示测量量纲
//  281     break;
//  282   case RMS:
//  283     if(Meter[i].Track == TRACK1)
//  284       Int32String_sign(&Num, A_Rms * Y_Attr[_A_Range].SCALE);
//  285     if(Meter[i].Track == TRACK2)
//  286       Int32String_sign(&Num, B_Rms * Y_Attr[_B_Range].SCALE);
//  287     if(Meter[i].Track == TRACK3)
//  288       Int32String_sign(&Num, 0);
//  289     if(Meter[i].Track == TRACK4)
//  290       Int32String_sign(&Num, 0);
//  291     Print_Str
//  292       (Meter[i].XPOS2, Meter[i].YPOS,
//  293       Y_COLOR[Meter[i].Track], 
//  294       PRN,
//  295       Num.str);                              // 显示测量数值
//  296     Print_Str
//  297       (Meter[i].XPOS2 +40, Meter[i].YPOS,
//  298       Y_COLOR[Meter[i].Track], 
//  299       PRN,
//  300       V_Unit[Num.decPos]);                   // 显示测量量纲
//  301     break;
//  302   case MAX:
//  303     if(Meter[i].Track == TRACK1)
//  304       Int32String_sign(&Num, A_Max * Y_Attr[_A_Range].SCALE);
//  305     if(Meter[i].Track == TRACK2)
//  306       Int32String_sign(&Num, B_Max * Y_Attr[_B_Range].SCALE);
//  307     if(Meter[i].Track == TRACK3)
//  308       Int32String_sign(&Num, 0);
//  309     if(Meter[i].Track == TRACK4)
//  310       Int32String_sign(&Num, 0);
//  311     Print_Str
//  312       (Meter[i].XPOS2, Meter[i].YPOS,
//  313       Y_COLOR[Meter[i].Track], 
//  314       PRN,
//  315       Num.str);                              // 显示测量数值
//  316     Print_Str
//  317       (Meter[i].XPOS2 +40, Meter[i].YPOS,
//  318       Y_COLOR[Meter[i].Track], 
//  319       PRN,
//  320       V_Unit[Num.decPos]);                   // 显示测量量纲
//  321     break;
//  322   case MIN:
//  323     if(Meter[i].Track == TRACK1)
//  324       Int32String_sign(&Num, A_Min * Y_Attr[_A_Range].SCALE);
//  325     if(Meter[i].Track == TRACK2)
//  326       Int32String_sign(&Num, B_Min * Y_Attr[_B_Range].SCALE);
//  327     if(Meter[i].Track == TRACK3)
//  328       Int32String_sign(&Num, 0);
//  329     if(Meter[i].Track == TRACK4)
//  330       Int32String_sign(&Num, 0);
//  331     Print_Str
//  332       (Meter[i].XPOS2, Meter[i].YPOS,
//  333       Y_COLOR[Meter[i].Track], 
//  334       PRN,
//  335       Num.str);                              // 显示测量数值
//  336     Print_Str
//  337       (Meter[i].XPOS2 +40, Meter[i].YPOS,
//  338       Y_COLOR[Meter[i].Track], 
//  339       PRN,
//  340       V_Unit[Num.decPos]);                   // 显示测量量纲
//  341     break;
//  342 //  case FRQ:
//  343 //    break;
//  344 //  case CIR:
//  345 //    break;
//  346 //  case DUT:
//  347 //    break;
//  348   }
//  349 }
??Display_Value_1:
        POP      {R4-R6,PC}       ;; return
??Display_Value_4:
        LDRH     R1,[R5, #+1162]
        UXTB     R1,R1
        ADDW     R0,R5,#+1148
        BL       u8ToDec2
        LDR.N    R4,??Display_Value_5  ;; Y_COLOR
        ADDW     R0,R5,#+1148
        PUSH     {R0,LR}
        CFI CFA R13+24
        MOVS     R3,#+0
        LDRB     R0,[R6, #+1044]
        LDRH     R2,[R4, R0, LSL #+1]
        LDRB     R1,[R6, #+1050]
        ADD      R0,R6,#+1048
        LDRH     R0,[R0, #+0]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+16
        ADD      R0,R4,#+12
        PUSH     {R0,LR}
        CFI CFA R13+24
        MOVS     R3,#+0
        LDRB     R0,[R6, #+1044]
        LDRH     R2,[R4, R0, LSL #+1]
        LDRB     R1,[R6, #+1050]
        ADD      R0,R6,#+1048
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+16
        B.N      ??Display_Value_3
        CFI CFA R13+16
??Display_Value_6:
        LDRB     R0,[R6, #+1044]
        CBNZ     R0,??Display_Value_7
        LDR.N    R0,??Display_Value_5+0x4  ;; A_Vpp
        LDRSH    R0,[R0, #+0]
        LDRSH    R1,[R5, #+56]
        MOVS     R2,#+20
        LDR.W    R3,??DataTable21  ;; Y_Attr
        LDR      R3,[R3, #+0]
        MLA      R1,R1,R2,R3
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
??Display_Value_7:
        LDRB     R0,[R6, #+1044]
        CMP      R0,#+1
        BNE.N    ??Display_Value_8
        LDR.N    R0,??Display_Value_5+0x8  ;; B_Vpp
        LDRSH    R0,[R0, #+0]
        LDRSH    R1,[R5, #+136]
        MOVS     R2,#+20
        LDR.W    R3,??DataTable21  ;; Y_Attr
        LDR      R3,[R3, #+0]
        MLA      R1,R1,R2,R3
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
??Display_Value_8:
        LDRB     R0,[R6, #+1044]
        CMP      R0,#+2
        BNE.N    ??Display_Value_9
        MOVS     R1,#+0
        ADDW     R0,R5,#+1164
??Display_Value_10:
        BL       Int32String_sign
??Display_Value_9:
        LDR.N    R4,??Display_Value_5  ;; Y_COLOR
        ADDW     R0,R5,#+1166
        PUSH     {R0,LR}
        CFI CFA R13+24
        MOVS     R3,#+0
        LDRB     R0,[R6, #+1044]
        LDRH     R2,[R4, R0, LSL #+1]
        LDRB     R1,[R6, #+1050]
        ADD      R0,R6,#+1048
        LDRH     R0,[R0, #+0]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+16
        LDRB     R0,[R5, #+1164]
        MOVS     R1,#+3
        MLA      R0,R0,R1,R5
        ADD      R0,R0,#+1192
        PUSH     {R0,LR}
        CFI CFA R13+24
        MOVS     R3,#+0
        LDRB     R0,[R6, #+1044]
        LDRH     R2,[R4, R0, LSL #+1]
        LDRB     R1,[R6, #+1050]
        ADD      R0,R6,#+1048
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+40
        B.N      ??Display_Value_3
        CFI CFA R13+16
??Display_Value_11:
        LDRB     R0,[R6, #+1044]
        CBNZ     R0,??Display_Value_12
        LDR.N    R0,??Display_Value_5+0xC  ;; A_Vdc
        LDRSH    R0,[R0, #+0]
        LDRSH    R1,[R5, #+56]
        MOVS     R2,#+20
        LDR.W    R3,??DataTable21  ;; Y_Attr
        LDR      R3,[R3, #+0]
        MLA      R1,R1,R2,R3
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
??Display_Value_12:
        LDRB     R0,[R6, #+1044]
        CMP      R0,#+1
        BNE.N    ??Display_Value_13
        LDR.N    R0,??Display_Value_5+0x10  ;; B_Vdc
        LDRSH    R0,[R0, #+0]
        LDRSH    R1,[R5, #+136]
        MOVS     R2,#+20
        LDR.W    R3,??DataTable21  ;; Y_Attr
        LDR      R3,[R3, #+0]
        MLA      R1,R1,R2,R3
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
??Display_Value_13:
        LDRB     R0,[R6, #+1044]
        CMP      R0,#+2
        BNE.N    ??Display_Value_14
        MOVS     R1,#+0
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
??Display_Value_14:
        LDRB     R0,[R6, #+1044]
        CMP      R0,#+3
        BNE.N    ??Display_Value_9
        MOVS     R1,#+0
        ADDW     R0,R5,#+1164
        B.N      ??Display_Value_10
??Display_Value_15:
        LDRB     R0,[R6, #+1044]
        CBNZ     R0,??Display_Value_16
        LDR.N    R0,??Display_Value_5+0x14  ;; A_Rms
        LDRSH    R0,[R0, #+0]
        LDRSH    R1,[R5, #+56]
        MOVS     R2,#+20
        LDR.W    R3,??DataTable21  ;; Y_Attr
        LDR      R3,[R3, #+0]
        MLA      R1,R1,R2,R3
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
??Display_Value_16:
        LDRB     R0,[R6, #+1044]
        CMP      R0,#+1
        BNE.N    ??Display_Value_17
        LDR.N    R0,??Display_Value_5+0x18  ;; B_Rms
        LDRSH    R0,[R0, #+0]
        LDRSH    R1,[R5, #+136]
        MOVS     R2,#+20
        LDR.W    R3,??DataTable21  ;; Y_Attr
        LDR      R3,[R3, #+0]
        MLA      R1,R1,R2,R3
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
??Display_Value_17:
        LDRB     R0,[R6, #+1044]
        CMP      R0,#+2
        BNE.N    ??Display_Value_18
        MOVS     R1,#+0
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
??Display_Value_18:
        LDRB     R0,[R6, #+1044]
        CMP      R0,#+3
        BNE.W    ??Display_Value_9
        MOVS     R1,#+0
        ADDW     R0,R5,#+1164
        B.N      ??Display_Value_10
??Display_Value_19:
        LDRB     R0,[R6, #+1044]
        CBNZ     R0,??Display_Value_20
        LDR.N    R0,??Display_Value_5+0x1C  ;; A_Max
        LDRSH    R0,[R0, #+0]
        LDRSH    R1,[R5, #+56]
        MOVS     R2,#+20
        LDR.W    R3,??DataTable21  ;; Y_Attr
        LDR      R3,[R3, #+0]
        MLA      R1,R1,R2,R3
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
??Display_Value_20:
        LDRB     R0,[R6, #+1044]
        CMP      R0,#+1
        BNE.N    ??Display_Value_21
        LDR.N    R0,??Display_Value_5+0x20  ;; B_Max
        LDRSH    R0,[R0, #+0]
        LDRSH    R1,[R5, #+136]
        MOVS     R2,#+20
        LDR.W    R3,??DataTable21  ;; Y_Attr
        LDR      R3,[R3, #+0]
        MLA      R1,R1,R2,R3
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
??Display_Value_21:
        LDRB     R0,[R6, #+1044]
        CMP      R0,#+2
        BNE.N    ??Display_Value_22
        MOVS     R1,#+0
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
??Display_Value_22:
        LDRB     R0,[R6, #+1044]
        CMP      R0,#+3
        BNE.W    ??Display_Value_9
        MOVS     R1,#+0
        ADDW     R0,R5,#+1164
        B.N      ??Display_Value_10
??Display_Value_23:
        LDRB     R0,[R6, #+1044]
        CBNZ     R0,??Display_Value_24
        LDR.N    R0,??Display_Value_5+0x24  ;; A_Min
        LDRSH    R0,[R0, #+0]
        LDRSH    R1,[R5, #+56]
        MOVS     R2,#+20
        LDR.W    R3,??DataTable21  ;; Y_Attr
        LDR      R3,[R3, #+0]
        MLA      R1,R1,R2,R3
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
??Display_Value_24:
        LDRB     R0,[R6, #+1044]
        CMP      R0,#+1
        BNE.N    ??Display_Value_25
        LDR.N    R0,??Display_Value_5+0x28  ;; B_Min
        LDRSH    R0,[R0, #+0]
        LDRSH    R1,[R5, #+136]
        MOVS     R2,#+20
        LDR.W    R3,??DataTable21  ;; Y_Attr
        LDR      R3,[R3, #+0]
        MLA      R1,R1,R2,R3
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
??Display_Value_25:
        LDRB     R0,[R6, #+1044]
        CMP      R0,#+2
        BNE.N    ??Display_Value_26
        MOVS     R1,#+0
        ADDW     R0,R5,#+1164
        BL       Int32String_sign
??Display_Value_26:
        LDRB     R0,[R6, #+1044]
        CMP      R0,#+3
        BNE.W    ??Display_Value_9
        MOVS     R1,#+0
        ADDW     R0,R5,#+1164
        B.N      ??Display_Value_10
        DATA
??Display_Value_5:
        DC32     Y_COLOR
        DC32     A_Vpp
        DC32     B_Vpp
        DC32     A_Vdc
        DC32     B_Vdc
        DC32     A_Rms
        DC32     B_Rms
        DC32     A_Max
        DC32     B_Max
        DC32     A_Min
        DC32     B_Min
        CFI EndBlock cfiBlock1
//  350 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Display_Title
        THUMB
//  351 void Display_Title(void)
//  352 {
Display_Title:
        PUSH     {R4-R11,LR}
        CFI R14 Frame(CFA, -4)
        CFI R11 Frame(CFA, -8)
        CFI R10 Frame(CFA, -12)
        CFI R9 Frame(CFA, -16)
        CFI R8 Frame(CFA, -20)
        CFI R7 Frame(CFA, -24)
        CFI R6 Frame(CFA, -28)
        CFI R5 Frame(CFA, -32)
        CFI R4 Frame(CFA, -36)
        CFI CFA R13+36
        SUB      SP,SP,#+4
        CFI CFA R13+40
//  353   u8  i, j;
//  354   
//  355   for(i = TRACK1; i <= VOLUME; ++i){
        MOV      R8,#+0
        LDR.W    R4,??DataTable23  ;; Title
        ADD      R0,R4,#+1176
        STR      R0,[SP, #+0]
        ADD      R5,R4,#+16
        LDR.W    R11,??DataTable15  ;; Twink
        MOV      R10,#+10
//  356     for(j = 0; j < 4; ++j){
??Display_Title_0:
        MOV      R9,#+0
        SUBS     R6,R5,#+6
//  357       if(Title[i][j].Flag & UPDAT){   // 需要刷新的Item
??Display_Title_1:
        LDRB     R0,[R6, #+8]
        TST      R0,#0x2
        BEQ.W    ??Display_Title_2
//  358         Title[i][j].Flag &= !UPDAT;   // Clr Update flag 
        MOVS     R0,#+0
        STRB     R0,[R6, #+8]
//  359         if((i == BATTERY)||(i == TRIGG)){
        UXTB     R0,R8
        CMP      R0,#+4
        BEQ.N    ??Display_Title_3
        CMP      R0,#+7
        BNE.N    ??Display_Title_4
//  360           if(Title[i][j].MARK & FIX){                  // ---- Under fix mode
??Display_Title_3:
        LDRB     R0,[R6, #+0]
        TST      R0,#0x20
        BEQ.N    ??Display_Title_5
//  361             Print_Str( 
//  362               Title[i][j].XPOS, Title[i][j].YPOS,
//  363               Title[i][j].Color[Title[i][0].Value],    // Color variable 
//  364               PRN, 
//  365               Title[i][j].Str                          // String fixed
//  366             );                    
        LDR      R0,[R6, #-10]
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDRSH    R0,[R5, R3]
        SUB      R1,R6,#+10
        LDR      R1,[R1, #+4]
        LDRH     R2,[R1, R0, LSL #+1]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  367           } else if(!(Title[i][j].MARK & NOT)){        // ---- Under other mode
??Display_Title_5:
        TST      R0,#0x80
        BNE.W    ??Display_Title_7
//  368             Print_Str(
//  369               Title[i][j].XPOS, Title[i][j].YPOS,
//  370               Title[i][j].Color[Title[i][0].Value],    // Color variable 
//  371               PRN, 
//  372               Title[i][j].Str +(Title[i][j].Value * 10)// String variable
//  373             ); 
        LDRSH    R0,[R6, #+6]
        LDR      R1,[R6, #-10]
        MLA      R0,R0,R10,R1
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDRSH    R0,[R5, R3]
        SUB      R1,R6,#+10
        LDR      R1,[R1, #+4]
        LDRH     R2,[R1, R0, LSL #+1]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  374           }
//  375         } else {
//  376           if(Title[i][j].MARK & FIX){                  // ---- Under fix mode
??Display_Title_4:
        LDRB     R0,[R6, #+0]
        TST      R0,#0x20
        BEQ.N    ??Display_Title_8
//  377             Print_Str(
//  378               Title[i][j].XPOS, Title[i][j].YPOS,
//  379               Title[i][j].Color[0],                    // Color fixed 
//  380               PRN, 
//  381               Title[i][j].Str                          // String fixed
//  382              );
??Display_Title_9:
        LDR      R0,[R6, #-10]
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        SUB      R0,R6,#+10
        LDR      R0,[R0, #+4]
        LDRH     R2,[R0, #+0]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  383           } else if(Title[i][j].MARK & NUM3){          // ---- Under NUM3 mode
??Display_Title_8:
        TST      R0,#0x2
        BEQ.W    ??Display_Title_10
//  384             if(i == V_VERNIE){
        UXTB     R0,R8
        CMP      R0,#+8
        BNE.N    ??Display_Title_11
//  385               Int32String_sign(&Num,(_V1_Vernie - _V2_Vernie)* _Meas_V_Scale);
        LDRSH    R0,[R4, #+656]
        LDRSH    R1,[R4, #+676]
        SUBS     R0,R0,R1
        LDRSH    R1,[R4, #+696]
        MOVS     R2,#+80
        MLA      R1,R1,R2,R4
        LDRSH    R1,[R1, #+56]
        MOVS     R2,#+20
        LDR.W    R3,??DataTable21  ;; Y_Attr
        LDR      R3,[R3, #+0]
        MLA      R1,R1,R2,R3
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADDW     R0,R4,#+1164
        BL       Int32String_sign
//  386               Print_Str(
//  387                 Title[i][j].XPOS, Title[i][j].YPOS,
//  388                 Title[i][j].Color[_Meas_V_Track],      // Color fixed  
//  389                 PRN, 
//  390                 Num.str                                // String for numerical
//  391               );
        SUB      R7,R6,#+10
        ADDW     R0,R4,#+1166
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDRSH    R0,[R4, #+696]
        LDR      R1,[R7, #+4]
        LDRH     R2,[R1, R0, LSL #+1]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  392               Print_Str(
//  393                 Title[i][j].XPOS + 40, Title[i][j].YPOS,
//  394                 Title[i][j].Color[_Meas_V_Track],      // Color fixed  
//  395                 PRN, 
//  396                 V_Unit[Num.decPos]                     // String variable
//  397               );
        LDRB     R0,[R4, #+1164]
        MOVS     R1,#+3
        MLA      R0,R0,R1,R4
        ADD      R0,R0,#+1192
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDRSH    R0,[R4, #+696]
        LDR      R1,[R7, #+4]
        LDRH     R2,[R1, R0, LSL #+1]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        ADDS     R0,R0,#+40
        UXTH     R0,R0
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  398             }
//  399             if(i == T_VERNIE){
??Display_Title_11:
        UXTB     R0,R8
        CMP      R0,#+10
        BNE.N    ??Display_Title_12
//  400               Int32String_sign(&Num,(_T2_Vernie - _T1_Vernie)* _T_Scale);
        LDRSH    R0,[R4, #+836]
        LDRSH    R1,[R4, #+816]
        SUBS     R0,R0,R1
        LDRSH    R1,[R4, #+436]
        MOVS     R2,#+20
        LDR.N    R3,??DataTable22  ;; X_Attr
        LDR      R3,[R3, #+0]
        MLA      R1,R1,R2,R3
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADDW     R0,R4,#+1164
        BL       Int32String_sign
//  401               Print_Str(
//  402                 Title[i][j].XPOS, Title[i][j].YPOS,
//  403                 Title[i][j].Color[0],                  // Color fixed  
//  404                 PRN, 
//  405                 Num.str                                // String for numerical
//  406               );
        SUB      R7,R6,#+10
        ADDW     R0,R4,#+1166
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDR      R0,[R7, #+4]
        LDRH     R2,[R0, #+0]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  407               Print_Str(
//  408                 Title[i][j].XPOS + 40, Title[i][j].YPOS,
//  409                 Title[i][j].Color[0],                  // Color fixed  
//  410                 PRN, 
//  411                 T_Unit[Num.decPos]                     // String variable
//  412               );
        LDRB     R0,[R4, #+1164]
        MOVS     R1,#+3
        MLA      R0,R0,R1,R4
        ADDW     R0,R0,#+1204
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDR      R0,[R7, #+4]
        LDRH     R2,[R0, #+0]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        ADDS     R0,R0,#+40
        UXTH     R0,R0
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  413             }
//  414             if(i == FILE){
??Display_Title_12:
        UXTB     R0,R8
        CMP      R0,#+9
        BNE.W    ??Display_Title_7
//  415               u8ToDec3(Title[i][1].Str, Title[i][1].Value);
        LDRH     R1,[R5, #+20]
        UXTB     R1,R1
        LDR      R0,[R5, #+4]
        BL       u8ToDec3
//  416               Print_Str(
//  417                 Title[i][1].XPOS, Title[i][1].YPOS,
//  418                 Title[i][1].Color[0],                  // Color fixed  
//  419                 PRN, 
//  420                 Title[i][1].Str                        // String for numerical
//  421               );
        LDR      R0,[R5, #+4]
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDR      R0,[R5, #+8]
        LDRH     R2,[R0, #+0]
        LDRB     R1,[R5, #+18]
        LDRH     R0,[R5, #+16]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  422             }
//  423           } else if(Title[i][j].MARK == NUM2){ 
??Display_Title_10:
        CMP      R0,#+1
        BNE.N    ??Display_Title_13
//  424                 NumStr[0]=' ';
        MOVS     R0,#+32
        STRB     R0,[R4, #+1148]
//  425             if(i == BK_LIGHT){                        // 背光百分比显示处理
        LDRSH    R0,[R6, #+6]
        UXTB     R1,R8
        CMP      R1,#+11
        BNE.N    ??Display_Title_14
//  426               if(Title[i][j].Value == 9){
        CMP      R0,#+9
        BNE.N    ??Display_Title_15
//  427                 NumStr[0]='1';
??Display_Title_16:
        MOVS     R0,#+49
        STRB     R0,[R4, #+1148]
//  428                 NumStr[1]='0';
        MOVS     R0,#+48
        STRB     R0,[R4, #+1149]
//  429                 NumStr[2]='0';
        STRB     R0,[R4, #+1150]
        B.N      ??Display_Title_17
//  430               } else  
//  431                 u8ToDec2(NumStr+1, 10*(Title[i][j].Value+1)); 
??Display_Title_15:
        ADDS     R0,R0,#+1
        MOVS     R1,#+10
        MULS     R1,R0,R1
        UXTB     R1,R1
        ADDW     R0,R4,#+1149
        B.N      ??Display_Title_18
//  432             } else {                                  // 音量百分比显示处理
//  433               if(Title[i][j].Value == 10){
??Display_Title_14:
        CMP      R0,#+10
        BEQ.N    ??Display_Title_16
//  434                 NumStr[0]='1';
//  435                 NumStr[1]='0';
//  436                 NumStr[2]='0';
//  437               } else  u8ToDec2(NumStr+1, 10*Title[i][j].Value); 
        MOVS     R1,#+10
        MULS     R1,R0,R1
        UXTB     R1,R1
        ADDW     R0,R4,#+1149
??Display_Title_18:
        BL       u8ToDec2
//  438             }
//  439             Print_Str(
//  440               Title[i][j].XPOS, Title[i][j].YPOS,
//  441               Title[i][j].Color[0],                  // Color fixed  
//  442               PRN, 
//  443               NumStr                        // String for numerical
//  444             );
??Display_Title_17:
        SUB      R7,R6,#+10
        ADDW     R0,R4,#+1148
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDR      R0,[R7, #+4]
        LDRH     R2,[R0, #+0]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  445             Print_Str(
//  446               Title[i][j].XPOS+24, Title[i][j].YPOS,
//  447               Title[i][j].Color[0],                  // Color fixed  
//  448               PRN, 
//  449               "%"                        
//  450             );
        ADR.N    R0,??Display_Title_19  ;; "%"
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDR      R0,[R7, #+4]
        LDRH     R2,[R0, #+0]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        ADDS     R0,R0,#+24
        UXTH     R0,R0
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  451           } else if(Title[i][j].MARK != NOT){
??Display_Title_13:
        CMP      R0,#+128
        BEQ.N    ??Display_Title_20
//  452           
//  453             if(i == V_VERNIE){
        SUB      R7,R6,#+10
        UXTB     R0,R8
        CMP      R0,#+8
        BNE.N    ??Display_Title_21
//  454               Print_Str(
//  455                 Title[i][j].XPOS, Title[i][j].YPOS,
//  456                 Title[i][j].Color[_Meas_V_Track],         // Color variable 
//  457                 PRN, 
//  458                 Title[i][j].Str +(Title[i][j].Value * 10)// String variable
//  459               ); 
        LDRSH    R0,[R6, #+6]
        LDR      R1,[R6, #-10]
        MLA      R0,R0,R10,R1
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDRSH    R0,[R4, #+696]
        LDR      R1,[R7, #+4]
        LDRH     R2,[R1, R0, LSL #+1]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  460             } else {
//  461               Print_Str(
//  462                 Title[i][j].XPOS, Title[i][j].YPOS,
//  463                 Title[i][j].Color[0],                    // Color fixed 
//  464                 PRN, 
//  465                 Title[i][j].Str +(Title[i][j].Value * 10)// String variable
//  466               ); 
??Display_Title_21:
        LDRSH    R0,[R6, #+6]
        LDR      R1,[R6, #-10]
        MLA      R0,R0,R10,R1
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDR      R0,[R7, #+4]
        LDRH     R2,[R0, #+0]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  467             }
//  468           } else if(i == T_VERNIE){
??Display_Title_20:
        UXTB     R0,R8
        CMP      R0,#+10
        BNE.W    ??Display_Title_7
        B.N      ??Display_Title_9
//  469             Print_Str(
//  470               Title[i][j].XPOS, Title[i][j].YPOS,
//  471               Title[i][j].Color[0],                    // Color fixed 
//  472               PRN, 
//  473               Title[i][j].Str                          // String variable
//  474             ); 
//  475           }
//  476         }
//  477       } else if((Current == i)&&(Detail[i] == j)&&(Blink)){ // 当前光标位置的Item
??Display_Title_2:
        ADD      R0,R4,#+1160
        LDRB     R0,[R0, #+0]
        UXTB     R1,R8
        CMP      R0,R1
        BNE.W    ??Display_Title_7
        LDR      R0,[SP, #+0]
        LDRB     R0,[R0, #+0]
        UXTB     R1,R9
        CMP      R0,R1
        BNE.N    ??Display_Title_7
        LDR.N    R0,??DataTable19  ;; Blink
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Display_Title_7
//  478         Blink = 0;
        LDR.N    R0,??DataTable19  ;; Blink
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  479         if((i == BATTERY)||(i == TRIGG)){
        UXTB     R0,R8
        CMP      R0,#+4
        BEQ.N    ??Display_Title_22
        CMP      R0,#+7
        BNE.N    ??Display_Title_23
//  480           if((Title[i][j].MARK & FIX)){      // ---- Under fix mode
??Display_Title_22:
        SUB      R7,R6,#+10
        LDRB     R0,[R6, #+0]
        TST      R0,#0x20
        BEQ.N    ??Display_Title_24
//  481             Print_Str( 
//  482               Title[i][j].XPOS, Title[i][j].YPOS,
//  483               Title[i][j].Color[Title[i][0].Value],    // Color variable 
//  484               Twink, 
//  485               Title[i][j].Str                          // String fixed
//  486             );                    
        LDR      R0,[R6, #-10]
        PUSH     {R0,LR}
        CFI CFA R13+48
        LDRB     R3,[R11, #+0]
        LDRSH    R0,[R5, R1]
        LDR      R1,[R7, #+4]
        LDRH     R2,[R1, R0, LSL #+1]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  487           } else {                                // ---- Under other mode
//  488             Print_Str(
//  489               Title[i][j].XPOS, Title[i][j].YPOS,
//  490               Title[i][j].Color[Title[i][0].Value],    // Color variable 
//  491               Twink, 
//  492               Title[i][j].Str +(Title[i][j].Value * 10)// String variable
//  493             ); 
??Display_Title_24:
        LDRSH    R0,[R6, #+6]
        LDR      R1,[R6, #-10]
        MLA      R0,R0,R10,R1
        PUSH     {R0,LR}
        CFI CFA R13+48
        LDRB     R3,[R11, #+0]
        LDRSH    R0,[R5, #+0]
        LDR      R1,[R7, #+4]
        LDRH     R2,[R1, R0, LSL #+1]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  494           }
//  495         } else {
//  496           if(Title[i][j].MARK & FIX){             // ---- Under fix mode
??Display_Title_23:
        SUB      R7,R6,#+10
        LDRB     R0,[R6, #+0]
        TST      R0,#0x20
        BEQ.N    ??Display_Title_25
//  497             Print_Str(
//  498               Title[i][j].XPOS, Title[i][j].YPOS,
//  499               Title[i][j].Color[0],                    // Color fixed 
//  500               Twink, 
//  501               Title[i][j].Str                          // String fixed
//  502             );
        LDR      R0,[R6, #-10]
        PUSH     {R0,LR}
        CFI CFA R13+48
        LDRB     R3,[R11, #+0]
        LDR      R0,[R7, #+4]
        LDRH     R2,[R0, #+0]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  503           } else {
//  504             if(i == V_VERNIE){
??Display_Title_25:
        UXTB     R0,R8
        CMP      R0,#+8
        BNE.N    ??Display_Title_26
//  505               Print_Str(
//  506                 Title[i][j].XPOS, Title[i][j].YPOS,
//  507                 Title[i][j].Color[_Meas_V_Track],        // Color variable=
//  508                 Twink, 
//  509                 Title[i][j].Str +(Title[i][j].Value * 10)// String variable
//  510               ); 
        LDRSH    R0,[R6, #+6]
        LDR      R1,[R6, #-10]
        MLA      R0,R0,R10,R1
        PUSH     {R0,LR}
        CFI CFA R13+48
        LDRB     R3,[R11, #+0]
        LDRSH    R0,[R4, #+696]
        LDR      R1,[R7, #+4]
        LDRH     R2,[R1, R0, LSL #+1]
        B.N      ??Display_Title_27
        CFI CFA R13+40
//  511             } else {
//  512               Print_Str(
//  513                 Title[i][j].XPOS, Title[i][j].YPOS,
//  514                 Title[i][j].Color[0],                    // Color fixed 
//  515                 Twink, 
//  516                 Title[i][j].Str +(Title[i][j].Value * 10)// String variable
//  517               ); 
??Display_Title_26:
        LDRSH    R0,[R6, #+6]
        LDR      R1,[R6, #-10]
        MLA      R0,R0,R10,R1
        PUSH     {R0,LR}
        CFI CFA R13+48
        LDRB     R3,[R11, #+0]
        LDR      R0,[R7, #+4]
        LDRH     R2,[R0, #+0]
??Display_Title_27:
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  518             }
//  519             if((i == FILE)&&(Title[i][j].MARK & NUM3)){
        UXTB     R0,R8
        CMP      R0,#+9
        BNE.N    ??Display_Title_7
        LDRB     R0,[R6, #+0]
        TST      R0,#0x2
        BEQ.N    ??Display_Title_7
//  520               u8ToDec3(Title[i][1].Str, Title[i][1].Value);
        LDRH     R1,[R5, #+20]
        UXTB     R1,R1
        LDR      R0,[R5, #+4]
        BL       u8ToDec3
//  521               Print_Str(
//  522                 Title[i][1].XPOS, Title[i][1].YPOS,
//  523                 Title[i][1].Color[0],                  // Color fixed  
//  524                 Twink, 
//  525                 Title[i][1].Str                        // String for numerical
//  526               );
        LDR      R0,[R5, #+4]
        PUSH     {R0,LR}
        CFI CFA R13+48
        LDRB     R3,[R11, #+0]
        LDR      R0,[R5, #+8]
        LDRH     R2,[R0, #+0]
        LDRB     R1,[R5, #+18]
        LDRH     R0,[R5, #+16]
??Display_Title_6:
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  527             }
//  528           }
//  529         }
//  530       }
//  531     }
??Display_Title_7:
        ADD      R9,R9,#+1
        ADDS     R6,R6,#+20
        UXTB     R0,R9
        CMP      R0,#+4
        BCC.W    ??Display_Title_1
//  532   }
        ADD      R8,R8,#+1
        ADDS     R5,R5,#+80
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+0]
        UXTB     R0,R8
        CMP      R0,#+13
        BCC.W    ??Display_Title_0
//  533 }
        ADD      SP,SP,#+4
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        DATA
??Display_Title_19:
        DC8      "%",+0,+0
        CFI EndBlock cfiBlock2

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable15:
        DC32     Twink

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable19:
        DC32     Blink
//  534 /*******************************************************************************
//  535  Load_Attr:  加载硬件属性
//  536 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Load_Attr
        THUMB
//  537 void Load_Attr(void)
//  538 {
Load_Attr:
        PUSH     {R4-R9,LR}
        CFI R14 Frame(CFA, -4)
        CFI R9 Frame(CFA, -8)
        CFI R8 Frame(CFA, -12)
        CFI R7 Frame(CFA, -16)
        CFI R6 Frame(CFA, -20)
        CFI R5 Frame(CFA, -24)
        CFI R4 Frame(CFA, -28)
        CFI CFA R13+28
        SUB      SP,SP,#+4
        CFI CFA R13+32
//  539   u16 i;
//  540   
//  541   for(i=0; i<G_Attr[0].Yp_Max+1; ++i) 
        MOVS     R6,#+0
        LDR.N    R4,??DataTable23  ;; Title
        ADD      R7,R4,#+1216
        MOV      R8,R6
        LDR.W    R9,??DataTable21  ;; Y_Attr
        LDR.N    R5,??Load_Attr_0  ;; G_Attr
        LDR      R0,[R5, #+0]
        LDRH     R0,[R0, #+4]
        ADDS     R0,R0,#+1
        CMP      R0,#+1
        BLT.N    ??Load_Attr_1
//  542     strcpy(&Vertical[i][0], Y_Attr[i].STR);
??Load_Attr_2:
        LDR      R0,[R9, #+0]
        ADD      R1,R8,R0
        MOVS     R0,R7
        BL       strcpy
        ADDS     R6,R6,#+1
        UXTH     R6,R6
        ADD      R8,R8,#+20
        ADDS     R7,R7,#+10
        LDR      R0,[R5, #+0]
        LDRH     R0,[R0, #+4]
        ADDS     R0,R0,#+1
        CMP      R6,R0
        BLT.N    ??Load_Attr_2
//  543   Title[TRACK1][RANGE].Limit = G_Attr[0].Yp_Max;
??Load_Attr_1:
        LDR      R0,[R5, #+0]
        LDRSH    R1,[R0, #+4]
        STRH     R1,[R4, #+48]
//  544   Title[TRACK2][RANGE].Limit = G_Attr[0].Yp_Max;
        LDRSH    R1,[R0, #+4]
        STRH     R1,[R4, #+128]
//  545   Title[TRACK3][RANGE].Limit = 0;
        MOVS     R1,#+0
        STRH     R1,[R4, #+208]
//  546   Title[TRACK4][RANGE].Limit = 0;
        STRH     R1,[R4, #+288]
//  547   
//  548   for(i=0; i<G_Attr[0].Xp_Max+1; ++i) 
        MOVS     R6,#+0
        ADD      R7,R4,#+1368
        MOV      R8,R1
        LDR.W    R9,??DataTable22  ;; X_Attr
        LDRH     R0,[R0, #+6]
        ADDS     R0,R0,#+1
        CMP      R0,#+1
        BLT.N    ??Load_Attr_3
//  549     strcpy(&BaseStr[i][0], X_Attr[i].STR);
??Load_Attr_4:
        LDR      R0,[R9, #+0]
        ADD      R1,R8,R0
        MOVS     R0,R7
        BL       strcpy
        ADDS     R6,R6,#+1
        UXTH     R6,R6
        ADD      R8,R8,#+20
        ADDS     R7,R7,#+10
        LDR      R0,[R5, #+0]
        LDRH     R0,[R0, #+6]
        ADDS     R0,R0,#+1
        CMP      R6,R0
        BLT.N    ??Load_Attr_4
//  550   Title[T_BASE][BASE].Limit = G_Attr[0].Xp_Max;
??Load_Attr_3:
        LDR      R0,[R5, #+0]
        LDRSH    R0,[R0, #+6]
        STRH     R0,[R4, #+428]
//  551   
//  552 }
        ADD      SP,SP,#+4
        CFI CFA R13+28
        POP      {R4-R9,PC}       ;; return
        Nop      
        DATA
??Load_Attr_0:
        DC32     G_Attr
        CFI EndBlock cfiBlock3

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable21:
        DC32     Y_Attr

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable22:
        DC32     X_Attr
//  553 /*******************************************************************************
//  554  Update_Battery:  刷新电池电量指示
//  555 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Update_Battery
        THUMB
//  556 void Update_Battery(void)
//  557 {
Update_Battery:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  558   u16 Vb, Level;
//  559   
//  560   Vb = __Get(V_BATTERY);
        MOVS     R0,#+6
        BL       __Get
        UXTH     R0,R0
//  561   Level =0;
        MOVS     R1,#+0
//  562   if(Vb > 3000 ) Level +=1;
        MOVW     R3,#+3001
        CMP      R0,R3
        IT       CS 
        MOVCS    R1,#+1
//  563   if(Vb > 3500 ) Level +=1;
        MOVW     R3,#+3501
        CMP      R0,R3
        BCC.N    ??Update_Battery_0
        ADDS     R1,R1,#+1
        UXTH     R1,R1
//  564   if(Vb > 3900 ) Level +=1;
??Update_Battery_0:
        MOVW     R3,#+3901
        CMP      R0,R3
        BCC.N    ??Update_Battery_1
        ADDS     R1,R1,#+1
        UXTH     R1,R1
//  565   if(Vb > 4100 ) Level +=1;
??Update_Battery_1:
        MOVW     R2,#+4101
        CMP      R0,R2
        BCC.N    ??Update_Battery_2
        ADDS     R1,R1,#+1
        UXTH     R1,R1
//  566   Print_Str(
//  567     Title[4][1].XPOS, Title[4][1].YPOS,
//  568     Title[4][1].Color[Level], 
//  569     PRN,
//  570     (Title[4][1].Str + Level*10) 
//  571   );    
??Update_Battery_2:
        LDR.N    R0,??DataTable23  ;; Title
        MOVS     R2,#+10
        LDR      R3,[R0, #+340]
        MLA      R2,R1,R2,R3
        PUSH     {R2,LR}
        CFI CFA R13+16
        MOVS     R3,#+0
        LDR      R2,[R0, #+344]
        LDRH     R2,[R2, R1, LSL #+1]
        ADD      R1,R0,#+354
        LDRB     R1,[R1, #+0]
        LDRH     R0,[R0, #+352]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+8
//  572 }
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock4

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable23:
        DC32     Title

        END
//  573 /******************************** END OF FILE *********************************/
// 
//     1 byte  in section .bss
// 1 701 bytes in section .data
// 1 032 bytes in section .rodata
// 2 328 bytes in section .text
// 
// 2 328 bytes of CODE  memory
// 1 032 bytes of CONST memory
// 1 702 bytes of DATA  memory
//
//Errors: none
//Warnings: 4
