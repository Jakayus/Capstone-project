//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Joel Sereno on 9/24/23.
//

import SwiftUI

// User Default keys

let firstNameKey = "First_Name_Key"
let lastNameKey = "Last_Name_Key"
let emailKey = "Email_Key"


struct Onboarding: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var isLoggedIn = false
    
    
    var body: some View {
        NavigationView {
            VStack{
                // Note - assignment requests iOS15 style coding
                NavigationLink(destination: Home(),
                               isActive: $isLoggedIn) {
                    EmptyView()
                }
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                Button( action: {
                    
                    // store values in UserDefaults
                    if firstNameKey.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: firstNameKey)
                    } else if lastNameKey.isEmpty {
                        UserDefaults.standard.set(lastName, forKey: lastNameKey)
                    } else if emailKey.isEmpty {
                        // TODO: add email validation
                        UserDefaults.standard.set(email, forKey: emailKey)
                    }
                    isLoggedIn = true
                    
                }, label: {
                    Text("Register")
                })
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
