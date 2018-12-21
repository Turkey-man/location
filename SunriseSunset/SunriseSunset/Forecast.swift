//
//  Forecast.swift
//  SunriseSunset
//
//  Created by 1 on 20.12.18.
//  Copyright © 2018 Bogdan Magala. All rights reserved.
//

import Foundation

class Forecast {
    let sunrise: String?
    let sunset: String?
    
    struct SunriseKeys {
        static let sunrise = "sunrise"
        static let sunset = "sunset"
    }
    
    init(forecastDictionary: [String: Any]) {
        if let sunriseTime = forecastDictionary[SunriseKeys.sunrise] as? String {
            sunrise = sunriseTime
        } else {
            sunrise = nil
        }
        
        if let sunsetTime = forecastDictionary[SunriseKeys.sunset] as? String {
            sunset = sunsetTime
        } else {
            sunset = nil
        }
    }
}
