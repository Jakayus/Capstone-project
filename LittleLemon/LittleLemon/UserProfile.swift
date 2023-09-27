//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Joel Sereno on 9/27/23.
//

import SwiftUI

struct UserProfile: View {
    
    private let firstName = UserDefaults.standard.string(forKey: firstNameKey ) ?? "User First Name"
    private let lastName = UserDefaults.standard.string(forKey: lastNameKey ) ?? "User Second Name"
    private let email = UserDefaults.standard.string(forKey: emailKey ) ?? "User Email"
    
    var body: some View {
        VStack{
            Text("Personal Information")
            Image("profile-image-placeholder")
                .resizable()
                .scaledToFit()
            Text(firstName)
            Text(lastName)
            Text(email)
        }
    }
}

#Preview {
    UserProfile()
}