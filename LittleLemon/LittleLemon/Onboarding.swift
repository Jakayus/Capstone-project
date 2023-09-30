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
let loggedInKey = "Logged_In_Key"


struct Onboarding: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var isLoggedIn = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Primary1")
                    .ignoresSafeArea()
               VStack{
                    Text("Welcome to the Little Lemon App! ")
                       .foregroundColor(.yellow)
                        .font(.title)
                        .padding([.top, .horizontal])
                        .bold()
                   
                    Text("Create an account to continue")
                       .bold()
                       .foregroundColor(Color("Primary2"))
                        .padding()
                   
                    // Note - assignment requests iOS15 style coding, latest OS is iOS17
                    NavigationLink(destination: Home(),
                                   isActive: $isLoggedIn) {
                        EmptyView()
                    }
                   
                   TextField("",
                             text: $firstName,
                             prompt: Text("First Name")
                    .foregroundColor(.gray)
                   )
                   .foregroundColor(Color("Primary2"))
                    .padding()
                    .overlay { RoundedRectangle(cornerRadius: 5)
                            .stroke(.yellow, lineWidth: 1)
                    }
                    .padding(.horizontal)

                    TextField("",
                              text: $lastName,
                              prompt: Text("Last Name")
                        .foregroundColor(.gray)
                    )
                    .foregroundColor(Color("Primary2"))
                        .padding()
                        .overlay { RoundedRectangle(cornerRadius: 5)
                                .stroke(.yellow, lineWidth: 1)
                        }.foregroundColor(.red)
                        .padding(.horizontal)
                    TextField("",
                              text: $email,
                              prompt: Text("Email").foregroundColor(.gray)
                    )
                    .foregroundColor(Color("Primary2"))
                        .padding()
                        .overlay { RoundedRectangle(cornerRadius: 5)
                                .stroke(.yellow, lineWidth: 1)
                        }
                        .padding(.horizontal)
    
                    Button {
                        if ( !firstName.isEmpty &&
                             !lastName.isEmpty &&
                             !email.isEmpty) {
                            UserDefaults.standard.set(firstName, forKey: firstNameKey)
                            UserDefaults.standard.set(lastName, forKey: lastNameKey)
                            // TODO: add email validation
                            UserDefaults.standard.set(email, forKey: emailKey)
                            UserDefaults.standard.set(isLoggedIn, forKey: loggedInKey)
                            
                            isLoggedIn = true
                            
                            // clear entry fields
                            firstName = ""
                            lastName = ""
                            email = ""
                        } else {
                            // TODO: add alert
                        }
                        
                    } label: {
                        Text("Register")
                            .frame(maxWidth: 150)
                            
                            
                    }
                    .buttonStyle(.bordered)
                    .background(Color("Primary2"))
                    .foregroundColor(Color.black)
                    .cornerRadius(5)
                    .padding(.vertical)
                    
                    
                } // end VStack
                .onAppear {
                    if ( UserDefaults.standard.bool(forKey: loggedInKey) ) {
                        isLoggedIn = true
                    }
            }
            }
            
        } // end Navigation View
        
       
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
