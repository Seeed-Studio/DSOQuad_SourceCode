/******************** (C) COPYRIGHT 2009 e-Design Co.,Ltd. *********************
 File Name : Process.c       
 Version   : DS203_APP Ver 2.3x                                  Author : bure
*******************************************************************************/
#include "Interrupt.h"
#include "Function.h"
#include "Process.h"
#include "Draw.h"
#include "Menu.h"
#include "BIOS.h"
#include "File.h"

u32 a_Avg, b_Avg, a_Ssq, b_Ssq;            // 统计用中间变量//variable for statistics
u8  a_max, b_max, a_min, b_min;            // 统计用中间变量//variable for statistics
s16 A_Vdc, A_Vpp, A_Max, A_Min, A_Rms;     // 计量结果//Calculated results
s16 B_Vdc, B_Vpp, B_Max, B_Min, B_Rms;     
u8  Ch[4], V[8];
s32 Tmp;

u16  JumpCnt, n;
u8   Full=1, Interlace;

uc16 Wait[27]= {1000, 500, 200, 100, 50, 20, 10, 5, 2, 2,   
                2,      2,   2,   2,  2,  2,  2, 2, 2, 2,    
                2,      2,   2,   2,  2,  2,  2 };
                     
Y_attr *Y_Attr; 
X_attr *X_Attr; 
G_attr *G_Attr; 
T_attr *T_Attr; 

u32  DataBuf[4096];
u8  TrackBuff  [X_SIZE * 4];         // 曲线轨迹缓存：i+0,i+1,i+2,i+3,分别存放1～4号轨迹数据//Buffer for Waveform.i+0,i+1,i+2,i+3 represents  waveform 1-4

s8  Ka1[10] ={   0,    0,    0,    0,    0,    0,    0,    0,    0,    0}; // A通道零点误差校正系数//CHA Calibrate factor in base point
s8  Kb1[10] ={   0,    0,    0,    0,    0,    0,    0,    0,    0,    0}; // B通道零点误差校正系数//CHB Calibrate factor in base point
u16 Ka2[10] ={1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024}; // A通道增益误差校正系数//CHA Calibrate factor for gain
u16 Kb2[10] ={1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024}; // B通道增益误差校正系数//CHB Calibrate factor for gain
u16 Ka3 = 256, Kb3 = 256;                                                // A B通道位移误差校正系数//Calibrate factor for offset of CHA and CHB

D_tab D_Tab[20] ={  // 脉冲波形输出驱动表, 基于72MHz主频//Digital Signal generator output ,based on 72M main frequency
//    STR      PSC     ARR       DUTY% 
  {" 10Hz ",  180-1,  40000-1,     50},
  {" 20Hz ",  180-1,  20000-1,     50},
  {" 50Hz ",  180-1,   8000-1,     50},
  {"!100Hz!", 180-1,   4000-1,     50},
  {"!200Hz!", 180-1,   2000-1,     50},
  {"!500Hz!", 180-1,    800-1,     50},
  {" 1KHz ",  180-1,    400-1,     50},
  {" 2KHz ",  180-1,    200-1,     50},
  {" 5KHz ",   18-1,    800-1,     50},
  {"!10KHz!",  18-1,    400-1,     50},
  {"!20KHz!",  18-1,    200-1,     50},
  {"!50KHz!",   1-1,   1440-1,     50},
  {"100KHz",    1-1,    720-1,     50},
  {"200KHz",    1-1,    360-1,     50},
  {"500KHz",    1-1,    144-1,     50},
  {" 1MHz ",    1-1,     72-1,     50},
  {" 2MHz ",    1-1,     36-1,     50},
  {" 4MHz ",    1-1,     18-1,     50},
  {" 6MHz ",    1-1,     12-1,     50},
  {" 8MHz ",    1-1,      9-1,     50}};

