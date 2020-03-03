// Copyright (C) 2020 Andrew Lord

public protocol ImageCramPrinter {
    func output(message: @autoclosure () -> String)

    func output(error: @autoclosure () -> CustomStringConvertible)
}
