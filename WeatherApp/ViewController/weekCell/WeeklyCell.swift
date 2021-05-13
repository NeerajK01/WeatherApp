//
//  WeeklyCell.swift
//  WeatherApp
//
//  Created by Parveen kumar on 31/10/2019 .
//

import UIKit

class WeeklyCell: UITableViewCell {
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempratureLBL: UILabel!
    @IBOutlet weak var weatherLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func callAPI(dt: Int, dateString: String){
        if let lat = Constant.shared.currentLatitude, let lon = Constant.shared.currentLongitude{
            let url = "\(Constant.shared.secondBaseUrl)lat=\(lat)&lon=\(lon)&dt=\(dt)&appid=\(Constant.shared.API_KEY)"
            debugPrint(url)
            
            self.dateLbl.text = dateString
            
            DecodeResponse.shared.getResponseByDT(apiEndPoint: url, completionHandler: {
                (response, status) in
                if status == "Success"{
                    if let weatherResponse = response{
                        DispatchQueue.main.async {
                            
                            if let kelvinTemp = weatherResponse.current?.temp{
                                let afterConvert = kelvinTemp.convertFromKelvinToCelcius()
                                let celcius = afterConvert.roundToDecimal(2)
                                if Constant.shared.celcius{
                                    self.tempratureLBL.text = "\(String(describing: celcius)) °C"
                                }else{
                                    let fehrenheit = celcius.convertToFehrenheit()
                                    let roundFehrenheit = fehrenheit.roundToDecimal(2)
                                    self.tempratureLBL.text = "\(String(describing: roundFehrenheit)) °F"
                                }
                            }
                            self.weatherLBL.text = weatherResponse.current?.weather?[0].main ?? ""
                            
                        }
                    }
                }
            })
            
        }
    }

}
