/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : SPI_flash.h  
 Version   : DS203_SYS Ver 1.2x                                 Author : bure
*******************************************************************************/
#ifndef __SPI_FLASH_H
#define __SPI_FLASH_H

#include "stm32f10x_lib.h"

#define SPI_FLASH_PageSize 256

#define WREN       0x06  // Write enable instruction 
#define READ       0x03  // Read from Memory instruction 
#define RDSR       0x05  // Read Status Register instruction  
#define PP         0x02  // Write to Memory instruction 
#define PE         0xDB  // Page Erase instruction 
#define PW         0x0A  // Page write instruction 
#define DP         0xB9  // Deep power-down instruction 
#define RDP        0xAB  // Release from deep power-down instruction 

#define WIP_Flag   0x01  // Write In Progress (WIP) flag 
#define Dummy_Byte 0xA5

#define SPI_FLASH_CS_LOW()     GPIO_ResetBits(GPIOB, GPIO_Pin_7)
#define SPI_FLASH_CS_HIGH()    GPIO_SetBits(GPIOB, GPIO_Pin_7)

void SPI_FLASH_PageErase(u32 PageAddr);
void SPI_FLASH_PageWrite(u8* pBuffer, u32 WriteAddr);
void SPI_FLASH_BufferRead(u8* pBuffer, u32 ReadAddr, u16 NumByteToRead);
void MAL_GetStatus (void);
u8   SPI_FLASH_ReadByte(void);
u8   SPI_FLASH_SendByte(u8 byte);
void SPI_FLASH_WriteEnable(void);
void SPI_FLASH_WaitForWriteEnd(void);
void Param_PageWrite(u8* pBuffer, u8 PageNum);
void Param_PageRead(u8* pBuffer, u8 PageNum);

#endif

/*********************************  END OF FILE  ******************************/
