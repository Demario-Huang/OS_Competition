#![no_std]
#![no_main]

#[macro_use]
extern crate user_lib;

#[no_mangle]
fn main() -> i32 {
    println!("[user] Hello, world!");
    println!("[user] trap tested well now!");
    0
}