///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  11:08:21 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\APP_V2.51\source\Menu.c                /
//    Command line =  E:\Mini-DS\DS203\APP_V2.51\source\Menu.c -lA            /
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
//    List file    =  E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\List\Menu.s   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Menu

        EXTERN Blink
        EXTERN G_Attr
        EXTERN Int2Str
        EXTERN Int_sqrt
        EXTERN Interlace
        EXTERN Ka1
        EXTERN Ka2
        EXTERN Kb1
        EXTERN Kb2
        EXTERN PaS
        EXTERN PbS
        EXTERN PcS
        EXTERN PdS
        EXTERN Power
        EXTERN Print_Str
        EXTERN TaN
        EXTERN TaS
        EXTERN TbN
        EXTERN TbS
        EXTERN TcN
        EXTERN TcS
        EXTERN TdN
        EXTERN TdS
        EXTERN Twink
        EXTERN X_Attr
        EXTERN Y_Attr
        EXTERN __Get
        EXTERN a_Avg
        EXTERN a_Max
        EXTERN a_Min
        EXTERN a_Ssq
        EXTERN b_Avg
        EXTERN b_Max
        EXTERN b_Min
        EXTERN b_Ssq
        EXTERN strcpy
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
        PUBLIC F_UNIT
        PUBLIC Load_Attr
        PUBLIC METER
        PUBLIC MODESTR
        PUBLIC Meter
        PUBLIC NO_DEF
        PUBLIC NO_RANGE
        PUBLIC N_UNIT
        PUBLIC NumStr
        PUBLIC O_COLOR
        PUBLIC P_UNIT
        PUBLIC Result_FPS
        PUBLIC STATESTR
        PUBLIC S_Inv
        PUBLIC S_UNIT
        PUBLIC TRIGSTR
        PUBLIC TR_TYPE
        PUBLIC T_COLOR
        PUBLIC T_INV
        PUBLIC T_UNIT
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
        PUBLIC V_UNIT
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
        
// E:\Mini-DS\DS203\APP_V2.51\source\Menu.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : Menu.c  
//    3  Version   : DS203_APP Ver 2.5x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include <string.h>
//    6 #include "Interrupt.h"
//    7 #include "Function.h"
//    8 #include "Process.h"
//    9 #include "Menu.h"
//   10 #include "Draw.h"
//   11 #include "BIOS.h"
//   12 
//   13 //I32STR_RES Num;
//   14 
//   15 u16 Result_FPS;
//   16 
//   17 //  u8 N[20];
//   18 //uc8 T_UNIT[12] ={'A','B', 0 ,'C','D', 0 ,'E','F', 0 ,'G','H', 0 };

        SECTION `.rodata`:CONST:NOROOT(2)
//   19 uc8 T_UNIT[12] ={'u','S', 0 ,'u','S', 0 ,'m','S', 0 ,'S',' ', 0 };
//   20 uc8 V_UNIT[12] ={'m','V', 0 ,'m','V', 0 ,'V',' ', 0 ,'k','V', 0 };
//   21 uc8 F_UNIT[12] ={'H','z', 0 ,'H','z', 0 ,'K','C', 0 ,'M','C', 0 };
//   22 uc8 N_UNIT[12] ={ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 };
//   23 uc8 S_UNIT[12] ={'/','S','e','c', 0 ,'/','S','e','c', 0 , 0 , 0 };
//   24 uc8 P_UNIT[12] ={'%',' ', 0 ,'%',' ', 0 ,'%',' ', 0 , 0 , 0 , 0 };
//   25 //u8 V_Unit[4][3]={"uV","mV","V ","kV"};
//   26 //u8 T_Unit[5][3]={"nS","uS","mS","S ","  "};
//   27 //u8 F_Unit[5][4]={"Hz","Hz","KC","MC","  "};
//   28 
//   29 uc8 STATESTR[3][10] = {"!RUN!", "HOLD", "HOLD"};                  // Running state str
//   30 
//   31 uc16 S_Inv[3]       = {(SCRN<<8)+TEXT2, (SCRN<<8)+X_POSI, (SCRN<<8)+NOTE1};         // Running state Color
//   32 
//   33 uc8 BATT_STR[5][10] = {"~``'", "~``}", "~`;}", "~;;}", "{;;}"};   // Battery Status Str
//   34 uc16 B_COLOR[5]     = {(NOTE1<<8)+SCRN, (SIDE <<8)+SCRN,
//   35                        (TEXT2<<8)+SCRN, (TEXT2<<8)+SCRN,
//   36                        (TEXT2<<8)+SCRN};                          // Battery Status Color
//   37 
//   38 uc8 CH_A_STR[2][10]  = {" HIDE ", "!CH(A)!"};
//   39 uc8 CH_B_STR[2][10]  = {" HIDE ", "!CH(B)!"};
//   40 uc8 CH_C_STR[2][10]  = {" HIDE ", "!CH(C)!"};
//   41 uc8 CH_D_STR[10][10] = {" HIDE ", "!CH(D)!", "!(A+B)!", "!(A-B)!",  
//   42                      "!(C&D)!", "!(C|D)!", "!REC_A!",  "!REC_B!",
//   43                         "!REC_C!",  "!REC_D!"};                      // Track source Str
//   44 uc8 NO_RANGE[5]      = " -- ";                       
//   45 uc8 NO_DEF[5]        = "--";                       
//   46 
//   47 uc8  YCOUPLE[3][10]  = {"DC", "AC", "!-!"};                        // Track Couple Str                    
//   48 u8   Vertical[15][10];                                             // Track Range Str
//   49 uc8  YPOSISTR[5]    = {"YPOS"};                                    // Track Position Str 
//   50 uc16 Y_INV[5]       = {(SCRN<<8)+TR_1, (SCRN<<8)+TR_2,
//   51                        (SCRN<<8)+TR_3, (SCRN<<8)+TR_4,
//   52                        (SCRN<<8)+VERNIE};                          // Track Color 1
//   53 uc16 Y_COLOR[5]     = {(TR_1<<8)+SCRN, (TR_2<<8)+SCRN,
Y_COLOR:
        DATA
        DC16 5, 261, 517, 773, 1029
        DC8 0, 0
T_UNIT:
        DC8 117, 83, 0, 117, 83, 0, 109, 83, 0, 83, 32, 0
V_UNIT:
        DC8 109, 86, 0, 109, 86, 0, 86, 32, 0, 107, 86, 0
F_UNIT:
        DC8 72, 122, 0, 72, 122, 0, 75, 67, 0, 77, 67, 0
S_UNIT:
        DC8 47, 83, 101, 99, 0, 47, 83, 101, 99, 0, 0, 0
P_UNIT:
        DC8 37, 32, 0, 37, 32, 0, 37, 32, 0, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
N_UNIT:
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
STATESTR:
        DATA
        DC8 "!RUN!"
        DC8 0, 0, 0, 0
        DC8 "HOLD"
        DC8 0, 0, 0, 0, 0
        DC8 "HOLD"
        DC8 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
S_Inv:
        DATA
        DC16 1291, 1286, 1295
        DC8 0, 0

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
        DC8 "!REC_A!"
        DC8 0, 0
        DC8 "!REC_B!"
        DC8 0, 0
        DC8 "!REC_C!"
        DC8 0, 0
        DC8 "!REC_D!"
        DC8 0, 0

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
//   54                        (TR_3<<8)+SCRN, (TR_4<<8)+SCRN,
//   55                        (VERNIE<<8)+SCRN};                          // Track Color 2
//   56 

        SECTION `.rodata`:CONST:NOROOT(2)
//   57 uc8 MODESTR[5][10]  = {"!AUTO!", "!NORM!", "SINGL", "!NONE!",
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
//   58                        "!SCAN!"};                                  // Sync Mode Str
//   59 u8   BaseStr[30][10];                                              // Time Base b Str

        SECTION `.rodata`:CONST:NOROOT(2)
//   60 uc8  XPOSISTR[5]    = {"XPOS"};
XPOSISTR:
        DATA
        DC8 "XPOS"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
//   61 uc16 XCOLOR[2]      = {(SCRN<<8)+X_POSI, (X_POSI<<8)+SCRN};        // Time Base Color
XCOLOR:
        DATA
        DC16 1286, 1541
//   62 

        SECTION `.rodata`:CONST:NOROOT(2)
//   63 uc8 FO_TYPE[4][10]  = {" SINE ",  "Triang",  " !Saw! ",  "Square"}; // Output Kind Str  "Kd=  %"
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
//   64 

        SECTION `.rodata`:CONST:NOROOT(2)
//   65 uc8 FO_STR[20][10]  = {" 10Hz ",  " 20Hz ",  " 50Hz ",   " 100Hz",
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
//   66                        "!200Hz!", "!500Hz!", " 1KHz ",   " 2KHz ",
//   67                        " 5KHz ",  "!10KHz!", "!20KHz!",  "!50KHz!",
//   68                        "100KHz",  "200KHz",  "500KHz",   " 1MHz ",
//   69                        " 2MHz ",  " 4MHz ",  " 6MHz ",   " 8MHz "}; // Output Frequency Str
//   70 

        SECTION `.rodata`:CONST:NOROOT(2)
//   71 uc16 O_COLOR[2]     = {(SCRN<<8)+TEXT3, (TEXT3<<8)+SCRN};         // Output Frequency Color
O_COLOR:
        DATA
        DC16 1292, 3077
//   72 

        SECTION `.rodata`:CONST:NOROOT(2)
//   73 uc8  TRIGSTR[8][10] = {"TRIGG", "TRIGG", "TRIGG", "TRIGG"};      // Trigger source Str
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
//   74                           

        SECTION `.rodata`:CONST:NOROOT(2)
//   75 uc8  TR_TYPE[8][10] = {":!\\!", ":!^!", "<Vt", ">Vt",            // Trigger Type Str
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
//   76                        "<TL",   ">TL",  "<TH", ">TH"};

        SECTION `.rodata`:CONST:NOROOT(2)
//   77 uc8  VT_STR[9]      =  "THRESHOL";                                // Trigg Voltage Str
VT_STR:
        DATA
        DC8 "THRESHOL"
        DC8 0, 0, 0
//   78                           

        SECTION `.rodata`:CONST:NOROOT(2)
//   79 uc8  VERNIE1[5]     = {"!V1!"};          // V1 Vernie Str
VERNIE1:
        DATA
        DC8 "!V1!"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
//   80 uc8  VERNIE2[5]     = {"!V2!"};          // V2 Vernie Str
VERNIE2:
        DATA
        DC8 "!V2!"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
//   81 uc8  VERNIE3[5]     = {"!T1!"};          // T1 Vernie Str
VERNIE3:
        DATA
        DC8 "!T1!"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
//   82 uc8  VERNIE4[5]     = {"!T2!"};          // T2 Vernie Str
VERNIE4:
        DATA
        DC8 "!T2!"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(1)
//   83 uc16 V_INV[1]       = {(SCRN<<8)+VERNIE};
V_INV:
        DATA
        DC16 1284

        SECTION `.rodata`:CONST:NOROOT(1)
//   84 uc16 V_COLOR[1]     = {(VERNIE<<8)+SCRN};                         // Y Vernie Color
V_COLOR:
        DATA
        DC16 1029

        SECTION `.rodata`:CONST:NOROOT(1)
//   85 uc16 T_INV[1]       = {(SCRN<<8)+VERNIE};
T_INV:
        DATA
        DC16 1284

        SECTION `.rodata`:CONST:NOROOT(1)
//   86 uc16 T_COLOR[1]        = {(VERNIE<<8)+SCRN};                         // X Vernie Color
T_COLOR:
        DATA
        DC16 1029

        SECTION `.rodata`:CONST:NOROOT(2)
