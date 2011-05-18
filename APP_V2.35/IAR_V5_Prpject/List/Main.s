///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  13:45:38 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\APP_V2.32\source\Main.c                       /
//    Command line =  E:\DS0203\APP_V2.32\source\Main.c -lA                   /
//                    E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\ -o             /
//                    E:\DS0203\APP_V2.32\IAR_V5_Prpject\Obj\ --debug         /
//                    --endian=little --cpu=Cortex-M3 --fpu=None              /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.0 Evaluation\ARM\INC\DLib_Config_Full.h"    /
//                    -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\..\FWLib\inc\  /
//                    -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\..\USBLib\inc\ /
//                     -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\include\ -I   /
//                    "C:\Program Files\IAR Systems\Embedded Workbench 5.0    /
//                    Evaluation\ARM\INC\" -Ohs                               /
//    List file    =  E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\Main.s          /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Main

        EXTERN App_init
        EXTERN Beep_mS
        EXTERN Blink
        EXTERN Calibrat
        EXTERN Current
        EXTERN Delayms
        EXTERN Detail
        EXTERN Display_Meter
        EXTERN Display_Title
        EXTERN Display_Value
        EXTERN G_Attr
        EXTERN Key_Buffer
        EXTERN Load_Attr
        EXTERN Load_Dat
        EXTERN Load_Parameter
        EXTERN Meter
        EXTERN NVIC_SetVectorTable
        EXTERN PD_Cnt
        EXTERN Print_Str
        EXTERN Result_FPS
        EXTERN Save_Bmp
        EXTERN Save_Dat
        EXTERN Save_Parameter
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
        DC8 "     DS203 Mini DSO APP Ver 2.32      "
        DC8 0
        DC8 "! Save the current setting !"
        DC8 0, 0, 0
        DC8 " >   "
        DC8 0, 0
        DC8 " ERR "
        DC8 0, 0
        DC8 " OK  "
        DC8 0, 0
// E:\DS0203\APP_V2.32\source\Main.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : main.c  
//    3  Version   : DS203_APP Ver 2.3x                                  Author : bure
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
//   26 APP V2.32 从该版本起 可并行使用 IAR 4.42与５.０版本
//   27           源程序没改动，增加了文件夹　IAR_V5_Prpject
//   28 *******************************************************************************/
//   29 

        SECTION `.rodata`:CONST:NOROOT(2)
//   30 uc8 PROJECT_STR[20]="Demo PROG. Ver 1.00";
PROJECT_STR:
        DATA
        DC8 "Demo PROG. Ver 1.00"
//   31 
//   32 /*******************************************************************************
//   33   main : Main routine.
//   34 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function main
        THUMB
//   35 int main(void)
//   36 { 
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
//   37   u32 i, Licence;
//   38   u16 Count_FPS, Second, Offset, Result;
//   39   
//   40   NVIC_SetVectorTable(NVIC_VectTab_FLASH, 0x0C000);   // For Application #1
        MOV      R1,#+49152
        MOV      R0,#+134217728
        BL       NVIC_SetVectorTable
//   41 //NVIC_SetVectorTable(NVIC_VectTab_FLASH, 0x14000);   // For Application #2
//   42 //NVIC_SetVectorTable(NVIC_VectTab_FLASH, 0x1C000);   // For Application #3
//   43 //NVIC_SetVectorTable(NVIC_VectTab_FLASH, 0x24000);   // For Application #4
//   44   
//   45 //Note: 用 IAR_V4.x 编译时，变更 App#n 还要同时修改 lnkarm.xcl 文件中的对应项 
//   46 //      用 IAR_V5.x 编译时，变更 App#n 还要同时修改 xxxxxx.icf 文件中的对应项 
//   47   
//   48   __USB_Init();
        BL       __USB_Init
        MOVS     R0,#+11
//   49   
//   50   if(__Get(FPGA_OK)== 0){
        BL       __Get
        CBNZ     R0,??main_0
//   51     __Display_Str(6*8, 30, YEL, PRN, "      FPGA configuration error       ");
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
//   52     while (1){};
??main_2:
        B.N      ??main_2
