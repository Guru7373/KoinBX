//
//  Double+Extension.swift
//  KoinBX
//
//  Created by Guru on 23/04/25.
//

import Foundation

/// A utility extension for the `Double` type that provides additional functionality.

extension Double {
    /// Rounds a `Double` to a specified number of decimal places.
    ///
    /// - Parameter places: The number of decimal places to round to.
    /// - Returns: A new `Double` rounded to the specified number of decimal places.
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
