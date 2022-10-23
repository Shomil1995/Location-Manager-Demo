//
//  TripDetails+CoreDataProperties.swift
//  
//
//  Created by shomil on 03/10/22.
//
//

import Foundation
import CoreData


extension TripDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripDetails> {
        return NSFetchRequest<TripDetails>(entityName: "TripDetails")
    }

    @NSManaged public var distance: Double
    @NSManaged public var endDate: String?
    @NSManaged public var endLat: Double
    @NSManaged public var endLong: Double
    @NSManaged public var startDate: String?
    @NSManaged public var startLat: Double
    @NSManaged public var startLong: Double

}
