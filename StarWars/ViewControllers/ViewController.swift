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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacters" {
            let destination = segue.destination as! DataViewController
            
            provider.getData(for: Person.self) { data, error in
                guard let data = data else {
                    // TODO: Handle error
                    return
                }
                
                DispatchQueue.main.async {
                    print(data)
                    destination.updateData(with: data)
                }
            }
        }
    }
}
