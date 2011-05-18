/******************** (C) COPYRIGHT 2009 e-Design Co.,Ltd. *********************
 File Name : Draw.c       
 Version   : DS203_APP Ver 2.3x                                  Author : bure
*******************************************************************************/
#include "Process.h"
#include "Draw.h"
#include "Menu.h"
#include "BIOS.h"

uc16 RULE_BASE [8] ={0x020,0x040,0x080,0x040,0x020,0x010,0x008,0x010};

uc8  Mark_TAB_1[7] ={0x00,0x00,0x42,0xFE,0x02,0x00,0x00};      // Mark 1
uc8  Mark_TAB_2[7] ={0x00,0x46,0x8A,0x92,0x92,0x62,0x00};      // Mark 2
uc8  Mark_TAB_3[7] ={0x00,0x44,0x82,0x92,0x92,0x6C,0x00};      // Mark 3
uc8  Mark_TAB_4[7] ={0x00,0x18,0x28,0x4A,0xFE,0x0A,0x00};      // Mark 4
uc8  Mark_TAB_T[7] ={0x00,0x40,0x40,0x7E,0x40,0x40,0x00};      // Mark T

uc8  Mark_TAB[5][7] ={{0x00,0x00,0x42,0xFE,0x02,0x00,0x00},    // Mark 1
                      {0x00,0x46,0x8A,0x92,0x92,0x62,0x00},    // Mark 2
                      {0x00,0x44,0x82,0x92,0x92,0x6C,0x00},    // Mark 3
                      {0x00,0x18,0x28,0x4A,0xFE,0x0A,0x00},    // Mark 4
                      {0x00,0x40,0x40,0x7E,0x40,0x40,0x00}};   // Mark T

uc16 CLK_TAB[44] =
  {0x000,0x000,0x000,0x000,0x070,0x3FF,0x070,0x000,0x000,0x000,0x000,
   0x000,0x002,0x004,0x008,0x070,0x070,0x070,0x080,0x100,0x200,0x000,
   0x020,0x020,0x020,0x020,0x070,0x070,0x070,0x020,0x020,0x020,0x020,
   0x000,0x200,0x100,0x080,0x070,0x070,0x070,0x008,0x004,0x002,0x000};

