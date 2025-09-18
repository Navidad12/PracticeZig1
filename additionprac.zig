const std = @import("std");

pub fn main() void {
    const a: f64 = 500;
    const b: f64 = 400;

    const result = a + b;

    std.debug.print("{} + {} = {} \n", .{ a, b, result });
}
