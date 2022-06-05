#![no_std]
#![no_main]
#![allow(clippy::println_empty_string)]

extern crate alloc;

#[macro_use]
extern crate user_lib;

const LF: u8 = 0x0au8;
const CR: u8 = 0x0du8;
const DL: u8 = 0x7fu8;
const BS: u8 = 0x08u8;

use alloc::string::String;
use user_lib::console::getchar;
use user_lib::{exec, fork, waitpid};

#[no_mangle]
pub fn main() -> i32 {
    println!("Rust user shell");
    print!(">> ");
    let mut line: [char; 20] = ['\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0'];
    let mut index = 0;
    print!("{}",line[0] as char);
    loop {
        let c = getchar();
        match c {
            LF | CR => {
                println!("");
                if (line[0] == 'q' && line[1] == 'u' && line[2] == 'i' && line[3] == 't' && line[4] == '\0'){   // type quit to end the shell
                    return 0;
                }
                if index != 0 {
                    let pid = fork();
                    if pid == 0 {
                        // child process           
                        if (line[0] == '1' && line[1] == '\0'){
                            exec("exit\0");
                        }      
                        else if (line[0] == '2' && line[1] == '\0'){
                            exec("fantastic_text\0");
                        }
                        else if (line[0] == '3' && line[1] == '\0'){
                            exec("forkexec\0");
                        }
                        else if (line[0] == '4' && line[1] == '\0'){
                            exec("forktest\0");
                        }
                        else if (line[0] == '5' && line[1] == '\0'){
                            exec("forktest2\0");
                        }
                        else if (line[0] == '6' && line[1] == '\0'){
                            exec("forktest_simple\0");
                        }
                        else if (line[0] == '7' && line[1] == '\0'){
                            exec("forktree\0");
                        }
                        else if (line[0] == '8' && line[1] == '\0'){
                            exec("hello_world\0");
                        }
                        else if (line[0] == '9' && line[1] == '\0'){
                            exec("matrix\0");
                        }
                        else if (line[0] == '1' && line[1] == '0' && line[2] == '\0'){
                            exec("sleep\0");
                        }
                        else if (line[0] == '1' && line[1] == '1' && line[2] == '\0'){
                            exec("sleep_simple\0");
                        }
                        else if (line[0] == '1' && line[1] == '2' && line[2] == '\0'){
                            exec("stack_overflow\0");
                        }
                        else if (line[0] == '1' && line[1] == '3' && line[2] == '\0'){
                            exec("usertests\0");
                        }
                        else if (line[0] == '1' && line[1] == '4' && line[2] == '\0'){
                            exec("yield\0");
                        }
                        // }else{
                        //     panic!("Unknown file");
                        // }
                    } else {
                        let mut exit_code: i32 = 0;
                        let exit_pid = waitpid(pid as usize, &mut exit_code);
                        assert_eq!(pid, exit_pid);
                        println!("Shell: Process {} exited with code {}", pid, exit_code);
                    }
                    for i in 0..20{
                        line[i] = '\0';
                    }
                    index = 0;

                }
                print!(">> ");
            }
            BS | DL => {
                if !line.is_empty() {
                    print!("{}", BS as char);
                    print!(" ");
                    print!("{}", BS as char);
                    if (index >= 0){
                        line[index - 1] = '\0';
                        index -= 1;
                    }
                }
            }
            _ => {
                if (index < 20){
                    print!("{}", c as char);
                    line[index] = c as char;
                    index += 1;
                }
            }
        }
    }
    0
}
