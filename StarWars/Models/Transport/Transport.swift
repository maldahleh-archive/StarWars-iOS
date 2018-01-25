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
    
    let url: String?
    let pilotsUrls: [String]
    
    class func header() -> String {
        return "Transports"
    }
    
    init?(json: JSON) {
        struct Keys {
            static let Name = "name"
            static let Model = "model"
            static let Length = "length"
            static let CreditsCost = "cost_in_credits"
            static let Crew = "crew"
            static let Url = "url"
            static let Pilots = "pilots"
        }
        
        if let name = json[Keys.Name] as? String, let model = json[Keys.Model] as? String, let length = json[Keys.Length] as? String, let crew = json[Keys.Crew] as? String, let creditCost = json[Keys.CreditsCost] as? String, let url = json[Keys.Url] as? String, let pilots = json[Keys.Pilots] as? [String] {
            self.name = name
            self.model = model
            
            self.length = Int(length)
            
            self.crew = Int(crew)
            
            self.creditCost = Int(creditCost)
            
            self.url = url
            self.pilotsUrls = pilots
        } else {
            return nil
        }
    }
}

// MARK: - Protocol implementation
extension Transport {
    func getValue(for field: Int, with unit: Unit) -> String {
        switch field {
        case 0: return model
        case 1: return toString(creditCost)
        case 2: return length(for: unit)
        case 3: return toString(transportClass)
        case 4: return toString(crew)
        default: return ""
        }
    }
    
    func length(for unit: Unit) -> String {
        return format(length, withUnit: unit)
    }
}
