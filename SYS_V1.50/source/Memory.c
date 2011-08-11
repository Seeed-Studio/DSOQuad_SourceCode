/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : Memory.c  
 Version   : DS203_SYS Ver 1.5x                                  Author : bure
*******************************************************************************/
#include "Ext_Flash.h"
#include "USB_scsi.h"
#include "USB_regs.h"
#include "USB_conf.h"
#include "USB_bot.h"
#include "USB_mem.h"
#include "Config.h"
#include "Memory.h"
#include "BIOS.h"
#include "ASM.h"

vu32 Block_Read_count = 0;
vu32 Block_offset;
vu32 Counter = 0;
u32  Idx;
u8 Data_Buffer[512+256]; 
u8 TransferState = TXFR_IDLE;

extern u8 Bulk_Data_Buff[BULK_MAX_PACKET_SIZE];  /* data buffer*/
extern u16 Data_Len;
extern u8 Bot_State;
extern Bulk_Only_CBW CBW;
extern Bulk_Only_CSW CSW;
extern u32 Mass_Memory_Size;
extern u32 Mass_Block_Size;

/*******************************************************************************
* Function Name  : Read_Memory
* Description    : Handle the Read operation from the microSD card.
*******************************************************************************/
void Read_Memory(u32 Memory_Offset, u32 Transfer_Length)
{
  static u32 Offset, Length;

  if (TransferState == TXFR_IDLE )
  {
    Offset = Memory_Offset * Mass_Block_Size;
    Length = Transfer_Length * Mass_Block_Size;
    TransferState = TXFR_ONGOING;
  }

  if (TransferState == TXFR_ONGOING )
  {
    if (!Block_Read_count)
    {
      Clash = 1;
      __ExtFlash_PageRD(Data_Buffer, Offset, Mass_Block_Size);           
      UserToPMABufferCopy((u8 *)Data_Buffer, ENDP1_TXADDR, BULK_MAX_PACKET_SIZE);
      Block_Read_count = Mass_Block_Size - BULK_MAX_PACKET_SIZE;
      Block_offset = BULK_MAX_PACKET_SIZE;
    }
    else
    {
      UserToPMABufferCopy((u8 *)Data_Buffer + Block_offset, ENDP1_TXADDR, BULK_MAX_PACKET_SIZE);
      Block_Read_count -= BULK_MAX_PACKET_SIZE;
      Block_offset += BULK_MAX_PACKET_SIZE;
    }

    SetEPTxCount(ENDP1, BULK_MAX_PACKET_SIZE);
    SetEPTxStatus(ENDP1, EP_TX_VALID);
    Offset += BULK_MAX_PACKET_SIZE;
    Length -= BULK_MAX_PACKET_SIZE;

    CSW.dDataResidue -= BULK_MAX_PACKET_SIZE;
  }
  if (Length == 0)
  {
    Block_Read_count = 0;
    Block_offset = 0;
    Offset = 0;
    Bot_State = BOT_DATA_IN_LAST;
    TransferState = TXFR_IDLE;
  }
}
/*******************************************************************************
* Function Name  : Write_Memory
* Description    : Handle the Write operation to the microSD card.
*******************************************************************************/
void Write_Memory (u32 Memory_Offset, u32 Transfer_Length)
{

  static u32 W_Offset, W_Length;

  u32 temp =  Counter + 64;

  if (TransferState == TXFR_IDLE )
  {
    W_Offset = Memory_Offset * Mass_Block_Size;
    W_Length = Transfer_Length * Mass_Block_Size;
    TransferState = TXFR_ONGOING;
  }

  if (TransferState == TXFR_ONGOING )
  {

    for (Idx = 0 ; Counter < temp; Counter++)
    {
      *((u8 *)Data_Buffer + Counter) = Bulk_Data_Buff[Idx++];
    }

    W_Offset += Data_Len;
    W_Length -= Data_Len;

    if (!(W_Length % Mass_Block_Size))
    {
      Counter = 0;
      Clash = 1;
      __ExtFlash_PageWR(Data_Buffer, W_Offset - Mass_Block_Size);  
      __ExtFlash_PageWR(Data_Buffer + EXT_FLASH_PageSize, W_Offset - EXT_FLASH_PageSize);  
    }

    CSW.dDataResidue -= Data_Len;
    SetEPRxStatus(ENDP2, EP_RX_VALID); /* enable the next transaction*/

  }

  if ((W_Length == 0) || (Bot_State == BOT_CSW_Send))
  {
    Counter = 0;
    Set_CSW (CSW_CMD_PASSED, SEND_CSW_ENABLE);
    TransferState = TXFR_IDLE;
  }
}
/******************************* END OF FILE **********************************/

