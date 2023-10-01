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
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var searchText = ""
    
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
                
                // Search Bar
                TextField("Search menu", text: $searchText)
                
                FetchedObjects(predicate: buildPredicate()
                               ,sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    List{
                        ForEach(dishes, id: \.self) { dish in
                            HStack{
                                Text("title: \(dish.title ?? "unknown title")")
                                Text("price: \(dish.price ?? "unknown price")")
                                
                                // using Apple example of error handling for AsyncImage
                                AsyncImage(url: URL(string: dish.image ?? "no image")) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } else if phase.error != nil {
                                        Color.red
                                    } else {
                                        ProgressView()
                                    }
                                } // end AsyncImage
                            }
                        }
                    }
                } // end FetchedObjects
            } // end VStack (Bottom Half of Menu)
        } // end VStack (entire Menu)
        .onAppear {
            getMenuData()
        }
    }
    
    
    func getMenuData() {
        
        // clear database (per Coursera course instruction)
        PersistenceController.shared.clear()
        
        // get URL
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        
        // create URL request
        let urlRequest = URLRequest(url: url)
        
        // create URL Session task
        let task = URLSession.shared.dataTask(with: urlRequest) { data, reponse, error in
            
            if let data = data, let string = String(data: data, encoding: .utf8) {
                
                // convert string to Data format
                let menuListData = Data(string.utf8)
                
                // create decoder and use it to decode based off of MenuList created earlier
                let decoder = JSONDecoder()
                let menuList = try! decoder.decode(MenuList.self, from: menuListData)

                // convert decoded data to CoreData entities
                for foodItem in menuList.menu {
                    let newDish = Dish(context: viewContext) // Note - initially had an error saying "Dish could not be found" - quitting and restarting Xcode seemed to solve this as this class is created dynamically
                    
                    newDish.title = foodItem.title
                    newDish.price = foodItem.price
                    newDish.image = foodItem.image
                    print(newDish.title)
                }
                
                try? viewContext.save() // save to CoreData
                
            } else {
                print("unsuccessful decoding - data not valid")
            }
        }
        task.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {

        // alphabetical sort descriptor
        return [
            NSSortDescriptor(key: "title",
                            ascending: true,
                             selector: #selector(NSString.localizedCaseInsensitiveCompare))
        ]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            // filter on TextField entry
            return NSPredicate(format: "title CONTAINS[cd] %@",  "\(searchText)")
        }
    }
    
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
