#![no_std]
#![no_main]

#[macro_use]
extern crate user_lib;

use user_lib::{get_time, yield_};

#[no_mangle]
fn main() -> i32 {
    println!("[user] this is SLEEP ZZZZ!");
    let current_timer = get_time();
    println!("[user] the current time is: {}", current_timer);

    let wait_for = current_timer + 3000;
    while get_time() < wait_for {
        yield_();
    }
    println!("[user] Test sleep OK!");
    0
}