uc16 Char_TAB_8x11[744] = {
  0x000,0x000,0x000,0x780,0x040,0x020,0x020,0x020, // " 
  0x020,0x020,0x040,0x780,0x000,0x000,0x000,0x000, // # 
  0x000,0x000,0x000,0x00F,0x010,0x020,0x020,0x020, // $ 
  0x30C,0x18C,0x0C0,0x060,0x030,0x318,0x30C,0x000, // % 
  0x000,0x180,0x260,0x21C,0x26A,0x284,0x140,0x000, // & 
  0x202,0x202,0x202,0x202,0x202,0x202,0x3FE,0x000, // ' 
  0x000,0x000,0x0F8,0x1FC,0x306,0x202,0x000,0x000, // (
  0x000,0x000,0x202,0x306,0x1FC,0x0F8,0x000,0x000, // )
  0x000,0x18C,0x0D8,0x070,0x070,0x0D8,0x18C,0x000, // *  
  0x000,0x020,0x020,0x0F8,0x0F8,0x020,0x020,0x000, // + 
  0x020,0x020,0x010,0x00F,0x000,0x000,0x000,0x000, // , 
  0x000,0x020,0x020,0x020,0x020,0x020,0x020,0x000, // -
  0x000,0x000,0x300,0x300,0x000,0x000,0x000,0x000, // .
  0x180,0x0C0,0x060,0x030,0x018,0x00C,0x006,0x000, // / 
  0x1FC,0x3FE,0x242,0x222,0x212,0x3FE,0x1FC,0x000, // 0
  0x000,0x208,0x20C,0x3FE,0x3FE,0x200,0x200,0x000, // 1
  0x304,0x386,0x2C2,0x262,0x232,0x31E,0x30C,0x000, // 2
  0x104,0x306,0x222,0x222,0x222,0x3FE,0x1DC,0x000, // 3
  0x060,0x070,0x058,0x24C,0x3FE,0x3FE,0x240,0x000, // 4
  0x11E,0x21E,0x212,0x212,0x212,0x3F2,0x1E2,0x000, // 5
  0x1F8,0x3FC,0x226,0x222,0x222,0x3E0,0x1C0,0x000, // 6
  0x006,0x006,0x3C2,0x3E2,0x032,0x01E,0x00E,0x000, // 7
  0x1DC,0x3FE,0x222,0x222,0x222,0x3FE,0x1DC,0x000, // 8
  0x01C,0x23E,0x222,0x222,0x322,0x1FE,0x0FC,0x000, // 9
  0x000,0x000,0x000,0x198,0x198,0x000,0x000,0x000, // : 
  0x2FA,0x2FA,0x2FA,0x2FA,0x2FA,0x2FA,0x2FA,0x2FA, // ; 
  0x000,0x020,0x070,0x0D8,0x18C,0x306,0x202,0x000, // <
  0x090,0x090,0x090,0x090,0x090,0x090,0x000,0x000, // =  
  0x000,0x202,0x306,0x18C,0x0D8,0x070,0x020,0x000, // >
  0x018,0x01C,0x004,0x344,0x364,0x03C,0x018,0x000, // ? 
  0x1F8,0x104,0x272,0x272,0x2F2,0x284,0x078,0x000, // @ 
  0x3F0,0x3F8,0x04C,0x046,0x04C,0x3F8,0x3F0,0x000, // A
  0x202,0x3FE,0x3FE,0x222,0x222,0x3FE,0x1DC,0x000, // B
  0x0F8,0x1FC,0x306,0x202,0x202,0x306,0x18C,0x000, // C
  0x202,0x3FE,0x3FE,0x202,0x306,0x1FC,0x0F8,0x000, // D
  0x202,0x3FE,0x3FE,0x222,0x272,0x306,0x38E,0x000, // E
  0x202,0x3FE,0x3FE,0x222,0x072,0x006,0x00E,0x000, // F
  0x0F8,0x1FC,0x306,0x222,0x222,0x1E6,0x3EC,0x000, // G
  0x3FE,0x3FE,0x020,0x020,0x020,0x3FE,0x3FE,0x000, // H
  0x000,0x000,0x202,0x3FE,0x3FE,0x202,0x000,0x000, // I
  0x1C0,0x3C0,0x200,0x202,0x3FE,0x1FE,0x002,0x000, // J
  0x202,0x3FE,0x3FE,0x030,0x0F8,0x3CE,0x306,0x000, // K
  0x202,0x3FE,0x3FE,0x202,0x200,0x200,0x300,0x000, // L
  0x3FE,0x3FE,0x01C,0x038,0x01C,0x3FE,0x3FE,0x000, // M
  0x3FE,0x3FE,0x01C,0x038,0x070,0x3FE,0x3FE,0x000, // N
  0x0F8,0x1FC,0x306,0x202,0x306,0x1FC,0x0F8,0x000, // O
  0x202,0x3FE,0x3FE,0x222,0x022,0x03E,0x01C,0x000, // P
  0x1FC,0x3FE,0x202,0x282,0x302,0x3FE,0x1FC,0x000, // Q
  0x202,0x3FE,0x3FE,0x022,0x062,0x3FE,0x39C,0x000, // R
  0x10C,0x31E,0x232,0x222,0x262,0x3CE,0x18C,0x000, // S
  0x000,0x00E,0x206,0x3FE,0x3FE,0x206,0x00E,0x000, // T
  0x1FE,0x3FE,0x200,0x200,0x200,0x3FE,0x1FE,0x000, // U
  0x07E,0x0FE,0x180,0x300,0x180,0x0FE,0x07E,0x000, // V
  0x0FE,0x3FE,0x380,0x1E0,0x380,0x3FE,0x0FE,0x000, // W
  0x306,0x3DE,0x0F8,0x020,0x0F8,0x3DE,0x306,0x000, // X
  0x000,0x01E,0x23E,0x3E0,0x3E0,0x23E,0x01E,0x000, // Y
  0x38E,0x3C6,0x262,0x232,0x31E,0x38E,0x000,0x000, // Z
  0x200,0x300,0x2C0,0x220,0x218,0x204,0x3FE,0x000, // [     
  0x000,0x022,0x042,0x1FE,0x3FE,0x240,0x220,0x000, // \ 
  0x020,0x010,0x008,0x006,0x008,0x010,0x020,0x020, // ]   
  0x000,0x220,0x210,0x3FC,0x3FE,0x012,0x022,0x000, // ^  
  0x000,0x200,0x200,0x200,0x200,0x200,0x200,0x000, // _  
  0x202,0x202,0x202,0x202,0x202,0x202,0x202,0x202, // ` 
  0x1C0,0x3E8,0x228,0x228,0x1F8,0x3F0,0x200,0x000, // a         
  0x202,0x3FE,0x1FE,0x220,0x220,0x3E0,0x1C0,0x000, // b 
  0x1E0,0x3F0,0x210,0x210,0x210,0x330,0x120,0x000, // c 
  0x000,0x1C0,0x3E0,0x220,0x222,0x3FE,0x3FE,0x000, // d 
  0x1E0,0x3F0,0x250,0x250,0x250,0x370,0x160,0x000, // e 
  0x000,0x220,0x3FC,0x3FE,0x222,0x002,0x004,0x000, // f
  0x130,0x378,0x248,0x248,0x3F8,0x1F8,0x000,0x000, // g
  0x202,0x3FE,0x3FE,0x020,0x010,0x3F0,0x3E0,0x000, // h
  0x000,0x000,0x200,0x3F6,0x3F6,0x200,0x000,0x000, // i 
  0x000,0x100,0x300,0x210,0x3F6,0x1F6,0x000,0x000, // j
  0x202,0x3FE,0x3FE,0x062,0x0F0,0x398,0x308,0x000, // k
  0x000,0x000,0x202,0x3FE,0x3FE,0x200,0x000,0x000, // l
  0x3F8,0x3F8,0x018,0x3F0,0x018,0x3F8,0x3F0,0x000, // m 
  0x008,0x3F8,0x3F0,0x008,0x008,0x3F8,0x3F0,0x000, // n 
  0x000,0x1F0,0x3F8,0x208,0x208,0x3F8,0x1F0,0x000, // o
  0x208,0x3F8,0x3F0,0x248,0x048,0x078,0x030,0x000, // p 
  0x030,0x078,0x048,0x248,0x3F8,0x3F8,0x200,0x000, // q
  0x208,0x3F8,0x3F0,0x218,0x008,0x018,0x030,0x000, // r 
  0x000,0x110,0x338,0x268,0x248,0x3D8,0x190,0x000, // s 
  0x010,0x010,0x1F8,0x3FC,0x210,0x310,0x100,0x000, // t
  0x1F8,0x3F8,0x200,0x200,0x1F8,0x3F8,0x200,0x000, // u 
  0x000,0x0F8,0x1F8,0x300,0x300,0x1F8,0x0F8,0x000, // v
  0x0F8,0x3F8,0x300,0x180,0x300,0x3F8,0x0F8,0x000, // w
  0x208,0x318,0x1B0,0x0E0,0x1B0,0x318,0x208,0x000, // x
  0x038,0x278,0x240,0x240,0x240,0x1F8,0x0F8,0x000, // y
  0x318,0x388,0x2C8,0x268,0x238,0x318,0x000,0x000, // z 
  0x0F8,0x088,0x38E,0x022,0x2FA,0x2FA,0x2FA,0x2FA, // { 
  0x000,0x000,0x000,0x3FE,0x3FE,0x000,0x000,0x000, // | 
  0x2FA,0x2FA,0x2FA,0x2FA,0x2FA,0x202,0x3FE,0x000, // } 
  0x0F8,0x088,0x38E,0x202,0x202,0x202,0x202,0x202};// ~ 

