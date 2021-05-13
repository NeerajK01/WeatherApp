//
//  ViewController.swift
//  WeatherApp
//
//  Created by Parveen kumar on 31/10/2019 .
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var userNameLBL: UILabel!
    
    var locationManager: CLLocationManager!
    
    var cityName: String?
    var countryCode: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let username = UserDefaults.standard.string(forKey: "username"){
            if username == ""{
                userNameLBL.text = "Hello"
            }else{
                userNameLBL.text = "Hello, \(username)"
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateUsername), name: NSNotification.Name(rawValue: "userNameUpdate"), object: nil)
        
        
        //init location manager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.getCurrentLocationEveryTime()
        
    }


    @objc func UpdateUsername(){
        if let username = UserDefaults.standard.string(forKey: "username"){
            userNameLBL.text = "Hello, \(username)"
        }
    }
    
    func getCurrentLocationEveryTime(){
        //configure location manager
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        //check if location GPS enable or not
        if CLLocationManager.locationServicesEnabled(){
            
            //location enabled
            debugPrint("Location Enabled")
            locationManager.startUpdatingLocation()
            
        }else{
            
            //location not enabled
            debugPrint("Location Not Enabled")
            
        }
    }
    
    @IBAction func getCurrentLocation(_ sender: Any) {
        if let city = self.cityName, let country = self.countryCode{
            let dataDict:[String: String] = ["city": city, "code": country]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getCurrentWeather"), object: nil, userInfo: dataDict)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //get current location
        let userLocation = locations[0] as CLLocation
        
        //get latitude and longitude
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        Constant.shared.currentLatitude = latitude.roundToDecimal(2)
        Constant.shared.currentLongitude = longitude.roundToDecimal(2)
        
        //set ui and hit notification
        
//        debugPrint("latitude \(latitude)")
//        debugPrint("longitude \(longitude)")
//
        //get address
        let geocode = CLGeocoder()
        geocode.reverseGeocodeLocation(userLocation){ (placemarks, error) in
            if (error != nil){
                debugPrint("Error in reverseGeocodeLocation")
            }
            let placemark = placemarks! as [CLPlacemark]
            if (placemark.count > 0){
                let addressmark = placemark[0]
                
                let locality = addressmark.locality ?? ""
//                let administraticeArea = addressmark.administrativeArea ?? ""
//                let country = addressmark.country ?? ""
                let countryCode = addressmark.isoCountryCode ?? ""
                
                self.cityName = String(describing: locality)
                self.countryCode = String(describing: countryCode)
                
                //set address
//                debugPrint("Locality: \(String(describing: locality))")
//                debugPrint("administraticeArea: \(String(describing: administraticeArea))")
//                debugPrint("country: \(String(describing: country))")
//                debugPrint("country Code: \(String(describing: countryCode))")
                
            }
        }
    }
    
}

