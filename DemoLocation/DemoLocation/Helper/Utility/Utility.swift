//
//  Utility.swift
//  DemoLocation
//
//  Created by shomil on 30/09/22.
//

import Foundation

//MARK: - DispatchQueue
func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

//MARK: - Maint Thread
func mainThread(_ completion: @escaping () -> ()) {
    DispatchQueue.main.async {
        completion()
    }
}

//MARK: - Current Date
func currentDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:Z"
    dateFormatter.timeZone = .current
    var currentDate = dateFormatter.string(from:date)
    return currentDate
}

//MARK: - Change Date Format
func changeFormat(str:String) -> String {
    let dateFormatter = DateFormatter()
    
    // step 1
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:Z" // input format
    let date = dateFormatter.date(from: str)!
    
    // step 2
    dateFormatter.dateFormat = "hh:mm:ss a" // output format
    let string = dateFormatter.string(from: date)
    return string
}
