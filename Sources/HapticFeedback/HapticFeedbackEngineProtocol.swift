//
//  HapticFeedbackEngineProtocol.swift
//  HapticFeedback IOS
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

// MARK: - HapticFeedbackEngine

public protocol HapticFeedbackEngine {

    /// Log flag
    var logEnabled: Bool! { get set }

    /// Prepare
    func prepare() throws

    /// Generate feedback notification
    func generate(_ feedbackNotification: HapticFeedbackNotification)
}
