/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : Process.h  
 Version   : DS203_APP Ver 2.3x                                  Author : bure
*******************************************************************************/
#ifndef __Process_h
#define __Process_h

#include "stm32f10x_lib.h"
#include "Draw.h"

//================= 输入通道编号定义 =================
//==================Definition of input channel=========
#define A                 0
#define B                 1
#define C                 2
#define D                 3
#define A_                2
#define B_                3
#define Ap                4
#define Bp                5

//================== 结构变量宏定义 ==================
//===================Structure Macro ==============
#define _1_source  Title[TRACK1][SOURCE].Value
#define _2_source  Title[TRACK2][SOURCE].Value
#define _3_source  Title[TRACK3][SOURCE].Value
#define _4_source  Title[TRACK4][SOURCE].Value
#define _1_posi    Title[TRACK1][POSI].Value
#define _2_posi    Title[TRACK2][POSI].Value
#define _3_posi    Title[TRACK3][POSI].Value
#define _4_posi    Title[TRACK4][POSI].Value
#define _C_adj     Title[TRACK3][RANGE].Value
#define _D_adj     Title[TRACK4][RANGE].Value
#define _A_Range   Title[TRACK1][RANGE].Value
#define _B_Range   Title[TRACK2][RANGE].Value

#define _Tr_source Title[TRIGG][SOURCE].Value
#define _Trigg     Title[TRIGG]
#define _Tr_kind   Title[TRIGG][TR_KIND].Value

#define _File      Title[FILE][0]

#define _X_posi    Title[T_BASE][XPOSI]
#define _X_View    Title[T_BASE][VIEW]
#define _T_base    Title[T_BASE][BASE].Value
#define _Mode      (Title[T_BASE][MODE].Value)

#define _A_Range    Title[TRACK1][RANGE].Value
#define _B_Range    Title[TRACK2][RANGE].Value

#define _Kp        X_Attr[Title[T_BASE][BASE].Value].KP  // 当前档位的X插值系数//The interpolation factor for current T_base.
#define _INSERT    G_Attr[0].INSERT                      // 开始应用插值的档位//T_base to apply interpolation

#define _State     Title[RUNNING][STATE]
#define _Status    Title[RUNNING][STATE].Value

#define _Curr      Title[Current]
#define _Det       Detail[Current]

#define _Frqn      Title[OUTPUT][FRQN].Value
#define _Kind      Title[OUTPUT][KIND].Value

#define _T1        Title[T_VERNIE][T1].Value
#define _T2        Title[T_VERNIE][T2].Value

#define _Vt1       V_Trigg[TRACK1].Value
#define _Vt2       V_Trigg[TRACK2].Value

typedef struct  // 模拟波形输出驱动表 //Analog output structure
{
  uc8  STR[8];   // 档位标识字符串//Gear string
  uc16 PSC;      // 预分频系数//Freqency pre-divider
  uc16 ARR;      // 分频系数//Frequency divider
} A_tab ; 

typedef struct  // 脉冲波形输出驱动表//Digital output strucrure 
{
  uc8  STR[8];  // 档位标识字符串//Gear string
  uc16 PSC;     // 预分频系数//Frequency pre-divider
  uc16 ARR;     // 分频系数//Frequency divider
  u16  Duty;    // 占空比系数//Duty
} D_tab ; 

extern u8  TrackBuff [X_SIZE * 4];          // i+0~3,分别存放1～4号轨迹数据//i=1,2,3,4, store the data of waveform 1~4
extern u16 JumpCnt;
extern u32 a_Avg, b_Avg;                    

extern s16 A_Vdc, A_Vpp, A_Max, A_Min, A_Rms;     // Cal result.
extern s16 B_Vdc, B_Vpp, B_Max, B_Min, B_Rms;     

extern s8  Ka1[10], Kb1[10]; // 模拟通道零点误差校正系数//Base calibrate factor for analog channel
extern u16 Ka2[10], Kb2[10]; // 模拟通道增益误差校正系数//Gain calibrate factor for analog channel
extern u16 Ka3, Kb3;         // 模拟通道位移误差校正系数//Drift calibrate factor for analog channel
extern u32 DataBuf[4096];

void App_init(void);
void View_init(void);
void Update_Range(void);
void Update_Base(void);
void Update_Output(void); 
void Update_Trig(void); 
void Process(void);
void Synchro(void);
u8   CH_D_Data(void);  

#endif
/******************************** END OF FILE *********************************/
