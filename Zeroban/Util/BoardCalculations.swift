//
//  BoardCalculations.swift
//  Zeroban
//
//  Created by Elias on 2018-05-25.
//  Copyright © 2018 Zero distance. All rights reserved.
//

import Foundation

struct BoardCalculations {

    static func getWip(entity: ReportRow) -> Int {
        return Int(entity.in_progress)
    }

    static func getPSAck(entity: ReportRow) -> Int {
        return Int(entity.in_progress + entity.done)
    }
    
    static func getTotal(entity: ReportRow) -> Int {
        return Int(entity.todo + entity.in_progress + entity.done)
    }
    
    static func getThroughput(entity: ReportRow, entity2: ReportRow) -> Int {
        return Int(entity.done - entity2.done)
    }
}

