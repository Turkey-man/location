//
//  SunService.swift
//  SunriseSunset
//
//  Created by 1 on 09.12.18.
//  Copyright © 2018 Bogdan Magala. All rights reserved.
//

import Foundation
import Alamofire
//https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400
class SunService {
    var forecastBaseURL: URL?
    var modelController: CoordinatesModelController!
    
    init(BaseURL: URL) {
        self.forecastBaseURL = BaseURL
        forecastBaseURL = URL(string: "https://api.sunrise-sunset.org/json?")
    }
    
    func getData(latitude: Double, longtitude: Double, completion: @escaping (Forecast?) -> Void){
        if let forecastUrl = URL(string: "\(forecastBaseURL!)lat=\(latitude)&lng=\(longtitude)") {
            request(forecastUrl).responseJSON(completionHandler: { (response) in
                //If we get the data
                if let jsonDictionary = response.result.value as? [String: Any] {
                    //Accessing results
                    if let currentForecastDictionaty = jsonDictionary["results"] as? [String: Any] {
                        //Filling previously created dict with data
                        let currentForecast = Forecast(forecastDictionary: currentForecastDictionaty)
                        completion(currentForecast)
                    } else {
                        completion(nil)
                    }
                }
            })
        }
    }
}
