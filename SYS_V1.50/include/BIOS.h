/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : BIOS.h  
 Version   : DS203_SYS Ver 1.5x                                 Author : bure
*******************************************************************************/
#ifndef __BIOS_H
#define __BIOS_H

#include "stm32f10x_lib.h"

//=================== 硬件版本相关定义 ===================

  #define HDW_VERSION       "Hardware Ver 2.6  "

//==================== Flash 空间分配 ====================

#define BIN_BASE                ((u32)(0x0802C000)) // Size < 68KB  
#define PRM_BASE                BIN_BASE + 68*1024  // Size =  2KB   
#define INF_BASE                BIN_BASE + 70*1024  // Size < 10KB   
#define APP4_BASE               ((u32)(0x08024000)) // Size = 32KB  
#define APP3_BASE               ((u32)(0x0801C000)) // Size = 32KB  
#define APP2_BASE               ((u32)(0x08014000)) // Size = 32KB  
#define APP1_BASE               ((u32)(0x0800C000)) // Size = 32KB  
#define SYS_BASE                ((u32)(0x08004000)) // Size = 32KB   
#define DFU_BASE                ((u32)(0x08000000)) // Size = 16KB 

//====================== 函数 Set 中 Object 及 Value 定义 ======================

#define CH_A_OFFSET       0     // A通道垂直位移  Value = 0~200
#define CH_B_OFFSET       1     // B通道垂直位移  Value = 0~200
#define BACKLIGHT         2     // 背光亮度       Value = 0~100
#define BEEP_VOLUME       3     // 蜂鸣器音量     Value = 0~100
#define BETTERY_DT        4     // 电池电压检测   Value = 1: 启动
#define ADC_MODE          5     // ADC工作模式    Value = 1/0
#define FIFO_CLR          6     // FIFO指针复位   Value = 1/0: W_PTR/R_PTR
#define T_BASE_PSC        7     
#define T_BASE_ARR        8     
#define CH_A_COUPLE       9     //                Value = 1/0: AC/DC
#define CH_A_RANGE       10     //                Value = 0~5
#define CH_B_COUPLE      11     //                Value = 1/0: AC/DC
#define CH_B_RANGE       12     //                Value = 0~5
#define ANALOG_ARR       13     // 模拟输出分频系数
#define ANALOG_PTR       14     // 模拟输出缓冲区指针
#define ANALOG_CNT       15     // 模拟输出每周期点数
#define DIGTAL_PSC       16     // 脉冲输出预分频系数
#define DIGTAL_ARR       17     // 脉冲输出分频系数
#define DIGTAL_CCR       18     // 脉冲输出占空比系数
#define KEY_IF_RST       19     // 定时中断标志复位
#define STANDBY          20     // 进入降功耗等待状态
#define FPGA_RST         31     // FPGA 复位

#define TRIGG_MODE       32+0  // 触发模式
#define V_THRESHOLD      32+1  // 电压触发门限
#define T_THRESHOLD      32+2  // 脉冲宽度触发时间门限
#define ADC_CTRL         32+4  // ADC 工作状态设置
#define A_POSITION       32+5  // 当前CH_A的零点位置
#define B_POSITION       32+6  // 当前CH_B的零点位置
#define REG_ADDR         32+7  // 该地址决定了FPGA中哪一组寄存器的数据被MCU读入

//==================== 函数 Set 中 TRIGG_MODE 的 Value 定义=====================
/*
CH_A Trigger source & kind select => 
0x00: by Negedge;   0x01: by Posedge;   0x02: by low level; 0x03: by high level
0x04: TL < Delta_T; 0x05: TL > Delta_T; 0x06: TH < Delta_T; 0x07: TH > Delta_T;

CH_B Trigger source & kind select =>
0x08: by Negedge;   0x09: by Posedge;   0x0A: by low level; 0x0B: by high level
0x0C: TL < Delta_T; 0x0D: TL > Delta_T; 0x0E: TH < Delta_T; 0x0F: TH > Delta_T;

CH_C Trigger source & kind select =>
0x10: by Negedge;   0x11: by Posedge;   0x12: by low level; 0x13: by high level
0x04: TL < Delta_T; 0x05: TL > Delta_T; 0x06: TH < Delta_T; 0x07: TH > Delta_T;

CH_D Trigger source & kind select =>
0x18: by Negedge;   0x19: by Posedge;   0x1A: by low level; 0x1B: by high level
0x1C: TL < Delta_T; 0x1D: TL > Delta_T; 0x1E: TH < Delta_T; 0x1F: TH > Delta_T;

0x20~0xFF  =>  Unconditional trigger
*/
#define UNCONDITION       0x20        // 无条件触发采样        

