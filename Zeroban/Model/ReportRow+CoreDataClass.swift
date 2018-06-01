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
    func getEntityValues() -> [(key: String, value: (get: Any, set:(Any) -> ()))] {
        return [
            ("Date", getSetDate()),
            ("Todo", getSetTodo()),
            ("In Progress", getSetInProgress()),
            ("Done", getSetDone())
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
}
