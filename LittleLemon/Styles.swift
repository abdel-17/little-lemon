import SwiftUI

private struct LemonTextFieldStyle: ViewModifier {
    @FocusState private var focused
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(
                Capsule()
                    .stroke(focused ? Color.accentColor : Color.secondary,
                            lineWidth: 2)
            )
            .focused($focused)
    }
}

extension TextField {
    func lemonStyle() -> some View {
        self.modifier(LemonTextFieldStyle())
    }
}

private struct LemonButtonStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderedProminent)
            .foregroundColor(colorScheme == .dark ? .black : .white)
    }
}

extension Button {
    func lemonStyle() -> some View {
        self.modifier(LemonButtonStyle())
    }
}
