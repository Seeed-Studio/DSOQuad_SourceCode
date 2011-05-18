/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : file.c  
 Version   : DS203_APP Ver 2.3x                                  Author : bure
*******************************************************************************/
#include <string.h>
#include "Interrupt.h"
#include "Function.h"
#include "Process.h"
#include "BIOS.h"
#include "File.h"
#include "Draw.h"
#include "Menu.h"

/*******************************************************************************

U盘导引扇区内容：0x00      如果为 0xEB 或 0xE9 则表示该扇区同时也是逻辑分区零扇区
                 0x01C6~0x01C9 4字节为逻辑分区开始位置（高位在后）  DiskStart    

分区零扇区内容：0x000B,0x000C 2字节该盘扇区字节长度（高位在后）    SectorsLen   
                       0x000D 1字节该盘每簇的扇区数（2的整数次幂） SecPerClus   
                0x000E,0x000F 2字节该盘的保留扇区数（高位在后）    RsvdSecCnt    
（FAT16）       0x0016,0x0017 2字节 FAT占用的扇区数（高位在后）    FAT_Size16   FAT32时该值为 0x0000
                0x001C~0x001F 4字节该盘的隐藏扇区数（高位在后）    Hidden_Sec    
（FAT32）       0x0024,0x0025 2字节 FAT占用的扇区数（高位在后）    FAT_Size32   

FAT表的长度(length of FAT)   ：FAT_LEN   = FAT_Size16 ×SectorsLen           
FAT1开始扇区(addr of FAT1)  ：FAT1_Sect = DiskStart + RsvdSecCnt           
FAT2开始扇区 (addr of FAT2) ：FAT2_Sect = FAT1_Sect + FAT_Size16           
根目录开始扇区(Section of root catalogue)：Root_Sect = FAT2_Sect + FAT_Size16           
根目录开始地址(addr of root catalogue)：Root_Addr = Root_Sect ×SectorsLen   

根目录扇区内容：        Root_Addr + 0x0020 开始，每条目录项长度为 0x20，//Each catalogue length is 0x20
(Root catalogue details:)FAT16根目录占用扇区数 SecPerRoot = 0x20 //Sections for root catalogue of fat16
                          FAT32根目录占用扇区数 SecPerRoot = 0x01 × SecPerClus //Sections for root catalogue of fat32

目录项中的内容：      0x00~0x07 8字节文件名  //8 bytes filename 
(catalogue details:)  0x08~0x0A 3字节扩展名   //3 bytes extroname
                      0x16,0x17 2字节最近修改时间（ = Hour << 11 + Minute << 5 + Second >> 1 ）//2 bytes modified time
                      0x18,0x19 2字节最近修改日期（ =（ Year - 1980 ）<< 9 + Month << 5 + Day ）//2 bytes modified date
        （FAT32）     0x14,0x15 文件开始簇号Bit 16~31（高位字节在后）Cluster_Hi//Cluster_hi for files
        （FAT16）     0x1A,0x1B 文件开始簇号Bit  0~15（高位字节在后）Cluster     0x12E5//Cluster_low for files
                      0x1C-0x1F 4字节的文件字节长度 （高位在后）//4 bytes file length
                  
文件开始地址  ：File_Addr =（ Root_Sect + SecPerRoot +（Cluster -0x02）×SecPerClus ）×Sectors_LEN

*******************************************************************************/
u32 DiskStart, Hidden_Sec, Root_Addr, ClusterNum, File_Addr, File_Size; 
u16 RsvdSecCnt, SectorSize, FAT_Size16, FAT_Size32; 
u16 SecPerClus, /*DirFliePtr, DirFlieSec, */DirSecNum, MaxNum;
u8  SecBuff[512];
u8  FileBuff[1200];
u32 Offset, Count;
u16 BMP_Color[16] = { WHT,  CYAN,  CYAN_,  YEL,   
                      YEL_, PURPL, PURPL_, GRN,    
                      GRN_, GRAY,  ORANGE, BLUE,    
                      RED,  BLACK, BLACK,  BLACK,}; 

  
#define WHT        0xFFFF
#define CYAN       0xFFE0
#define CYAN_      0xBDE0
#define YEL        0x07FF
#define YEL_       0x05F7
#define PURPL      0xF81F
#define PURPL_     0xB817
#define GRN        0x07E0
#define GRN_       0x05E0
#define GRAY       0x7BEF   
#define ORANGE     0x051F
#define BLUE       0xF800
#define RED        0x001F
#define BLACK      0x0000

