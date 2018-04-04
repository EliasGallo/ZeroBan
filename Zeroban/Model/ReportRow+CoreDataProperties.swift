//
//  ReportRow+CoreDataProperties.swift
//  Zeroban
//
//  Created by Elias on 2018-04-04.
//  Copyright © 2018 Zero distance. All rights reserved.
//
//

import Foundation
import CoreData


extension ReportRow {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReportRow> {
        return NSFetchRequest<ReportRow>(entityName: "ReportRow")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var done: Int32
    @NSManaged public var in_progress: Int32
    @NSManaged public var todo: Int32

}
