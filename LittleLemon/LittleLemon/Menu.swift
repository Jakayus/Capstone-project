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
    @State private var startersPredicate = false
    @State private var dessertsPredicate = false
    @State private var mainsPredicate = false
    @State private var color: Color = Color.gray
    
    
    @State private var predicateSelection = PredicateSelection.None
    
    enum PredicateSelection {
        case None
        case Starters
        case Mains
        case Desserts
    }
    
    
    
    var body: some View {
        VStack{
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
                // Search Bar
                TextField("🔍 Search menu", text: $searchText)
                    .padding(5)
                    .foregroundColor(.black)
                    .overlay { RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.yellow)}
                    .background(Color.white)
                    .padding()
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
                
                HStack {
                    Button("Starters"){
                        predicateSelection = .Starters
                    }
                    .foregroundColor(.black)
                    .buttonStyle(.bordered)
                    .background(predicateSelection == .Starters ? Color("Secondary1") : Color.white)
                    .cornerRadius(10)
                    
                    Button("Mains"){
                        predicateSelection = .Mains
                    }
                    .foregroundColor(.black)
                    .buttonStyle(.bordered)
                    .background(predicateSelection == .Mains ? Color("Secondary1") : Color.white)
                    .cornerRadius(10)
                    
                    .cornerRadius(10)
                    Button("Desserts") {
                        predicateSelection = .Desserts
                    } .foregroundColor(.black)
                        .buttonStyle(.bordered)
                        .background(predicateSelection == .Desserts ? Color("Secondary1") : Color.white)
                        .cornerRadius(10)
                    
                    Button("Reset") {
                        predicateSelection = .None
                    } .foregroundColor(.black)
                        .buttonStyle(.bordered)
                        .cornerRadius(10)
                    
                }
                
                FetchedObjects(predicate: buildPredicate()
                               ,sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    List{
                        ForEach(dishes, id: \.self) { dish in
                            HStack{
                                VStack (alignment: .leading) {
                                    Text("\(dish.title ?? "Unknown Dish")")
                                        .bold()
                                        .font(.title3)
                                    Text("\(dish.foodDescription ?? "Description Unknown")")
                                        .foregroundColor(Color.gray)
                                    Text("$\(dish.price ?? "Unknown Price")")
                                        .bold()
                                }
                                
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
                    newDish.category = foodItem.category
                    newDish.foodDescription = foodItem.description
                    
                    // debut - print(newDish.title)
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
        
        // have predicates default to no filtering
        var searchPredicate = NSPredicate(value: true)
        var buttonPredicate = NSPredicate(value: true)
        
        if searchText.isEmpty {
            // do nothing
        } else {
            // filter on TextField entry
            searchPredicate = NSPredicate(format: "title CONTAINS[cd] %@",  "\(searchText)")
        }
        
        // additional category predicate
        let starters = NSPredicate(format: "category MATCHES[cd] %@", "starters")
        let mains = NSPredicate(format: "category MATCHES[cd] %@", "mains")
        let desserts = NSPredicate(format: "category MATCHES[cd] %@", "desserts")
        
        switch predicateSelection {
        case .None:
            buttonPredicate = NSPredicate(value: true)
        case .Starters:
            buttonPredicate = starters
        case .Mains:
            buttonPredicate = mains
        case .Desserts:
            buttonPredicate = desserts
        }
        
        
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [searchPredicate, buttonPredicate])
        
        return compoundPredicate
    }
    
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
