//
//  HapticFeedbackPattern.swift
//  HapticFeedback IOS
//
//  Created by MacBook on 11.12.2020.
//

import Foundation

// MARK: - HapticFeedbackPattern

public class HapticFeedbackPattern {

    // MARK: - Properties

    /// Pattern
    var pattern: String

    /// Delay
    var delay: Double

    // MARK: - Initializers

    /// Create pattern
    /// - Parameters:
    ///   - pattern: pattern instance
    ///   - delay: delay instance
    init(pattern: String, delay: Double = 0.02) {
        self.pattern = pattern
        self.delay = delay
    }
}
