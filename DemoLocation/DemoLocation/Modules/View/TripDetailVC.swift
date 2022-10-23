//
//  ThirdVC.swift
//  DemoLocation
//
//  Created by shomil on 03/10/22.
//

import UIKit

class TripDetailVC: UIViewController ,MainStoryboarded {
    
    //MARK: - IBOutlet
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblTripDetail: UILabel!
    
    //MARK: - Variables
    var locationManager = CLLocationManager()
    var startDate : String = ""
    var endDate: String = ""
    var arrLocations: [MapPathData] = []
    var isTripDetail : Bool = false
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        setData()
        navigationItem.leftBarButtonItem = nil
        showCurrentLocationOnMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true

    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - SetData
    func setData() {
        if isTripDetail == false {
            lblEndTime.isHidden = true
            lblStartTime.isHidden = true
            lblTripDetail.isHidden = true
        }
        lblStartTime.text = "Start Time: \(changeFormat(str: startDate))"
        lblEndTime.text = "End Time: \(changeFormat(str: endDate))"
    }
    @IBAction func btnHomeAction(_ sender: Any) {
        let objStartTripVC = StartTripVC.instantiate()
        navigationController?.pushViewController(objStartTripVC, animated: true)
    }
}

//MARK: - CLLocationManagerDelegate
extension TripDetailVC: CLLocationManagerDelegate {
    func showCurrentLocationOnMap() {
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        
        for data in arrLocations{
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: data.lat ?? 0.0, longitude:  data.lon ?? 0.0)
            marker.map = mapView
            mapView.camera = GMSCameraPosition(latitude:  data.lat ?? 0.0, longitude:  data.lon ?? 0.0, zoom: 10.0, bearing: 0, viewingAngle: 0)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.showCurrentLocationOnMap()
        self.locationManager.stopUpdatingLocation()
    }
}