//   53   }
//   54   
//   55   __Display_Str(48, 50, WHT, PRN, APP_VERSION);
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
//   56   Y_Attr = (Y_attr*)__Get(VERTICAL);     
        MOVS     R0,#+7
        BL       __Get
        LDR.W    R1,??main_1+0x8  ;; Y_Attr
        STR      R0,[R1, #+0]
//   57   X_Attr = (X_attr*)__Get(HORIZONTAL);
        MOVS     R0,#+8
        BL       __Get
        LDR.W    R1,??main_1+0xC  ;; X_Attr
        STR      R0,[R1, #+0]
//   58   G_Attr = (G_attr*)__Get(GLOBAL);
        MOVS     R0,#+9
        BL       __Get
        LDR.W    R1,??main_1+0x10  ;; G_Attr
        STR      R0,[R1, #+0]
//   59   T_Attr = (T_attr*)__Get(TRIGGER);
        MOVS     R0,#+10
        BL       __Get
        LDR.W    R1,??main_1+0x14  ;; T_Attr
        STR      R0,[R1, #+0]
//   60   Load_Attr();
        BL       Load_Attr
//   61   Load_Parameter();            // 读取预设开机参数，赋值Y_Attr等
        BL       Load_Parameter
//   62   
//   63 /*--------------------------- LICENCE_CTRL_DEMO --------------------------------
//   64   Offset = Seek_Proj(PROJECT_ID);
//   65   if(Offset >= 2048){                          // Project ID not found
//   66     Offset = Seek_Blank();
//   67     if(Offset == 2048){  
//   68       __Display_Str(6*8, 50, GRN, PRN,   "         Licence record full         ");
//   69       while (1){};
//   70     } else {
//   71       Result  = Add_Proj(PROJECT_ID, Offset);  // Set project ID
//   72       Result &= Add_Cnt(DEMOCNT, Offset);      // Set max demo run counter      
//   73       Result &= Add_Str((u32)PROJECT_STR, Offset); 
//   74       if(Result != 1){                                
//   75         __Display_Str(6*8,50,GRN, PRN,   "       Project ID writen error       ");
//   76         Delayms(500);
//   77       }
//   78     }
//   79   }
//   80   Licence = Get_Lic(Offset);                   // Get project licence record
//   81   if(__Ident(DEVELOPER_ID, PROJECT_ID, Licence)!= 1){
//   82     __Display_Str(6*8, 50, GRN, PRN,   "Please input project licence:00000000");
//   83     Licence = Input_Lic((6+29)*8, 50);         // Input Licence
//   84     if(__Ident(DEVELOPER_ID, PROJECT_ID, Licence)!=1)  Result = 0;
//   85     else{                                      // Licence correct
//   86       Result  = Add_Lic(Licence, Offset);            
//   87       if(Result == 1)                                
//   88         __Display_Str(6*8,50,GRN, PRN, "          Licence writen ok          ");
//   89       else  
//   90         __Display_Str(6*8,50,GRN, PRN, "         Licence writen error        ");
//   91       Delayms(500);
//   92     }
//   93     if(Result != 1){
//   94       __Display_Str(6*8, 30, GRN, PRN, "      Push any key to next step      ");
//   95       while(Key_Buffer == 0){};
//   96     }
//   97   }
//   98 //  --------------------------------------------------------------------------*/
//   99   
//  100   Beep_mS = 500;
        LDR.W    R0,??main_1+0x18  ;; Beep_mS
        MOV      R1,#+500
        STRH     R1,[R0, #+0]
//  101   Delayms(2000); 
        MOV      R0,#+2000
        BL       Delayms
//  102   App_init();
        BL       App_init
//  103   Key_Buffer=0;
        LDR.W    R9,??main_1+0x1C  ;; Key_Buffer
        MOVS     R0,#+0
        STRB     R0,[R9, #+0]
        MOV      R11,#+20
        LDR.W    R5,??main_1+0x20  ;; Detail
        MOV      R8,#+80
        LDR.W    R6,??main_1+0x24  ;; Current
        LDR.W    R7,??main_1+0x28  ;; Title
        B.N      ??main_3
//  104   
//  105 //--------------------------------- 主循环 ------------------------------------- 
//  106   while (1){
//  107     if(PD_Cnt == 0){
//  108       __Set(BACKLIGHT, 0);     // 关闭背光
//  109       __Set(STANDBY, EN);      // 进入省电状态  
//  110     } else {
//  111       Synchro();                              // 同步显示各个轨迹波形数据
//  112       Count_FPS++;
//  113       if(Second != Sec_Cnt) {
//  114         Second = Sec_Cnt;
//  115         Result_FPS = Count_FPS;
//  116         Count_FPS = 0;
//  117         Update_Battery();
//  118         for(i=0; i<9; ++i)  Display_Value(i); // 每秒刷新测量值        
//  119       }
//  120       Display_Meter();
//  121       Display_Title();
//  122       if(Update){                             // 处理按键后需要刷新的项目
//  123         Update_Range();
//  124         Update_Base();
//  125         Update_Output();
//  126         Update_Trig();
//  127         Update_Mark();
//  128         __Set(BACKLIGHT, 10*(Title[BK_LIGHT][CLASS].Value+1));
//  129         if(Current != FILE) Update_View_Area();
//  130         _D_V_Source.Flag |= UPDAT;            // Updat delta V 
//  131         _Delta_V.Flag    |= UPDAT; 
//  132         _Delta_T.Flag    |= UPDAT;            // Updat delta T 
//  133         Update = 0;                           // Update finish
//  134       } 
//  135       Blink = 0;
//  136     }
//  137 //------------------------------ 按键处理循环 ---------------------------------- 
//  138     if(Key_Buffer) { 
//  139       if(PD_Cnt == 0)  App_init();          // 退出省电状态
//  140       PD_Cnt = 600;                         // 600秒
//  141       if(Key_Buffer == KEY_P){
//  142         _State.Value = 1-_State.Value;                 // "RUN/HOLD" 状态互换
//  143         _State.Flag |= UPDAT;                          // 置相应的更新标志
//  144         if(_Mode == SIGN){
//  145           for(i=0; i<4*X_SIZE; ++i)  TrackBuff[i] = 0; // 清除旧的显示波形
//  146           __Set(FIFO_CLR, W_PTR);                      // FIFO写指针复位
//  147         }
//  148       }
//  149       if(Key_Buffer== KEY2){
//  150         if(Current <  TRACK3){
//  151           Delayms(500); 
//  152           if((__Get(KEY_STATUS)& KEY2_STATUS)==0){
//  153             Delayms(500); 
//  154             if((__Get(KEY_STATUS)& KEY2_STATUS)==0){
//  155               Delayms(500); 
//  156               if((__Get(KEY_STATUS)& KEY2_STATUS)==0){
//  157                 Delayms(500); 
//  158                 if((__Get(KEY_STATUS)& KEY2_STATUS)==0){
//  159                   Calibrat();             // 模拟通道校准
//  160                 }
//  161               }
//  162             }
//  163           }
//  164         }
//  165       }
//  166       if(Key_Buffer== KEY3){
//  167         Save_Parameter(0);                             // 保存当前操作设置参数    
//  168         if(Current != FILE){
//  169           Print_Str(91, 0, 0x0405, PRN, "! Save the current setting !");
//  170           Delayms(500);
//  171         } 
//  172       }
//  173       if(Key_Buffer== KEY4){
//  174         if(Current == FILE){
//  175           Print_Str(230, 0, (SCRN<<8)+ TEXT1, PRN, " >   ");
//  176           if(_Curr[0].Value == SAVE){
//  177             if(_Curr[2].Value == BMP)       i = Save_Bmp(_Curr[1].Value);
//  178             else if(_Curr[2].Value == DAT)  i = Save_Dat(_Curr[1].Value);
//  179 //            else if(_Curr[2].Value == CSV)  i = Save_CSV(_Curr[1].Value);
//  180           } else if(_Curr[0].Value == LOAD) i = Load_Dat(_Curr[1].Value);
//  181           if(i != 0) Print_Str(230, 0, (SCRN<<8)+ TEXT1, PRN, " ERR "); 
//  182           else       Print_Str(230, 0, (SCRN<<8)+ TEXT1, PRN, " OK  ");
//  183           Delayms(500);
//  184           _Curr[2].Flag |= UPDAT;
//  185         }  
//  186       }             
//  187       if(Key_Buffer == K_ITEM_DEC){ //------------------ "Item-" Key
//  188         if(Current < METER_0){
//  189           _Curr[_Det].Flag |= UPDAT;
//  190           if(Current == TRACK1)  Current = VOLUME;
//  191           else                   Current --;
//  192           if(Current == RUNNING) Current --;               // Jump over Item 4
//  193           if(_Det >2)  _Det =0;
//  194           _Curr[_Det].Flag |= BLINK;
//  195           _Curr[0].Flag |= UPDAT;
//  196           _Curr[1].Flag |= UPDAT;
//  197           _Curr[2].Flag |= UPDAT;
//  198           _Curr[3].Flag |= UPDAT;
//  199         } else {
//  200           Meter[Current-METER_0].Flag |= UPDAT; 
//  201           if(Current == METER_0) Current = METER_8;
//  202           else                   Current --;
//  203           Meter[Current-METER_0].Flag |= BLINK;
//  204         }
//  205       }
//  206       if(Key_Buffer == K_ITEM_S){ //------------------ "Item_Select"  Key
//  207         if(Current < METER_0)  Current = METER_0;
//  208         else                   Current = TRACK1;
//  209       }
//  210       if(Key_Buffer == K_ITEM_INC){ //------------------ "Item+" Key
//  211         if(Current < METER_0){
//  212           _Curr[_Det].Flag |= UPDAT;
//  213           if(Current == VOLUME)  Current = TRACK1;
//  214           else                   Current ++;
//  215           if(Current == RUNNING) Current ++;              // Jump over RUNNING
//  216           if(_Det >2)    _Det =0;
//  217           _Curr[_Det].Flag |= BLINK;
//  218           _Curr[0].Flag |= UPDAT;
//  219           _Curr[1].Flag |= UPDAT;
//  220           _Curr[2].Flag |= UPDAT;
//  221           _Curr[3].Flag |= UPDAT;
//  222         } else {
//  223           Meter[Current-METER_0].Flag |= UPDAT;  
//  224           if(Current == METER_8) Current  = METER_0;
//  225           else                   Current ++;
//  226           Meter[Current-METER_0].Flag |= BLINK;
//  227         }
//  228       }
//  229       if(Key_Buffer == K_INDEX_DEC){ //--------------------- "Index-" Key 
//  230         if(Current < METER_0){
//  231           if((Current == TRIGG)&&(Detail[Current]==2)){         // 触发电平调节
//  232             if(V_Trigg[_Trigg[SOURCE].Value].Value > MIN_Y+4) 
//  233               V_Trigg[_Trigg[SOURCE].Value].Value--;
//  234           } else if((Current == BK_LIGHT)||(Current == VOLUME)){// 背光或音量调节
//  235             if(_Curr[1].Value > 0)   _Curr[1].Value--;
//  236           } else if((Current == T_BASE)&&(_Det == XPOSI)){      // X_POSI调节
//  237             if(_Curr[_Det].Value > 30) _Curr[_Det].Value -= 30; 
//  238             else if(_Curr[_Det].Value > 0) _Curr[_Det].Value--;
//  239             _X_View.Flag |= UPDAT;                              // 刷新X_View
//  240           } else {                                              // 当前项为其他
//  241             if(_Curr[_Det].Value > 0) _Curr[_Det].Value--; 
//  242             else if(_Curr[_Det].MARK & CIRC) _Curr[_Det].Value =_Curr[_Det].Limit;
//  243           }
//  244           if((Current == T_BASE)&&(_Det == MODE)){     // T_BASE MODE 选择
//  245             Title[RUNNING][STATE].Value = RUN;         // STATE = RUNNING 
//  246             Title[RUNNING][STATE].Flag |= UPDAT;       // 刷新 RUNNING STATE
//  247           }
//  248           if(((Current == OUTPUT)&&(Title[OUTPUT][SOURCE].Value != DIGI))&&
//  249             (Title[OUTPUT][FRQN].Value > 10)) 
//  250             Title[OUTPUT][FRQN].Value = 10;            // 模拟信号频率上限为20KHz
//  251           if((Current == FILE)&&(_Curr[0].Value == 1)) 
//  252             _Curr[2].Value = 1;                        // 只能Load Dat文件
//  253           _Curr[0].Flag |= UPDAT;
//  254           _Curr[1].Flag |= UPDAT;
//  255           _Curr[2].Flag |= UPDAT;
//  256           _Curr[3].Flag |= UPDAT;
//  257         } else {
//  258           Meter[Current-METER_0].Flag |= UPDAT;
//  259           if(Meter[Current-METER_0].Item  > VBT) 
//  260             Meter[Current-METER_0].Item -= 1;          // 改变测量项目 
//  261           else                     
//  262             Meter[Current-METER_0].Item  = MIN;
//  263           if(Meter[Current-METER_0].Item == FPS) 
//  264             Meter[Current-METER_0].Track = 4;
//  265           if(Meter[Current-METER_0].Item == MIN) 
//  266             Meter[Current-METER_0].Track = 0;
//  267         }
//  268       }
//  269       if(Key_Buffer == K_INDEX_S){ //----------------- "Index_Select" Key
//  270         if(Current < METER_0){                         // 改变Detail
//  271           _Curr[_Det].Flag |= UPDAT;
//  272           if(_Det < 3)    _Det += 1;
//  273           else            _Det  = 0;
//  274           if(_Curr[_Det].MARK & NOT)                        _Det  = 0; 
//  275           if(_Curr[_Det].MARK & NUM2)                       _Det  = 0; 
//  276           if((_Curr[_Det].MARK & NUM3)&&(Current != FILE))  _Det  = 0;  
//  277           _Curr[_Det].Flag |= BLINK;
//  278         } else {                                       // 改变测量对象
//  279           Meter[Current-METER_0].Flag |= UPDAT;
//  280           if(Meter[Current-METER_0].Track <  TRACK4) 
//  281             Meter[Current-METER_0].Track += 1;
//  282           if(Meter[Current-METER_0].Track == TRACK4) 
//  283             Meter[Current-METER_0].Track  = 0;
//  284         }
//  285       }
//  286       if(Key_Buffer == K_INDEX_INC){ //--------------------- "Index+" Key 
//  287         if(Current < METER_0){
//  288           if((Current == TRIGG)&&(Detail[Current]==2)){         // 触发电平调节
//  289             if(V_Trigg[_Trigg[SOURCE].Value].Value < MAX_Y-4) 
//  290               V_Trigg[_Trigg[SOURCE].Value].Value++;
//  291           } else if((Current == BK_LIGHT)||(Current == VOLUME)){// 背光或音量调节
//  292             if(_Curr[1].Value < _Curr[1].Limit)   _Curr[1].Value++;
//  293           } else if((Current == T_BASE)&&(_Det == XPOSI)){      // X_POSI调节
//  294             if(_Curr[_Det].Value <(_Curr[_Det].Limit-30))  _Curr[_Det].Value += 30; 
//  295             else if(_Curr[_Det].Value < _Curr[_Det].Limit) _Curr[_Det].Value ++;
//  296             _X_View.Flag |= UPDAT;                      
//  297           } else {                                              // 当前项为其他
//  298             if(_Curr[_Det].Value < _Curr[_Det].Limit)  _Curr[_Det].Value++;
//  299             else if(_Curr[_Det].MARK & CIRC)   _Curr[_Det].Value  = 0;
//  300           }
//  301           if((Current == T_BASE)&&(_Det == MODE)){     // T_BASE MODE 选择
//  302             Title[RUNNING][STATE].Value = RUN;         // STATE = RUNNING 
//  303             Title[RUNNING][STATE].Flag |= UPDAT;       // 刷新 RUNNING STATE
//  304           }
//  305           if((Current == OUTPUT)&&(Title[OUTPUT][SOURCE].Value != DIGI)){
//  306             if(Title[OUTPUT][FRQN].Value > 10) 
//  307               Title[OUTPUT][FRQN].Value = 10;          // 模拟信号频率上限为20KHz
//  308           }
//  309           if((Current == FILE)&&(_Curr[0].Value == 1))  
//  310             _Curr[2].Value = 1;                        // 只能Load Dat文件
//  311           _Curr[0].Flag |= UPDAT;
//  312           _Curr[1].Flag |= UPDAT;
//  313           _Curr[2].Flag |= UPDAT;
//  314           _Curr[3].Flag |= UPDAT;
//  315         } else {
//  316           Meter[Current-METER_0].Flag |= UPDAT;
//  317           if(Meter[Current-METER_0].Item < MIN)  
//  318             Meter[Current-METER_0].Item += 1;          // 改变测量项目
//  319           else                     
//  320             Meter[Current-METER_0].Item  = VBT;
??main_4:
        MOVS     R2,#+0
        STRB     R2,[R1, #+1]
//  321           if(Meter[Current-METER_0].Item == VBT) 
//  322             Meter[Current-METER_0].Track = 4;
??main_5:
        MOVS     R2,#+4
        STRB     R2,[R0, #-152]
//  323           if(Meter[Current-METER_0].Item == VPP) 
??main_6:
        LDRB     R1,[R1, #+1]
        CMP      R1,#+2
        BNE.N    ??main_7
//  324             Meter[Current-METER_0].Track = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #-152]
//  325         }
//  326       }
//  327       Key_Buffer=0;
??main_7:
        MOVS     R0,#+0
        STRB     R0,[R9, #+0]
//  328       Update = 1;
        LDR.W    R0,??main_1+0x2C  ;; Update
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
??main_3:
        LDR.W    R0,??main_1+0x30  ;; PD_Cnt
        LDRH     R0,[R0, #+0]
        CBNZ     R0,??main_8
        MOVS     R1,#+0
        MOVS     R0,#+2
        BL       __Set
        MOVS     R1,#+1
        MOVS     R0,#+20
        BL       __Set
        B.N      ??main_9
??main_8:
        BL       Synchro
        ADD      R10,R10,#+1
        UXTH     R10,R10
        LDR      R0,[SP, #+0]
        LDR.W    R1,??main_1+0x34  ;; Sec_Cnt
        LDRH     R1,[R1, #+0]
        UXTH     R0,R0
        CMP      R0,R1
        BEQ.N    ??main_10
        LDR.W    R0,??main_1+0x34  ;; Sec_Cnt
        LDRH     R0,[R0, #+0]
        STR      R0,[SP, #+0]
        LDR.W    R0,??main_1+0x38  ;; Result_FPS
        STRH     R10,[R0, #+0]
        MOV      R10,#+0
        BL       Update_Battery
        MOVS     R4,#+0
??main_11:
        UXTB     R0,R4
        BL       Display_Value
        ADDS     R4,R4,#+1
        CMP      R4,#+9
        BCC.N    ??main_11
??main_10:
        BL       Display_Meter
        BL       Display_Title
        LDR.W    R0,??main_1+0x2C  ;; Update
        LDRB     R0,[R0, #+0]
        CBZ      R0,??main_12
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
        LDR.W    R0,??main_1+0x2C  ;; Update
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
??main_12:
        LDR.W    R0,??main_1+0x3C  ;; Blink
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
??main_9:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+0
        BEQ.N    ??main_3
        LDR.W    R0,??main_1+0x30  ;; PD_Cnt
        LDRH     R0,[R0, #+0]
        CBNZ     R0,??main_13
        BL       App_init
??main_13:
        LDR.W    R0,??main_1+0x30  ;; PD_Cnt
        MOV      R1,#+600
        STRH     R1,[R0, #+0]
        LDRB     R0,[R9, #+0]
        CMP      R0,#+1
        BNE.N    ??main_14
        LDRH     R0,[R7, #+336]
        RSB      R0,R0,#+1
        STRH     R0,[R7, #+336]
        ADD      R0,R7,#+338
        LDRB     R0,[R0, #+0]
        ORR      R0,R0,#0x2
        ADD      R1,R7,#+338
        STRB     R0,[R1, #+0]
        LDRSH    R0,[R7, #+416]
        CMP      R0,#+2
        BNE.N    ??main_14
        MOV      R1,#+1200
        LDR.W    R0,??main_1+0x40  ;; TrackBuff
        BL       __aeabi_memclr
        MOV      R4,#+1200
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       __Set
??main_14:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+2
        BNE.N    ??main_15
        LDRB     R0,[R6, #+0]
        CMP      R0,#+2
        BCS.N    ??main_15
        MOV      R0,#+500
        BL       Delayms
        MOVS     R0,#+4
        BL       __Get
        TST      R0,#0x2000
        BNE.N    ??main_15
        MOV      R0,#+500
        BL       Delayms
        MOVS     R0,#+4
        BL       __Get
        TST      R0,#0x2000
        BNE.N    ??main_15
        MOV      R0,#+500
        BL       Delayms
        MOVS     R0,#+4
        BL       __Get
        TST      R0,#0x2000
        BNE.N    ??main_15
        MOV      R0,#+500
        BL       Delayms
        MOVS     R0,#+4
        BL       __Get
        TST      R0,#0x2000
        IT       EQ 
        BLEQ     Calibrat
??main_15:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+3
        BNE.N    ??main_16
        MOVS     R0,#+0
        BL       Save_Parameter
        LDRB     R0,[R6, #+0]
        CMP      R0,#+9
        BEQ.N    ??main_16
        LDR.W    R0,??main_1+0x44  ;; `?<Constant "      FPGA configurat...">` + 80
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
??main_16:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+4
        BNE.N    ??main_17
        LDRB     R0,[R6, #+0]
        CMP      R0,#+9
        BNE.N    ??main_17
        LDR.W    R0,??main_1+0x48  ;; `?<Constant "      FPGA configurat...">` + 112
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
        CBNZ     R1,??main_18
        LDRSH    R1,[R0, #+56]
        CBNZ     R1,??main_19
        LDRH     R0,[R0, #+36]
        UXTB     R0,R0
        BL       Save_Bmp
        B.N      ??main_20
??main_19:
        CMP      R1,#+1
        BNE.N    ??main_21
        LDRH     R0,[R0, #+36]
        UXTB     R0,R0
        BL       Save_Dat
        B.N      ??main_20
??main_18:
        CMP      R1,#+1
        BNE.N    ??main_21
        LDRH     R0,[R0, #+36]
        UXTB     R0,R0
        BL       Load_Dat
??main_20:
        MOVS     R4,R0
??main_21:
        CBZ      R4,??main_22
        LDR.W    R0,??main_1+0x4C  ;; `?<Constant "      FPGA configurat...">` + 120
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        MOVW     R2,#+1290
        B.N      ??main_23
        CFI CFA R13+40
??main_22:
        LDR.W    R0,??main_1+0x50  ;; `?<Constant "      FPGA configurat...">` + 128
        PUSH     {R0,LR}
        CFI CFA R13+48
        MOVS     R3,#+0
        MOVW     R2,#+1290
??main_23:
        MOVS     R1,#+0
        MOVS     R0,#+230
        BL       Print_Str
        ADD      SP,SP,#+8
        CFI CFA R13+40
        MOV      R0,#+500
        BL       Delayms
        LDRB     R0,[R6, #+0]
        MLA      R0,R0,R8,R7
        LDRB     R1,[R0, #+58]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+58]
??main_17:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+9
        BNE.N    ??main_24
        LDRB     R0,[R6, #+0]
        MOVS     R1,R0
        CMP      R0,#+13
        BCS.N    ??main_25
        LDRB     R2,[R1, R5]
        MLA      R1,R1,R8,R7
        MLA      R1,R2,R11,R1
        LDRB     R2,[R1, #+18]
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #+18]
        CBNZ     R0,??main_26
        MOVS     R1,#+12
        B.N      ??main_27
??main_26:
        SUBS     R1,R0,#+1
        UXTB     R1,R1
        CMP      R1,#+4
        IT       EQ 
        MOVEQ    R1,#+3
??main_27:
        STRB     R1,[R6, #+0]
        LDRB     R0,[R1, R5]
        CMP      R0,#+3
        BCC.N    ??main_28
        MOVS     R0,#+0
        STRB     R0,[R1, R5]
??main_28:
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
        B.N      ??main_24
??main_25:
        MOVS     R2,#+12
        LDR.W    R3,??main_1+0x54  ;; Meter
        MLA      R1,R1,R2,R3
        LDRB     R2,[R1, #-145]
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #-145]
        CMP      R0,#+13
        BNE.N    ??main_29
        MOVS     R0,#+21
        B.N      ??main_30
??main_29:
        SUBS     R0,R0,#+1
??main_30:
        STRB     R0,[R6, #+0]
        UXTB     R0,R0
        MOVS     R1,#+12
        LDR.W    R2,??main_1+0x54  ;; Meter
        MLA      R0,R0,R1,R2
        LDRB     R1,[R0, #-145]
        ORR      R1,R1,#0x1
        STRB     R1,[R0, #-145]
??main_24:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+10
        BNE.N    ??main_31
        LDRB     R0,[R6, #+0]
        CMP      R0,#+13
        BCS.N    ??main_32
        MOVS     R0,#+13
        B.N      ??main_33
??main_32:
        MOVS     R0,#+0
??main_33:
        STRB     R0,[R6, #+0]
??main_31:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+8
        BNE.N    ??main_34
        LDRB     R0,[R6, #+0]
        MOVS     R1,R0
        CMP      R0,#+13
        BCS.N    ??main_35
        LDRB     R2,[R1, R5]
        MLA      R1,R1,R8,R7
        MLA      R1,R2,R11,R1
        LDRB     R2,[R1, #+18]
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #+18]
        CMP      R0,#+12
        BNE.N    ??main_36
        MOVS     R1,#+0
        B.N      ??main_37
??main_36:
        ADDS     R1,R0,#+1
        UXTB     R1,R1
        CMP      R1,#+4
        IT       EQ 
        MOVEQ    R1,#+5
??main_37:
        STRB     R1,[R6, #+0]
        LDRB     R0,[R1, R5]
        CMP      R0,#+3
        BCC.N    ??main_38
        MOVS     R0,#+0
        STRB     R0,[R1, R5]
??main_38:
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
        B.N      ??main_34
??main_35:
        MOVS     R2,#+12
        LDR.W    R3,??main_1+0x54  ;; Meter
        MLA      R1,R1,R2,R3
        LDRB     R2,[R1, #-145]
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #-145]
        CMP      R0,#+21
        BNE.N    ??main_39
        MOVS     R0,#+13
        B.N      ??main_40
??main_39:
        ADDS     R0,R0,#+1
??main_40:
        STRB     R0,[R6, #+0]
        LDRB     R0,[R6, #+0]
        MOVS     R1,#+12
        LDR.W    R2,??main_1+0x54  ;; Meter
        MLA      R0,R0,R1,R2
        LDRB     R1,[R0, #-145]
        ORR      R1,R1,#0x1
        STRB     R1,[R0, #-145]
??main_34:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+5
        BNE.W    ??main_41
        LDRB     R0,[R6, #+0]
        CMP      R0,#+13
        BCS.W    ??main_42
        CMP      R0,#+7
        BNE.N    ??main_43
        LDRB     R1,[R5, #+7]
        CMP      R1,#+2
        BNE.N    ??main_44
        LDRSH    R1,[R7, #+576]
        LDR.W    R2,??main_1+0x58  ;; V_Trigg
        LDRSH    R2,[R2, R1, LSL #+2]
        CMP      R2,#+18
        BLT.N    ??main_45
        LDR.W    R3,??main_1+0x58  ;; V_Trigg
        SUBS     R2,R2,#+1
        STRH     R2,[R3, R1, LSL #+2]
        B.N      ??main_45
??main_43:
        CMP      R0,#+11
        BEQ.N    ??main_46
        CMP      R0,#+12
        BNE.N    ??main_47
??main_46:
        MLA      R1,R0,R8,R7
        LDRSH    R2,[R1, #+36]
        CMP      R2,#+1
        BLT.N    ??main_48
        SUBS     R2,R2,#+1
        STRH     R2,[R1, #+36]
        B.N      ??main_48
??main_47:
        CMP      R0,#+5
        BNE.N    ??main_44
        LDRB     R1,[R5, #+5]
        CMP      R1,#+2
        BNE.N    ??main_44
        LDRSH    R1,[R7, #+456]
        CMP      R1,#+31
        BLT.N    ??main_49
        SUBS     R1,R1,#+30
        STRH     R1,[R7, #+456]
        B.N      ??main_50
??main_49:
        CMP      R1,#+1
        BLT.N    ??main_50
        SUBS     R1,R1,#+1
        STRH     R1,[R7, #+456]
??main_50:
        ADD      R1,R7,#+478
        LDRB     R1,[R1, #+0]
        ORR      R1,R1,#0x2
        ADD      R2,R7,#+478
??main_51:
        STRB     R1,[R2, #+0]
        B.N      ??main_45
??main_44:
        LDRB     R12,[R0, R5]
        MLA      R1,R0,R8,R7
        MLA      R2,R12,R11,R1
        LDRSH    R1,[R2, #+16]
        CMP      R1,#+1
        BLT.N    ??main_52
        LDRH     R1,[R2, #+16]
        SUBS     R1,R1,#+1
        STRH     R1,[R2, #+16]
        B.N      ??main_48
??main_52:
        LDRB     R1,[R2, #+10]
        TST      R1,#0x10
        ITT      NE 
        LDRHNE   R1,[R2, #+8]
        STRHNE   R1,[R2, #+16]
??main_48:
        CMP      R0,#+5
        BNE.N    ??main_53
        LDRB     R1,[R5, #+5]
        CBNZ     R1,??main_45
        STRH     R1,[R7, #+336]
        ADD      R1,R7,#+338
        LDRB     R1,[R1, #+0]
        ORR      R1,R1,#0x2
        ADD      R2,R7,#+338
        B.N      ??main_51
??main_53:
        CMP      R0,#+6
        BNE.N    ??main_54
        LDRSH    R1,[R7, #+496]
        CMP      R1,#+3
        BEQ.N    ??main_45
        LDRSH    R1,[R7, #+516]
        CMP      R1,#+11
        BLT.N    ??main_45
        MOVS     R1,#+10
        STRH     R1,[R7, #+516]
        B.N      ??main_45
??main_54:
        CMP      R0,#+9
        BNE.N    ??main_45
        LDRSH    R1,[R7, #+736]
        CMP      R1,#+1
        IT       EQ 
        STRHEQ   R1,[R7, #+776]
??main_45:
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
        B.N      ??main_41
??main_42:
        MOVS     R3,R0
        MOVS     R0,#+12
        LDR.N    R1,??main_1+0x54  ;; Meter
        MLA      R0,R3,R0,R1
        SUB      R1,R0,#+152
        LDRB     R2,[R1, #+7]
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #+7]
        LDRB     R2,[R1, #+1]
        CBZ      R2,??main_55
        SUBS     R2,R2,#+1
        STRB     R2,[R1, #+1]
        UXTB     R2,R2
        CMP      R2,#+1
        BNE.N    ??main_56
        MOVS     R2,#+4
        STRB     R2,[R0, #-152]
??main_56:
        LDRB     R1,[R1, #+1]
        CMP      R1,#+6
        BNE.N    ??main_41
??main_57:
        MOVS     R1,#+0
        STRB     R1,[R0, #-152]
??main_41:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+7
        BNE.N    ??main_58
        LDRB     R0,[R6, #+0]
        MOVS     R3,R0
        CMP      R0,#+13
        BCS.N    ??main_59
        LDRB     R12,[R3, R5]
        MLA      R1,R3,R8,R7
        MLA      R2,R12,R11,R1
        LDRB     LR,[R2, #+18]
        ORR      LR,LR,#0x2
        STRB     LR,[R2, #+18]
        CMP      R12,#+3
        BCS.N    ??main_60
        ADD      R2,R12,#+1
        B.N      ??main_61
??main_55:
        MOVS     R2,#+6
        STRB     R2,[R1, #+1]
        B.N      ??main_57
??main_60:
        MOVS     R2,#+0
??main_61:
        STRB     R2,[R3, R5]
        LDRB     R2,[R3, R5]
        MLA      R2,R2,R11,R1
        LDRB     R2,[R2, #+10]
        TST      R2,#0x80
        BEQ.N    ??main_62
        MOVS     R2,#+0
        STRB     R2,[R3, R5]
??main_62:
        LDRB     R2,[R3, R5]
        MLA      R2,R2,R11,R1
        LDRB     R2,[R2, #+10]
        TST      R2,#0x1
        BEQ.N    ??main_63
        MOVS     R2,#+0
        STRB     R2,[R3, R5]
??main_63:
        LDRB     R2,[R3, R5]
        MLA      R2,R2,R11,R1
        LDRB     R2,[R2, #+10]
        TST      R2,#0x2
        BEQ.N    ??main_64
        CMP      R0,#+9
        BEQ.N    ??main_64
        MOVS     R0,#+0
        STRB     R0,[R3, R5]
??main_64:
        LDRB     R0,[R3, R5]
        MLA      R0,R0,R11,R1
        LDRB     R1,[R0, #+18]
        ORR      R1,R1,#0x1
        STRB     R1,[R0, #+18]
        B.N      ??main_58
??main_59:
        MOVS     R0,#+12
        LDR.N    R1,??main_1+0x54  ;; Meter
        MLA      R0,R3,R0,R1
        SUB      R1,R0,#+152
        LDRB     R2,[R1, #+7]
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #+7]
        LDRB     R1,[R0, #-152]
        CMP      R1,#+3
        BCS.N    ??main_65
        ADDS     R1,R1,#+1
        STRB     R1,[R0, #-152]
??main_65:
        LDRB     R1,[R0, #-152]
        CMP      R1,#+3
        BNE.N    ??main_58
        MOVS     R1,#+0
        STRB     R1,[R0, #-152]
??main_58:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+6
        BNE.W    ??main_7
        LDRB     R0,[R6, #+0]
        CMP      R0,#+13
        BCS.W    ??main_66
        CMP      R0,#+7
        BNE.N    ??main_67
        LDRB     R1,[R5, #+7]
        CMP      R1,#+2
        BNE.N    ??main_68
        LDRSH    R1,[R7, #+576]
        LDR.N    R2,??main_1+0x58  ;; V_Trigg
        LDRSH    R2,[R2, R1, LSL #+2]
        CMP      R2,#+209
        BGE.N    ??main_69
        LDR.N    R3,??main_1+0x58  ;; V_Trigg
        ADDS     R2,R2,#+1
        STRH     R2,[R3, R1, LSL #+2]
        B.N      ??main_69
??main_67:
        CMP      R0,#+11
        BEQ.N    ??main_70
        CMP      R0,#+12
        BNE.N    ??main_71
??main_70:
        MLA      R1,R0,R8,R7
        LDRSH    R2,[R1, #+36]
        LDRSH    R3,[R1, #+28]
        CMP      R2,R3
        BGE.N    ??main_72
        LDRH     R2,[R1, #+36]
        ADDS     R2,R2,#+1
        STRH     R2,[R1, #+36]
        B.N      ??main_72
??main_71:
        CMP      R0,#+5
        BNE.N    ??main_68
        LDRB     R1,[R5, #+5]
        CMP      R1,#+2
        BNE.N    ??main_68
        LDRSH    R1,[R7, #+448]
        LDRSH    R2,[R7, #+456]
        SUB      R3,R1,#+30
        CMP      R2,R3
        BGE.N    ??main_73
        ADD      R1,R2,#+30
        STRH     R1,[R7, #+456]
        B.N      ??main_74
??main_73:
        CMP      R2,R1
        BGE.N    ??main_74
        ADDS     R1,R2,#+1
        STRH     R1,[R7, #+456]
??main_74:
        ADD      R1,R7,#+478
        LDRB     R1,[R1, #+0]
        ORR      R1,R1,#0x2
        ADD      R2,R7,#+478
??main_75:
        STRB     R1,[R2, #+0]
        B.N      ??main_69
??main_68:
        MLA      R1,R0,R8,R7
        LDRB     R2,[R0, R5]
        MLA      R1,R2,R11,R1
        LDRSH    R2,[R1, #+16]
        LDRSH    R3,[R1, #+8]
        CMP      R2,R3
        BGE.N    ??main_76
        LDRH     R2,[R1, #+16]
        ADDS     R2,R2,#+1
        B.N      ??main_77
??main_76:
        LDRB     R2,[R1, #+10]
        TST      R2,#0x10
        BEQ.N    ??main_72
        MOVS     R2,#+0
??main_77:
        STRH     R2,[R1, #+16]
??main_72:
        CMP      R0,#+5
        BNE.N    ??main_78
        LDRB     R1,[R5, #+5]
        CBNZ     R1,??main_69
        STRH     R1,[R7, #+336]
        ADD      R1,R7,#+338
        LDRB     R1,[R1, #+0]
        ORR      R1,R1,#0x2
        ADD      R2,R7,#+338
        B.N      ??main_75
??main_78:
        CMP      R0,#+6
        BNE.N    ??main_79
        LDRSH    R1,[R7, #+496]
        CMP      R1,#+3
        BEQ.N    ??main_69
        LDRSH    R1,[R7, #+516]
        CMP      R1,#+11
        BLT.N    ??main_69
        MOVS     R1,#+10
        STRH     R1,[R7, #+516]
        B.N      ??main_69
??main_79:
        CMP      R0,#+9
        BNE.N    ??main_69
        LDRSH    R1,[R7, #+736]
        CMP      R1,#+1
        IT       EQ 
        STRHEQ   R1,[R7, #+776]
??main_69:
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
        B.N      ??main_7
??main_66:
        MOVS     R3,R0
        MOVS     R0,#+12
        LDR.N    R1,??main_1+0x54  ;; Meter
        MLA      R0,R3,R0,R1
        SUB      R1,R0,#+152
        LDRB     R2,[R1, #+7]
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #+7]
        LDRB     R2,[R1, #+1]
        CMP      R2,#+6
        BCS.W    ??main_4
        ADDS     R2,R2,#+1
        STRB     R2,[R1, #+1]
        UXTB     R2,R2
        CMP      R2,#+0
        BNE.W    ??main_6
        B.N      ??main_5
        Nop      
        DATA
??main_1:
        DC32     `?<Constant "      FPGA configurat...">`
        DC32     `?<Constant "      FPGA configurat...">` + 40
        DC32     Y_Attr
        DC32     X_Attr
        DC32     G_Attr
        DC32     T_Attr
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
        DC32     `?<Constant "      FPGA configurat...">` + 80
        DC32     `?<Constant "      FPGA configurat...">` + 112
        DC32     `?<Constant "      FPGA configurat...">` + 120
        DC32     `?<Constant "      FPGA configurat...">` + 128
        DC32     Meter
        DC32     V_Trigg
        CFI EndBlock cfiBlock0
//  329     }
//  330   }
//  331 }

        END
//  332 /*********************************  END OF FILE  ******************************/
// 
//   156 bytes in section .rodata
// 2 204 bytes in section .text
// 
// 2 204 bytes of CODE  memory
//   156 bytes of CONST memory
//
//Errors: none
//Warnings: 3