uc8  Ref_Wave [300] =   //样本波形描述//Data of wave for instance
{100,116,130,144,157,167,175,181,185,185,184,179,173,164,153,141,128,114,100, 86,
  73, 60, 49, 40, 33, 27, 24, 24, 25, 29, 35, 43, 52, 63, 75, 87,100,112,124,135,
 145,153,160,164,167,167,166,163,157,150,142,133,122,111,100, 89, 79, 70, 61, 54,
  48, 44, 42, 42, 43, 46, 50, 57, 64, 72, 81, 90,100,109,118,126,133,139,144,147,
 149,149,148,146,142,137,130,124,116,108,100, 93, 85, 79, 73, 68, 64, 61, 60, 60,
  61, 63, 66, 70, 75, 81, 87, 93,100,106,112,117,122,125,128,130,131,131,131,129,
 126,123,119,115,110,105,100, 96, 91, 88, 84, 81, 79, 78, 77, 78, 78, 80, 82, 84, 
  87, 90, 93, 97,100,103,106,108,110,112,113,114,114,113,113,112,110,109,107,105,
 104,102,100,99, 97, 96, 96, 95, 95, 95, 95, 96, 96, 97, 97, 98, 99, 99, 100,100,
 100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,
 100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,
 100,100,100,100,100,115,129,141,151,160,165,169,170,169,167,162,156,148,139,130,
 120,110,100, 91, 82, 75, 68, 63, 59, 57, 56, 56, 58, 61, 64, 69, 75, 81, 87, 94,
 100,106,112,117,121,125,127,129,130,130,128,127,124,121,117,113,109,104,100, 96, 
  92, 88, 85, 83, 81, 80, 79, 79, 80, 81, 83, 85, 88, 91, 94, 97,100,103,106,108,};

uc16  Row_Base0[201] =     //空白列基础数据//Data of blank row
{BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 20~30
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 70~80
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 20~30
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 70~80
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
 BLACK };
   
uc16  Row_Base1[201] =     //仅含垂直边线的列基础数据//Data of row with vertical border line only 
{GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 00~10
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 10~20
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 20~30
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 30~40
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 40~50
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 50~60
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 60~70
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 70~80
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 80~90
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 90~00
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 00~10
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 10~20
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 20~30
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 30~40
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 40~50
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 50~60
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 60~70
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 70~80
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 80~90
 GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY ,GRAY , // 90~00
 GRAY };
   
uc16  Row_Base2[201] =     //仅含水平边线的列基础数据//Data of row with horizontal border line only
{GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 20~30
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 70~80
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 20~30
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 70~80
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
 GRAY };
   
uc16  Row_Base3[201] =     //含水平格线和水平边线的列基础数据//Data of row with horizontal border and horizontal partition line
{GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
 BLACK,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 20~30
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
 GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
 BLACK,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 70~80
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
 GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 00~10
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 10~20
 BLACK,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 20~30
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 30~40
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 40~50
 GRAY ,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 50~60
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 60~70
 BLACK,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 70~80
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 80~90
 BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK, // 90~00
 GRAY };
   
uc16  Row_Base4[201] =     //含垂直格线和水平边线的列基础数据//data of row with horizontal border and vertical partition line
{GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 00~10
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 10~20
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 20~30
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 30~40
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 40~50
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 50~60
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 60~70
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 70~80
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 80~90
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 90~00
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 00~10
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 10~20
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 20~30
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 30~40
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 40~50
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 50~60
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 60~70
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 70~80
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 80~90
 GRAY ,BLACK,BLACK,BLACK,BLACK,GRAY ,BLACK,BLACK,BLACK,BLACK, // 90~00
 GRAY };
   
