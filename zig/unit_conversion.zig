const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();
    const err = error.InvalidArgument;
    var buffer: [32]u8 = undefined;

    try stdout.print("What is the measurement in feet?: ", .{});
    const input: ?[]u8 = (try stdin.readUntilDelimiterOrEof(&buffer, '\n')) orelse {
        std.debug.print("\nNo input provided.\n", .{});

        return err;
    };

    const feet: f32 = try std.fmt.parseFloat(f32, input.?);

    if (feet < 0) {
        std.debug.print("\nValue cannot be negative!\n", .{});

        return err;
    }

    const inches: f64 = feet * 12;
    const yards: f64 = feet * 3;
    const miles: f64 = yards / 1760;

    try stdout.print("\n\nIn inches: {d}", .{inches});
    try stdout.print("\nIn yards: {d}", .{yards});
    try stdout.print("\nIn miles: {d}\n", .{miles});
}
