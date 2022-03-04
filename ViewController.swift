//
//  ViewController.swift
//  LocationAppDemo
//
//  Created by 高橋蓮 on 2022/03/04.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        title = "Home"
        LocationManager.shared.GetUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.addMapPin(with: location)
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    func addMapPin(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(center: location.coordinate,
                                         span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)),
                      animated: true)
        map.addAnnotation(pin)
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            self?.title = locationName
            
        }
    }
    
    
    
}

