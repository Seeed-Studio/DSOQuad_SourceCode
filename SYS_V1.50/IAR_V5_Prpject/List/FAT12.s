///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  14:03:33 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\SYS_V1.50\source\FAT12.c               /
//    Command line =  E:\Mini-DS\DS203\SYS_V1.50\source\FAT12.c -lA           /
//                    E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\ -o      /
//                    E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\Obj\          /
//                    --no_inline --endian=little --cpu=Cortex-M3 -e          /
//                    --fpu=None --dlib_config "C:\Program Files\IAR          /
//                    Systems\Embedded Workbench 5.0                          /
//                    Evaluation\ARM\INC\DLib_Config_Normal.h" -I             /
//                    E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\..\..\FWLib\i /
//                    nc\ -I E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\..\..\ /
//                    USBLib\inc\ -I E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpjec /
//                    t\..\include\ -I "C:\Program Files\IAR                  /
//                    Systems\Embedded Workbench 5.0 Evaluation\ARM\INC\"     /
//                    -Ohs                                                    /
//    List file    =  E:\Mini-DS\DS203\SYS_V1.50\IAR_V5_Prpject\List\FAT12.s  /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME FAT12

        EXTERN Clash
        EXTERN __ExtFlash_PageRD
        EXTERN __ExtFlash_PageWR
        EXTERN __ProgDiskPage
        EXTERN __ReadDiskData

        PUBLIC CloseFile
        PUBLIC NextCluster
        PUBLIC OpenFileRd
        PUBLIC OpenFileWr
        PUBLIC ProgDiskPage
        PUBLIC ProgFileSec
        PUBLIC ReadDiskData
        PUBLIC ReadFileSec
        PUBLIC SeekBlank
        PUBLIC SetCluster
        
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
        
// E:\Mini-DS\DS203\SYS_V1.50\source\FAT12.c
//    1 /********************* (C) COPYRIGHT 2011 e-Design Co.,Ltd. ********************
//    2  File Name : FAT12.c  
//    3  Version   : DS203_SYS Ver 1.5x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include <string.h>
//    6 #include "FAT12.h"
//    7 #include "BIOS.h"
//    8 #include "ASM.h"
//    9 #include "Function.h"
//   10 
//   11 #define FAT_LEN      0x1800 
//   12 #define FAT1_BASE    0x00001000   // FAT1区开始地址
//   13 #define FAT2_BASE    0x00002800   // FAT2区开始地址
//   14 #define ROOT_BASE    0x00004000   // 根目录开始地址
//   15 #define FILE_BASE    0x00008000   // 文件区开始地址
//   16 #define SEC_LEN      0x200        // 扇区长度
//   17 #define FAT1_SEC     0x0C         // FAT1扇区数
//   18 #define FAT2_SEC     0x0C         // FAT2扇区数
//   19 
//   20 #define OK           0            // 操作完成
//   21 #define SEC_ERR      1            // 扇区读写错误
//   22 #define FAT_ERR      2            // FAT表读写错误
//   23 #define OVER         3            // 操作溢出
//   24 #define NEW          4            // 新目录项
//   25 #define END          0xFFF        // 链接结束
//   26 
//   27 #define OW           0            // 或写(数据从0变1改写)
//   28 #define RW           1            // 重写
//   29 
//   30 
//   31 /*******************************************************************************
//   32  读磁盘页面(256 Bytes)  包含USB读写冲突后重读
//   33 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function ReadDiskData
        THUMB
//   34 u8 ReadDiskData(u8* pBuffer, u32 ReadAddr, u16 Lenght)
//   35 {
ReadDiskData:
        PUSH     {R4-R8,LR}
        CFI R14 Frame(CFA, -4)
        CFI R8 Frame(CFA, -8)
        CFI R7 Frame(CFA, -12)
        CFI R6 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
        MOVS     R6,R0
        MOVS     R4,R1
        MOVS     R5,R2
//   36   u8 n = 0;
        MOV      R8,#+0
        LDR.N    R7,??DataTable1  ;; Clash