A_tab A_Tab[11] ={ // 模拟波形输出驱动表, 基于72MHz主频, 每周期36点合成//Analog signal generator, based on 72M main frequency, and 36 points for each period
//    STR     PSC     ARR 
  {" 10Hz ",  20-1,  10000-1},
  {" 20Hz ",  20-1,   5000-1},
  {" 50Hz ",  20-1,   2000-1},
  {"!100Hz!", 20-1,   1000-1},
  {"!200Hz!", 20-1,    500-1},
  {"!500Hz!", 20-1,    200-1},
  {" 1KHz ",  20-1,    100-1},
  {" 2KHz ",  20-1,     50-1},
  {" 5KHz ",  20-1,     20-1},
  {"!10KHz!", 20-1,     10-1},
  {"!20KHz!", 20-1,      5-1}};

u16 SIN_DATA[36] =  // Sine wave data                                                                                                 //         
  {0x000,0x027,0x08E,0x130,0x209,0x311,0x441,0x58F,0x6F0,    // 90
   0x85A,0x9C0,0xB19,0xC59,0xD76,0xE68,0xF26,0xFAB,0xFF3,    // 180
   0xFFF,0xFD7,0xF70,0xECE,0xDF5,0xCED,0xBBD,0xA6F,0x90E,    // 270
   0x7A4,0x63E,0x4E5,0x3A5,0x288,0x196,0x0D8,0x053,0x00B,};  // 360   

u16 TRG_DATA[36] =  // triangle wave data
  {0x000,0x0E3,0x1C6,0x2AA,0x38D,0x471,0x554,0x638,0x71B,    // 90
   0x7FF,0x8E2,0x9C6,0xAA9,0xB8D,0xC70,0xD54,0xE37,0xF1B,    // 180
   0xFFE,0xF1B,0xE37,0xD54,0xC70,0xB8D,0xAA9,0x9C6,0x8E2,    // 270
   0x7FF,0x71B,0x638,0x554,0x471,0x38D,0x2AA,0x1C6,0x0E3};   // 360			
         
u16 SAW_DATA[36] =  // Sawtooth wave data                                                                                             //         
  {0x000,0x075,0x0EA,0x15F,0x1D4,0x249,0x2BE,0x333,0x3A8,    // 90
   0x41D,0x492,0x507,0x57C,0x5F1,0x666,0x6DB,0x750,0x7C5,    // 180
   0x83A,0x8AF,0x924,0x999,0xA0E,0xA83,0xAF8,0xB6D,0xBE2,    // 270
   0xC57,0xCCC,0xD41,0xDB6,0xE2B,0xEA0,0xF15,0xF8A,0xFFF};   // 360    


