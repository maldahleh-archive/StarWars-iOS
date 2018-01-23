//
//  DataViewController.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-17.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UIPickerViewDelegate {
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet var descriptionLabels: [UILabel]!
    @IBOutlet var dataLabels: [UILabel]!
    
    @IBOutlet weak var currencySelector: UISegmentedControl!
    @IBOutlet weak var unitSelector: UISegmentedControl!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    @IBOutlet weak var trailingDivider: UIView!
    
    var modelType: Model.Type!
    var selectedModel: Model!
    
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
    
    // MARK: - Actions
    @IBAction func unitValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: dataLabels[2].text = selectedModel.length(for: .imperial)
        case 1: dataLabels[2].text = selectedModel.length(for: .metric)
        default: return
        }
    }
    
    // MARK: - UI
    func updateFacts() {
        if modelType is Vehicle.Type || modelType is Starship.Type {
            let data = dataSource.downloadedData as! [Transport]
            let smallest = data.filter({ $0.length != nil }).sorted(by: { $0.length! < $1.length! }).first?.name
            let largest = data.filter({ $0.length != nil }).sorted(by: { $0.length! > $1.length! }).first?.name
            
            updateFactsWith(smallest: smallest, largest: largest)
        } else {
            let data = dataSource.downloadedData as! [Person]
            let smallest = data.filter({ $0.height != nil }).sorted(by: { $0.height! < $1.height! }).first?.name
            let largest = data.filter({ $0.height != nil }).sorted(by: { $0.height! > $1.height! }).first?.name
            
            updateFactsWith(smallest: smallest, largest: largest)
        }
    }
    
    func updateFactsWith(smallest: String?, largest: String?) {
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

    // MARK: - Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource.downloadedData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateDataLabels(for: row)
    }
    
    // MARK: - Helper
    func selectedUnit() -> Unit {
        switch unitSelector.selectedSegmentIndex {
        case 0: return .imperial
        case 1: return .metric
        default: return .metric
        }
    }
    
    func updateData(with models: [Model]) {
        dataSource.downloadedData = models
        pickerView.reloadAllComponents()
        
        updateFacts()
        updateDataLabels(for: 0)
    }
    
    func updateDataLabels(for index: Int) {
        if !dataSource.downloadedData.isEmpty {
            let model = dataSource.downloadedData[index]
            
            for label in dataLabels {
                label.text = model.getValue(for: label.tag, with: selectedUnit())
            }
            
            selectedModel = model
        }
    }
    
    func updateLabels(for model: Model.Type) {
        headerLabel.text = model.header()
        
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
