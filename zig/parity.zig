const std = @import("std");
const stdout = std.io.getStdOut().writer();

fn even_or_odd(number: i64) []const u8 {
    if (@rem(number, 2) == 0) {
        return "even";
    }

    return "odd";
}

fn input_fail() error{InvalidArgument} {
    return error.InvalidArgument;
}

fn get_input_from_console(message: []const u8) !i32 {
    const stdin = std.io.getStdIn().reader();
    var buffer: [32]u8 = undefined;

    try stdout.print("{s}", .{message});
    const input: ?[]u8 = (try stdin.readUntilDelimiterOrEof(&buffer, '\n')) orelse return input_fail();
    const number: i32 = try std.fmt.parseInt(i32, input.?, 10);

    return number;
}

fn show_results(number: i64) !void {
    try stdout.print("\nThe sum of the two numbers is: {d}", .{number});
    try stdout.print("\nThe number is: {s}\n", .{even_or_odd(number)});
}

pub fn main() !void {
    const number_a: i32 = try get_input_from_console("1 - Enter a number to add: ");
    const number_b: i32 = try get_input_from_console("2 - Enter another number to add: ");
    const number_c: i64 = number_a + number_b;

    try show_results(number_c);
}
