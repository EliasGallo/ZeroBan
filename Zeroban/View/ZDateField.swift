//
//  ZDatePicker.swift
//  Zeroban
//
//  Created by Elias on 2018-04-04.
//  Copyright © 2018 Zero distance. All rights reserved.
//

import UIKit

class ZDateField: UITextField {
    
    private let datePicker = UIDatePicker()
    private let dateFormatter: DateFormatter = ZUtil.Formatter()
    
    var changeValue: ((Date) -> ())?
    
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
        
        // date picker
        datePicker.locale = Locale(identifier: "sv")
        datePicker.datePickerMode = .date
        self.inputView = datePicker

        // done button in date picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed(sender:)))
        toolbar.setItems([doneButton], animated: true)
        self.inputAccessoryView = toolbar
    }
    
    func setValue(value: Date){
        self.text = dateFormatter.string(from: value)
    }
    
    func setDisabledField() {
        self.isEnabled = false
        self.backgroundColor = ZColors.DisabledColor
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        self.text = dateFormatter.string(from: (datePicker.date))
        changeValue?(datePicker.date)
        self.endEditing(true)
    }

    func invalid(isInvalid: Bool) {
        if (isInvalid) {
            self.layer.borderColor = ZColors.InvalidColor.cgColor
        } else {
            self.layer.borderColor = ZColors.FieldBorderColor.cgColor
        }
    }
}
