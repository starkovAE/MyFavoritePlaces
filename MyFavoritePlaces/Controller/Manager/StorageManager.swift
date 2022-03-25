//
//  StorageManager.swift
//  MyFavoritePlaces
//
//  Created by Александр Старков on 25.03.2022.
//

import RealmSwift
import Foundation
let realm = try! Realm()

class StorageManager {
    static func saveObject(_ place: Place) {
        try! realm.write {
            realm.add(place)
        }
        
    }
    static func deleteObject(_ place: Place) {
        try! realm.write {
            realm.delete(place)
        }
    }
}