//   87 uc8  F_FUNC[2][10]  = {"Save File", "Load File"};                 // File Function Str
F_FUNC:
        DATA
        DC8 "Save File"
        DC8 "Load File"
//   88 

        SECTION `.rodata`:CONST:NOROOT(2)
//   89 uc8  F_EXT[8][10]   = {".BMP?", ".DAT?", ".BUF?",".CSV?", " OK! ",
F_EXT:
        DATA
        DC8 ".BMP?"
        DC8 0, 0, 0, 0
        DC8 ".DAT?"
        DC8 0, 0, 0, 0
        DC8 ".BUF?"
        DC8 0, 0, 0, 0
        DC8 ".CSV?"
        DC8 0, 0, 0, 0
        DC8 " OK! "
        DC8 0, 0, 0, 0
        DC8 " ERR!"
        DC8 0, 0, 0, 0
        DC8 ".HEX"
        DC8 0, 0, 0, 0, 0
        DC8 ".BIN"
        DC8 0, 0, 0, 0, 0
//   90                          " ERR!",".HEX", ".BIN",};                  // File Ext Name Str

        SECTION `.rodata`:CONST:NOROOT(1)
//   91 uc16 F_INV[1]       = {(SCRN<<8)+TEXT1};                          //  File Color
F_INV:
        DATA
        DC16 1290

        SECTION `.rodata`:CONST:NOROOT(2)
//   92 uc8  DELTA_V[2][10] = {"[V:", "[V:"};
DELTA_V:
        DATA
        DC8 "[V:"
        DC8 0, 0, 0, 0, 0, 0
        DC8 "[V:"
        DC8 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
//   93 uc8  DELTA_T[4]     = "[T:";
DELTA_T:
        DATA
        DC8 "[T:"

        SECTION `.rodata`:CONST:NOROOT(2)
//   94 uc8  METER[12][5]   = {"Vbt", "FPS", "Vpp", "Vdc", "RMS",  "Max", 
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
        DC8 "FRQ"
        DC8 0
        DC8 "CIR"
        DC8 0
        DC8 "DUT"
        DC8 0
        DC8 "!TH!"
        DC8 "!TL!"
//   95                        "Min", "FRQ", "CIR", "DUT", "!TH!", "!TL!"};
//   96 
//   97 u8   Detail[14], NumStr[12];

        SECTION `.bss`:DATA:NOROOT(0)
//   98 u8   Current = 0, TypeA = 0, Update = 1;
TypeA:
        DS8 1

        SECTION `.data`:DATA:NOROOT(2)
//   99 u8   BL_Str[5]="B.L", Vol_Str[5]="Vol";
//  100 
//  101 menu Title[13][4]=   
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
        DC16 2
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
        DC16 3
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
//  102 {
//  103   //     Item_String,   m_Color,   Limit, Mark, xPos, yPos, Value, Flag 
//  104   {//============================ Title Track1 Group ===========================
//  105     {(u8*)CH_A_STR,(u16*)Y_INV,     2-1, CIRC,   35,  228,     1, UPDAT}, //  Track source
//  106     {(u8*)YCOUPLE, (u16*)Y_COLOR,   2-1, CIRC,   35,  216,     0, UPDAT}, //  Track Couple        
//  107     {(u8*)Vertical,(u16*)Y_COLOR,   9-1,    0,   51,  216,     5, UPDAT}, //  Track Range 
//  108     {(u8*)YPOSISTR,(u16*)Y_INV,     200,  FIX,    0,    0,   150, UPDAT}, //  Adj. Track Position 160
//  109   },
//  110   {//============================ Title Track2 Group ===========================
//  111     {(u8*)CH_B_STR,(u16*)Y_INV+1,   2-1, CIRC,   86,  228,     1, UPDAT}, //  Track source
//  112     {(u8*)YCOUPLE, (u16*)Y_COLOR+1, 2-1, CIRC,   86,  216,     1, UPDAT}, //  Track Couple        
//  113     {(u8*)Vertical,(u16*)Y_COLOR+1, 9-1,    0,  102,  216,     1, UPDAT}, //  Track Range
//  114     {(u8*)YPOSISTR,(u16*)Y_INV+1,   200,  FIX,    0,    0,   100, UPDAT}, //  Adj. Track Position
//  115   },
//  116   {//============================ Title Track3 Group ===========================
//  117     {(u8*)CH_C_STR,(u16*)Y_INV+2,   2-1, CIRC,  137,  228,     1, UPDAT}, //  Track source
//  118     {(u8*)NO_DEF , (u16*)Y_COLOR+2, 1-1, CIRC,  137,  216,     0, UPDAT}, //  Track Couple        
//  119     {(u8*)NO_RANGE,(u16*)Y_COLOR+2, 1-1,    0,  153,  216,     0, UPDAT}, //  Track Range
//  120     {(u8*)YPOSISTR,(u16*)Y_INV+2, 200-1,  FIX,    0,    0,    60, UPDAT}, //  Adj. Track Position
//  121   },
//  122   {//============================ Title Track4 Group ===========================
//  123     {(u8*)CH_D_STR,(u16*)Y_INV+3,  10-1, CIRC,  188,  228,     1, UPDAT}, //  Track source
//  124     {(u8*)NO_DEF , (u16*)Y_COLOR+3, 1-1, CIRC,  188,  216,     0, UPDAT}, //  Track Couple        
//  125     {(u8*)NO_RANGE,(u16*)Y_COLOR+3, 1-1,    0,  204,  216,     0, UPDAT}, //  Track Range
//  126     {(u8*)YPOSISTR,(u16*)Y_INV+3, 200-1,  FIX,    0,    0,    20, UPDAT}, //  Adj. Track Position
//  127   },
//  128   {//================== Running State & Battery Status Group ===================
//  129     {(u8*)STATESTR,(u16*)S_Inv,     3-1,    0,    0,  228,     0, UPDAT}, //  Running state
//  130     {(u8*)BATT_STR,(u16*)B_COLOR,   5-1,    0,    0,  216,     0, UPDAT}, //  Battery status
//  131     {(u8*)BATT_STR,(u16*)B_COLOR,   5-1,  NOT,    0,    0,     0,   HID}, 
//  132     {(u8*)BATT_STR,(u16*)B_COLOR,   5-1,  NOT,    0,    0,     0,   HID},
//  133   },
//  134   {//========================= Title Time Base Group ===========================
//  135     {(u8*)MODESTR, (u16*)XCOLOR,    5-1, CIRC,  239,  228,     0, UPDAT}, //  Sync Mode
//  136     {(u8*)BaseStr, (u16*)XCOLOR+1, 27-1,    0,  239,  216,    17, UPDAT}, //  Time Base Range
//  137     {(u8*)XPOSISTR,(u16*)XCOLOR,   3795,  FIX,  366,    0,     0, UPDAT}, //  Adj. X position
//  138     {(u8*)XPOSISTR,(u16*)XCOLOR,   3795,  NOT,   80,    0,     0, UPDAT}, //  View window rule
//  139   },           
//  140   {//======================= Title Output Signal Group =========================
//  141     {(u8*)FO_TYPE, (u16*)O_COLOR,   4-1, CIRC,  282,  228,     3, UPDAT}, //  Output Wave Kind         
//  142     {(u8*)FO_STR,  (u16*)O_COLOR+1,20-1,    0,  282,  216,    13, UPDAT}, //  Output Frequency         
//  143     {(u8*)NumStr,  (u16*)O_COLOR,   100,  NOT,  306,  228,    50,   HID},        
//  144     {(u8*)NumStr,  (u16*)O_COLOR,     0,  NOT,    0,    0,     0,   HID}, //  Duty value          
//  145   },
//  146   {//=====================;===== Title Trigger Group ====;======================
//  147     {(u8*)TRIGSTR, (u16*)Y_INV,     4-1, CIRC,  333,  228,     1, UPDAT}, //  Trigger source         
//  148     {(u8*)TR_TYPE, (u16*)Y_INV,     8-1, CIRC,  373,  228,     0, UPDAT}, //  Trigger Kine         
//  149     {(u8*)VT_STR,  (u16*)Y_COLOR,   200,  FIX,  333,  216,     0, UPDAT}, //  Adj. Trigger threshold     
//  150     {(u8*)VT_STR,  (u16*)Y_COLOR,     0,  NOT,  357,  216,     0,   HID}, //  Number position     
//  151   },
//  152   {//============================ Title Y Vernie Group =========================
//  153     {(u8*)VERNIE1, (u16*)V_INV,   200-1,  FIX,   35,    0,   180, UPDAT}, //  V1 Vernie         
//  154     {(u8*)VERNIE2, (u16*)V_INV,   200-1,  FIX,   62,    0,    40, UPDAT}, //  V2 Vernie     
//  155     {(u8*)DELTA_V, (u16*)Y_INV,     2-1, CIRC,  314,  197,     0, UPDAT}, //  Measure Track    
//  156     {(u8*)NumStr,  (u16*)Y_COLOR,   240, NUM3,  342,  197,    70, UPDAT}, //  Delta V value    
//  157   },
//  158   {//============================= Title File Group ============================
//  159     {(u8*)F_FUNC,  (u16*)F_INV,     2-1, CIRC,  134,    0,     0,     0}, //  File function    
//  160     {(u8*)NumStr,  (u16*)F_INV,   256-1, NUM3,  206,    0,     0,     1}, //  File number     
//  161     {(u8*)F_EXT,   (u16*)F_INV,     4-1, CIRC,  230,    0,     0,     0}, //  Ext. name     
//  162     {(u8*)F_EXT,   (u16*)F_INV,       0,  NOT,    0,    0,     0,   HID},  
//  163   },
//  164   {//============================ Title X Vernie Group =========================
//  165     {(u8*)VERNIE3, (u16*)T_INV,     300,  FIX,  312,    0,    80, UPDAT}, //  T1 Vernie         
//  166     {(u8*)VERNIE4, (u16*)T_INV,     300,  FIX,  339,    0,   280, UPDAT}, //  T2 Vernie     
//  167     {(u8*)DELTA_T, (u16*)T_INV,       0,  NOT,  314,  182,     0, UPDAT}, //  Delta T Str     
//  168     {(u8*)NumStr,  (u16*)T_COLOR,   300, NUM3,  342,  182,    80, UPDAT}, //  Delta T value    
//  169   },
//  170   {//=========================== Title BackLight Group =========================
//  171     {(u8*)BL_Str,  (u16*)V_INV,     1-1,  FIX,  314,  167,     0, UPDAT}, //  BackLight    
//  172     {(u8*)NumStr,  (u16*)V_COLOR,  10-1, NUM2,  342,  167,     5, UPDAT}, //  Class     
//  173     {(u8*)NumStr,  (u16*)V_INV,       0,  NOT,    0,    0,     0,   HID},     
//  174     {(u8*)NumStr,  (u16*)V_INV,       0,  NOT,    0,    0,     0,   HID},  
//  175   },
//  176   {//============================ Title Volume Group ===========================
//  177     {(u8*)Vol_Str, (u16*)V_INV,     1-1,  FIX,  314,  152,     0, UPDAT}, //  Volume        
//  178     {(u8*)NumStr,  (u16*)V_COLOR,  11-1, NUM2,  342,  152,     5, UPDAT}, //  Class     
//  179     {(u8*)NumStr,  (u16*)V_INV,       0,  NOT,    0,    0,     0,   HID},    
//  180     {(u8*)NumStr,  (u16*)V_INV,       0,  NOT,    0,    0,     0,   HID},    
//  181   },
//  182 };
//  183 
//  184 meter Meter[9] =
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
        DC8 3, 7
        DC16 314, 342
        DC8 107, 2
        DC32 METER
        DC8 2, 8
        DC16 314, 342
        DC8 92, 2
        DC32 METER
        DC8 2, 9
        DC16 314, 342
        DC8 77, 2
        DC32 METER
        DC8 1, 10
        DC16 314, 342
        DC8 62, 2
        DC32 METER
        DC8 1, 11
        DC16 314, 342
        DC8 47, 2
        DC32 METER
        DC8 0, 2
        DC16 314, 342
        DC8 32, 2
        DC32 METER
        DC8 0, 3
        DC16 314, 342
        DC8 17, 2
