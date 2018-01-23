//
//  Person.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-16.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation

class Person: Model {
    let name: String
    
    let birthYear: String
    let gender: String?
    
    let height: Int?
    let mass: Int?
    
    let hairColour: String?
    let eyeColour: String?
    let skinColour: String
    
    let starshipUrls: [String]
    let vehicleUrls: [String]

    init?(json: JSON) {
        struct Keys {
            static let DoesNotExist = "n/a"
            
            static let Name = "name"
            static let BirthYear = "birth_year"
            static let Gender = "gender"
            static let Height = "height"
            static let Mass = "mass"
            static let HairColour = "hair_color"
            static let EyeColour = "eye_color"
            static let SkinColour = "skin_color"
            static let Starships = "starships"
            static let Vehicles = "vehicles"
        }
        
        if let name = json[Keys.Name] as? String, let birthYear = json[Keys.BirthYear] as? String, let gender = json[Keys.Gender] as? String, let height = json[Keys.Height] as? String, let mass = json[Keys.Mass] as? String, let hairColour = json[Keys.HairColour] as? String, let eyeColour = json[Keys.EyeColour] as? String, let skinColour = json[Keys.SkinColour] as? String, let starshipUrls = json[Keys.Starships] as? [String], let vehicleUrls = json[Keys.Vehicles] as? [String] {
            self.name = name
            self.birthYear = birthYear
            self.gender = gender != Keys.DoesNotExist ? gender : nil
            
            self.height = Int(height)
            self.mass = Int(mass)
            
            self.hairColour = hairColour != Keys.DoesNotExist ? hairColour : nil
            self.eyeColour = eyeColour != Keys.DoesNotExist ? eyeColour : nil
            self.skinColour = skinColour
            
            // TODO: URL searching on vehicles and starships
            self.starshipUrls = starshipUrls
            self.vehicleUrls = vehicleUrls
        } else {
            return nil
        }
    }
    
    func getValue(for field: Int, with unit: Unit) -> String {
        switch field {
        case 0: return birthYear
        case 1: return toString(gender)
        case 2: return length(for: unit)
        case 3: return toString(eyeColour)
        case 4: return toString(hairColour)
        default: return ""
        }
    }
    
    func length(for unit: Unit) -> String {
        let heightVal = toString(height)
        
        if heightVal != "N/A" {
            switch unit {
            case .metric: return String(format: "%.2f", Double(height!) / 100.0) + "m"
            case .imperial: return String(format: "%.2f", Double(height!) / 30.48) + "ft"
            }
        }
        
        return heightVal
    }
    
    class func header() -> String {
        return "Characters"
    }
}
