//
//  CreditController.swift
//  StarWars
//
//  Created by Mohammed Al-Dahleh on 2018-01-23.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation
import UIKit

typealias IntCompletionHandler = (Int?) -> Void

class CreditController {
    static var CreditConversion: Int?
    
    static func getCreditConversion(for controller: UIViewController, completion: @escaping IntCompletionHandler) {
        if let creditConversion = CreditConversion {
            completion(creditConversion)
        } else {
            displayConversionBox(for: controller) { result in
                completion(result)
            }
        }
    }
    
    private static func displayConversionBox(for controller: UIViewController, completion: @escaping IntCompletionHandler) {
        let alertController = UIAlertController(title: "Credit Conversion", message: "Enter an integer conversion value:", preferredStyle: .alert)
        
        let setAction = UIAlertAction(title: "Set", style: .default, handler: {
            alert -> Void in
            
            let conversionField = alertController.textFields![0] as UITextField
            let conversionRateWrapped = conversionField.text
            
            guard let conversionRate = conversionRateWrapped else {
                displayWarning(withMessage: "Invalid Input!", forController: controller)
                completion(nil)
                return
            }
            
            guard let conversionInt = Int(conversionRate) else {
                displayWarning(withMessage: "Integer Required!", forController: controller)
                completion(nil)
                return
            }
            
            if conversionInt <= 0 {
                displayWarning(withMessage: "You must enter a positive number!", forController: controller)
                completion(nil)
                return
            }
            
            completion(conversionInt)
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Conversion"
        }
        
        alertController.addAction(setAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    private static func displayWarning(withMessage message: String, forController controller: UIViewController) {
        let alertController = UIAlertController(title: "Credit Conversion", message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        controller.present(alertController, animated: true, completion: nil)
    }
}
