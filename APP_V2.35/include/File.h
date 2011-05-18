/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : file.h  
 Version   : DS203_APP Ver 2.3x                                  Author : bure
*******************************************************************************/
#ifndef __FILE_H
#define __FILE_H

#include "stm32f10x_lib.h"

#define FLASH_WAIT_TIMEOUT      100000 
#define PAGE_0                  0 
#define PAGE_1                  1 
#define PAGE_2                  2 
#define PAGE_3                  3 

extern u32 DiskStart, Hidden_Sec, Root_Addr, ClusterNum, File_Addr;
extern u8  FileBuff[1200], SecBuff[512];

u8 Open_File(u8 FileNum, u8 *ExtName);
u8 Save_Bmp(u8 FileNum);
u8 Color_Num(u16 Color);
u8 Load_Parameter(void);
u8 Save_Parameter(u8 Default);
u8 Save_Dat(u8 FileNum);
u8 Load_Dat(u8 FileNum);
#endif
/********************************* END OF FILE ********************************/
