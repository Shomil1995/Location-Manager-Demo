//
//  SecondVC.swift
//  DemoLocation
//
//  Created by shomil on 03/10/22.
//

import UIKit
import CoreLocation
import GoogleMaps


class OngoingTripVC: UIViewController, MainStoryboarded {
    
    //MARK: - IBOutlet
    @IBOutlet weak var btnEndTrip: UIButton!
    @IBOutlet var mapView: GMSMapView!
    
    //MARK: - Variables
    var viewModel = TripViewModel()
    var locationManager = CLLocationManager()
    var arrMapPath : BehaviorRelay<[MapPathData]> = .init(value: [])
    var iTemp:Int = 0
    var marker = GMSMarker()
    var timer = Timer()
    var startDate : String = ""
    var distanceTravelled = 0.0
    var endDate: String = ""
    var locations : [MapPathData] = []
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.accessibilityElementsHidden = false
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        bindUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true

    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - bindUI
    func bindUI() {
        arrMapPath.asDriver().drive(onNext: { [weak self] arrMapPath in
            self?.drawPathOnMap()
            self?.playCar()
        }).disposed(by: rx.disposeBag)
    }
    //MARK: - Distance Calculate
    func calculateDistance() {
        // make GMSMutablePath of your co-ordinates
        let path = GMSMutablePath()
        
        for obj in arrMapPath.value{
            print(obj)
            path.addLatitude(obj.lat ?? 0.0, longitude: obj.lon ?? 0.0)
        }
        // Here is your traveling path
        print(path)
        let km = Int(GMSGeometryLength(path))
        // your total traveling distance
        print(km/1000)
        distanceTravelled = Double(km/1000)
    }
    
    //MARK: - IBAction
    @IBAction func btnEndTripAction(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        calculateDistance()
        endDate = currentDate(date: Date())
        locations.append(MapPathData(lat: arrMapPath.value.first?.lat ?? 0.0, lon: arrMapPath.value.first?.lon ?? 0.0))
        locations.append(MapPathData(lat: arrMapPath.value.last?.lat ?? 0.0, lon: arrMapPath.value.last?.lon ?? 0.0))
        viewModel.setTripData(btnEndTrip, startDate: startDate, endDate: endDate, startLat: arrMapPath.value.first?.lat ?? 0.0, startLong: arrMapPath.value.first?.lon ?? 0.0, endLat: arrMapPath.value.last?.lat ?? 0.0, endLong: arrMapPath.value.last?.lon ?? 0.0, distance: distanceTravelled)
        let objTripDetailVC = TripDetailVC.instantiate()
        objTripDetailVC.startDate = startDate
        objTripDetailVC.endDate = endDate
        objTripDetailVC.arrLocations = locations
        objTripDetailVC.isTripDetail = true
        navigationController?.pushViewController(objTripDetailVC, animated: true)
    }
}

extension OngoingTripVC {
    
    //path create
    func drawPathOnMap()  {
        let path = GMSMutablePath()
        let marker = GMSMarker()
        
        let inialLat:Double = arrMapPath.value[0].lat!
        let inialLong:Double = arrMapPath.value[0].lon!
        
        for mapPath in arrMapPath.value
        {
            path.add(CLLocationCoordinate2DMake(mapPath.lat!, mapPath.lon!))
        }
        //set poly line on mapview
        let rectangle = GMSPolyline(path: path)
        rectangle.strokeWidth = 5.0
        marker.map = mapView
        rectangle.map = mapView
        
        //Zoom map with path area
        let loc : CLLocation = CLLocation(latitude: inialLat, longitude: inialLong)
        updateMapFrame(newLocation: loc, zoom: 12.0)
    }
    
    //marker move on map view
    func playCar()
    {
        //        if iTemp <= (arrMapPath.value.count - 1 )
        //        {
        //            let iTempMapPath = arrMapPath.value[iTemp]
        //
        //            let loc : CLLocation = CLLocation(latitude: iTempMapPath.lat!, longitude: iTempMapPath.lon!)
        //
        //            updateMapFrame(newLocation: loc, zoom: self.mapView.camera.zoom)
        //            marker.position = CLLocationCoordinate2DMake(iTempMapPath.lat!, iTempMapPath.lon!)
        //
        //            marker.icon = UIImage(named: "map_car_running.png")
        //            marker.map = mapView
        //
        //            // Timer close
        //            if iTemp == (arrMapPath.value.count - 1)
        //            {
        //                // timer close
        //                timer.invalidate()
        //                iTemp = 0
        //            }
        //            iTemp += 1
        //        }
    }
    
    //Zoom map with cordinate
    func updateMapFrame(newLocation: CLLocation, zoom: Float) {
        let camera = GMSCameraPosition.camera(withTarget: newLocation.coordinate, zoom: zoom)
        self.mapView.animate(to: camera)
    }
    
}

//MARK: -  CLLocationManagerDelegate
extension OngoingTripVC : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        var arr = arrMapPath.value
        arr.append(MapPathData(lat: locValue.latitude, lon: locValue.longitude))
        arrMapPath.accept(arr)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


