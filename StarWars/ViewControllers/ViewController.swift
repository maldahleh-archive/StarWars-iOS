//
//  ViewController.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-16.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let provider = DataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DataViewController else {
            return
        }
        
        var modelType: Model.Type!
        if segue.identifier == "showCharacters" {
            modelType = Person.self
        } else if segue.identifier == "showVehicles" {
            modelType = Vehicle.self
        } else {
            modelType = Starship.self
        }
        
        destination.modelType = modelType
        destination.dataProvider = provider
        retrieveDataFor(type: modelType, destination: destination)
    }
    
    // MARK: - Helper
    func retrieveDataFor(type: Model.Type, destination: DataViewController) {
        provider.getData(for: type) { data, error in
            guard let data = data else {
                fatalError(error!.localizedDescription)
            }
            
            DispatchQueue.main.async {
                destination.updateData(with: data)
            }
        }
    }
}
