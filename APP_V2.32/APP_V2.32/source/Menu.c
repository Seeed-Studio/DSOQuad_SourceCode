/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : Menu.c  
 Version   : DS203_APP Ver 2.3x                                  Author : bure
*******************************************************************************/
#include <string.h>
#include "Interrupt.h"
#include "Function.h"
#include "Process.h"
#include "Menu.h"
#include "Draw.h"
#include "BIOS.h"

I32STR_RES Num;

u16 Result_FPS;

u8 V_Unit[4][3]={"uV","mV","V ","kV"};
u8 T_Unit[4][3]={"nS","uS","mS","S "};
u8 F_Unit[4][4]={"Hz","Hz","KC","MC"};

uc8 STATESTR[2][10] = {"!RUN!", "HOLD"};                          // Running state str

uc16 S_Inv[2]       = {(SCRN<<8)+TEXT2, (SCRN<<8)+NOTE1};         // Running state Color

uc8 BATT_STR[5][10] = {"~``'", "~``}", "~`;}", "~;;}", "{;;}"};   // Battery Status Str
uc16 B_COLOR[5]     = {(NOTE1<<8)+SCRN, (SIDE <<8)+SCRN,
                       (TEXT2<<8)+SCRN, (TEXT2<<8)+SCRN,
                       (TEXT2<<8)+SCRN};                          // Battery Status Color

uc8 CH_A_STR[2][10]  = {" HIDE ", "!CH(A)!"};
uc8 CH_B_STR[2][10]  = {" HIDE ", "!CH(B)!"};
uc8 CH_C_STR[2][10]  = {" HIDE ", "!CH(C)!"};
uc8 CH_D_STR[10][10] = {" HIDE ", "!CH(D)!", "!(A+B)!", "!(A-B)!",  
                       "!(C&D)!", "!(C|D)!", "FILE_1",  "FILE_2",
                        "FILE_3",  "FILE_4"};                      // Track source Str
uc8 NO_RANGE[5]      = " -- ";                       
uc8 NO_DEF[5]        = "--";                       

uc8  YCOUPLE[3][10]  = {"DC", "AC", "!-!"};                        // Track Couple Str                    
u8   Vertical[15][10];                                             // Track Range Str
uc8  YPOSISTR[5]    = {"YPOS"};                                   // Track Position Str 
uc16 Y_INV[5]       = {(SCRN<<8)+TR_1, (SCRN<<8)+TR_2,
                       (SCRN<<8)+TR_3, (SCRN<<8)+TR_4,
                       (SCRN<<8)+VERNIE};                          // Track Color 1
uc16 Y_COLOR[5]     = {(TR_1<<8)+SCRN, (TR_2<<8)+SCRN,
                       (TR_3<<8)+SCRN, (TR_4<<8)+SCRN,
                       (VERNIE<<8)+SCRN};                          // Track Color 2

uc8 MODESTR[5][10]  = {"!AUTO!", "!NORM!", "SINGL", "!NONE!",
                       "!SCAN!"};                                 // Sync Mode Str
u8   BaseStr[30][10];                                              // Time Base b Str
uc8  XPOSISTR[5]    = {"XPOS"};
uc16 XCOLOR[2]      = {(SCRN<<8)+X_POSI, (X_POSI<<8)+SCRN};       // Time Base Color

uc8 FO_TYPE[4][10]  = {" SINE ",  "Triang",  " !Saw! ",  "Square"}; // Output Kind Str  "Kd=  %"

uc8 FO_STR[20][10]  = {" 10Hz ",  " 20Hz ",  " 50Hz ",   " 100Hz",
                       "!200Hz!", "!500Hz!", " 1KHz ",   " 2KHz ",
                       " 5KHz ",  "!10KHz!", "!20KHz!",  "!50KHz!",
                       "100KHz",  "200KHz",  "500KHz",   " 1MHz ",
                       " 2MHz ",  " 4MHz ",  " 6MHz ",   " 8MHz "}; // Output Frequency Str

