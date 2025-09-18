const std = @import("std");

fn readFloat(alloc: std.mem.Allocator, prompt: []const u8) !f64 {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{s}", .{prompt});

    const stdin = std.io.getStdIn().reader();
    const line = try stdin.readUntilDelimiterAlloc(alloc, '\n', 256);
    defer alloc.free(line);

    const trimmed = std.mem.trim(u8, line, " \t\r");
    return std.fmt.parseFloat(f64, trimmed);
}

fn readOp(alloc: std.mem.Allocator) !u8 {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Enter operator (+, -, *, /): ", .{});

    const stdin = std.io.getStdIn().reader();
    const line = try stdin.readUntilDelimiterAlloc(alloc, '\n', 16);
    defer alloc.free(line);

    const trimmed = std.mem.trim(u8, line, " \t\r");
    if (trimmed.len == 0) return error.EmptyOperator;
    return trimmed[0];
}

fn add(a: f64, b: f64) f64 {
    return a + b;
}
fn sub(a: f64, b: f64) f64 {
    return a - b;
}
fn mul(a: f64, b: f64) f64 {
    return a * b;
}
fn div(a: f64, b: f64) f64 {
    return a / b;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const a = try readFloat(alloc, "Enter first number: ");
    const op = try readOp(alloc);
    const b = try readFloat(alloc, "Enter second number: ");

    const result = switch (op) {
        '+' => add(a, b),
        '-' => sub(a, b),
        '*' => mul(a, b),
        '/' => if (b == 0) return error.DivisionByZero else div(a, b),
        else => return error.UnknownOperator,
    };

    const stdout = std.io.getStdOut().writer();
    try stdout.print("Result: {d:.2}\n", .{result});
}
