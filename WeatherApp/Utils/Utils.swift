//
//  Utils.swift
//  WeatherApp
//
//  Created by Parveen kumar on 31/10/2019 .
//

import Foundation

class Utils {
    private init(){}
    static let shared = Utils()
    
    func ConvertCalendarDateFormat(getDateValue: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE, MMM dd yyyy"
        let date: NSDate? = dateFormatterGet.date(from: getDateValue) as NSDate?
        let currDate = dateFormatterPrint.string(from: date! as Date)
        return currDate
    }
    
}
