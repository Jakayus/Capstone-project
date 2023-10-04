//
//  NavigationBar.swift
//  LittleLemon
//
//  Created by Joel Sereno on 10/2/23.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
        HStack {
            Spacer()
            Image("Logo")
                .resizable()
                .fixedSize()
            Image("Profile")
                .resizable()
                .frame(width: 50, height: 50)
                .padding([.trailing])
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
            .previewLayout(.sizeThatFits)
    }
}
