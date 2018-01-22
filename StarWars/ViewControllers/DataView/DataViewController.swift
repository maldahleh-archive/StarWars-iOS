//
//  DataViewController.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-17.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UIPickerViewDelegate {
    @IBOutlet var descriptionLabels: [UILabel]!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    @IBOutlet weak var trailingDivider: UIView!
    
    var modelType: Model.Type!
    let dataSource = DataViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = dataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateLabels(for: modelType)
    }
    
    // MARK: - UI
    func updateFacts() {
        if modelType is Vehicle.Type || modelType is Starship.Type {
            let data = dataSource.downloadedData as! [Transport]
            let smallest = data.filter({ $0.length != nil }).sorted(by: { $0.length! < $1.length! }).first?.name
            let largest = data.filter({ $0.length != nil }).sorted(by: { $0.length! > $1.length! }).first?.name
            
            if let smallest = smallest {
                smallestLabel.text = smallest
            } else {
                smallestLabel.text = ""
            }
            
            if let largest = largest {
                largestLabel.text = largest
            } else {
                largestLabel.text = ""
            }
        }
    }

    // MARK: - Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource.downloadedData[row].name
    }
    
    // MARK: - Helper
    func updateData(with models: [Model]) {
        dataSource.downloadedData = models
        pickerView.reloadAllComponents()
        
        updateFacts()
    }
    
    func updateLabels(for model: Model.Type) {
        if model is Vehicle.Type || model is Starship.Type {
            for label in descriptionLabels {
                let mapping = TransportMapping(rawValue: label.tag)
                
                if let mapping = mapping {
                    label.text = mapping.description
                } else {
                    label.isHidden = true
                }
            }
            
            trailingDivider.isHidden = true
        } else if model is Person.Type {
            for label in descriptionLabels {
                let mapping = CharacterMapping(rawValue: label.tag)
                
                if let mapping = mapping {
                    label.text = mapping.description
                } else {
                    label.isHidden = true
                }
            }
        }
    }
}
