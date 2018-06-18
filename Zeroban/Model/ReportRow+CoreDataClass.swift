//
//  ReportRow+CoreDataClass.swift
//  Zeroban
//
//  Created by Elias on 2018-04-04.
//  Copyright © 2018 Zero distance. All rights reserved.
//
//

import Foundation
import CoreData

public class ReportRow: NSManagedObject {
    var extraSections: Array<Any> = []
    var invalidSections: Array<String> = []

    func getEntityValues() -> [(key: String, value: (get: Any, set:(Any) -> ()), invalid: Bool)] {
        return [
            ("Date", getSetDate(), hasInvalidDate()),
            ("Todo", getSetTodo(), false),
            ("In Progress", getSetInProgress(), false),
            ("Done", getSetDone(), hasInvalidDone())
        ]
    }
    
    func getSetTodo() -> (get: Any, set:(Any) -> ()) {
        return (
            get: Int(self.todo),
            set: { value in
                self.todo = Int32(value as! Int)
            }
        )
    }
    
    func getSetDate() -> (get: Any, set:(Any) -> ()) {
        return (
            get: self.date!,
            set: { value in
                self.date = value as? NSDate
            }
        )
    }
    
    func getSetInProgress() -> (get: Any, set:(Any) -> ()) {
        return (
            get: Int(self.in_progress),
            set: { value in
                self.in_progress = Int32(value as! Int)
            }
        )
    }
    
    func getSetDone() -> (get: Any, set:(Any) -> ()) {
        return (
            get: Int(self.done),
            set: { value in
                self.done = Int32(value as! Int)
            }
        )
    }
    
    func setInvalidDate(isInvalid: Bool) {
        hasInvalid(section: "date", isInvalid: isInvalid)
    }
    
    func hasInvalidDate() -> Bool {
        return invalidSections.contains("date")
    }
    
    func setInvalidDone(isInvalid: Bool) {
        hasInvalid(section: "done", isInvalid: isInvalid)
    }
    
    func hasInvalidDone() -> Bool {
        return invalidSections.contains("done")
    }
    
    private func hasInvalid(section: String, isInvalid: Bool) {
        if(isInvalid) {
            invalidSections.append(section)
        } else {
            invalidSections = invalidSections.filter({ $0 != section })
        }
    }
}
