//
//  FoodItem.swift
//  LittleLemon
//
//  Created by Joel Sereno on 9/30/23.
//

import SwiftUI

struct FoodItem: View {
    
    @State var foodName: String
    @State var foodPrice: String
    @State var foodDescription: String
    
    
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("\(foodName)")
                    .bold()
                    .font(.title3)
                Text("\(foodDescription)")
                    .foregroundColor(Color.gray)
                Text("$\(foodPrice)")
                    .bold()
            }
            .padding()
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100, maxHeight: 100)

        }
    }
}

struct FoodItem_Previews: PreviewProvider {
    static var previews: some View {
        FoodItem(foodName: "Food Name", foodPrice: "Free.99", foodDescription: "Great food")
    }
}
