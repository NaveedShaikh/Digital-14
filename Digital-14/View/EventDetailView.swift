//
//  EventDetailView.swift
//  Digital-14
//
//  Created by Naveed Shaikh on 24/09/21.
//

import SwiftUI
import URLImage

struct EventDetailView: View {
    var event: Event
    @ObservedObject var networkManager = NetworkManager()

    var body: some View {
        VStack {
            let imgURL = networkManager.returnImageUrl(performaImg: event.performers)
            URLImage(URL(string: imgURL)!) { image in
                image
                    .resizable().frame(maxWidth:.infinity, maxHeight:200)
                }
            Text(networkManager.getDateForEvent(createdDate: event.created_at)).fontWeight(.bold).frame(maxWidth:.infinity, alignment: .leading)
            HStack {
                Text(event.venue.state) + Text(",")
                Text(event.venue.country)
                    .foregroundColor(.black)
                }
            .frame(maxWidth:.infinity, alignment: .leading)
            Spacer()
        }.navigationBarTitle(Text(event.title), displayMode:.inline)
            .padding()
    }
}

