//
//  DataProvider.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-17.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation

typealias DataCompletionHandler = ([Model]?, JSONError?) -> Void

class DataProvider {
    let client = SWAPIClient()
    
    private var people: [Person] = []
    private var vehicles: [Vehicle] = []
    private var starship: [Starship] = []
    
    func getData(for model: Model, completion: @escaping DataCompletionHandler) {
        if model is Person {
            if !people.isEmpty {
                completion(people, nil)
                return
            }
            
            // TODO: Not downloaded, attempt to download from API
        }
        
        if model is Vehicle {
            if !vehicles.isEmpty {
                completion(vehicles, nil)
                return
            }
            
            // TODO: Not downloaded, attempt to download from API
        }
        
        if model is Starship {
            if !starship.isEmpty {
                completion(starship, nil)
                return
            }
            
            // TODO: Not downloaded, attempt to download from API
        }
    }
}
