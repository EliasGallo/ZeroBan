//
//  ZNumberField.swift
//  Zeroban
//
//  Created by Elias on 2018-04-04.
//  Copyright © 2018 Zero distance. All rights reserved.
//

import UIKit

class ZNumberField: UITextField {

    var changeValue: ((Int) -> ())?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textAlignment = .center
        self.backgroundColor = ZColors.ActionColor
        self.layer.cornerRadius = 4.0
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = ZColors.FieldBorderColor.cgColor
        self.keyboardType = .numberPad
        
        // on textfield change
        self.addTarget(self, action: #selector(handleChange(textField:)), for: .editingChanged)
        
        // done button in date picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        self.inputAccessoryView = toolbar
    }
    
    @objc func handleChange(textField: UITextField){
        changeValue?(Int(textField.text!) ?? 0)
    }
    
    func setDisabledField() {
        self.isEnabled = false
        self.backgroundColor = ZColors.DisabledColor
    }
    
    @objc func donePressed() {
        self.endEditing(false)
    }
}