/*******************************************************************************
 打开指定扩展名的文件            输入：文件扩展名             返回值：0x00=成功 
Open the files with specified extro name         INPUT:extroname     RETURN VALUE: 0x00=SUCCESS
*******************************************************************************/
u8 Open_File(u8 FileNum, u8 *ExtName)
{
  u8 i, j, k; 
  u16 SectorCnt;
  u8 FileName[12]="FILE    BMP", Num[4];
  
               // ------------生成文件名------------ //   
              //------------Generate file name--------//
  u8ToDec3(Num, FileNum);
  FileName[4] = Num[0];
  FileName[5] = Num[1];
  FileName[6] = Num[2];
  FileName[8] = ExtName[0];
  FileName[9] = ExtName[1];
  FileName[10]= ExtName[2];
  
               // ------------读取U盘参数----------- //  
                 //------------Read the parameter of USB disk---//
  DiskStart =0;
  DirSecNum = 0x20;             
  __Disk_Buff_RD(SecBuff, 0, 256);
  SectorSize =(SecBuff[0x0C]<<8)+(SecBuff[0x0B]);     // 0200
  SecPerClus = SecBuff[0x0D];                            // 01
  RsvdSecCnt =(SecBuff[0x0F]<<8)+(SecBuff[0x0E]);     // 0008
  FAT_Size16 =(SecBuff[0x17]<<8)+(SecBuff[0x16]);     // 000C
  Hidden_Sec =(SecBuff[0x1F]<<24)+(SecBuff[0x1E]<<16)
    +(SecBuff[0x1D]<<8)+(SecBuff[0x1C]);              // 0000

               // ------------读取根目录----------- //  
  //-------------Read the root catalogue------//
  Root_Addr =(DiskStart + RsvdSecCnt + 2*FAT_Size16)*SectorSize; // 4000 
  __Disk_Buff_RD(SecBuff, Root_Addr, 512);

               // ------------查找文件名----------- //  
        //-------------Seek the file name--------//
  for(SectorCnt =0; SectorCnt < DirSecNum; SectorCnt++){
    __Disk_Buff_RD(SecBuff, Root_Addr + SectorCnt*512, 512);
    for(i=0; i<16; i++){
      if(SecBuff[i*32] == 0xE5)  k = 0xFF;  // 已删除的文件项//Files deleted
      else                       k = 0;     // 正常的文件项 //Files normal
      for(j=0; j<11; j++){
        if(SecBuff[i*32+j] != FileName[j])  k |= 0xFF; // 
      }
      if(k == 0) {                              // File is found
        
               // ------计算文件大小及存放地址----- // 
              //-------Cal the file size and address---//
        ClusterNum =((SecBuff[i*32+0x1B]<<8)+(SecBuff[i*32+0x1A])); // 00E5
        File_Addr  = Root_Addr +(DirSecNum +(ClusterNum -2)*SecPerClus)*512;// 4000+(20+(E5-2))*200
        File_Size  =((SecBuff[i*32+0x1C])+(SecBuff[i*32+0x1D]<<8)+
                    (SecBuff[i*32+0x1E]<<16)+(SecBuff[i*32+0x1F]<<24));
        return 0;
      }
    }
  }
  return 0xFF;
}
/*******************************************************************************
Save_Dat: 保存当前屏幕显示图像原始数据    输入：文件编号     返回值：0x00=成功 
	Save the data of waveform     INPUT: File NO.     RETURN: 0x00=Success
*******************************************************************************/
u8 Save_Dat(u8 FileNum)
{
  u16 i, j, Rvalue; 
  
  Rvalue = Open_File(FileNum, "DAT");  // 2 KB data lenght : 4 *300 = 1.2KBytes
  if(Rvalue != 0) return Rvalue;
  
  for(j=0; j<4; j++){
    for(i=0; i<299; i++){
      SecBuff[i] = TrackBuff[i*4 + j];
    }
    SecBuff[299] = Title[j][POSI].Value;
    __Disk_Buff_WR(SecBuff, File_Addr + j*512);
    __Disk_Buff_WR(SecBuff + 256, File_Addr + 256 +j*512);
  }
  
  return 0;
}
/*******************************************************************************
Load_Dat: 加载保存过的屏幕图像原始数据    输入：文件编号     返回值：0x00=成功 
          load the data  in USB disk               INPUT:File NO.       RETUREN:0x00 = Success
*******************************************************************************/
u8 Load_Dat(u8 FileNum)
{
  u16  Rvalue;

  Rvalue = Open_File(FileNum, "DAT");  // 2 KB data lenght : 4 *300 = 1.2KBytes
  if(Rvalue != 0) return Rvalue;
  
  __Disk_Buff_RD(FileBuff,         File_Addr,     300);
  
  __Disk_Buff_RD(FileBuff+300,     File_Addr+2*256, 300);

  __Disk_Buff_RD(FileBuff+600,     File_Addr+4*256, 300);

  __Disk_Buff_RD(FileBuff+900,     File_Addr+6*256, 300);
  
  return 0;
}
/*******************************************************************************
Save_Bmp: 保存当前屏幕显示图像为BMP格式    输入：文件编号     返回值：0x00=成功 
          Save the current Waveform as .BMP file INPUT:File No. RETURN:0x00=Success
*******************************************************************************/
u8 Save_Bmp(u8 FileNum)
{
  u16  x=0, y=0, ColorH, ColorL, Rvalue;
  u8   i, j, k; 

  Rvalue = Open_File(FileNum, "BMP");  // 47 KB data lenght = 256*188 = 48128 Bytes
  if(Rvalue != 0) return Rvalue;
  __Disk_Buff_RD(SecBuff, File_Addr, 256);
  
  i = 0x0036; // 调色板存放开始地址//Address of the assemble color 
  for(j=0; j<16; ++j){
    SecBuff[j*4 +i+0]=(BMP_Color[j]& 0xF800)>>8; // Bule
    SecBuff[j*4 +i+1]=(BMP_Color[j]& 0x07E0)>>3; // Green
    SecBuff[j*4 +i+2]=(BMP_Color[j]& 0x001F)<<3; // Red
    SecBuff[j*4 +i+3]= 0;                        // Alpha
  }
  i = 0x0076; // 图像数据开始存放地址//Address to save the .bmp
  k = 0;
  for(y=0; y<240; y++){
    for(x=0; x<400 ; x+=2){  
      __Point_SCR(x, y);
      ColorH =__LCD_GetPixl();
      __Point_SCR(x+1, y);
      ColorL =__LCD_GetPixl();
      SecBuff[i] =(Color_Num(ColorH)<<4)+ Color_Num(ColorL);
      i++;
      if(i==0){
        __Disk_Buff_WR(SecBuff, File_Addr +(k <<8));
        Print_Clk(254, 0, (SCRN<<8)+ TEXT1, (k >>2)& 3);    // 进度指示 // Progress indicator
        k++;
      }
    }
  }
  __Disk_Buff_WR(SecBuff, File_Addr +(k <<8));
  return 0;
}
u8 Color_Num(u16 Color)
{
  if(Color == WHT)                   return 0;
  else if((Color & CYAN  )== CYAN  ) return 1;
  else if((Color & YEL   )== YEL   ) return 3;
  else if((Color & PURPL )== PURPL ) return 5;
  else if((Color & GRN   )== GRN   ) return 7;
  else if((Color & CYAN_ )== CYAN_ ) return 2;
  else if((Color & YEL_  )== YEL_  ) return 4;
  else if((Color & PURPL_)== PURPL_) return 6;
  else if((Color & GRN_  )== GRN_  ) return 8;
  else if((Color & GRAY  )== GRAY  ) return 9;
  else if((Color & ORANGE)== ORANGE) return 10;
  else if((Color & BLUE  )== BLUE  ) return 11;
  else if((Color & RED   )== RED   ) return 12;
  else                               return 13;
}
/*******************************************************************************
Load_Parameter: 加载之前的工作参数                           Return: 0= Success
                Load the Parameter in flash.	
*******************************************************************************/
u8 Load_Parameter(void)            // 参数区共有4页，每页 256 Byte//  4 Pages of flash for parameters , 256 byte in each page.
{ 
  u8 Versions =0x03, Sum =0;
  u16 i;
  u16* p = (u16*)SecBuff;
  
  __Param_Area_RD(SecBuff, PAGE_0);
 
  if(Versions !=(*p & 0xFF)) return 1;          // 版本出错返回// ERROR of Version 
  for(i=0; i<256; ++i) Sum += SecBuff[i];
  if(Sum != 0) return 2;                  // 校验和出错返回// ERROR of checkout
  
  Current =(*p++ >>8);                    // 加载之前的 Current Title //Load previous Current Title
  
  for(i=0; i<7; i++){ 
    Detail[i*2]  = *p;
    Detail[i*2+1]= (*p++ >>8);             // 加载之前的 Detail//Load previous Detail
  }
  for(i=0; i<13; i++){
    Title[i][0].Value = *p++;             // 加载之前的显示菜单中各个对应项的值//Load the data of submenu of each menu
    Title[i][1].Value = *p++;
    Title[i][2].Value = *p++;
    Title[i][3].Value = *p++;
  }
  for(i=0; i<9; i++){
    Meter[i].Item     = *p;
    Meter[i].Track    =(*p++ >>8);        // 加载之前的测量项目及测量对象//Load the  previous measured items.
  }
  for(i=0; i<10; i++){
    Ka1[i] = *p;                         // 恢复原来的 A 通道零点误差校正系数//Reload CHA Calibrate factor in base point
    Kb1[i] =(*p++ >>8);                  // 恢复原来的 B 通道零点误差校正系数//Reload CHB Calibrate factor in base point
    Ka2[i] = *p++;                       // 恢复原来的 A 通道增益误差校正系数//Reload CHA Calibrate factor for gain
    Kb2[i] = *p++;                       // 加载之前的 B 通道增益误差校正系数//Reload CHB Calibrate factor for gain
  }
  Ka3 = *p++;                            // 恢复原来的 A 通道位移误差校正系数//Reload Calibrate factor for offset of CHA
  Kb3 = *p++;                            // 恢复原来的 B 通道位移误差校正系数//Reload Calibrate factor for offset of CHB

  V_Trigg[A].Value = *p++;
  V_Trigg[B].Value = *p++;               // 恢复原来A,B通道触发阈值// Reload Trigger threshhold of channelA and B
  
  return 0;
}
/*******************************************************************************
 Save_Parameter: 保存当前的工作参数                          Return: 0= Success
*******************************************************************************/
u8 Save_Parameter(u8 Default)             // 参数区共有4页，每页 256 Byte //4 pages flash for parameter ,256 bytes for each page.
{                                          // 目前只用了第0页//Only the section 0 was used yet
  u8 Versions =0x03, Sum =0;
  u16* p =(u16*)SecBuff;
  u16  i;
  
  memset(SecBuff,0,256);  
  
  if(Default) Versions =0xFF;
  *p++ =(Current <<8)+ Versions;            // 保存参数版本号及当前的 Title //Version of parameter and current Title
  
  for(i=0; i<7; i++) 
    *p++ =(Detail[i*2+1]<<8)+ Detail[i*2]; // 保存当前的 Detail//Save the Current Detail
  
  for(i=0; i<13; i++){                     // 保存显示菜单中各个对应项的值//Save the value for each submemu
    *p++ = Title[i][0].Value;
    *p++ = Title[i][1].Value;
    *p++ = Title[i][2].Value;
    *p++ = Title[i][3].Value;
  }
  for(i=0; i<9; i++){
    *p++ =(Meter[i].Track<<8)+ Meter[i].Item; // 保存测量项目及测量对象//Save the current measure item
  }
  for(i=0; i<10; i++){
    *p++ =(Kb1[i]<<8)+ Ka1[i];             // 保存当前 A,B 通道零点误差校正系数//Save Calibrate factor in base point for CHA and CHB
    *p++ = Ka2[i];                         // 保存当前 A 通道增益误差校正系数//Save Calibrate factor for gain of CHA
    *p++ = Kb2[i];                         // 保存当前 B 通道增益误差校正系数//Save Calibrate factor for gain of CHB
  }
  *p++ = Ka3;                              // 保存当前 A 通道位移误差校正系数//Save Calibrate factor for offset of CHA
  *p++ = Kb3;                              // 保存当前 B 通道位移误差校正系数//Save Calibrate factor for offset of CHB
  
  *p++ = V_Trigg[A].Value;
  *p++ = V_Trigg[B].Value;                 // 保存当前A,B通道触发阈值  // Save Trigger threshhold of channelA and B
   
  
  for(i=0; i<255; i++)  Sum += SecBuff[i]; //计算参数区校验和// Cal. the key value for the parameter area.
  SecBuff[255] = (~Sum)+ 1;
  __Param_Area_WR(SecBuff, PAGE_0); 
  return 0;
}

/******************************** END OF FILE *********************************/

