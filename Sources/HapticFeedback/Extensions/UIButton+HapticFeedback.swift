//
//  UIButton+HapticFeedback.swift
//  HapticFeedback IOS
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

// MARK: - HapticFeedbackButton

class HapticFeedbackButton: UIButton {

    /// Add target to button
    /// - Parameter aDecoder: aDecoder instance
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTarget(self, action: #selector(didPress), for: .touchDown)
        addTarget(self, action: #selector(didRelease), for: .touchUpInside)
        addTarget(self, action: #selector(didRelease), for: .touchUpOutside)
    }

    // MARK: - Usefull

    @objc private func didPress() {
        HapticFeedback.shared().generate(.heavy)
    }

    @objc private func didRelease() {
        HapticFeedback.shared().generate(.light)
    }
}
