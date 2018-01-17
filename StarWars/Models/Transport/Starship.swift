//
//  Starship.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-17.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

class Starship: Transport {
    let hyperdriveRating: String
    let mglt: String
    
    override init?(json: JSON) {
        struct Keys {
            static let StarshipClass = "starship_class"
            static let HyperdriveRating = "hyperdrive_rating"
            static let MGLT = "MGLT"
        }
        
        if let starshipClass = json[Keys.StarshipClass] as? String, let hyperdriveRating = json[Keys.HyperdriveRating] as? String, let mglt = json[Keys.MGLT] as? String {
            self.hyperdriveRating = hyperdriveRating
            self.mglt = mglt
            
            super.init(json: json)
            self.transportClass = starshipClass
        } else {
            return nil
        }
    }
}
