//
//  MenuItemDetails.swift
//  LittleLemon
//
//  Created by Joel Sereno on 10/2/23.
//

import SwiftUI

struct MenuItemDetails: View {
    let dishEntity: Dish
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text("\(dishEntity.title ?? "Unknown title")")
                    .font(.system(size: 60))
                    .bold()
                //.padding([.leading])
                Spacer()
            }
            // using Apple example of error handling for AsyncImage
            AsyncImage(url: URL(string: dishEntity.image ?? "no image")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(5)
                        .padding()
                    
                } else if phase.error != nil {
                    Image(systemName: "photo")
                        .frame(maxWidth: 150, alignment: .trailing)
                        .foregroundColor(.red)
                } else {
                    ProgressView()
                        .frame(maxWidth: 150, alignment: .trailing)
                }
            } // end AsyncImage
            
            VStack (alignment: .leading){
                Text("$\(dishEntity.price ?? "Unknown price")")
                    .font(.title2)
                    .bold()
                    .padding()
                Text("\(dishEntity.foodDescription ?? "Description not provided")")
                    .font(.title3)
                    .italic()
                    .foregroundColor(Color.gray)
                    .padding()
            }
        } // end VStack
    }
}

//struct MenuItemDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuItemDetails()
//    }
//}