uc16 O_COLOR[2]     = {(SCRN<<8)+TEXT3, (TEXT3<<8)+SCRN};         // Output Frequency Color

uc8  TRIGSTR[8][10] = {"TRIGG", "TRIGG", "TRIGG", "TRIGG"};      // Trigger source Str
                          
uc8  TR_TYPE[8][10] = {":!\\!", ":!^!", "<Vt", ">Vt",            // Trigger Type Str
                       "<TL",   ">TL",  "<TH", ">TH"};
uc8  VT_STR[9]      =  "THRESHOL";                                // Trigg Voltage Str
                          
uc8  VERNIE1[5]     = {"!V1!"};          // V1 Vernie Str
uc8  VERNIE2[5]     = {"!V2!"};          // V2 Vernie Str
uc8  VERNIE3[5]     = {"!T1!"};          // T1 Vernie Str
uc8  VERNIE4[5]     = {"!T2!"};          // T2 Vernie Str
uc16 V_INV[1]       = {(SCRN<<8)+VERNIE};
uc16 V_COLOR[1]     = {(VERNIE<<8)+SCRN};                         // Y Vernie Color
uc16 T_INV[1]       = {(SCRN<<8)+VERNIE};
uc16 T_COLOR[1]        = {(VERNIE<<8)+SCRN};                         // X Vernie Color
uc8  F_FUNC[2][10]  = {"Save File", "Load File"};                 // File Function Str

uc8  F_EXT[7][10]   = {".BMP?", ".DAT?", ".CVS?", " OK! ",
                         " ERR!",".HEX", ".BIN",};                  // File Ext Name Str
uc16 F_INV[1]       = {(SCRN<<8)+TEXT1};                          //  File Color
uc8  DELTA_V[2][10] = {"[V:", "[V:"};
uc8  DELTA_T[4]     = "[T:";
uc8  METER[11][5]   = {"Vbt", "FPS", "Vpp", "Vdc", "RMS", 
                       "Max", "Min", "Frq", "CIR", "DUT"};

u8   NumStr[9], Detail[14];
u8   Current = 0, TypeA = 0, Update = 1;
u8   BL_Str[5]="B.L", Vol_Str[5]="Vol";

