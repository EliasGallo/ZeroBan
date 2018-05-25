//
//  ReportRow+CoreDataProperties.swift
//  Zeroban
//
//  Created by Elias on 2018-05-25.
//  Copyright © 2018 Zero distance. All rights reserved.
//
//

import Foundation
import CoreData


extension ReportRow {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReportRow> {
        let fetchRequest:NSFetchRequest = NSFetchRequest<ReportRow>(entityName: "ReportRow")
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "createdAt", ascending: true)]
        return fetchRequest
    }

    @NSManaged public var createdAt: NSDate?
    @NSManaged public var date: NSDate?
    @NSManaged public var done: Int32
    @NSManaged public var in_progress: Int32
    @NSManaged public var todo: Int32

}
