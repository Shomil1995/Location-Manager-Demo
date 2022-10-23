//
//  SixthVC.swift
//  DemoLocation
//
//  Created by shomil on 03/10/22.
//

import UIKit

class TripHistoryVC: UIViewController, MainStoryboarded {
    
    //MARK: - IBOutlet
    @IBOutlet weak var tblTripList: UITableView!
    
    //MARK: - Variables
    var viewModel = TripListViewModel()
    var arrLocations : [MapPathData] = []
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getTripData()
        title = "Trip History"
        tblTripList.dataSource = self
        tblTripList.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true

    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TripHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.objTripList.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblTripList.dequeueReusableCell(withIdentifier: "TripListTblCell", for: indexPath) as! TripListTblCell
        let arrTripList = viewModel.objTripList.value
        cell.lblTripNo.text = "Trip No: \(indexPath.row + 1)"
        cell.lblStartTime.text = "Start Time: \(changeFormat(str: arrTripList?[indexPath.row].startDate ?? ""))"
        cell.lblEndTime.text = "End Time: \(changeFormat(str: arrTripList?[indexPath.row].endDate ?? ""))"
        cell.lblDistance.text = "Total Distance Travelled: \(arrTripList?[indexPath.row].distance ?? 0) Km"
        return  cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let arrTripList = viewModel.objTripList.value
        arrLocations.append(MapPathData(lat: arrTripList?[indexPath.row].startLat , lon: arrTripList?[indexPath.row].startLong))
        arrLocations.append(MapPathData(lat: arrTripList?[indexPath.row].endLat , lon: arrTripList?[indexPath.row].endLong))
        
        let objTripDetailVC = TripDetailVC.instantiate()
        objTripDetailVC.arrLocations = arrLocations
        objTripDetailVC.startDate =  arrTripList?[indexPath.row].startDate ?? ""
        objTripDetailVC.endDate = arrTripList?[indexPath.row].endDate ?? ""
        objTripDetailVC.isTripDetail = false
        self.navigationController?.pushViewController(objTripDetailVC, animated: true)
        
    }
    
}