menu Title[13][4]=   
{
  //     Item_String,   m_Color,   Limit, Mark, xPos, yPos, Value, Flag 
  {//============================ Title Track1 Group ===========================
    {(u8*)CH_A_STR,(u16*)Y_INV,     2-1, CIRC,   35,  228,     1, UPDAT}, //  Track source
    {(u8*)YCOUPLE, (u16*)Y_COLOR,   2-1, CIRC,   35,  216,     0, UPDAT}, //  Track Couple        
    {(u8*)Vertical,(u16*)Y_COLOR,   9-1,    0,   51,  216,     5, UPDAT}, //  Track Range 
    {(u8*)YPOSISTR,(u16*)Y_INV,     200,  FIX,    0,    0,   150, UPDAT}, //  Adj. Track Position 160
  },
  {//============================ Title Track2 Group ===========================
    {(u8*)CH_B_STR,(u16*)Y_INV+1,   2-1, CIRC,   86,  228,     1, UPDAT}, //  Track source
    {(u8*)YCOUPLE, (u16*)Y_COLOR+1, 2-1, CIRC,   86,  216,     1, UPDAT}, //  Track Couple        
    {(u8*)Vertical,(u16*)Y_COLOR+1, 9-1,    0,  102,  216,     1, UPDAT}, //  Track Range
    {(u8*)YPOSISTR,(u16*)Y_INV+1,   200,  FIX,    0,    0,   100, UPDAT}, //  Adj. Track Position
  },
  {//============================ Title Track3 Group ===========================
    {(u8*)CH_C_STR,(u16*)Y_INV+2,   2-1, CIRC,  137,  228,     1, UPDAT}, //  Track source
    {(u8*)NO_DEF , (u16*)Y_COLOR+2, 1-1, CIRC,  137,  216,     0, UPDAT}, //  Track Couple        
    {(u8*)NO_RANGE,(u16*)Y_COLOR+2, 1-1,    0,  153,  216,     0, UPDAT}, //  Track Range
    {(u8*)YPOSISTR,(u16*)Y_INV+2, 200-1,  FIX,    0,    0,    60, UPDAT}, //  Adj. Track Position
  },
  {//============================ Title Track4 Group ===========================
    {(u8*)CH_D_STR,(u16*)Y_INV+3,  10-1, CIRC,  188,  228,     1, UPDAT}, //  Track source
    {(u8*)NO_DEF , (u16*)Y_COLOR+3, 1-1, CIRC,  188,  216,     0, UPDAT}, //  Track Couple        
    {(u8*)NO_RANGE,(u16*)Y_COLOR+3, 1-1,    0,  204,  216,     0, UPDAT}, //  Track Range
    {(u8*)YPOSISTR,(u16*)Y_INV+3, 200-1,  FIX,    0,    0,    20, UPDAT}, //  Adj. Track Position
  },
  {//================== Running State & Battery Status Group ===================
    {(u8*)STATESTR,(u16*)S_Inv,     2-1,    0,    0,  228,     0, UPDAT}, //  Running state
    {(u8*)BATT_STR,(u16*)B_COLOR,   5-1,    0,    0,  216,     0, UPDAT}, //  Battery status
    {(u8*)BATT_STR,(u16*)B_COLOR,   5-1,  NOT,    0,    0,     0,   HID}, 
    {(u8*)BATT_STR,(u16*)B_COLOR,   5-1,  NOT,    0,    0,     0,   HID},
  },
  {//========================= Title Time Base Group ===========================
    {(u8*)MODESTR, (u16*)XCOLOR,    5-1, CIRC,  239,  228,     0, UPDAT}, //  Sync Mode
    {(u8*)BaseStr, (u16*)XCOLOR+1, 27-1,    0,  239,  216,    17, UPDAT}, //  Time Base Range
    {(u8*)XPOSISTR,(u16*)XCOLOR,   3795,  FIX,  366,    0,     0, UPDAT}, //  Adj. X position
    {(u8*)XPOSISTR,(u16*)XCOLOR,   3795,  NOT,   80,    0,     0, UPDAT}, //  View window rule
  },           
  {//======================= Title Output Signal Group =========================
    {(u8*)FO_TYPE, (u16*)O_COLOR,   4-1, CIRC,  282,  228,     3, UPDAT}, //  Output Wave Kind         
    {(u8*)FO_STR,  (u16*)O_COLOR+1,20-1,    0,  282,  216,    13, UPDAT}, //  Output Frequency         
    {(u8*)NumStr,  (u16*)O_COLOR,   100,  NOT,  306,  228,    50,   HID},        
    {(u8*)NumStr,  (u16*)O_COLOR,     0,  NOT,    0,    0,     0,   HID}, //  Duty value          
  },
  {//=====================;===== Title Trigger Group ====;======================
    {(u8*)TRIGSTR, (u16*)Y_INV,     4-1, CIRC,  333,  228,     1, UPDAT}, //  Trigger source         
    {(u8*)TR_TYPE, (u16*)Y_INV,     8-1, CIRC,  373,  228,     0, UPDAT}, //  Trigger Kine         
    {(u8*)VT_STR,  (u16*)Y_COLOR,   200,  FIX,  333,  216,     0, UPDAT}, //  Adj. Trigger threshold     
    {(u8*)VT_STR,  (u16*)Y_COLOR,     0,  NOT,  357,  216,     0,   HID}, //  Number position     
  },
  {//============================ Title Y Vernie Group =========================
    {(u8*)VERNIE1, (u16*)V_INV,   200-1,  FIX,   35,    0,   180, UPDAT}, //  V1 Vernie         
    {(u8*)VERNIE2, (u16*)V_INV,   200-1,  FIX,   62,    0,    40, UPDAT}, //  V2 Vernie     
    {(u8*)DELTA_V, (u16*)Y_INV,     2-1, CIRC,  314,  197,     0, UPDAT}, //  Measure Track    
    {(u8*)NumStr,  (u16*)Y_COLOR,   240, NUM3,  342,  197,    70, UPDAT}, //  Delta V value    
  },
  {//============================= Title File Group ============================
    {(u8*)F_FUNC,  (u16*)F_INV,     2-1, CIRC,  134,    0,     0,     0}, //  File function    
    {(u8*)NumStr,  (u16*)F_INV,   256-1, NUM3,  206,    0,     0,     1}, //  File number     
    {(u8*)F_EXT,   (u16*)F_INV,     2-1, CIRC,  230,    0,     0,     0}, //  Ext. name     
    {(u8*)F_EXT,   (u16*)F_INV,       0,  NOT,    0,    0,     0,   HID},  
  },
  {//============================ Title X Vernie Group =========================
    {(u8*)VERNIE3, (u16*)T_INV,     300,  FIX,  312,    0,    80, UPDAT}, //  T1 Vernie         
    {(u8*)VERNIE4, (u16*)T_INV,     300,  FIX,  339,    0,   280, UPDAT}, //  T2 Vernie     
    {(u8*)DELTA_T, (u16*)T_INV,       0,  NOT,  314,  182,     0, UPDAT}, //  Delta T Str     
    {(u8*)NumStr,  (u16*)T_COLOR,   300, NUM3,  342,  182,    80, UPDAT}, //  Delta T value    
  },
  {//=========================== Title BackLight Group =========================
    {(u8*)BL_Str,  (u16*)V_INV,     1-1,  FIX,  314,  167,     0, UPDAT}, //  BackLight    
    {(u8*)NumStr,  (u16*)V_COLOR,  10-1, NUM2,  342,  167,     5, UPDAT}, //  Class     
    {(u8*)NumStr,  (u16*)V_INV,       0,  NOT,    0,    0,     0,   HID},     
    {(u8*)NumStr,  (u16*)V_INV,       0,  NOT,    0,    0,     0,   HID},  
  },
  {//============================ Title Volume Group ===========================
    {(u8*)Vol_Str, (u16*)V_INV,     1-1,  FIX,  314,  152,     0, UPDAT}, //  Volume        
    {(u8*)NumStr,  (u16*)V_COLOR,  11-1, NUM2,  342,  152,     5, UPDAT}, //  Class     
    {(u8*)NumStr,  (u16*)V_INV,       0,  NOT,    0,    0,     0,   HID},    
    {(u8*)NumStr,  (u16*)V_INV,       0,  NOT,    0,    0,     0,   HID},    
  },
};

