/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : Function.c  
 Version   : DS203 APP Ver 2.5x                          Author : bure & Kewei
*******************************************************************************/
#include "Interrupt.h"
#include "Function.h"
#include "BIOS.h"

u32 TestCnt = 0;

/*******************************************************************************
 
*******************************************************************************/
u32 Power(u8 x, u8 y) 
{ 
  u32 m = x;
  
  if(y == 0) return 1;
  while (--y) m *= x;
  return m;
}
/*******************************************************************************
 delayms: 毫秒（mS）延时程序。 输入: 延时等待的毫秒数值（在72MHz主频情况下）
*******************************************************************************/
void Delayms(u16 mS) 
{ 
  Delay_Cnt = mS;
  while (Delay_Cnt > 0){}
}
/*******************************************************************************
 Sign_int2Str: 32位数转e位有效数字符串 + 量纲字符串
*******************************************************************************/
void Int2Str(u8 *p, s32 n, uc8 *pUnit, u8 e, u8 Mode)
{
  s32 i, j, m, c;
  u8  *k;
  
  if(n == 0x80000000){               // 该数值定义为无效数值
    *p++ = ' '; *p++ = '.';
    while(--e)  *p++ = ' '; 
    *p = 0;  return;
  }
  if(Mode == SIGN){
    if(n == 0) *p++ = '0';
    if(n >  0) *p++ = '+';
    if(n <  0){*p++ = '-';  n = -n;}
  }
  m = n; i = 0; c = 5;
  while(m >= 10){                    // 检测 n 的有效位数
    m /= 10;  if(++i > e) c *= 10;   // 有效位数大于e则计算四舍五入位数
  }
  if(i >= e) n += c;                 // 加上四舍五入值
  m = n; i = 0;
  while(m >= 10){                    // 重新检测 n 的有效位数
    m /= 10; i++;
  }
  i++;   
  if(e > 3){
    m = (i-1)/3;
    i %= 3;
    if(i == 0) i = 3;
  } else {
    m = i/3;
    i %= 3;
  }
  p += e; k = p+1;  
  while(n >= Power(10, e)) n /= 10;  // 截取最高e位有效位数
  for(j=0; j<m; j++) while(*pUnit++);
  do *k++ = *pUnit; while(*pUnit++); // 量纲字符字符串  
  while(e--){
    *p-- = '0'+(n%10); n /= 10;
    if((Mode != STD)&&(m > 0)&&(i == e)) *p-- = '.';
//    if((m > 0)&&(i == e)) *p-- = '.';
  }
  if((Mode != STD)&&(m == 0)) *p-- = '.';
  if((Mode == STD)&&(m == 0)) *p-- = ' ';
}
/*******************************************************************************
 Int32String_sign:带符号32位数转3位有效数字字符串  
******************************************************************************
void Int32String_sign(I32STR_RES *r, s32 n)
{
  u32 i, m, c, e=3, fixlen;
  u8 *p = r->str;
  
  fixlen = e+2;
  if(n == 0x80000000){
    *p++ = ' ';
    *p++ = '.';
    *p++ = ' ';
    *p++ = ' ';
    *p++ = ' ';
    *p = 0;
    r->decPos = 4;
    r->len = p-r->str;
    return;
  }
  if ( n == 0 ) {
    *p++ = '+';
    *p++ = '0';
    *p++ = '.';
    *p++ = '0';
    *p++ = '0';
    *p = 0;
    r->decPos = 0;
    r->len = p-r->str;
    return;
  }  
  if ( n > 0 ) *p++ = '+';
  else {
    *p++ = '-';
    n = -n;
  }
  m = n;
  i = 0;
  c = 5;
  while ( m >= 10 ) {
    m /= 10;
    if ( ++i > e ) c *= 10;
  }
  if ( i >= e ) n += c;
  m = n;
  i = 0;
  while ( m >= 10 ) {
    m /= 10;
    i++;
  }
  r->decPos = i/3;   
  switch ( i ) {
  case 9:
    *p++ = '0'+n/1000000000;
    if ( --e == 0 ) break;
    n %= 1000000000;
    *p++ = '.', i = 0;
  case 8:
    *p++ = '0'+n/100000000;
    if ( --e == 0 ) break;
    n %= 100000000;
  case 7:
    *p++ = '0'+n/10000000;
    if ( --e == 0 ) break;
    n %= 10000000;
  case 6:
    *p++ = '0'+n/1000000;
    if ( --e == 0 ) break;
    n %= 1000000;
    if ( i ) *p++ = '.', i = 0;
  case 5:
    *p++ = '0'+n/100000;
    if ( --e == 0 ) break;
    n %= 100000;
  case 4:
    *p++ = '0'+n/10000;
    if ( --e == 0 ) break;
    n %= 10000;
  case 3:
    *p++ = '0'+n/1000;
    if ( --e == 0 ) break;
    n %= 1000;
    if ( i ) *p++ = '.', i = 0;
  case 2:
    *p++ = '0'+n/100;
    if ( --e == 0 ) break;
    n %= 100;
  case 1:
    *p++ = '0'+n/10;
    if ( --e == 0 ) break;
    n %= 10;
  case 0:
    *p++ = '0'+n;
  }
  while ( p < r->str+fixlen )  *p++ = ' ';
  *p = 0;
  r->len = p-r->str;
}*/
/*******************************************************************************
 Int32String:无符号32位数转e位有效数字字符串  
******************************************************************************
void Int32String(I32STR_RES *r, u32 n, u32 e)
{
  u32 i, m, c, fixlen;
  u8 *p = r->str;

//  fixlen = e+2;
  fixlen = e+1;
  if(n == 0x80000000){
    *p++ = ' ';
    *p++ = '.';
    *p++ = ' ';
    *p++ = ' ';
    *p++ = ' ';
    *p = 0;
    r->decPos = 4;
    r->len = p-r->str;
    return;
  }
  if ( n == 0 ) {
    *p++ = '0';
    *p++ = '.';
    *p++ = '0';
    *p++ = '0';
    *p++ = '0';
    *p = 0;
    r->decPos = 0;
    r->len = p-r->str;
    return;
  }  
  m = n;
  i = 0;
  c = 5;
  while ( m >= 10 ) {
    m /= 10;
    if ( ++i > e ) c *= 10;
  }
  if ( i >= e ) n += c;
  m = n;
  i = 0;
  while ( m >= 10 ) {
    m /= 10;
    i++;
  }
  r->decPos = i/3;   
  switch ( i ) {
  case 9:
    *p++ = '0'+n/1000000000;
    if ( --e == 0 ) break;
    n %= 1000000000;
    *p++ = '.', i = 0;
  case 8:
    *p++ = '0'+n/100000000;
    if ( --e == 0 ) break;
    n %= 100000000;
  case 7:
    *p++ = '0'+n/10000000;
    if ( --e == 0 ) break;
    n %= 10000000;
  case 6:
    *p++ = '0'+n/1000000;
    if ( --e == 0 ) break;
    n %= 1000000;
    if ( i ) *p++ = '.', i = 0;
  case 5:
    *p++ = '0'+n/100000;
    if ( --e == 0 ) break;
    n %= 100000;
  case 4:
    *p++ = '0'+n/10000;
    if ( --e == 0 ) break;
    n %= 10000;
  case 3:
    *p++ = '0'+n/1000;
    if ( --e == 0 ) break;
    n %= 1000;
    if ( i ) *p++ = '.', i = 0;
  case 2:
    *p++ = '0'+n/100;
    if ( --e == 0 ) break;
    n %= 100;
  case 1:
    *p++ = '0'+n/10;
    if ( --e == 0 ) break;
    n %= 10;
  case 0:
    *p++ = '0'+n;
  }
  while ( p < r->str+fixlen )  *p++ = ' ';
  *p = 0;
  r->len = p-r->str;
}
*/
/*******************************************************************************
 Two ASCII character Change to 1 Byte HEX data 
*******************************************************************************/
u8 Str2Byte(u8 x,u8 y) // 双ASCII字符转1字节二进制数
{
  uc8 Hexcode[17]="0123456789ABCDEF";
  u8 i, Temp=0;
  
  if(x>='a' && x<='z')  x-=32;     // 小写改大写
  if(y>='a' && y<='z')  y-=32;     // 小写改大写
  for(i=0;i<16;i++){
    if(Hexcode[i]==x)  Temp+=i*16; // 将字符转为高4位十六进制数值
  }
  for(i=0;i<16;i++){
    if(Hexcode[i]==y)  Temp+=i;    // 将字符转为低4位十六进制数值
  }
  return Temp;
}

