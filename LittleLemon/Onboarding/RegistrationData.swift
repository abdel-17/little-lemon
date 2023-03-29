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
    
    /// Fake registration data.
    ///
    /// Use this mainly for previews.
    static let fake = RegistrationData(firstName: "Ahmed",
                                       lastName: "Mohamed",
                                       email: "ahmedmohamed@gmail.com")
    
    private struct Keys {
        static let firstName = "firstName"
        
        static let lastName = "lastName"
        
        static let email = "email"
    }
    
    func save(to store: UserDefaults) {
        store.set(firstName, forKey: RegistrationData.Keys.firstName)
        store.set(lastName, forKey: RegistrationData.Keys.lastName)
        store.set(email, forKey: RegistrationData.Keys.email)
        debugPrint("Saved registration data to \(store)")
    }
    
    static func load(from store: UserDefaults) -> RegistrationData? {
        guard
            let firstName = store.string(forKey: Keys.firstName),
            let lastName = store.string(forKey: Keys.lastName),
            let email = store.string(forKey: Keys.email)
        else {
            debugPrint("No registration data found in \(store)")
            return nil
        }
        debugPrint("Loading registration data from \(store)")
        return RegistrationData(firstName: firstName,
                                lastName: lastName,
                                email: email)
    }
    
    static func delete(from store: UserDefaults) {
        store.set(nil, forKey: RegistrationData.Keys.firstName)
        store.set(nil, forKey: RegistrationData.Keys.lastName)
        store.set(nil, forKey: RegistrationData.Keys.email)
        debugPrint("Deleted registration data from \(store)")
    }
}
