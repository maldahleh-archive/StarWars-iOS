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
    
    let films: [Film]
    let pilots: [Pilot]
}
