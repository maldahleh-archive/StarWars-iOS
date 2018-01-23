//
//  Model.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-17.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

protocol Model: class {
    var name: String { get }
    
    static func header() -> String
    
    func getValue(for field: Int, with unit: Unit) -> String
    func length(for unit: Unit) -> String
    func toString(_ value: Any?) -> String
}

extension Model {
    func toString(_ value: Any?) -> String {
        if let value = value {
            return String(describing: value)
        } else {
            return "N/A"
        }
    }
}
