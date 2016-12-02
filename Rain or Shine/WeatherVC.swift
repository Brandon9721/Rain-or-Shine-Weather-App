//
//  WeatherVC.swift
//  Rain or Shine
//
//  Created by Brandon Byrne on 2016-11-27.
//  Copyright © 2016 ZeahSoft. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locaionLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        locationManager.startUpdatingLocation()
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch(status) {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
       
        case .authorizedWhenInUse:
            locationManager.requestLocation()
            self.updateMainUI()
            break
        default:
            print("DEFAULT", status.rawValue)
        }
        //locationAuthStatus()
    }
//    func setCoords() {
//        Location.sharedInstance.latitude = currentLocation.coordinate.latitude
//        Location.sharedInstance.longitude = currentLocation.coordinate.longitude
//        print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
//    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
        locationManager.stopUpdatingLocation()
        if let currentLocation = locations.last {
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
            
        }
    }
    
  
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

    // function to download future forecasts
    func downloadForecastData(completed: @escaping DownloadComplete) {
        // downloading forecast weather data for tableview
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                       
                    }
//                    self.forecasts.remove(at: 0)
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath ) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    
    // update labels with downloaded data
    func updateMainUI() {
        locationManager.stopUpdatingLocation()
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        if(currentWeather.cityName != "")
        {
            locaionLabel.text = "\(currentWeather.cityName), \(currentWeather.countryName)"
        }
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
        locationManager.stopUpdatingLocation()
        
    }
    

}

