//
//  TripDetailModel.swift
//  DemoLocation
//
//  Created by shomil on 03/10/22.
//

import Foundation

struct TripDetailData {

    var startDate: String
    var endDate: String
    var distance: Double
    var startLat: Double
    var startLong : Double
    var endLat : Double
    var endLong: Double

    init(entry: TripDetails) {
        startDate = entry.startDate ?? "abc"
        endDate = entry.endDate ?? "abc"
        distance = entry.distance ?? 0.0
        startLat = entry.startLat ?? 0.0
        startLong = entry.startLong ?? 0.0
        endLat = entry.endLat ?? 0.0
        endLong = entry.endLong ?? 0.0
    }
}
