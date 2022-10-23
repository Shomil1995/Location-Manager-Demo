//
//  ViewController.swift
//  DemoLocation
//
//  Created by shomil on 30/09/22.
//

import UIKit


class StartTripVC: UIViewController, MainStoryboarded {
    
    //MARK: - IBOutlet
    @IBOutlet weak var mapView: GMSMapView!
    
    //MARK: - Variables
    var locationManager = CLLocationManager()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.accessibilityElementsHidden = false
        locationManager.startUpdatingLocation()
        let rightButtonItem = UIBarButtonItem.init(title: "Menu", style: .done, target: self, action: #selector(rightButtonAction(sender:)))
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        let menu = SideMenuNavigationController(rootViewController: MenuListVC.instantiate())
        present(menu, animated: true, completion: nil)
    }
    
    //MARK: - IBAction
    
    @IBAction func btnGetCurrentLocationAction(_ sender: Any) {
        
        if
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            print(locationManager.location)
            let objOngoingTripVC = OngoingTripVC.instantiate()
            var arr = objOngoingTripVC.arrMapPath.value
            arr.append(MapPathData(lat: locationManager.location?.coordinate.latitude ?? 0.0, lon: locationManager.location?.coordinate.longitude ?? 0.0))
            objOngoingTripVC.startDate = currentDate(date: Date())
            objOngoingTripVC.arrMapPath.accept(arr)
            navigationController?.pushViewController(objOngoingTripVC, animated: true)
        } else {
            
        }
        
    }
    
}

//MARK: - CLLocationManagerDelegate
extension StartTripVC : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else {
            return
        }
        print(location.coordinate)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        marker.map = mapView
        
        mapView.camera = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 10.0, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
