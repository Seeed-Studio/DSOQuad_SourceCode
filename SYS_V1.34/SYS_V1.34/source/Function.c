/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : Function.c  
 Version   : DS203_SYS Ver 1.3x                          Author : kewei & bure
*******************************************************************************/

#include "stm32f10x_lib.h"
#include "Interrupt.h"
#include "Function.h"
#include "Config.h"
#include "BIOS.h"
#include "ASM.h"

                          
/*******************************************************************************
 Two ASCII character Change to 1 Byte HEX data 
*******************************************************************************/
u8 Str2Byte(u8 x,u8 y) // 双ASCII字符转1字节二进制数Two ASCII character Change to 1 Byte HEX data
{
  uc8 Hexcode[17]="0123456789ABCDEF";
  u8 i, Temp=0;
  
  if(x>='a' && x<='z')  x-=32;     // 小写改大写//Low-case to upper-case	
  if(y>='a' && y<='z')  y-=32;     // 小写改大写//Low-case to upper-case
  for(i=0;i<16;i++){
    if(Hexcode[i]==x)  Temp+=i*16; // 将字符转为高4位十六进制数值//Convert a char to upper 4 bits of hexadecimal
  }
  for(i=0;i<16;i++){
    if(Hexcode[i]==y)  Temp+=i;    // 将字符转为低4位十六进制数值//Convert a char to lower 4 bits of hexadecimal
  }
  return Temp;
}

/*******************************************************************************
 u16ToDec5: Change Byte to 3 decimal number string   
*******************************************************************************/
void u16ToDec5(u8 *p, u16 n)
{
    *p++ = '0'+n/10000;
    n %= 10000;
    *p++ = '0'+n/1000;
    n %= 1000;
    *p++ = '0'+n/100;
    n %= 100;
    *p++ = '0'+n/10;
    n %= 10;
    *p++ = '0'+n;
    *p = 0;
}
/*******************************************************************************
 Char2Dec3: Change Byte to 3 decimal number string   
*******************************************************************************/
void u8ToDec3(u8 *p, u8 n)
{
    *p++ = '0'+n/100;
    n %= 100;
    *p++ = '0'+n/10;
    n %= 10;
    *p++ = '0'+n;
    *p = 0;
}
/*******************************************************************************
 Char2Dec2: Change Byte to 2 decimal number string   
*******************************************************************************/
void u8ToDec2(u8 *p, u8 n)
{
//    *p++ = '0'+n/100;
    n %= 100;
    *p++ = '0'+n/10;
    n %= 10;
    *p++ = '0'+n;
    *p = 0;
}
/*******************************************************************************
 Char2Hex: Change Byte to 2 hex number string  
*******************************************************************************/
void Char2Hex(u8 *p, u8 n)
{
    if(n/16>9) *p++ = 'A'+(n/16-10);
    else       *p++ = '0'+n/16;
    n %= 16;
    if(n>9)    *p++ = 'A'+(n-10);
    else       *p++ = '0'+n;
    *p = 0;
}
/*******************************************************************************
 Word2Hex: Change 4 Bytes to 8 hex number string  
*******************************************************************************/
void Word2Hex(u8 *p, u32 n)
{
    if(n/0x10000000>9) *p++ = 'A'+(n/0x10000000-10);
    else               *p++ = '0'+ n/0x10000000;
    n %= 0x10000000;
    if(n/0x01000000>9) *p++ = 'A'+(n/0x01000000-10);
    else               *p++ = '0'+ n/0x01000000;
    n %= 0x01000000;
    if(n/0x00100000>9) *p++ = 'A'+(n/0x00100000-10);
    else               *p++ = '0'+ n/0x00100000;
    n %= 0x00100000;
    if(n/0x00010000>9) *p++ = 'A'+(n/0x00010000-10);
    else               *p++ = '0'+ n/0x00010000;
    n %= 0x00010000;
    if(n/0x00001000>9) *p++ = 'A'+(n/0x00001000-10);
    else               *p++ = '0'+ n/0x00001000;
    n %= 0x00001000;
    if(n/0x00000100>9) *p++ = 'A'+(n/0x00000100-10);
    else               *p++ = '0'+ n/0x00000100;
    n %= 0x00000100;
    if(n/0x00000010>9) *p++ = 'A'+(n/0x00000010-10);
    else               *p++ = '0'+ n/0x00000010;
    n %= 0x00000010;
    if(n/0x00000001>9) *p++ = 'A'+(n/0x00000001-10);
    else               *p++ = '0'+ n/0x00000001;
    n %= 0x10000000;
    *p = 0;
}
/*******************************************************************************
 Int_sqrt: unsigned int square root
*******************************************************************************/
u32 Int_sqrt(u32 n)
{ u32 k;
  if ( n == 0 ) return 0;
  k = 2*Int_sqrt(n/4)+1;
  if ( k*k > n ) return k-1;
  else return k;
}
/*******************************************************************************
Read_Keys:    Key status process                                Return: KeyCode
*******************************************************************************/
u8 Read_Keys(void)
{
  u16 Key_Status, Key_Status_Now;
  u8  KeyCode=0;
  Key_Status_Now = ~Get(KEY_STATUS, 0);
  Key_Status = Key_Status_Now &(~Key_Status_Last);
  if(Key_Status){                               // New key push on
    Key_Wait_Cnt=25;                        // Close auto repeat 500mS
    if(Key_Status & 0x0100)  KeyCode = K_FUNC;         // K3 
    if(Key_Status & 0x0200)  KeyCode = K_MENU;         // K4 
    if(Key_Status & 0x0400)  KeyCode = K_INDEX_DEC;    // K5 
    if(Key_Status & 0x0800)  KeyCode = K_INDEX_INC;    // K6  
    if(Key_Status & 0x1000)  KeyCode = K_INDEX_OK;     // K7  
    if(Key_Status & 0x2000)  KeyCode = K_SELE;         // K2
    if(Key_Status & 0x4000)  KeyCode = K_PLAY;         // K1
    if(Key_Status & 0x8000)  KeyCode = K_ITEM_INC;     // K8
    if(Key_Status & 0x0008)  KeyCode = K_ITEM_DEC;     // K9
    if(Key_Status & 0x0040)  KeyCode = K_ITEM_OK;      // K10
  } else {
    if(Key_Status_Now & Key_Status_Last){       // Key push hold on
      if((Key_Wait_Cnt ==0)&&(Key_Repeat_Cnt ==0)){
        if(Key_Status_Now & 0x0400)  KeyCode = K_INDEX_DEC;    // K5 
        if(Key_Status_Now & 0x0800)  KeyCode = K_INDEX_INC;    // K6
        if(Key_Status_Now & 0x0008)  KeyCode = K_ITEM_DEC;     // K9 
        if(Key_Status_Now & 0x8000)  KeyCode = K_ITEM_INC;     // K8 
        Key_Repeat_Cnt = 5;                 // Auto repeat per 100mS
      }
    }
  }
  Key_Status_Last = Key_Status_Now;
  return KeyCode;
}    
/*******************************************************************************
Beep : Beeper Ctrl  (Volume=0~99, Lenght=1~65535mS)
*******************************************************************************/
void Beep(u8 Volume, u16 mS)
{
  Beep_mS = mS; 
  Set(BEEP_VOLUME, Volume);
}
/********************************* END OF FILE ********************************/
