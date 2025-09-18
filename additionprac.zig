const std = @import("std");

pub fn main() void {
    const a: i32 = 500;
    const b: i32 = 400;

    const result = a + b;

    std.debug.print("{} + {} = {} \n", .{ a, b, result });
}
