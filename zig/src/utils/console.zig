//! This module provides utility functions for console input and output.

const std = @import("std");
const testing = std.testing;
const allocator = testing.allocator;
const Allocator = std.mem.Allocator;
const Writer = std.io.Writer;

const Alignment = enum {
    Left,
    Right,
    Center,
};

/// Copies a string to a new buffer using the provided allocator.
fn copy(alloc: Allocator, string: []const u8) ![]u8 {
    return try std.mem.Allocator.dupe(alloc, u8, string);
}

/// Get input from the console and copy it to a new buffer.
pub fn input(comptime T: type, stdin: anytype, stdout: anytype, alloc: Allocator, message: ?[]const u8, on_input_failure: ?fn () anyerror) !?[]u8 {
    var buffer: [@bitSizeOf(T)]u8 = undefined;

    if (message) |msg| {
        try stdout.print("{s}", .{msg});
    }

    const value: ?[]u8 = (try stdin.readUntilDelimiterOrEof(&buffer, '\n')) orelse {
        if (on_input_failure) |on_fail| {
            return on_fail();
        }

        return null;
    };

    return try copy(alloc, value.?);
}

/// Parses the input buffer to integer
pub fn parseInt(comptime T: type, buffer: []u8, base: u8) !T {
    if (@typeInfo(T) != .int) {
        @compileError("Type must be an integer");
    }

    return try std.fmt.parseInt(T, buffer, base);
}

/// Parses the input buffer to float
pub fn parseFloat(comptime T: type, buffer: []u8) !T {
    if (@typeInfo(T) != .float) {
        @compileError("Type must be a float");
    }

    return try std.fmt.parseFloat(T, buffer);
}

/// Parses the input buffer to boolean
pub fn parseBool(buffer: []u8) !bool {
    if (std.mem.eql(u8, buffer, "true")) {
        return true;
    }

    if (std.mem.eql(u8, buffer, "false")) {
        return false;
    }

    return error.InvalidCharacter;
}

/// Parses the input buffer to character
pub fn parseChar(buffer: []u8) !u8 {
    if (buffer.len != 1) {
        return error.InvalidCharacter;
    }

    return buffer[0];
}

/// Converts isize to usize safely
fn safeCastToUsize(potential_usize: isize) ?usize {
    return if (potential_usize >= 0) @as(usize, @intCast(potential_usize)) else null;
}

/// Handles left-aligned display of a message in the console.
fn handleLeftDisplay(stdout: std.io.Writer, message: []const u8, width: u8, padding_char: []const u8, left_border: []const u8, right_border: []const u8) !void {
    try stdout.print("{s}{s}", .{ left_border, message });

    const padding_length: isize = @as(isize, @intCast(@as(isize, @intCast(width - message.len)) - @as(isize, @intCast(left_border.len - right_border.len))));
    if (safeCastToUsize(padding_length)) |padding_len| {
        try stdout.writeBytesNTimes(padding_char, padding_len);
    }

    try stdout.print("{s}", .{right_border});
}

// fn handleRightDisplay(stdout: anytype, message: []const u8, width: u8, padding_char: u8, left_border: ?u8, right_border: ?u8) !void {}

// fn handleCenterDisplay(stdout: anytype, message: []const u8, width: u8, padding_char: u8, left_border: ?u8, right_border: ?u8) !void {}

/// Display a message in the console with specified width, padding character, and alignment.
pub fn display(stdout: anytype, message: []const u8, width: u8, padding_char: []const u8, alignment: Alignment, left_border: []const u8, right_border: []const u8) !void {
    try switch (alignment) {
        Alignment.Left => handleLeftDisplay(stdout, message, width, padding_char, left_border, right_border),
        // Alignment.Right => handleRightDisplay(stdout, message, width, padding_char, left_border, right_border),
        // Alignment.Center => handleCenterDisplay(stdout, message, width, padding_char, left_border, right_border),
        else => return error.InvalidAlignment,
    };
}

test "copy function duplicates the string correctly" {
    const original = "Hello world!";
    const copied: []u8 = try copy(allocator, original);
    defer allocator.free(copied);

    try testing.expectEqualStrings(original, copied);
}

test "input function reads input from console correctly" {
    const expected = "Hello world!";
    const mock = expected ++ "\n";

    {
        var fbs = std.io.fixedBufferStream(mock);
        const stdin = fbs.reader();
        const stdout = std.io.getStdOut().writer();

        const result: ?[]u8 = try input(u32, stdin, stdout, allocator, null, null);
        defer allocator.free(result.?);

        try testing.expectEqualStrings(expected, result.?);
    }

    {
        const expected_stdout = "Enter something: ";

        var fbs = std.io.fixedBufferStream(mock);
        const stdin = fbs.reader();
        var output_buffer: [1024]u8 = undefined;
        var output_stream = std.io.fixedBufferStream(&output_buffer);
        const stdout = output_stream.writer();

        const result: ?[]u8 = try input(u32, stdin, stdout, allocator, expected_stdout, null);
        defer allocator.free(result.?);

        const captured_stdout = output_stream.getWritten();

        try testing.expectEqualStrings(expected_stdout, captured_stdout);
        try testing.expectEqualStrings(expected, result.?);
    }
}

