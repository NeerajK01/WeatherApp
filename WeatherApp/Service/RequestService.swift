//
//  RequestService.swift
//  WeatherApp
//
//  Created by Parveen kumar on 31/10/2019 .
//

import Foundation

class RequestService {
    private init(){ }
    static let shared = RequestService()
    
    func callAPI(apiEndPoint: String, completionHandler: @escaping ( Data?, Error?) -> Void){
        
        guard let url = URL(string: apiEndPoint) else{
            exit(1)
        }
        
        let session = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        let task = session.dataTask(with: urlRequest){
            (data, response, error) in
            
            if error != nil{
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            completionHandler(data, error)
            
        }
        task.resume()
    }
}
