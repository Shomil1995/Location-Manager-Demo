//
//  FifthVC.swift
//  DemoLocation
//
//  Created by shomil on 03/10/22.
//

import UIKit

class MenuListVC: UIViewController, MainStoryboarded {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var tblMenuList: UITableView!
    
    //MARK: - Variables
    var arrMenuList = ["Trip History"]
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuList.delegate = self
        tblMenuList.dataSource = self
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MenuListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblMenuList.dequeueReusableCell(withIdentifier: "MenuListTblCell", for: indexPath) as! MenuListTblCell
        cell.lblMenu.text = arrMenuList[indexPath.row]
        return  cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objTripHistoryVC = TripHistoryVC.instantiate()
        self.navigationController?.pushViewController(objTripHistoryVC, animated: true)
    }
    
}
