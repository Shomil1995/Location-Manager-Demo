//
//  TripListViewModel.swift
//  DemoLocation
//
//  Created by shomil on 03/10/22.
//

import Foundation
import Foundation
import CoreData
import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx


class TripListViewModel {
    var objTripList: BehaviorRelay<[TripDetailData]?> = .init(value: nil)
}

//MARK: Public methods
extension TripListViewModel {
    func getTripData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<TripDetails> = TripDetails.fetchRequest()
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            objTripList.accept(result.map { TripDetailData.init(entry: $0) })
            print(result.debugDescription)
        } catch let error {
            UIApplication.topViewController()?.view.makeToast(error.localizedDescription)
            print("Could not save. \(error), \(error.localizedDescription)")
        }
    }
    
}
