//
//  CurrentVC.swift
//  WeatherApp
//
//  Created by Parveen kumar on 31/10/2019 .
//

import UIKit

class CurrentVC: UIViewController {

    @IBOutlet weak var currentBackgroundView: UIView!
    @IBOutlet weak var cityNameLBL: UILabel!
    @IBOutlet weak var currentDateLBL: UILabel!
    @IBOutlet weak var tempratureLBL: UILabel!
    @IBOutlet weak var atmosphereLBL: UILabel!
    @IBOutlet weak var windSpeedLBL: UILabel!
    
    var currentWeather: TodayWeatherDTO = TodayWeatherDTO()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getResponse(notification:)), name: NSNotification.Name(rawValue: "getCurrentWeather"), object: nil)
        
        self.setStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateValues()
    }
    
    func setStyle(){
        currentBackgroundView.layer.cornerRadius = currentBackgroundView.frame.height * 0.02
        currentBackgroundView.layer.shadowColor = UIColor.darkGray.cgColor
        currentBackgroundView.layer.shadowOpacity = 0.5
        currentBackgroundView.layer.shadowOffset = CGSize.zero
        currentBackgroundView.layer.shadowRadius = 8
    }
    
    @objc func getResponse(notification: NSNotification){
        if let city = notification.userInfo?["city"] as? String{
            if let country = notification.userInfo?["code"] as? String{
                
                let apiEndPoint = "\(Constant.shared.baseUrl)\(city),\(country)\(Constant.shared.app_ID)\(Constant.shared.API_KEY)"
                
                DecodeResponse.shared.getResponse(apiEndPoint: apiEndPoint, completionHandler: {
                    (response, status) in
                    if status == "Success"{
                        if let weatherresponse = response{
                            self.currentWeather = weatherresponse
                            DispatchQueue.main.async {
                                self.updateValues()
                            }
                        }
                    }
                })
                
            }
        }
    }
    
    func updateValues(){
        self.cityNameLBL.text = currentWeather.name ?? "Delhi"
        let currentDate = Utils.shared.ConvertCalendarDateFormat(getDateValue: String(describing: Date()))
        self.currentDateLBL.text = currentDate
        if let kelvinTemp = currentWeather.main?.temp{
            let afterConvert = kelvinTemp.convertFromKelvinToCelcius()
            let celcius = afterConvert.roundToDecimal(2)
            if Constant.shared.celcius{
                self.tempratureLBL.text = "\(String(describing: celcius)) °C"
            }else{
                self.tempratureLBL.text = "\(String(describing: celcius.convertToFehrenheit())) °F"
            }
        }
        
        
        self.atmosphereLBL.text = currentWeather.weather?[0].main ?? ""
        if let speed = currentWeather.wind?.speed{
            self.windSpeedLBL.text = "\(speed) km/h"
        }
        
    }
    
}


extension Double{
    func convertFromKelvinToCelcius() -> Double{
        return (self - 273.15)
    }
    
    func convertToFehrenheit() -> Double{
        return ((self * 1.8000) + 32)
    }
    
    func convertToCelcius() -> Double{
        return ((self - 32) / 1.8000)
    }
    
    func roundToDecimal(_ fractionDigit: Int) -> Double{
        let multiplier = pow(10, Double(fractionDigit))
        return Darwin.round(self * multiplier) / multiplier
    }
    
}
