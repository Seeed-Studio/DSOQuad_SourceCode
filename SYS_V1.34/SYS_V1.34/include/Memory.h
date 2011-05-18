/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : Memory.h  
 Version   : DS203_SYS Ver 1.2x                                 Author : bure
*******************************************************************************/
#ifndef __MEMORY_H
#define __MEMORY_H

#include "stm32f10x_lib.h"

#define TXFR_IDLE     0
#define TXFR_ONGOING  1

void Write_Memory (u32 Memory_Offset, u32 Transfer_Length);
void Read_Memory (u32 Memory_Offset, u32 Transfer_Length);

#endif 
/********************************* END OF FILE ********************************/
