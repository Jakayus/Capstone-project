//
//  FoodItem.swift
//  LittleLemon
//
//  Created by Joel Sereno on 9/30/23.
//

import SwiftUI

struct FoodItem: View {
    
    @State var foodName: String
    var body: some View {
        HStack {
            VStack {
                Text("\(foodName)")
                Text("Menu Item Description")
                Text("Price")
            }
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .padding(50)
        }
    }
}

struct FoodItem_Previews: PreviewProvider {
    static var previews: some View {
        FoodItem(foodName: "Test me")
    }
}
