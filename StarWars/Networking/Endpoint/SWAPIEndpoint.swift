//
//  SWAPIEndpoint.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-17.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation

enum SWAPIPaged: Endpoint {
    case people(page: Int)
    case vehicles(page: Int)
    case starships(page: Int)
}

extension SWAPIPaged {
    private struct Keys {
        static let vehicles = "vehicles"
        static let starships = "starships"
        static let people = "people"
    }
    
    var url: URL {
        switch self {
        case .people(let page): return URL(string: "\(baseUrl)\(Keys.people)/?page=\(page)")!
        case .vehicles(let page): return URL(string: "\(baseUrl)\(Keys.vehicles)/?page=\(page)")!
        case .starships(let page): return URL(string: "\(baseUrl)\(Keys.starships)/?page=\(page)")!
        }
    }
    
    var request: URLRequest {
        return URLRequest(url: url)
    }
}
