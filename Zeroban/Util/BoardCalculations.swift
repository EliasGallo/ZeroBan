//
//  BoardCalculations.swift
//  Zeroban
//
//  Created by Elias on 2018-05-25.
//  Copyright © 2018 Zero distance. All rights reserved.
//

import Foundation

struct BoardCalculations {

    static func getWip() -> (_ entity: ReportRow) -> Int {
        return { entity in
            return Int(entity.in_progress)
        }
    }

    static func getPSAck() -> (_ entity: ReportRow) -> Int {
        return { entity in
            return Int(entity.in_progress + entity.done)
        }
    }
    
    static func getTotal() -> (_ entity: ReportRow) -> Int {
        return { entity in
            return Int(entity.todo + entity.in_progress + entity.done)
        }
    }
}

