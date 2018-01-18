//
//  DataViewController.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-17.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UIPickerViewDelegate {
    @IBOutlet weak var pickerView: UIPickerView!
    
    let dataSource = DataViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = dataSource
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
}
