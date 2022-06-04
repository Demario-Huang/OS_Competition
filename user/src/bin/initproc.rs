#![no_std]
#![no_main]

#[macro_use]
extern crate user_lib;

use user_lib::{exec, fork, wait, yield_};

#[no_mangle]
fn main() -> i32 {

    println!("[initproc] enter the init process!!");

    let pid = fork();

    println!("fork finish!");

    if pid == 0 {
        println!("This is Child Process!\n");
    }else{
        println!("This is Father Process!\n");
    }



    // if fork() == 0 {
    //     exec("user_shell\0");
    // } else {
    //     loop {
    //         let mut exit_code: i32 = 0;
    //         let pid = wait(&mut exit_code);
    //         if pid == -1 {
    //             yield_();
    //             continue;
    //         }
    //         println!(
    //             "[initproc] Released a zombie process, pid={}, exit_code={}",
    //             pid, exit_code,
    //         );
    //     }
    // }
    0
}