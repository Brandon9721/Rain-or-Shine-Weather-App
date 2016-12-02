//
//  Constants.swift
//  Rain or Shine
//
//  Created by Brandon Byrne on 2016-11-28.
//  Copyright © 2016 ZeahSoft. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "7a995fcd356a9c3e39d5207e87cfbbef"

typealias DownloadComplete = () -> ()

var CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude as Double)\(LONGITUDE)\(Location.sharedInstance.longitude as Double)\(APP_ID)\(API_KEY)"

var FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude! as Double)&lon=\(Location.sharedInstance.longitude! as Double)&cnt=16&mode=json&appid=7a995fcd356a9c3e39d5207e87cfbbef"
