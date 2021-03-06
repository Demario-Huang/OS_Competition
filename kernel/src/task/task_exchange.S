.altmacro
.macro SAVE_SN n
    sd s\n, (\n+3)*8(a0)
.endm
.macro LOAD_SN n
    ld s\n, (\n+3)*8(a1)
.endm
    .section .text
    .globl __switch
__switch:
    # __switch(
    #     current_task_cx_ptr: *mut TaskContext,
    #     next_task_cx_ptr: *const TaskContext
    # )
    # save kernel stack of current task
    sd sp, 8(a0)
    # save ra & s0~s11 of current execution

    # 下面两行是自己加的
    csrr t1, sepc
    sd t1, 0(a0)

    # sd ra, 0(a0)
    .set n, 0
    .rept 12
        SAVE_SN %n
        .set n, n + 1
    .endr


    # restore ra & s0~s11 of next execution
    ld ra, 0(a1)
    .set n, 0
    .rept 12
        LOAD_SN %n
        .set n, n + 1
    .endr
    # restore kernel stack of next task
    ld sp, 8(a1)

    # ld t1, 16(a1)
    # csrw satp, t1
    # sfence.vma

    ret

