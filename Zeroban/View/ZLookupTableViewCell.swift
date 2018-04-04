//
//  ZTableViewCell.swift
//  Zeroban
//
//  Created by Elias on 2018-04-04.
//  Copyright © 2018 Zero distance. All rights reserved.
//

import UIKit

class ZLookupTableViewCell: UITableViewCell {
    
    let stackView: UIStackView = ZStackView()
    var lookupData: (rfs: Date, leadTime: Int)?
    
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
        
        if stackView.arrangedSubviews.count <= 1, let data = lookupData {
            let subViews = stackView.arrangedSubviews
            subViews.forEach({ $0.removeFromSuperview() })
            // set RfS
            let dateField:ZDateField = ZDateField()
            dateField.setValue(value: data.rfs)
            dateField.setDisabledField()
            self.stackView.addArrangedSubview(dateField)
            // set lead time
            let numberField = ZNumberField()
            numberField.text = String(data.leadTime)
            numberField.setDisabledField()
            stackView.addArrangedSubview(numberField)
        }
    }
}

