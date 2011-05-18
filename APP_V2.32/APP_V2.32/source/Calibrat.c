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

uc8 VS_STR[10][12]={"100-120mV","250-300mV","0.5-0.6V ","1.0-1.2V ","2.5-3.0V ",
                    "5.0-6.0V "," 10-12V  "," 25-30V  "," 50-60V  ","suitable "};
uc8 ExitStr[3][30]={" Exit without calibration ", 
                    "Exit with save calibration", 
                    "Exit with Restore defaults"};
u8  Exit;      

/*******************************************************************************
  Calibrat : Calibrat routine
*******************************************************************************/
void Calibrat(void)
{ 
  u8  V_Unit[4][3]={"uV","mV","V ","kV"};
  u16 i, j, k, Range, Target;

  I32STR_RES Num;
  
  Key_Buffer = 0; 
  __Set(STANDBY, DN);                                   // 退出省电状态//Exit the stanby mode
  __Set(BACKLIGHT, 10*(Title[BK_LIGHT][CLASS].Value+1));
  __Clear_Screen(BLACK);                                // 清屏幕//Clear the screen
  
  k = Load_Parameter();                                 // 读取预设开机参数//  Load the pre-set paremeter 
  __Set(TRIGG_MODE, UNCONDITION);                       // 设任意触发// Sample with no condition
  __Set(ADC_CTRL, EN);       
  _Status = RUN;
  __Set(BEEP_VOLUME, 5*(Title[VOLUME][CLASS].Value-1)); // Reload volume
  Beep_mS = 500;                                        // 蜂鸣器响500mS//Beep for 500ms
  Exit = 0;
  Range = 0;
  Target = 0;
  Key_Buffer = 0; 
  
  __Set(T_BASE_PSC, X_Attr[_100uS].PSC);                // T_BASE = 100uS
  __Set(T_BASE_ARR, X_Attr[_100uS].ARR);

  __Set(CH_A_COUPLE, DC);
  __Set(CH_A_OFFSET, 25);
  __Set(CH_B_COUPLE, DC);
  __Set(CH_B_OFFSET, 25);
  
  
  for(j=0; j<220; j+=20){                               // 画表格  //Draw the table
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
 
  Print_Str(  6, 185, 0x0005, PRN, "CH_A");              // 显示表格标题栏//Show the title
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
    Beep_mS = 500;                                       // 蜂鸣器响500mS //Beep for 500ms
    Delayms(2000); 
    App_init();
    return;
  }
  while (1){
    if(PD_Cnt == 0){
      __Set(BACKLIGHT, 0);                         // 关闭背光 //Close the backlight
      __Set(STANDBY, EN);                          // 进入省电状态//Enter the stanby mode
      return;
    }
    JumpCnt =0;
    Process();                                     // 采样波形处理 //Handle the Sampled wave   
    if((Target == 1)||(Target == 4)){ 
      A_Vdc = Ka1[Range]*10+(10*Ka2[Range]*(a_Avg/1024))/4096 - 1750;  //"DIFF" for CHA and CHB
      B_Vdc = Kb1[Range]*10+(10*Kb2[Range]*(b_Avg/1024))/4096 - 1750;  //Range stands for gears,50mv or 0.1v... , and Targer stands for item to calibrate. ZERO of DIFF or VOL
    } else {
      A_Vdc = Ka1[Range] +(Ka2[Range] *((a_Avg+512)/1024))/4096 - 25;  
      B_Vdc = Kb1[Range] +(Kb2[Range] *((b_Avg+512)/1024))/4096 - 25; 
    }
    if(__Get(FIFO_FULL))  __Set(FIFO_CLR, W_PTR); // FIFO写指针复位 //Reset the FIFO write pointer

    if(Key_Buffer) { 
      PD_Cnt = 600;                               // 600秒(S)
      if(Range < G_Attr[0].Yp_Max +1){
        if(Target == 0){
          Int32String_sign(&Num, A_Vdc);
          //Print_Str( 45, 166-(Range*20), 0x0005, PRN, Num.str);
          Print_Str( 289, 166-(8*20), 0x0005, PRN, Num.str);
          Int32String_sign(&Num, Ka1[Range]);
          Print_Str( 45, 166-(Range*20), 0x0005, PRN, Num.str);
          
        }
        if(Target == 1){
          Int32String_sign(&Num, A_Vdc);
          //Print_Str( 89, 166-(Range*20), 0x0005, PRN, Num.str);
          Print_Str( 289, 166-(8*20), 0x0005, PRN, Num.str);
          Int32String_sign(&Num, Ka2[Range]);
          Print_Str( 89, 166-(Range*20), 0x0005, PRN, Num.str);
          
        }
        if(Target == 2){
          Int32String_sign(&Num, A_Vdc * Y_Attr[Range].SCALE);
          //Print_Str(134, 166-(Range*20), 0x0005, PRN, Num.str);
          //Print_Str(174, 166-(Range*20), 0x0005, PRN, V_Unit[Num.decPos]);
          Print_Str(289, 166-(8*20), 0x0005, PRN, Num.str);
          Print_Str(329, 166-(8*20), 0x0005, PRN, V_Unit[Num.decPos]);
          Int32String_sign(&Num, Ka3);
          Print_Str(134, 166-(Range*20), 0x0005, PRN, Num.str);
        }
        if(Target == 3){
          Int32String_sign(&Num, B_Vdc);
          //Print_Str(245, 166-(Range*20), 0x0105, PRN, Num.str); 
          Print_Str(289, 166-(8*20), 0x0105, PRN, Num.str);
          Int32String_sign(&Num, Kb1[Range]);
          Print_Str(245, 166-(Range*20), 0x0105, PRN, Num.str);
         
        }
        if(Target == 4){
          Int32String_sign(&Num, B_Vdc);
          //Print_Str(289, 166-(Range*20), 0x0105, PRN, Num.str);
          Print_Str(289, 166-(8*20), 0x0105, PRN, Num.str);
          Int32String_sign(&Num, Kb2[Range]);
          Print_Str(289, 166-(Range*20), 0x0105, PRN, Num.str);
          
        }
        if(Target == 5){
          Int32String_sign(&Num, B_Vdc * Y_Attr[Range].SCALE);
         // Print_Str(334, 166-(Range*20), 0x0105, PRN, Num.str);
         // Print_Str(374, 166-(Range*20), 0x0105, PRN, V_Unit[Num.decPos]);
          Print_Str(289, 166-(8*20), 0x0105, PRN, Num.str);
          Print_Str(329, 166-(8*20), 0x0105, PRN, V_Unit[Num.decPos]); 
          Int32String_sign(&Num, Kb3);
          Print_Str(334, 166-(Range*20), 0x0105, PRN, Num.str);
        }
      } else {
        Print_Str(  10, 166-(8*20), 0x0405, PRN, (u8*)ExitStr[Exit % 3]);
      }
      switch (Key_Buffer){  
      case KEY2:
        if(Range < G_Attr[0].Yp_Max)  Range = G_Attr[0].Yp_Max;
//        if(Range >= G_Attr[0].Yp_Max){
        if(Exit == 1){
          Save_Parameter(0);                         // 保存校正后的参数 // Save the parameters calibrated
          Print_Str( 32, 216, 0x0405, PRN, "         Save the calibration data         ");
          Delayms(1000); 
        }
        if(Exit == 2){
          memset(SecBuff,0,256);  
          __Param_Area_WR(SecBuff, PAGE_0);          // 保存缺省值参数 // Save the defaults data 
          Print_Str( 32, 216, 0x0405, PRN, "           Restore defaults data           ");
          Delayms(1000); 
        }
        App_init();
        return;
      case K_ITEM_S:
        if(Target <5) Target++;
        else          Target =0;
        break;
      case K_ITEM_DEC:
        if(Range >0) Range--;
        break;
      case K_ITEM_INC:
        if(Range  <= G_Attr[0].Yp_Max) Range++;
//        if(Range == G_Attr[0].Yp_Max)    Target = 0;
        break;
      case K_INDEX_DEC:
        if(Target == 0)  Ka1[Range]--;
        if(Target == 1)  Ka2[Range]--;
        if(Target == 2)  Ka3--;
        if(Target == 3)  Kb1[Range]--;
        if(Target == 4)  Kb2[Range]--;
        if(Target == 5)  Kb3--;
        if(Range >= G_Attr[0].Yp_Max) Exit--;
        break;
      case K_INDEX_INC:
        if(Target == 0)  Ka1[Range]++;
        if(Target == 1)  Ka2[Range]++;
        if(Target == 2)  Ka3++;
        if(Target == 3)  Kb1[Range]++;
        if(Target == 4)  Kb2[Range]++;
        if(Target == 5)  Kb3++;
        if(Range >= G_Attr[0].Yp_Max) Exit++;
        break;
      }
      Key_Buffer = 0;
      if((Target == 1)||(Target == 4)){ 
        __Set(CH_A_OFFSET, (Ka3 * 175)/256);
        __Set(CH_B_OFFSET, (Kb3 * 175)/256);
      } else {
        __Set(CH_A_OFFSET, (Ka3 * 25)/256);
        __Set(CH_B_OFFSET, (Kb3 * 25)/256);
      }
      __Set(CH_A_RANGE, Range);
      __Set(CH_B_RANGE, Range);
    }
    
    if(Blink){ 
      Blink = 0;
      if(Range < G_Attr[0].Yp_Max +1){
        if(Target == 0){
          Int32String_sign(&Num, A_Vdc);
          Print_Str( 45, 166-(Range*20), 0x0005, Twink, Num.str);
        }
        if(Target == 1){
          Int32String_sign(&Num, A_Vdc);
          Print_Str( 89, 166-(Range*20), 0x0005, Twink, Num.str);
        }
        if(Target == 2){
          Int32String_sign(&Num, A_Vdc * Y_Attr[Range].SCALE);
          Print_Str(134, 166-(Range*20), 0x0005, Twink, Num.str);
          Print_Str(174, 166-(Range*20), 0x0005, Twink, V_Unit[Num.decPos]);
        }
        if(Target == 3){
          Int32String_sign(&Num, B_Vdc);
          Print_Str(245, 166-(Range*20), 0x0105, Twink, Num.str);
        }
        if(Target == 4){
          Int32String_sign(&Num, B_Vdc);
          Print_Str(289, 166-(Range*20), 0x0105, Twink, Num.str);
        }
        if(Target == 5){
          Int32String_sign(&Num, B_Vdc * Y_Attr[Range].SCALE);
          Print_Str(334, 166-(Range*20), 0x0105, Twink, Num.str);
          Print_Str(374, 166-(Range*20), 0x0105, Twink, V_Unit[Num.decPos]);
        } 
        if((Target == 2)||(Target == 5)){
          if     (strcmp((char const*)Y_Attr[Range].STR, "20mV") == 0)  i = 0; 
          else if(strcmp((char const*)Y_Attr[Range].STR, "50mV") == 0)  i = 1; 
          else if(strcmp((char const*)Y_Attr[Range].STR, "0.1V") == 0)  i = 2; 
          else if(strcmp((char const*)Y_Attr[Range].STR, "0.2V") == 0)  i = 3; 
          else if(strcmp((char const*)Y_Attr[Range].STR, "0.5V") == 0)  i = 4; 
          else if(strcmp((char const*)Y_Attr[Range].STR, " 1V ") == 0)  i = 5; 
          else if(strcmp((char const*)Y_Attr[Range].STR, " 2V ") == 0)  i = 6; 
          else if(strcmp((char const*)Y_Attr[Range].STR, " 5V ") == 0)  i = 7; 
          else if(strcmp((char const*)Y_Attr[Range].STR, "!10V!")== 0)  i = 8; 
          else                                             i = 9; 
          Print_Str(  4*8, 216, 0x0605, PRN, " Input ");
          Print_Str( 11*8, 216, 0x0405, PRN, (u8*)VS_STR[i]);
          Print_Str( 21*8, 216, 0x0605, PRN, "standard voltage to ");
          if(Target < 3) Print_Str( 41*8, 216, 0x0005, PRN, "CH_A  ");
          else           Print_Str( 41*8, 216, 0x0105, PRN, "CH_B  ");
        } else {
          Print_Str(  4*8, 216, 0x0605, PRN, "     Please connect");
          Print_Str( 29*8, 216, 0x0605, PRN, "input to GND       ");
          if(Target < 3) Print_Str( 23*8, 216, 0x0105, PRN, " CH_A ");
          else           Print_Str( 23*8, 216, 0x0005, PRN, " CH_B ");
        }
      } else {
        Print_Str( 10, 166-(8*20), 0x0405, Twink, (u8*)ExitStr[Exit % 3]);
        Print_Str(4*8, 216, 0x0605, PRN, "    Push the . key to confirm exit        ");
      }
    }
  }
}
/*********************************  END OF FILE  ******************************/
