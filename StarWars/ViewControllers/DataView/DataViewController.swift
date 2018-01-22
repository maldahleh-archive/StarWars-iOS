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

    // MARK: - Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource.downloadedData[row].name
    }
    
    // MARK: - Helper
    func updateData(with models: [Model]) {
        dataSource.downloadedData = models
        pickerView.reloadAllComponents()
    }
    
    func updateLabels(for model: Model.Type) {
        if model is Vehicle.Type {
            for label in descriptionLabels {
                let mapping = VehicleMapping(rawValue: label.tag)
                
                if let mapping = mapping {
                    label.text = mapping.description
                } else {
                    label.isHidden = true
                }
            }
        }
    }
}
