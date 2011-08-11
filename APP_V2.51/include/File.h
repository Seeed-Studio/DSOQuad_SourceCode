/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : file.h  
 Version   : DS203_APP Ver 2.5x                                  Author : bure
*******************************************************************************/
#ifndef __FILE_H
#define __FILE_H

#include "stm32f10x_lib.h"

#define FLASH_WAIT_TIMEOUT      100000 
#define PAGE_0                  0 
#define PAGE_1                  1 
#define PAGE_2                  2 
#define PAGE_3                  3 

#define OK           0            // 操作完成
#define SEC_ERR      1            // 扇区读写错误
#define FAT_ERR      2            // FAT表读写错误
#define OVER         3            // 操作溢出
#define NEW          4            // 空白/新目录项
#define EMPT         4            // 文件不存在
#define VER_ERR      5            // 版本错误
#define SUM_ERR      6            // 校验和错误
#define RD_ERR       8            // 扇区读错误
#define WR_ERR       9            // 扇区写错误
#define DISK_ERR     10           // 磁盘错误

extern u8  FileBuff[1200];

u8 Save_Bmp(u8 FileNum);
u8 Color_Num(u16 Color);
u8 Load_Param(void);
u8 Save_Param(void);
u8 Save_Dat(u8 FileNum);
u8 Load_Dat(u8 FileNum);
u8 Save_Buf(u8 FileNum);
u8 Load_Buf(u8 FileNum);
u8 Save_Csv(u8 FileNum);
u8 Make_Filename(u8 FileNum,u8* FileName);
void reset_parameter(void);
#endif
/********************************* END OF FILE ********************************/
