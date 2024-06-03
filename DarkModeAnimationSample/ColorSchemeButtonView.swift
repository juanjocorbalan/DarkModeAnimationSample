//
//  ColorSchemeButtonView.swift
//  DarkModeAnimationSample
//
//  Created by Juanjo Corbalan on 29/5/24.
//

import SwiftUI

struct ColorSchemeButtonView: View {
    @Binding var scheme: ColorScheme
    var action: (() -> Void)?

    init(scheme: Binding<ColorScheme>, action: (() -> Void)? = nil) {
        self._scheme = scheme
        self.action = action
    }

    var body: some View {
        Button(action: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                action?()
            }
        }, label: {
            Image(systemName: scheme == .light ? "sun.max" : "moon")
                .font(.title2.bold())
                .foregroundStyle(scheme == .dark ? .white : .black)
                .padding(8)
                .background{
                    Circle()
                        .stroke(lineWidth: 2)
                        .fill(scheme == .dark ? .white : .black)
                }
        })
        .buttonStyle(ColorSchemeButtonStyle())
    }
}

struct ColorSchemeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.3 : 1)
    }
}

#Preview {
    ColorSchemeButtonView(scheme: .constant(.light))
}
