//
//  RegistrationView.swift
//  LittleLemon
//
//  Created by Abdel on 26/03/2023.
//

import SwiftUI

struct OnboardingView: View {
    @State var registrationData = RegistrationData()
    
    var body: some View {
        VStack(spacing: 24) {
            FormInput(label: "First Name*",
                      placeholder: "Enter your first name",
                      input: $registrationData.firstName)
            
            FormInput(label: "Last Name*",
                      placeholder: "Enter your last name",
                      input: $registrationData.lastName)
            
            FormInput(label: "Email*",
                      placeholder: "Enter your email address",
                      input: $registrationData.lastName)
            
            SubmitButton(registrationData: registrationData)
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
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(
                    Capsule()
                        .stroke(.black, lineWidth: 2)
                )
        }
    }
}

fileprivate struct SubmitButton: View {
    let registrationData: RegistrationData
    
    var body: some View {
        Button("Submit") {
            registrationData.save(to: UserDefaults.standard)
        }
        .buttonStyle(.borderedProminent)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