meter Meter[9] =
{ {(u8*)METER,      4,    VBT,     314,    342,   137,  UPDAT}, //  Meter #0
  {(u8*)METER,      4,    FPS,     314,    342,   122,  UPDAT}, //  Meter #1
  {(u8*)METER, TRACK1,    VPP,     314,    342,   107,  UPDAT}, //  Meter #2
  {(u8*)METER, TRACK1,    VDC,     314,    342,    92,  UPDAT}, //  Meter #3
  {(u8*)METER, TRACK1,    RMS,     314,    342,    77,  UPDAT}, //  Meter #4
  {(u8*)METER, TRACK2,    MAX,     314,    342,    62,  UPDAT}, //  Meter #5
  {(u8*)METER, TRACK2,    MIN,     314,    342,    47,  UPDAT}, //  Meter #6
  {(u8*)METER, TRACK2,    VPP,     314,    342,    32,  UPDAT}, //  Meter #7
  {(u8*)METER, TRACK3,    VDC,     314,    342,    17,  UPDAT}, //  Meter #8
};         

void Display_Meter(void)                  // 每次刷新显示一个测量项//Show a measured item for each refreshing
{
  u8  i;
  
  for(i=0; i<9; ++i){        
    if(Meter[i].Flag & UPDAT){            //-----显示需刷新的测量项目名称//-----Name of item measured
      Meter[i].Flag &= (!UPDAT & !BLINK);       // Clr Update & Blink flag
      Print_Str
        (Meter[i].XPOS1, Meter[i].YPOS,        // 需要显示的坐标//Coordinates
         Y_INV[Meter[i].Track],                // 需要显示的颜色(所属通道)// Color represent the chanenl
         PRN,                                  // 需要显示的方式//Show Mode
         Meter[i].Str +(Meter[i].Item * 5));   // 需要显示的项目名称//Item name
    } 
  }
  if((Current >= METER_0)&&(Current <= METER_8)){
    if(Blink){                            //-----显示需闪烁的测量项目名称//-----Name of item measured
      i = Current - METER_0;
      Blink = 0;                               // Clr Blink Ctrl flag 
      Print_Str(
        Meter[i].XPOS1, Meter[i].YPOS,         // 需要闪烁的坐标 //Coordinates
        Y_INV[Meter[i].Track],                 // 需要闪烁的颜色(所属通道)// Color represent the chanenl
        Twink,                                 // 闪烁方式//Show Mode
        Meter[i].Str +(Meter[i].Item *5));     // 需要闪烁的项目名称//Item name
    }
  }
}