//===================== 函数 Set 中 ADC_CTRL 的 Value 定义 =====================

#define ADC_DN            0        // ADC休眠
#define ADC_EN            1        // ADC工作

//===================== 函数 Set 中 ADC_MODE 的 Value 定义 =====================
 
#define SEPARATE          0        // ADC独立采样模式
#define INTERLACE         1        // ADC交替采样模式

//======================== FPGA数据读写控制信号H_L定义 =========================

#define LOW               0
#define HIGH              1

//===================== 函数 Set 中 FIFO_CLR 的 Value 定义 =====================

#define R_PTR             0        // FIFO读地址指针
#define W_PTR             1        // FIFO写地址指针

//==================== 函数 Set_ 中 CH_X_COUPLE 的 Value 定义 ==================

#define DC                0
#define AC                1

//======================== 函数 Get 中的 Object 定义 ===========================

#define FIFO_DIGIT     0        // 16bits FIFO digital data
#define FIFO_EMPTY     1        // FIFO empty flag: 1 = empty
#define FIFO_START     2        // FIFO start flag: 1 = start
#define FIFO_FULL      3        // FIFO full flag: 1 = Full
#define KEY_STATUS     4        // Current keys status
#define USB_POWER      5        // USB power status: 1 = Power ON
#define V_BATTERY      6        // Battery voltage (mV)
#define VERTICAL       7        // 垂直通道属性指针
#define HORIZONTAL     8        // 水平通道属性指针
#define GLOBAL         9        // 整体属性指针
#define TRIGGER        10       // 触发通道属性指针
#define FPGA_OK        11       // FPGA 配置成功
#define CHARGE         12       // 电池充电状态
#define HDWVER         13       // 设备硬件版本号 
#define DFUVER         14       // DFU程序模块版本号 
#define SYSVER         15       // SYS程序模块版本号 
#define FPGAVER        16       // FPGA配置程序版本号 

#define ADC_DATA       32+0     // 0~7:ADC_CH_A 8~15:ADC_CH_B 16~17:CH_C&CH_D 
#define PRE_SAMPLING   32+1     // 0~15:Pre-sampling depth
#define ALL_SAMPLING   32+2     // 0~15:Total sampling depth
#define CH_A_MIN_MAX   32+3     // 0~7:VMIN 8~15:VMAX 
#define CH_A_V_SUM     32+4     // 0~15:CH_A voltage sum
#define CH_A_V_SSQ     32+5     // 0~15:CH_A voltage sum of squares
#define CH_A_NEDGE     32+6     // 0~15:CH_A number of edge
#define CH_A_FREQ      32+7     // 0~15:CH_A frequence
#define CH_A_PHW_MAX   32+8     // 0~15:CH_A pulse high width MAX
#define CH_A_PHW_MIN   32+9     // 0~15:CH_A pulse high width MIN
#define CH_A_PLW_MAX   32+10    // 0~15:CH_A pulse low width MAX
#define CH_A_PLW_MIN   32+11    // 0~15:CH_A pulse low width MIN

//======================= 模拟通道(衰减/增益)档位控制信号 ======================

  #define _50MV             0
  #define _100MV            1
  #define _200MV            2
  #define _500MV            3
  #define _1V               4
  #define _2V               5
  #define _5V               6
  #define _10V              7
  #define CH_A              8
  #define CH_B              8

//============================= 系统控制用IO脚定义 =============================

