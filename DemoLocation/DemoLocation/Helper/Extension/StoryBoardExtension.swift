//
//  StoryBoardExtension.swift
//  DemoLocation
//
//  Created by shomil on 03/10/22.
//

import Foundation
import UIKit

protocol MainStoryboarded {
    static func instantiate() -> Self
}

extension MainStoryboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
