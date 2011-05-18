/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : Authenticate.c  
 Version   : DS203_SYS Ver 1.02                          Author : kewei & bure
*******************************************************************************/
//#include <stdio.h>
#include "Authenticate.h"
#include "Interrupt.h"
#include "SPI_flash.h"
#include "Function.h"
#include <string.h>
#include "LCD.h"
#include "ASM.h"

/************************ Licence Block defination（公开）**********************
offset 0x00~0x03: ProjectID 4Bytes (example:  0x12345678)  
offset 0x04~0x07: LicenceNo 4Bytes (example:  0x0A1B2C3D)
offset 0x08~0x0B: DemoCntL  4Bytes (Cnt = 00: 0x00000000, Cnt = 31: 0xFFFFFFFF)
offset 0x0C~0x0F: DemoCntH  4Bytes (Cnt = 32: 0x00000000, Cnt = 63: 0xFFFFFFFF)
offset 0x10~0x1F: Developer Str 15+1Bytes (example: "e-Design 2011.3")
*******************************************************************************/

//u8  FlashBuf[256]; 
    
/*******************************************************************************
 Add_Rec: Add a licence recoed                        Return: 0 = Ok, FF = Full
*******************************************************************************/
u16 Add_Rec(u32 ProjectID, u8 DemoRunCnt, u8 *Str16) 
{
  u16 i, j, k, Tmp, Result;
  
  FLASH_Unlock();
  for(i=0; i<2048; i+=32){               // Find blank recoed  
    Tmp = 0xFFFF;
    for(j=0; j<8; j+=4)  Tmp &= *(u32*)(REC_BASE + i + j);
    if(Tmp == 0xFFFF){
      Result  = FLASH_Prog(REC_BASE+i+0x00, ProjectID & 0xFFFF);
      Result |= FLASH_Prog(REC_BASE+i+0x02, ProjectID >> 16);
      for(k=0x10; k<0x20; k+=2){
        Result |= FLASH_Prog(REC_BASE+i+k, *(u16*)Str16);
        (u16*)Str16++;
      }
      if(Result == FLASH_COMPLETE){
        FLASH_Lock();
        return 0;
      }
    }
  }
  return 0xFF;
}
/*******************************************************************************
 Add_Lic: Add or edit Licence recoed  Return: 0 = Ok, 1 = Full
*******************************************************************************/
u8 Add_Lic(u32 ProjectID, u32 LicenceNo) 
{
  u16 i, Result;
  
  FLASH_Unlock();
  i = Seek_Lic(DEVELOPER_ID, ProjectID);
  if(i<64){
    Result  = FLASH_Prog(REC_BASE+i+4, LicenceNo & 0xFFFF);
    Result |= FLASH_Prog(REC_BASE+i+6, LicenceNo >> 16);
    if(Result == FLASH_COMPLETE){
      FLASH_Lock();
      return 0;
    }
  }
  return 1;
}
/*******************************************************************************
 Seek_Lic: Seek Licence             RET: 0~64 = Licence offset, FF = No licence 
*******************************************************************************/
u8 Seek_Lic(u32 LicenceNo, u32 Proj_ID)
{
  u16 i;
  for(i=0; i<2048; i+=32){
    if((Proj_ID ==(*(u32*)(REC_BASE+i)))&&(LicenceNo ==(*(u32*)(REC_BASE+i+4))))
      return i; 
  }
  return 0xFF;
}
/*******************************************************************************
 Chk_Lic: Check Licence               RET: 0 = Lic ok / UnLtd. 1~64 = DemoCnt. 
*******************************************************************************/
u8 Chk_Lic(u32 Dev_ID, u32 Proj_ID) 
{ 
  u16 i, j, k=0;
  u32 Licence; 
  
  i = Seek_Lic(DEVELOPER_ID, PROJECT_ID);
  Licence = *(u32*)(REC_BASE + i + 4);
  if(__Ident(DEVELOPER_ID, __Dev_SN(), PROJECT_ID, Licence)==0){
    for(j=0; j<32; j++){
      if(*(u32*)(REC_BASE + i +  8)==(1<<j))  k++;
      if(*(u32*)(REC_BASE + i + 12)==(1<<j))  k++;
    }
    return k;                        // 返回 DemoCnt 中"1"的个数//Return the No. of "1" in DemoCnt
  } else   return 0xFF;
}
/*******************************************************************************
 Input_Lic: Input 32 Bytes Licence 
*******************************************************************************/
u32 Input_Lic(u16 x0, u8 y0, u16 Color) // Return: 32Bits Lic 
{
  u8  i=0, j, n[2]={"0"};
  u32 Lic=0;
  u8  NumStr[9], Type;
  
  Word2Hex(NumStr, Lic);
  Display_Str(x0, y0, Color, PRN, NumStr);
  
  while (i<8){
    Word2Hex(NumStr, Lic);
    if( Type != Twink ){  // Blink current number each 0.5 Sec.
      Type = Twink;
      for(j=0; j<8; ++j){ // 刷新显示8位数字，当前位闪烁// Refresh the 8 bits data, and blink current bit
        n[0] = NumStr[j];
        if(i==j) Display_Str(j*8+ x0, y0, Color, Type, n);
        else     Display_Str(j*8+ x0, y0, Color, PRN,  n);
      }
    }
    if(Key_Buffer != 0){
      switch (Key_Buffer){  
      case K_INDEX_DEC:
        if(((Lic >>((7-i)*4))& 0x0F )> 0) Lic -= 0x01<<((7-i)*4);
        else                              Lic += 0x0F<<((7-i)*4);
        break;
      case K_INDEX_INC:
        if(((Lic >>((7-i)*4))& 0x0F )<15) Lic += 0x01<<((7-i)*4);
        else                              Lic -= 0x0F<<((7-i)*4);
        break;
      case K_ITEM_INC:
        if(i<7) i++;
        else    i=0;
        break;
      case K_ITEM_DEC:
        if(i>0) i--;
        else    i=7;
        break;
      case K_SELE:
        i = 8;        // Exit 
        break;
      }
      Key_Buffer = NO_KEY;
    }
  }
  return Lic;
}
/*******************************************************************************
 FLASH_Prog:
*******************************************************************************/
u8 FLASH_Prog(u32 Address, u16 Data)    
{
  if(FLASH_WaitForLastOperation(WAIT_TIMES)!=FLASH_TIMEOUT) 
    FLASH_ClearFlag(FLASH_FLAG_EOP|FLASH_FLAG_PGERR|FLASH_FLAG_WRPRTERR); 
  return FLASH_ProgramHalfWord(Address, Data);
}
/*******************************************************************************
 FLASH_Erase:
*******************************************************************************/
void FLASH_Erase(u32 Address)    
{
  if(Address%PAGE_SIZE == 0){                   // FLASH Page start
    if(FLASH_WaitForLastOperation(WAIT_TIMES)!=FLASH_TIMEOUT) 
      FLASH_ClearFlag(FLASH_FLAG_EOP|FLASH_FLAG_PGERR|FLASH_FLAG_WRPRTERR); 
    FLASH_ErasePage(Address);                   // FLASH Page erase 
  }
}


/********************************* END OF FILE ********************************/
