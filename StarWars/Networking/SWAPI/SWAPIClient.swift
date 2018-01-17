//
//  SWAPIClient.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-17.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation

class SWAPIClient {
    struct PagedResult {
        let totalObjects: Int
        let jsonResults: Results
    }
    
    let downloader = JSONDownloader()
    
    typealias PageCompletionHandler = (PagedResult?, JSONError?) -> Void
    typealias Results = [JSON]
    
    func downloadData(for endpoint: SWAPIPaged, completion: @escaping PageCompletionHandler) {
        struct Keys {
            static let Count = "count"
            static let Results = "results"
        }
        
        let task = downloader.jsonTask(with: endpoint.request) { json, error in
            guard let json = json else {
                completion(nil, error!)
                return
            }
            
            guard let total = json[Keys.Count] as? Int else {
                completion(nil, .jsonParsingFailure(message: "Count property not found."))
                return
            }
            
            guard let results = json[Keys.Results] as? Results else {
                completion(nil, .jsonParsingFailure(message: "Results property not found"))
                return
            }
            
            let result = PagedResult(totalObjects: total, jsonResults: results)
            completion(result, nil)
        }
        
        task.resume()
    }
}
