//
//  EventRow.swift
//  Digital-14
//
//  Created by Naveed Shaikh on 24/09/21.
//

import SwiftUI
import URLImage

struct EventRow: View {
    
    var event: Event
    @EnvironmentObject var favorites: Favorites

    @State var performaImage:String = ""
    @ObservedObject var networkManager = NetworkManager()

    var body: some View {
        HStack {
            let imgURL = networkManager.returnImageUrl(performaImg: event.performers)
                        
            URLImage(URL(string: imgURL)!) { image in
                image
                    .resizable().resizable().frame(width: 140, height: 140).cornerRadius(20.0).shadow(radius: 10)
                    .overlay(ImageOverlay(isFav: self.favorites.contains(event), event: event), alignment: .topLeading)
                }
            
            VStack {
                Spacer()
                HStack {
                    Text(event.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .lineLimit(nil)
                    Spacer()
                }
                HStack {
                    Text(event.venue.state) + Text(",")
                    Text(event.venue.country)
                    Spacer()
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                HStack {
                    Text(networkManager.getDateForEvent(createdDate: event.created_at)).foregroundColor(.gray).frame(maxWidth:.infinity, alignment: .leading)
                }
                Spacer()
            }
        }.frame(height: 130)
    }
}

// MARK: OverlayFavouriteImage On Image
struct ImageOverlay: View {
    @State var isFav : Bool
    var event: Event
    @EnvironmentObject var favorites: Favorites
    var body: some View {
        ZStack{
        Button(action: {
           self.isFav.toggle()
            if(!isFav) {
                self.favorites.remove(self.event)
            }
            else {
                self.favorites.add(self.event)
            }
        }) {
            Image(systemName:"heart.fill")
                  .resizable()
                .frame(width: 30, height: 25)
                .foregroundColor(self.isFav == true ? .red : .gray)
            }
           .buttonStyle(PlainButtonStyle())
        }
    }
}



