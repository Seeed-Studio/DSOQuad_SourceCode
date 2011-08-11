/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : Authenticate.h  
 Version   : DS203_SYS Ver 1.02                          Author : kewei & bure
*******************************************************************************/
#ifndef __AUTHENTICATE_H
#define __AUTHENTICATE_H

#include "stm32f10x_lib.h"

#define REC_BASE          0x08003800
#define DEVELOPER_ID      0x87654321
#define PROJECT_ID        0x12345678
#define PAGE_SIZE         0x0800

#define WAIT_TIMES        100000 


#define SN_START1   10
#define SN_STOP1    21
#define SN_START2   53
#define SN_STOP2    67
#define ID_START1   17
#define ID_STOP1    31
#define ID_START2   71
#define ID_STOP2    87
#define Param_PAGE  0

u16  Add_Rec(u32 ProjectID, u8 DemoRunCnt, u8 *Str16); 
u8   Add_Lic(u32 ProjectID, u32 LicenceNo); 
u8   Seek_Lic(u32 LicenceNo, u32 Proj_ID);
u8   FLASH_Prog(u32 Address, u16 Data);    
void FLASH_Erase(u32 Address);    

u32  Dev_SN(void);    // Return: DeviceSN 
u8   Chk_Lic(u32 Vender_ID, u32 Proj_ID); // Return: 0=Ok, 1=None
void MulAdd(u32 Value, u8 a, u8 b);
u32  Create(u32 Lic, u32 Dev_SN, u32 Proj_ID);
//u32  Generate(u32 Vender_ID, u32 Proj_ID);
void Encode(u8 *Buffer);         // 32 Bytes buffer Encode
u32  Input_Lic(u16 x0, u8 y0, u16 Color); // Return: 32Bits Lic


#endif

/********************************* END OF FILE ********************************/
