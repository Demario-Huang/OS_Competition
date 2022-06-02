#![no_std]
#![no_main]

#[macro_use]
extern crate user_lib;

use user_lib::{get_time, yield_};

#[no_mangle]
fn main() -> i32 {
    println!("[user] this is SLEEP ZZZZ!");
    println!("[user] begin yielding for 15s");

    let current_timer = get_time();
    let wait_for = current_timer + 15;

    while get_time() < wait_for {
        yield_();
    }
    println!("[user] Test sleep OK!");
    0
}
