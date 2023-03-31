//
//  RegistrationView.swift
//  LittleLemon
//
//  Created by Abdel on 26/03/2023.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject private var loginViewModel: LoginViewModel

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Create Account")
                    .font(.title)
                    .bold()
                
                Spacer()
            }
            
            FormInput(label: "First name*",
                      placeholder: "Enter your first name",
                      input: $loginViewModel.firstName)

            FormInput(label: "Last name*",
                      placeholder: "Enter your last name",
                      input: $loginViewModel.lastName)

            FormInput(label: "Email address*",
                      placeholder: "Enter your email address",
                      input: $loginViewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

            Button("Submit") {
                loginViewModel.login()
            }
            .lemonStyle()
            .padding(.top)
            .disabled(!loginViewModel.isValid)
        }
        .padding()
    }
}

fileprivate struct FormInput: View {
    let label: String

    let placeholder: String

    @Binding var input: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .padding(.horizontal)

            TextField(placeholder, text: $input)
                .lemonStyle()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(LoginViewModel())
    }
}
