//
//  Vehicle.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-16.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

class Vehicle: Transport {
    override init?(json: JSON) {
        struct Keys {
            static let VehicleClass = "vehicle_class"
        }
        
        if let vehicleClass = json[Keys.VehicleClass] as? String {
            super.init(json: json)
            self.transportClass = vehicleClass
        } else {
            return nil
        }
    }
    
    override class func header() -> String {
        return "Vehicles"
    }
}