#define LCD_nRST_LOW()    GPIOD_BRR  = GPIO_Pin_11
#define LCD_nRST_HIGH()   GPIOD_BSRR = GPIO_Pin_11
#define LCD_RS_LOW()      GPIOD_BRR  = GPIO_Pin_12
#define LCD_RS_HIGH()     GPIOD_BSRR = GPIO_Pin_12

#define FIFO_SCK_LOW()    GPIOA_BRR  = GPIO_Pin_6
#define FIFO_SCK_HIGH()   GPIOA_BSRR = GPIO_Pin_6
#define FIFO_SDA_LOW()    GPIOA_BRR  = GPIO_Pin_7
#define FIFO_SDA_HIGH()   GPIOA_BSRR = GPIO_Pin_7

#define FIFO_CLRW_LOW()   GPIOB_BRR  = GPIO_Pin_1
#define FIFO_CLRW_HIGH()  GPIOB_BSRR = GPIO_Pin_1
#define FIFO_MODE_LOW()   GPIOC_BRR  = GPIO_Pin_3
#define FIFO_MODE_HIGH()  GPIOC_BSRR = GPIO_Pin_3
#define FIFO_CLRR_LOW()   GPIOC_BRR  = GPIO_Pin_4
#define FIFO_CLRR_HIGH()  GPIOC_BSRR = GPIO_Pin_4
#define FIFO_H_L_LOW()    GPIOC_BRR  = GPIO_Pin_5
#define FIFO_H_L_HIGH()   GPIOC_BSRR = GPIO_Pin_5

#define SPI_SS_LOW()      GPIOB_BRR  = GPIO_Pin_10
#define SPI_SS_HIGH()     GPIOB_BSRR = GPIO_Pin_10
#define SPI_CLK_LOW()     GPIOB_BRR  = GPIO_Pin_11
#define SPI_CLK_HIGH()    GPIOB_BSRR = GPIO_Pin_11
#define SPI_MOSI_LOW()    GPIOB_BRR  = GPIO_Pin_12
#define SPI_MOSI_HIGH()   GPIOB_BSRR = GPIO_Pin_12
#define SPI_CRST_LOW()    GPIOB_BRR  = GPIO_Pin_14
#define SPI_CRST_HIGH()   GPIOB_BSRR = GPIO_Pin_14

#define CHRG_ST          !((GPIOB_IDR & 0x0100)>>8)
#define USB_PWR_ON        ((GPIOD_IDR & 0x0004)>>2)
#define FPGA_CFG_OK       (GPIOB_IDR >>15)

#define KEY1_OFF          ((GPIOA_IDR & 0x4000)!=0)
#define KEY2_OFF          ((GPIOC_IDR & 0x0400)!=0)
#define KEY3_OFF          ((GPIOC_IDR & 0x0200)!=0)
#define KEY4_OFF          ((GPIOC_IDR & 0x0100)!=0)
#define KEY1_ON           ((GPIOA_IDR & 0x4000)==0)
#define KEY2_ON           ((GPIOC_IDR & 0x0400)==0)
#define KEY3_ON           ((GPIOC_IDR & 0x0200)==0)
#define KEY4_ON           ((GPIOC_IDR & 0x0100)==0)

#define USB_EN()          GPIOA_CRH = 0x888BBBBB

#define STB_DN()    GPIOD_BSRR = GPIO_Pin_13; TIM1_CR1 = 0x0085 
#define STB_EN()    GPIOD_BRR  = GPIO_Pin_13; TIM1_CR1 = 0x0084 

