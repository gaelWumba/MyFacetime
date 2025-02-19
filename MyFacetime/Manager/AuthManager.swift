//
//  AuthManager.swift
//  MyFacetime
//
//  Created by gael on 19/07/2024.
//

import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            completion(error == nil)
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            completion(error == nil)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }

}
