//
//  PlaceModel.swift
//  MyFavoritePlaces
//
//  Created by Александр Старков on 24.03.2022.
//


import UIKit
import RealmSwift
class Place: Object {
    @Persisted var name: String
    @Persisted var location: String?
    @Persisted var type: String?
    @Persisted var imageData: Data?

    convenience init(name: String, location: String?, type: String?, imageData: Data?) {
        self .init() //вызываем инициализатор класса, в котором иниициализируется значения по умолчанию
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
 }
