//
//  ZTableViewCell.swift
//  Zeroban
//
//  Created by Elias on 2018-04-04.
//  Copyright © 2018 Zero distance. All rights reserved.
//

import UIKit

class ZTableViewCell: UITableViewCell {
    
    let stackView: UIStackView = ZStackView()
    var fieldsDisabled = false
    var entity: ReportRow?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentView.addSubview(stackView)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(stackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = self.contentView.frame
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        if let data = entity?.getEntityValues() {
            let subViews = stackView.arrangedSubviews
            subViews.forEach({ $0.removeFromSuperview() })
            data.forEach({
                if let dateValue = $0.value.get as? Date {
                    let dateField:ZDateField = ZDateField()
                    dateField.setValue(value: dateValue)
                    if self.fieldsDisabled {
                        dateField.changeValue = fieldChanged(set: $0.value.set)
                    } else {
                        dateField.setDisabledField()
                    }
                    
                    dateField.invalid(isInvalid: $0.invalid)
                    self.stackView.addArrangedSubview(dateField)
                    
                } else if let intValue = $0.value.get as? Int {
                    let numberField = ZNumberField()
                    numberField.text = String(intValue)
                    if self.fieldsDisabled {
                        numberField.changeValue = fieldChanged(set: $0.value.set)
                    } else {
                        numberField.setDisabledField()
                    }
                    numberField.invalid(isInvalid: $0.invalid)
                    stackView.addArrangedSubview(numberField)
                }
            })
            
            entity?.extraSections.forEach({ value in
                let totalField = ZNumberField()
                totalField.text = String(describing: value)
                totalField.setDisabledField()
                stackView.addArrangedSubview(totalField)
            })
        }
    }
    
    func fieldChanged(set:@escaping (Date) -> ()) -> ((Date) -> ()) {
        return { newValue in
            set(newValue)
        }
    }
    
    func fieldChanged(set:@escaping (Int) -> ()) -> ((Int) -> ()) {
        return { newValue in
            set(newValue)
            // assuming total is the last subview
            (self.stackView.arrangedSubviews.last as! ZNumberField).text = String(describing: self.entity?.extraSections.last)
        }
    }
}
