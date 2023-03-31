//
//  LabeledTextField.swift
//  LittleLemon
//
//  Created by Abdel on 31/03/2023.
//

import SwiftUI

struct LabeledTextField: View {
    let label: String

    let placeholder: String

    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .padding(.horizontal)

            TextField(placeholder, text: $text)
                .lemonStyle()
        }
    }
}

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        LabeledTextField(
            label: "Name",
            placeholder: "Enter your name",
            text: Binding(get: { "Abdelrahman" },
                          set: { _, _ in })
        )
    }
}
