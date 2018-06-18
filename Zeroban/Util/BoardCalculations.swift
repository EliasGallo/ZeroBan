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
    
    static func getRfsLookup(entity: ReportRow, olderEntities: [ReportRow]) -> Date? {
        // PSAck1 = inprogress1 + done1
        // rfs lookup = date PSAack1 = done2
        for object in olderEntities {
            let psack1 = object.in_progress + object.done
            if psack1 == entity.done {
                return object.date! as Date
            }
        }
        return nil
    }
    
    static func validateData(entities: [ReportRow]) {
        for i in 1..<entities.count {
            let o = entities[i]
            let prevO = entities[i - 1]
            o.setInvalidDate(isInvalid: Calendar.current.compare(prevO.date! as Date, to: o.date! as Date, toGranularity: .day) != .orderedAscending)
            o.setInvalidDone(isInvalid: prevO.done > o.done)
        }
    }
}

