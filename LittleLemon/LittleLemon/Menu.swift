//
//  Menu.swift
//  LittleLemon
//
//  Created by Joel Sereno on 9/25/23.
//

import SwiftUI

struct Menu: View {
    
    // Sample data until real data is acquired
    private let TemporarySamples = ["Burger", "Fries", "Drink"]
    
    let AppDescription = "We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist."
    
    var body: some View {
        VStack{
            Image("Logo")
                .resizable()
                .fixedSize()
            
            VStack (alignment: .leading) {
                VStack (alignment: .leading) {
                    Text("Litte Lemon").foregroundColor(Color("Primary2"))
                        .font(.largeTitle)
                        .font(.custom("Avenir Book", size: 22))
                        .bold()
                        .padding([.leading])
                    Text("Chicago")
                        .foregroundColor(Color.white)
                        .font(.title)
                        .padding([.leading])
                }

                HStack{
                    Text(AppDescription)
                        .foregroundColor(Color.white)
                        .font(.title3)
                        .padding([.leading, .trailing])
                    Image("Hero Image")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding([.bottom, .trailing])
                }
            }
            .background(Color("Primary1"))
            .ignoresSafeArea()
            
            
            
            List {
                ForEach(TemporarySamples, id: \.self) { foodItem in
                    Text(foodItem)
                }
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
