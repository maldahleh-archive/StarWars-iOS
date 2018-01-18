//
//  Transport.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-17.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

class Transport: Model {
    let name: String
    let model: String
    var transportClass: String? = nil
    let length: Int?
    let crew: Int?
    
    let creditCost: Int?
    
    let pilotsUrls: [String]
    
    init?(json: JSON) {
        struct Keys {
            static let Name = "name"
            static let Model = "model"
            static let Length = "length"
            static let CreditsCost = "cost_in_credits"
            static let Crew = "crew"
            static let Pilots = "pilots"
        }
        
        if let name = json[Keys.Name] as? String, let model = json[Keys.Model] as? String, let length = json[Keys.Length] as? String, let crew = json[Keys.Crew] as? String, let creditCost = json[Keys.CreditsCost] as? String, let pilots = json[Keys.Pilots] as? [String] {
            self.name = name
            self.model = model
            
            self.length = Int(length)
            
            self.crew = Int(crew)
            
            self.creditCost = Int(creditCost)
            
            // TODO: Handle Pilot URLs
            self.pilotsUrls = pilots
        } else {
            return nil
        }
    }
}
