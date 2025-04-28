const std = @import("std");
const stdout = std.io.getStdOut().writer();
const allocator = std.heap.page_allocator;

fn input_fail() error{InvalidArgument} {
    std.debug.print("\nNo input provided.\n", .{});

    return error.InvalidArgument;
}

fn copy(str: []const u8) ![]u8 {
    return try std.mem.Allocator.dupe(allocator, u8, str);
}

fn get_input_from_console(message: []const u8) ![]u8 {
    const stdin = std.io.getStdIn().reader();
    var buffer: [32]u8 = undefined;

    try stdout.print("{s}", .{message});
    const input: ?[]u8 = (try stdin.readUntilDelimiterOrEof(&buffer, '\n')) orelse return input_fail();

    return copy(input.?);
}

fn input_float(message: []const u8) !f32 {
    const input: []u8 = try get_input_from_console(message);
    defer allocator.free(input);

    return try std.fmt.parseFloat(f32, input);
}

fn input_int(message: []const u8) !i32 {
    const input: []u8 = try get_input_from_console(message);
    defer allocator.free(input);

    return try std.fmt.parseInt(i32, input, 10);
}

fn calculate_gloss_salary(lesson_value: f32, lessons_worked_month: i32) f64 {
    return lesson_value * @as(f32, @floatFromInt(lessons_worked_month));
}

fn calculate_net_salary(gross_salary: f64, inss_discount_percentage: f32) f64 {
    return gross_salary - (gross_salary * inss_discount_percentage / 100);
}

fn display_salaries(gross_salary: f64, net_salary: f64) !void {
    try stdout.print("\nGross Salary: {d:.2}\n", .{gross_salary});
    try stdout.print("Net Salary: {d:.2}\n", .{net_salary});
}

pub fn main() !void {
    const lesson_value: f32 = try input_float("Enter the lesson value: ");
    const lessons_worked_month: i32 = try input_int("Enter the number of lessons worked in the month: ");
    const inss_discount_percentage: f32 = try input_float("Enter the INSS discount percentage: ");

    const gross_salary: f64 = calculate_gloss_salary(lesson_value, lessons_worked_month);
    const net_salary: f64 = calculate_net_salary(gross_salary, inss_discount_percentage);

    try display_salaries(gross_salary, net_salary);
}
