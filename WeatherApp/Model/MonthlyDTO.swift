//
//  MonthlyDTO.swift
//  WeatherApp
//
//  Created by Parveen kumar on 31/10/2019 .
//

import Foundation
struct MonthlyDTO: Decodable {
    var lat: Double?
    var lon: Double?
    var current: Current?
}

struct Current: Decodable {
    var dt: Int?
    var temp: Double?
    var weather: [MonthlyWeather]?
}

struct MonthlyWeather: Decodable {
    var id: Int?
    var main: String?
    var description: String?
    
}
