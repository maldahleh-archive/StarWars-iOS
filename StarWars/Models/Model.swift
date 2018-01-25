//
//  Model.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-17.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

protocol Model: class {
    var name: String { get }
    var url: String? { get }
    
    static func header() -> String
    
    func getValue(for field: Int, with unit: Unit) -> String
    func length(for unit: Unit) -> String
    
    // MARK: - Helper
    func format(_ value: Int?, withUnit unit: Unit) -> String
    func toString(_ value: Any?) -> String
}

extension Model {
    func format(_ value: Int?, withUnit unit: Unit) -> String {
        let convertedVal = toString(value)
        
        if convertedVal != "N/A" {
            switch unit {
            case .metric: return String(format: "%.2f", Double(value!) / 100.0) + "m"
            case .imperial: return String(format: "%.2f", Double(value!) / 30.48) + "ft"
            }
        }
        
        return convertedVal
    }
    
    func toString(_ value: Any?) -> String {
        if let value = value {
            return String(describing: value)
        } else {
            return "N/A"
        }
    }
}
