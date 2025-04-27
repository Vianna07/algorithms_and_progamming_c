const std = @import("std");
const stdout = std.io.getStdOut().writer();
const allocator = std.heap.page_allocator;
const math = std.math;

fn display_options() !void {
    try stdout.writeAll(
        \\
        \\Choose an option:
        \\
        \\1. Sine of the angle given in radians
        \\2. Sine of the angle given in degrees
        \\3. Tangent of the angle given in radians
        \\4. Tangent of the angle given in degrees
        \\5. Exit
        \\
    );
}

fn exit_program(option: i8) !void {
    if (option == 5) {
        try stdout.print("Exiting...\n", .{});
        std.process.exit(0);
    }
}

fn copy(str: []u8) ![]u8 {
    return try std.mem.Allocator.dupe(allocator, u8, str);
}

fn get_input_from_console(message: []const u8) ![]u8 {
    const stdin = std.io.getStdIn().reader();
    var buffer: [32]u8 = undefined;

    try stdout.print("{s}", .{message});
    const input: ?[]u8 = (try stdin.readUntilDelimiterOrEof(&buffer, '\n')) orelse return error.InvalidArgument;

    return copy(input.?);
}

fn get_angle() !f32 {
    const input: []u8 = try get_input_from_console("\nEnter the value of an angle: ");
    defer allocator.free(input);

    return try std.fmt.parseFloat(f32, input);
}

fn get_option() !i8 {
    const input: []u8 = try get_input_from_console("\nEnter the desired option: ");
    defer allocator.free(input);

    return try std.fmt.parseInt(i8, input, 10);
}

fn is_valid_option(option: i8) bool {
    return option >= 1 and option <= 4;
}

fn degrees_to_radians(degrees: f32) f32 {
    return degrees * math.pi / 180.0;
}

fn display_result(option: i8, angle: f32) !void {
    const radians: f32 = degrees_to_radians(angle);
    var buffer: [256]u8 = undefined;

    const result: []u8 = switch (option) {
        1 => try std.fmt.bufPrint(&buffer, "\nSine of {d:.2} radians = {d:.2}\n", .{ radians, math.sin(radians) }),
        2 => try std.fmt.bufPrint(&buffer, "\nSine of {d} degrees = {d:.2}\n", .{ angle, math.sin(radians) }),
        3 => try std.fmt.bufPrint(&buffer, "\nTangent of {d:.2} radians = {d:.2}\n", .{ radians, math.tan(radians) }),
        4 => try std.fmt.bufPrint(&buffer, "\nTangent of {d} degrees = {d:.2}\n", .{ angle, math.tan(radians) }),
        else => try std.fmt.bufPrint(&buffer, "\nInvalid option.\n", .{}),
    };

    try stdout.print("{s}", .{result});
}

fn main() !void {
    while (true) {
        const angle: f32 = get_angle() catch |err| {
            std.debug.print("\nError while trying to get angle: {}", .{err});
            try stdout.print("\nTry again.\n", .{});

            continue;
        };

        try display_options();

        const option: i8 = get_option() catch |err| {
            std.debug.print("\nError while trying to get option: {}", .{err});
            try stdout.print("\nTry again.\n", .{});

            continue;
        };

        try exit_program(option);

        if (!is_valid_option(option)) {
            try stdout.print("Invalid option. Try again.\n", .{});
            continue;
        }

        try display_result(option, angle);
    }
}
