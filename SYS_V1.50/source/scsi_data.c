/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : SCSI_data.c  
 Version   : DS203_SYS Ver 1.3x                                 Author : bure
*******************************************************************************/
#include "USB_scsi.h"
#include "Memory.h"

u8 Page00_Inquiry_Data[] ={    // PERIPHERAL QUALIFIER & PERIPHERAL DEVICE TYPE
    0x00, 0x00, 0x00, 0x00,
    0x00 };                    // Supported Pages 00
  
u8 Standard_Inquiry_Data[] ={
    0x00,                      // Direct Access Device 
    0x80,                      // RMB = 1: Removable Medium 
    0x02,                      // Version: No conformance claim to standard 
    0x02,
    36 - 4,                    // Additional Length 
    0x00,                      // SCCS = 1: Storage Controller Component 
    0x00,
    0x00,
    'M', 'i', 'n', 'i', '_', 'D', 'S', 'O',           // Vendor Identification 
    'F', 'l', 'a', 's', 'h', ' ', 'D', 'i', 's', 'k', // Product Identification
    ' ', ' ', ' ', ' ', ' ', ' ', ' ' 
};

u8 Mode_Sense6_data[] ={
    0x03, 0x00, 0x00, 0x00};

u8 Mode_Sense10_data[] ={
    0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

u8 Scsi_Sense_Data[] ={
    0x70,               //RespCode
    0x00,               //SegmentNumber
    NO_SENSE,           // Sens_Key
    0x00, 0x00, 0x00,
    0x00,               //Information
    0x0A,               //AdditionalSenseLength
    0x00, 0x00, 0x00,
    0x00,               //CmdInformation
    NO_SENSE,           //Asc
    0x00,               //ASCQ
    0x00,               //FRUC
    0x00,               //TBD
    0x00,
    0x00 };             //SenseKeySpecific
  
u8 ReadCapacity10_Data[] ={    // Last Logical Block 
    0, 0, 0, 0,                // Block Length 
    0, 0, 0, 0};
  
u8 ReadFormatCapacity_Data [] ={
    0x00, 0x00, 0x00, 0x08,    // Capacity List Length 
    0, 0, 0, 0,                // Block Count 
    0x02,// Block Length 
    0, 0, 0};// Descriptor Code: Formatted Media 

/*********************************  END OF FILE  ******************************/
