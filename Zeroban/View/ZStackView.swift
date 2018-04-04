//
//  ZStackView.swift
//  Zeroban
//
//  Created by Elias on 2018-04-04.
//  Copyright © 2018 Zero distance. All rights reserved.
//

import UIKit

class ZStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializationUi()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initializationUi()
    }
    
    private func initializationUi() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .fill
        self.contentMode = .scaleToFill
        self.layoutMargins = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
        self.isLayoutMarginsRelativeArrangement = true
    }
    
}
