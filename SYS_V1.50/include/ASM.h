/******************** (C) COPYRIGHT 2009 e-Design Co.,Ltd. *********************
 File Name : ASM.h       
 Version   : DS203_SYS Ver 1.5x                                 Author : bure
*******************************************************************************/

#ifndef __ASM_H
#define __ASM_H

#include "stm32f10x_lib.h"

//==============================================================================
//                        System function entrance
//==============================================================================
 void __LCD_DMA_Ready(void);                    // Wait LCD data DMA ready
 void __LCD_WR_Row(uc16 *pBuffer,u8 NumPixel);  // Send a row data to LCD
 void __LCD_Fill(u16 *pBuffer,u16 NumPixel);    // Fill number of pixel by DMA 
 void __Row_DMA_Ready(void);                    // Wait row base data DMA ready
 void __Row_Copy(uc16 *S_Buffer,u16 *T_Buffer); // Copy one row base data to buffer
 void __Row_Fill(uc16 *S_Buffer,u16 *T_Buffer); // Fill one row base data to buffer
 u32  __Read_FIFO(void);  
 void __LCD_Initial(void);
 void __Position(u16 x0, u16 y0);
 void __Point_SCR(u16 x0, u16 y0);
 void __LCD_SetPixl(u16 Color);
 void __Clear_Screen(u16 Color);
 u16  __Get_TAB_8x14(u8 Code, u16 Row);
 void __LCD_Set_Block(u16 x1, u16 x2, u16 y1, u16 y2);
 
 
 u32  __Dev_SN(void);                        // Get 32bits Device Serial Number
 u8   __Ident(u32 Dev_ID, u32 Proj_ID, u32 Lic_No);
 u8   __Chk_SYS(u32 Licence);
 u8*  __Chk_DFU(void);
 u8*  __Chk_HDW(void);
 
 u32  __Input_Lic(u16 x0, u8 y0); //Return: 32Bits Licence 
 u8   __Add_Lic(u32 ProjectID, u32 LicenceNo, u8 DemoRunCnt, u8 *Str22);  // Add a new Licence recoed 
 u8   __Chk_Lic(u32 Vender_ID, u32 Proj_ID); // Return: DemoRunCnt (0xFF: Unlimit, 0x00: Locked, 1~254: Counter)
 void __CTR_HP(void);     //USB_HP_Interrupt
 void __USB_Istr(void);   //USB_LP_Interrupt
 u16  __Get(u8 Kind);
 void __Set_Param(u8 RegAddr, u8 Parameter); 
 void __Set(u8 Object, u32 Value);
 void __ExtFlash_PageRD(u8* pBuffer, u32 ReadAddr, u16 NumByteToRead);
 void __ExtFlash_PageWR(u8* pBuffer, u32 WriteAddr);

 u16  __LCD_GetPixl(void);  
 void __USB_Init(void);

 u8 __ReadDiskData(u8* pBuffer, u32 ReadAddr, u16 Lenght);
 u8 __ProgDiskPage(u8* pBuffer, u32 ProgAddr);
 u8 __OpenFileWr(u8* Buffer, u8* FileName, u16* Cluster, u32* pDirAddr);
 u8 __OpenFileRd(u8* Buffer, u8* FileName, u16* Cluster, u32* pDirAddr);
 u8 __ReadFileSec(u8* Buffer, u16* Cluster);
 u8 __ProgFileSec(u8* Buffer, u16* Cluster);
 u8 __CloseFile(u8* Buffer, u32 Lenght, u16* Cluster, u32* pDirAddr);


#endif /* __ASM_H */

//****************************** END OF FILE ***********************************
