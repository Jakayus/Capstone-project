//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Joel Sereno on 9/24/23.
//

import SwiftUI

struct Onboarding: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    var body: some View {
        VStack{
            TextField("First Name", text: $firstName)
            TextField("Last Name", text: $lastName)
            TextField("Email", text: $email)
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
