/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : Calibrat.c  
 Version   : DS203_APP Ver 2.3x                                  Author : bure
*******************************************************************************/
#include <string.h>
#include "Interrupt.h"
#include "Function.h"
#include "Calibrat.h"
#include "Process.h"
#include "File.h"
#include "BIOS.h"
#include "Menu.h"

uc8 VS_STR[9][12]={"250-300mV","0.5-0.6V ","1.0-1.2V ","2.5-3.0V ",
                   "5.0-6.0V "," 10-12V  "," 25-30V  "," 50-60V  ","suitable "};
uc8 ExitStr[3][30]={" Exit without Calibration ", 
                    "Exit with Save Calibration", 
                    "Exit with Restore Defaults"};
void Balance(void)
{
  __Set(STANDBY, DN);          // 退出省电状态
  __Set(ADC_CTRL, EN );       
  _Status = RUN;
  __Set(T_BASE_PSC, X_Attr[_2uS].PSC);                // T_BASE = 2uS
  __Set(T_BASE_ARR, X_Attr[_2uS].ARR);
  __Set(CH_A_COUPLE, DC);
  __Set(CH_A_OFFSET, 100);
  __Set(CH_B_COUPLE, DC);
  __Set(CH_B_OFFSET, 100);
  __Set(CH_A_RANGE,  G_Attr[0].Yp_Max);        // 10V/Div
  __Set(CH_B_RANGE,  G_Attr[0].Yp_Max+1);      // B通道合并到A通道
  __Set(ADC_MODE, INTERLACE);                  // Set Interlace mode
  Delayms(2000); 
  __Set(FIFO_CLR, W_PTR); 
  Delayms(20); 
  JumpCnt =0;
  Process();                                     // 采样波形处理   
//  Kab = 0;
  Kab = (a_Avg - b_Avg)/4096;
}
/*******************************************************************************
  Calibrat : Calibrat routine
*******************************************************************************/
void Calibrat(u8 Channel)
{ 
  u8  V_Unit[4][3]={"uV","mV","V ","kV"};
  u16 i, j, k, Range, Target;
  u8  Exit = 0;      

  I32STR_RES Num;
  
  Key_Buffer = 0; 
  __Set(STANDBY, DN);                                   // 退出省电状态
  __Set(BACKLIGHT, 10*(Title[BK_LIGHT][CLASS].Value+1));
  __Clear_Screen(BLACK);                                // 清屏幕
  
  k = Load_Parameter();                                 // 读取预设开机参数  
  Interlace = 0;
  __Set(ADC_MODE, SEPARATE);                        // Set Separate mode
  __Set(TRIGG_MODE, UNCONDITION);                       // 设任意触发
  __Set(ADC_CTRL, EN);       
  _Status = RUN;
  __Set(BEEP_VOLUME, 5*(Title[VOLUME][CLASS].Value-1)); // Reload volume
  Beep_mS = 500;                                        // 蜂鸣器响500mS
  Range = 0;
  if(Channel == TRACK1)  Target = 0;
  else                   Target = 3;
  Key_Buffer = 0; 
  
  __Set(T_BASE_PSC, X_Attr[_100uS].PSC);                // T_BASE = 100uS
  __Set(T_BASE_ARR, X_Attr[_100uS].ARR);

  __Set(CH_A_COUPLE, DC);
  __Set(CH_A_OFFSET, 5);
  __Set(CH_B_COUPLE, DC);
  __Set(CH_B_OFFSET, 5);
  
  
  for(j=0; j<220; j+=20){                               // 画表格  
    for(i=0; i<399; i++){
      __Point_SCR(i, j);
      __LCD_SetPixl(WHT);
    }
  }
  for(i=0; i<399; i++){
    __Point_SCR(i, 239);
    __LCD_SetPixl(WHT);
  }
  __Point_SCR(  0,  0);
  for(j= 0; j<239; j++)  __LCD_SetPixl(WHT); 
  __Point_SCR( 44, 20);
  for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
  __Point_SCR( 88, 20);
  for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
  __Point_SCR(132, 20);
  for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
  __Point_SCR(200, 20);
  for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
  __Point_SCR(244, 20);
  for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
  __Point_SCR(288, 20);
  for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
  __Point_SCR(332, 20);
  for(j=20; j<201; j++)  __LCD_SetPixl(WHT); 
  __Point_SCR(398, 0);
  for(j= 0; j<239; j++)  __LCD_SetPixl(WHT); 
 
  Print_Str(  6, 185, 0x0005, PRN, "CH_A");              // 显示表格标题栏
  Print_Str( 49, 185, 0x0005, PRN, "ZERO");
  Print_Str( 93, 185, 0x0005, PRN, "DIFF");
  Print_Str(141, 185, 0x0005, PRN, "VOTAGE");
  Print_Str(206, 185, 0x0105, PRN, "CH_B");
  Print_Str(249, 185, 0x0105, PRN, "ZERO");
  Print_Str(293, 185, 0x0105, PRN, "DIFF");
  Print_Str(342, 185, 0x0105, PRN, "VOTAGE");
    
  for(i=0; i<G_Attr[0].Yp_Max+1; i++){
    Print_Str(  6, 166-(i*20), 0x0005, PRN, Y_Attr[i].STR);
    Print_Str(206, 166-(i*20), 0x0105, PRN, Y_Attr[i].STR);
  }
  Print_Str( 10, 166-(8*20), 0x0405, PRN, (u8*)ExitStr[Exit % 3]);

  if(k != 0) {
    Print_Str( 32, 216, 0x0405, PRN, "         Parameters version error          ");
    __Set(BEEP_VOLUME, 5*(Title[VOLUME][CLASS].Value-1));// Volume
    Beep_mS = 500;                                       // 蜂鸣器响500mS
    Delayms(2000); 
    App_init();
    return;
  }
  while (1){
    if(PD_Cnt == 0){
      __Set(BACKLIGHT, 0);                         // 关闭背光
      __Set(STANDBY, EN);                          // 进入省电状态
      return;
    }
    JumpCnt =0;
    Process();                                     // 采样波形处理   
    if((Target == 1)||(Target == 4)){ 
      A_Vdc = Ka1[Range] +(Ka2[Range]*(a_Avg/4096))/1024 - 195;      
      B_Vdc = Kb1[Range] +(Kb2[Range]*(b_Avg/4096))/1024 - 195;      
    } else {
      A_Vdc = Ka1[Range] +(Ka2[Range]*(a_Avg/4096))/1024 - 5;      
      B_Vdc = Kb1[Range] +(Kb2[Range]*(b_Avg/4096))/1024 - 5;     
    }
//    if(__Get(FIFO_FULL))  __Set(FIFO_CLR, W_PTR); // FIFO写指针复位 

    if(Key_Buffer) { 
      PD_Cnt = 600;                               // 600秒
      if(Range <= G_Attr[0].Yp_Max){
      switch (Target){  
      case 0:
        Int32String_sign(&Num, A_Vdc);
        Print_Str( 45, 166-(Range*20), 0x0005, PRN, Num.str);
        break;
      case 1:
        Int32String_sign(&Num, A_Vdc);
        Print_Str( 89, 166-(Range*20), 0x0005, PRN, Num.str);
        break;
      case 2:
        Int32String_sign(&Num, A_Vdc * Y_Attr[Range].SCALE);
        Print_Str(134, 166-(Range*20), 0x0005, PRN, Num.str);
        Print_Str(174, 166-(Range*20), 0x0005, PRN, V_Unit[Num.decPos]);
        break;
      case 3:
        Int32String_sign(&Num, B_Vdc);
        Print_Str(245, 166-(Range*20), 0x0105, PRN, Num.str);
        break;
      case 4:
        Int32String_sign(&Num, B_Vdc);
        Print_Str(289, 166-(Range*20), 0x0105, PRN, Num.str);
        break;
      case 5:
        Int32String_sign(&Num, B_Vdc * Y_Attr[Range].SCALE);
        Print_Str(334, 166-(Range*20), 0x0105, PRN, Num.str);
        Print_Str(374, 166-(Range*20), 0x0105, PRN, V_Unit[Num.decPos]);
      }
      }
      switch (Key_Buffer){  
      case KEY2:
        if(Range > G_Attr[0].Yp_Max){
          if(Exit == 1){
            Save_Parameter(0);                         // 保存校正后的参数
            Print_Str( 32, 216, 0x0405, PRN, "         Save the calibration data         ");
            Delayms(1000); 
          }
          if(Exit == 2){
            for(i=0; i<=G_Attr[0].Yp_Max; i++){
              Ka1[i]=0;
              Kb1[i]=0;
              Ka2[i]=1024;
              Kb2[i]=1024;
            }
            Ka3=256;
            Kb3=256;
            Save_Parameter(0);                         // 保存缺省值参数
            Print_Str( 32, 216, 0x0405, PRN, "           Restore defaults data           ");
            Delayms(1000); 
          }
          App_init();
          return;
        }
        break;
      case K_ITEM_S:
        if(Channel == TRACK1){  
          if(Target <2) Target = 2;
          else          Target = 0;
        } else {
          if(Target <5) Target = 5;
          else          Target = 3;
        }
        break;
      case K_INDEX_S:
        if(Channel == TRACK1){  
          if((Target <1)&&(Range == 0)) Target = 1;
          else if(Target <2) Target = 0;
        } else {
          if((Target <4)&&(Range == 0)) Target = 4;
          else if(Target <5) Target = 3;
        }
        break;
      case K_ITEM_DEC:
        if(Range >0) Range--;
        if(Target == 1) Target = 0;  
        if(Target == 4) Target = 3;  
        break;
      case K_ITEM_INC:
        if(Range  <= G_Attr[0].Yp_Max) Range++;
        if(Target == 1) Target = 0;  
        if(Target == 4) Target = 3;  
        break;
      case K_INDEX_DEC:
        if(Range <= G_Attr[0].Yp_Max){
          if(Target == 0)  Ka1[Range]--;
          if((Target == 1)&&(Range == 0))  Ka3--;
          if(Target == 2)  Ka2[Range] -= 4;
          if(Target == 3)  Kb1[Range]--;
          if((Target == 4)&&(Range == 0))  Kb3--;
          if(Target == 5)  Kb2[Range] -= 4;;
        } else {
          if(Exit > 0) Exit--;
          else         Exit = 2;
        }
        break;
      case K_INDEX_INC:
        if(Range <= G_Attr[0].Yp_Max){
          if(Target == 0)  Ka1[Range]++;
          if((Target == 1)&&(Range == 0))  Ka3++;
          if(Target == 2)  Ka2[Range] += 4;
          if(Target == 3)  Kb1[Range]++;
          if((Target == 4)&&(Range == 0))  Kb3++;
          if(Target == 5)  Kb2[Range] += 4;;
          if(Range >= G_Attr[0].Yp_Max) Exit++;
        } else {
          if(Exit < 2) Exit++;
          else         Exit = 0;
        }
        break;
      }
      Key_Buffer = 0;
      if((Target == 1)||(Target == 4)){ 
        __Set(CH_A_OFFSET, (Ka3 * 195)/256);
        __Set(CH_B_OFFSET, (Kb3 * 195)/256);
      } else {
        __Set(CH_A_OFFSET, (Ka3 * 5)/256);
        __Set(CH_B_OFFSET, (Kb3 * 5)/256);
      }
      __Set(CH_A_RANGE, Range);
      __Set(CH_B_RANGE, Range);
      Delayms(200); 
    }
    __Set(FIFO_CLR, W_PTR); // FIFO写指针复位 
//      __Set(CH_A_RANGE, Range);
//      __Set(CH_B_RANGE, Range);
    
    if(Blink){ 
      Blink = 0;
      if(Range < G_Attr[0].Yp_Max +1){
        switch (Target){  
        case 0:
          Int32String_sign(&Num, A_Vdc);
          Print_Str( 45, 166-(Range*20), 0x0005, Twink, Num.str);
          Print_Str(  4*8, 216, 0x0605, PRN, "     Please connect");
          Print_Str( 23*8, 216, 0x0105, PRN, " CH_A ");
          Print_Str( 29*8, 216, 0x0605, PRN, "input to GND       ");
          Print_Str( 38*8, 216, 0x0605, Twink, "GND");
          if(Range != 0){
            Print_Str( 89, 166-(Range*20), 0x0005, PRN, " -- ");
          } 
          break;
        case 1:
          Int32String_sign(&Num, A_Vdc);
          Print_Str( 89, 166-(Range*20), 0x0005, Twink, Num.str);
          Print_Str( 38*8, 216, 0x0605, Twink, "GND");
          break;
        case 2:
          Int32String_sign(&Num, A_Vdc * Y_Attr[Range].SCALE);
          Print_Str(134, 166-(Range*20), 0x0005, Twink, Num.str);
          Print_Str(174, 166-(Range*20), 0x0005, Twink, V_Unit[Num.decPos]);
          Print_Str(  4*8, 216, 0x0605, PRN, " Input ");
          Print_Str( 11*8, 216, 0x0405, Twink, (u8*)VS_STR[Range]);
          Print_Str( 20*8, 216, 0x0605, PRN, " standard voltage to ");
          Print_Str( 41*8, 216, 0x0005, PRN, "CH_A  ");
          break;
        case 3:
          Int32String_sign(&Num, B_Vdc);
          Print_Str(245, 166-(Range*20), 0x0105, Twink, Num.str);
          Print_Str(  4*8, 216, 0x0605, PRN, "     Please connect");
          Print_Str( 23*8, 216, 0x0005, PRN, " CH_B ");
          Print_Str( 29*8, 216, 0x0605, PRN, "input to GND       ");
          Print_Str( 38*8, 216, 0x0605, Twink, "GND");
          if(Range != 0){
            Print_Str(289, 166-(Range*20), 0x0105, PRN, " -- ");
          } 
          break;
        case 4:
          Int32String_sign(&Num, B_Vdc);
          Print_Str(289, 166-(Range*20), 0x0105, Twink, Num.str);
          Print_Str( 38*8, 216, 0x0605, Twink, "GND");
          break;
        case 5:
          Int32String_sign(&Num, B_Vdc * Y_Attr[Range].SCALE);
          Print_Str(334, 166-(Range*20), 0x0105, Twink, Num.str);
          Print_Str(374, 166-(Range*20), 0x0105, Twink, V_Unit[Num.decPos]);
          Print_Str(  4*8, 216, 0x0605, PRN, " Input ");
          Print_Str( 11*8, 216, 0x0405, Twink, (u8*)VS_STR[Range]);
          Print_Str( 20*8, 216, 0x0605, PRN, " standard voltage to ");
          Print_Str( 41*8, 216, 0x0105, PRN, "CH_B  ");
        }
      } else Print_Str(10, 6, 0x0405, Twink, (u8*)ExitStr[Exit % 3]);
    }
  }
}
/*********************************  END OF FILE  ******************************/
