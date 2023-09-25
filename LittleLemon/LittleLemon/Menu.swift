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
    
    var body: some View {
        VStack{
            // TODO: Provide descriptions and enhance UI
            Text("TODO: App Name")
            Text("TODO: App Location")
            Text("TODO: App Description")
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
