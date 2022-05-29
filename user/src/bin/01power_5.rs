#![no_std]
#![no_main]

#[macro_use]
extern crate user_lib;

const LEN: usize = 100;

#[no_mangle]
fn main() -> i32 {
    println!("[user] this is power 5555!");
    let p = 5u64;
    let m = 998244353u64;
    let iter: usize = 140000;
    let mut s = [0u64; LEN];
    let mut cur = 0usize;
    s[cur] = 1;
    for i in 1..=iter {
        let next = if cur + 1 == LEN { 0 } else { cur + 1 };
        s[next] = s[cur] * p % m;
        cur = next;
        if i % 10000 == 0 {
            println!("[user] power_5 [{}/{}]", i, iter);
        }
    }
    println!("[user] {}^{} = {}(MOD {})", p, iter, s[cur], m);
    println!("[user] Test power_5 OK!");
    0
}
