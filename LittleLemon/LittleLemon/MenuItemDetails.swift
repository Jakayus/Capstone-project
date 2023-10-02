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
            Text("Destination Reached")
            Text("\(dishEntity.foodDescription ?? "Unknown food")")
        }
    }
}

//struct MenuItemDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuItemDetails()
//    }
//}
