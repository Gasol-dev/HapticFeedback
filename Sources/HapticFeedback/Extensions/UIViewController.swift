//
//  UIViewController.swift
//  HapticFeedback IOS
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

// MARK: - UIViewController

extension UIViewController {

    // MARK: - Usefull

    public func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        hapticFeedbackNotification: HapticFeedbackNotification,
        completion: (() -> Void)? = nil
    ) {
        present(viewControllerToPresent, animated: flag, completion: completion)
        HapticFeedback.shared().generate(hapticFeedbackNotification)
    }
}
