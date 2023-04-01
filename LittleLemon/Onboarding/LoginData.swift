//
//  LoginData.swift
//  LittleLemon
//
//  Created by Abdel on 01/04/2023.
//

struct LoginData: Equatable {
    var firstName = ""
    
    var lastName = ""
    
    var email = ""
    
    /// Returns `true` if the current login state is valid.
    var isValid: Bool {
        !firstName.isEmpty &&
        !lastName.isEmpty &&
        email.wholeMatch(of: LoginData.emailRegex) != nil
    }
    
    /// A regular expression that matches an email address.
    private static let emailRegex = try! Regex("^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$")
}
