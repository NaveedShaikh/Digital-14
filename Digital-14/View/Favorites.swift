//
//  Favorites.swift
//  Digital-14
//
//  Created by Naveed Shaikh on 25/09/21.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var theFavs: Set<String>
    let defaults = UserDefaults.standard
    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

//    init() {
//            // load our saved data
//
//            // still here? Use an empty array
//            self.theFavs = []
//        }
    
    init() {
            let decoder = JSONDecoder()
            if let data = defaults.value(forKey: saveKey) as? Data {
                let taskData = try? decoder.decode(Set<String>.self, from: data)
                self.theFavs = taskData ?? []
            } else {
                self.theFavs = []
            }
        }
    

        // returns true if our set contains this resort
        func contains(_ event: Event) -> Bool {
            theFavs.contains(String(event.id))
        }
    
        func add(_ event: Event) {
                objectWillChange.send()
                theFavs.insert(String(event.id))
                save()
        }
    
        func remove(_ event: Event) {
                objectWillChange.send()
                theFavs.remove(String(event.id))
                save()
        }

        func save() {
            let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(theFavs) {
                        defaults.set(encoded, forKey: saveKey)
                    }
            }
    
}
