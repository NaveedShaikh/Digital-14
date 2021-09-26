//
//  NetworkManager.swift
//  Digital-14
//
//  Created by Naveed Shaikh on 24/09/21.
//


import Alamofire
import Foundation
import Combine

class NetworkManager: ObservableObject {
    @Published var theEvents = Events(events: [])
    @Published var loading = false
    private let api_key = "MjM1MjcyNDJ8MTYzMjQ4MDQ0Ny4yNjAwNTk&q="
    private let api_url_base = "https://api.seatgeek.com/2/events?client_id="
    
    init() {
        loading = true
        //Uncomment the below to load ALL EVENTS.
        //loadAllEvents()
    }
    
    // MARK: LoadAllEvents.
    private func loadAllEvents() {
        Alamofire.request("\(api_url_base)\(api_key)")
            .responseJSON{ response in
                guard let data = response.data else { return }
                let event = try! JSONDecoder().decode(Events.self, from: data)
                DispatchQueue.main.async {
                    self.theEvents = event
                    self.loading = false
                }
        }
    }
    
    // MARK: LoadSearchQuery.
     func loadDataForSearchQuery(searchText:String) {
         Alamofire.request("\(api_url_base)\(api_key)\(searchText)")
            .responseJSON{ response in
                guard let data = response.data else { return }
                let event = try! JSONDecoder().decode(Events.self, from: data)
                DispatchQueue.main.async {
                    self.theEvents = event
                    self.loading = false
                }
        }
    }
    
    // MARK: ReturnImage.
    func returnImageUrl(performaImg: [Performers]) -> String {
        var imgName :String = ""
        performaImg.forEach { item in
                        imgName = item.image
                    }
        return imgName
    }
    
    // MARK: GetDateForEvent.
    func getDateForEvent(createdDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from:createdDate)!
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: date)
    }
}