void Display_Value(u8 i)
{
  switch (Meter[i].Item){  
  case VBT://--------------- 计算和显示电池电压 ---------------//---------------Vol of battery-------------------------
    Int32String_sign(&Num, __Get(V_BATTERY)* 1000);
    Print_Str
      (Meter[i].XPOS2, Meter[i].YPOS,
      ((TEXT1 << 8) + SCRN), 
      PRN,
      Num.str);                              // 显示测量数值//Show data measured
    Print_Str
      (Meter[i].XPOS2 +40, Meter[i].YPOS,
      ((TEXT1 << 8) + SCRN), 
      PRN,
      V_Unit[Num.decPos]);   /* */               // 显示测量量纲//Show the unit
    break;
  case FPS://--------------- 计算和显示帧计数 ---------------//--------------- Frame per second ---------------
    u8ToDec2(NumStr, Result_FPS & 0xFF);
    Print_Str
      (Meter[i].XPOS2, Meter[i].YPOS,
       Y_COLOR[Meter[i].Track], 
       PRN,
       NumStr);                              // 显示测量数值// Show data measured
    Print_Str
      (Meter[i].XPOS2 +16, Meter[i].YPOS,
       Y_COLOR[Meter[i].Track], 
       PRN,
       "/Sec.");                             // 显示测量量纲//Show the unit
    break;  
  case VPP:
    if(Meter[i].Track == TRACK1)
      Int32String_sign(&Num, A_Vpp * Y_Attr[_A_Range].SCALE);
    if(Meter[i].Track == TRACK2)
      Int32String_sign(&Num, B_Vpp * Y_Attr[_B_Range].SCALE);
    if(Meter[i].Track == TRACK3)
      Int32String_sign(&Num, 0);
    Print_Str
      (Meter[i].XPOS2, Meter[i].YPOS,
      Y_COLOR[Meter[i].Track], 
      PRN,
      Num.str);                              // 显示测量数值// Show data measured
    Print_Str
      (Meter[i].XPOS2 +40, Meter[i].YPOS,
      Y_COLOR[Meter[i].Track], 
      PRN,
      V_Unit[Num.decPos]);                   // 显示测量量纲//Show the unit
    break;
  case VDC:
    if(Meter[i].Track == TRACK1)
      Int32String_sign(&Num, A_Vdc * Y_Attr[_A_Range].SCALE);
    if(Meter[i].Track == TRACK2)
      Int32String_sign(&Num, B_Vdc * Y_Attr[_B_Range].SCALE);
    if(Meter[i].Track == TRACK3)
      Int32String_sign(&Num, 0);
    if(Meter[i].Track == TRACK4)
      Int32String_sign(&Num, 0);
    Print_Str
      (Meter[i].XPOS2, Meter[i].YPOS,
      Y_COLOR[Meter[i].Track], 
      PRN,
      Num.str);                              // 显示测量数值// Show data measured
    Print_Str
      (Meter[i].XPOS2 +40, Meter[i].YPOS,
      Y_COLOR[Meter[i].Track], 
      PRN,
      V_Unit[Num.decPos]);                   // 显示测量量纲//Show the unit
    break;
  case RMS:
    if(Meter[i].Track == TRACK1)
      Int32String_sign(&Num, A_Rms * Y_Attr[_A_Range].SCALE);
    if(Meter[i].Track == TRACK2)
      Int32String_sign(&Num, B_Rms * Y_Attr[_B_Range].SCALE);
    if(Meter[i].Track == TRACK3)
      Int32String_sign(&Num, 0);
    if(Meter[i].Track == TRACK4)
      Int32String_sign(&Num, 0);
    Print_Str
      (Meter[i].XPOS2, Meter[i].YPOS,
      Y_COLOR[Meter[i].Track], 
      PRN,
      Num.str);                              // 显示测量数值// Show data measured
    Print_Str
      (Meter[i].XPOS2 +40, Meter[i].YPOS,
      Y_COLOR[Meter[i].Track], 
      PRN,
      V_Unit[Num.decPos]);                   // 显示测量量纲//Show the unit
    break;
  case MAX:
    if(Meter[i].Track == TRACK1)
      Int32String_sign(&Num, A_Max * Y_Attr[_A_Range].SCALE);
    if(Meter[i].Track == TRACK2)
      Int32String_sign(&Num, B_Max * Y_Attr[_B_Range].SCALE);
    if(Meter[i].Track == TRACK3)
      Int32String_sign(&Num, 0);
    if(Meter[i].Track == TRACK4)
      Int32String_sign(&Num, 0);
    Print_Str
      (Meter[i].XPOS2, Meter[i].YPOS,
      Y_COLOR[Meter[i].Track], 
      PRN,
      Num.str);                              // 显示测量数值// Show data measured
    Print_Str
      (Meter[i].XPOS2 +40, Meter[i].YPOS,
      Y_COLOR[Meter[i].Track], 
      PRN,
      V_Unit[Num.decPos]);                   // 显示测量量纲//Show the unit
    break;
  case MIN:
    if(Meter[i].Track == TRACK1)
      Int32String_sign(&Num, A_Min * Y_Attr[_A_Range].SCALE);
    if(Meter[i].Track == TRACK2)
      Int32String_sign(&Num, B_Min * Y_Attr[_B_Range].SCALE);
    if(Meter[i].Track == TRACK3)
      Int32String_sign(&Num, 0);
    if(Meter[i].Track == TRACK4)
      Int32String_sign(&Num, 0);
    Print_Str
      (Meter[i].XPOS2, Meter[i].YPOS,
      Y_COLOR[Meter[i].Track], 
      PRN,
      Num.str);                              // 显示测量数值// Show data measured
    Print_Str
      (Meter[i].XPOS2 +40, Meter[i].YPOS,
      Y_COLOR[Meter[i].Track], 
      PRN,
      V_Unit[Num.decPos]);                   // 显示测量量纲//Show the unit
    break;
//  case FRQ:
//    break;
//  case CIR:
//    break;
//  case DUT:
//    break;
  }
}

