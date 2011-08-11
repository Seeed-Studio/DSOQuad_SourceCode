/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : Calibrat.c  
 Version   : DS203_APP Ver 2.3x                                  Author : bure
*******************************************************************************/
#include "Interrupt.h"
#include "Function.h"
#include "Calibrat.h"
#include "Process.h"
#include "File.h"
#include "BIOS.h"
#include "Menu.h"

uc8 VS_STR[9][12]  ={"250-300mV", "!0.5-0.6V!","!1.0-1.2V!","!2.5-3.0V!",
                     "!5.0-6.0V!"," !10-12V! "," !25-30V! "," !50-60V! "};
uc8 ExitStr[3][50] ={" PRESS (#) KEY TO Exit WITH RESTORE DEFAULTS ",
                     " PRESS (#) KEY TO Exit WITH SAVE CALIBRATION ",
                     " PRESS (#) KEY TO Exit WITHOUT CALIBRATION   "};
uc8 V_UNIT1[8] ={'m','V','m','V','V',' ','k','V'};

void Balance(void)
{
  u16 i;
  
  __Set(STANDBY, DN);                          // 退出省电状态
  __Set(ADC_CTRL, EN );       
  __Set(T_BASE_PSC, X_Attr[_2uS].PSC);         // T_BASE = 2uS
  __Set(T_BASE_ARR, X_Attr[_2uS].ARR);
  __Set(CH_A_COUPLE, AC);
  __Set(CH_B_COUPLE, AC);
  __Set(CH_A_OFFSET, 100);
  __Set(CH_B_OFFSET, 100);
  __Set(CH_A_RANGE,  G_Attr[0].Yp_Max);        // 10V/Div
  __Set(CH_B_RANGE,  G_Attr[0].Yp_Max+1);      // B通道合并到A通道
  __Set(ADC_MODE, INTERLACE);                  // Set Interlace mode
  Update_Trig();
  __Set(TRIGG_MODE, UNCONDITION);              // 设任意触发
  Delayms(2000); 
  
  __Set(FIFO_CLR, W_PTR); 
  Delayms(20); 
  a_Avg = 2048;               
  b_Avg = 2048;            
  for(i=0; i <4096; i++){
    DataBuf[i] = __Read_FIFO();         // 读入32位FIFO数据, 读后指针+1
    a_Avg += (DataBuf[i] & 0xFF );      // 累计直流平均值                
    b_Avg += ((DataBuf[i]>>8) & 0xFF );              
  }
  Kab = (a_Avg - b_Avg)/4096;
}
/*******************************************************************************
  Calibrat : Calibrat routine
*******************************************************************************/
void Calibrat(u8 Channel)
{ 
  s8  Ma1[10], Mb1[10], Ma3[10], Mb3[10];
  u16 Ma2[10], Mb2[10], i, j;
  s16 TmpA, TmpB;
  u8  Range, n[10], k, m, Step;
  
  Key_Buffer = 0; 
  __Set(STANDBY, DN);                                   // 退出省电状态
  __Set(BACKLIGHT, 10*(Title[BK_LIGHT][CLASS].Value+1));
  __Clear_Screen(BLACK);                                // 清屏幕
  
  Interlace = 0;
  __Set(ADC_MODE, SEPARATE);                            // Set Separate mode
  __Set(ADC_CTRL, EN);       
  __Set(TRIGG_MODE, UNCONDITION);                       // 设任意触发
  _Status = RUN;
  __Set(BEEP_VOLUME, 5*(Title[VOLUME][CLASS].Value-1)); // Reload volume
  Beep_mS = 500;                                        // 蜂鸣器响500mS
  Range = 0;
  Step  = 0;
  m     = 0;
  
  __Set(T_BASE_PSC, X_Attr[_100uS].PSC);                // T_BASE = 100uS
  __Set(T_BASE_ARR, X_Attr[_100uS].ARR);

  __Set(CH_A_COUPLE, DC);
  __Set(CH_B_COUPLE, DC);
  
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
  Print_Str(137, 185, 0x0005, PRN, "VOLTAGE");
  Print_Str(206, 185, 0x0105, PRN, "CH_B");
  Print_Str(249, 185, 0x0105, PRN, "ZERO");
  Print_Str(293, 185, 0x0105, PRN, "DIFF");
  Print_Str(338, 185, 0x0105, PRN, "VOLTAGE");
    
  for(i=0; i<=G_Attr[0].Yp_Max; i++){
    Print_Str(  6, 166-(i*20), 0x0005, PRN, Y_Attr[i].STR); // 显示量程
    Print_Str(206, 166-(i*20), 0x0105, PRN, Y_Attr[i].STR);
    Ma1[i] = Ka1[i];  Ma2[i] = Ka2[i];  Ma3[i] = Ka3[i];    // 备份校准前的参数
    Mb1[i] = Kb1[i];  Mb2[i] = Kb2[i];  Mb3[i] = Kb3[i];
  }

  while (1){
    if(PD_Cnt == 0){
      __Set(BACKLIGHT, 0);                               // 关闭背光
      __Set(STANDBY, EN);                                // 进入省电状态
      return;
    }
    __Set(CH_A_RANGE, Range);  __Set(CH_B_RANGE, Range);
    Delayms(20); 
    __Set(FIFO_CLR, W_PTR);
    Delayms(20); 
    a_Avg = 2048;  b_Avg = 2048;               
    for(i=0; i <4096; i++){
      DataBuf[i] = __Read_FIFO();         // 读入32位FIFO数据
      a_Avg += (DataBuf[i] & 0xFF );      // 累计直流平均值                
      b_Avg += ((DataBuf[i]>>8) & 0xFF );              
    }
    TmpA  = Ka1[Range] +(Ka2[Range]*(a_Avg/4096)+ 512)/1024;
    TmpB  = Kb1[Range] +(Kb2[Range]*(b_Avg/4096)+ 512)/1024;

    if(Blink){ 
      Blink = 0;
      switch (Step){  
      case 0:
        Range = 0;
        __Set(CH_A_OFFSET, ((1024+Ka3[Range])*40 + 512)/1024);
        __Set(CH_B_OFFSET, ((1024+Kb3[Range])*40 + 512)/1024);
        Print_Str(   8, 216, 0x0305, PRN,   "        PLEASE CONNECT");
        Print_Str(29*8, 216, 0x0305, PRN,   "INPUT TO ");
        Print_Str(38*8, 216, 0x0405, PRN,   "GND      ");
        Print_Str(   8,   6, 0x0305, PRN,   "   PRESS   KEY TO CONFIRM THE INPUT VOLTAGE   ");
        Print_Str(10*8,   6, 0x0405, Twink, " ");
        if(Channel == TRACK1){
          Print_Str( 23*8, 216, 0x0005, PRN, " CH_A ");
          for(i=0; i<=G_Attr[0].Yp_Max; i++){
            Ka1[i] = 0; Ka2[i] = 1024; Ka3[i] = 0;         // 设置校准参数初值
          }
        }
        if(Channel == TRACK2){
          Print_Str( 23*8, 216, 0x0105, PRN, " CH_B ");
          for(i=0; i<=G_Attr[0].Yp_Max; i++){
            Kb1[i] = 0; Kb2[i] = 1024; Kb3[i] = 0;         // 设置校准参数初值
          }
        }
        break;
      case 1:
        Print_Str(   8,   6, 0x0305, PRN,   "   AUTOMATIC CALIBRATION IN PROGRESS...       ");
        if(Channel == TRACK1){
          s8ToPercen(n, TmpA - 40);
          Print_Str( 45, 166-(Range*20), 0x0005, INV, n);
          Ka1[Range] -= TmpA - 40; 
        } 
        if(Channel == TRACK2){
          s8ToPercen(n, TmpB - 40);
          Print_Str(245, 166-(Range*20), 0x0105, INV, n);
          Kb1[Range] -= TmpB - 40; 
        }
        Range++;
        if(Range > G_Attr[0].Yp_Max){ 
          Range = 0;  Step++;
        } 
        __Set(CH_A_OFFSET, ((1024+Ka3[Range])*40 + 512)/1024);
        __Set(CH_B_OFFSET, ((1024+Kb3[Range])*40 + 512)/1024);
        k = 0;
        break;
      case 2:
        k++;
        if(k >= 8) k = 0;
        if(Channel == TRACK1){
          s8ToPercen(n, TmpA - 40);
          Print_Str( 45, 166-(Range*20), 0x0005, PRN, n);
          if(TmpA - 40 != 0)  Ka1[Range] -= TmpA - 40;
          else                k = 0;           
        } 
        if(Channel == TRACK2){
          s8ToPercen(n, TmpB - 40);
          Print_Str(245, 166-(Range*20), 0x0105, PRN, n);
          if(TmpB - 40 != 0)  Kb1[Range] -= TmpB - 40;
          else                k = 0; 
        }
        if(k == 0)  Range++;
        if(Range > G_Attr[0].Yp_Max){ 
          Range = 0;  Step++;
        } 
        __Set(CH_A_OFFSET, ((1024+Ka3[Range])*40 + 512)/1024);
        __Set(CH_B_OFFSET, ((1024+Kb3[Range])*40 + 512)/1024);
        break;
      case 3:
        k++;
        __Set(CH_A_OFFSET, ((1024+Ka3[Range])*160 + 512)/1024);
        __Set(CH_B_OFFSET, ((1024+Kb3[Range])*160 + 512)/1024);
        if((Channel == TRACK1)&&(TmpA > 140))  Step++;
        if((Channel == TRACK2)&&(TmpB > 140))  Step++;
        if(k > 20)  Step++;
        break;
      case 4:
        k = 0;
        if(Channel == TRACK1){
          s8ToPercen(n, TmpA - 160);
          Print_Str( 89, 166-(Range*20), 0x0005, INV, n);
          Ka3[Range] -= (1024*(TmpA-160)+80)/160;
        } 
        if(Channel == TRACK2){
          s8ToPercen(n, TmpB - 160);
          Print_Str(289, 166-(Range*20), 0x0105, INV, n);
          Kb3[Range] -= (1024*(TmpB-160)+80)/160;
        }
        Range++;
        if(Range > G_Attr[0].Yp_Max){ 
          Range = 0;  Step++;
        } 
        __Set(CH_A_OFFSET, ((1024+Ka3[Range])* 160 + 512)/1024);
        __Set(CH_B_OFFSET, ((1024+Kb3[Range])* 160 + 512)/1024);
        break;
      case 5:
        k++;
        if(k >= 8) k = 0;
        if(Channel == TRACK1){
          s8ToPercen(n, TmpA - 160);
          Print_Str( 89, 166-(Range*20), 0x0005, PRN, n);
          if(TmpA - 160 != 0) Ka3[Range] -= (1024*(TmpA-160)+80)/160;
          else                k = 0;           
        } 
        if(Channel == TRACK2){
          s8ToPercen(n, TmpB - 160);
          Print_Str(289, 166-(Range*20), 0x0105, PRN, n);
          if(TmpB - 160 != 0) Kb3[Range] -= (1024*(TmpB-160)+80)/160;
          else                k = 0; 
        }
        if(k == 0)  Range++;
        if(Range > G_Attr[0].Yp_Max){ 
          Range = 0;  Step++;
        } 
        __Set(CH_A_OFFSET, ((1024+Ka3[Range])* 160 + 512)/1024);
        __Set(CH_B_OFFSET, ((1024+Kb3[Range])* 160 + 512)/1024);
        break;
      case 6:
        k++;
        if(k > 20)  Step++;
        Range = 0;
        if(m < 2){
          __Set(CH_A_OFFSET, ((1024+Ka3[Range])*40 + 512)/1024);
          __Set(CH_B_OFFSET, ((1024+Kb3[Range])*40 + 512)/1024);
          if((Channel == TRACK1)&&(TmpA < 50)){
            Step = 1;
            m++;
          }
          if((Channel == TRACK2)&&(TmpB < 50)){
            Step = 1;
            m++;
          }
        } else {
          __Set(CH_A_OFFSET, ((1024+Ka3[Range])* 25 + 512)/1024);
          __Set(CH_B_OFFSET, ((1024+Kb3[Range])* 25 + 512)/1024);
          if((Channel == TRACK1)&&(TmpA < 55))  Step++;
          if((Channel == TRACK2)&&(TmpB < 55))  Step++;
        }
        break;
      case 7:
        Print_Str( 4*8, 216, 0x0305, PRN,   " INPUT ");
        Print_Str(11*8, 216, 0x0405, Twink, (u8*)VS_STR[Range]);
        Print_Str(20*8, 216, 0x0305, PRN,   " STANDARD VOLTAGE TO ");
        Print_Str(   8,   6, 0x0305, PRN,   "MODIFY VOLTAGE:   ...    ");
        Print_Str(18*8,   6, 0x0405, Twink, "-");
        Print_Str(22*8,   6, 0x0405, Twink, "+");
        Print_Str(27*8,   6, 0x0305, PRN,   "SELECT RANGE:   ---   ");
        Print_Str(42*8,   6, 0x0405, Twink, "<");
        Print_Str(46*8,   6, 0x0405, Twink, ">");
        if(Channel == TRACK1){
          if(TmpA > 35){
            Int2Str(n, (TmpA - 25)* Y_Attr[Range].SCALE, V_UNIT, 3, SIGN);
          } else {
            Int2Str(n, 0, V_UNIT, 3, SIGN);
          }
          Print_Str( 134, 166-(Range*20), 0x0005, Twink, n);
          Print_Str(41*8, 216,            0x0005, PRN,   "CH_A  ");
        } 
        if(Channel == TRACK2){
          if(TmpB > 35){
            Int2Str(n, (TmpB - 25)* Y_Attr[Range].SCALE, V_UNIT, 3, SIGN);
          } else {
            Int2Str(n, 0, V_UNIT, 3, SIGN);
          }
          Print_Str( 334, 166-(Range*20), 0x0105, Twink, n);
          Print_Str(41*8, 216,            0x0105, PRN,   "CH_B  ");
        }
        break;
      case 8:                             //"    PRESS   ---   TO SELECT THE NEXT OPERATION"
        m = 0;
        Print_Str(   8,   6, 0x0305, PRN,   "    PRESS   ---  ");
        Print_Str(12*8,   6, 0x0405, Twink, "<");
        Print_Str(16*8,   6, 0x0405, Twink, ">");
        Print_Str(17*8,   6, 0x0305, PRN,   " TO SELECT THE NEXT OPERATION   ");
        Print_Str(   8, 216, 0x0305, PRN,   "  PRESS   TO ");
        Print_Str(14*8, 216, 0x0405, PRN,   "CONFIRM THE RE-CALIBRATION ");
        Print_Str( 9*8, 216, 0x0405, Twink, " ");       
        if(Channel == TRACK1)  Print_Str(41*8, 216, 0x0005, PRN, "CH_A "); 
        if(Channel == TRACK2)  Print_Str(41*8, 216, 0x0105, PRN, "CH_B ");
        break;                            //"  PRESS   TO CONFIRM THE RE-CALIBRATION CH_A  "
      case 9:                             //             "SELECT THE CALIBRATION CH_A      "
        Print_Str( 9*8, 216, 0x0405, Twink, " ");       
        Print_Str(14*8, 216, 0x0405, PRN,   "SELECT THE CALIBRATION ");
        if(Channel == TRACK1)  Print_Str(37*8, 216, 0x0105, PRN, "CH_B     "); 
        if(Channel == TRACK2)  Print_Str(37*8, 216, 0x0005, PRN, "CH_A     ");
        break;
      case 10:                            //             "Exit WITHOUT SAVE RESULTS        "
        Print_Str( 9*8, 216, 0x0405, Twink, " ");       
        Print_Str(14*8, 216, 0x0405, PRN,   "Exit WITHOUT SAVE RESULTS        ");
        break;
      case 11:                            //             "Exit AND SAVE CALIBRATION RESULTS"
        Print_Str( 9*8, 216, 0x0405, Twink, " ");       
        Print_Str(14*8, 216, 0x0405, PRN,   "Exit AND SAVE CALIBRATION RESULTS");
        break;
      case 12:                            //             "Exit AND RESTORE SYSTEM DEFAULTS "
        Print_Str( 9*8, 216, 0x0405, Twink, " ");       
        Print_Str(14*8, 216, 0x0405, PRN,   "Exit AND RESTORE SYSTEM DEFAULTS ");
        break;
      }
    }
    if(Key_Buffer){ 
      PD_Cnt = 600;                               // 重新设定等待时间600秒
      if((Range <= G_Attr[0].Yp_Max)&&(Step == 7)){
        if(Channel == TRACK1){
          Print_Str(134, 166-(Range*20), 0x0005, PRN, n);
        }
        if(Channel == TRACK2){
          Print_Str(334, 166-(Range*20), 0x0105, PRN, n);
        }
      } 
      switch (Key_Buffer){  
      case KEY2:
        if(Step == 0)  Step++;
        if((Step == 8)||(Step == 9)){
          if(Step == 9) Channel = 1 - Channel;
          for(i=0; i<=G_Attr[0].Yp_Max; i++){
            if(Channel == TRACK1){
              Print_Str( 45, 166-(i*20), 0x0005, PRN, "     ");   
              Print_Str( 89, 166-(i*20), 0x0005, PRN, "     ");   
              Print_Str(134, 166-(i*20), 0x0005, PRN, "       ");  
            }
            if(Channel == TRACK2){
              Print_Str(245, 166-(i*20), 0x0105, PRN, "     ");
              Print_Str(289, 166-(i*20), 0x0105, PRN, "     ");
              Print_Str(334, 166-(i*20), 0x0105, PRN, "       ");
            }
          }
          Step = 0;; 
        } 
        if(Step >= 10){
          if(Step == 10){
            for(i=0; i<=G_Attr[0].Yp_Max; i++){
              Ka1[i] = Ma1[i];  Ka2[i] = Ma2[i];  Ka3[i] = Ma3[i];
              Kb1[i] = Mb1[i];  Kb2[i] = Mb2[i];  Kb3[i] = Mb3[i];
            }
            Save_Param();                         // 不保存校正后的参数
            Print_Str( 8, 216, 0x0405, PRN, "                                                ");
          } 
          if(Step == 11){
            Save_Param();                         // 保存校正后的参数
            Print_Str( 8, 216, 0x0405, PRN, "          SAVING THE CALIBRATION DATA           ");
          }  
          if(Step == 12){ 
            for(i=0; i<=G_Attr[0].Yp_Max; i++){
              Ka1[i] = 0; Ka2[i] = 1024; Ka3[i] = 0;         // 设置校准参数初值
              Kb1[i] = 0; Kb2[i] = 1024; Kb3[i] = 0;
            }
            Save_Param();  // 清除校准参数，保存缺省值 
            Print_Str( 8, 216, 0x0405, PRN, "       RESTORE DEFAULTS CALIBRATION DATA        ");
          }
          Delayms(1000);                                      
          App_init();
          return;
        }
        break;
      case KEY3:
        break;
      case K_ITEM_DEC:
        if((Step == 7)&&(Range > 0)) Range--;  
        if( Step >= 9)               Step--;
        if( Step == 8)               Step = 12;
        break;
      case K_ITEM_INC:
        if(Step >= 8)  Step++;
        if(Step > 12)  Step = 8;
        if(Step == 7)  Range++;  
        if(Range  > G_Attr[0].Yp_Max){  
          Range = 0;        
          Step++;
        } 
        break;
      case K_INDEX_DEC:
        if(Step == 7){  
          if((Channel == TRACK1)&&(TmpA > 35))  Ka2[Range] -= 2;
          if((Channel == TRACK2)&&(TmpB > 35))  Kb2[Range] -= 2;
        }
        break;
      case K_INDEX_INC:
        if(Step == 7){  
          if((Channel == TRACK1)&&(TmpA > 35))  Ka2[Range] += 2;
          if((Channel == TRACK2)&&(TmpB > 35))  Kb2[Range] += 2;
        }
        break;
      }
      Key_Buffer = 0;
    }
  }
}
/*********************************  END OF FILE  ******************************/