Current:
        DC8 0
        DC8 0
Result_FPS:
        DC8 0, 0
Detail:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
NumStr:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
//  185 { {(u8*)METER,      4,    VBT,     314,    342,   137,  UPDAT}, //  Meter #0
//  186   {(u8*)METER,      4,    FPS,     314,    342,   122,  UPDAT}, //  Meter #1
//  187   {(u8*)METER, TRACK4,    FRQ,     314,    342,   107,  UPDAT}, //  Meter #2
//  188   {(u8*)METER, TRACK3,    CIR,     314,    342,    92,  UPDAT}, //  Meter #3
//  189   {(u8*)METER, TRACK3,    DUT,     314,    342,    77,  UPDAT}, //  Meter #4
//  190   {(u8*)METER, TRACK2,    TH,      314,    342,    62,  UPDAT}, //  Meter #5
//  191   {(u8*)METER, TRACK2,    TL,      314,    342,    47,  UPDAT}, //  Meter #6
//  192   {(u8*)METER, TRACK1,    VPP,     314,    342,    32,  UPDAT}, //  Meter #7
//  193   {(u8*)METER, TRACK1,    VDC,     314,    342,    17,  UPDAT}, //  Meter #8
//  194 };         
//  195 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function Display_Meter
        THUMB
//  196 void Display_Meter(void)                  // 每次刷新显示一个测量项
//  197 {
Display_Meter:
        PUSH     {R4-R8,LR}
        CFI R14 Frame(CFA, -4)
        CFI R8 Frame(CFA, -8)
        CFI R7 Frame(CFA, -12)
        CFI R6 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
//  198   u8  i;
//  199   
//  200   for(i=0; i<9; ++i){        
        LDR.W    R4,??DataTable34  ;; Title
        ADDW     R5,R4,#+1044
        MOVS     R6,#+9
        LDR.W    R8,??Display_Meter_0  ;; Y_INV
        MOVS     R7,#+5
