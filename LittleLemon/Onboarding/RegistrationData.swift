//
//  Registration.swift
//  LittleLemon
//
//  Created by Abdel on 26/03/2023.
//

import Foundation

struct RegistrationData {
    var firstName = ""
    
    var lastName = ""
    
    var email = ""
    
    var isValid: Bool {
        !firstName.isEmpty &&
        !lastName.isEmpty &&
        !email.isEmpty  // Email validation could be better
    }
    
    private struct Keys {
        static let firstName = "firstName"
        
        static let lastName = "lastName"
        
        static let email = "email"
    }
    
    static func load(from store: UserDefaults) -> RegistrationData? {
        guard
            let firstName = store.string(forKey: Keys.firstName),
            let lastName = store.string(forKey: Keys.lastName),
            let email = store.string(forKey: Keys.email)
        else {
            return nil
        }
        return RegistrationData(firstName: firstName,
                                lastName: lastName,
                                email: email)
    }
    
    func save(to store: UserDefaults) {
        store.set(RegistrationData.Keys.firstName, forKey: firstName)
        store.set(RegistrationData.Keys.lastName, forKey: lastName)
        store.set(RegistrationData.Keys.email, forKey: email)
    }
}
