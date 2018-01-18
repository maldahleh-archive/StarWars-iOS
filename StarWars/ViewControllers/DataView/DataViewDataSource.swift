//
//  DataViewDataSource.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-18.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import UIKit

class DataViewDataSource: NSObject, UIPickerViewDataSource {
    var downloadedData = [Model]()
    
    // MARK: - Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return downloadedData.count
    }
}
