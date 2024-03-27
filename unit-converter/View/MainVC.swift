//
//  ViewController.swift
//  unit-converter
//
//  Created by Amir Sarsenov on 27/03/2024.
//

import UIKit

class MainVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var valueBTxt: UITextField!
    @IBOutlet weak var unitABtn: UIButton!
    @IBOutlet weak var unitBBtn: UIButton!
    @IBOutlet weak var valueATxt: UITextField!
    
    var isMilesToKilometers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueATxt.delegate = self
        valueBTxt.delegate = self
        
        valueATxt.addTarget(self, action: #selector(valueATxtDidChange(_:)), for: .editingChanged)
        valueBTxt.addTarget(self, action: #selector(valueBTxtDidChange(_:)), for: .editingChanged)
        
        unitABtn.setTitle("Miles", for: .normal)
        unitBBtn.setTitle("Kilometers", for: .normal)
    }
    
    @objc func valueATxtDidChange(_ textField: UITextField) {
        if let valueText = textField.text, let value = Double(valueText) {
            let convertedValue = isMilesToKilometers ? value * 1.60934 : value / 1.60934
            valueBTxt.text = String(format: "%.2f", convertedValue)
        } else {
            valueBTxt.text = ""
        }
    }
    
    @objc func valueBTxtDidChange(_ textField: UITextField) {
        if let valueText = textField.text, let value = Double(valueText) {
            let convertedValue = isMilesToKilometers ? value / 1.60934 : value * 1.60934
            valueATxt.text = String(format: "%.2f", convertedValue)
        } else {
            valueATxt.text = ""
        }
    }

    @IBAction func onUnitATapped(_ sender: Any) {
        swapUnits()
    }
    
    @IBAction func onUnitBTapped(_ sender: Any) {
        swapUnits()
    }

    private func swapUnits() {
        isMilesToKilometers.toggle()

        let unitATitle = unitABtn.title(for: .normal)
        unitABtn.setTitle(unitBBtn.title(for: .normal), for: .normal)
        unitBBtn.setTitle(unitATitle, for: .normal)

        if let valueAText = valueATxt.text, let _ = Double(valueAText) {
            valueATxtDidChange(valueATxt)
        } else if let valueBText = valueBTxt.text, let _ = Double(valueBText) {
            valueBTxtDidChange(valueBTxt)
        }
    }
}

