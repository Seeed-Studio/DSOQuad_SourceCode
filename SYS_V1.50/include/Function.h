/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : Function.h  
 Version   : DS203_SYS Ver 1.2x                                 Author : bure
*******************************************************************************/
#ifndef __Function_H__
#define __Function_H__

#include "stm32f10x_lib.h"

#define NO_KEY       0
#define K_PLAY       1
#define K_SELE       2
#define K_FUNC       3
#define K_MENU       4
#define K_INDEX_DEC  5
#define K_INDEX_INC  6
#define K_INDEX_OK   7
#define K_ITEM_INC   8
#define K_ITEM_DEC   9
#define K_ITEM_OK    10

u8   Str2Byte(u8 x,u8 y);
void u16ToDec5(u8 *p, u16 n);
void u8ToDec3(u8 *p, u8 n);
void u8ToDec2(u8 *p, u8 n);
void Char2Hex(u8 *p, u8 n);
void Word2Hex(u8 *p, u32 n);
u32  Int_sqrt(u32 n);
u8   Read_Keys(void);
void Beep(u8 Volume, u16 mS);          // Volume=0~99, Lenght=1~65535mS

#endif
/********************************* END OF FILE ********************************/
