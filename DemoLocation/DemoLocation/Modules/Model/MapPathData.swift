//
//  MapPath.swift
//  DemoLocation
//
//  Created by shomil on 03/10/22.
//

import Foundation

struct MapPathData {
    
    var lat : Double?
    var lon : Double?
   
    init() {}
    init(lat : Double?,lon : Double?) {
        self.lat = lat
        self.lon = lon
    }
}
