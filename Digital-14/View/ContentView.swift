//
//  ContentView.swift
//  Digital-14
//
//  Created by Naveed Shaikh on 24/09/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    @ObservedObject var favorites = Favorites()
    
    @State private var searchText = ""
    
    var body: some View {
        
        ZStack {
            //To set base color to app.
            //Color.ui.baseColor.edgesIgnoringSafeArea(.all)
            VStack {
                NavigationView {
                VStack {
                    SearchBar(text: $searchText, onTextChanged: searchEvents)
                    Spacer()
                    if networkManager.loading {
                        Text("Enter Text in SearchBar ...")
                        Spacer()
                    } else {
                        List {
                            ForEach(networkManager.theEvents.events.filter {
                                self.searchText.isEmpty ? true : $0.title.lowercased().contains(self.searchText.lowercased())
                            }) { myEvent in
                                NavigationLink(destination: EventDetailView(event: myEvent)) {
                                        EventRow(event: myEvent)
                                    
                                }
                            }
                        }
                        
                    }
                 }
                .environmentObject(favorites)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                }
            }
        }
    }
    
    func searchEvents(for searchText: String) {
        if !searchText.isEmpty {
            var searchedString = ""
            searchedString = searchText.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
            networkManager.loadDataForSearchQuery(searchText: searchedString)
        }
    }
    

}


extension Color {
    static let ui = Color.UI()
    
    struct UI {
         let baseColor = Color("AppBaseColor")
    }
}