u16 Color[16] = { CYAN,   // #0  TRACK1 
                  YEL,    // #1  TRACK2
                  PURPL,  // #2  TRACK3 
                  GRN,    // #3  TRACK4 
                  WHT,    // #4  VERNIE   
                  BLACK,  // #5  SCRN
                  ORANGE, // #6  X_POSI 
                  BLUE,   // #7  TRIGG 
                  CYAN,   // #8  VERNIE  
                  GRAY,   // #9  GRID 
                  WHT,    // #10 TEXT 
                  GRN,    // #11 TEXT2
                  BLUE,   // #12 TEXT3
                  GRAY,   // #13 BLOCK
                  YEL,    // #14 SIDE
                  RED };  // #15 NOTE 

trigg V_Trigg[4] = {// Value,  Flag:( HID=0x04, UPDAT=0x02 )
                     {   175,  UPDAT + HID },
                     {   116,  UPDAT       },
                     {    75,  UPDAT + HID },
                     {    35,  UPDAT + HID },
                   };
u16 LCD_Buffer1[240], LCD_Buffer2[240];
u8  Vt1=180, Vt2=128, Vt3=70, Vt4=30;

/*******************************************************************************
 Get_TAB_8x11
*******************************************************************************/
u16 Get_TAB_8x11(u8 Code, u8 Row)
{
  return Char_TAB_8x11[((Code-0x22)*8)+Row];
}
/*******************************************************************************
 Get_Ref_Wave: 
*******************************************************************************/
u8 Get_Ref_Wave(u16 i)
{
  return Ref_Wave[i];
}
/*******************************************************************************
 Print_Clk: 进度指示//show the process
*******************************************************************************/
void Print_Clk(u16 x0, u16 y0, u16 Type, u8 Phase)
{
  u16 i, j, b;
  
  __LCD_Set_Block(x0, x0+10, y0, y0+10);
  for(i=0; i<11; ++i){
    b = CLK_TAB[Phase *11 + i];
    for(j=0; j<11; ++j){
      if((b >> j)& 0x001) __LCD_SetPixl(Color[Type >> 0x8]);
      else                __LCD_SetPixl(Color[Type & 0x0F]);
    }
  }
  __LCD_Set_Block(LCD_X1,LCD_X2,LCD_Y1,LCD_Y2);  //恢复全尺寸窗口//Renew the full window
}
/*******************************************************************************
 Print_Str: 
*******************************************************************************/
void Print_Str(u16 x0, u16 y0, u16 Type, u8 Mode, u8 *s)
{ 
  signed short i, j, b; 
  __LCD_Set_Block(x0, LCD_X2, y0, y0+10);
  for (j=0; j<11;++j){ 
    if(Mode == 0) __LCD_SetPixl(Color[Type & 0x0F]);   //Normal replace Display
    else          __LCD_SetPixl(Color[Type >> 0x8]);   //Inverse replace Display
  }
  x0++;                            // 每一个字符串前增加一空白列 //add a blank space for each string
  while (*s!=0) {
    for(i=0;i<8;++i){
      if((*s==0x20)||(*s==0x21)) b = 0x0000;
      else                       b = Get_TAB_8x11(*s, i);
      if((*s==0x21)&&(i==4)) break;
      for(j=0;j<11;++j){
        if((b << j)& 0x400) {
          if(Mode == 0) __LCD_SetPixl(Color[Type >> 0x8]);
          else          __LCD_SetPixl(Color[Type & 0x0F]);
        } else {
          if(Mode == 0) __LCD_SetPixl(Color[Type & 0x0F]);
          else          __LCD_SetPixl(Color[Type >> 0x8]);
        }
      }
    }
    if(*s==0x21) x0 +=4;           //显示位置水平方向+4//+4 in horizontal if ASC is 0x21
    else  x0 += 8;                 //显示位置水平方向+8//+8 in horizontal 
    ++s;                           //字符串指针+1 //Increase the pointer by 1
  }
  __LCD_Set_Block(LCD_X1,LCD_X2,LCD_Y1,LCD_Y2);  //恢复全尺寸窗口//Renew the full window
}
/*******************************************************************************
 Draw_Row : 为缓解DMA冲突，分两个缓冲区交替工作
            Two buffer works alterlativly to ease the DMA confusion
*******************************************************************************/
void Draw_Row(u16 Row)
{ 
  u8  i, y[8], Dot_Hide[8]; 
  s16 Tmp, m, n ;
  if((Row > MIN_X)&&(Row <= MAX_X)){               // 波形显示区数据预处理//Pre-handle the data  
    m = (Row - MIN_X-1)* 4;
    n = (Row - MIN_X)  * 4;
    for(i = 0; i < 8; i += 2) {
      Dot_Hide[i] = 0;
      y[i]   = TrackBuff[m + i/2];                  // 端点提取// extract the endpoint
      y[i+1] = TrackBuff[n + i/2];
      
      if(y[i]   >= Y_BASE+Y_SIZE)  y[i]   = Y_BASE+Y_SIZE-1;      // 超界处理// handle the point exceed range
      else if(y[i]   <= Y_BASE+1)  y[i]   = Y_BASE+1;   
      if(y[i+1] >= Y_BASE+Y_SIZE)  y[i+1] = Y_BASE+Y_SIZE-1;
      else if(y[i+1] <= Y_BASE+1)  y[i+1] = Y_BASE+1;
      
      if(y[i] == y[i+1]){
        if((y[i] == Y_BASE+1)||(y[i] == Y_SIZE-1)) Dot_Hide[i] = 1;  // 超界消隐//Clean the point exceed range
        else {
          if(y[i] >= Y_BASE+2)           y[i]   -= 1;              // 水平线加粗// Thicken the horizontal line
          if(y[i+1] <= Y_BASE+Y_SIZE-2)  y[i+1] += 1;
        }
      }
      if(y[i] > y[i+1]){                                             // 大小排序//Sortting
        Tmp = y[i+1]; y[i+1]= y[i]; y[i]= Tmp; 
      }
    }
  } 
  __Row_DMA_Ready();
  __Point_SCR(Row, MIN_Y);
  
  if(Row & 1){                                       // Odd row process
//----------------------- Fill the row base data -------------------------------
    __Row_Copy(Row_Base2, LCD_Buffer1);
//------------------------- Draw the Curve data --------------------------------
    if((Row > MIN_X)&&(Row < MAX_X)){             
      if((Dot_Hide[0] == 0)&&(Title[TRACK1][SOURCE].Value != HIDE)){
        if((y[1]-y[0])>5){
          for(i=y[0]; i<=y[1]; ++i) LCD_Buffer2[i] |=Color[TR_1]-0x4200; // 低亮度//Less brightness
        } else {
          for(i=y[0]; i<=y[1]; ++i) LCD_Buffer2[i] |=Color[TR_1];        // 正常亮度//Normal brightness
        }
      }
      if((Dot_Hide[2] == 0)&&(Title[TRACK2][SOURCE].Value != HIDE)){
        if((y[3]-y[2])>5){
          for(i=y[2]; i<=y[3]; ++i) LCD_Buffer2[i] |=Color[TR_2]-0x0208; // 低亮度//Less brightness
        } else {   
          for(i=y[2]; i<=y[3]; ++i) LCD_Buffer2[i] |=Color[TR_2];        // 正常亮度//Normal brightness
        }
      }
      if((Dot_Hide[4] == 0)&&(Title[TRACK3][SOURCE].Value != HIDE)){
        if((y[5]-y[4])>5){
          for(i=y[4]; i<=y[5]; ++i) LCD_Buffer2[i] |=Color[TR_3]-0x4008; // 低亮度//Less brightness
        } else {
          for(i=y[4]; i<=y[5]; ++i) LCD_Buffer2[i] |=Color[TR_3];        // 正常亮度//Normal brightness
        }
      }
      if((Dot_Hide[6] == 0)&&(Title[TRACK4][SOURCE].Value != HIDE)){
        if((y[7]-y[6])>5){
          for(i=y[6]; i<=y[7]; ++i) LCD_Buffer2[i] |=Color[TR_4]-0x0200; // 低亮度//Less brightness
        } else {
          for(i=y[6]; i<=y[7]; ++i) LCD_Buffer2[i] |=Color[TR_4];        // 正常亮度//Normal brightness
        }
      }
//------------------------- Draw the Trigg Vernie data -------------------------
      if(Title[TRIGG][SOURCE].Value == TRACK1) 
        LCD_Buffer2[V_Trigg[TRACK1].Value] |= Color[TR_1];
      if(Title[TRIGG][SOURCE].Value == TRACK2) 
        LCD_Buffer2[V_Trigg[TRACK2].Value] |= Color[TR_2];
      if(Title[TRIGG][SOURCE].Value == TRACK3) 
        LCD_Buffer2[V_Trigg[TRACK3].Value] |= Color[TR_3];
      if(Title[TRIGG][SOURCE].Value == TRACK4) 
        LCD_Buffer2[V_Trigg[TRACK4].Value] |= Color[TR_4];
//------------------------- Draw the X Vernie data -----------------------------
      Tmp =(MIN_X + 150)- _X_posi.Value;
      if(Tmp > MIN_X) {
        if((Row == Tmp)&&((_X_posi.Flag & HID)== 0)){
          for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer2[i] |= Color[X_POSI];
        }
        if((Row == Tmp-1)||(Row == Tmp+1)){
          LCD_Buffer2[Y_SIZE] = Color[X_POSI];
          LCD_Buffer2[Y_BASE] = Color[X_POSI];
        }
        if(Row == Tmp){
          LCD_Buffer2[Y_SIZE]   = Color[X_POSI];
          LCD_Buffer2[Y_SIZE-1] = Color[X_POSI];
          LCD_Buffer2[Y_BASE+1] = Color[X_POSI];
          LCD_Buffer2[Y_BASE]   = Color[X_POSI];
        }
      }
      Tmp = MIN_X + Title[T_VERNIE][T1].Value;
      if((Row == Tmp)&&((Title[T_VERNIE][T1].Flag & HID)== 0)){
        for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer2[i] |= Color[VERNIE];
      }
      if((Row == Tmp-1)||(Row == Tmp+1)){
        LCD_Buffer2[Y_SIZE] |= Color[VERNIE];
        LCD_Buffer2[Y_BASE] |= Color[VERNIE];
      }
      if(Row == Tmp){
        LCD_Buffer2[Y_SIZE]   |= Color[VERNIE];
        LCD_Buffer2[Y_SIZE-1] |= Color[VERNIE];
        LCD_Buffer2[Y_BASE+1] |= Color[VERNIE];
        LCD_Buffer2[Y_BASE]   |= Color[VERNIE];
      }
      Tmp = MIN_X + Title[T_VERNIE][T2].Value;
      if((Row == Tmp)&&((Title[T_VERNIE][T2].Flag & HID)== 0)){
        for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer2[i] |= Color[VERNIE];
      }
      if((Row == Tmp-1)||(Row == Tmp+1)){
        LCD_Buffer2[Y_SIZE] = Color[VERNIE];
        LCD_Buffer2[Y_BASE] = Color[VERNIE];
      }
      if(Row == Tmp){
        LCD_Buffer2[Y_SIZE]   = Color[VERNIE];
        LCD_Buffer2[Y_SIZE-1] = Color[VERNIE];
        LCD_Buffer2[Y_BASE+1] = Color[VERNIE];
      }
    } 
//------------------------- Draw the Y Vernie data -----------------------------
      if((Row == MIN_X)||(Row == MAX_X)){
        LCD_Buffer2[Title[V_VERNIE][V1].Value-1] |= Color[VERNIE];
        LCD_Buffer2[Title[V_VERNIE][V1].Value+0] |= Color[VERNIE];
        LCD_Buffer2[Title[V_VERNIE][V1].Value+1] |= Color[VERNIE];
        LCD_Buffer2[Title[V_VERNIE][V2].Value-1] |= Color[VERNIE];
        LCD_Buffer2[Title[V_VERNIE][V2].Value+0] |= Color[VERNIE];
        LCD_Buffer2[Title[V_VERNIE][V2].Value+1] |= Color[VERNIE];
      }
    __LCD_Copy(LCD_Buffer2, Y_SIZE+1);               // Odd row Transitive
  } else {                                           // Even row process
//----------------------- Fill the row base data -------------------------------
    if(Row+1 == MAX_X)                   __Row_Copy(Row_Base1, LCD_Buffer2);
    else if(Row+1 == MIN_X)              ;
    else if((Row+1 - MIN_X)%30 == 0)     __Row_Copy(Row_Base4, LCD_Buffer2);
    else if((Row+1 - MIN_X)%6  == 0)     __Row_Copy(Row_Base3, LCD_Buffer2);
    else                                 __Row_Copy(Row_Base2, LCD_Buffer2);
//------------------------- Draw the Y Vernie data -----------------------------
    if((Row==MIN_X+1)||(Row==MAX_X-1)){
        LCD_Buffer1[Title[V_VERNIE][V1].Value] |= Color[VERNIE];
        LCD_Buffer1[Title[V_VERNIE][V2].Value] |= Color[VERNIE];
    }
      if((Title[V_VERNIE][V1].Flag & HID)== 0) 
        LCD_Buffer1[Title[V_VERNIE][V1].Value] |= Color[VERNIE];
      if((Title[V_VERNIE][V2].Flag & HID)== 0) 
        LCD_Buffer1[Title[V_VERNIE][V2].Value] |= Color[VERNIE];
//------------------------- Draw the Curve data --------------------------------
    if((Row > MIN_X)&&(Row < MAX_X)){              
      if((Dot_Hide[0] == 0)&&(Title[TRACK1][SOURCE].Value != HIDE)){
        if((y[1]-y[0])>5){
          for(i=y[0]; i<=y[1]; ++i) LCD_Buffer1[i] |=Color[TR_1]-0x4200; // 低亮度//Less brightness
        } else {
          for(i=y[0]; i<=y[1]; ++i) LCD_Buffer1[i] |=Color[TR_1];        // 正常亮度//Normal brightness
        }
      }
      if((Dot_Hide[2] == 0)&&(Title[TRACK2][SOURCE].Value != HIDE)){
        if((y[3]-y[2])>5){
          for(i=y[2]; i<=y[3]; ++i) LCD_Buffer1[i] |=Color[TR_2]-0x0208; // 低亮度//Less brightness
        } else {   
          for(i=y[2]; i<=y[3]; ++i) LCD_Buffer1[i] |=Color[TR_2];        // 正常亮度//Normal brightness
        }
      }
      if((Dot_Hide[4] == 0)&&(Title[TRACK3][SOURCE].Value != HIDE)){
        if((y[5]-y[4])>5){
          for(i=y[4]; i<=y[5]; ++i) LCD_Buffer1[i] |=Color[TR_3]-0x4008; // 低亮度//Less brightness
        } else {
          for(i=y[4]; i<=y[5]; ++i) LCD_Buffer1[i] |=Color[TR_3];        // 正常亮度//Normal brightness
        }
      }
      if((Dot_Hide[6] == 0)&&(Title[TRACK4][SOURCE].Value != HIDE)){
        if((y[7]-y[6])>5){
          for(i=y[6]; i<=y[7]; ++i) LCD_Buffer1[i] |=Color[TR_4]-0x0200; // 低亮度//Less brightness
        } else {
          for(i=y[6]; i<=y[7]; ++i) LCD_Buffer1[i] |=Color[TR_4];        // 正常亮度//Normal brightness
        }
      }
//------------------------- Draw the X Vernie data -----------------------------
      Tmp =(MIN_X + 150)- _X_posi.Value;
      if(Tmp > MIN_X) {
        if((Row == Tmp)&&((_X_posi.Flag & HID)== 0)){
          for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer1[i] |= Color[X_POSI];
        }
        if((Row == Tmp-1)||(Row == Tmp+1)){
          LCD_Buffer1[Y_SIZE] = Color[X_POSI];
          LCD_Buffer1[Y_BASE] = Color[X_POSI];
        }
        if(Row == Tmp){
          LCD_Buffer1[Y_SIZE]   = Color[X_POSI];
          LCD_Buffer1[Y_SIZE-1] = Color[X_POSI];
          LCD_Buffer1[Y_BASE+1] = Color[X_POSI];
          LCD_Buffer1[Y_BASE]   = Color[X_POSI];
        }
      }
      Tmp = MIN_X + Title[T_VERNIE][T1].Value;
      if((Row == Tmp)&&((Title[T_VERNIE][T1].Flag & HID)== 0)){
        for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer1[i] |= Color[VERNIE];
      }
      if((Row == Tmp-1)||(Row == Tmp+1)){
        LCD_Buffer1[Y_SIZE] = Color[VERNIE];
        LCD_Buffer1[Y_BASE] = Color[VERNIE];
      }
      if(Row == Tmp){
        LCD_Buffer1[Y_SIZE]   = Color[VERNIE];
        LCD_Buffer1[Y_SIZE-1] = Color[VERNIE];
        LCD_Buffer1[Y_BASE+1] = Color[VERNIE];
      }
      Tmp = MIN_X + Title[T_VERNIE][T2].Value;
      if((Row == Tmp)&&((Title[T_VERNIE][T2].Flag & HID)== 0)){
        for(i = 1; i < Y_SIZE; i+=3) LCD_Buffer1[i] |= Color[VERNIE];
      }
      if((Row == Tmp-1)||(Row == Tmp+1)){
        LCD_Buffer1[Y_SIZE] = Color[VERNIE];
        LCD_Buffer1[Y_BASE] = Color[VERNIE];
      }
      if(Row == Tmp){
        LCD_Buffer1[Y_SIZE]   = Color[VERNIE];
        LCD_Buffer1[Y_SIZE-1] = Color[VERNIE];
        LCD_Buffer1[Y_BASE+1] = Color[VERNIE];
      }
    }
    __LCD_Copy(LCD_Buffer1, Y_SIZE+1);             // Even row Transitive
  }
}
/*******************************************************************************
 Draw_Window :  
*******************************************************************************/
void Draw_Window(void)						
{ 
  u16 Row;
  __Row_DMA_Ready();
  __Row_Copy(Row_Base1, LCD_Buffer2);
  __Row_DMA_Ready();
  __Row_Copy(Row_Base2, LCD_Buffer1);
  for(Row = MIN_X; Row <= MAX_X; ++Row) Draw_Row(Row); 
  __LCD_DMA_Ready();
  __Row_DMA_Ready();
}
/*******************************************************************************
 Draw_Mark :  
*******************************************************************************/
void Draw_Mark(u16 m, u16 n)						
{ 
  u16 i, j, Tmp;
  
  if(m < 4)  if(Title[m][POSI].Value > 200-3) return;
  else       if(V_Trigg[n].Value > 200-3)     return;  
  
  for(i = 0; i <= 10; ++i){
    if(i < 7){
      if(m < 4){
        Tmp = Mark_TAB[m][i];
        __Point_SCR(i, Title[m][POSI].Value +(MIN_Y-4));
      } else {
        Tmp = Mark_TAB[4][i];
        __Point_SCR(i,     V_Trigg[n].Value +(MIN_Y-4));
      }
      for(j = 0; j < 8; ++j){
        if(Tmp & 1) __LCD_SetPixl(Color[SCRN]);
        else        __LCD_SetPixl(Color[n]);
        Tmp >>= 1;
      }
      __LCD_SetPixl(Color[n]);
    } else {
      if(m < 4){
        __Point_SCR(i, Title[m][POSI].Value +(MIN_Y-10)+ i);
        for(j=Title[m][POSI].Value+(MIN_Y-10)+i;j<(Title[m][POSI].Value+(MIN_Y+11)-i);++j) 
          __LCD_SetPixl(Color[n]); 
      } else { 
        __Point_SCR(i,     V_Trigg[n].Value +(MIN_Y-10)+ i);   
        for(j=V_Trigg[n].Value+(MIN_Y-10)+i;j<(V_Trigg[n].Value+(MIN_Y+11)-i);++j) 
          __LCD_SetPixl(Color[n]); 
      }
    }
  }
}
/*******************************************************************************
 Update_Mark :  
*******************************************************************************/
void Update_Mark(void)						
{ 
  s16 i, Tmp; 
  u8  j;
  
  __Row_DMA_Ready();
  for(i = 0; i <= 10; ++i){
    __Point_SCR(i, MIN_Y-1);
    for(j = MIN_Y-1; j < MAX_Y+2; ++j)  __LCD_SetPixl(Color[SCRN]);   // Clear row
  }
  if(_1_source  != HIDE)    Draw_Mark(TRACK1, TRACK1); // Display Track1 mark
  if(_2_source  != HIDE)    Draw_Mark(TRACK2, TRACK2); // Display Track1 mark
  if(_3_source  != HIDE)    Draw_Mark(TRACK3, TRACK3); // Display Track1 mark
  if(_4_source  != HIDE)    Draw_Mark(TRACK4, TRACK4); // Display Track1 mark
  if(_Tr_source == TRACK1)  Draw_Mark(TRIGG,  TRACK1); // Display Trigg1 mark
  if(_Tr_source == TRACK2)  Draw_Mark(TRIGG,  TRACK2); // Display Trigg1 mark
  if(_Tr_source == TRACK3)  Draw_Mark(TRIGG,  TRACK3); // Display Trigg1 mark
  if(_Tr_source == TRACK4)  Draw_Mark(TRIGG,  TRACK4); // Display Trigg1 mark
    
  __Point_SCR(MAX_X+1, MIN_Y-1);
  for(j = MIN_Y-1; j < MAX_Y+2; ++j) __LCD_SetPixl(Color[SCRN]); // Clear last row 
  for(i = MIN_X; i <= MAX_X+1; ++i)
  {
    __Point_SCR(i, MIN_Y-1);
    __LCD_SetPixl(Color[SCRN]);                            // Clear first column
    __Point_SCR(i, MAX_Y+1);
    __LCD_SetPixl(Color[SCRN]);                            // Clear last column
  }
  __Point_SCR(MIN_X-1, Title[V_VERNIE][V1].Value +(MIN_Y - 2));
  for(i = 0; i < 5; ++i) __LCD_SetPixl(Color[VERNIE]);
  __Point_SCR(MIN_X-1, Title[V_VERNIE][V2].Value +(MIN_Y - 2));
  for(i = 0; i < 5; ++i) __LCD_SetPixl(Color[VERNIE]);
  __Point_SCR(MAX_X+1, Title[V_VERNIE][V1].Value +(MIN_Y - 2));
  for(i = 0; i < 5; ++i) __LCD_SetPixl(Color[VERNIE]);
  __Point_SCR(MAX_X+1, Title[V_VERNIE][V2].Value +(MIN_Y - 2));
  for(i = 0; i < 5; ++i) __LCD_SetPixl(Color[VERNIE]);
  
  Tmp =(MIN_X + 150)- _X_posi.Value;
  if(Tmp > MIN_X){
    for(i = Tmp - 2; i <= Tmp + 2; ++i){
      __Point_SCR(i, MIN_Y-1);
      __LCD_SetPixl(Color[X_POSI]);
      __Point_SCR(i, MAX_Y+1);
      __LCD_SetPixl(Color[X_POSI]);
    }
  }
  Tmp = MIN_X + Title[T_VERNIE][T1].Value;
  for(i = Tmp - 2; i <= Tmp + 2; ++i){
    __Point_SCR(i, MIN_Y-1);
    __LCD_SetPixl(Color[VERNIE]);
    __Point_SCR(i, MAX_Y+1);
    __LCD_SetPixl(Color[VERNIE]);
  }
  Tmp = MIN_X + Title[T_VERNIE][T2].Value;
  for(i = Tmp - 2; i <= Tmp + 2; ++i){
    __Point_SCR(i, MIN_Y-1);
    __LCD_SetPixl(Color[VERNIE]);
    __Point_SCR(i, MAX_Y+1);
    __LCD_SetPixl(Color[VERNIE]);
  }
}
/*******************************************************************************
 Update_View_Area: 刷新显示窗口位置指示 
                  Refresh the address of window indicator
*******************************************************************************/
void Update_View_Area(void)
{  
  s16 i, j, k;
  {
    __Point_SCR(89,  0);
    for(j=0; j<12; ++j) __LCD_SetPixl(ORANGE); 
    __Point_SCR(90,  0);
    for(j=0; j<12; ++j) __LCD_SetPixl(ORANGE); 
    __Point_SCR(308, 0);
    for(j=0; j<12; ++j) __LCD_SetPixl(ORANGE); 
    __Point_SCR(309, 0);
    for(j=0; j<12; ++j) __LCD_SetPixl(ORANGE); 

    for(i=91; i<307; i+=8){
      for(j=0; j<8; ++j){
        __Point_SCR(i+j, 0);
        for(k=0; k<12; ++k){
          if((0x01 << k)& RULE_BASE[j]) __LCD_SetPixl(ORANGE);
          else                          __LCD_SetPixl(BLACK);
        }
      }
    }
    __Point_SCR(0  + 91 + (_X_posi.Value * 200)/3796, 0); 
    for(j=0;j<9;++j) __LCD_SetPixl(WHT);
    __Point_SCR(15 + 91 + (_X_posi.Value * 200)/3796, 0);
    for(j=0;j<9;++j) __LCD_SetPixl(WHT);
    for(i=0;i<16;++i){
      __Point_SCR(i + 91 +(_X_posi.Value * 200)/3796, 0);
      __LCD_SetPixl(WHT);
      __Point_SCR(i + 91 +(_X_posi.Value * 200)/3796, 9);
      __LCD_SetPixl(WHT);
    }
    _X_View.Flag &= !UPDAT;
  }
}
/******************************** END OF FILE *********************************/
