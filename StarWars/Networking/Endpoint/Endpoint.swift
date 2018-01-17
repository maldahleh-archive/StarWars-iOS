//
//  Endpoint.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-17.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var url: URL { get }
    var request: URLRequest { get }
}

extension Endpoint {
    var baseUrl: String {
        return "https://swapi.co/api/"
    }
}
