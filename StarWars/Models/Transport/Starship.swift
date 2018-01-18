//
//  Starship.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-17.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

class Starship: Transport {
    override init?(json: JSON) {
        struct Keys {
            static let StarshipClass = "starship_class"
        }
        
        if let starshipClass = json[Keys.StarshipClass] as? String {
            super.init(json: json)
            self.transportClass = starshipClass
        } else {
            return nil
        }
    }
}