/*******************************************************************************
 App_init: 显示窗口波形数据初始化
            Init the data of app 
*******************************************************************************/
void App_init(void)
{ 
  u16 i, j;
  __Set(ADC_CTRL, EN );       
  __Set(STANDBY, DN);          // 退出省电状态//Exit the power saving mode
  __Clear_Screen(BLACK);       // 清屏幕//Clear the screen
  Delayms(20); 
  __Set(FIFO_CLR, W_PTR); 
  for(i=0; i<13; i++) for(j=0; j<4; j++) Title[i][j].Flag |= UPDAT;
  for(i=0; i<9; i++)                     Meter[i].Flag    |= UPDAT;
  if(Current != FILE) {
    Title[FILE][0].Flag &= !UPDAT;
    Title[FILE][1].Flag &= !UPDAT;
    Title[FILE][3].Flag &= !UPDAT;
  }  
  PD_Cnt = 600;
  Update = 1;                  // 返回后恢复原来的档位设置//Load the previous setting of gears
}
/*******************************************************************************
 View_init: 显示窗口波形数据初始化
             Init the data of wave
*******************************************************************************/
void View_init(void)
{ 
  u16 i, j = 0, k = 0;
  for(i = 0; i < X_SIZE * 4; i += 4){
    TrackBuff[i] = 160;
    TrackBuff[i+1] = Get_Ref_Wave(i/4);
    if((i%160)==0) j = 1 - j;
    TrackBuff[i+2] = 60 + (j * 17);
    if((i%64)==0) k = 1 - k;
    TrackBuff[i+3] = 20 + (k * 17);
  }
}
/*******************************************************************************
 Update_Range: 
*******************************************************************************/
void Update_Range(void) 
{
  Interlace = 0;
  __Set(ADC_MODE, SEPARATE);                        // Set Separate mode
  __Set(CH_A_COUPLE, Title[TRACK1][COUPLE].Value);
  __Set(CH_A_RANGE,  Title[TRACK1][RANGE].Value);
  __Set(CH_A_OFFSET, (Ka3 * Title[TRACK1][POSI].Value)/256);
  if(_1_source == HIDE){
    if(_T_base > 16){
      __Set(CH_A_RANGE, G_Attr[0].Yp_Max+1);        // A通道合并到B通道 //integrate CHA to CHB
      __Set(ADC_MODE, INTERLACE);                   // Set Interlace mode
      Interlace = 1;                      
    }  
  }
  __Set(CH_B_COUPLE, Title[TRACK2][COUPLE].Value);
  __Set(CH_B_RANGE,  Title[TRACK2][RANGE].Value);
  __Set(CH_B_OFFSET, (Kb3 * Title[TRACK2][POSI].Value)/256);
  if(_2_source == HIDE){
    if(_T_base > 16){
      __Set(CH_B_RANGE,  G_Attr[0].Yp_Max+1);      // B通道合并到A通道//integrate CHB to CHA
      __Set(ADC_MODE, INTERLACE);                  // Set Interlace mode
      Interlace = 2;                        
    }
  } 
  if(_Status == RUN) __Set(FIFO_CLR, W_PTR);       // FIFO写指针复位//Reset the write pointer of FIFO
}
/*******************************************************************************
 Update_Base: 
*******************************************************************************/
void Update_Base(void) 
{
  u16 i;
  
  __Set(ADC_CTRL, EN);       
  i = Title[T_BASE][BASE].Value;
  __Set(T_BASE_PSC, X_Attr[i].PSC);
  __Set(T_BASE_ARR, X_Attr[i].ARR);
  Wait_Cnt = Wait[_T_base];
  if(_Status == RUN) __Set(FIFO_CLR, W_PTR);      // FIFO写指针复位//Reset the write pointer of FIFO
}
/*******************************************************************************
 Update_Output: 
*******************************************************************************/
void Update_Output(void) 
{
  if(_Kind == SINE){
    __Set(ANALOG_CNT, 36);
    (*((vu32 *)(0x40020400+0x50))) = (u32)&SIN_DATA[0];
    __Set(ANALOG_ARR, A_Tab[_Frqn].ARR);
  }
  if(_Kind == SAW){
    __Set(ANALOG_ARR, A_Tab[_Frqn].ARR);
    (*((vu32 *)(0x40020400+0x50))) = (u32)&SAW_DATA[0];
    __Set(ANALOG_CNT, 36);
  }
  if(_Kind == TRIANG){
    __Set(ANALOG_ARR, A_Tab[_Frqn].ARR);
    (*((vu32 *)(0x40020400+0x50))) = (u32)&TRG_DATA[0];
    __Set(ANALOG_CNT, 36);
  }
  if(_Kind == DIGI){
    __Set(DIGTAL_PSC, D_Tab[_Frqn].PSC);
    __Set(DIGTAL_ARR, D_Tab[_Frqn].ARR);
    __Set(DIGTAL_CCR, (D_Tab[_Frqn].ARR+1)/2);
  }
}
/*******************************************************************************
 Update_Trig: 
*******************************************************************************/
void Update_Trig(void) 
{ 
  if(T1 > T2)  __Set(T_THRESHOLD, (_T1 - _T2));  
  else         __Set(T_THRESHOLD, (_T2 - _T1)); 
  __Set(TRIGG_MODE,  (_Tr_source<< 3)+_Tr_kind);
  if(Title[TRIGG][SOURCE].Value == TRACK1){ 
    __Set(V_THRESHOLD, (((_Vt1-Ka1[_A_Range])*1024)/Ka2[_A_Range])&0xFF); 
  }
  if(Title[TRIGG][SOURCE].Value == TRACK2){ 
    __Set(V_THRESHOLD, (((_Vt2-Kb1[_B_Range])*1024)/Kb2[_B_Range])&0xFF); 
  }
  if(_Status == RUN) __Set(FIFO_CLR, W_PTR);      // FIFO写指针复位//Reset the write pointer of FIFO
}
/*******************************************************************************
 Process: 计算处理缓冲区数据 
          Handle the data in buffer
*******************************************************************************/
void Process(void)
{ 
  s16 i, j, k;
  
  n= 0;
  k =((1024 -_Kp)* 150)/1024 + _X_posi.Value;  // 计算插值运算后窗口位置的修正值//Calculate the correction of window position
  a_Avg =0; b_Avg =0; a_Ssq =0; b_Ssq =0;      // 统计用中间变量//Variable for statistics
  a_max =0; b_max =0; a_min =255; b_min =255;  // 统计用中间变量//Variable for statistics

  if(Interlace == 0){                          // 独立采样模式//Sample the 2 channels independently
    for(i=0; i <4096; i++){
      if((__Get(FIFO_EMPTY)==0)&&(i == JumpCnt)&&(_Status == RUN)){
        JumpCnt++;
        DataBuf[i] = __Read_FIFO();             // 读入32位FIFO数据, 读后指针+1//Load the 32 bits data in FIFO, and then increase the pointer by 1
      }
      Ch[A] = (DataBuf[i] & 0xFF );              
      a_Avg += Ch[A];                           // 累计直流平均值 //Cal average of DC             
      Tmp = Ch[A]-_1_posi;
      a_Ssq +=(Tmp * Tmp);                      // 统计平方和//Cal the Sum of the squares
      if(Ch[A] > a_max)  a_max = Ch[A];         // 统计最大值 //Tracing the maxmum 
      if(Ch[A] < a_min)  a_min = Ch[A];         // 统计最小值   //Tracing the minmum 
  
  
      Ch[B] = ((DataBuf[i] >> 8) & 0xFF);       
      b_Avg += Ch[B];                           // 累计直流平均值//Cal average of DC
      Tmp = Ch[B]-_2_posi;
      b_Ssq +=(Tmp * Tmp);                      // 统计平方和//Cal the Sum of the squares
      if(Ch[B] > b_max)  b_max = Ch[B];         // 统计最大值  //Tracing the maxmum  
      if(Ch[B] < b_min)  b_min = Ch[B];         // 统计最小值   //Tracing the minmum
  
      Ch[C] = ((DataBuf[i] >>16)& 1);           //C and D channel are 1 bits only
      Ch[D] = ((DataBuf[i] >>17)& 1);
    
      if((i > k)&&(n < 300-1)){                 // 指针到达指定窗口位置//The pointer increase to the window set by" k"
        j =i-k;
        V[A]  = Ka1[_A_Range] +(Ka2[_A_Range] *Ch[A])/1024;      
        V[B]  = Kb1[_B_Range] +(Kb2[_B_Range] *Ch[B])/1024;      //计算当前点的主值//Cal the current V for channel A and B
        while(j*1024 - n*_Kp > 0 ){
          V[Ap]= V[A_]+((V[A]-V[A_])*((n *_Kp)-(j-1)*1024))/1024;  //计算当前CH_A点的插值//Get the interpolation of waveform 1
          TrackBuff[n*4 + TRACK1] = V[Ap];
          
          V[Bp]= V[B_]+((V[B]-V[B_])*((n *_Kp)-(j-1)*1024))/1024;  //计算当前CH_B点的插值//Get the interpolation of waveform 2
          TrackBuff[n*4 + TRACK2] = V[Bp];
          
          Tmp = _3_posi + 20 * Ch[C];
          if(Tmp >= Y_BASE+Y_SIZE)  Tmp = Y_BASE+Y_SIZE-1;
          else if(Tmp <= Y_BASE+1)  Tmp = Y_BASE+1;
          TrackBuff[n*4 + TRACK3] = Tmp;
          
          TrackBuff[n*4 + TRACK4] = CH_D_Data(); 
          n++;
        V[A_] = V[A];  V[B_] = V[B];       
        }
      }
    }
  } else {                                      // 交替采样模式//When channel A or B is hiden,interlace mode
    for(i=0; i <4096; i++){
      if((__Get(FIFO_EMPTY)==0)&&(i == JumpCnt)&&(_Status == RUN)){
        JumpCnt++;
        DataBuf[i] = __Read_FIFO();             // 读入32位FIFO数据, 读后指针+1//Load the 32 bits data in FIFO, and then increase the pointer by 1
      }
      Ch[A] = (DataBuf[i] & 0xFF );              
      Ch[B] = ((DataBuf[i] >> 8) & 0xFF);       

      a_Avg += Ch[A]+Ch[B];                                   
      b_Avg = a_Avg;                            // 累计直流平均值//Cal average of DC
      
      Tmp = Ch[A]-_1_posi;
      a_Ssq +=(Tmp * Tmp);
      Tmp = Ch[B]-_1_posi;
      a_Ssq +=(Tmp * Tmp);                    
      b_Ssq  = a_Ssq;                           // 统计平方和//Cal the Sum of the squares
      
      if(Ch[A] > a_max)  a_max = Ch[A];          
      if(Ch[B] > a_max)  a_max = Ch[B];         // 统计最大值 //Tracing the maxmum 
      b_max = a_max;
      
      if(Ch[A] < a_min)  a_min = Ch[A];         
      if(Ch[B] < a_min)  a_min = Ch[B];         // 统计最小值 //Tracing the minnu  
      b_min = a_min;
  
      Ch[C] = ((DataBuf[i] >>16)& 1);
      Ch[D] = ((DataBuf[i] >>17)& 1);
    
      if(_2_source == HIDE){                 // B通道合并到A通道时//If channel B is hiden
        V[A] = Ka1[_A_Range] +(Ka2[_A_Range] *Ch[A])/1024;        //计算当前第1点的主值//Cal the main value of 1st current data
        V[B] = Ka1[_A_Range] +(Ka2[_A_Range] *Ch[B])/1024;        //计算当前第2点的主值//Cal the main value of 2nd current data
      } else {                            // A通道合并到B通道时//If channel A is hiden
        V[A] = Kb1[_B_Range] +(Kb2[_B_Range] * Ch[A])/1024;        //计算当前第1点的主值//Cal the main value of 1st current data
        V[B] = Kb1[_B_Range] +(Kb2[_B_Range] * Ch[B])/1024;        //计算当前第2点的主值//Cal the main value of 2nd current data
      }
      if((i > k)&&(n < 300-1)){                 // 指针到达指定窗口位置//The pointer increase to the window set by" k"
        j =i - k;
        while(j*1024 > n*_Kp){
          V[Bp] =V[A_]+((V[B]-V[A_])*((n *_Kp)-(j-1)*1024))/1024;  
          TrackBuff[n*4 + TRACK1] = V[Bp];
          TrackBuff[n*4 + TRACK2] = V[Bp];
          Tmp = _3_posi + 20 * Ch[C];
          if(Tmp >= Y_BASE+Y_SIZE)  Tmp = Y_BASE+Y_SIZE-1;
          else if(Tmp <= Y_BASE+1)  Tmp = Y_BASE+1;
          TrackBuff[n*4 + TRACK3] = Tmp;
          TrackBuff[n*4 + TRACK4] = CH_D_Data(); 
          n++;
        }
        while(j*1024 > n*_Kp){
          V[Ap] =V[B]+((V[A]-V[B])*((n *_Kp)-(j-1)*1024))/1024;   
          TrackBuff[n*4 + TRACK1] = V[Ap];
          TrackBuff[n*4 + TRACK2] = V[Ap];
          Tmp = _3_posi + 20 * Ch[C];
          if(Tmp >= Y_BASE+Y_SIZE)  Tmp = Y_BASE+Y_SIZE-1;
          else if(Tmp <= Y_BASE+1)  Tmp = Y_BASE+1;
          TrackBuff[n*4 + TRACK3] = Tmp;
          TrackBuff[n*4 + TRACK4] = CH_D_Data(); 
          n++;
        }
        V[A_] = V[A]; 
      }
    }
  }
  for(i=0; i<4; i++){                                    // 消除屏幕端点连线//Clear up the ligature
    for(j=0; j<4; j++){
      TrackBuff[(i+0)*4+ j]   = TrackBuff[(i+1)*4 + j];
      TrackBuff[(299-i)*4+ j] = TrackBuff[(298-i)*4 + j];
    }
  }
}

