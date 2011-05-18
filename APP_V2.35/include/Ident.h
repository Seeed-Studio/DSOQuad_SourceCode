/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : Authenticate.h  
 Version   : DS203_APP Ver 2.3x                          Author : kewei & bure
*******************************************************************************/
#ifndef __AUTHENTICATE_H
#define __AUTHENTICATE_H

#include "stm32f10x_lib.h"

#define LICENCE_CTRL_DEMO

#ifdef LICENCE_CTRL_DEMO
  #define DEVELOPER_ID      0x87654321
  #define PROJECT_ID        0x12345678
  #define DEMOCNT           64
#endif

#define SYS_LIC_OFFSET      0
#define REC_BASE            0x08003800

#define WAIT_TIMES          100000 
#define PAGE_SIZE           0x0800

#define SN_START1   10
#define SN_STOP1    21
#define SN_START2   53
#define SN_STOP2    67
#define ID_START1   17
#define ID_STOP1    31
#define ID_START2   71
#define ID_STOP2    87
#define Param_PAGE  0

extern vu8  Key_Buffer, Twink;

u8   Chk_DemoCnt(u16 Offset, u32 Sec_Cnt);
u32  Get_Lic(u16 Offset);
u16  Seek_Proj(u32 Proj_ID);
u16  Seek_Blank(void);
u32  Input_Lic(u16 x0, u8 y0); 

u8   Add_Proj(u32 ProjectID, u16 Offset); 
u8   Add_Str(u32 ProjStrAddr, u16 Offset); 
u8   Add_Cnt(u8 DemoCnt, u16 Offset);
u8   Add_Lic(u32 LicenceNo, u32 Offsaet); 

u32  Input_Lic(u16 x0, u8 y0); // Return: 32Bits Lic 

#endif

/********************************* END OF FILE ********************************/
