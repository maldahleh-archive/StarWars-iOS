//
//  Mapping.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-22.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

enum TransportMapping: Int {
    case make = 0
    case cost = 1
    case length = 2
    case vehicleClass = 3
    case crew = 4
}

extension TransportMapping {
    var description: String {
        switch self {
        case .make: return "Make"
        case .cost: return "Cost"
        case .length: return "Length"
        case .vehicleClass: return "Class"
        case .crew: return "Crew"
        }
    }
}
