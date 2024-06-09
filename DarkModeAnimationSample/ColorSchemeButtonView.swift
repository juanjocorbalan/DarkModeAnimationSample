//
//  ColorSchemeButtonView.swift
//  DarkModeAnimationSample
//
//  Created by Juanjo Corbalan on 29/5/24.
//

import SwiftUI

struct ColorSchemeButtonView: View {
    @Environment(\.colorScheme) private var scheme
    var action: (() -> Void)?

    var body: some View {
        Button(action: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                action?()
            }
        }, label: {
            Image(systemName: scheme == .light ? "sun.max" : "moon")
        })
        .buttonStyle(ColorSchemeButtonStyle(scheme: scheme))
    }
}

struct ColorSchemeButtonStyle: ButtonStyle {
    let scheme: ColorScheme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2.bold())
            .foregroundStyle(scheme == .dark ? .white : .black)
            .padding(8)
            .background{
                Circle()
                    .stroke(lineWidth: 2)
                    .fill(scheme == .dark ? .white : .black)
            }
            .scaleEffect(configuration.isPressed ? 1.3 : 1)
    }
}

#Preview {
    ColorSchemeButtonView()
}