//   37   
//   38   while(1){
//   39     Clash = 0;
??ReadDiskData_0:
        MOVS     R0,#+0
        STRB     R0,[R7, #+0]
//   40     __ExtFlash_PageRD(pBuffer, ReadAddr, Lenght);
        MOVS     R2,R5
        MOVS     R1,R4
        MOVS     R0,R6
        BL       __ExtFlash_PageRD
//   41     if(n++ > 6) return SEC_ERR;     // 超时出错返回
        MOV      R0,R8
        ADD      R8,R0,#+1
        UXTB     R0,R0
        CMP      R0,#+7
        BCC.N    ??ReadDiskData_1
        MOVS     R0,#+1
        B.N      ??ReadDiskData_2
//   42     if(Clash == 0) return OK;       // 无冲突产生则返回
??ReadDiskData_1:
        LDRB     R0,[R7, #+0]
        CMP      R0,#+0
        BNE.N    ??ReadDiskData_0
??ReadDiskData_2:
        POP      {R4-R8,PC}       ;; return
        CFI EndBlock cfiBlock0
//   43   }
//   44 }
//   45 /*******************************************************************************
//   46  写磁盘页面(256 Bytes)  包含USB读写冲突后重写
//   47 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function ProgDiskPage
        THUMB
//   48 u8 ProgDiskPage(u8* pBuffer, u32 ProgAddr)
//   49 {                         
ProgDiskPage:
        PUSH     {R4-R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI R7 Frame(CFA, -8)
        CFI R6 Frame(CFA, -12)
        CFI R5 Frame(CFA, -16)
        CFI R4 Frame(CFA, -20)
        CFI CFA R13+20
        SUB      SP,SP,#+4
        CFI CFA R13+24
        MOVS     R5,R0
        MOVS     R4,R1
//   50   u8   n = 0; 
        MOVS     R6,#+0
        LDR.N    R7,??DataTable1  ;; Clash
//   51   
//   52   while(1){
//   53     Clash = 0;
??ProgDiskPage_0:
        MOVS     R0,#+0
        STRB     R0,[R7, #+0]
//   54     __ExtFlash_PageWR(pBuffer, ProgAddr);
        MOVS     R1,R4
        MOVS     R0,R5
        BL       __ExtFlash_PageWR
//   55     if(n++ > 6) return SEC_ERR;     // 超时出错返回
        MOVS     R0,R6
        ADDS     R6,R0,#+1
        UXTB     R0,R0
        CMP      R0,#+7
        BCC.N    ??ProgDiskPage_1
        MOVS     R0,#+1
        B.N      ??ProgDiskPage_2
//   56     if(Clash == 0) return OK;       // 无冲突产生则返回
??ProgDiskPage_1:
        LDRB     R0,[R7, #+0]
        CMP      R0,#+0
        BNE.N    ??ProgDiskPage_0
??ProgDiskPage_2:
        ADD      SP,SP,#+4
        CFI CFA R13+20
        POP      {R4-R7,PC}       ;; return
        CFI EndBlock cfiBlock1
//   57   }
//   58 } 

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable1:
        DC32     Clash
//   59 /*******************************************************************************
//   60  查找下一个链接簇号后返回，当前簇号保存在指针+1的位置
//   61 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function NextCluster
        THUMB
//   62 u8 NextCluster(u16* pCluster)
//   63 {
NextCluster:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        SUB      SP,SP,#+8
        CFI CFA R13+16
        MOVS     R4,R0
//   64   u16 FatNum;
//   65   u32 Addr = FAT1_BASE +(*pCluster + *pCluster/2);
        LDRH     R0,[R4, #+0]
        LSRS     R1,R0,#+1
        ADDS     R1,R1,R0
        ADD      R1,R1,#+4096
//   66   
//   67   *(pCluster+1)= *pCluster;                                   // 保存前一个簇号
        STRH     R0,[R4, #+2]
//   68   *pCluster = 0;
        MOVS     R2,#+0
        STRH     R2,[R4, #+0]
//   69   if((*(pCluster+1) >= END)||(*(pCluster+1)< 2)) return OK;
        MOVW     R2,#+4095
        CMP      R0,R2
        BCS.N    ??NextCluster_0
        CMP      R0,#+2
        BCS.N    ??NextCluster_1
??NextCluster_2:
        B.N      ??NextCluster_0
//   70   if(__ReadDiskData((u8*)&FatNum, Addr, 2)!= OK) return SEC_ERR;
??NextCluster_1:
        MOVS     R2,#+2
        ADD      R0,SP,#+0
        BL       __ReadDiskData
        CBZ      R0,??NextCluster_3
        MOVS     R0,#+1
        B.N      ??NextCluster_4
//   71   *pCluster= (*(pCluster+1) & 1)?(FatNum >>4):(FatNum & 0x0FFF); // 指向下一个簇号
??NextCluster_3:
        LDRH     R0,[R4, #+2]
        TST      R0,#0x1
        BEQ.N    ??NextCluster_5
        LDRH     R0,[SP, #+0]
        LSRS     R0,R0,#+4
        B.N      ??NextCluster_6
??NextCluster_5:
        LDRH     R0,[SP, #+0]
        LSLS     R0,R0,#+20
        LSRS     R0,R0,#+20
??NextCluster_6:
        STRH     R0,[R4, #+0]
//   72   return OK; 
??NextCluster_0:
        MOVS     R0,#+0
??NextCluster_4:
        ADD      SP,SP,#+8
        CFI CFA R13+8
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock2
//   73 }
//   74 /*******************************************************************************
//   75  读文件扇区(512 Bytes), 返回时指针指向下一个簇号，当前簇号保存在指针+1的位置
//   76 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function ReadFileSec
        THUMB
//   77 u8 ReadFileSec(u8* pBuffer, u16* pCluster)
//   78 {
ReadFileSec:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOVS     R5,R0
        MOVS     R6,R1
//   79   u32 ReadAddr = FILE_BASE + SEC_LEN*(*pCluster-2);
        LDRH     R0,[R6, #+0]
        LSLS     R0,R0,#+9
        ADD      R4,R0,#+31744
//   80   
//   81   if(__ReadDiskData(pBuffer, ReadAddr, 256)!=OK) return SEC_ERR; // 读前半扇区
        MOV      R2,#+256
        MOVS     R1,R4
        MOVS     R0,R5
        BL       __ReadDiskData
        CBZ      R0,??ReadFileSec_0
??ReadFileSec_1:
        MOVS     R0,#+1
        POP      {R4-R6,PC}
//   82   pBuffer += 256;  ReadAddr += 256;
//   83   if(__ReadDiskData(pBuffer, ReadAddr, 256)!=OK) return SEC_ERR; // 读后半扇区
??ReadFileSec_0:
        MOV      R2,#+256
        ADD      R1,R4,#+256
        ADD      R0,R5,#+256
        BL       __ReadDiskData
        CMP      R0,#+0
        BNE.N    ??ReadFileSec_1
//   84   if(NextCluster(pCluster)!=0) return FAT_ERR;                 // 取下一个簇号
        MOVS     R0,R6
        BL       NextCluster
        CBZ      R0,??ReadFileSec_2
        MOVS     R0,#+2
//   85   return OK;
??ReadFileSec_2:
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock3
//   86 } 
//   87 /*******************************************************************************
//   88  写文件扇区(512 Bytes)，填写当前FAT表及返回查找到的下一个簇号
//   89 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function ProgFileSec
        THUMB
//   90 u8 ProgFileSec(u8* pBuffer, u16* pCluster)
//   91 {
ProgFileSec:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOVS     R5,R0
        MOVS     R6,R1
//   92   u16 Tmp;
//   93   u32 ProgAddr = FILE_BASE + SEC_LEN*(*pCluster-2);
        LDRH     R0,[R6, #+0]
        LSLS     R0,R0,#+9
        ADD      R4,R0,#+31744
//   94   
//   95   if(__ProgDiskPage(pBuffer, ProgAddr)!= OK) return SEC_ERR; // 写前半扇区
        MOVS     R1,R4
        MOVS     R0,R5
        BL       __ProgDiskPage
        CBZ      R0,??ProgFileSec_0
??ProgFileSec_1:
        MOVS     R0,#+1
        POP      {R4-R6,PC}
//   96   pBuffer += 256;  ProgAddr += 256;
??ProgFileSec_0:
        ADD      R5,R5,#+256
//   97   if(__ProgDiskPage(pBuffer, ProgAddr)!= OK) return SEC_ERR; // 写后半扇区
        ADD      R1,R4,#+256
        MOVS     R0,R5
        BL       __ProgDiskPage
        CMP      R0,#+0
        BNE.N    ??ProgFileSec_1
//   98   if(NextCluster(pCluster)!=0) return FAT_ERR;                 // 取下一个簇号
        MOVS     R0,R6
        BL       NextCluster
        CBZ      R0,??ProgFileSec_2
        MOVS     R0,#+2
        POP      {R4-R6,PC}
//   99   Tmp = *(pCluster+1);
//  100   if(*pCluster == 0){
??ProgFileSec_2:
        LDRH     R0,[R6, #+0]
        CBNZ     R0,??ProgFileSec_3
//  101     *pCluster = Tmp;
        LDRH     R0,[R6, #+2]
        STRH     R0,[R6, #+0]
//  102     if(SeekBlank (pBuffer, pCluster )!= OK) return OVER;
        MOVS     R1,R6
        MOVS     R0,R5
        BL       SeekBlank
        CBZ      R0,??ProgFileSec_4
        MOVS     R0,#+3
        POP      {R4-R6,PC}
//  103     if(SetCluster(pBuffer, pCluster )!= OK) return SEC_ERR;
??ProgFileSec_4:
        MOVS     R1,R6
        MOVS     R0,R5
        BL       SetCluster
        CMP      R0,#+0
        BNE.N    ??ProgFileSec_1
//  104   }
//  105   return OK;
??ProgFileSec_3:
        MOVS     R0,#+0
??ProgFileSec_5:
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock4
//  106 }
//  107 /*******************************************************************************
//  108  查找空闲簇号，返回时指针指向下一个空闲簇号，当前簇号保存在指针+1的位置
//  109 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function SeekBlank
        THUMB
//  110 u8 SeekBlank(u8* pBuffer, u16* pCluster)
//  111 {
SeekBlank:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
        MOVS     R4,R1
//  112   u16  Tmp;
//  113   u8   Buffer[2];
//  114 
//  115   *(pCluster+1)= *pCluster;                                    // 保存当前簇号
        LDRH     R0,[R4, #+0]
        STRH     R0,[R4, #+2]
//  116   for(*pCluster=0; (*pCluster)<4095; (*pCluster)++){
        MOVS     R0,#+0
        STRH     R0,[R4, #+0]
        MOVW     R5,#+4095
        B.N      ??SeekBlank_0
??SeekBlank_1:
        ADDS     R0,R0,#+1
        STRH     R0,[R4, #+0]
        UXTH     R0,R0
        CMP      R0,R5
        BCS.N    ??SeekBlank_2
//  117     if(__ReadDiskData(Buffer, FAT1_BASE +(*pCluster)+(*pCluster)/2, 2)!= 0) return SEC_ERR;
??SeekBlank_0:
        LDRH     R0,[R4, #+0]
        MOVS     R2,#+2
        LSRS     R1,R0,#+1
        ADDS     R0,R0,R1
        ADD      R1,R0,#+4096
        ADD      R0,SP,#+0
        BL       __ReadDiskData
        CBZ      R0,??SeekBlank_3
        MOVS     R0,#+1
        B.N      ??SeekBlank_4
//  118     Tmp = ((*pCluster)& 1)?((*(u16*)Buffer)>>4):((*(u16*)Buffer)& 0xFFF);
??SeekBlank_3:
        LDRH     R0,[R4, #+0]
        TST      R0,#0x1
        BEQ.N    ??SeekBlank_5
        LDRH     R1,[SP, #+0]
        LSRS     R1,R1,#+4
        B.N      ??SeekBlank_6
??SeekBlank_5:
        LDRH     R1,[SP, #+0]
        LSLS     R1,R1,#+20
        LSRS     R1,R1,#+20
//  119     if((Tmp == 0)&&((*pCluster)!= *(pCluster+1))) return OK;
??SeekBlank_6:
        CMP      R1,#+0
        BNE.N    ??SeekBlank_1
        LDRH     R1,[R4, #+2]
        CMP      R0,R1
        BEQ.N    ??SeekBlank_1
??SeekBlank_2:
        MOVS     R0,#+0
??SeekBlank_4:
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        CFI EndBlock cfiBlock5
//  120   }
//  121   return OK;
//  122 }         
//  123 /*******************************************************************************
//  124  将下一簇号写入FAT表当前簇链接位，返回时指针指向下一簇号，指针+1为当前簇号
//  125 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function SetCluster
        THUMB
//  126 u8 SetCluster(u8* pBuffer, u16* pCluster)
//  127 {
SetCluster:
        PUSH     {R4-R8,LR}
        CFI R14 Frame(CFA, -4)
        CFI R8 Frame(CFA, -8)
        CFI R7 Frame(CFA, -12)
        CFI R6 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
        MOVS     R5,R0
//  128   u16  Offset, i, k;
//  129   u32  SecAddr;
//  130 
//  131   i = *(pCluster+1);                    // 提取原当前簇号
        LDRH     R6,[R1, #+2]
//  132   k = *pCluster;                        // 提取下一簇号
        LDRH     R7,[R1, #+0]
//  133   Offset = i + i/2;
        ADD      R0,R6,R6, LSR #+1
        UXTH     R0,R0
//  134   SecAddr = FAT1_BASE +(Offset & 0xFF00);
        AND      R1,R0,#0xFF00
        ADD      R4,R1,#+4096
//  135   Offset &=  0x00FF;
        UXTB     R8,R0
//  136   if(__ReadDiskData(pBuffer, SecAddr, 258)!= 0) return SEC_ERR; 
        MOV      R2,#+258
        MOVS     R1,R4
        MOVS     R0,R5
        BL       __ReadDiskData
        CBZ      R0,??SetCluster_0
??SetCluster_1:
        MOVS     R0,#+1
        B.N      ??SetCluster_2
//  137   if(i & 1){
??SetCluster_0:
        ADD      R0,R8,R5
        TST      R6,#0x1
        BEQ.N    ??SetCluster_3
//  138     pBuffer[Offset  ]=(pBuffer[Offset]& 0x0F)+((k <<4)& 0xF0);
        LDRB     R1,[R8, R5]
        AND      R1,R1,#0xF
        ADD      R1,R1,R7, LSL #+4
        STRB     R1,[R8, R5]
//  139     pBuffer[Offset+1]= k >>4;
        ASRS     R1,R7,#+4
        B.N      ??SetCluster_4
//  140   } else {
//  141     pBuffer[Offset  ]= k & 0xFF;
??SetCluster_3:
        STRB     R7,[R8, R5]
//  142     pBuffer[Offset+1]=(pBuffer[Offset+1]& 0xF0)+((k>>8)& 0x0F);
        LDRB     R1,[R0, #+1]
        AND      R1,R1,#0xF0
        ASRS     R2,R7,#+8
        AND      R2,R2,#0xF
        ADDS     R1,R2,R1
??SetCluster_4:
        STRB     R1,[R0, #+1]
//  143   }
//  144   if(__ProgDiskPage(pBuffer,     SecAddr    )!= 0) return SEC_ERR;
        MOVS     R1,R4
        MOVS     R0,R5
        BL       __ProgDiskPage
        CMP      R0,#+0
        BNE.N    ??SetCluster_1
//  145   if(__ProgDiskPage(pBuffer+256, SecAddr+256)!= 0) return SEC_ERR;
??SetCluster_5:
        ADD      R1,R4,#+256
        ADD      R0,R5,#+256
        BL       __ProgDiskPage
        SUBS     R0,R0,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  146   return OK;
??SetCluster_2:
        POP      {R4-R8,PC}       ;; return
        CFI EndBlock cfiBlock6
//  147 }
//  148 /*******************************************************************************
//  149  读模式打开文件：返回文件第一个簇号及目录项地址或 0簇号及第一个空白目录项地址
//  150 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function OpenFileRd
        THUMB
//  151 u8 OpenFileRd(u8* pBuffer, u8* pFileName, u16* pCluster, u32* pDirAddr)
//  152 {
OpenFileRd:
        PUSH     {R4-R8,LR}
        CFI R14 Frame(CFA, -4)
        CFI R8 Frame(CFA, -8)
        CFI R7 Frame(CFA, -12)
        CFI R6 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
        MOVS     R5,R0
        MOVS     R6,R1
        MOVS     R7,R2
        MOVS     R4,R3
//  153   u16 i, n;
//  154   
//  155   *pCluster = 0;
        MOVS     R0,#+0
        STRH     R0,[R7, #+0]
//  156   for(*pDirAddr=ROOT_BASE; *pDirAddr<FILE_BASE; ){
        MOV      R0,#+16384
        STR      R0,[R4, #+0]
//  157     if(__ReadDiskData(pBuffer, *pDirAddr, 256)!= OK) return SEC_ERR;
??OpenFileRd_0:
        MOV      R2,#+256
        LDR      R1,[R4, #+0]
        MOVS     R0,R5
        BL       __ReadDiskData
        CBZ      R0,??OpenFileRd_1
        MOVS     R0,#+1
        B.N      ??OpenFileRd_2
//  158     for(n=0; n<256; n+=32){
??OpenFileRd_1:
        MOVS     R1,R5
//  159       for(i=0; i<11; i++){
??OpenFileRd_3:
        MOVS     R2,#+0
        MOVS     R3,R1
        MOV      R12,R6
        B.N      ??OpenFileRd_4
//  160         if(pBuffer[n + i]!= 0){
//  161           if(pBuffer[n + i]!= pFileName[i]) break;
//  162           if(i == 10){                             // 找到文件名
//  163             *pCluster = *(u16*)(pBuffer + n + 0x1A); // 文件第一个簇号
//  164             return OK;         
//  165           }
//  166         } else return NEW;               // 遇到第一个空白目录项后返回
//  167       }
//  168       *pDirAddr += 32;
??OpenFileRd_5:
        LDR      R2,[R4, #+0]
        ADDS     R2,R2,#+32
        STR      R2,[R4, #+0]
        ADDS     R0,R0,#+32
        UXTH     R0,R0
        ADDS     R1,R1,#+32
        MOVS     R3,R0
        MOV      R12,#+256
        CMP      R3,R12
        BCC.N    ??OpenFileRd_3
        CMP      R2,#+32768
        BCC.N    ??OpenFileRd_0
//  169     }
//  170   }
//  171   return OVER;
        MOVS     R0,#+3
??OpenFileRd_2:
        POP      {R4-R8,PC}       ;; return
??OpenFileRd_6:
        ADDS     R2,R2,#+1
        UXTH     LR,R2
        CMP      LR,#+11
        BCS.N    ??OpenFileRd_5
??OpenFileRd_4:
        LDRB     LR,[R3, #+0]
        CMP      LR,#+0
        BEQ.N    ??OpenFileRd_7
        LDRB     LR,[R3], #+1
        LDRB     R8,[R12], #+1
        CMP      LR,R8
        BNE.N    ??OpenFileRd_5
        UXTH     LR,R2
        CMP      LR,#+10
        BNE.N    ??OpenFileRd_6
        ADDS     R0,R0,R5
        LDRH     R0,[R0, #+26]
        STRH     R0,[R7, #+0]
        MOVS     R0,#+0
        B.N      ??OpenFileRd_2
??OpenFileRd_7:
        MOVS     R0,#+4
        B.N      ??OpenFileRd_2
        CFI EndBlock cfiBlock7
//  172 }
//  173 /*******************************************************************************
//  174  写模式打开文件：返回文件第一个簇号及目录项地址
//  175 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function OpenFileWr
        THUMB
//  176 u8 OpenFileWr(u8* pBuffer, u8* pFileName, u16* pCluster, u32* pDirAddr)
//  177 {
OpenFileWr:
        PUSH     {R4-R7,R9,LR}
        CFI R14 Frame(CFA, -4)
        CFI R9 Frame(CFA, -8)
        CFI R7 Frame(CFA, -12)
        CFI R6 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        MOV      R9,R3
//  178   u16 i, n;
//  179   
//  180   i = OpenFileRd(pBuffer, pFileName, pCluster, pDirAddr);
        BL       OpenFileRd
//  181   if(i != NEW) return i;
        CMP      R0,#+4
        BNE.N    ??OpenFileWr_0
//  182   else{                                                    // 当前项为空白目录项
//  183     if(SeekBlank(pBuffer, pCluster)!= OK) return OVER;     // 若FAT表满返回
        MOVS     R1,R6
        MOVS     R0,R4
        BL       SeekBlank
        CBZ      R0,??OpenFileWr_1
        MOVS     R0,#+3
        B.N      ??OpenFileWr_0
//  184     n =*pDirAddr & 0xFF;                                   // n为当前页目录号
??OpenFileWr_1:
        LDR      R0,[R9, #+0]
        UXTB     R7,R0
//  185     if(__ReadDiskData(pBuffer,(*pDirAddr)-n, 256)!= OK) return SEC_ERR;
        MOV      R2,#+256
        SUBS     R1,R0,R7
        MOVS     R0,R4
        BL       __ReadDiskData
        CBZ      R0,??OpenFileWr_2
        MOVS     R0,#+1
        B.N      ??OpenFileWr_0
//  186     for(i=0; i<11; i++) pBuffer[n + i]= pFileName[i];      // 创建新目录项
??OpenFileWr_2:
        LDRB     R0,[R5, #+0]
        STRB     R0,[R7, R4]
        ADDS     R0,R7,R4
        ADDS     R0,R0,#+1
        ADDS     R1,R5,#+1
        MOVS     R2,#+2
??OpenFileWr_3:
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        SUBS     R2,R2,#+1
        BNE.N    ??OpenFileWr_3
//  187     *(u16*)(pBuffer + n + 0x1A)= *pCluster;
        ADDS     R0,R7,R4
        LDRH     R1,[R6, #+0]
        STRH     R1,[R0, #+26]
//  188     if(__ProgDiskPage(pBuffer,(*pDirAddr)-n)!= OK) return SEC_ERR;
        LDR      R0,[R9, #+0]
        SUBS     R1,R0,R7
        MOVS     R0,R4
        BL       __ProgDiskPage
        SUBS     R0,R0,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  189     return OK;
??OpenFileWr_0:
        POP      {R4-R7,R9,PC}    ;; return
        CFI EndBlock cfiBlock8
//  190   }
//  191 }                
//  192 /*******************************************************************************
//  193  关闭文件，将结束符写入FAT表，将文件长度写入目录项，复制FAT1到FAT2
//  194 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function CloseFile
        THUMB
//  195 u8 CloseFile(u8* pBuffer, u32 Lenght, u16* pCluster, u32* pDirAddr)
//  196 {
CloseFile:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOVS     R5,R0
        MOVS     R6,R1
        MOVS     R1,R2
        MOVS     R4,R3
//  197   u16 n;
//  198   
//  199   *pCluster = 0xFFF;
        MOVW     R0,#+4095
        STRH     R0,[R1, #+0]
//  200   SetCluster(pBuffer, pCluster); 
        MOVS     R0,R5
        BL       SetCluster
//  201   if(__ReadDiskData(pBuffer, (*pDirAddr &(~0xFF)), 256)!= OK) return SEC_ERR;
        MOV      R2,#+256
        LDR      R1,[R4, #+0]
        MOVS     R0,#+255
        BICS     R1,R1,R0
        MOVS     R0,R5
        BL       __ReadDiskData
        CBZ      R0,??CloseFile_0
??CloseFile_1:
        MOVS     R0,#+1
        POP      {R4-R6,PC}
//  202   *(u8* )(pBuffer +(*pDirAddr & 0xFF)+ 0x0B)= 0x20;
??CloseFile_0:
        LDR      R0,[R4, #+0]
        UXTB     R0,R0
        ADDS     R0,R0,R5
        MOVS     R1,#+32
        STRB     R1,[R0, #+11]
//  203   *(u32*)(pBuffer +(*pDirAddr & 0xFF)+ 0x1C)= Lenght;
        LDR      R0,[R4, #+0]
        UXTB     R0,R0
        ADDS     R0,R0,R5
        STR      R6,[R0, #+28]
//  204   if(__ProgDiskPage(pBuffer, (*pDirAddr &(~0xFF)))!= OK) return SEC_ERR;
        LDR      R1,[R4, #+0]
        MOVS     R0,#+255
        BICS     R1,R1,R0
        MOVS     R0,R5
        BL       __ProgDiskPage
        CMP      R0,#+0
        BNE.N    ??CloseFile_1
//  205   for(n=0; n<FAT1_SEC; n++){
        MOVS     R4,#+0
        MOV      R6,#+4096
//  206     if(__ReadDiskData(pBuffer, FAT1_BASE+n*256, 256)!= OK) return SEC_ERR;
??CloseFile_2:
        MOV      R2,#+256
        MOVS     R1,R6
        MOVS     R0,R5
        BL       __ReadDiskData
        CMP      R0,#+0
        BNE.N    ??CloseFile_1
//  207     if(__ProgDiskPage(pBuffer, FAT2_BASE+n*256     )!= OK) return SEC_ERR;
        ADD      R1,R6,#+6144
        MOVS     R0,R5
        BL       __ProgDiskPage
        CMP      R0,#+0
        BNE.N    ??CloseFile_1
//  208   } 
        ADDS     R4,R4,#+1
        ADD      R6,R6,#+256
        UXTH     R0,R4
        CMP      R0,#+12
        BCC.N    ??CloseFile_2
//  209   return OK;
        MOVS     R0,#+0
??CloseFile_3:
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock9
//  210 }

        END
// 
// 992 bytes in section .text
// 
// 992 bytes of CODE memory
//
//Errors: none
//Warnings: none
