//
//  CoreDataHandler.swift
//  Zeroban
//
//  Created by Elias on 2018-04-04.
//  Copyright © 2018 Zero distance. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {

    private class func getAppDeligate() -> AppDelegate {
        return (UIApplication.shared.delegate as! AppDelegate)
    }
    private class func getAppContext() -> NSManagedObjectContext{
        return getAppDeligate().persistentContainer.viewContext
    }
    
    // Saves all changes
    class func saveContext () -> Bool {
        let context = getAppContext()
        if context.hasChanges {
            do {
                print("saveContext")
                try context.save()
                return true
            } catch {
                print("saveContext fail", error)
                return false
            }
        }
        print("saveContext, nothing changed")
        return true
    }
    
    class func saveReportRowObject(date: Date, todo: Int, inProgress: Int, done: Int) -> Bool {
        let context = getAppContext()
        let entity = NSEntityDescription.entity(forEntityName: "ReportRow", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        managedObject.setValue(date, forKey: "date")
        managedObject.setValue(todo, forKey: "todo")
        managedObject.setValue(inProgress, forKey: "in_progress")
        managedObject.setValue(done, forKey: "done")

        return saveContext()
    }
    
    class func fetchReportRowObject() -> [ReportRow]? {
        do {
            let objects: [ReportRow]? = try getAppContext().fetch(ReportRow.fetchRequest())
            return objects
        } catch {
            return nil
        }
    }
    
    class func getLookupRows() -> [(rfs: Date, leadTime: Int)]? {
        // TODO: do calculations
        // PSAck1 = inprogress1 + done1
        // rfs lookup = date PSAack1 = done2
        if let reportRowObjects = fetchReportRowObject(), reportRowObjects.count > 1 {
            var objects: [(rfs: Date, leadTime: Int)] = []
            (1..<reportRowObjects.count).forEach({ i in
                let object1 = reportRowObjects[i]
                (0..<i).forEach({ k in
                    let object2 = reportRowObjects[k]
                    if(object1 === object2) {
                        print("same obj")
                    }
                    let psack1 = Int(object2.in_progress + object2.done)
                    if (psack1 == Int(object1.done)) {
                        objects.append((rfs: object2.date! as Date, leadTime: getDayDiff(startDate: object1.date! as Date, endDate: object2.date! as Date)))
                    }
                })
            })
            
            /*for object1 in reportRowObjects {
                for object2 in reportRowObjects {
                    if(object1 === object2) {
                        print("same obj")
                        break
                    }
                    let psack1 = Int(object1.in_progress + object1.done)
                    if (psack1 == Int(object2.done)) {
                        objects.append((rfs: object1.date! as Date, leadTime: 2))
                        break
                    }
                }
            }*/
            return objects
        }
        return nil
    }
    
    private class func getDayDiff(startDate: Date, endDate: Date) -> Int {
        print("startDate", startDate)
        print("endDate", endDate)
        return Calendar.current.dateComponents([.day], from: endDate, to: startDate).day!
    }
    
    private class func getByReportRowObjectId(id: NSManagedObjectID) -> ReportRow? {
        return getAppContext().object(with: id) as? ReportRow
    }
    
    class func updateReportRowObject(entity: ReportRow) -> (NSDate, Int, Int, Int) -> Bool {
        return { date, todo, inProgress, done in
            print("a", entity)
            print("todo", todo)
            // Use curry, send this function with entity and then invoke with the value.
            // 1. fetch entity from db with predicate
            if let object = getByReportRowObjectId(id: entity.objectID) {
                // 2. set new values
                object.todo = Int32(todo)
                object.in_progress = Int32(inProgress)
                object.done = Int32(done)
                object.date = date
             }
            // 3. save
            return true
        }
    }
}
