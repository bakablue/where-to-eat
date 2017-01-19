//
//  ViewController.swift
//  WhereToEat
//
//  Created by Mélanie Godard on 01/12/2016.
//  Copyright © 2016 Wellcut. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet var stylePicker: UIPickerView!
    @IBOutlet weak var style: UITextField!
    @IBOutlet weak var grade: UISlider!
    @IBOutlet weak var gradeDisplayed: UILabel!
    @IBOutlet weak var lastVisit: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var mediumPrice: UITextField!
    @IBOutlet weak var visitedOptions: UIStackView!
    @IBOutlet weak var visited: UISwitch!
    
    var addressFromLocation : String?
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
    enum FormError: Error {
        case EmptyValues(textField : UITextField)
        case NotEnoughtCharacters(nbCharacters : Int, textField : UITextField)
        case ForbiddenValue(value: String, textField: UITextField)
    }
    
    let pickerData = ["test", "test2"]
    
    var directory : Directory = Directory.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylePicker.dataSource = self
        stylePicker.delegate = self
        style.inputView = stylePicker
        lastVisit.inputView = datePicker
        grade.maximumValue = 10.0
        grade.minimumValue = 0.0
        gradeDisplayed.text = String(grade.value)
        visitedOptions.isHidden = true
        visited.isOn = false
        if (addressFromLocation != nil) {
            address.text = addressFromLocation!
        }
        //stylePicker.
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func visitedValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            visitedOptions.isHidden = false
        } else {
            visitedOptions.isHidden = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(false)
    }
    
    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
        lastVisit.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func addRestaurant(_ sender: UIBarButtonItem) {
        do {
            let resto = try restaurantFromForm()
            directory.add(restaurant: resto!)
            self.navigationController?.popViewController(animated: true)
        } catch FormError.EmptyValues(let textField) {
            print("Empty values")
            textField.backgroundColor = UIColor.red
        } catch FormError.NotEnoughtCharacters (let nbCharacters, let textField) {
            print("Not enough characters: \(nbCharacters)")
            textField.backgroundColor = UIColor.red
        } catch FormError.ForbiddenValue (let value, let textField) {
            print("Bad value: \(value)")
            textField.backgroundColor = UIColor.red
        } catch {
            print("Undefined Errors")
        }
    }
    private func restaurantFromForm() throws -> Resto? {
    guard let nameText = name.text else {
        throw FormError.EmptyValues(textField: name)
    }
    
    guard nameText.characters.count >= 2 else {
        throw FormError.NotEnoughtCharacters(nbCharacters: nameText.characters.count, textField: name)
    }
    guard let addressText = address.text else {
        throw FormError.EmptyValues(textField: address)
    }
    guard addressText.characters.count >= 2 else {
            throw FormError.NotEnoughtCharacters(nbCharacters: nameText.characters.count, textField: address)
            
    }
    guard let styleText = style.text else {
        throw FormError.EmptyValues(textField: style)
    }
    guard styleText.characters.count >= 2 else {
        throw FormError.NotEnoughtCharacters(nbCharacters: nameText.characters.count, textField: address)
            
    }
        guard let styleResult = Resto.Style(rawValue: styleText) else {
            throw FormError.ForbiddenValue(value: styleText, textField: style)
        }
        var resto = Resto(name: nameText, address: addressText, style: styleResult)
        
        if visited.isOn {
            let mediumPriceValue = mediumPrice.text
            let lastVisitValue = lastVisit.text
            
            if (mediumPriceValue != nil) {
                if let mediumPriceFloat = UInt(mediumPriceValue!) {
                    resto.mediumPrice = mediumPriceFloat
                }
            }
            
            if (lastVisitValue != nil) {
                if let lastVisitDate = dateFormatter.date(from: lastVisitValue!) {
                    resto.lastVisit = lastVisitDate
                }
            }
            resto.note = UInt(grade.value)
            
        }
        return resto
    }

    @IBAction func onValueChanged(_ sender: UISlider) {
        let value = sender.value
        let valueInteger = Int(value)
        sender.value = Float(valueInteger)
        gradeDisplayed.text = String(valueInteger)
    }

}

