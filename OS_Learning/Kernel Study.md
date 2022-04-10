# Kernel Study

单内核模式下的层次：

调用服务的主程序层，执行系统调用的服务层，和支持系统调用的底层函数

<img src="/Users/huangpengxiang/Library/Application Support/typora-user-images/截屏2022-03-10 下午3.01.58.png" alt="截屏2022-03-10 下午3.01.58" style="zoom:33%;" />

内核主要由5个模块组成：

进程调度，内存管理，文件系统，进程通信，网络接口。

<img src="/Users/huangpengxiang/Library/Application Support/typora-user-images/截屏2022-03-10 下午3.03.06.png" alt="截屏2022-03-10 下午3.03.06" style="zoom:33%;" />

整体的结构框图：

<img src="/Users/huangpengxiang/Library/Application Support/typora-user-images/截屏2022-03-10 下午3.03.58.png" alt="截屏2022-03-10 下午3.03.58" style="zoom:33%;" />

## 初始化

在/boot目录下，引导程序把内核从磁盘加载到内存中，并让系统进入保护程序下运行。

就开始执行/init/main.c. 该程序首选对各部分设备进行初始化，让系统处于可以运行的状态下。

然后把自己手动移到任务0中运行，并自己fork出进程1。在进程1中程序将继续进行对应用环境对初始化并执行登陆shell程序，而原进程0则会在系统空闲时被调度执行。

移动到任务0执行这个过程 是由头文件/include/asm/system.h这个程序执行，function: move_to_user_mode. 把main.c的程序执行流从内核态降到了用户态。（使用中断）

## boot

boot目录下有三个文件：作用分别是计算机加电时引导内核启动，将内核代码加载进内存中，并做一些初始化的工作。

https://www.sunxiaokong.xyz/2020-08-08/lzx-babyos-1/

主要流程：

PC电源打开进入实模式，从地址0xFFFF0开始自动执行代码

在物理地址为0的地方初始化中断向量

启动设备的第一扇区（512字节），读入内存的0x7C00处（31kb）
