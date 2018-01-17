//
//  Vehicle.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-16.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation

typealias JSON = [String: AnyObject]

struct Vehicle {
    let name: String
    let model: String
    let vehicleClass: String
    let manufacturer: String
    let consumables: String
    
    let length: Double
    let maxAtmosphericSpeed: Int
    let cargoCapacity: Double
    
    let crew: Int
    let passengers: Int
    
    let creditCost: Int
    
    let filmsUrls: [String]
    let pilotsUrls: [String]
}

extension Vehicle {
    init?(json: JSON) {
        struct Keys {
            static let Name = "name"
            static let Model = "model"
            static let VehicleClass = "vehicle_class"
            static let Manufacturer = "manufacturer"
            static let Length = "length"
            static let CreditsCost = "cost_in_credits"
            static let Crew = "crew"
            static let Passengers = "passengers"
            static let MaxSpeed = "max_atmospheric_speed"
            static let CargoCapacity = "cargo_capacity"
            static let Consumables = "consumables"
            static let Films = "films"
            static let Pilots = "pilots"
        }
        
        if let name = json[Keys.Name] as? String, let model = json[Keys.Model] as? String, let vehicleClass = json[Keys.VehicleClass] as? String, let manufacturer = json[Keys.Manufacturer] as? String, let consumables = json[Keys.Consumables] as? String, let length = json[Keys.Length] as? Double, let maxAtmosphericSpeed = json[Keys.MaxSpeed] as? Int, let cargoCapacity = json[Keys.CargoCapacity] as? Double, let crew = json[Keys.Crew] as? Int, let passengers = json[Keys.Passengers] as? Int, let creditCost = json[Keys.CreditsCost] as? Int, let films = json[Keys.Films] as? [String], let pilots = json[Keys.Pilots] as? [String] {
            self.name = name
            self.model = model
            self.vehicleClass = vehicleClass
            self.manufacturer = manufacturer
            self.consumables = consumables
            
            self.length = length
            self.maxAtmosphericSpeed = maxAtmosphericSpeed
            self.cargoCapacity = cargoCapacity
            
            self.crew = crew
            self.passengers = passengers
            
            self.creditCost = creditCost
            
            // TODO: Handle Film and Pilot URLs
            self.filmsUrls = films
            self.pilotsUrls = pilots
        } else {
            return nil
        }
    }
}