/*******************************************************************************
 u16ToDec5: Change 2 Byte to 5 decimal number string   
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
 u8ToDec3: Change Byte to 3 decimal number string   
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
 s8ToPercen: Change sign char to +(-)x.xx string   
*******************************************************************************/
void s8ToPercen(u8 *p, s8 n)
{
    if(n >= 0)  *p++ = '+';
    else {
      *p++ = '-';
      n = -n;
    }
    *p++ = '0'+n/100;
    n %= 100;
    *p++ = '.';
    *p++ = '0'+n/10;
    n %= 10;
    *p++ = '0'+n;
    *p = 0;
}
/*******************************************************************************
 u8ToDec2: Change Byte to 2 decimal number string   
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
 Shor2Hex: Change 2Bytes to 4 hex number string  
*******************************************************************************/
void Shor2Hex(u8 *p, u16 n)
{
    if(n/0x1000 >9) *p++ = 'A'+(n/0x1000-10);
    else            *p++ = '0'+ n/0x1000;
    n %= 0x1000;
    if(n/0x100 >9)  *p++ = 'A'+(n/0x100-10);
    else            *p++ = '0'+ n/0x100;
    n %= 0x100;
    if(n/0x10 >9)   *p++ = 'A'+(n/0x10-10);
    else            *p++ = '0'+ n/0x10;
    n %= 0x10;
    if(n >9)        *p++ = 'A'+(n-10);
    else            *p++ = '0'+n;
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
  
  Key_Status_Now = ~__Get(KEY_STATUS);//~KeyScan();
  Key_Status = Key_Status_Now &(~Key_Status_Last);
  if(Key_Status){                               // New key push on
    Key_Wait_Cnt=25;                        // Close auto repeat 500mS
    if(Key_Status & K_ITEM_D_STATUS)   KeyCode = K_ITEM_DEC;    // K9
    if(Key_Status & K_ITEM_S_STATUS)   KeyCode = K_ITEM_S;      // K10
    if(Key_Status & KEY3_STATUS)       KeyCode = KEY3;          // K3 
    if(Key_Status & KEY4_STATUS)       KeyCode = KEY4;          // K4 
    if(Key_Status & K_INDEX_D_STATUS)  KeyCode = K_INDEX_DEC;   // K5 
    if(Key_Status & K_INDEX_I_STATUS)  KeyCode = K_INDEX_INC;   // K6  
    if(Key_Status & K_INDEX_S_STATUS)  KeyCode = K_INDEX_S;     // K7  
    if(Key_Status & KEY2_STATUS)       KeyCode = KEY2;          // K2
    if(Key_Status & KEY1_STATUS)       KeyCode = KEY_P;         // K1
    if(Key_Status & K_ITEM_I_STATUS)   KeyCode = K_ITEM_INC;    // K8
  } else {
    if(Key_Status_Now & Key_Status_Last){       // Key push hold on
      if((Key_Wait_Cnt || Key_Repeat_Cnt)==0){
        if(Key_Status_Now & K_INDEX_D_STATUS)  KeyCode = K_INDEX_DEC;    // K5 
        if(Key_Status_Now & K_INDEX_I_STATUS)  KeyCode = K_INDEX_INC;    // K6
        if(Key_Status_Now & K_ITEM_D_STATUS)   KeyCode = K_ITEM_DEC;     // K9 
        if(Key_Status_Now & K_ITEM_I_STATUS)   KeyCode = K_ITEM_INC;     // K8 
        Key_Repeat_Cnt = 5;                 // Auto repeat per 100mS
      }
    }
  }
  Key_Status_Last = Key_Status_Now;
  return KeyCode;
} 

/********************************* END OF FILE ********************************/
