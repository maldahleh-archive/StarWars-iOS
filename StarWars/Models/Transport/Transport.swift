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
    let manufacturer: String
    let consumables: String
    
    let length: Int?
    let maxAtmosphericSpeed: Int?
    let cargoCapacity: Int?
    
    let crew: Int?
    let passengers: Int?
    
    let creditCost: Int?
    
    let pilotsUrls: [String]
    
    init?(json: JSON) {
        struct Keys {
            static let Name = "name"
            static let Model = "model"
            static let Manufacturer = "manufacturer"
            static let Length = "length"
            static let CreditsCost = "cost_in_credits"
            static let Crew = "crew"
            static let Passengers = "passengers"
            static let MaxSpeed = "max_atmosphering_speed"
            static let CargoCapacity = "cargo_capacity"
            static let Consumables = "consumables"
            static let Pilots = "pilots"
        }
        
        if let name = json[Keys.Name] as? String, let model = json[Keys.Model] as? String, let manufacturer = json[Keys.Manufacturer] as? String, let consumables = json[Keys.Consumables] as? String, let length = json[Keys.Length] as? String, let maxAtmosphericSpeed = json[Keys.MaxSpeed] as? String, let cargoCapacity = json[Keys.CargoCapacity] as? String, let crew = json[Keys.Crew] as? String, let passengers = json[Keys.Passengers] as? String, let creditCost = json[Keys.CreditsCost] as? String, let pilots = json[Keys.Pilots] as? [String] {
            self.name = name
            self.model = model
            self.manufacturer = manufacturer
            self.consumables = consumables
            
            self.length = Int(length)
            self.maxAtmosphericSpeed = Int(maxAtmosphericSpeed)
            self.cargoCapacity = Int(cargoCapacity)
            
            self.crew = Int(crew)
            self.passengers = Int(passengers)
            
            self.creditCost = Int(creditCost)
            
            // TODO: Handle Pilot URLs
            self.pilotsUrls = pilots
        } else {
            return nil
        }
    }
}
