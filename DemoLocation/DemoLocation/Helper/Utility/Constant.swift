//
//  Constant.swift
//  DemoLocation
//
//  Created by shomil on 30/09/22.
//

import Foundation
import UIKit

//MARK: - UIColor
extension UIColor {
    class func BlueTheme() -> UIColor { return UIColor(named: "BlueTheme")!}
}

//MARK: - StaticKeys 
struct StaticKeys {
    static let KEYGoogleMaps = "AIzaSyBNcQNaGk5txTUWOrTFX3KgKvpSDzSBx6I"
}

//MARK: - WebServiceParameter
struct WebServiceParameter {
    static let startDate = "startDate"
    static let endDate = "endDate"
    static let distance = "distance"
    static let startLat = "startLat"
    static let startLong = "startLong"
    static let endLat = "endLat"
    static let endLong = "endLong"
}
