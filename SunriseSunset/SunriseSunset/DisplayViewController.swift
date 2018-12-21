//
//  ViewController.swift
//  SunriseSunset
//
//  Created by 1 on 13.12.18.
//  Copyright © 2018 Bogdan Magala. All rights reserved.
//

import UIKit
import CoreLocation

class DisplayViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    var modelController: CoordinatesModelController!
    var sunService: SunService!
    let baseURL = URL(string: "https://api.sunrise-sunset.org/json?")
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        
        var coordinates = modelController.coordinates
        var latitude = locationValue.latitude
        var longtitude = locationValue.longitude
        coordinates = Coordinates(coords: (lat: latitude, long: longtitude))
    }
    
    @IBAction func getForecast(_ sender: Any) {
        var coordinates = modelController.coordinates
        sunService = SunService(BaseURL: baseURL!)
                sunService.getData(latitude: coordinates.coords.lat, longtitude: coordinates.coords.long) { (currentForecast) in
                    //MARK:- Back to main thread in case of success
                    if let currentForecast = currentForecast {
                        DispatchQueue.main.async {
                            if let sunrise = currentForecast.sunrise, let sunset = currentForecast.sunset {
                                self.sunriseLabel.text = "\(sunrise)"
                                self.sunsetLabel.text = "\(sunset)"
                            } else {
                                self.sunriseLabel.text = "-"
                                self.sunsetLabel.text = "-"
                            }
                        }
                    }
                }
    }
}
