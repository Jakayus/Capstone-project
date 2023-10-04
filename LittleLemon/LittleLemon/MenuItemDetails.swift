//
//  MenuItemDetails.swift
//  LittleLemon
//
//  Created by Joel Sereno on 10/2/23.
//

import SwiftUI

struct MenuItemDetails: View {
    //let dishEntity: Dish
    
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    Text("Pasta")
                        .font(.system(size: 60))
                        .bold()
                        .padding([.leading])
                    Spacer()
                    Text("$12.99")
                        .font(.title2)
                        .bold()
                        .padding([.trailing])
                }
                Image("Pasta")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(5)
                    .padding()
                Text("Penne with fried aubergines, cherry tomatoes, tomato sauce, fresh chilli, garlic, basil & salted ricotta cheese.")
                    .font(.title3)
                    .italic()
                    .foregroundColor(Color.gray)
                    .padding()
                    
                
            } // end VStack
        }
    }
}

struct MenuItemDetails_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemDetails()
    }
}