test "input function returns null for empty input" {
    const expected: ?[]u8 = null;
    const mocked_input = "";

    {
        var fbs = std.io.fixedBufferStream(mocked_input);
        const stdin = fbs.reader();
        const stdout = std.io.getStdOut().writer();

        const result: ?[]u8 = try input(u32, stdin, stdout, allocator, null, null);

        try testing.expectEqual(expected, result);
    }

    {
        const expected_stdout = "Enter anything: ";

        var fbs = std.io.fixedBufferStream(mocked_input);
        const stdin = fbs.reader();
        var output_buffer: [1024]u8 = undefined;
        var output_stream = std.io.fixedBufferStream(&output_buffer);
        const stdout = output_stream.writer();

        const result: ?[]u8 = try input(u32, stdin, stdout, allocator, expected_stdout, null);
        const captured_stdout = output_stream.getWritten();

        try testing.expectEqualStrings(expected_stdout, captured_stdout);
        try testing.expectEqual(expected, result);
    }
}

// Mock function to simulate input failure
fn input_failure() anyerror {
    return error.InvalidCharacter;
}

test "input function handles input failure correctly" {
    const expected = error.InvalidCharacter;
    const mocked_input = "";

    {
        var fbs = std.io.fixedBufferStream(mocked_input);
        const stdin = fbs.reader();
        const stdout = std.io.getStdOut().writer();
        // try stdout.writeBytesNTimes(padding_char, padding_length);

        const result: anyerror!?[]u8 = input(u32, stdin, stdout, allocator, null, input_failure);

        try testing.expectError(expected, result);
    }

    {
        const expected_stdout = "Type somewhat: ";

        var fbs = std.io.fixedBufferStream(mocked_input);
        const stdin = fbs.reader();
        var output_buffer: [1024]u8 = undefined;
        var output_stream = std.io.fixedBufferStream(&output_buffer);
        const stdout = output_stream.writer();

        const result: anyerror!?[]u8 = input(u32, stdin, stdout, allocator, expected_stdout, input_failure);
        const captured_stdout = output_stream.getWritten();

        try testing.expectEqualStrings(expected_stdout, captured_stdout);
        try testing.expectError(expected, result);
    }
}

test "parseInt function parses integer input correctly" {
    const expected = 17;
    const mocked_input: []u8 = try copy(allocator, "17");
    defer allocator.free(mocked_input);

    const result: i32 = try parseInt(i32, mocked_input, 10);

    try testing.expectEqual(expected, result);
}

test "parseInt function parses integer input with different base correctly" {
    const expected = 255;
    const mocked_input: []u8 = try copy(allocator, "ff");
    defer allocator.free(mocked_input);

    const result: u32 = try parseInt(u32, mocked_input, 16);

    try testing.expectEqual(expected, result);
}

test "parseInt function returns error for invalid input" {
    const expected = error.InvalidCharacter;
    const mocked_input: []u8 = try copy(allocator, "invalid");
    defer allocator.free(mocked_input);

    const result: anyerror!i32 = parseInt(i32, mocked_input, 10);

    try testing.expectError(expected, result);
}

test "parseFloat function parses float input correctly" {
    const expected = 3.14;
    const mocked_input: []u8 = try copy(allocator, "3.14");
    defer allocator.free(mocked_input);

    const result: f32 = try parseFloat(f32, mocked_input);

    try testing.expectEqual(expected, result);
}

test "parseFloat function returns error for invalid input" {
    const expected = error.InvalidCharacter;
    const mocked_input: []u8 = try copy(allocator, "invalid");
    defer allocator.free(mocked_input);

    const result: anyerror!f32 = parseFloat(f32, mocked_input);

    try testing.expectError(expected, result);
}

test "parseBool function parses boolean input correctly" {
    const expected = true;
    const mocked_input: []u8 = try copy(allocator, "true");
    defer allocator.free(mocked_input);

    const result: bool = try parseBool(mocked_input);

    try testing.expectEqual(expected, result);
}

test "parseBool function returns error for invalid input" {
    const expected = error.InvalidCharacter;
    const mocked_input: []u8 = try copy(allocator, "invalid");
    defer allocator.free(mocked_input);

    const result: anyerror!bool = parseBool(mocked_input);

    try testing.expectError(expected, result);
}

test "parseChar function parses character input correctly" {
    const expected = 'A';
    const mocked_input: []u8 = try copy(allocator, "A");
    defer allocator.free(mocked_input);

    const result: u8 = try parseChar(mocked_input);

    try testing.expectEqual(expected, result);
}

test "parseChar function returns error for invalid input" {
    const expected = error.InvalidCharacter;
    const mocked_input: []u8 = try copy(allocator, "invalid");
    defer allocator.free(mocked_input);

    const result: anyerror!u8 = parseChar(mocked_input);

    try testing.expectError(expected, result);
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    // try display(stdout, "TASKTASKTASKTASKTASK", 20, "=", Alignment.Left, "\n\n|", "|\n\n");
    try display(stdout, "TASKTASKTASKTASKTASK", 30, "=", Alignment.Left, "\n\n|", "|\n\n");
}
