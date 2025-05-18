const std = @import("std");
const stdout = std.io.getStdOut().writer();

const BmiClassification = enum {
    underweight,
    normal_weight,
    overweight,
    obesity,
};

fn validate_data(weight: f32, height: f32) !void {
    if (weight <= 0 or height <= 0) {
        std.debug.print("\nInvalid input. Weight and height must be positive numbers.\n", .{});

        return error.InvalidArgument;
    }
}

fn get_bmi_classification(bmi: f32) BmiClassification {
    if (bmi < 19) {
        return BmiClassification.underweight;
    } else if (bmi < 25) {
        return BmiClassification.normal_weight;
    } else if (bmi < 30) {
        return BmiClassification.overweight;
    }

    return BmiClassification.obesity;
}

fn display_result(bmi: f32) !void {
    var buffer: [128]u8 = undefined;
    const classification = get_bmi_classification(bmi);

    try stdout.print("\nYour BMI is: {d:.2}\n", .{bmi});

    const result: []u8 = try switch (classification) {
        .underweight => std.fmt.bufPrint(&buffer, "Classification: Underweight\n", .{}),
        .normal_weight => std.fmt.bufPrint(&buffer, "Classification: Normal Weight\n", .{}),
        .overweight => std.fmt.bufPrint(&buffer, "Classification: Overweight\n", .{}),
        .obesity => std.fmt.bufPrint(&buffer, "Classification: Obesity\n", .{}),
    };

    try stdout.print("{s}", .{result});
}

fn calculate_bmi(weight: f32, height: f32) f32 {
    const height_in_meters: f32 = height / 100.0;

    return weight / (height_in_meters * height_in_meters);
}

fn input_fail() error{InvalidArgument} {
    std.debug.print("\nNo input provided.\n", .{});

    return error.InvalidArgument;
}

fn get_input_from_console(message: []const u8) !f32 {
    const stdin = std.io.getStdIn().reader();
    var buffer: [32]u8 = undefined;

    try stdout.print("{s}", .{message});
    const input: ?[]u8 = (try stdin.readUntilDelimiterOrEof(&buffer, '\n')) orelse return input_fail();
    const value = try std.fmt.parseFloat(f32, input.?);

    return value;
}

pub fn main() !void {
    const weight: f32 = try get_input_from_console("Enter your weight in kilograms: ");
    const height: f32 = try get_input_from_console("Enter your height in centimeters: ");

    try validate_data(weight, height);

    const bmi: f32 = calculate_bmi(weight, height);

    try display_result(bmi);
}
