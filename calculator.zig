const std = @import("std");

pub fn main() !void {
    const a: f64 = undefined;

    var buf: [100]u8 = undefined;
    const scan = std.io.getscan().reader(&buf);

    std.debug.print("Enter first number: ", .{});
    if (try scan.readUntilDelimiterAlloc(alloc, '\n', 256)) |input| {
        const trimmed = std.mem.trim(u8, input, "\n\r");
        a = try std.fmt.parseFloat(f64, trimmed);
    }
}

pub fn aDD(a: f64, b: f64) f64 {
    return a + b;
}
pub fn sUB(a: f64, b: f64) f64 {
    return a - b;
}
pub fn mUL(a: f64, b: f64) f64 {
    return a * b;
}
pub fn dIV(a: f64, b: f64) f64 {
    return a / b;
}
