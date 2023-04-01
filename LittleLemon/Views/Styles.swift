import SwiftUI

extension Color {
    static var olive: Color {
        Color("olive")
    }
}

private struct LemonTextFieldStyle: ViewModifier {
    @FocusState private var focused

    let blurredStrokeColor: Color

    func body(content: Content) -> some View {
        content
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(
                Capsule()
                    .strokeBorder(focused ? .accentColor : blurredStrokeColor,
                                  lineWidth: 2)
            )
            .focused($focused)
    }
}

extension TextField {
    func lemonStyle(blurredStrokeColor: Color = .secondary) -> some View {
        modifier(LemonTextFieldStyle(blurredStrokeColor: blurredStrokeColor))
    }
}

extension View {
    /// Optimizes this view for email text input.
    ///
    /// Applies the following modifiers to this view:
    /// 1) `keyboardType(.emailAddress)`
    /// 2) `textInputAutocapitalization(.never)`
    /// 3) `textInputAutocapitalization(.never)`
    func emailTextField() -> some View {
        self
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
    }
}

private struct LemonButtonStyle: ViewModifier {
    @Environment(\.isEnabled) private var isEnabled
    
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content
            .foregroundColor(isEnabled && colorScheme == .dark ? .black : nil)
            .buttonStyle(.borderedProminent)
    }
}

extension Button {
    func lemonStyle() -> some View {
        modifier(LemonButtonStyle())
    }
}
