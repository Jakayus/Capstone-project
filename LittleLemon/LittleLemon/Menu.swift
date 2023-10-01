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
                    Text("Little Lemon").foregroundColor(Color("Primary2"))
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
                        .padding([.leading])
                    Image("Hero Image")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding([.bottom, .trailing])
                }
            }
            .background(Color("Primary1"))
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("OUT FOR DELIVERY")
                        .bold()
                        .font(.caption)
                    Image("Delivery Van")
                        .resizable()
                        .frame(width: 50, height: 25)
                }
                
                HStack{
                    Button("Starters"){ }.buttonStyle(.bordered)
                    Button("Mains") { }.buttonStyle(.bordered)
                    Button("Desserts") { }.buttonStyle(.bordered)
                    Button("Sides") { }.buttonStyle(.bordered)
                }
                
                
                List {
                    ForEach(TemporarySamples, id: \.self) { foodItem in
                        FoodItem(foodName: foodItem)
                    }
                }
            }
            
            
        }
        .onAppear {
            getMenuData()
        }
    }
    
    
    func getMenuData() {
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        
        let urlRequest = URLRequest(url: url)
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { url, reponse, error in
            print(url ?? "no url")
        }
        downloadTask.resume()
    }
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
