//
//  TripViewModel.swift
//  DemoLocation
//
//  Created by shomil on 03/10/22.
//

import Foundation
import CoreData
import UIKit

class TripViewModel {
   
}

//MARK: Public methods
extension TripViewModel {
func setTripData(_ loaderInView: UIView? = nil, startDate: String, endDate: String, startLat: Double, startLong: Double, endLat: Double, endLong: Double, distance: Double? = nil) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let userEntity = NSEntityDescription.entity(forEntityName: "TripDetails", in: managedContext)!
    
    let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
    user.setValue(startDate, forKey: WebServiceParameter.startDate)
    user.setValue(endDate, forKey: WebServiceParameter.endDate)
    user.setValue(startLat, forKey: WebServiceParameter.startLat)
    user.setValue(startLong, forKey: WebServiceParameter.startLong)
    user.setValue(endLat, forKey: WebServiceParameter.endLat)
    user.setValue(endLong, forKey: WebServiceParameter.endLong)
    user.setValue(distance, forKey: WebServiceParameter.distance)

    do {
        try managedContext.save()
        print("Data saved sucessfully")
    } catch let error as Error {
        UIApplication.topViewController()?.view.makeToast(error.localizedDescription)
        print("Could not save. \(error), \(error.localizedDescription)")
    }
}
}
