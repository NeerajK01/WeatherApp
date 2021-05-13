//
//  WeekVC.swift
//  WeatherApp
//
//  Created by Parveen kumar on 31/10/2019 .
//

import UIKit

class WeekVC: UIViewController {

    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var weekTablView: UITableView!
    
    var weekDate: [String] = [String]()
    var weekTimeInterval: [Int] = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStyle()
        
        setStyle()
        
        let today = Date()
        for i in 0..<7{
            let nextDate = Calendar.current.date(byAdding: .day, value: i-6, to: today)!
            
            let getDate = Utils.shared.ConvertCalendarDateFormat(getDateValue: String(describing: nextDate))
            self.weekDate.append(getDate)
            
            self.weekTimeInterval.append(Int(nextDate.timeIntervalSince1970))
            
//            debugPrint(nextDate)
//            debugPrint(Int(nextDate.timeIntervalSince1970))
        }
        weekTablView.delegate = self
        weekTablView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        weekTablView.reloadData()
    }
    
    func setStyle(){
        backgroundView.layer.cornerRadius = backgroundView.frame.height * 0.02
        backgroundView.layer.shadowColor = UIColor.darkGray.cgColor
        backgroundView.layer.shadowOpacity = 0.5
        backgroundView.layer.shadowOffset = CGSize.zero
        backgroundView.layer.shadowRadius = 8
    }
    
}

extension WeekVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekCell", for: indexPath) as! WeeklyCell
        
        if (self.weekDate.count >= indexPath.row) && (self.weekTimeInterval.count >= indexPath.row){
            cell.callAPI(dt: self.weekTimeInterval[indexPath.row], dateString: self.weekDate[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}
