//
//  Colors.swift
//  Zeroban
//
//  Created by Elias on 2018-04-04.
//  Copyright © 2018 Zero distance. All rights reserved.
//

import UIKit

struct ZColors {
    static let ActionColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    static let DisabledColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    static let FieldBorderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let BackgroundColor = #colorLiteral(red: 0, green: 0.5134028792, blue: 0.7684984803, alpha: 1)
}

struct ZUtil {
    static let Formatter = { () -> DateFormatter in
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "sv")
        return dateFormatter
    }
}
