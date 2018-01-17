//
//  JSONError.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-17.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

enum JSONError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
}