u8 CH_D_Data(void)  //计算生成CH_D通道的显示数据//Cal the data for channel D
{
  s32 Tmp;
  
  switch (_4_source){  
  case A_add_B:
    if(Interlace == 0){                          // 独立采样模式//Sample independently
      Tmp = _4_posi +(V[A]-_1_posi)+(V[B]-_2_posi);
    } else {                                     // 交替采样模式//Sample interlacly
      Tmp = _4_posi;
      if(_1_source != HIDE)  Tmp = _4_posi +(V[Ap]-_1_posi);
      if(_2_source != HIDE)  Tmp = _4_posi +(V[Bp]-_2_posi);
    } break;
  case A_sub_B:
    if(Interlace == 0){                          // 独立采样模式//Sample independently
      Tmp = _4_posi +(V[A]-_1_posi)-(V[B]-_2_posi);  break;
    } else {                                     // 交替采样模式//Sample interlacly
      Tmp = _4_posi;
      if(_1_source != HIDE)  Tmp = _4_posi +(V[Ap]-_1_posi);
      if(_2_source != HIDE)  Tmp = _4_posi +(V[Bp]-_2_posi);
    } break;
  case C_and_D:
    Tmp = _4_posi + 20 *(Ch[C] & Ch[D]);  break;
  case C_or_D:
    Tmp =  _4_posi + 20 *(Ch[C] & Ch[D]);  break;
  case FILE1:
    Tmp = FileBuff[n] - FileBuff[299] +_4_posi;  break;
  case FILE2:
    Tmp = FileBuff[n+300] - FileBuff[599] +_4_posi;  break;
  case FILE3:
    Tmp = FileBuff[n+600] - FileBuff[899] +_4_posi;  break;
  case FILE4:
    Tmp = FileBuff[n+900] - FileBuff[1199] +_4_posi;  break;
  default:
    Tmp = _4_posi + 20 * Ch[D];
  }
  if(Tmp >= Y_BASE+Y_SIZE)  Tmp = Y_BASE+Y_SIZE-1;
  else if(Tmp <= Y_BASE+1)  Tmp = Y_BASE+1;
  return Tmp;
}
/*******************************************************************************
 Synchro: 扫描同步处理，按设定模式显示波形 
          Hanndle the scanning, and show waveform as the scan mode
*******************************************************************************/
void Synchro(void)  //扫描同步方式共有：AUTO、NORM、SIGN、NONE、SCAN 5种模式//Scan mode
{ 
  u16  i;

  switch (_Mode){ 
  case AUTO:
    __Set(TRIGG_MODE,(_Tr_source <<3)+_Tr_kind);  // 设触发条件//Set the trigger Condition
    if(__Get(FIFO_START)!=0){
      Process();                                  // 生成新的显示波形//Generate new wave 
      Wait_Cnt = Wait[_T_base];
    } else if(Wait_Cnt==0){
      if(JumpCnt >= 4095)  JumpCnt = 0;         
      Process();   
      Wait_Cnt = Wait[_T_base];
    } break;
  case NORM:
    __Set(TRIGG_MODE,(_Tr_source <<3)+_Tr_kind);  // 设触发条件//Set the trigger Condition
    if(__Get(FIFO_START)!=0){
      Process();                                  // 生成新的显示波形//Generate new wave
      Wait_Cnt = Wait[_T_base];
    } else if(Wait_Cnt==0){                          //If not triggered in a period of time
      for(i=0; i<4*X_SIZE; ++i)  TrackBuff[i] = 0;// 清除旧的显示波形//clear the previous waveform
      Wait_Cnt = Wait[_T_base];
    } break;
  case SIGN:
    __Set(TRIGG_MODE,(_Tr_source <<3)+_Tr_kind);  // 设触发条件//Set the trigger Condition
    if(__Get(FIFO_START)!=0)  Process();          // 生成新的显示波形//Generate new wave 
    break;
  case NONE:
  case SCAN:
    __Set(TRIGG_MODE, UNCONDITION);               // 设为无条件触发//Trigger with no condition 
    Process();                                    // 生成当前显示波形//Get current date and generate waveform
    break;
  }
  Draw_Window();                                  // 刷新屏幕波形显示区//Refresh the wave area of LCD

  if((_Status == RUN)&&(__Get(FIFO_FULL)!=0)){    // FIFO is full
    __Set(FIFO_CLR, W_PTR);                       // FIFO写指针复位//Reset the write pointer of FIFO
    Wait_Cnt = Wait[_T_base];
    JumpCnt =0;
    if(_Mode == SIGN){
      _Status = HOLD;                             // 一帧完后，进入暂停//Pause when finished one frame.
      _State.Flag |= UPDAT;
    }
    if(_Mode == SCAN){
      for(i=0; i<X_SIZE; i++){                    // 重建当前轨迹基线  //Recreate the current  baseline if in scan mode                  
        TrackBuff[i*4 + TRACK1] = _1_posi;
        TrackBuff[i*4 + TRACK2] = _2_posi; 
        TrackBuff[i*4 + TRACK3] = _3_posi; 
        TrackBuff[i*4 + TRACK4] = _4_posi;
      }
    }
  }    
  A_Vdc = Ka1[_A_Range] +(Ka2[_A_Range]*(a_Avg/1024))/4096 - _1_posi;  
  B_Vdc = Kb1[_B_Range] +(Kb2[_B_Range]*(b_Avg/1024))/4096 - _2_posi;  

  A_Rms = Ka1[_A_Range] +(Ka2[_A_Range]*Int_sqrt(a_Ssq/4096))/1024;
  B_Rms = Kb1[_B_Range] +(Kb2[_B_Range]*Int_sqrt(b_Ssq/4096))/1024;

  A_Max = Ka1[_A_Range] +(Ka2[_A_Range]*a_max)/1024 - _1_posi;
  B_Max = Kb1[_B_Range] +(Kb2[_B_Range]*b_max)/1024 - _2_posi;
 
  A_Min = Ka1[_A_Range] +(Ka2[_A_Range]*a_min)/1024 - _1_posi;
  B_Min = Kb1[_B_Range] +(Kb2[_B_Range]*b_min)/1024 - _2_posi;
    
  A_Vpp = A_Max - A_Min;
  B_Vpp = B_Max - B_Min;
}  
/******************************** END OF FILE *********************************/
