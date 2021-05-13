//
//  DecodeResponse.swift
//  WeatherApp
//
//  Created by Parveen kumar on 31/10/2019 .
//

import Foundation
class DecodeResponse {
    private init(){ }
    static let shared = DecodeResponse()
    
    func getResponse(apiEndPoint: String, completionHandler: @escaping(TodayWeatherDTO?, String?) -> Void){
        RequestService.shared.callAPI(apiEndPoint: apiEndPoint, completionHandler: {
            (response, error) in
            
            if response != nil{
                do{
                    let jsonData = JSONDecoder()
                    let weatherData = try jsonData.decode(TodayWeatherDTO.self, from: response!)
                    debugPrint(weatherData)
                    completionHandler(weatherData, "Success")
                }catch{
                    completionHandler(nil, "UnSuccess")
                }
            }
        })
    }
    
    func getResponseByDT(apiEndPoint: String, completionHandler: @escaping(WeatherDTO?, String?) -> Void){
        RequestService.shared.callAPI(apiEndPoint: apiEndPoint, completionHandler: {
            (response, error) in
            if response != nil{
                do{
                    let jsonData = JSONDecoder()
                    let weatherData = try jsonData.decode(WeatherDTO.self, from: response!)
                    debugPrint(weatherData)
                    completionHandler(weatherData, "Success")
                }catch{
                    completionHandler(nil, "UnSuccess")
                }
            }
        })
    }
    
}
