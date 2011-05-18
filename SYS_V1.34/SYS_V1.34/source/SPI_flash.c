/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : SPI_flash.c  
 Version   : DS203_SYS Ver 1.3x                                  Author : bure
*******************************************************************************/
#include "SPI_flash.h"

u32 Mass_Memory_Size;
u32 Mass_Block_Size;
u32 Mass_Block_Count;

/*******************************************************************************
 SPI_FLASH_PageErase  : Erases the specified FLASH Page.
*******************************************************************************/
void SPI_FLASH_PageErase(u32 PageAddr)
{
  SPI_FLASH_WriteEnable();
  SPI_FLASH_CS_LOW();
  SPI_FLASH_SendByte(PE);
  SPI_FLASH_SendByte((PageAddr & 0xFF0000) >> 16);   //Send high address byte
  SPI_FLASH_SendByte((PageAddr & 0xFF00) >> 8);      //Send medium address byte
  SPI_FLASH_SendByte(PageAddr & 0xFF);               //Send low address byte
  SPI_FLASH_CS_HIGH();

  SPI_FLASH_WaitForWriteEnd();                // Wait the end of Flash writing 
}
/*******************************************************************************
 SPI_FLASH_PageWrite : 

 SPI FLASH 的2~16页被定义成参数区
*******************************************************************************/
void Param_PageWrite(u8* pBuffer, u8 PageNum)
{
  u16 Lenght;
  u32 WriteAddr;
  
  Lenght = 0x100;
  WriteAddr = 0x200 * (1 + PageNum);
//  SPI_FLASH_PageErase(WriteAddr);
  SPI_FLASH_WriteEnable();
  SPI_FLASH_CS_LOW();
  SPI_FLASH_SendByte(PW);
  SPI_FLASH_SendByte((WriteAddr & 0xFF0000) >> 16);
  SPI_FLASH_SendByte((WriteAddr & 0xFF00) >> 8);  
  SPI_FLASH_SendByte(WriteAddr & 0xFF);
  while(Lenght--) {         // while there is data to be written on the FLASH 
    SPI_FLASH_SendByte(*pBuffer);
    pBuffer++; 
  }
  SPI_FLASH_CS_HIGH();
  SPI_FLASH_WaitForWriteEnd();
}

void SPI_FLASH_PageWrite(u8* pBuffer, u32 WriteAddr)
{
  u16 Lenght = 0x100;
  SPI_FLASH_WriteEnable();
  SPI_FLASH_CS_LOW();
  SPI_FLASH_SendByte(PW);
  SPI_FLASH_SendByte((WriteAddr & 0xFF0000) >> 16);
  SPI_FLASH_SendByte((WriteAddr & 0xFF00) >> 8);  
  SPI_FLASH_SendByte(WriteAddr & 0xFF);
  while(Lenght--) {         // while there is data to be written on the FLASH 
    SPI_FLASH_SendByte(*pBuffer);
    pBuffer++; 
  }
  SPI_FLASH_CS_HIGH();
  SPI_FLASH_WaitForWriteEnd();
}

/*******************************************************************************
 SPI_FLASH_BufferRead
*******************************************************************************/
void SPI_FLASH_BufferRead(u8* pBuffer, u32 ReadAddr, u16 NumByteToRead)
{
  SPI_FLASH_CS_LOW();
  SPI_FLASH_SendByte(READ);
  SPI_FLASH_SendByte((ReadAddr & 0xFF0000) >> 16);
  SPI_FLASH_SendByte((ReadAddr& 0xFF00) >> 8);
  SPI_FLASH_SendByte(ReadAddr & 0xFF);

  while(NumByteToRead--){ // while there is data to be read 
    *pBuffer = SPI_FLASH_SendByte(Dummy_Byte);
    pBuffer++;
  }
  SPI_FLASH_CS_HIGH();
}

void Param_PageRead(u8* pBuffer, u8 PageNum)
{
  u16 Lenght = 256;
  u32 ReadAddr = 0x200 * (1 + PageNum);
  SPI_FLASH_CS_LOW();
  SPI_FLASH_SendByte(READ);
  SPI_FLASH_SendByte((ReadAddr & 0xFF0000) >> 16);
  SPI_FLASH_SendByte((ReadAddr& 0xFF00) >> 8);
  SPI_FLASH_SendByte(ReadAddr & 0xFF);
  while(Lenght--){ // while there is data to be read 
    *pBuffer = SPI_FLASH_SendByte(Dummy_Byte);
    pBuffer++;
  }
  SPI_FLASH_CS_HIGH();
}
/*******************************************************************************
 SPI_FLASH_ReadByte
*******************************************************************************/
u8 SPI_FLASH_ReadByte(void)
{
  return (SPI_FLASH_SendByte(Dummy_Byte));
}

/*******************************************************************************
 SPI_FLASH_SendByte
*******************************************************************************/
u8 SPI_FLASH_SendByte(u8 byte)
{
  while(SPI_GetFlagStatus(SPI3, SPI_FLAG_TXE) == RESET);
  SPI_SendData(SPI3, byte);
  while(SPI_GetFlagStatus(SPI3, SPI_FLAG_RXNE) == RESET);
  return SPI_ReceiveData(SPI3);
}
/*******************************************************************************
 SPI_FLASH_WriteEnable
*******************************************************************************/
void SPI_FLASH_WriteEnable(void)
{
  SPI_FLASH_CS_LOW();
  SPI_FLASH_SendByte(WREN);
  SPI_FLASH_CS_HIGH();
}
/*******************************************************************************
 SPI_FLASH_WaitForWriteEnd
*******************************************************************************/
void SPI_FLASH_WaitForWriteEnd(void)
{
  u8 FLASH_Status = 0;
  SPI_FLASH_CS_LOW();
  SPI_FLASH_SendByte(RDSR);
  do { FLASH_Status = SPI_FLASH_SendByte(Dummy_Byte);                
  } while((FLASH_Status & WIP_Flag) == SET);              // Write in progress 
  SPI_FLASH_CS_HIGH();
}
/*******************************************************************************
 MAL_GetStatus
*******************************************************************************/
void MAL_GetStatus (void)
{
    Mass_Block_Count = 4096;        //FLASH_SIZE/FLASH_PAGE_SIZE; 
    Mass_Block_Size  = 512;         //FLASH_PAGE_SIZE; 
    Mass_Memory_Size = 0x200000;    //FLASH_SIZE; 
} 

/*********************************  END OF FILE  ******************************/
