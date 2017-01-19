//
//  ViewControllerExtension.swift
//  WhereToEat
//
//  Created by Mélanie Godard on 14/12/2016.
//  Copyright © 2016 Wellcut. All rights reserved.
//

import UIKit

extension ViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        style.text = Resto.Style.allStyles[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Resto.Style.allStyles[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Resto.Style.allStyles.count
    }
}