//  201     if(Meter[i].Flag & UPDAT){            //-----显示需刷新的测量项目名称
??Display_Meter_1:
        LDRB     R0,[R5, #+7]
        TST      R0,#0x2
        BEQ.N    ??Display_Meter_2
//  202       Meter[i].Flag &= (!UPDAT & !BLINK);       // Clr Update & Blink flag
        MOVS     R0,#+0
        STRB     R0,[R5, #+7]
//  203       Print_Str
//  204         (Meter[i].XPOS1, Meter[i].YPOS,        // 需要显示的坐标
//  205          Y_INV[Meter[i].Track],                // 需要显示的颜色(所属通道)
//  206          PRN,                                  // 需要显示的方式
//  207          Meter[i].Str +(Meter[i].Item * 5));   // 需要显示的项目名称
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
//  208     } 
//  209   }
??Display_Meter_2:
        ADDS     R5,R5,#+12
        SUBS     R6,R6,#+1
        BNE.N    ??Display_Meter_1
//  210   if((Current >= METER_0)&&(Current <= METER_8)){
        LDRB     R0,[R4, #+1148]
        CMP      R0,#+13
        BCC.N    ??Display_Meter_3
        CMP      R0,#+22
        BCS.N    ??Display_Meter_3
//  211     if(Blink){                            //-----显示需闪烁的测量项目名称
        LDR.W    R1,??DataTable27  ;; Blink
        LDRB     R2,[R1, #+0]
        CBZ      R2,??Display_Meter_3
//  212       i = Current - METER_0;
        SUBS     R0,R0,#+13
        UXTB     R0,R0
//  213       Blink = 0;                               // Clr Blink Ctrl flag 
        MOVS     R2,#+0
        STRB     R2,[R1, #+0]
//  214       Print_Str(
//  215         Meter[i].XPOS1, Meter[i].YPOS,         // 需要闪烁的坐标 
//  216         Y_INV[Meter[i].Track],                 // 需要闪烁的颜色(所属通道)
//  217         Twink,                                 // 闪烁方式
//  218         Meter[i].Str +(Meter[i].Item *5));     // 需要闪烁的项目名称
        MOVS     R1,#+12
        MLA      R0,R0,R1,R4
        LDRB     R1,[R0, #+1045]
        ADD      R3,R0,#+1040
        LDR      R3,[R3, #+0]
        MLA      R1,R1,R7,R3
        PUSH     {R1,LR}
        CFI CFA R13+32
        LDR.W    R1,??DataTable33  ;; Twink
        LDRB     R3,[R1, #+0]
        LDRB     R1,[R0, #+1044]
        LDR.N    R2,??Display_Meter_0  ;; Y_INV
        LDRH     R2,[R2, R1, LSL #+1]
        LDRB     R1,[R0, #+1050]
        LDRH     R0,[R0, #+1046]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+24
//  219     }
//  220   }
//  221 }
??Display_Meter_3:
        POP      {R4-R8,PC}       ;; return
        DATA
??Display_Meter_0:
        DC32     Y_INV
        CFI EndBlock cfiBlock0
//  222 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function Display_Value
        THUMB
//  223 void Display_Value(u8 i)
//  224 {
Display_Value:
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
        MOVS     R7,R0
//  225   s32 Tmp = 0;
        MOVS     R4,#+0
//  226   u16 Kp;
//  227   u32 k, n, m;
//  228   
//  229   if(Interlace == 0) Kp = _Kp1; // 独立采样模式
        LDR.W    R5,??DataTable34  ;; Title
        LDRSH    R11,[R5, #+436]
        MOV      R9,#+20
        LDR.W    R0,??DataTable36  ;; X_Attr
        LDR      R0,[R0, #+0]
        MLA      R0,R11,R9,R0
        LDR.W    R1,??Display_Value_1  ;; Interlace
        LDRB     R1,[R1, #+0]
        CMP      R1,#+0
        ITE      NE 
        LDRHNE   R6,[R0, #+114]
        LDRHEQ   R6,[R0, #+14]
//  230   else               Kp = _Kp2; // 交替采样模式  
//  231   
//  232   k = _T_Range; m = 1;  n = 1;
        MOV      R10,#+1
        MOV      R8,R10
        CMP      R11,#+9
        BCS.N    ??Display_Value_2
//  233   if(k < 9)  m = Power(10, (11-k)/3);
        RSB      R0,R11,#+11
        MOVS     R1,#+3
        UDIV     R1,R0,R1
        UXTB     R1,R1
        MOVS     R0,#+10
        BL       Power
        MOV      R10,R0
        B.N      ??Display_Value_3
//  234   else       n = Power(10, (k- 9)/3);
??Display_Value_2:
        SUB      R0,R11,#+9
        MOVS     R1,#+3
        UDIV     R1,R0,R1
        UXTB     R1,R1
        MOVS     R0,#+10
        BL       Power
        MOV      R8,R0
//  235   k = X_Attr[(k%3)+9].SCALE;
??Display_Value_3:
        MOVS     R0,#+3
        UDIV     R0,R11,R0
        MOVS     R1,#+3
        MLS      R0,R0,R1,R11
        LDR.W    R1,??DataTable36  ;; X_Attr
        LDR      R1,[R1, #+0]
        MLA      R0,R0,R9,R1
        LDR      R0,[R0, #+196]
//  236   
//  237   switch (Meter[i].Item){  
        MOVS     R1,#+12
        MLA      R7,R7,R1,R5
        LDRB     R1,[R7, #+1045]
        CMP      R1,#+11
        BHI.N    ??Display_Value_4
        TBH      [PC, R1, LSL #+1]
        DATA
??Display_Value_0:
        DC16     +12,+49,+61,+152
        DC16     +225,+313,+395,+477
        DC16     +598,+679,+748,+817
        THUMB
//  238   case VBT://--------------- 计算和显示电池电压 ---------------
//  239     Int2Str(NumStr, __Get(V_BATTERY)*1000, V_UNIT, 3, SIGN);
??Display_Value_5:
        MOVS     R0,#+6
        BL       __Get
        MOVS     R1,#+0
        PUSH     {R1,LR}
        CFI CFA R13+48
        MOVS     R3,#+3
        LDR.W    R2,??DataTable20  ;; Y_COLOR + 24
        MOV      R1,#+1000
        MULS     R1,R0,R1
        ADD      R0,R5,#+1168
??Display_Value_6:
        BL       Int2Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  240     break;
//  241   case FPS://--------------- 计算和显示帧计数 ---------------
//  242     Int2Str(NumStr, Result_FPS & 0x7F, S_UNIT, 2, STD);
//  243     break;  
//  244   case VPP:
//  245     if((Meter[i].Track == TRACK1)&&(_1_source == CH_A)){
//  246       Tmp = (Ka2[_A_Range]*(a_Max - a_Min)+ 512)/1024;
//  247       if(Tmp <= 4) Tmp = 0;
//  248       Tmp *= Y_Attr[_A_Range].SCALE;
//  249     }
//  250     if((Meter[i].Track == TRACK2)&&(_2_source == CH_B)){
//  251       Tmp = (Kb2[_B_Range]*(b_Max - b_Min)+ 512)/1024;
//  252       if(Tmp <= 4) Tmp = 0;
//  253       Tmp *= Y_Attr[_B_Range].SCALE;
//  254     }
//  255     Int2Str(NumStr, Tmp, V_UNIT, 3, SIGN);
//  256     break;
//  257   case VDC:
//  258     if((Meter[i].Track == TRACK1)&&(_1_source == CH_A)){
//  259       Tmp = Ka1[_A_Range]+(Ka2[_A_Range]*(a_Avg/4096)+ 512)/1024 - _1_posi;
//  260       if((Tmp >= -2)&&(Tmp <= 2)) Tmp = 0;
//  261       Tmp *= Y_Attr[_A_Range].SCALE;
//  262     }
//  263     if((Meter[i].Track == TRACK2)&&(_2_source == CH_B)){
//  264       Tmp = Kb1[_B_Range]+(Kb2[_B_Range]*(b_Avg/4096)+ 512)/1024 - _2_posi;
//  265       if((Tmp >= -2)&&(Tmp <= 2)) Tmp = 0;
//  266       Tmp *= Y_Attr[_B_Range].SCALE;
//  267     }
//  268     Int2Str(NumStr, Tmp, V_UNIT, 3, SIGN);
//  269     break;
//  270   case RMS:
//  271     if((Meter[i].Track == TRACK1)&&(_1_source == CH_A)){
//  272       Tmp = Ka1[_A_Range] +(Ka2[_A_Range]*Int_sqrt(a_Ssq/4096)+ 512)/1024;
//  273       if(Tmp <= 2) Tmp = 0;
//  274       Tmp *= Y_Attr[_A_Range].SCALE;
//  275     }
//  276     if((Meter[i].Track == TRACK2)&&(_2_source == CH_B)){
//  277       Tmp = Kb1[_B_Range] +(Kb2[_B_Range]*Int_sqrt(b_Ssq/4096)+ 512)/1024;
//  278       if(Tmp <= 2) Tmp = 0;
//  279       Tmp *= Y_Attr[_B_Range].SCALE;
//  280     }
//  281     Int2Str(NumStr, Tmp, V_UNIT, 3, UNSIGN);
//  282     break;
//  283   case MAX:
//  284     if((Meter[i].Track == TRACK1)&&(_1_source == CH_A))
//  285       Tmp = (Ka1[_A_Range] +(Ka2[_A_Range]*a_Max + 512)/1024 - _1_posi)* Y_Attr[_A_Range].SCALE;
//  286     if((Meter[i].Track == TRACK2)&&(_2_source == CH_B))
//  287       Tmp = (Kb1[_B_Range] +(Kb2[_B_Range]*b_Max + 512)/1024 - _2_posi)* Y_Attr[_B_Range].SCALE;
//  288     Int2Str(NumStr, Tmp, V_UNIT, 3, SIGN);
//  289     break;
//  290   case MIN:
//  291     if((Meter[i].Track == TRACK1)&&(_1_source == CH_A))
//  292       Tmp = (Ka1[_A_Range] +(Ka2[_A_Range]*a_Min + 512)/1024 - _1_posi)* Y_Attr[_A_Range].SCALE;
//  293     if((Meter[i].Track == TRACK2)&&(_2_source == CH_B))
//  294       Tmp = (Kb1[_B_Range] +(Kb2[_B_Range]*b_Min + 512)/1024 - _2_posi)* Y_Attr[_B_Range].SCALE;
//  295     Int2Str(NumStr, Tmp, V_UNIT, 3, SIGN);
//  296     break;
//  297   case FRQ:
//  298     if((Meter[i].Track == TRACK1)&&(_1_source == CH_A))
//  299       Tmp = 2000*((500000 * TaN)/TaS);
//  300     if((Meter[i].Track == TRACK2)&&(_2_source == CH_B))
//  301       Tmp = 2000*((500000 * TbN)/TbS);
//  302     if((Meter[i].Track == TRACK3)&&(_3_source == CH_C))
//  303       Tmp = 2000*((500000 * TcN)/TcS);
//  304     if((Meter[i].Track == TRACK4)&&(_4_source == CH_D))
//  305       Tmp = 2000*((500000 * TdN)/TdS);
//  306     if(n < 10) Int2Str(NumStr, ((250*(Tmp/(k/60)))/m)/15,   F_UNIT, 4, UNSIGN);
//  307     else       Int2Str(NumStr, Kp*(n*(Tmp/(k/60))/240)/256, F_UNIT, 4, UNSIGN);
//  308     break;  
//  309   case CIR:
//  310     if((Meter[i].Track == TRACK1)&&(_1_source == CH_A))
//  311       Tmp = (k *TaS)/TaN;
//  312     if((Meter[i].Track == TRACK2)&&(_2_source == CH_B))
//  313       Tmp = (k *TbS)/TbN;
//  314     if((Meter[i].Track == TRACK3)&&(_3_source == CH_C))
//  315       Tmp = (k *TcS)/TcN;
//  316     if((Meter[i].Track == TRACK4)&&(_4_source == CH_D))
//  317       Tmp = (k *TdS)/TdN;
//  318     if(Tmp <= 0x7FFFFFFF/m) Tmp = 1024*((m*Tmp)/Kp)/n;
//  319     else                    Tmp = 0x80000000;
//  320     Int2Str(NumStr, Tmp, T_UNIT, 4, UNSIGN);
//  321     break;
//  322   case DUT:
//  323     if((Meter[i].Track == TRACK1)&&(_1_source == CH_A))
//  324       Tmp = (100000*PaS)/TaS;
//  325     if((Meter[i].Track == TRACK2)&&(_2_source == CH_B))
//  326       Tmp = (100000*PbS)/TbS;
//  327     if((Meter[i].Track == TRACK3)&&(_3_source == CH_C))
//  328       Tmp = (100000*PcS)/TcS;
//  329     if((Meter[i].Track == TRACK4)&&(_4_source == CH_D))
//  330       Tmp = (100000*PdS)/TdS;
//  331     Int2Str(NumStr, Tmp, P_UNIT, 4, UNSIGN);
//  332     break;
//  333   case TH:
//  334     if((Meter[i].Track == TRACK1)&&(_1_source == CH_A))
//  335       Tmp = (k*TaS)/TaN - (k*PaS)/TaN;
//  336     if((Meter[i].Track == TRACK2)&&(_2_source == CH_B))
//  337       Tmp = (100000*PbS)/TbS;
//  338     if((Meter[i].Track == TRACK3)&&(_3_source == CH_C))
//  339       Tmp = (100000*PcS)/TcS;
//  340     if((Meter[i].Track == TRACK4)&&(_4_source == CH_D))
//  341       Tmp = (100000*PdS)/TdS;
//  342     if(Tmp <= 0x7FFFFFFF/m) Tmp = 1024*((m*Tmp)/Kp)/n;
//  343     else                    Tmp = 0x80000000;
//  344     Int2Str(NumStr, Tmp, T_UNIT, 4, UNSIGN);
//  345     break;
//  346   case TL:
//  347     if((Meter[i].Track == TRACK1)&&(_1_source == CH_A))
//  348       Tmp = (k*PaS)/TaN;
//  349     if((Meter[i].Track == TRACK2)&&(_2_source == CH_B))
//  350       Tmp = (k*PbS)/TbN;
//  351     if((Meter[i].Track == TRACK3)&&(_3_source == CH_C))
//  352       Tmp = (k*PcS)/TcN;
//  353     if((Meter[i].Track == TRACK4)&&(_4_source == CH_D))
//  354       Tmp = (k*PdS)/TdN;
//  355     if(Tmp <= 0x7FFFFFFF/m) Tmp = 1024*((m*Tmp)/Kp)/n;
//  356     else                    Tmp = 0x80000000;
//  357     Int2Str(NumStr, Tmp, T_UNIT, 4, UNSIGN);
//  358     break;
//  359     }
//  360   Print_Str(
//  361     Meter[i].XPOS2, Meter[i].YPOS,
//  362     Y_COLOR[Meter[i].Track], 
//  363     PRN,
//  364     NumStr);                              // 显示测量数值
??Display_Value_4:
        ADD      R0,R5,#+1168
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDRB     R0,[R7, #+1044]
        LDR.W    R1,??Display_Value_1+0x4  ;; Y_COLOR
        LDRH     R2,[R1, R0, LSL #+1]
        LDRB     R1,[R7, #+1050]
        ADD      R0,R7,#+1048
        LDRH     R0,[R0, #+0]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  365 }
        ADD      SP,SP,#+4
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        CFI CFA R13+40
??Display_Value_7:
        MOVS     R0,#+2
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+2
        LDR.W    R2,??Display_Value_1+0x8  ;; Y_COLOR + 48
        LDRH     R0,[R5, #+1150]
        AND      R1,R0,#0x7F
        ADD      R0,R5,#+1168
        B.N      ??Display_Value_6
        CFI CFA R13+40
??Display_Value_8:
        LDRB     R1,[R7, #+1044]
        CBNZ     R1,??Display_Value_9
        LDRSH    R0,[R5, #+16]
        CMP      R0,#+1
        BNE.N    ??Display_Value_10
        LDRSH    R0,[R5, #+56]
        LDR.W    R1,??Display_Value_1+0xC  ;; Ka2
        LDRH     R0,[R1, R0, LSL #+1]
        LDR.W    R1,??Display_Value_1+0x10  ;; a_Max
        LDRB     R1,[R1, #+0]
        LDR.W    R2,??Display_Value_1+0x14  ;; a_Min
        LDRB     R2,[R2, #+0]
        SUBS     R1,R1,R2
        MOV      R2,#+512
        MLA      R0,R0,R1,R2
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R0,R0,#+10
        CMP      R0,#+5
        IT       LT 
        MOVLT    R0,#+0
??Display_Value_11:
        LDRSH    R1,[R5, #+56]
        LDR.W    R2,??DataTable35  ;; Y_Attr
        LDR      R2,[R2, #+0]
        MLA      R1,R1,R9,R2
        LDR      R1,[R1, #+16]
        MUL      R4,R0,R1
        B.N      ??Display_Value_10
??Display_Value_9:
        CMP      R1,#+1
        BNE.N    ??Display_Value_10
        LDRSH    R0,[R5, #+96]
        CMP      R0,#+1
        BNE.N    ??Display_Value_10
        LDRSH    R0,[R5, #+136]
        LDR.W    R1,??Display_Value_1+0x18  ;; Kb2
        LDRH     R0,[R1, R0, LSL #+1]
        LDR.W    R1,??Display_Value_1+0x1C  ;; b_Max
        LDRB     R1,[R1, #+0]
        LDR.W    R2,??Display_Value_1+0x20  ;; b_Min
        LDRB     R2,[R2, #+0]
        SUBS     R1,R1,R2
        MOV      R2,#+512
        MLA      R0,R0,R1,R2
        ASRS     R1,R0,#+9
        ADD      R0,R0,R1, LSR #+22
        ASRS     R0,R0,#+10
        CMP      R0,#+5
        IT       LT 
        MOVLT    R0,#+0
??Display_Value_12:
        LDRSH    R1,[R5, #+136]
        LDR.W    R2,??DataTable35  ;; Y_Attr
        LDR      R2,[R2, #+0]
        MLA      R1,R1,R9,R2
        LDR      R1,[R1, #+16]
        MUL      R4,R0,R1
??Display_Value_10:
        MOVS     R0,#+0
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+3
        LDR.W    R2,??DataTable20  ;; Y_COLOR + 24
        MOVS     R1,R4
        ADD      R0,R5,#+1168
        B.N      ??Display_Value_6
        CFI CFA R13+40
??Display_Value_13:
        LDRB     R1,[R7, #+1044]
        CBNZ     R1,??Display_Value_14
        LDRSH    R0,[R5, #+16]
        CMP      R0,#+1
        BNE.N    ??Display_Value_10
        LDRSH    R0,[R5, #+56]
        LDR.W    R1,??Display_Value_1+0x24  ;; Ka1
        LDRSB    R1,[R0, R1]
        LDR.W    R2,??Display_Value_1+0xC  ;; Ka2
        LDRH     R0,[R2, R0, LSL #+1]
        LDR.W    R2,??Display_Value_1+0x28  ;; a_Avg
        LDR      R2,[R2, #+0]
        LSRS     R2,R2,#+12
        MOV      R3,#+512
        MLA      R0,R0,R2,R3
        ADD      R0,R1,R0, LSR #+10
        LDRSH    R1,[R5, #+76]
        SUBS     R0,R0,R1
        MVN      R1,#+1
        CMP      R0,R1
        BLT.N    ??Display_Value_11
        CMP      R0,#+3
        BGE.N    ??Display_Value_11
        MOVS     R0,#+0
        B.N      ??Display_Value_11
??Display_Value_14:
        CMP      R1,#+1
        BNE.N    ??Display_Value_10
        LDRSH    R0,[R5, #+96]
        CMP      R0,#+1
        BNE.N    ??Display_Value_10
        LDRSH    R0,[R5, #+136]
        LDR.W    R1,??Display_Value_1+0x2C  ;; Kb1
        LDRSB    R1,[R0, R1]
        LDR.W    R2,??Display_Value_1+0x18  ;; Kb2
        LDRH     R0,[R2, R0, LSL #+1]
        LDR.W    R2,??Display_Value_1+0x30  ;; b_Avg
        LDR      R2,[R2, #+0]
        LSRS     R2,R2,#+12
        MOV      R3,#+512
        MLA      R0,R0,R2,R3
        ADD      R0,R1,R0, LSR #+10
        LDRSH    R1,[R5, #+156]
        SUBS     R0,R0,R1
        MVN      R1,#+1
        CMP      R0,R1
        BLT.N    ??Display_Value_12
        CMP      R0,#+3
        BGE.N    ??Display_Value_12
        MOVS     R0,#+0
        B.N      ??Display_Value_12
??Display_Value_15:
        LDRB     R0,[R7, #+1044]
        CBNZ     R0,??Display_Value_16
        LDRSH    R0,[R5, #+16]
        CMP      R0,#+1
        BNE.N    ??Display_Value_17
        LDR.W    R0,??Display_Value_1+0x34  ;; a_Ssq
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+12
        BL       Int_sqrt
        LDRSH    R1,[R5, #+56]
        LDR.W    R2,??Display_Value_1+0x24  ;; Ka1
        LDRSB    R2,[R1, R2]
        LDR.W    R3,??Display_Value_1+0xC  ;; Ka2
        LDRH     R3,[R3, R1, LSL #+1]
        MOV      R12,#+512
        MLA      R0,R3,R0,R12
        ADD      R0,R2,R0, LSR #+10
        CMP      R0,#+3
        IT       LT 
        MOVLT    R0,#+0
        LDR.W    R2,??DataTable35  ;; Y_Attr
        LDR      R2,[R2, #+0]
        MLA      R1,R1,R9,R2
        LDR      R1,[R1, #+16]
        MUL      R4,R0,R1
??Display_Value_16:
        LDRB     R0,[R7, #+1044]
        CMP      R0,#+1
        BNE.N    ??Display_Value_17
        LDRSH    R0,[R5, #+96]
        CMP      R0,#+1
        BNE.N    ??Display_Value_17
        LDR.W    R0,??Display_Value_1+0x38  ;; b_Ssq
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+12
        BL       Int_sqrt
        LDRSH    R1,[R5, #+136]
        LDR.W    R2,??Display_Value_1+0x2C  ;; Kb1
        LDRSB    R2,[R1, R2]
        LDR.W    R3,??Display_Value_1+0x18  ;; Kb2
        LDRH     R3,[R3, R1, LSL #+1]
        MOV      R12,#+512
        MLA      R0,R3,R0,R12
        ADD      R0,R2,R0, LSR #+10
        CMP      R0,#+3
        IT       LT 
        MOVLT    R0,#+0
        LDR.W    R2,??DataTable35  ;; Y_Attr
        LDR      R2,[R2, #+0]
        MLA      R1,R1,R9,R2
        LDR      R1,[R1, #+16]
        MUL      R4,R0,R1
??Display_Value_17:
        MOVS     R0,#+1
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+3
        LDR.W    R2,??DataTable20  ;; Y_COLOR + 24
        MOVS     R1,R4
        ADD      R0,R5,#+1168
        B.N      ??Display_Value_6
        CFI CFA R13+40
??Display_Value_18:
        LDRB     R1,[R7, #+1044]
        CBNZ     R1,??Display_Value_19
        LDRSH    R0,[R5, #+16]
        CMP      R0,#+1
        BNE.W    ??Display_Value_10
        LDRSH    R0,[R5, #+56]
        LDR.W    R1,??Display_Value_1+0xC  ;; Ka2
        LDRH     R1,[R1, R0, LSL #+1]
        LDR.W    R2,??Display_Value_1+0x10  ;; a_Max
        LDRB     R2,[R2, #+0]
        MOV      R3,#+512
        MLA      R1,R1,R2,R3
        LDR.W    R2,??Display_Value_1+0x24  ;; Ka1
        LDRSB    R2,[R0, R2]
        ASRS     R3,R1,#+9
        ADD      R1,R1,R3, LSR #+22
        ADD      R1,R2,R1, ASR #+10
        LDRSH    R2,[R5, #+76]
        SUBS     R1,R1,R2
        LDR.W    R2,??DataTable35  ;; Y_Attr
        LDR      R2,[R2, #+0]
        MLA      R0,R0,R9,R2
        LDR      R0,[R0, #+16]
        MUL      R4,R1,R0
        B.N      ??Display_Value_10
??Display_Value_19:
        CMP      R1,#+1
        BNE.W    ??Display_Value_10
        LDRSH    R0,[R5, #+96]
        CMP      R0,#+1
        BNE.W    ??Display_Value_10
        LDRSH    R0,[R5, #+136]
        LDR.W    R1,??Display_Value_1+0x18  ;; Kb2
        LDRH     R1,[R1, R0, LSL #+1]
        LDR.W    R2,??Display_Value_1+0x1C  ;; b_Max
        LDRB     R2,[R2, #+0]
        MOV      R3,#+512
        MLA      R1,R1,R2,R3
        LDR.W    R2,??Display_Value_1+0x2C  ;; Kb1
        LDRSB    R2,[R0, R2]
        ASRS     R3,R1,#+9
        ADD      R1,R1,R3, LSR #+22
        ADD      R1,R2,R1, ASR #+10
        LDRSH    R2,[R5, #+156]
        SUBS     R1,R1,R2
        LDR.W    R2,??DataTable35  ;; Y_Attr
        LDR      R2,[R2, #+0]
        MLA      R0,R0,R9,R2
        LDR      R0,[R0, #+16]
        MUL      R4,R1,R0
        B.N      ??Display_Value_10
??Display_Value_20:
        LDRB     R1,[R7, #+1044]
        CBNZ     R1,??Display_Value_21
        LDRSH    R0,[R5, #+16]
        CMP      R0,#+1
        BNE.W    ??Display_Value_10
        LDRSH    R0,[R5, #+56]
        LDR.W    R1,??Display_Value_1+0xC  ;; Ka2
        LDRH     R1,[R1, R0, LSL #+1]
        LDR.W    R2,??Display_Value_1+0x14  ;; a_Min
        LDRB     R2,[R2, #+0]
        MOV      R3,#+512
        MLA      R1,R1,R2,R3
        LDR.W    R2,??Display_Value_1+0x24  ;; Ka1
        LDRSB    R2,[R0, R2]
        ASRS     R3,R1,#+9
        ADD      R1,R1,R3, LSR #+22
        ADD      R1,R2,R1, ASR #+10
        LDRSH    R2,[R5, #+76]
        SUBS     R1,R1,R2
        LDR.W    R2,??DataTable35  ;; Y_Attr
        LDR      R2,[R2, #+0]
        MLA      R0,R0,R9,R2
        LDR      R0,[R0, #+16]
        MUL      R4,R1,R0
        B.N      ??Display_Value_10
??Display_Value_21:
        CMP      R1,#+1
        BNE.W    ??Display_Value_10
        LDRSH    R0,[R5, #+96]
        CMP      R0,#+1
        BNE.W    ??Display_Value_10
        LDRSH    R0,[R5, #+136]
        LDR.W    R1,??Display_Value_1+0x18  ;; Kb2
        LDRH     R1,[R1, R0, LSL #+1]
        LDR.W    R2,??Display_Value_1+0x20  ;; b_Min
        LDRB     R2,[R2, #+0]
        MOV      R3,#+512
        MLA      R1,R1,R2,R3
        LDR.W    R2,??Display_Value_1+0x2C  ;; Kb1
        LDRSB    R2,[R0, R2]
        ASRS     R3,R1,#+9
        ADD      R1,R1,R3, LSR #+22
        ADD      R1,R2,R1, ASR #+10
        LDRSH    R2,[R5, #+156]
        SUBS     R1,R1,R2
        LDR.W    R2,??DataTable35  ;; Y_Attr
        LDR      R2,[R2, #+0]
        MLA      R0,R0,R9,R2
        LDR      R0,[R0, #+16]
        MUL      R4,R1,R0
        B.N      ??Display_Value_10
??Display_Value_22:
        LDRB     R1,[R7, #+1044]
        CBNZ     R1,??Display_Value_23
        LDRSH    R1,[R5, #+16]
        CMP      R1,#+1
        BNE.N    ??Display_Value_24
        LDR.W    R1,??Display_Value_1+0x3C  ;; TaN
        LDRH     R1,[R1, #+0]
        LDR.W    R2,??Display_Value_1+0x40  ;; 0x7a120
        MULS     R1,R1,R2
        LDR.W    R2,??Display_Value_1+0x44  ;; TaS
        LDRH     R2,[R2, #+0]
        SDIV     R1,R1,R2
        MOV      R2,#+2000
        MUL      R4,R1,R2
        B.N      ??Display_Value_24
??Display_Value_23:
        CMP      R1,#+1
        BNE.N    ??Display_Value_25
        LDRSH    R1,[R5, #+96]
        CMP      R1,#+1
        BNE.N    ??Display_Value_24
        LDR.W    R1,??Display_Value_1+0x48  ;; TbN
        LDRH     R1,[R1, #+0]
        LDR.W    R2,??Display_Value_1+0x40  ;; 0x7a120
        MULS     R1,R1,R2
        LDR.W    R2,??Display_Value_1+0x4C  ;; TbS
        LDRH     R2,[R2, #+0]
        SDIV     R1,R1,R2
        MOV      R2,#+2000
        MUL      R4,R1,R2
        B.N      ??Display_Value_24
??Display_Value_25:
        CMP      R1,#+2
        BNE.N    ??Display_Value_26
        LDRSH    R1,[R5, #+176]
        CMP      R1,#+1
        BNE.N    ??Display_Value_24
        LDR.N    R1,??Display_Value_1+0x50  ;; TcN
        LDRH     R1,[R1, #+0]
        LDR.N    R2,??Display_Value_1+0x40  ;; 0x7a120
        MULS     R1,R1,R2
        LDR.N    R2,??Display_Value_1+0x54  ;; TcS
        LDRH     R2,[R2, #+0]
        SDIV     R1,R1,R2
        MOV      R2,#+2000
        MUL      R4,R1,R2
        B.N      ??Display_Value_24
??Display_Value_26:
        CMP      R1,#+3
        BNE.N    ??Display_Value_24
        LDRSH    R1,[R5, #+256]
        CMP      R1,#+1
        BNE.N    ??Display_Value_24
        LDR.N    R1,??Display_Value_1+0x58  ;; TdN
        LDRH     R1,[R1, #+0]
        LDR.N    R2,??Display_Value_1+0x40  ;; 0x7a120
        MULS     R1,R1,R2
        LDR.N    R2,??Display_Value_1+0x5C  ;; TdS
        LDRH     R2,[R2, #+0]
        SDIV     R1,R1,R2
        MOV      R2,#+2000
        MUL      R4,R1,R2
??Display_Value_24:
        MOVS     R1,#+60
        UDIV     R0,R0,R1
        UDIV     R0,R4,R0
        LDR.N    R1,??Display_Value_1+0x4  ;; Y_COLOR
        CMP      R8,#+10
        BCS.N    ??Display_Value_27
        MOVS     R2,#+1
        PUSH     {R2,LR}
        CFI CFA R13+48
        MOVS     R3,#+4
        ADD      R2,R1,#+36
        MOVS     R1,#+250
        MULS     R0,R0,R1
        UDIV     R0,R0,R10
        MOVS     R1,#+15
        UDIV     R1,R0,R1
        ADD      R0,R5,#+1168
        B.N      ??Display_Value_6
        CFI CFA R13+40
??Display_Value_27:
        MOVS     R2,#+1
        PUSH     {R2,LR}
        CFI CFA R13+48
        MOVS     R3,#+4
        ADD      R2,R1,#+36
        MUL      R0,R8,R0
        MOVS     R1,#+240
        UDIV     R0,R0,R1
        MULS     R0,R6,R0
        LSRS     R1,R0,#+8
        ADD      R0,R5,#+1168
        B.N      ??Display_Value_6
        CFI CFA R13+40
??Display_Value_28:
        LDRB     R1,[R7, #+1044]
        CBNZ     R1,??Display_Value_29
        LDRSH    R1,[R5, #+16]
        CMP      R1,#+1
        BNE.N    ??Display_Value_30
        LDR.N    R1,??Display_Value_1+0x44  ;; TaS
        LDRH     R1,[R1, #+0]
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x3C  ;; TaN
        LDRH     R1,[R1, #+0]
        UDIV     R4,R0,R1
        B.N      ??Display_Value_30
??Display_Value_29:
        CMP      R1,#+1
        BNE.N    ??Display_Value_31
        LDRSH    R1,[R5, #+96]
        CMP      R1,#+1
        BNE.N    ??Display_Value_30
        LDR.N    R1,??Display_Value_1+0x4C  ;; TbS
        LDRH     R1,[R1, #+0]
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x48  ;; TbN
        LDRH     R1,[R1, #+0]
        UDIV     R4,R0,R1
        B.N      ??Display_Value_30
??Display_Value_31:
        CMP      R1,#+2
        BNE.N    ??Display_Value_32
        LDRSH    R1,[R5, #+176]
        CMP      R1,#+1
        BNE.N    ??Display_Value_30
        LDR.N    R1,??Display_Value_1+0x54  ;; TcS
        LDRH     R1,[R1, #+0]
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x50  ;; TcN
        LDRH     R1,[R1, #+0]
        UDIV     R4,R0,R1
        B.N      ??Display_Value_30
??Display_Value_32:
        CMP      R1,#+3
        BNE.N    ??Display_Value_30
        LDRSH    R1,[R5, #+256]
        CMP      R1,#+1
        BNE.N    ??Display_Value_30
        LDR.N    R1,??Display_Value_1+0x5C  ;; TdS
        LDRH     R1,[R1, #+0]
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x58  ;; TdN
        LDRH     R1,[R1, #+0]
        UDIV     R4,R0,R1
??Display_Value_30:
        MVN      R0,#-2147483648
        UDIV     R0,R0,R10
        CMP      R0,R4
        BCC.N    ??Display_Value_33
        MUL      R0,R10,R4
        UDIV     R0,R0,R6
        LSLS     R0,R0,#+10
        UDIV     R4,R0,R8
        B.N      ??Display_Value_34
??Display_Value_33:
        MOV      R4,#-2147483648
??Display_Value_34:
        MOVS     R0,#+1
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+4
        LDR.W    R2,??DataTable23  ;; Y_COLOR + 12
        MOVS     R1,R4
        ADD      R0,R5,#+1168
        B.N      ??Display_Value_6
        CFI CFA R13+40
??Display_Value_35:
        LDRB     R1,[R7, #+1044]
        CBNZ     R1,??Display_Value_36
        LDRSH    R0,[R5, #+16]
        CMP      R0,#+1
        BNE.N    ??Display_Value_37
        LDR.N    R0,??Display_Value_1+0x60  ;; PaS
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??Display_Value_1+0x64  ;; 0x186a0
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x44  ;; TaS
        LDRH     R1,[R1, #+0]
        SDIV     R4,R0,R1
        B.N      ??Display_Value_37
??Display_Value_36:
        CMP      R1,#+1
        BNE.N    ??Display_Value_38
        LDRSH    R0,[R5, #+96]
        CMP      R0,#+1
        BNE.N    ??Display_Value_37
        LDR.N    R0,??Display_Value_1+0x68  ;; PbS
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??Display_Value_1+0x64  ;; 0x186a0
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x4C  ;; TbS
        LDRH     R1,[R1, #+0]
        SDIV     R4,R0,R1
        B.N      ??Display_Value_37
??Display_Value_38:
        CMP      R1,#+2
        BNE.N    ??Display_Value_39
        LDRSH    R0,[R5, #+176]
        CMP      R0,#+1
        BNE.N    ??Display_Value_37
        LDR.N    R0,??Display_Value_1+0x6C  ;; PcS
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??Display_Value_1+0x64  ;; 0x186a0
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x54  ;; TcS
        LDRH     R1,[R1, #+0]
        SDIV     R4,R0,R1
        B.N      ??Display_Value_37
??Display_Value_39:
        CMP      R1,#+3
        BNE.N    ??Display_Value_37
        LDRSH    R0,[R5, #+256]
        CMP      R0,#+1
        BNE.N    ??Display_Value_37
        LDR.N    R0,??Display_Value_1+0x70  ;; PdS
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??Display_Value_1+0x64  ;; 0x186a0
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x5C  ;; TdS
        LDRH     R1,[R1, #+0]
        SDIV     R4,R0,R1
??Display_Value_37:
        MOVS     R0,#+1
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+4
        LDR.W    R2,??DataTable25  ;; Y_COLOR + 60
        MOVS     R1,R4
        ADD      R0,R5,#+1168
        B.N      ??Display_Value_6
        CFI CFA R13+40
??Display_Value_40:
        LDRB     R1,[R7, #+1044]
        CBNZ     R1,??Display_Value_41
        LDRSH    R1,[R5, #+16]
        CMP      R1,#+1
        BNE.N    ??Display_Value_30
        LDR.N    R1,??Display_Value_1+0x3C  ;; TaN
        LDRH     R1,[R1, #+0]
        LDR.N    R2,??Display_Value_1+0x44  ;; TaS
        LDRH     R2,[R2, #+0]
        MULS     R2,R0,R2
        UDIV     R2,R2,R1
        LDR.N    R3,??Display_Value_1+0x60  ;; PaS
        LDRH     R3,[R3, #+0]
        MULS     R0,R0,R3
        UDIV     R0,R0,R1
        SUBS     R4,R2,R0
        B.N      ??Display_Value_30
??Display_Value_41:
        CMP      R1,#+1
        BNE.N    ??Display_Value_42
        LDRSH    R0,[R5, #+96]
        CMP      R0,#+1
        BNE.N    ??Display_Value_30
        LDR.N    R0,??Display_Value_1+0x68  ;; PbS
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??Display_Value_1+0x64  ;; 0x186a0
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x4C  ;; TbS
        LDRH     R1,[R1, #+0]
        SDIV     R4,R0,R1
        B.N      ??Display_Value_30
??Display_Value_42:
        CMP      R1,#+2
        BNE.N    ??Display_Value_43
        LDRSH    R0,[R5, #+176]
        CMP      R0,#+1
        BNE.W    ??Display_Value_30
        LDR.N    R0,??Display_Value_1+0x6C  ;; PcS
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??Display_Value_1+0x64  ;; 0x186a0
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x54  ;; TcS
        LDRH     R1,[R1, #+0]
        SDIV     R4,R0,R1
        B.N      ??Display_Value_30
??Display_Value_43:
        CMP      R1,#+3
        BNE.W    ??Display_Value_30
        LDRSH    R0,[R5, #+256]
        CMP      R0,#+1
        BNE.W    ??Display_Value_30
        LDR.N    R0,??Display_Value_1+0x70  ;; PdS
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??Display_Value_1+0x64  ;; 0x186a0
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x5C  ;; TdS
        LDRH     R1,[R1, #+0]
        SDIV     R4,R0,R1
        B.N      ??Display_Value_30
??Display_Value_44:
        LDRB     R1,[R7, #+1044]
        CBNZ     R1,??Display_Value_45
        LDRSH    R1,[R5, #+16]
        CMP      R1,#+1
        BNE.W    ??Display_Value_30
        LDR.N    R1,??Display_Value_1+0x60  ;; PaS
        LDRH     R1,[R1, #+0]
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x3C  ;; TaN
        LDRH     R1,[R1, #+0]
        UDIV     R4,R0,R1
        B.N      ??Display_Value_30
??Display_Value_45:
        CMP      R1,#+1
        BNE.N    ??Display_Value_46
        LDRSH    R1,[R5, #+96]
        CMP      R1,#+1
        BNE.W    ??Display_Value_30
        LDR.N    R1,??Display_Value_1+0x68  ;; PbS
        LDRH     R1,[R1, #+0]
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x48  ;; TbN
        LDRH     R1,[R1, #+0]
        UDIV     R4,R0,R1
        B.N      ??Display_Value_30
??Display_Value_46:
        CMP      R1,#+2
        BNE.N    ??Display_Value_47
        LDRSH    R1,[R5, #+176]
        CMP      R1,#+1
        BNE.W    ??Display_Value_30
        LDR.N    R1,??Display_Value_1+0x6C  ;; PcS
        LDRH     R1,[R1, #+0]
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x50  ;; TcN
        LDRH     R1,[R1, #+0]
        UDIV     R4,R0,R1
        B.N      ??Display_Value_30
??Display_Value_47:
        CMP      R1,#+3
        BNE.W    ??Display_Value_30
        LDRSH    R1,[R5, #+256]
        CMP      R1,#+1
        BNE.W    ??Display_Value_30
        LDR.N    R1,??Display_Value_1+0x70  ;; PdS
        LDRH     R1,[R1, #+0]
        MULS     R0,R0,R1
        LDR.N    R1,??Display_Value_1+0x58  ;; TdN
        LDRH     R1,[R1, #+0]
        UDIV     R4,R0,R1
        B.N      ??Display_Value_30
        DATA
??Display_Value_1:
        DC32     Interlace
        DC32     Y_COLOR
        DC32     Y_COLOR + 48
        DC32     Ka2
        DC32     a_Max
        DC32     a_Min
        DC32     Kb2
        DC32     b_Max
        DC32     b_Min
        DC32     Ka1
        DC32     a_Avg
        DC32     Kb1
        DC32     b_Avg
        DC32     a_Ssq
        DC32     b_Ssq
        DC32     TaN
        DC32     0x7a120
        DC32     TaS
        DC32     TbN
        DC32     TbS
        DC32     TcN
        DC32     TcS
        DC32     TdN
        DC32     TdS
        DC32     PaS
        DC32     0x186a0
        DC32     PbS
        DC32     PcS
        DC32     PdS
        CFI EndBlock cfiBlock1
//  366 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function Display_Title
        THUMB
//  367 void Display_Title(void)
//  368 {
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
//  369   u16  i, j;
//  370   s32  k, n, m;
//  371   
//  372   for(i = TRACK1; i <= VOLUME; ++i){
        MOVS     R4,#+0
        LDR.W    R5,??DataTable34  ;; Title
        ADD      R0,R5,#+1152
        STR      R0,[SP, #+0]
        ADD      R10,R5,#+16
//  373     for(j = 0; j < 4; ++j){
??Display_Title_0:
        MOV      R11,#+0
        SUB      R6,R10,#+6
//  374       if(Title[i][j].Flag & UPDAT){   // 需要刷新的Item
??Display_Title_1:
        LDRB     R0,[R6, #+8]
        TST      R0,#0x2
        BEQ.W    ??Display_Title_2
//  375         Title[i][j].Flag &= ~UPDAT;   // Clr Update flag 
        AND      R0,R0,#0xFD
        STRB     R0,[R6, #+8]
//  376         if((i == BATTERY)||(i == TRIGG)){
        UXTH     R0,R4
        CMP      R0,#+4
        BEQ.N    ??Display_Title_3
        CMP      R0,#+7
        BNE.N    ??Display_Title_4
//  377           if(Title[i][j].MARK & FIX){                  // ---- Under fix mode
??Display_Title_3:
        LDRB     R0,[R6, #+0]
        TST      R0,#0x20
        BEQ.N    ??Display_Title_5
//  378             Print_Str( 
//  379               Title[i][j].XPOS, Title[i][j].YPOS,
//  380               Title[i][j].Color[Title[i][0].Value],    // Color variable 
//  381               PRN, 
//  382               Title[i][j].Str                          // String fixed
//  383             );                    
        LDR      R0,[R6, #-10]
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDRSH    R0,[R10, #+0]
        SUB      R1,R6,#+10
        LDR      R1,[R1, #+4]
        LDRH     R2,[R1, R0, LSL #+1]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  384           } else if(!(Title[i][j].MARK & NOT)){        // ---- Under other mode
??Display_Title_5:
        TST      R0,#0x80
        BNE.W    ??Display_Title_7
//  385             Print_Str(
//  386               Title[i][j].XPOS, Title[i][j].YPOS,
//  387               Title[i][j].Color[Title[i][0].Value],    // Color variable 
//  388               PRN, 
//  389               Title[i][j].Str +(Title[i][j].Value * 10)// String variable
//  390             ); 
        LDRSH    R0,[R6, #+6]
        MOVS     R1,#+10
        LDR      R2,[R6, #-10]
        MLA      R0,R0,R1,R2
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDRSH    R0,[R10, #+0]
        SUB      R1,R6,#+10
        LDR      R1,[R1, #+4]
        LDRH     R2,[R1, R0, LSL #+1]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  391           }
//  392         } else {
//  393           if(Title[i][j].MARK & FIX){                  // ---- Under fix mode
??Display_Title_4:
        LDRB     R0,[R6, #+0]
        TST      R0,#0x20
        BEQ.N    ??Display_Title_8
//  394             Print_Str(
//  395               Title[i][j].XPOS, Title[i][j].YPOS,
//  396               Title[i][j].Color[0],                    // Color fixed 
//  397               PRN, 
//  398               Title[i][j].Str                          // String fixed
//  399              );
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
//  400           } else if(Title[i][j].MARK & NUM3){          // ---- Under NUM3 mode
??Display_Title_8:
        TST      R0,#0x2
        BEQ.W    ??Display_Title_10
//  401             if(i == V_VERNIE){
        UXTH     R0,R4
        CMP      R0,#+8
        BNE.N    ??Display_Title_11
//  402               Int2Str(NumStr,(_V1_Vernie-_V2_Vernie)*_Meas_V_Scale, V_UNIT, 3, SIGN);
        MOVS     R0,#+0
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+3
        LDR.N    R2,??DataTable20  ;; Y_COLOR + 24
        LDRSH    R0,[R5, #+656]
        LDRSH    R1,[R5, #+676]
        SUBS     R0,R0,R1
        LDRSH    R1,[R5, #+696]
        MOV      R12,#+80
        MLA      R1,R1,R12,R5
        LDRSH    R1,[R1, #+56]
        MOV      R12,#+20
        LDR.W    LR,??DataTable35  ;; Y_Attr
        LDR      LR,[LR, #+0]
        MLA      R1,R1,R12,LR
        LDR      R1,[R1, #+16]
        MULS     R1,R0,R1
        ADD      R0,R5,#+1168
        BL       Int2Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  403               Print_Str(
//  404                 Title[i][j].XPOS, Title[i][j].YPOS,
//  405                 Title[i][j].Color[_Meas_V_Track],      // Color fixed  
//  406                 PRN, 
//  407                 NumStr                                // String for numerical
//  408               );
        ADD      R0,R5,#+1168
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDRSH    R0,[R5, #+696]
        SUB      R1,R6,#+10
        LDR      R1,[R1, #+4]
        LDRH     R2,[R1, R0, LSL #+1]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  409             }
//  410             if(i == T_VERNIE){
??Display_Title_11:
        UXTH     R0,R4
        CMP      R0,#+10
        BNE.N    ??Display_Title_12
//  411               m = 1;  n = 1;
        MOVS     R7,#+1
        MOV      R8,R7
//  412               k = _T_Range;
        LDRSH    R9,[R5, #+436]
//  413               if(k < 9)  m = Power(10, (11-k)/3);
        CMP      R9,#+9
        BGE.N    ??Display_Title_13
        RSB      R0,R9,#+11
        MOVS     R1,#+3
        SDIV     R1,R0,R1
        UXTB     R1,R1
        MOVS     R0,#+10
        BL       Power
        MOVS     R7,R0
        B.N      ??Display_Title_14
//  414               else       n = Power(10, (k- 9)/3);
??Display_Title_13:
        SUB      R0,R9,#+9
        MOVS     R1,#+3
        SDIV     R1,R0,R1
        UXTB     R1,R1
        MOVS     R0,#+10
        BL       Power
        MOV      R8,R0
//  415               k = X_Attr[(k%3)+9].SCALE *(_T2 - _T1);
??Display_Title_14:
        MOVS     R0,#+3
        SDIV     R0,R9,R0
        MOVS     R1,#+3
        MLS      R0,R0,R1,R9
        MOVS     R1,#+20
        LDR.N    R2,??DataTable36  ;; X_Attr
        LDR      R2,[R2, #+0]
        MLA      R0,R0,R1,R2
        LDR      R0,[R0, #+196]
        LDRSH    R1,[R5, #+836]
        LDRSH    R2,[R5, #+816]
        SUBS     R1,R1,R2
        MULS     R0,R0,R1
//  416               if(k > 0){
        MVN      R1,#-2147483648
        SDIV     R1,R1,R7
        CMP      R0,#+1
        BLT.N    ??Display_Title_15
//  417                 if(k <=  0x7FFFFFFF/m)  k = (m * k)/n;
        CMP      R1,R0
        BLT.N    ??Display_Title_16
        MULS     R0,R7,R0
        SDIV     R1,R0,R8
        B.N      ??Display_Title_17
//  418                 else                    k = 0x80000000;
??Display_Title_16:
        MOV      R1,#-2147483648
        B.N      ??Display_Title_17
//  419               } else {
//  420                 if((-k)> 0x7FFFFFFF/m)  k = (m * k)/n;
??Display_Title_15:
        RSBS     R2,R0,#+0
        CMP      R1,R2
        BGE.N    ??Display_Title_18
        MULS     R0,R7,R0
        SDIV     R1,R0,R8
        B.N      ??Display_Title_17
//  421                 else                    k = 0x80000000;
??Display_Title_18:
        MOV      R1,#-2147483648
//  422               }
//  423               Int2Str(NumStr, k, T_UNIT, 3, SIGN);
??Display_Title_17:
        MOVS     R0,#+0
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+3
        LDR.N    R2,??DataTable23  ;; Y_COLOR + 12
        ADD      R0,R5,#+1168
        BL       Int2Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  424               Print_Str(
//  425                 Title[i][j].XPOS, Title[i][j].YPOS,
//  426                 Title[i][j].Color[0],                  // Color fixed  
//  427                 PRN, 
//  428                 NumStr                                // String for numerical
//  429               );
        ADD      R0,R5,#+1168
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        SUB      R0,R6,#+10
        LDR      R0,[R0, #+4]
        LDRH     R2,[R0, #+0]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  430             }
//  431             if(i==FILE){//??????????????????????????????
??Display_Title_12:
        UXTH     R0,R4
        CMP      R0,#+9
        BNE.W    ??Display_Title_7
//  432                u8ToDec3(Title[FILE][1].Str, Title[FILE][1].Value);
        LDRH     R1,[R5, #+756]
        UXTB     R1,R1
        LDR      R0,[R5, #+740]
        BL       u8ToDec3
//  433                Print_Str(
//  434                 Title[FILE][1].XPOS, Title[FILE][1].YPOS,
//  435                 Title[FILE][1].Color[0],                  // Color fixed  
//  436                 PRN, 
//  437                 Title[FILE][1].Str                        // String for numerical
//  438               );
        LDR      R0,[R5, #+740]
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDR      R0,[R5, #+744]
        LDRH     R2,[R0, #+0]
        LDRB     R1,[R5, #+754]
        LDRH     R0,[R5, #+752]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  439             }
//  440           } else if(Title[i][j].MARK == NUM2){ 
??Display_Title_10:
        CMP      R0,#+1
        BNE.N    ??Display_Title_19
//  441                 NumStr[0]=' ';
        ADD      R0,R5,#+1168
        MOVS     R1,#+32
        STRB     R1,[R0, #+0]
//  442             if(i == BK_LIGHT){                        // 背光百分比显示处理
        LDRSH    R0,[R6, #+6]
        UXTH     R1,R4
        CMP      R1,#+11
        BNE.N    ??Display_Title_20
//  443               if(Title[i][j].Value == 9){
        CMP      R0,#+9
        BNE.N    ??Display_Title_21
//  444                 Int2Str(NumStr, 100, P_UNIT, 3, STD);
??Display_Title_22:
        MOVS     R0,#+2
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+3
        LDR.N    R2,??DataTable25  ;; Y_COLOR + 60
        MOVS     R1,#+100
        ADD      R0,R5,#+1168
??Display_Title_23:
        BL       Int2Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  445                 } else Int2Str(NumStr, 10*(Title[i][j].Value+1), P_UNIT, 2, STD);
//  446             } else {                                  // 音量百分比显示处理
//  447               if(Title[i][j].Value == 10){
//  448                 Int2Str(NumStr, 100, P_UNIT, 3, STD);
//  449               } else Int2Str(NumStr, 10*(Title[i][j].Value+1), P_UNIT, 2, STD);
//  450             }
//  451             Print_Str(
//  452               Title[i][j].XPOS, Title[i][j].YPOS,
//  453               Title[i][j].Color[0],                  // Color fixed  
//  454               PRN, 
//  455               NumStr                        // String for numerical
//  456             );
        ADD      R0,R5,#+1168
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
??Display_Title_20:
        CMP      R0,#+10
        BEQ.N    ??Display_Title_22
??Display_Title_21:
        MOVS     R1,#+2
        PUSH     {R1,LR}
        CFI CFA R13+48
        MOVS     R3,#+2
        LDR.N    R2,??DataTable25  ;; Y_COLOR + 60
        ADDS     R0,R0,#+1
        MOVS     R1,#+10
        MULS     R1,R0,R1
        ADD      R0,R5,#+1168
        B.N      ??Display_Title_23
        CFI CFA R13+40
//  457           } else if(Title[i][j].MARK != NOT){
??Display_Title_19:
        CMP      R0,#+128
        BEQ.N    ??Display_Title_24
//  458           
//  459             if(i == V_VERNIE){
        SUB      R0,R6,#+10
        UXTH     R1,R4
        CMP      R1,#+8
        BNE.N    ??Display_Title_25
//  460               Print_Str(
//  461                 Title[i][j].XPOS, Title[i][j].YPOS,
//  462                 Title[i][j].Color[_Meas_V_Track],         // Color variable 
//  463                 PRN, 
//  464                 Title[i][j].Str +(Title[i][j].Value * 10)// String variable
//  465               ); 
        LDRSH    R1,[R6, #+6]
        MOVS     R2,#+10
        LDR      R3,[R6, #-10]
        MLA      R1,R1,R2,R3
        PUSH     {R1,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDRSH    R1,[R5, #+696]
        LDR      R0,[R0, #+4]
        LDRH     R2,[R0, R1, LSL #+1]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  466             } else {
//  467               Print_Str(
//  468                 Title[i][j].XPOS, Title[i][j].YPOS,
//  469                 Title[i][j].Color[0],                    // Color fixed 
//  470                 PRN, 
//  471                 Title[i][j].Str +(Title[i][j].Value * 10)// String variable
//  472               ); 
??Display_Title_25:
        LDRSH    R1,[R6, #+6]
        MOVS     R2,#+10
        LDR      R3,[R6, #-10]
        MLA      R1,R1,R2,R3
        PUSH     {R1,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        LDR      R0,[R0, #+4]
        LDRH     R2,[R0, #+0]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  473             }
//  474           } else if(i == T_VERNIE){
??Display_Title_24:
        UXTH     R0,R4
        CMP      R0,#+10
        BNE.W    ??Display_Title_7
        B.N      ??Display_Title_9
//  475             Print_Str(
//  476               Title[i][j].XPOS, Title[i][j].YPOS,
//  477               Title[i][j].Color[0],                    // Color fixed 
//  478               PRN, 
//  479               Title[i][j].Str                          // String variable
//  480             ); 
//  481           }
//  482         }//
//  483       } else if((Current == i)&&(Detail[i] == j)&&(Blink)){ // 当前光标位置的Item
??Display_Title_2:
        LDRB     R0,[R5, #+1148]
        UXTH     R1,R4
        CMP      R0,R1
        BNE.W    ??Display_Title_7
        LDR      R0,[SP, #+0]
        LDRB     R0,[R0, #+0]
        UXTH     R1,R11
        CMP      R0,R1
        BNE.W    ??Display_Title_7
        LDR.N    R0,??DataTable27  ;; Blink
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Display_Title_7
//  484         Blink = 0;
        LDR.N    R0,??DataTable27  ;; Blink
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  485         if((i == BATTERY)||(i == TRIGG)){
        UXTH     R0,R4
        CMP      R0,#+4
        BEQ.N    ??Display_Title_26
        CMP      R0,#+7
        BNE.N    ??Display_Title_27
//  486           if((Title[i][j].MARK & FIX)){      // ---- Under fix mode
??Display_Title_26:
        SUB      R0,R6,#+10
        LDRB     R1,[R6, #+0]
        TST      R1,#0x20
        BEQ.N    ??Display_Title_28
//  487             Print_Str( 
//  488               Title[i][j].XPOS, Title[i][j].YPOS,
//  489               Title[i][j].Color[Title[i][0].Value],    // Color variable 
//  490               Twink, 
//  491               Title[i][j].Str                          // String fixed
//  492             );                    
        LDR      R1,[R6, #-10]
        PUSH     {R1,LR}
        CFI CFA R13+48
        LDR.N    R1,??DataTable33  ;; Twink
        LDRB     R3,[R1, #+0]
        LDRSH    R1,[R10, #+0]
        LDR      R0,[R0, #+4]
        LDRH     R2,[R0, R1, LSL #+1]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  493           } else {                                // ---- Under other mode
//  494             Print_Str(
//  495               Title[i][j].XPOS, Title[i][j].YPOS,
//  496               Title[i][j].Color[Title[i][0].Value],    // Color variable 
//  497               Twink, 
//  498               Title[i][j].Str +(Title[i][j].Value * 10)// String variable
//  499             ); 
??Display_Title_28:
        LDRSH    R1,[R6, #+6]
        MOVS     R2,#+10
        LDR      R3,[R6, #-10]
        MLA      R1,R1,R2,R3
        PUSH     {R1,LR}
        CFI CFA R13+48
        LDR.N    R1,??DataTable33  ;; Twink
        LDRB     R3,[R1, #+0]
        LDRSH    R1,[R10, #+0]
        LDR      R0,[R0, #+4]
        LDRH     R2,[R0, R1, LSL #+1]
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        B.N      ??Display_Title_6
        CFI CFA R13+40
//  500           }
//  501         } else {
//  502           if(Title[i][j].MARK & FIX){             // ---- Under fix mode
??Display_Title_27:
        LDRB     R0,[R6, #+0]
        TST      R0,#0x20
        BEQ.N    ??Display_Title_29
//  503             Print_Str(
//  504               Title[i][j].XPOS, Title[i][j].YPOS,
//  505               Title[i][j].Color[0],                    // Color fixed 
//  506               Twink, 
//  507               Title[i][j].Str                          // String fixed
//  508             );
        LDR      R0,[R6, #-10]
        PUSH     {R0,LR}
        CFI CFA R13+48
        LDR.N    R0,??DataTable33  ;; Twink
        LDRB     R3,[R0, #+0]
        SUB      R0,R6,#+10
        B.N      ??Display_Title_30
        CFI CFA R13+40
//  509      } else if(Title[i][j].MARK != NUM3){
??Display_Title_29:
        CMP      R0,#+2
        BEQ.N    ??Display_Title_31
//  510                  if(i == V_VERNIE){
        SUB      R0,R6,#+10
        UXTH     R1,R4
        CMP      R1,#+8
        BNE.N    ??Display_Title_32
//  511               Print_Str(
//  512                 Title[i][j].XPOS, Title[i][j].YPOS,
//  513                 Title[i][j].Color[_Meas_V_Track],        // Color variable=
//  514                 Twink, 
//  515                 Title[i][j].Str +(Title[i][j].Value * 10)// String variable
//  516               ); 
        LDRSH    R1,[R6, #+6]
        MOVS     R2,#+10
        LDR      R3,[R6, #-10]
        MLA      R1,R1,R2,R3
        PUSH     {R1,LR}
        CFI CFA R13+48
        LDR.N    R1,??DataTable33  ;; Twink
        LDRB     R3,[R1, #+0]
        LDRSH    R1,[R5, #+696]
        LDR      R0,[R0, #+4]
        LDRH     R2,[R0, R1, LSL #+1]
        B.N      ??Display_Title_33
        CFI CFA R13+40
//  517             } else {
//  518               Print_Str(
//  519                 Title[i][j].XPOS, Title[i][j].YPOS,
//  520                 Title[i][j].Color[0],                    // Color fixed 
//  521                 Twink, 
//  522                 Title[i][j].Str +(Title[i][j].Value * 10)// String variable
//  523               ); 
??Display_Title_32:
        LDRSH    R1,[R6, #+6]
        MOVS     R2,#+10
        LDR      R3,[R6, #-10]
        MLA      R1,R1,R2,R3
        PUSH     {R1,LR}
        CFI CFA R13+48
        LDR.N    R1,??DataTable33  ;; Twink
        LDRB     R3,[R1, #+0]
??Display_Title_30:
        LDR      R0,[R0, #+4]
        LDRH     R2,[R0, #+0]
??Display_Title_33:
        LDRB     R1,[R6, #+4]
        LDRH     R0,[R6, #+2]
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  524       }
//  525                   }
//  526             if((i == FILE)&&(Title[i][j].MARK & NUM3)){
??Display_Title_31:
        UXTH     R0,R4
        CMP      R0,#+9
        BNE.N    ??Display_Title_7
        LDRB     R0,[R6, #+0]
        TST      R0,#0x2
        BEQ.N    ??Display_Title_7
//  527               u8ToDec3(Title[i][1].Str, Title[i][1].Value);
        LDRH     R1,[R10, #+20]
        UXTB     R1,R1
        LDR      R0,[R10, #+4]
        BL       u8ToDec3
//  528               Print_Str(
//  529                 Title[i][1].XPOS, Title[i][1].YPOS,
//  530                 Title[i][1].Color[0],                  // Color fixed  
//  531                 Twink, 
//  532                 Title[i][1].Str                        // String for numerical
//  533               );
        LDR      R0,[R10, #+4]
        PUSH     {R0,LR}
        CFI CFA R13+48
        LDR.N    R0,??DataTable33  ;; Twink
        LDRB     R3,[R0, #+0]
        LDR      R0,[R10, #+8]
        LDRH     R2,[R0, #+0]
        LDRB     R1,[R10, #+18]
        LDRH     R0,[R10, #+16]
??Display_Title_6:
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  534             }
//  535         }
//  536       }
//  537     }
??Display_Title_7:
        ADD      R11,R11,#+1
        ADDS     R6,R6,#+20
        UXTH     R0,R11
        CMP      R0,#+4
        BCC.W    ??Display_Title_1
//  538   }
        ADDS     R4,R4,#+1
        ADD      R10,R10,#+80
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+0]
        UXTH     R0,R4
        CMP      R0,#+13
        BCC.W    ??Display_Title_0
//  539 }
        ADD      SP,SP,#+4
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        CFI EndBlock cfiBlock2

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable20:
        DC32     Y_COLOR + 24

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable23:
        DC32     Y_COLOR + 12

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable25:
        DC32     Y_COLOR + 60

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable27:
        DC32     Blink

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable33:
        DC32     Twink
//  540 /*******************************************************************************
//  541  Load_Attr:  加载硬件属性
//  542 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function Load_Attr
        THUMB
//  543 void Load_Attr(void)
//  544 {
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
//  545   u16 i;
//  546   
//  547   for(i=0; i<G_Attr[0].Yp_Max+1; ++i) 
        MOVS     R6,#+0
        LDR.N    R4,??DataTable34  ;; Title
        ADDW     R7,R4,#+1180
        MOV      R8,R6
        LDR.W    R9,??DataTable35  ;; Y_Attr
        LDR.N    R5,??Load_Attr_0  ;; G_Attr
        LDR      R0,[R5, #+0]
        LDRH     R0,[R0, #+4]
        ADDS     R0,R0,#+1
        CMP      R0,#+1
        BLT.N    ??Load_Attr_1
//  548     strcpy(&Vertical[i][0], Y_Attr[i].STR);
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
//  549   Title[TRACK1][RANGE].Limit = G_Attr[0].Yp_Max;
??Load_Attr_1:
        LDR      R0,[R5, #+0]
        LDRSH    R1,[R0, #+4]
        STRH     R1,[R4, #+48]
//  550   Title[TRACK2][RANGE].Limit = G_Attr[0].Yp_Max;
        LDRSH    R1,[R0, #+4]
        STRH     R1,[R4, #+128]
//  551   Title[TRACK3][RANGE].Limit = 0;
        MOVS     R1,#+0
        STRH     R1,[R4, #+208]
//  552   Title[TRACK4][RANGE].Limit = 0;
        STRH     R1,[R4, #+288]
//  553   
//  554   for(i=0; i<G_Attr[0].Xp_Max+6; ++i) 
        MOVS     R6,#+0
        ADDW     R7,R4,#+1332
        MOV      R8,R1
        LDR.W    R9,??DataTable36  ;; X_Attr
        LDRH     R0,[R0, #+6]
        ADDS     R0,R0,#+6
        CMP      R0,#+1
        BLT.N    ??Load_Attr_3
//  555     strcpy(&BaseStr[i][0], X_Attr[i].STR);
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
        ADDS     R0,R0,#+6
        CMP      R6,R0
        BLT.N    ??Load_Attr_4
//  556   Title[T_BASE][BASE].Limit = G_Attr[0].Xp_Max;
??Load_Attr_3:
        LDR      R0,[R5, #+0]
        LDRSH    R0,[R0, #+6]
        STRH     R0,[R4, #+428]
//  557   
//  558 }
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
??DataTable34:
        DC32     Title

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable35:
        DC32     Y_Attr

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable36:
        DC32     X_Attr
//  559 /*******************************************************************************
//  560  Update_Battery:  刷新电池电量指示
//  561 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function Update_Battery
        THUMB
//  562 void Update_Battery(void)
//  563 {
Update_Battery:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  564   u16 Vb, Level;
//  565   
//  566   Vb = __Get(V_BATTERY);
        MOVS     R0,#+6
        BL       __Get
        UXTH     R0,R0
//  567   Level =0;
        MOVS     R1,#+0
//  568   if(Vb > 3000 ) Level +=1;
        MOVW     R3,#+3001
        CMP      R0,R3
        IT       CS 
        MOVCS    R1,#+1
//  569   if(Vb > 3500 ) Level +=1;
        MOVW     R3,#+3501
        CMP      R0,R3
        BCC.N    ??Update_Battery_0
        ADDS     R1,R1,#+1
        UXTH     R1,R1
//  570   if(Vb > 3900 ) Level +=1;
??Update_Battery_0:
        MOVW     R3,#+3901
        CMP      R0,R3
        BCC.N    ??Update_Battery_1
        ADDS     R1,R1,#+1
        UXTH     R1,R1
//  571   if(Vb > 4100 ) Level +=1;
??Update_Battery_1:
        MOVW     R2,#+4101
        CMP      R0,R2
        BCC.N    ??Update_Battery_2
        ADDS     R1,R1,#+1
        UXTH     R1,R1
//  572   Print_Str(
//  573     Title[4][1].XPOS, Title[4][1].YPOS,
//  574     Title[4][1].Color[Level], 
//  575     PRN,
//  576     (Title[4][1].Str + Level*10) 
//  577   );    
??Update_Battery_2:
        LDR.N    R0,??Update_Battery_3  ;; Title
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
//  578 }
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        DATA
??Update_Battery_3:
        DC32     Title
        CFI EndBlock cfiBlock4

        END
//  579 /******************************** END OF FILE *********************************/
// 
//     1 byte  in section .bss
// 1 649 bytes in section .data
// 1 122 bytes in section .rodata
// 3 506 bytes in section .text
// 
// 3 506 bytes of CODE  memory
// 1 122 bytes of CONST memory
// 1 650 bytes of DATA  memory
//
//Errors: none
//Warnings: 4
