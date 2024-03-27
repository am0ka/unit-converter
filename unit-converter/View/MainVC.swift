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
    
    @IBOutlet weak var valueCTxt: UITextField!
    @IBOutlet weak var valueDTxt: UITextField!
    @IBOutlet weak var unitCBtn: UIButton!
    @IBOutlet weak var unitDBtn: UIButton!

    var isMilesToKilometers = true
    var isPoundsToKilograms = true
    
    let milesToKilometersFactor = 1.60934
    let poundsToKilogramsFactor = 0.453592
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueATxt.delegate = self
        valueBTxt.delegate = self
        valueCTxt.delegate = self
        valueDTxt.delegate = self

        valueATxt.addTarget(self, action: #selector(valueATxtDidChange(_:)), for: .editingChanged)
        valueBTxt.addTarget(self, action: #selector(valueBTxtDidChange(_:)), for: .editingChanged)
        valueCTxt.addTarget(self, action: #selector(valueCTxtDidChange(_:)), for: .editingChanged)
        valueDTxt.addTarget(self, action: #selector(valueDTxtDidChange(_:)), for: .editingChanged)

        unitABtn.setTitle("Miles", for: .normal)
        unitBBtn.setTitle("Kilometers", for: .normal)
        unitCBtn.setTitle("Pounds", for: .normal)
        unitDBtn.setTitle("Kilograms", for: .normal)
    }
    
    @objc func valueATxtDidChange(_ textField: UITextField) {
        if let valueText = textField.text, let value = convertToDecimal(valueText) {
            let convertedValue = isMilesToKilometers ? value * milesToKilometersFactor : value / milesToKilometersFactor
            valueBTxt.text = String(format: "%.4f", convertedValue)
        } else {
            valueBTxt.text = ""
        }
    }
    
    @objc func valueBTxtDidChange(_ textField: UITextField) {
        if let valueText = textField.text, let value = convertToDecimal(valueText) {
            let convertedValue = isMilesToKilometers ? value / milesToKilometersFactor : value * milesToKilometersFactor
            valueATxt.text = String(format: "%.4f", convertedValue)
        } else {
            valueATxt.text = ""
        }
    }
    
    @objc func valueCTxtDidChange(_ textField: UITextField) {
        if let valueText = textField.text, let value = convertToDecimal(valueText) {
            let convertedValue = isPoundsToKilograms ? value * poundsToKilogramsFactor : value / poundsToKilogramsFactor
            valueDTxt.text = String(format: "%.4f", convertedValue)
        } else {
            valueDTxt.text = ""
        }
    }
    
    @objc func valueDTxtDidChange(_ textField: UITextField) {
        if let valueText = textField.text, let value = convertToDecimal(valueText) {
            let convertedValue = isPoundsToKilograms ? value / poundsToKilogramsFactor : value * poundsToKilogramsFactor
            valueCTxt.text = String(format: "%.4f", convertedValue)
        } else {
            valueCTxt.text = ""
        }
    }

    @IBAction func onUnitATapped(_ sender: Any) {
        swapMilesKilometers()
    }
    
    @IBAction func onUnitBTapped(_ sender: Any) {
        swapMilesKilometers()
    }
    
    @IBAction func onUnitCTapped(_ sender: Any) {
        swapPoundsKilograms()
    }
    
    @IBAction func onUnitDTapped(_ sender: Any) {
        swapPoundsKilograms()
    }
    
    private func convertToDecimal(_ string: String) -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let number = numberFormatter.number(from: string) {
            return number.doubleValue
        }
        return nil
    }

    private func swapMilesKilometers() {
        isMilesToKilometers.toggle()

        let unitATitle = unitABtn.title(for: .normal)
        unitABtn.setTitle(unitBBtn.title(for: .normal), for: .normal)
        unitBBtn.setTitle(unitATitle, for: .normal)

        if let valueAText = valueATxt.text, let _ = convertToDecimal(valueAText) {
            valueATxtDidChange(valueATxt)
        } else if let valueBText = valueBTxt.text, let _ = convertToDecimal(valueBText) {
            valueBTxtDidChange(valueBTxt)
        }
    }
    
    private func swapPoundsKilograms() {
        isPoundsToKilograms.toggle()

        let unitCTitle = unitCBtn.title(for: .normal)
        unitCBtn.setTitle(unitDBtn.title(for: .normal), for: .normal)
        unitDBtn.setTitle(unitCTitle, for: .normal)

        if let valueCText = valueCTxt.text, let _ = convertToDecimal(valueCText) {
            valueCTxtDidChange(valueCTxt)
        } else if let valueDText = valueDTxt.text, let _ = convertToDecimal(valueDText) {
            valueDTxtDidChange(valueDTxt)
        }
    }
}

