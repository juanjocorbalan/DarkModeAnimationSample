//
//  Extensions.swift
//  DarkModeAnimationSample
//
//  Created by Juanjo Corbalan on 30/5/24.
//

import SwiftUI

struct FrameKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension UIView {
    func snapshot() -> UIImage {
        UIGraphicsImageRenderer(size: frame.size)
            .image { drawHierarchy(in: $0.format.bounds, afterScreenUpdates: true) }
    }
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?.keyWindow
    }

    var rootView: UIView? {
        firstKeyWindow?.rootViewController?.view
    }
}
