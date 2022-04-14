# API Design

#### MM

address.h:

1. struct Phys_Addr {ppn, offset};
   + To_long(self) => 输入Phys_Addr, 转换为物理地址long
   + From_long(long) => 输入物理地址long，转换为Phys_Addr
2. struct Virt_Addr {vpn, offset}
   + To_long() => 同上
   + From_long() => same
3. fn parse_vpn(vpn) => (L2, L1, L0)

Frame_allocator.h:

1. struct Frame_allocator {start, end, *cycle_list};
   + fn alloct_frame() => ppn
   + fn free_frame(ppn): 释放frame，将该ppn push进cycle_list

PageTable.h

0. struct Permission_Bits {R, W, X, V...}

1. struct PTE {ppn, Permission_Bits}
   + new() => 将Permission_Bits.V 初始化为1
   + empty() => 清零
   + is_valid() => 检查该PTE是否已经激活

2. struct Page_table {root_ppn}

   + fn new() => Page_table: 调用alloct_frame, 将返回的ppn设为root_ppn

   + fn map(vpn, ppn): 建表
   + fn unmap(vpn)
   + Translate(vpn) => ppn：不经过MMU，手动查表

Area.h (对一个段（虚拟内存连续，访存特权一致）的)

1. struct Permission { } 对这一个段的访存特权
2. MapType {Identical, Framed}: Identical: 线性，Framed：非线性

3. struct Area {VPNrange: Vector. Permission, MapType}
   + map_one(vpn): 
     + 若Framed：调用frame_allocator分配一个frame得到ppn。调用map（ppn，vpn）
     + 若Identical：let ppn = vpn。调用map（ppn，vpn）
   + unmap_one(vpn)
   + map_all(self): 将VPNrange中的vpn一个个map_one()
   + unmap_all(self)
   + Copy_Data(*data, self.VPNrange): 迭代VPNrange, 调用Page_Table.Translate得到ppn，将data写入ppn

Memory_set.h （对整个应用程序地址空间的抽象）

1. struct Memory_set {page_table, Areas: Vec};

   + parse_elf => 得到应用程序的每个段

   + push()：调用copy_data和map_all

   + drop(self.pagetable): 清空，释放frames

   + New_kernel(): 重新建立kernel的内存空间 - 调用push并线性建立kernel的页表

   + New_app(): 调用parse_elf解析elf文件，调用push为应用程序的每个段分配frames，建立叶表

mm.h

1. fn activte() 修改寄存器启动分页模式
2. fn init() 调用Memory_set.New_kernel( ). 

---

#### Trap控制流

trap_context.h

1. struct Trap_Context { x[32]: 保存32位通用寄存器, sstatus: 指示现在出于什么Mode，sepc: 存储应用程序下一行应该执行的指令，kernel_satp: （不变）内核根目录所在的物理页帧页数，kernel_sp: （不变）对应的内核栈顶，trap_handler: trap_handler函数的地址 }
   + fn new() -> Trap_Context: 
     + 初始化x[2]位应用程序用户栈栈顶
     + sstatus：User
     + spec：应用程序入口
     + kernel_satp: （不变）内核根目录所在的物理页帧页数
     + kernel_sp: （不变）对应的内核栈顶
     + trap_handler: （不变）trap_handler函数的地址

trap.S

 1. __alltrap (a0: Trap_Context的VPN（定值）， a1: 应用程序Page Table根目录)

    + 将satp改为a1, 实现地址空间从内核转向指定应用程序的地址空间

    + 将sp和sscratch指向a0
    + 恢复普通寄存器与特殊寄存器现场
    + spec寄存器设置为Trap_Contex.spec
    + sp指向x[2]
    + 调用sret返回，开始执行spec寄存器指向的位置

 2. __restore

    + 交换sp和sscratch (这样sscratch会指向用户栈当前位置，sp会指向Trap上下文)
    + 保存寄存器现场到trap_context.x[]
    + 保存sstatus, sepc到trap_context.sstatus和trap_contex.sepc中
    + 将sscratch保存到x[2]中
    + 将satp设置为指向trap_contex.kernel_stap
    + 将sp指向trap内核栈顶
    + 跳转到context.trap_handler开始执行。

trap.h

1. set_user_trap_entry(): 将stvec寄存器设置为Trampoline
2. return_user( ): 
   + 调用set_user_trap_entry( )
   + 调用__restore
3. trap_handler():
   + 根据scause和stval，分发处理异常
   + 处理完后，调用return_user

timer.h

1. init_timer: 
   + 将sie的寄存器开启，从而允许时钟中断
   + 调用rustsbi的set_timer, 开启时钟中断

---

#### 进程管理

Trap_context.h 

1. struct Trap_context {ra: ret返回后执行的位置，sp：返回后使用的栈指针，s[12] 通用寄存器}
   + fn go_to_user_mode(*kernel_stack_ptr): 将ra甚至为trap.h的return_user。 将sp设置为内核栈指针

Task_Control_Block.h

1. struct Pid_Acclocator {begin, end, cycle_list}: 功能类似frame_allocator, 分配空闲的pid
   + fn alloc -> pid
   + fn dealloc(pid)
   
2. struct KernelStack{pid}   -> 代表一个内核栈
   + new() -> 向KERNEL_SPACE map进一段内核栈
   + top() -> 返回内核栈顶点

3. struct TCB {pid，KernelStack, trap_context_ppn, task_context, status, memory_set, parent, children: Vec, exit_code}  => 非常重要的数据结构，代表了一个进程

   + get_trap_context
   + get_memory_set
   + get_status
   + new() => 初始化一个进程：包括调用memory_set的方法将一个elf文件map进内存中，调用pid_allocator获取一个pid，调用trap.h中的new()初始化trap context，初始化一个内核栈，将task 上下文设置为go_to_user_mode。最终返回一个TCB
   + exec() => 执行一个elf文件：将memory set替换为新的elf对应的内存空间。并改变新初始化一个trap上下文。
   + fork() => 根据当前的TCB完全clone一个一模一样的TCB。
   
4. stuct Status {只能为Ready, Running, Zombie其中的一个}

TaskManager.h -> 用一个队列维护出于Ready状态的TCB

1. struct TaskManager {ready_queue: Vec(TCB)}
   + new() => 生成一个空的队列
   + add(TCB) => 加入一个TCB到队尾
   + pop( ) => 弹出一个TCB准备执行
2. fn init_zero_proc => 手动加入初始化第一个应用程序的TCB并到TaskManager里

core.h -> 对处理器的一个抽象

1. struct core {current：TCB, idle_proc_task_context: Trap_context}
   + new() => 零初始化idle_proc
2. fn run_tasks( )：一个无限循环，其功能是从TaskManager中弹出一个TCB，将core记录的current和这个TCB进行任务切换（包括上下文切换，调用switch.S中的__switch函数）。
   + 一开始时它是和idle_proc_task_context切换, idle_proc_task_context即变成了当前内核正在执行的位置。然后处理器跳转去执行之前手动初始化的第一个应用程序

3. fn switch_to_idle( ): 将core中的当前程序与idle_pro_task_context调用__switch交换，并将换出来的程序放到TaskManager的尾部。即又回到执行run_tasks的循环

4. stop_then_run_next( ): 当时钟中断产生，traphandler会调用这个函数。其调用switch_to_idle( )，调用switch将当前的进程放入TaskManager队尾，并回到执行run_tasks的循环。

5. exit_then_run( ): 和stop_then_run_next的区别是不再放入队尾，而是直接free掉。这是trap_handler检测到程序退出的时候调用的



   

