//
//  GeekAPI.swift
//  Digital-14
//
//  Created by Naveed Shaikh on 24/09/21.
//

import Foundation


// MARK: BaseEventModel.

struct Event: Codable, Identifiable {
    let title: String
    let created_at: String
    let venue : Venue
    var performers: [Performers]
    var id: Int
}

struct Performers: Codable {
    var name : String
    var image: String
}

struct Venue: Codable {
    let state: String
    let country: String
}





