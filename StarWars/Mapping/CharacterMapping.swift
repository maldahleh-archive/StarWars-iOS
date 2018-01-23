//
//  CharacterMapping.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-22.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

enum CharacterMapping: Int {
    case born = 0
    case home = 1
    case height = 2
    case eyes = 3
    case hair = 4
    case vehicles = 5
    case ships = 6
}

extension CharacterMapping {
    var description: String {
        switch self {
        case .born: return "Born"
        case .home: return "Gender"
        case .height: return "Height"
        case .eyes: return "Eyes"
        case .hair: return "Hair"
        case .vehicles: return "Vehicles"
        case .ships: return "Ships"
        }
    }
}
