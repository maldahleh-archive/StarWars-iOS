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
    private var starships: [Starship] = []
    
    func getData(for model: Model.Type, completion: @escaping DataCompletionHandler) {
        if model is Person.Type && !people.isEmpty {
            completion(people, nil)
            return
        }
        
        if model is Vehicle.Type && !vehicles.isEmpty {
            completion(vehicles, nil)
            return
        }
        
        if model is Starship.Type && !starships.isEmpty {
            completion(starships, nil)
            return
        }
        
        downloadFor(page: 1, withModel: model, onCompletion: completion)
    }
    
    private func downloadFor(page: Int, withModel model: Model.Type, onCompletion completion: @escaping DataCompletionHandler) {
        var endpoint: SWAPIPaged!
        
        if model is Person.Type {
            endpoint = SWAPIPaged.people(page: page)
            
            client.downloadData(for: endpoint) { result, error in
                guard let result = result else {
                    completion(nil, error)
                    return
                }
                
                for jsonResult in result.jsonResults {
                    if let person = Person(json: jsonResult) {
                        self.people.append(person)
                    } else {
                        completion(nil, .invalidData)
                    }
                }
                
                if self.people.count != result.totalObjects {
                    self.downloadFor(page: page + 1, withModel: model, onCompletion: completion)
                } else {
                    completion(self.people, nil)
                }
            }
        } else if model is Vehicle.Type {
            endpoint = SWAPIPaged.vehicles(page: page)
            
            client.downloadData(for: endpoint) { result, error in
                guard let result = result else {
                    completion(nil, error)
                    return
                }
                
                for jsonResult in result.jsonResults {
                    if let vehicle = Vehicle(json: jsonResult) {
                        self.vehicles.append(vehicle)
                    } else {
                        completion(nil, .invalidData)
                    }
                }
                
                if self.vehicles.count != result.totalObjects {
                    self.downloadFor(page: page + 1, withModel: model, onCompletion: completion)
                } else {
                    completion(self.vehicles, nil)
                }
            }
        } else if model is Starship.Type {
            endpoint = SWAPIPaged.starships(page: page)
            
            client.downloadData(for: endpoint) { result, error in
                guard let result = result else {
                    completion(nil, error)
                    return
                }
                
                for jsonResult in result.jsonResults {
                    if let starship = Starship(json: jsonResult) {
                        self.starships.append(starship)
                    } else {
                        completion(nil, .invalidData)
                    }
                }
                
                if self.starships.count != result.totalObjects {
                    self.downloadFor(page: page + 1, withModel: model, onCompletion: completion)
                } else {
                    completion(self.starships, nil)
                }
            }
        }
    }
}
