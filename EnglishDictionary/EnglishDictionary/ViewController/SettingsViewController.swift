//
//  AppSettingsViewController.swift
//  EnglishDictionary
//
//  Created by CANSU ARAR on 3.12.2024.
//

import UIKit

protocol SettingsControllerColorDelegate: AnyObject {
    func applyColor(color: UIColor)
}

final class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
        
    @IBOutlet private weak var colorPickerView: UIPickerView!
    weak var colorDelegate: SettingsControllerColorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Colors.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Colors.allCases[row].rawValue
    }
    
    @IBAction private func changeButtonPressed(_ sender: Any) {
        let selectedColorIndex = colorPickerView.selectedRow(inComponent: 0)
        let selectedColor = Colors.allCases[selectedColorIndex]
        let color = selectedColor.uiColor
        colorDelegate?.applyColor(color: color)
        navigationController?.popViewController(animated: true)
    }
    
}

