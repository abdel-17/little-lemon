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
            
            LabeledTextField(
                label: "First name*",
                placeholder: "Enter your first name",
                text: $loginViewModel.loginData.firstName)

            LabeledTextField(
                label: "Last name*",
                placeholder: "Enter your last name",
                text: $loginViewModel.loginData.lastName)

            LabeledTextField(
                label: "Email address*",
                placeholder: "Enter your email address",
                text: $loginViewModel.loginData.email)
            .emailTextField()

            Button("Submit") {
                loginViewModel.onLogin()
            }
            .lemonStyle()
            .padding(.top)
            .disabled(!loginViewModel.loginData.isValid)
        }
        .padding()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(LoginViewModel())
    }
}
