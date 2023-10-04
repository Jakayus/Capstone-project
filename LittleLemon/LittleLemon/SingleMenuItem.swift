//
//  SingleMenuItem.swift
//  LittleLemon
//
//  Created by Joel Sereno on 10/2/23.
//

import SwiftUI

struct SingleMenuItem: View {
    let dishEntity: Dish
    
    var body: some View {
        HStack{
            VStack (alignment: .leading) {
                Text("\(dishEntity.title ?? "Unknown Dish")")
                    .bold()
                    .font(.title3)
                Text("\(dishEntity.foodDescription ?? "Description Unknown")")
                    .foregroundColor(Color.gray)
                Text("$\(dishEntity.price ?? "Unknown Price")")
                    .bold()
            }
            
            // using Apple example of error handling for AsyncImage
            AsyncImage(url: URL(string: dishEntity.image ?? "no image")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 150, alignment: .trailing)
                    
                } else if phase.error != nil {
                   Image(systemName: "photo")
                        .frame(maxWidth: 150, alignment: .trailing)
                        .foregroundColor(.red)
                } else {
                    ProgressView("Loading...")
                        .frame(maxWidth: 150, alignment: .trailing)
                }
            } // end AsyncImage
        }
    }
}

//struct SingleMenuItem_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        SingleMenuItem(dishEntity: )
//    }
//}
