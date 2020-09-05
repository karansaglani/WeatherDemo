//
//  ViewController.swift
//  WeatherDemo
//
//  Created by Karan Saglani on 05/09/20.
//  Copyright © 2020 Karan Saglani. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    let mf = MeasurementFormatter()
    
    var weatherDetails : ModelWeatherData?
    
    let APIKeyForOpenWeather = "4a5bc7c72839372de9c5837691d96a5f"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        
    }
    
}

extension ViewController: CLLocationManagerDelegate, GMSMapViewDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        
        
        let camera = GMSCameraPosition.camera(withLatitude: (userLocation?.coordinate.latitude)!, longitude:(userLocation?.coordinate.longitude)!, zoom:10)
        self.mapView.camera = camera
        self.mapView.isMyLocationEnabled = true
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
            locationManager.startUpdatingLocation()
        @unknown default:
            fatalError()
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        print("My Location")
        if let location = mapView.myLocation{
            let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude:(location.coordinate.longitude), zoom:14)
            mapView.animate(to: camera)
        }
        
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let marker = GMSMarker(position: center)
        
        print("Latitude :- \(coordinate.latitude)")
        print("Longitude :-\(coordinate.longitude)")
        marker.map = self.mapView
        
        marker.title = "Check Weather"
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        retrieveCurrentWeatherAtLat(lat: marker.position.latitude, lon: marker.position.longitude) { (json) in
            print(json.description)
        }
        
        
    }
    func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return mf.string(from: output)
    }
    
    func convertSecondsToCurrentTime(seconds : Int) -> String{
        
        let timeInteravl = seconds
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeInteravl))
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat =  "hh:mm a"
        let dateString = dateTimeFormatter.string(from: date as Date)
        return dateString
    }
    
    func moveToInfo(weatherData: ModelWeatherData) {
        
        let vcConfirmation = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"WeatherInfoViewController")as? WeatherInfoViewController
        vcConfirmation?.modalTransitionStyle = .coverVertical
        vcConfirmation?.arrConfirmDetail = createWeatherData(weatherData: weatherData)
        self.present(vcConfirmation!, animated: true, completion: nil)
    }
    
    func createWeatherData(weatherData: ModelWeatherData) -> [[String : Any]]{
        
        var currentTemp = String.getString(weatherData.main?.feelsLike)
        if let doubleTemp = Double(currentTemp){
            let celsius = convertTemp(temp: doubleTemp, from: .kelvin, to: .celsius)
            currentTemp = celsius
        }
        
        var maxTemp = String.getString(weatherData.main?.tempMax)
        if let doubleTemp = Double(maxTemp){
            let celsius = convertTemp(temp: doubleTemp, from: .kelvin, to: .celsius)
            maxTemp = celsius
        }
        
        var minTemp = String.getString(weatherData.main?.tempMax)
        if let doubleTemp = Double(minTemp){
            let celsius = convertTemp(temp: doubleTemp, from: .kelvin, to: .celsius)
            minTemp = celsius
        }
        
        var sunriseTime = ""
        if let secs = weatherData.sys?.sunrise{
            sunriseTime = convertSecondsToCurrentTime(seconds: secs)
        }
        
        var sunsetTime = ""
        if let secs = weatherData.sys?.sunset{
            sunsetTime = convertSecondsToCurrentTime(seconds: secs)
        }
        
        let weatherArr = [
            
            [
                "confirmKey" : "Location",
                "confirmValue" : String.getString(weatherData.name) + ", " + String.getString(weatherData.sys?.country)
            ],
            [
                "confirmKey" : "Weather Condition",
                "confirmValue" : String.getString(weatherData.weather?.first?.main)
            ],
            [
                "confirmKey" : "Current Temperature",
                "confirmValue" : currentTemp
            ],
            [
                "confirmKey" : "Max Temperature",
                "confirmValue" : maxTemp
            ],
            [
                "confirmKey" : "Min Temperature",
                "confirmValue" : minTemp
            ],
            [
                "confirmKey" : "Pressure",
                "confirmValue" : String.getString(weatherData.main?.pressure) + " hPa"
            ],
            [
                "confirmKey" : "Sunrise",
                "confirmValue" : sunriseTime
            ],
            [
                "confirmKey" : "Sunrise",
                "confirmValue" : sunsetTime
            ]
        ]
        
        return weatherArr
    }
}

// Open Weather Service

extension ViewController{
    
    func retrieveCurrentWeatherAtLat(lat: CLLocationDegrees, lon: CLLocationDegrees,
                                     block: @escaping (_ weatherCondition: JSON) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather?APPID=\(APIKeyForOpenWeather)"
        let params = ["lat": lat, "lon": lon]
        
        AF.request(url , parameters: params).responseJSON {response in
            switch response.result{
            case .success(let value):
                let decoder = JSONDecoder()
                
                guard let data = response.data else {return}
                
                do{
                    let responseData = try decoder.decode(ModelWeatherData.self, from: data)
                    print(responseData)
                    self.moveToInfo(weatherData: responseData)
                    
                }
                catch{
                    print(error)
                }
                let json = JSON(value)
                debugPrint(json)
            case .failure(let error):
                print(error)
            }
        }
    }
}
