//
//  Home.swift
//  LittleLemon
//
//  Created by Joel Sereno on 9/25/23.
//

import SwiftUI

struct Home: View {
    
    @State private var tabSelection = 1
    
    var body: some View {
        // Default TabView Template for now
        TabView(selection: $tabSelection) {
            Text("Tab Content 1").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 1")/*@END_MENU_TOKEN@*/ }.tag(1)
            Text("Tab Content 2").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 2")/*@END_MENU_TOKEN@*/ }.tag(2)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