//================= 模拟通道控制信号定义 =================

  #define DC_1()        GPIOE_BSRR = GPIO_Pin_0
  #define AC_1()        GPIOE_BRR  = GPIO_Pin_0
  #define DC_2()        GPIOE_BSRR = GPIO_Pin_5
  #define AC_2()        GPIOE_BRR  = GPIO_Pin_5
  #define Ax0_OFF()     GPIOE_BRR  = GPIO_Pin_4
  #define Ax0_ON()      GPIOE_BSRR = GPIO_Pin_4
  #define Ax1_OFF()     GPIOB_BRR  = GPIO_Pin_9
  #define Ax1_ON()      GPIOB_BSRR = GPIO_Pin_9
  #define Ax2_LOW()     GPIOE_BRR  = GPIO_Pin_2
  #define Ax2_HIGH()    GPIOE_BSRR = GPIO_Pin_2
  #define Ax5_LOW()     GPIOE_BRR  = GPIO_Pin_3
  #define Ax5_HIGH()    GPIOE_BSRR = GPIO_Pin_3
//#define Ax10_OFF()    GPIOB_BSRR = GPIO_Pin_8
//#define Ax10_ON()     GPIOB_BRR  = GPIO_Pin_8
  #define Bx0_OFF()     GPIOC_BRR  = GPIO_Pin_13
  #define Bx0_ON()      GPIOC_BSRR = GPIO_Pin_13
  #define Bx1_OFF()     GPIOE_BRR  = GPIO_Pin_6
  #define Bx1_ON()      GPIOE_BSRR = GPIO_Pin_6
  #define Bx2_LOW()     GPIOC_BRR  = GPIO_Pin_14
  #define Bx2_HIGH()    GPIOC_BSRR = GPIO_Pin_14
  #define Bx5_LOW()     GPIOC_BRR  = GPIO_Pin_15
  #define Bx5_HIGH()    GPIOC_BSRR = GPIO_Pin_15

// =======================================================、

typedef struct  // 硬件综合属性 
{
  u16 LCD_X;    // 屏幕水平显示点数
  u16 LCD_Y;    // 屏幕垂直显示点数
  u16 Yp_Max;   // 垂直档位最大值     
  u16 Xp_Max;   // 水平档位最大值     
  u16 Tg_Num;   // 触发档位最大值
  u16 Yv_Max;   // 垂直位移最大值 
  u16 Xt_Max;   // 水平位移最大值 
  u16 Co_Max;   // 耦合方式最大值 
  u8  Ya_Num;   // 模拟通道数目
  u8  Yd_Num;   // 数字通道数目
  u8  INSERT;   // 开始应用插值的档位
  u16 KpA1;     // A通道位移补偿系数1
  u16 KpA2;     // A通道位移补偿系数2
  u16 KpB1;     // B通道位移补偿系数1
  u16 KpB2;     // B通道位移补偿系数2
} G_attr ;

typedef struct  // 垂直通道属性 
{
  u8  STR[8];   // 档位标识字符串
  s16 KA1;      // A通道位移误差校正系数1
  u16 KA2;      // A通道斜率误差校正系数2
  s16 KB1;      // B通道位移误差校正系数1
  u16 KB2;      // B通道斜率误差校正系数2
  u32 SCALE;    // 垂直通道比例系数
} Y_attr ;

typedef struct  // 水平通道属性 
{
  u8  STR[8];   // 档位标识字符串
  s16 PSC;      // 预分频系数
  u16 ARR;      // 分频系数
  u16 CCR;      // 占空比系数
  u16 KP;       // 插值系数
  u32 SCALE;    // 水平通道比例系数
} X_attr ; 

typedef struct  // 触发通道属性 
{
  u8  STR[8];   // 触发方式标识字符串
  u8  CHx;      // 触发通道编号
  u8  CMD;      // 触发方式控制字
} T_attr ; 

extern uc8  SYS_Ver[5]; 
extern u8   VerStr[8];
extern u8   Clash;

extern const G_attr G_ATTR[1];
extern const Y_attr Y_ATTR[9];
extern const X_attr X_ATTR[27];
extern const T_attr T_ATTR[32];

extern Y_attr *Y_Attr; 
extern X_attr *X_Attr; 
extern G_attr *G_Attr; 
extern T_attr *T_Attr; 

void SendByte(u8 Data); 
void Set_Param(u8 RegAddr, u8 Parameter); 

u32  Get(u8 Object, u32 Value);
u32  Set(u8 Object, u32 Value);

#endif  

/*******************************  END OF FILE  ********************************/
