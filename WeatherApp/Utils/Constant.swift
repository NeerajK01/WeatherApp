//
//  Constant.swift
//  WeatherApp
//
//  Created by Parveen kumar on 31/10/2019 .
//

import Foundation

class Constant {
    private init(){ }
    static let shared = Constant()
    
    var currentLatitude: Double?
    var currentLongitude: Double?
    
    var celcius = true
    
    var userName = ""
    let API_KEY = "afbeb18dc409da18adaff4abaf9db2e3"
    let baseUrl = "http://api.openweathermap.org/data/2.5/weather?q="
    let app_ID = "&APPID="
    
    let secondBaseUrl = "https://api.openweathermap.org/data/2.5/onecall/timemachine?"
}
