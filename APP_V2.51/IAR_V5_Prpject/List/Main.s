///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  11:08:07 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\APP_V2.51\source\Main.c                /
//    Command line =  E:\Mini-DS\DS203\APP_V2.51\source\Main.c -lA            /
//                    E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\List\ -o      /
//                    E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\Obj\ --debug  /
//                    --endian=little --cpu=Cortex-M3 --fpu=None              /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.0 Evaluation\ARM\INC\DLib_Config_Full.h"    /
//                    -I E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\..\..\FWLi /
//                    b\inc\ -I E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\..\ /
//                    ..\USBLib\inc\ -I E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prp /
//                    ject\..\include\ -I "C:\Program Files\IAR               /
//                    Systems\Embedded Workbench 5.0 Evaluation\ARM\INC\"     /
//                    -Ohs                                                    /
//    List file    =  E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\List\Main.s   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Main

        EXTERN App_init
        EXTERN Balance
        EXTERN Beep_mS
        EXTERN Blink
        EXTERN Calibrat
        EXTERN Current
        EXTERN Delay_Cnt
        EXTERN Delayms
        EXTERN Detail
        EXTERN Display_Meter
        EXTERN Display_Title
        EXTERN Display_Value
        EXTERN G_Attr
        EXTERN Key_Buffer
        EXTERN Load_Attr
        EXTERN Load_Buf
        EXTERN Load_Dat
        EXTERN Load_Param
        EXTERN Meter
        EXTERN NVIC_SetVectorTable
        EXTERN PD_Cnt
        EXTERN Print_Str
        EXTERN Result_FPS
        EXTERN Save_Bmp
        EXTERN Save_Buf
        EXTERN Save_Csv
        EXTERN Save_Dat
        EXTERN Save_Param
        EXTERN Sec_Cnt
        EXTERN Synchro
        EXTERN T_Attr
        EXTERN Title
        EXTERN TrackBuff
        EXTERN Update
        EXTERN Update_Base
        EXTERN Update_Battery
        EXTERN Update_Mark
        EXTERN Update_Output
        EXTERN Update_Range
        EXTERN Update_Trig
        EXTERN Update_View_Area
        EXTERN V_Trigg
        EXTERN X_Attr
        EXTERN Y_Attr
        EXTERN __Display_Str
        EXTERN __Get
        EXTERN __Set
        EXTERN __USB_Init
        EXTERN __aeabi_memclr
        EXTERN reset_parameter

        PUBLIC PROJECT_STR
        PUBLIC main
        
        CFI Names cfiNames0
        CFI StackFrame CFA R13 DATA
        CFI Resource R0:32, R1:32, R2:32, R3:32, R4:32, R5:32, R6:32, R7:32
        CFI Resource R8:32, R9:32, R10:32, R11:32, R12:32, R13:32, R14:32
        CFI EndNames cfiNames0
        
        CFI Common cfiCommon0 Using cfiNames0
        CFI CodeAlign 2
        CFI DataAlign 4
        CFI ReturnAddress R14 CODE
        CFI CFA R13+0
        CFI R0 Undefined
        CFI R1 Undefined
        CFI R2 Undefined
        CFI R3 Undefined
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R7 SameValue
        CFI R8 SameValue
        CFI R9 SameValue
        CFI R10 SameValue
        CFI R11 SameValue
        CFI R12 Undefined
        CFI R14 SameValue
        CFI EndCommon cfiCommon0
        

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "      FPGA configurat...">`:
        DATA
        DC8 "      FPGA configuration error       "
        DC8 0, 0
        DC8 "     DS203 Mini DSO APP Ver 2.51      "
        DC8 0
        DC8 "     Reload parameter form disk       "
        DC8 0
        DC8 "     Parameter record not found       "
        DC8 0
        DC8 "! Save the current setting !"
        DC8 0, 0, 0
        DC8 " >   "
        DC8 0, 0
        DC8 " OK  "
        DC8 0, 0
        DC8 " NONE"
        DC8 0, 0
        DC8 " FULL"
        DC8 0, 0
        DC8 " ERR "
        DC8 0, 0
// E:\Mini-DS\DS203\APP_V2.51\source\Main.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : Main.c  
//    3  Version   : DS203_APP Ver 2.5x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include "Interrupt.h"
//    6 #include "Function.h"
//    7 #include "Calibrat.h"
//    8 #include "Process.h"
//    9 #include "Ident.h"
//   10 #include "Draw.h"
//   11 #include "BIOS.h"
//   12 #include "Menu.h"
//   13 #include "File.h"
//   14 
//   15 /*******************************************************************************
//   16 版本修改说明
//   17 APP V2.30: 从该版本起不再兼容PCB_V2.6以下版本的主板
//   18            从该版本起不再兼容SYS_V1.31以下版本
//   19            休眠定时修改为600秒(Main.c)
//   20            修改及添加了新的SYS库函数(BIOS.s)
//   21            修改了开机信息显示程序(Main.c)
//   22 APP V2.31: 增加了开机识别FPGA加载配置完成与否判别(Main.c)
//   23            增加了Licence权限管理功能的Demo程序范例(Ident.c,Main.c)
//   24            修改了模拟通道校正功能的进入和退出相关操作(calibrat.c)
//   25            增加了144MHz交替采样模式下的相关功能(Process.c)
//   26 APP V2.32  从该版本起可并行使用IAR 4.42与5.0版本
//   27            源程序没改动，增加了文件夹　IAR_V5_Prpject
//   28 APP V2.33  修改了扫描时基<1uS时，显示刷新的BUG(Process.c)
//   29            修改了在校准状态下，操作提示信息的BUG(Calibrat.c)
//   30 APP V2.34  改为按通道单独校准(Calibrat.c & Main.c)
//   31            修改了校准项选择的操作方式(Calibrat.c)
//   32 APP V2.35  修改了校准过程中的BUG(Calibrat.c)
//   33            修改了扫描时基<5uS时，暂停不了的BUG(Process.c)
//   34            优化了显示数据处理程序(Process.c)
//   35            增加了模拟通道自动零点平衡功能(Main.c,Process.c,Calibrat.c)
//   36 APP V2.36  部分校准操作改为自动模式(Calibrat.c,Process.c,Function.c)
//   37            修改了开机加载工作参数的方式(Main.c)
//   38 APP V2.37  进一步完善和优化了显示数据处理程序(Process.c)
//   39            修改了32位有符号及无符号整数转换程序四舍五入的BUG(Function.c)
//   40            增加了时间频率脉宽占空比测量功能(Process.c, Menu.c)
//   41 APP V2.40  增加了写U盘创建文件名功能(Main.c, Flies.c, dosfs.c)
//   42            修改存盘时显示文件序号BUG(Menu.c) 
//   43 APP V2.41  增加了文件格式为.BUF的读/写采样缓冲区数据文件(Main.c,Flies.c,Menu.c)
//   44            增加了文件格式为.CSV的导出采样缓冲区数据文件(Main.c,Flies.c,Menu.c)
//   45 APP V2.42  为节省空间将文件系统转移到SYS_V1.40模块上(ASM.s, Flies.c, dosfs.c)
//   46            改为用"SerialNo.WPT"的文件形式保存工作参数表(Flies.c)
//   47            注：APP V2.42以上版本必须与SYS V1.40以上版本一起配合使用
//   48 APP V2.43  修改了模拟通道档位调整时的BUG(Main.c)
//   49 APP V2.44  修改了校准操作时保存参数的BUG(Calibrat.c)
//   50            增加了开机加载参数成功与否提示(Main.c)
//   51 APP V2.45  修改了读写BUF文件时恢复显示菜单中各个对应项时的BUG(Files.c)
//   52            删除了读BUF文件时的测试信息反馈显示(Main.c)
//   53 APP V2.50  重写了基于新FAT12文件系统的文件读写程序(Files.c, ASM.s)
//   54            修改了TH,TL测量显示的BUG(Menu.c)
//   55            优化了带量纲数值显示相关函数(Menu.c,Function.c,Calibrat.c)
//   56            修改了脉宽触发程序的BUG(Process.c)
//   57 APP V2.51  修改了Vmin,Vmax,Vpp计量的BUG(Process.c)
//   58 *******************************************************************************/
//   59 
//   60 #define APP_VERSION       "     DS203 Mini DSO APP Ver 2.51      "
//   61 

        SECTION `.rodata`:CONST:NOROOT(2)
//   62 uc8 PROJECT_STR[20] = "Demo PROG. Ver 1.00";
PROJECT_STR:
        DATA
        DC8 "Demo PROG. Ver 1.00"
//   63 
//   64 /*******************************************************************************
//   65   main : Main routine.
//   66 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function main
        THUMB
//   67 int main(void)
//   68 { 
main:
        PUSH     {R4-R11,LR}
        CFI R14 Frame(CFA, -4)
        CFI R11 Frame(CFA, -8)
        CFI R10 Frame(CFA, -12)
        CFI R9 Frame(CFA, -16)
        CFI R8 Frame(CFA, -20)
        CFI R7 Frame(CFA, -24)
        CFI R6 Frame(CFA, -28)
        CFI R5 Frame(CFA, -32)
        CFI R4 Frame(CFA, -36)
        CFI CFA R13+36
        SUB      SP,SP,#+4
        CFI CFA R13+40
//   69   s32 i;
//   70   u32 Licence;
//   71   u16 Count_FPS, Second;//,Offset, Result 
//   72 //  u8 N[20];
//   73 //  u8 T_Unit[15]={'u','S','u','S','m','S','S'};
//   74   
//   75   NVIC_SetVectorTable(NVIC_VectTab_FLASH, 0x0C000);   // For Application #1
        MOV      R1,#+49152
        MOV      R0,#+134217728
        BL       NVIC_SetVectorTable
//   76 //NVIC_SetVectorTable(NVIC_VectTab_FLASH, 0x14000);   // For Application #2
//   77 //NVIC_SetVectorTable(NVIC_VectTab_FLASH, 0x1C000);   // For Application #3
//   78 //NVIC_SetVectorTable(NVIC_VectTab_FLASH, 0x24000);   // For Application #4
//   79   
//   80 //Note: 用 IAR_V4.x 编译时，变更 App#n 还要同时修改 lnkarm.xcl 文件中的对应项 
//   81 //      用 IAR_V5.x 编译时，变更 App#n 还要同时修改 xxxxxx.icf 文件中的对应项 
//   82   
//   83   __USB_Init();
        BL       __USB_Init
        MOVS     R0,#+11
//   84   
//   85   if(__Get(FPGA_OK)== 0){
        BL       __Get
        CBNZ     R0,??main_0
//   86     __Display_Str(6*8, 30, YEL, PRN, "      FPGA configuration error       ");
        LDR.W    R0,??main_1      ;; `?<Constant "      FPGA configurat...">`
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        MOVW     R2,#+2047
        MOVS     R1,#+30
        MOVS     R0,#+48
        BL       __Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//   87     while (1){};
??main_2:
        B.N      ??main_2
//   88   }
//   89   
//   90   __Display_Str(48, 50, WHT, PRN, APP_VERSION);
??main_0:
        LDR.W    R0,??main_1+0x4  ;; `?<Constant "      FPGA configurat...">` + 40
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        MOVW     R2,#+65535
        MOVS     R1,#+50
        MOVS     R0,#+48
        BL       __Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//   91   Y_Attr = (Y_attr*)__Get(VERTICAL);     
        MOVS     R0,#+7
        BL       __Get
        LDR.W    R1,??main_1+0x8  ;; Y_Attr
        STR      R0,[R1, #+0]
//   92   X_Attr = (X_attr*)__Get(HORIZONTAL);
        MOVS     R0,#+8
        BL       __Get
        LDR.W    R1,??main_1+0xC  ;; X_Attr
        STR      R0,[R1, #+0]
//   93   G_Attr = (G_attr*)__Get(GLOBAL);
        MOVS     R0,#+9
        BL       __Get
        LDR.W    R1,??main_1+0x10  ;; G_Attr
        STR      R0,[R1, #+0]
//   94   T_Attr = (T_attr*)__Get(TRIGGER);
        MOVS     R0,#+10
        BL       __Get
        LDR.W    R1,??main_1+0x14  ;; T_Attr
        STR      R0,[R1, #+0]
//   95   Load_Attr();                                 // 赋值Y_Attr等
        BL       Load_Attr
//   96   i = Load_Param(); 
        BL       Load_Param
        MOVS     R4,R0
//   97   if(i == 0)  // 读取预设开机参数
        BNE.N    ??main_3
//   98     __Display_Str(6*8, 30, GRN, PRN, "     Reload parameter form disk       ");
        LDR.W    R0,??main_1+0x18  ;; `?<Constant "      FPGA configurat...">` + 80
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        MOV      R2,#+2016
        B.N      ??main_4
        CFI CFA R13+40
//   99   else       
//  100     __Display_Str(6*8, 30, YEL, PRN, "     Parameter record not found       ");  
??main_3:
        LDR.W    R0,??main_1+0x1C  ;; `?<Constant "      FPGA configurat...">` + 120
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        MOVW     R2,#+2047
??main_4:
        MOVS     R1,#+30
        MOVS     R0,#+48
        BL       __Display_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
//  101 //  i = Load_Param(); // 读取预设开机参数 
//  102 
//  103   /*--------------------------- LICENCE_CTRL_DEMO --------------------------------
//  104   Offset = Seek_Proj(PROJECT_ID);
//  105   if(Offset >= 2048){                          // Project ID not found
//  106     Offset = Seek_Blank();
//  107     if(Offset == 2048){  
//  108       __Display_Str(6*8, 50, GRN, PRN,   "         Licence record full         ");
//  109       while (1){};
//  110     } else {
//  111       Result  = Add_Proj(PROJECT_ID, Offset);  // Set project ID
//  112       Result &= Add_Cnt(DEMOCNT, Offset);      // Set max demo run counter      
//  113       Result &= Add_Str((u32)PROJECT_STR, Offset); 
//  114       if(Result != 1){                                
//  115         __Display_Str(6*8,50,GRN, PRN,   "       Project ID writen error       ");
//  116         Delayms(500);
//  117       }
//  118     }
//  119   }
//  120   Licence = Get_Lic(Offset);                   // Get project licence record
//  121   if(__Ident(DEVELOPER_ID, PROJECT_ID, Licence)!= 1){
//  122     __Display_Str(6*8, 50, GRN, PRN,   "Please input project licence:00000000");
//  123     Licence = Input_Lic((6+29)*8, 50);         // Input Licence
//  124     if(__Ident(DEVELOPER_ID, PROJECT_ID, Licence)!=1)  Result = 0;
//  125     else{                                      // Licence correct
//  126       Result  = Add_Lic(Licence, Offset);            
//  127       if(Result == 1)                                
//  128         __Display_Str(6*8,50,GRN, PRN, "          Licence writen ok          ");
//  129       else  
//  130         __Display_Str(6*8,50,GRN, PRN, "         Licence writen error        ");
//  131       Delayms(500);
//  132     }
//  133     if(Result != 1){
//  134       __Display_Str(6*8, 30, GRN, PRN, "      Push any key to next step      ");
//  135       while(Key_Buffer == 0){};
//  136     }
//  137   }
//  138 //  --------------------------------------------------------------------------*/
//  139   
//  140   Beep_mS = 500;
        LDR.W    R0,??main_1+0x20  ;; Beep_mS
        MOV      R1,#+500
        STRH     R1,[R0, #+0]
//  141   Balance();
        BL       Balance
//  142   App_init();
        BL       App_init
//  143   Key_Buffer=0;
        LDR.W    R9,??main_1+0x24  ;; Key_Buffer
        MOVS     R0,#+0
        STRB     R0,[R9, #+0]
        MOV      R11,#+20
        LDR.W    R5,??main_1+0x28  ;; Detail
        LDR.W    R6,??main_1+0x2C  ;; Current
        LDR.W    R7,??main_1+0x30  ;; Title
        MOV      R8,#+80
        B.N      ??main_5
//  144   
//  145 //--------------------------------- 主循环 ------------------------------------- 
//  146   while (1){
//  147     if(PD_Cnt == 0){
//  148       __Set(BACKLIGHT, 0);     // 关闭背光
//  149       __Set(STANDBY, EN);      // 进入省电状态  
//  150     } else {
//  151       Synchro();                              // 同步显示各个轨迹波形数据
//  152       Count_FPS++;
//  153       if(Second != Sec_Cnt) {
//  154         Second = Sec_Cnt;
//  155         Result_FPS = Count_FPS;
//  156         Count_FPS = 0;
//  157         Update_Battery();
//  158         for(i=0; i<9; ++i)  Display_Value(i); // 每秒刷新测量值        
//  159       }
//  160       Display_Meter();
//  161       Display_Title();
//  162       if(Update){                             // 处理按键后需要刷新的项目
//  163         Update_Range();
//  164         Update_Base();
//  165         Update_Output();
//  166         Update_Trig();
//  167         Update_Mark();
//  168         __Set(BACKLIGHT, 10*(Title[BK_LIGHT][CLASS].Value+1));
//  169         if(Current != FILE) Update_View_Area();
//  170         _D_V_Source.Flag |= UPDAT;            // Updat delta V 
//  171         _Delta_V.Flag    |= UPDAT; 
//  172         _Delta_T.Flag    |= UPDAT;            // Updat delta T 
//  173         Update = 0;                           // Update finish
//  174       } 
//  175       Blink = 0;
//  176     }
//  177     if((_State.Value == HOLD)&&((__Get(FIFO_FULL)!= 0)||(__Get(FIFO_START)== 0))){
//  178 //    if((_State.Value == HOLD)&&(Twink== 1)){
//  179       _State.Value = 2; 
//  180       _State.Flag |= UPDAT;
//  181     }
//  182 //------------------------------ 按键处理循环 ---------------------------------- 
//  183     if(Key_Buffer) { 
//  184       if(PD_Cnt == 0)  App_init();          // 退出省电状态
//  185       PD_Cnt = 600;                         // 600秒
//  186       if(Key_Buffer == KEY_P){
//  187         _State.Value = (_State.Value == 0)? 1 : 0;       // "RUN/HOLD" 状态互换
//  188 //        _State.Value = 1-_State.Value;                 // "RUN/HOLD" 状态互换
//  189         _State.Flag |= UPDAT;                          // 置相应的更新标志
//  190         if((Current == FILE)&&(_Curr[2].Value == BUF)) reset_parameter();
//  191         if(_Mode == SGL){
//  192           for(i=0; i<4*X_SIZE; ++i)  TrackBuff[i] = 0; // 清除旧的显示波形
//  193           __Set(FIFO_CLR, W_PTR);                      // FIFO写指针复位
//  194         }
//  195       }
//  196       if(Key_Buffer== KEY2){
//  197         if((Current == TRACK1)||(Current == TRACK2)){
//  198           Delay_Cnt = 2000;
//  199           while (Delay_Cnt > 0){
//  200             if((__Get(KEY_STATUS)& KEY2_STATUS)!=0) break; 
//  201           }
//  202           if(Delay_Cnt == 0)  Calibrat(Current);             // 模拟通道校准
//  203         }
//  204       }
//  205       if(Key_Buffer== KEY3){
//  206         Save_Param();                             // 保存当前操作设置参数    
//  207         if(Current != FILE){
//  208           Print_Str(91, 0, 0x0405, PRN, "! Save the current setting !");
//  209           Delayms(500);
//  210         } 
//  211       }
//  212       if(Key_Buffer== KEY4){
//  213         if(Current == FILE){
//  214           Print_Str(230, 0, (SCRN<<8)+ TEXT1, PRN, " >   ");
//  215         if(_Curr[0].Value == SAVE){
//  216           switch (_Curr[2].Value){
//  217           case BMP:
//  218             i = Save_Bmp(_Curr[1].Value);
//  219             break;
//  220           case DAT:
//  221             i=Save_Dat(_Curr[1].Value);
//  222             Delayms(1000);
//  223             break;
//  224           case BUF:
//  225             i=Save_Buf(_Curr[1].Value);
//  226              break;
//  227           case CSV:
//  228             i=Save_Csv(_Curr[1].Value);
//  229             break;
//  230           }
//  231           _Curr[1].Value++;
//  232         } else { 
//  233           i=0;
//  234           if(_Curr[2].Value==DAT) i = Load_Dat(_Curr[1].Value);
//  235           if(_Curr[2].Value==BUF) i = Load_Buf(_Curr[1].Value);
//  236         }
//  237         if       (i == OK  ) Print_Str(230, 0, (SCRN<<8)+ TEXT1, PRN, " OK  ");  
//  238         else{ 
//  239           if     (i == EMPT) Print_Str(230, 0, (SCRN<<8)+ TEXT1, PRN, " NONE");  
//  240           else if(i == OVER) Print_Str(230, 0, (SCRN<<8)+ TEXT1, PRN, " FULL");  
//  241           else               Print_Str(230, 0, (SCRN<<8)+ TEXT1, PRN, " ERR ");  
//  242         }
//  243         Delayms(1000);
//  244         _Curr[1].Flag |= UPDAT; 
//  245         _Curr[2].Flag |= UPDAT;
//  246         }  
//  247       }             
//  248       if(Key_Buffer == K_ITEM_DEC){ //------------------ "Item-" Key
//  249         if(Current < METER_0){
//  250           _Curr[_Det].Flag |= UPDAT;
//  251           if(Current == TRACK1)  Current = VOLUME;
//  252           else                   Current --;
//  253           if(Current == RUNNING) Current --;               // Jump over Item 4
//  254           if(_Det >2)  _Det =0;
//  255           _Curr[_Det].Flag |= BLINK;
//  256           _Curr[0].Flag |= UPDAT;
//  257           _Curr[1].Flag |= UPDAT;
//  258           _Curr[2].Flag |= UPDAT;
//  259           _Curr[3].Flag |= UPDAT;
//  260         } else {
//  261           Meter[Current-METER_0].Flag |= UPDAT; 
//  262           if(Current == METER_0) Current = METER_8;
//  263           else                   Current --;
//  264           Meter[Current-METER_0].Flag |= BLINK;
//  265         }
//  266       }
//  267       if(Key_Buffer == K_ITEM_S){ //------------------ "Item_Select"  Key
//  268         if(Current < METER_0)  Current = METER_0;
//  269         else                   Current = TRACK1;
//  270       }
//  271       if(Key_Buffer == K_ITEM_INC){ //------------------ "Item+" Key
//  272         if(Current < METER_0){
//  273           _Curr[_Det].Flag |= UPDAT;
//  274           if(Current == VOLUME)  Current = TRACK1;
//  275           else                   Current ++;
//  276           if(Current == RUNNING) Current ++;              // Jump over RUNNING
//  277           if(_Det >2)    _Det =0;
//  278           _Curr[_Det].Flag |= BLINK;
//  279           _Curr[0].Flag |= UPDAT;
//  280           _Curr[1].Flag |= UPDAT;
//  281           _Curr[2].Flag |= UPDAT;
//  282           _Curr[3].Flag |= UPDAT;
//  283         } else {
//  284           Meter[Current-METER_0].Flag |= UPDAT;  
//  285           if(Current == METER_8) Current  = METER_0;
//  286           else                   Current ++;
//  287           Meter[Current-METER_0].Flag |= BLINK;
//  288         }
//  289       }
//  290       if(Key_Buffer == K_INDEX_DEC){ //--------------------- "Index-" Key 
//  291         if(Current < METER_0){
//  292           if((Current == TRIGG)&&(Detail[Current]==2)){         // 触发电平调节
//  293             if(V_Trigg[_Trigg[SOURCE].Value].Value > MIN_Y+4) 
//  294               V_Trigg[_Trigg[SOURCE].Value].Value--;
//  295           } else if((Current == BK_LIGHT)||(Current == VOLUME)){// 背光或音量调节
//  296             if(_Curr[1].Value > 0)   _Curr[1].Value--;
//  297           } else if((Current == T_BASE)&&(_Det == XPOSI)){      // X_POSI调节
//  298             if(_Curr[_Det].Value > 30) _Curr[_Det].Value -= 30; 
//  299             else if(_Curr[_Det].Value > 0) _Curr[_Det].Value--;
//  300             _X_View.Flag |= UPDAT;                              // 刷新X_View
//  301           } else {                                              // 当前项为其他
//  302             if(_Curr[_Det].Value > 0) _Curr[_Det].Value--; 
//  303             else if(_Curr[_Det].MARK & CIRC) _Curr[_Det].Value =_Curr[_Det].Limit;
//  304           }
//  305           if((Current == T_BASE)&&(_Det == MODE)){     // T_BASE MODE 选择
//  306             Title[RUNNING][STATE].Value = RUN;         // STATE = RUNNING 
//  307             Title[RUNNING][STATE].Flag |= UPDAT;       // 刷新 RUNNING STATE
//  308           }
//  309           if(((Current == OUTPUT)&&(Title[OUTPUT][SOURCE].Value != DIGI))&&
//  310             (Title[OUTPUT][FRQN].Value > 10)) 
//  311             Title[OUTPUT][FRQN].Value = 10;            // 模拟信号频率上限为20KHz
//  312           if((Current == FILE)&&(_Curr[0].Value == LOAD)){ 
//  313             if(_Curr[2].Value == BMP) _Curr[2].Value = BUF;  // 只能Load Dat,Buf文件
//  314             if(_Curr[2].Value == CSV) _Curr[2].Value = BUF;  // 只能Load Dat,Buf文件
//  315           }
//  316           _Curr[0].Flag |= UPDAT;
//  317           _Curr[1].Flag |= UPDAT;
//  318           _Curr[2].Flag |= UPDAT;
//  319           _Curr[3].Flag |= UPDAT;
//  320         } else {
//  321           Meter[Current-METER_0].Flag |= UPDAT;
//  322           if(Meter[Current-METER_0].Item  > VBT) 
//  323             Meter[Current-METER_0].Item -= 1;          // 改变测量项目 
//  324           else                     
//  325             Meter[Current-METER_0].Item  = TL;//MIN;
//  326           if(Meter[Current-METER_0].Item == FPS) 
//  327             Meter[Current-METER_0].Track = 4;
//  328           if(Meter[Current-METER_0].Item == TL)//MIN) 
//  329             Meter[Current-METER_0].Track = 0;
//  330         }
//  331       }
//  332       if(Key_Buffer == K_INDEX_S){ //----------------- "Index_Select" Key
//  333         if(Current < METER_0){                         // 改变Detail
//  334           _Curr[_Det].Flag |= UPDAT;
//  335           if(_Det < 3)    _Det += 1;
//  336           else            _Det  = 0;
//  337           if(_Curr[_Det].MARK & NOT)                        _Det  = 0; 
//  338           if(_Curr[_Det].MARK & NUM2)                       _Det  = 0; 
//  339           if((_Curr[_Det].MARK & NUM3)&&(Current != FILE))  _Det  = 0;  
//  340           _Curr[_Det].Flag |= BLINK;
//  341         } else {                                       // 改变测量对象
//  342           Meter[Current-METER_0].Flag |= UPDAT;
//  343           if(Meter[Current-METER_0].Track <=  TRACK4) 
//  344             Meter[Current-METER_0].Track += 1;
//  345           if(Meter[Current-METER_0].Track > TRACK4) 
//  346             Meter[Current-METER_0].Track  = TRACK1;
//  347         }
//  348       }
//  349       if(Key_Buffer == K_INDEX_INC){ //--------------------- "Index+" Key 
//  350         if(Current < METER_0){
//  351           if((Current == TRIGG)&&(Detail[Current]==2)){         // 触发电平调节
//  352             if(V_Trigg[_Trigg[SOURCE].Value].Value < MAX_Y-4) 
//  353               V_Trigg[_Trigg[SOURCE].Value].Value++;
//  354           } else if((Current == BK_LIGHT)||(Current == VOLUME)){// 背光或音量调节
//  355             if(_Curr[1].Value < _Curr[1].Limit)   _Curr[1].Value++;
//  356           } else if((Current == T_BASE)&&(_Det == XPOSI)){      // X_POSI调节
//  357             if(_Curr[_Det].Value <(_Curr[_Det].Limit-30))  _Curr[_Det].Value += 30; 
//  358             else if(_Curr[_Det].Value < _Curr[_Det].Limit) _Curr[_Det].Value ++;
//  359             _X_View.Flag |= UPDAT;                      
//  360           } else {                                              // 当前项为其他
//  361             if(_Curr[_Det].Value < _Curr[_Det].Limit)  _Curr[_Det].Value++;
//  362             else if(_Curr[_Det].MARK & CIRC)   _Curr[_Det].Value  = 0;
//  363           }
//  364           if((Current == T_BASE)&&(_Det == MODE)){     // T_BASE MODE 选择
//  365             Title[RUNNING][STATE].Value = RUN;         // STATE = RUNNING 
//  366             Title[RUNNING][STATE].Flag |= UPDAT;       // 刷新 RUNNING STATE
//  367           }
//  368           if((Current == OUTPUT)&&(Title[OUTPUT][SOURCE].Value != DIGI)){
//  369             if(Title[OUTPUT][FRQN].Value > 10) 
//  370               Title[OUTPUT][FRQN].Value = 10;          // 模拟信号频率上限为20KHz
//  371           }
//  372           if((Current == FILE)&&(_Curr[0].Value == 1)){  // 只能Load Dat,Buf文件
//  373             if(_Curr[2].Value == BMP) _Curr[2].Value = DAT;
//  374             if(_Curr[2].Value == CSV) _Curr[2].Value = DAT;
//  375           }
//  376           _Curr[0].Flag |= UPDAT;
//  377           _Curr[1].Flag |= UPDAT;
//  378           _Curr[2].Flag |= UPDAT;
//  379           _Curr[3].Flag |= UPDAT;
//  380         } else {
//  381           Meter[Current-METER_0].Flag |= UPDAT;
//  382           if(Meter[Current-METER_0].Item < TL)//MIN)  
//  383             Meter[Current-METER_0].Item += 1;          // 改变测量项目
//  384           else                     
//  385             Meter[Current-METER_0].Item  = VBT;
??main_6:
        MOVS     R2,#+0
        STRB     R2,[R1, #+1]
//  386           if(Meter[Current-METER_0].Item == VBT) 
//  387             Meter[Current-METER_0].Track = 4;
??main_7:
        MOVS     R2,#+4
        STRB     R2,[R0, #-152]
//  388           if(Meter[Current-METER_0].Item == VPP) 
??main_8:
        LDRB     R1,[R1, #+1]
        CMP      R1,#+2
        BNE.N    ??main_9
//  389             Meter[Current-METER_0].Track = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #-152]
//  390         }
//  391       }
//  392       Key_Buffer=0;
??main_9:
        MOVS     R0,#+0
        STRB     R0,[R9, #+0]
//  393       Update = 1;
        LDR.W    R0,??main_1+0x34  ;; Update
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
??main_5:
        LDR.W    R0,??main_1+0x38  ;; PD_Cnt
        LDRH     R0,[R0, #+0]
        CBNZ     R0,??main_10
        MOVS     R1,#+0
        MOVS     R0,#+2
        BL       __Set
        MOVS     R1,#+1
        MOVS     R0,#+20
        BL       __Set
        B.N      ??main_11
??main_10:
        BL       Synchro
        ADD      R10,R10,#+1
        UXTH     R10,R10
        LDR      R0,[SP, #+0]
        LDR.W    R1,??main_1+0x3C  ;; Sec_Cnt
        LDRH     R1,[R1, #+0]
        UXTH     R0,R0
        CMP      R0,R1
        BEQ.N    ??main_12
        LDR.W    R0,??main_1+0x3C  ;; Sec_Cnt
        LDRH     R0,[R0, #+0]
        STR      R0,[SP, #+0]
        LDR.W    R0,??main_1+0x40  ;; Result_FPS
        STRH     R10,[R0, #+0]
        MOV      R10,#+0
        BL       Update_Battery
        MOVS     R4,#+0
??main_13:
        UXTB     R0,R4
        BL       Display_Value
        ADDS     R4,R4,#+1
        CMP      R4,#+9
        BLT.N    ??main_13
??main_12:
        BL       Display_Meter
        BL       Display_Title
        LDR.W    R0,??main_1+0x34  ;; Update
        LDRB     R0,[R0, #+0]
        CBZ      R0,??main_14
        BL       Update_Range
        BL       Update_Base
        BL       Update_Output
        BL       Update_Trig
        BL       Update_Mark
        LDRSH    R0,[R7, #+916]
        ADDS     R0,R0,#+1
        MOVS     R1,#+10
        MULS     R1,R0,R1
        MOVS     R0,#+2
        BL       __Set
        LDRB     R0,[R6, #+0]
        CMP      R0,#+9
        IT       NE 
        BLNE     Update_View_Area
        LDRB     R0,[R7, #+698]
        ORR      R0,R0,#0x2
        STRB     R0,[R7, #+698]
        LDRB     R0,[R7, #+718]
        ORR      R0,R0,#0x2
        STRB     R0,[R7, #+718]
        LDRB     R0,[R7, #+878]
        ORR      R0,R0,#0x2
        STRB     R0,[R7, #+878]
        LDR.W    R0,??main_1+0x34  ;; Update
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
??main_14:
        LDR.W    R0,??main_1+0x44  ;; Blink
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
??main_11:
        LDRSH    R0,[R7, #+336]
        CMP      R0,#+1
        BNE.N    ??main_15
        MOVS     R0,#+3
        BL       __Get
        CBNZ     R0,??main_16
        MOVS     R0,#+2
        BL       __Get
        CBNZ     R0,??main_15
??main_16:
        MOVS     R0,#+2
        STRH     R0,[R7, #+336]
        ADD      R0,R7,#+338
        LDRB     R0,[R0, #+0]
        ORR      R0,R0,#0x2
        ADD      R1,R7,#+338
        STRB     R0,[R1, #+0]
??main_15:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+0
        BEQ.W    ??main_5
        LDR.W    R0,??main_1+0x38  ;; PD_Cnt
        LDRH     R0,[R0, #+0]
        CBNZ     R0,??main_17
        BL       App_init
??main_17:
        LDR.W    R0,??main_1+0x38  ;; PD_Cnt
        MOV      R1,#+600
        STRH     R1,[R0, #+0]
        LDRB     R0,[R9, #+0]
        CMP      R0,#+1
        BNE.N    ??main_18
        LDRSH    R1,[R7, #+336]
        SUBS     R0,R1,#+1
        SBCS     R0,R0,R0
        LSRS     R0,R0,#+31
        STRH     R0,[R7, #+336]
        ADD      R0,R7,#+338
        LDRB     R0,[R0, #+0]
        ORR      R0,R0,#0x2
        ADD      R1,R7,#+338
        STRB     R0,[R1, #+0]
        LDRB     R0,[R6, #+0]
        CMP      R0,#+9
        BNE.N    ??main_19
        LDRSH    R0,[R7, #+776]
        CMP      R0,#+2
        IT       EQ 
        BLEQ     reset_parameter
??main_19:
        LDRSH    R0,[R7, #+416]
        CMP      R0,#+2
        BNE.N    ??main_18
        MOV      R1,#+1200
        LDR.W    R0,??main_1+0x48  ;; TrackBuff
        BL       __aeabi_memclr
        MOV      R4,#+1200
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
??main_18:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+2
        BNE.N    ??main_20
        LDRB     R0,[R6, #+0]
        CBZ      R0,??main_21
        CMP      R0,#+1
        BNE.N    ??main_20
??main_21:
        LDR.W    R0,??main_1+0x4C  ;; Delay_Cnt
        MOV      R1,#+2000
        STRH     R1,[R0, #+0]
??main_22:
        LDR.W    R0,??main_1+0x4C  ;; Delay_Cnt
        LDRH     R0,[R0, #+0]
        CBZ      R0,??main_23
        MOVS     R0,#+4
        BL       __Get
        TST      R0,#0x2000
        BEQ.N    ??main_22
??main_23:
        LDR.W    R0,??main_1+0x4C  ;; Delay_Cnt
        LDRH     R0,[R0, #+0]
        CBNZ     R0,??main_20
        LDRB     R0,[R6, #+0]
        BL       Calibrat
??main_20:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+3
        BNE.N    ??main_24
        BL       Save_Param
        LDRB     R0,[R6, #+0]
        CMP      R0,#+9
        BEQ.N    ??main_24
        LDR.W    R0,??main_1+0x50  ;; `?<Constant "      FPGA configurat...">` + 160
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        MOVW     R2,#+1029
        MOVS     R1,#+0
        MOVS     R0,#+91
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
        MOV      R0,#+500
        BL       Delayms
??main_24:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+4
        BNE.W    ??main_25
        LDRB     R0,[R6, #+0]
        CMP      R0,#+9
        BNE.W    ??main_25
        LDR.W    R0,??main_1+0x54  ;; `?<Constant "      FPGA configurat...">` + 192
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        MOVW     R2,#+1290
        MOVS     R1,#+0
        MOVS     R0,#+230
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
        LDRB     R0,[R6, #+0]
        MLA      R0,R0,R8,R7
        LDRSH    R1,[R0, #+16]
        CBNZ     R1,??main_26
        LDRSH    R1,[R0, #+56]
        CBZ      R1,??main_27
        CMP      R1,#+1
        BEQ.N    ??main_28
        CMP      R1,#+2
        BEQ.N    ??main_29
        CMP      R1,#+3
        BEQ.N    ??main_30
        B.N      ??main_31
??main_27:
        LDRH     R0,[R0, #+36]
        UXTB     R0,R0
        BL       Save_Bmp
        B.N      ??main_32
??main_28:
        LDRH     R0,[R0, #+36]
        UXTB     R0,R0
        BL       Save_Dat
        MOVS     R4,R0
        MOV      R0,#+1000
        BL       Delayms
        B.N      ??main_31
??main_29:
        LDRH     R0,[R0, #+36]
        UXTB     R0,R0
        BL       Save_Buf
        B.N      ??main_32
??main_30:
        LDRH     R0,[R0, #+36]
        UXTB     R0,R0
        BL       Save_Csv
??main_32:
        MOVS     R4,R0
??main_31:
        LDRB     R0,[R6, #+0]
        MLA      R0,R0,R8,R7
        LDRH     R1,[R0, #+36]
        ADDS     R1,R1,#+1
        STRH     R1,[R0, #+36]
        B.N      ??main_33
??main_26:
        MOVS     R4,#+0
        LDRSH    R1,[R0, #+56]
        CMP      R1,#+1
        BNE.N    ??main_34
        LDRH     R0,[R0, #+36]
        UXTB     R0,R0
        BL       Load_Dat
        MOVS     R4,R0
??main_34:
        LDRB     R0,[R6, #+0]
        MLA      R0,R0,R8,R7
        LDRSH    R1,[R0, #+56]
        CMP      R1,#+2
        BNE.N    ??main_33
        LDRH     R0,[R0, #+36]
        UXTB     R0,R0
        BL       Load_Buf
        MOVS     R4,R0
??main_33:
        CBNZ     R4,??main_35
        LDR.W    R0,??main_1+0x58  ;; `?<Constant "      FPGA configurat...">` + 200
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        MOVW     R2,#+1290
        B.N      ??main_36
        CFI CFA R13+40
??main_35:
        CMP      R4,#+4
        BNE.N    ??main_37
        LDR.W    R0,??main_1+0x5C  ;; `?<Constant "      FPGA configurat...">` + 208
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        MOVW     R2,#+1290
        B.N      ??main_36
        CFI CFA R13+40
??main_37:
        CMP      R4,#+3
        BNE.N    ??main_38
        LDR.W    R0,??main_1+0x60  ;; `?<Constant "      FPGA configurat...">` + 216
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        MOVW     R2,#+1290
        B.N      ??main_36
        CFI CFA R13+40
??main_38:
        LDR.W    R0,??main_1+0x64  ;; `?<Constant "      FPGA configurat...">` + 224
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        MOVW     R2,#+1290
??main_36:
        MOVS     R1,#+0
        MOVS     R0,#+230
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
        MOV      R0,#+1000
        BL       Delayms
        LDRB     R0,[R6, #+0]
        MLA      R0,R0,R8,R7
        LDRB     R1,[R0, #+38]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+38]
        LDRB     R1,[R0, #+58]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+58]
??main_25:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+9
        BNE.N    ??main_39
        LDRB     R0,[R6, #+0]
        MOVS     R1,R0
        CMP      R0,#+13
        BCS.N    ??main_40
        LDRB     R2,[R1, R5]
        MLA      R1,R1,R8,R7
        MLA      R1,R2,R11,R1
        LDRB     R2,[R1, #+18]
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #+18]
        CBNZ     R0,??main_41
        MOVS     R1,#+12
        B.N      ??main_42
??main_41:
        SUBS     R1,R0,#+1
        UXTB     R1,R1
        CMP      R1,#+4
        IT       EQ 
        MOVEQ    R1,#+3
??main_42:
        STRB     R1,[R6, #+0]
        LDRB     R0,[R1, R5]
        CMP      R0,#+3
        BCC.N    ??main_43
        MOVS     R0,#+0
        STRB     R0,[R1, R5]
??main_43:
        MLA      R0,R1,R8,R7
        LDRB     R1,[R1, R5]
        MLA      R1,R1,R11,R0
        LDRB     R2,[R1, #+18]
        ORR      R2,R2,#0x1
        STRB     R2,[R1, #+18]
        LDRB     R1,[R0, #+18]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+18]
        LDRB     R1,[R0, #+38]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+38]
        LDRB     R1,[R0, #+58]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+58]
        LDRB     R1,[R0, #+78]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+78]
        B.N      ??main_39
??main_40:
        MOVS     R2,#+12
        LDR.W    R3,??main_1+0x68  ;; Meter
        MLA      R1,R1,R2,R3
        LDRB     R2,[R1, #-145]
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #-145]
        CMP      R0,#+13
        BNE.N    ??main_44
        MOVS     R0,#+21
        B.N      ??main_45
??main_44:
        SUBS     R0,R0,#+1
??main_45:
        STRB     R0,[R6, #+0]
        UXTB     R0,R0
        MOVS     R1,#+12
        LDR.W    R2,??main_1+0x68  ;; Meter
        MLA      R0,R0,R1,R2
        LDRB     R1,[R0, #-145]
        ORR      R1,R1,#0x1
        STRB     R1,[R0, #-145]
??main_39:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+10
        BNE.N    ??main_46
        LDRB     R0,[R6, #+0]
        CMP      R0,#+13
        BCS.N    ??main_47
        MOVS     R0,#+13
        B.N      ??main_48
??main_47:
        MOVS     R0,#+0
??main_48:
        STRB     R0,[R6, #+0]
??main_46:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+8
        BNE.N    ??main_49
        LDRB     R0,[R6, #+0]
        MOVS     R1,R0
        CMP      R0,#+13
        BCS.N    ??main_50
        LDRB     R2,[R1, R5]
        MLA      R1,R1,R8,R7
        MLA      R1,R2,R11,R1
        LDRB     R2,[R1, #+18]
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #+18]
        CMP      R0,#+12
        BNE.N    ??main_51
        MOVS     R1,#+0
        B.N      ??main_52
??main_51:
        ADDS     R1,R0,#+1
        UXTB     R1,R1
        CMP      R1,#+4
        IT       EQ 
        MOVEQ    R1,#+5
??main_52:
        STRB     R1,[R6, #+0]
        LDRB     R0,[R1, R5]
        CMP      R0,#+3
        BCC.N    ??main_53
        MOVS     R0,#+0
        STRB     R0,[R1, R5]
??main_53:
        MLA      R0,R1,R8,R7
        LDRB     R1,[R1, R5]
        MLA      R1,R1,R11,R0
        LDRB     R2,[R1, #+18]
        ORR      R2,R2,#0x1
        STRB     R2,[R1, #+18]
        LDRB     R1,[R0, #+18]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+18]
        LDRB     R1,[R0, #+38]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+38]
        LDRB     R1,[R0, #+58]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+58]
        LDRB     R1,[R0, #+78]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+78]
        B.N      ??main_49
??main_50:
        MOVS     R2,#+12
        LDR.W    R3,??main_1+0x68  ;; Meter
        MLA      R1,R1,R2,R3
        LDRB     R2,[R1, #-145]
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #-145]
        CMP      R0,#+21
        BNE.N    ??main_54
        MOVS     R0,#+13
        B.N      ??main_55
??main_54:
        ADDS     R0,R0,#+1
??main_55:
        STRB     R0,[R6, #+0]
        LDRB     R0,[R6, #+0]
        MOVS     R1,#+12
        LDR.W    R2,??main_1+0x68  ;; Meter
        MLA      R0,R0,R1,R2
        LDRB     R1,[R0, #-145]
        ORR      R1,R1,#0x1
        STRB     R1,[R0, #-145]
??main_49:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+5
        BNE.W    ??main_56
        LDRB     R0,[R6, #+0]
        CMP      R0,#+13
        BCS.W    ??main_57
        CMP      R0,#+7
        BNE.N    ??main_58
        LDRB     R1,[R5, #+7]
        CMP      R1,#+2
        BNE.N    ??main_59
        LDRSH    R1,[R7, #+576]
        LDR.W    R2,??main_1+0x6C  ;; V_Trigg
        LDRSH    R2,[R2, R1, LSL #+2]
        CMP      R2,#+18
        BLT.N    ??main_60
        LDR.W    R3,??main_1+0x6C  ;; V_Trigg
        SUBS     R2,R2,#+1
        STRH     R2,[R3, R1, LSL #+2]
        B.N      ??main_60
??main_58:
        CMP      R0,#+11
        BEQ.N    ??main_61
        CMP      R0,#+12
        BNE.N    ??main_62
??main_61:
        MLA      R1,R0,R8,R7
        LDRSH    R2,[R1, #+36]
        CMP      R2,#+1
        BLT.N    ??main_63
        SUBS     R2,R2,#+1
        STRH     R2,[R1, #+36]
        B.N      ??main_63
??main_62:
        CMP      R0,#+5
        BNE.N    ??main_59
        LDRB     R1,[R5, #+5]
        CMP      R1,#+2
        BNE.N    ??main_59
        LDRSH    R1,[R7, #+456]
        CMP      R1,#+31
        BLT.N    ??main_64
        SUBS     R1,R1,#+30
        STRH     R1,[R7, #+456]
        B.N      ??main_65
??main_64:
        CMP      R1,#+1
        BLT.N    ??main_65
        SUBS     R1,R1,#+1
        STRH     R1,[R7, #+456]
??main_65:
        ADD      R1,R7,#+478
        LDRB     R1,[R1, #+0]
        ORR      R1,R1,#0x2
        ADD      R2,R7,#+478
??main_66:
        STRB     R1,[R2, #+0]
        B.N      ??main_60
??main_59:
        LDRB     R12,[R0, R5]
        MLA      R1,R0,R8,R7
        MLA      R2,R12,R11,R1
        LDRSH    R1,[R2, #+16]
        CMP      R1,#+1
        BLT.N    ??main_67
        LDRH     R1,[R2, #+16]
        SUBS     R1,R1,#+1
        STRH     R1,[R2, #+16]
        B.N      ??main_63
??main_67:
        LDRB     R1,[R2, #+10]
        TST      R1,#0x10
        ITT      NE 
        LDRHNE   R1,[R2, #+8]
        STRHNE   R1,[R2, #+16]
??main_63:
        CMP      R0,#+5
        BNE.N    ??main_68
        LDRB     R1,[R5, #+5]
        CBNZ     R1,??main_60
        STRH     R1,[R7, #+336]
        ADD      R1,R7,#+338
        LDRB     R1,[R1, #+0]
        ORR      R1,R1,#0x2
        ADD      R2,R7,#+338
        B.N      ??main_66
??main_68:
        CMP      R0,#+6
        BNE.N    ??main_69
        LDRSH    R1,[R7, #+496]
        CMP      R1,#+3
        BEQ.N    ??main_60
        LDRSH    R1,[R7, #+516]
        CMP      R1,#+11
        BLT.N    ??main_60
        MOVS     R1,#+10
        STRH     R1,[R7, #+516]
        B.N      ??main_60
??main_69:
        CMP      R0,#+9
        BNE.N    ??main_60
        LDRSH    R1,[R7, #+736]
        CMP      R1,#+1
        BNE.N    ??main_60
        LDRSH    R1,[R7, #+776]
        CBNZ     R1,??main_70
        MOVS     R1,#+2
        STRH     R1,[R7, #+776]
        B.N      ??main_60
??main_70:
        CMP      R1,#+3
        BNE.N    ??main_60
        MOVS     R1,#+2
        STRH     R1,[R7, #+776]
??main_60:
        MLA      R1,R0,R8,R7
        LDRB     R0,[R1, #+18]
        ORR      R0,R0,#0x2
        STRB     R0,[R1, #+18]
        LDRB     R0,[R1, #+38]
        ORR      R0,R0,#0x2
        STRB     R0,[R1, #+38]
        LDRB     R0,[R1, #+58]
        ORR      R0,R0,#0x2
        STRB     R0,[R1, #+58]
        LDRB     R0,[R1, #+78]
        ORR      R0,R0,#0x2
        STRB     R0,[R1, #+78]
        B.N      ??main_56
??main_57:
        MOVS     R3,R0
        MOVS     R0,#+12
        LDR.N    R1,??main_1+0x68  ;; Meter
        MLA      R0,R3,R0,R1
        SUB      R1,R0,#+152
        LDRB     R2,[R1, #+7]
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #+7]
        LDRB     R2,[R1, #+1]
        CBZ      R2,??main_71
        SUBS     R2,R2,#+1
        STRB     R2,[R1, #+1]
        UXTB     R2,R2
        CMP      R2,#+1
        BNE.N    ??main_72
        MOVS     R2,#+4
        STRB     R2,[R0, #-152]
??main_72:
        LDRB     R1,[R1, #+1]
        CMP      R1,#+11
        BNE.N    ??main_56
??main_73:
        MOVS     R1,#+0
        STRB     R1,[R0, #-152]
??main_56:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+7
        BNE.N    ??main_74
        LDRB     R0,[R6, #+0]
        MOVS     R3,R0
        CMP      R0,#+13
        BCS.N    ??main_75
        LDRB     R12,[R3, R5]
        MLA      R1,R3,R8,R7
        MLA      R2,R12,R11,R1
        LDRB     LR,[R2, #+18]
        ORR      LR,LR,#0x2
        STRB     LR,[R2, #+18]
        CMP      R12,#+3
        BCS.N    ??main_76
        ADD      R2,R12,#+1
        B.N      ??main_77
??main_71:
        MOVS     R2,#+11
        STRB     R2,[R1, #+1]
        B.N      ??main_73
??main_76:
        MOVS     R2,#+0
??main_77:
        STRB     R2,[R3, R5]
        LDRB     R2,[R3, R5]
        MLA      R2,R2,R11,R1
        LDRB     R2,[R2, #+10]
        TST      R2,#0x80
        BEQ.N    ??main_78
        MOVS     R2,#+0
        STRB     R2,[R3, R5]
??main_78:
        LDRB     R2,[R3, R5]
        MLA      R2,R2,R11,R1
        LDRB     R2,[R2, #+10]
        TST      R2,#0x1
        BEQ.N    ??main_79
        MOVS     R2,#+0
        STRB     R2,[R3, R5]
??main_79:
        LDRB     R2,[R3, R5]
        MLA      R2,R2,R11,R1
        LDRB     R2,[R2, #+10]
        TST      R2,#0x2
        BEQ.N    ??main_80
        CMP      R0,#+9
        BEQ.N    ??main_80
        MOVS     R0,#+0
        STRB     R0,[R3, R5]
??main_80:
        LDRB     R0,[R3, R5]
        MLA      R0,R0,R11,R1
        LDRB     R1,[R0, #+18]
        ORR      R1,R1,#0x1
        STRB     R1,[R0, #+18]
        B.N      ??main_74
??main_75:
        MOVS     R0,#+12
        LDR.N    R1,??main_1+0x68  ;; Meter
        MLA      R0,R3,R0,R1
        SUB      R1,R0,#+152
        LDRB     R2,[R1, #+7]
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #+7]
        LDRB     R1,[R0, #-152]
        CMP      R1,#+4
        BCS.N    ??main_81
        ADDS     R1,R1,#+1
        STRB     R1,[R0, #-152]
??main_81:
        LDRB     R1,[R0, #-152]
        CMP      R1,#+4
        BCC.N    ??main_74
        MOVS     R1,#+0
        STRB     R1,[R0, #-152]
??main_74:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+6
        BNE.W    ??main_9
        LDRB     R0,[R6, #+0]
        CMP      R0,#+13
        BCS.W    ??main_82
        CMP      R0,#+7
        BNE.N    ??main_83
        LDRB     R1,[R5, #+7]
        CMP      R1,#+2
        BNE.N    ??main_84
        LDRSH    R1,[R7, #+576]
        LDR.N    R2,??main_1+0x6C  ;; V_Trigg
        LDRSH    R2,[R2, R1, LSL #+2]
        CMP      R2,#+209
        BGE.N    ??main_85
        LDR.N    R3,??main_1+0x6C  ;; V_Trigg
        ADDS     R2,R2,#+1
        STRH     R2,[R3, R1, LSL #+2]
        B.N      ??main_85
??main_83:
        CMP      R0,#+11
        BEQ.N    ??main_86
        CMP      R0,#+12
        BNE.N    ??main_87
??main_86:
        MLA      R1,R0,R8,R7
        LDRSH    R2,[R1, #+36]
        LDRSH    R3,[R1, #+28]
        CMP      R2,R3
        BGE.N    ??main_88
        LDRH     R2,[R1, #+36]
        ADDS     R2,R2,#+1
        STRH     R2,[R1, #+36]
        B.N      ??main_88
??main_87:
        CMP      R0,#+5
        BNE.N    ??main_84
        LDRB     R1,[R5, #+5]
        CMP      R1,#+2
        BNE.N    ??main_84
        LDRSH    R1,[R7, #+448]
        LDRSH    R2,[R7, #+456]
        SUB      R3,R1,#+30
        CMP      R2,R3
        BGE.N    ??main_89
        ADD      R1,R2,#+30
        STRH     R1,[R7, #+456]
        B.N      ??main_90
??main_89:
        CMP      R2,R1
        BGE.N    ??main_90
        ADDS     R1,R2,#+1
        STRH     R1,[R7, #+456]
??main_90:
        ADD      R1,R7,#+478
        LDRB     R1,[R1, #+0]
        ORR      R1,R1,#0x2
        ADD      R2,R7,#+478
??main_91:
        STRB     R1,[R2, #+0]
        B.N      ??main_85
??main_84:
        MLA      R1,R0,R8,R7
        LDRB     R2,[R0, R5]
        MLA      R1,R2,R11,R1
        LDRSH    R2,[R1, #+16]
        LDRSH    R3,[R1, #+8]
        CMP      R2,R3
        BGE.N    ??main_92
        LDRH     R2,[R1, #+16]
        ADDS     R2,R2,#+1
        B.N      ??main_93
??main_92:
        LDRB     R2,[R1, #+10]
        TST      R2,#0x10
        BEQ.N    ??main_88
        MOVS     R2,#+0
??main_93:
        STRH     R2,[R1, #+16]
??main_88:
        CMP      R0,#+5
        BNE.N    ??main_94
        LDRB     R1,[R5, #+5]
        CBNZ     R1,??main_85
        STRH     R1,[R7, #+336]
        ADD      R1,R7,#+338
        LDRB     R1,[R1, #+0]
        ORR      R1,R1,#0x2
        ADD      R2,R7,#+338
        B.N      ??main_91
??main_94:
        CMP      R0,#+6
        BNE.N    ??main_95
        LDRSH    R1,[R7, #+496]
        CMP      R1,#+3
        BEQ.N    ??main_85
        LDRSH    R1,[R7, #+516]
        CMP      R1,#+11
        BLT.N    ??main_85
        MOVS     R1,#+10
        STRH     R1,[R7, #+516]
        B.N      ??main_85
??main_95:
        CMP      R0,#+9
        BNE.N    ??main_85
        LDRSH    R1,[R7, #+736]
        CMP      R1,#+1
        BNE.N    ??main_85
        LDRSH    R1,[R7, #+776]
        CBNZ     R1,??main_96
        MOVS     R1,#+1
        STRH     R1,[R7, #+776]
        B.N      ??main_85
??main_96:
        CMP      R1,#+3
        BNE.N    ??main_85
        MOVS     R1,#+1
        STRH     R1,[R7, #+776]
??main_85:
        MLA      R1,R0,R8,R7
        LDRB     R0,[R1, #+18]
        ORR      R0,R0,#0x2
        STRB     R0,[R1, #+18]
        LDRB     R0,[R1, #+38]
        ORR      R0,R0,#0x2
        STRB     R0,[R1, #+38]
        LDRB     R0,[R1, #+58]
        ORR      R0,R0,#0x2
        STRB     R0,[R1, #+58]
        LDRB     R0,[R1, #+78]
        ORR      R0,R0,#0x2
        STRB     R0,[R1, #+78]
        B.W      ??main_9
??main_82:
        MOVS     R3,R0
        MOVS     R0,#+12
        LDR.N    R1,??main_1+0x68  ;; Meter
        MLA      R0,R3,R0,R1
        SUB      R1,R0,#+152
        LDRB     R2,[R1, #+7]
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #+7]
        LDRB     R2,[R1, #+1]
        CMP      R2,#+11
        BCS.W    ??main_6
        ADDS     R2,R2,#+1
        STRB     R2,[R1, #+1]
        UXTB     R2,R2
        CMP      R2,#+0
        BNE.W    ??main_8
        B.W      ??main_7
        Nop      
        DATA
??main_1:
        DC32     `?<Constant "      FPGA configurat...">`
        DC32     `?<Constant "      FPGA configurat...">` + 40
        DC32     Y_Attr
        DC32     X_Attr
        DC32     G_Attr
        DC32     T_Attr
        DC32     `?<Constant "      FPGA configurat...">` + 80
        DC32     `?<Constant "      FPGA configurat...">` + 120
        DC32     Beep_mS
        DC32     Key_Buffer
        DC32     Detail
        DC32     Current
        DC32     Title
        DC32     Update
        DC32     PD_Cnt
        DC32     Sec_Cnt
        DC32     Result_FPS
        DC32     Blink
        DC32     TrackBuff
        DC32     Delay_Cnt
        DC32     `?<Constant "      FPGA configurat...">` + 160
        DC32     `?<Constant "      FPGA configurat...">` + 192
        DC32     `?<Constant "      FPGA configurat...">` + 200
        DC32     `?<Constant "      FPGA configurat...">` + 208
        DC32     `?<Constant "      FPGA configurat...">` + 216
        DC32     `?<Constant "      FPGA configurat...">` + 224
        DC32     Meter
        DC32     V_Trigg
        CFI EndBlock cfiBlock0
//  394     }
//  395   }
//  396 }

        END
//  397 /*********************************  END OF FILE  ******************************/
// 
//   252 bytes in section .rodata
// 2 468 bytes in section .text
// 
// 2 468 bytes of CODE  memory
//   252 bytes of CONST memory
//
//Errors: none
//Warnings: 1
