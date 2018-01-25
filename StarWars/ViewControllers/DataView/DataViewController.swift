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
    
    var dataProvider: DataProvider!
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
    @IBAction func currencyValueChanged(_ sender: UISegmentedControl) {
        let dataLabel = label(for: 1)
        let dataValue = selectedModel.getValue(for: 1, with: selectedUnit())
        
        if dataValue != "N/A" {
            switch sender.selectedSegmentIndex {
            case 0:
                CreditController.getCreditConversion(for: self) { rate in
                    guard let rate = rate else {
                        sender.selectedSegmentIndex = 1
                        return
                    }
                
                    dataLabel.text = "\(Double(dataValue)! * rate)"
                }
            case 1: dataLabel.text = dataValue
            default: return
            }
        }
    }
    
    @IBAction func unitValueChanged(_ sender: UISegmentedControl) {
        let dataLabel = label(for: 2)
        
        switch sender.selectedSegmentIndex {
        case 0: dataLabel.text = selectedModel.length(for: .imperial)
        case 1: dataLabel.text = selectedModel.length(for: .metric)
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
}

// MARK: - Picker View Delegate
extension DataViewController {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource.downloadedData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateDataLabels(for: row)
    }
}

// MARK: - UI Helpers
extension DataViewController {
    func updateData(with models: [Model]) {
        dataSource.downloadedData = models
        pickerView.reloadAllComponents()
        
        updateFacts()
        updateDataLabels(for: 0)
    }
    
    func updateDataLabels(for index: Int) {
        currencySelector.selectedSegmentIndex = 1
        
        if !dataSource.downloadedData.isEmpty {
            let model = dataSource.downloadedData[index]
            
            for label in dataLabels {
                label.text = model.getValue(for: label.tag, with: selectedUnit())
            }
            
            selectedModel = model
        }
        
        if modelType is Person.Type {
            updateSecondaryLabels(forModel: Vehicle.self, withLabel: 5)
            updateSecondaryLabels(forModel: Starship.self, withLabel: 6)
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
            
            currencySelector.isHidden = false
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
            
            currencySelector.isHidden = true
            trailingDivider.isHidden = false
        }
    }
    
    func updateSecondaryLabels(forModel model: Model.Type, withLabel tag: Int) {
        dataProvider.getData(for: model) { data, error in
            guard let data = data else { fatalError("Data failed, \(error!.localizedDescription)") }
            
            DispatchQueue.main.async {
                let downloadedData = data as! [Transport]
                let selected = self.selectedModel as! Person
                
                var builtString = ""
                if model is Vehicle.Type {
                    for transport in downloadedData {
                        if selected.vehicleUrls.contains(transport.url!) {
                            builtString += "\(transport.name), "
                        }
                    }
                } else if model is Starship.Type {
                    for transport in downloadedData {
                        if selected.starshipUrls.contains(transport.url!) {
                            builtString += "\(transport.name), "
                        }
                    }
                }
                
                self.label(for: tag).text = String(builtString.dropLast(2))
            }
        }
    }
}

// MARK: - Helper
extension DataViewController {
    func selectedUnit() -> Unit {
        switch unitSelector.selectedSegmentIndex {
        case 0: return .imperial
        case 1: return .metric
        default: return .metric
        }
    }
    
    func label(for tag: Int) -> UILabel {
        var dataLabel: UILabel!
        for label in dataLabels {
            if label.tag == tag {
                dataLabel = label
            }
        }
        
        return dataLabel
    }
}
