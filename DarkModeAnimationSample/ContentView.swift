//
//  ContentView.swift
//  DarkModeAnimationSample
//
//  Created by Juanjo Corbalan on 30/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var changeScheme: Bool = false
    @State private var scheme: ColorScheme = .light
    @State private var screenshot: UIImage? = nil
    @State private var buttonFrame: CGRect = .zero
    private var animationDuration: TimeInterval = 1.4

    @State private var value1: Bool = true
    @State private var value2: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Sample settings") {
                    Toggle(isOn: $value1, label: {
                        Text("Toggle 1")
                    })
                    Toggle(isOn: $value2, label: {
                        Text("Toggle 2")
                    })
                }

                Section("Appearance") {
                    LabeledContent("Color scheme") {
                        ColorSchemeButtonView(scheme: $scheme) {
                            screenshot = UIApplication.shared.rootView?.snapshot()
                            scheme = scheme == .light ? .dark : .light
                            withAnimation(.linear(duration: animationDuration)) {
                                changeScheme = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                                changeScheme = false
                                screenshot = nil
                            }
                        }
                        .overlay {
                            GeometryReader { proxy in
                                Color.clear
                                    .preference(key: FrameKey.self, value: proxy.frame(in: .global))
                            }
                        }
                        .onPreferenceChange(FrameKey.self) { buttonFrame = $0 }
                    }
                }
            }
            .navigationTitle("Settings")
        }
        .preferredColorScheme(scheme)
        .colorSchemeOverlay(changeScheme: changeScheme, screenshot: screenshot, anchor: buttonFrame)
    }
}

extension View {
    func colorSchemeOverlay(changeScheme: Bool, screenshot: UIImage?, anchor: CGRect) -> some View {
        self
            .overlay {
                if let image = screenshot {
                    Image(uiImage: image)
                        .mask {
                            GeometryReader { proxy in
                                Circle()
                                    .frame(width: anchor.width, height: anchor.height)
                                    .scaleEffect(changeScheme
                                                 ? 1
                                                 : hypot(max(anchor.midX, proxy.size.width - anchor.midX),
                                                         max(anchor.midY, proxy.size.height - anchor.midY))
                                                 / (anchor.width / 2))
                                    .offset(x: anchor.origin.x, y: anchor.origin.y)
                            }
                        }
                }
            }
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