void Display_Title(void)
{
  u8  i, j;
  
  for(i = TRACK1; i <= VOLUME; ++i){
    for(j = 0; j < 4; ++j){
      if(Title[i][j].Flag & UPDAT){   // 需要刷新的Item// If submenu updated
        Title[i][j].Flag &= !UPDAT;   // Clr Update flag 
        if((i == BATTERY)||(i == TRIGG)){
          if(Title[i][j].MARK & FIX){                  // ---- Under fix mode
            Print_Str( 
              Title[i][j].XPOS, Title[i][j].YPOS,
              Title[i][j].Color[Title[i][0].Value],    // Color variable 
              PRN, 
              Title[i][j].Str                          // String fixed
            );                    
          } else if(!(Title[i][j].MARK & NOT)){        // ---- Under other mode
            Print_Str(
              Title[i][j].XPOS, Title[i][j].YPOS,
              Title[i][j].Color[Title[i][0].Value],    // Color variable 
              PRN, 
              Title[i][j].Str +(Title[i][j].Value * 10)// String variable
            ); 
          }
        } else {
          if(Title[i][j].MARK & FIX){                  // ---- Under fix mode
            Print_Str(
              Title[i][j].XPOS, Title[i][j].YPOS,
              Title[i][j].Color[0],                    // Color fixed 
              PRN, 
              Title[i][j].Str                          // String fixed
             );
          } else if(Title[i][j].MARK & NUM3){          // ---- Under NUM3 mode
            if(i == V_VERNIE){
              Int32String_sign(&Num,(_V1_Vernie - _V2_Vernie)* _Meas_V_Scale);
              Print_Str(
                Title[i][j].XPOS, Title[i][j].YPOS,
                Title[i][j].Color[_Meas_V_Track],      // Color fixed  
                PRN, 
                Num.str                                // String for numerical
              );
              Print_Str(
                Title[i][j].XPOS + 40, Title[i][j].YPOS,
                Title[i][j].Color[_Meas_V_Track],      // Color fixed  
                PRN, 
                V_Unit[Num.decPos]                     // String variable
              );
            }
            if(i == T_VERNIE){
              Int32String_sign(&Num,(_T2_Vernie - _T1_Vernie)* _T_Scale);
              Print_Str(
                Title[i][j].XPOS, Title[i][j].YPOS,
                Title[i][j].Color[0],                  // Color fixed  
                PRN, 
                Num.str                                // String for numerical
              );
              Print_Str(
                Title[i][j].XPOS + 40, Title[i][j].YPOS,
                Title[i][j].Color[0],                  // Color fixed  
                PRN, 
                T_Unit[Num.decPos]                     // String variable
              );
            }
            if(i == FILE){
              u8ToDec3(Title[i][1].Str, Title[i][1].Value);
              Print_Str(
                Title[i][1].XPOS, Title[i][1].YPOS,
                Title[i][1].Color[0],                  // Color fixed  
                PRN, 
                Title[i][1].Str                        // String for numerical
              );
            }
          } else if(Title[i][j].MARK == NUM2){ 
                NumStr[0]=' ';
            if(i == BK_LIGHT){                        // 背光百分比显示处理//Show the percentage of backlight
              if(Title[i][j].Value == 9){
                NumStr[0]='1';
                NumStr[1]='0';
                NumStr[2]='0';
              } else  
                u8ToDec2(NumStr+1, 10*(Title[i][j].Value+1)); 
            } else {                                  // 音量百分比显示处理//Show the percentage of volume
              if(Title[i][j].Value == 10){
                NumStr[0]='1';
                NumStr[1]='0';
                NumStr[2]='0';
              } else  u8ToDec2(NumStr+1, 10*Title[i][j].Value); 
            }
            Print_Str(
              Title[i][j].XPOS, Title[i][j].YPOS,
              Title[i][j].Color[0],                  // Color fixed  
              PRN, 
              NumStr                        // String for numerical
            );
            Print_Str(
              Title[i][j].XPOS+24, Title[i][j].YPOS,
              Title[i][j].Color[0],                  // Color fixed  
              PRN, 
              "%"                        
            );
          } else if(Title[i][j].MARK != NOT){
          
            if(i == V_VERNIE){
              Print_Str(
                Title[i][j].XPOS, Title[i][j].YPOS,
                Title[i][j].Color[_Meas_V_Track],         // Color variable 
                PRN, 
                Title[i][j].Str +(Title[i][j].Value * 10)// String variable
              ); 
            } else {
              Print_Str(
                Title[i][j].XPOS, Title[i][j].YPOS,
                Title[i][j].Color[0],                    // Color fixed 
                PRN, 
                Title[i][j].Str +(Title[i][j].Value * 10)// String variable
              ); 
            }
          } else if(i == T_VERNIE){
            Print_Str(
              Title[i][j].XPOS, Title[i][j].YPOS,
              Title[i][j].Color[0],                    // Color fixed 
              PRN, 
              Title[i][j].Str                          // String variable
            ); 
          }
        }
      } else if((Current == i)&&(Detail[i] == j)&&(Blink)){ // 当前光标位置的Item//Current blink item
        Blink = 0;
        if((i == BATTERY)||(i == TRIGG)){
          if((Title[i][j].MARK & FIX)){      // ---- Under fix mode
            Print_Str( 
              Title[i][j].XPOS, Title[i][j].YPOS,
              Title[i][j].Color[Title[i][0].Value],    // Color variable 
              Twink, 
              Title[i][j].Str                          // String fixed
            );                    
          } else {                                // ---- Under other mode
            Print_Str(
              Title[i][j].XPOS, Title[i][j].YPOS,
              Title[i][j].Color[Title[i][0].Value],    // Color variable 
              Twink, 
              Title[i][j].Str +(Title[i][j].Value * 10)// String variable
            ); 
          }
        } else {
          if(Title[i][j].MARK & FIX){             // ---- Under fix mode
            Print_Str(
              Title[i][j].XPOS, Title[i][j].YPOS,
              Title[i][j].Color[0],                    // Color fixed 
              Twink, 
              Title[i][j].Str                          // String fixed
            );
          } else {
            if(i == V_VERNIE){
              Print_Str(
                Title[i][j].XPOS, Title[i][j].YPOS,
                Title[i][j].Color[_Meas_V_Track],        // Color variable=
                Twink, 
                Title[i][j].Str +(Title[i][j].Value * 10)// String variable
              ); 
            } else {
              Print_Str(
                Title[i][j].XPOS, Title[i][j].YPOS,
                Title[i][j].Color[0],                    // Color fixed 
                Twink, 
                Title[i][j].Str +(Title[i][j].Value * 10)// String variable
              ); 
            }
            if((i == FILE)&&(Title[i][j].MARK & NUM3)){
              u8ToDec3(Title[i][1].Str, Title[i][1].Value);
              Print_Str(
                Title[i][1].XPOS, Title[i][1].YPOS,
                Title[i][1].Color[0],                  // Color fixed  
                Twink, 
                Title[i][1].Str                        // String for numerical
              );
            }
          }
        }
      }
    }
  }
}
/*******************************************************************************
 Load_Attr:  加载硬件属性
              Load the attribution of hardware.
*******************************************************************************/
void Load_Attr(void)
{
  u16 i;
  
  for(i=0; i<G_Attr[0].Yp_Max+1; ++i) 
    strcpy(&Vertical[i][0], Y_Attr[i].STR);
  Title[TRACK1][RANGE].Limit = G_Attr[0].Yp_Max;
  Title[TRACK2][RANGE].Limit = G_Attr[0].Yp_Max;
  Title[TRACK3][RANGE].Limit = 0;
  Title[TRACK4][RANGE].Limit = 0;
  
  for(i=0; i<G_Attr[0].Xp_Max+1; ++i) 
    strcpy(&BaseStr[i][0], X_Attr[i].STR);
  Title[T_BASE][BASE].Limit = G_Attr[0].Xp_Max;
  
}
/*******************************************************************************
 Update_Battery:  刷新电池电量指示
                  Refresh display of battry 
*******************************************************************************/
void Update_Battery(void)
{
  u16 Vb, Level;
  
  Vb = __Get(V_BATTERY);
  Level =0;
  if(Vb > 3000 ) Level +=1;
  if(Vb > 3500 ) Level +=1;
  if(Vb > 3900 ) Level +=1;
  if(Vb > 4100 ) Level +=1;
  Print_Str(
    Title[4][1].XPOS, Title[4][1].YPOS,
    Title[4][1].Color[Level], 
    PRN,
    (Title[4][1].Str + Level*10) 
  );    
}
/******************************** END OF FILE *********************************/
