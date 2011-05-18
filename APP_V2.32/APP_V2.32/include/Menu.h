/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : Menu.h  
 Version   : DS203_APP Ver 2.3x                                  Author : bure
*******************************************************************************/
#ifndef __MENU_H
#define __MENU_H

#include "stm32f10x_lib.h"

//----------- Detail菜单中常量MARK的定义 -----------
//-----------Definition of MARK in Detail-----------
#define NUM2    0x01   // 在指定位置显示2位的Value数值//Show a 2_bits value in a specified address 
#define NUM3    0x02   // 在指定位置显示浮点3位的Value数值//Show a 3_bits float value in a specified address
#define CIRC    0x10   // 该Detail项的Value值在调节到头时循环//Value of this detail loop when reach limit
#define FIX     0x20   // 该Detail项的Value值改变时对应的标识字符串不变//String for the detail do not change when its value changes
#define NOT     0x80   // 在选择时跳过该Detail项//Jump over this detail
//#define NONE    0x00   // 其他 // Others

//----------- Detail菜单中变量Flag的定义 -----------
//------------Definition of Flag in Detail-------------
#define HID     0x04   // 不显示该Detail项//Do not show this detail
#define UPDAT   0x02   // 该Detail项显示刷新//Update this detail
#define BLINK   0x01   // 该Detail项显示闪烁//Blink this detail

#define BATTERY    4


//=============== MENU 主菜单项编号定义 ===============
//================Definition of the manu==================
#define TRACK1     0
#define TRACK2     1
#define TRACK3     2
#define TRACK4     3
#define RUNNING    4
#define T_BASE     5
#define OUTPUT     6
#define TRIGG      7
#define V_VERNIE   8
#define FILE       9
#define T_VERNIE   10
#define BK_LIGHT   11
#define VOLUME     12

//------------- TRACKn 子菜单项编号定义 --------------
//-------------Definition of submenu for TRACKn------------
#define SOURCE     0
#define COUPLE     1
#define RANGE      2
#define POSI       3

//............ TRACKn 中 SOURCE 项编号定义 ...........
//.............Definition of SOURCE for TRACKn..........
#define HIDE       0
/**/
#define CH_A       1
#define CH_B       1
#define CH_C       1
#define CH_D       1
#define A_add_B    2
#define A_sub_B    3
#define C_and_D    4
#define C_or_D     5
#define FILE1      6
#define FILE2      7
#define FILE3      8
#define FILE4      9

//------------- RUNNING 子菜单项编号定义 -------------
//--------------Definition of submenu for RUNNING-------
#define STATE      0
#define STATUS     1

//.............. STATE 子菜单项编号定义 ..............
//...............Definition of submenu for STATE.......
#define RUN        0
#define HOLD       1

//-------------- T_BASE 子菜单项编号定义 -------------
//---------------Definition of submenu for T_BASE--------
#define MODE       0
#define BASE       1
#define XPOSI      2
#define VIEW       3

//............. T_BASE 中 MODE 项编号定义 ............
//..............Definition of MODE for T_BASE..........
#define AUTO       0
#define NORM       1
#define SIGN       2
#define NONE       3
#define SCAN       4

//-------------- OUTPUT 子菜单项编号定义 -------------
//---------------Definition of submenu for output------
#define KIND       0
#define FRQN       1
//#define CLASS      1

//--------------- TRIGG 子菜单项编号定义 -------------
//---------------Definition of submenu for TRIGG-------
#define SOURCE     0
#define TR_KIND    1
#define THRESHOLD  2

//------------- T_VERNIE 子菜单项编号定义 ------------
//-------------Definition of submenu for T_VERNIE-------
#define T1         0
#define T2         1

//------------- V_VERNIE 子菜单项编号定义 ------------
//------------Definition of submenu for V_VERNIE---------
#define V1         0
#define V2         1

//--------------- FILE 子菜单项编号定义 --------------
//------------Definition of submenu for FILE---------
#define SAVE       0
#define LOAD       1
#define BMP        0
#define DAT        1

//--------- BK_LIGHT & VOLUME子菜单项编号定义 --------
//---------Definition of submenu for BK_LIGHT & VOLUME------
#define CLASS      1

//============== METER 主菜单项编号定义 ==============
//==============Definition of METER==============
#define METER_0    13
#define METER_1    14
#define METER_2    15
#define METER_3    16
#define METER_4    17
#define METER_5    18
#define METER_6    19
#define METER_7    20
#define METER_8    21

//------------- METER 中 Item 项编号定义 -------------
//--------------Definition of Item for METER----------
#define VBT        0
#define FPS        1
#define VPP        2
#define VDC        3
#define RMS        4
#define MAX        5
#define MIN        6
//#define FRQ        7
//#define CIR        8 
//#define DUT        9

//#define _Item           Title[Item]
#define _Meas_V_Track   (Title[V_VERNIE][2].Value)  
#define _Meas_V_Range   (Title[_Meas_V_Track][RANGE].Value)     
#define _Meas_V_Scale   (Y_Attr[_Meas_V_Range].SCALE)
#define _V1_Vernie      (Title[V_VERNIE][0].Value)
#define _V2_Vernie      (Title[V_VERNIE][1].Value)
#define _D_V_Source     Title[V_VERNIE][2]
#define _Delta_V        Title[V_VERNIE][3]
#define _T1_Vernie      (Title[T_VERNIE][0].Value)
#define _T2_Vernie      (Title[T_VERNIE][1].Value)
#define _Delta_T        Title[T_VERNIE][3]
#define _T_Range        (Title[T_BASE][1].Value)
#define _T_Scale        (X_Attr[_T_Range].SCALE)

typedef struct 
{
  u8   *Str;
  u8   Track;
  u8   Item;
  uc16 XPOS1;
  uc16 XPOS2;
  uc8  YPOS;
  u8   Flag;       // HID=0x04, UPD=0x02, BLINK=0x01, 
} meter; 

typedef struct 
{
  u8   *Str;
  u16  *Color;
  s16  Limit;      // Max Value 
  uc8  MARK;       // NUM=0x04, FIX=0x02, CIR=0x01,
  uc16 XPOS;
  uc8  YPOS;
  s16  Value;
  u8   Flag;       // HID=0x04, UPD=0x02, BLINK=0x01, 
} menu; 

extern menu Title[13][4];
extern meter Meter[9];
extern u8 Current, TypeA, Update;//Type, Blink, 
extern u8 Detail[14], NumStr[9];
extern u16 Result_FPS;


void Display_Value(u8 i);
void Display_Title(void);
void Display_Meter(void);
void Load_Attr(void);
void Update_Battery(void);

#endif

/********************************* END OF FILE ********************************/
