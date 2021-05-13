//
//  CalendarVC.swift
//  WeatherApp
//
//  Created by Parveen kumar on 31/10/2019 .
//

import UIKit
import JTAppleCalendar

class CalendarVC: UIViewController {
    @IBOutlet weak var delhiBTN: UIButton!
    @IBOutlet weak var noidaBtn: UIButton!
    @IBOutlet weak var mumbaiBTN: UIButton!
    @IBOutlet weak var prevBTN: UIButton!
    @IBOutlet weak var nextBTN: UIButton!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var monthLBL: UILabel!
    @IBOutlet weak var calendarView: JTACMonthView!
    
    @IBOutlet weak var tempratureLBL: UILabel!
    @IBOutlet weak var atmosphereLBL: UILabel!
    
    var latitude: Double?
    var longitude: Double?
    
    var weatherData: WeatherDTO = WeatherDTO()
    
    var dateSelect: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        self.monthLBL.text = formatter.string(from: date)
        currentMonth()
        scrollCalendar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateWeather()
    }
   
    func setStyle(){
        
        self.delhiBTN.layer.backgroundColor = UIColor.blue.cgColor
        self.delhiBTN.setTitleColor(.white, for: .normal)
        self.noidaBtn.layer.backgroundColor = UIColor.lightGray.cgColor
        self.noidaBtn.setTitleColor(.black, for: .normal)
        self.mumbaiBTN.layer.backgroundColor = UIColor.lightGray.cgColor
        self.mumbaiBTN.setTitleColor(.black, for: .normal)
        self.latitude = 28.70
        self.longitude = 77.10
        
        backGroundView.layer.cornerRadius = backGroundView.frame.height * 0.02
        backGroundView.layer.shadowColor = UIColor.darkGray.cgColor
        backGroundView.layer.shadowOpacity = 0.5
        backGroundView.layer.shadowOffset = CGSize.zero
        backGroundView.layer.shadowRadius = 8
        
        self.delhiBTN.layer.masksToBounds = true
        self.delhiBTN.layer.cornerRadius = self.delhiBTN.frame.height * 0.20
        
        self.noidaBtn.layer.masksToBounds = true
        self.noidaBtn.layer.cornerRadius = self.noidaBtn.frame.height * 0.20
        
        self.mumbaiBTN.layer.masksToBounds = true
        self.mumbaiBTN.layer.cornerRadius = self.mumbaiBTN.frame.height * 0.20
        
        self.prevBTN.layer.masksToBounds = true
        self.prevBTN.layer.cornerRadius = self.prevBTN.frame.height * 0.20
        
        self.nextBTN.layer.masksToBounds = true
        self.nextBTN.layer.cornerRadius = self.nextBTN.frame.height * 0.20
        
    }
    
    @IBAction func selectDelhiAction(_ sender: Any) {
        self.delhiBTN.layer.backgroundColor = UIColor.blue.cgColor
        self.delhiBTN.setTitleColor(.white, for: .normal)
        self.noidaBtn.layer.backgroundColor = UIColor.lightGray.cgColor
        self.noidaBtn.setTitleColor(.black, for: .normal)
        self.mumbaiBTN.layer.backgroundColor = UIColor.lightGray.cgColor
        self.mumbaiBTN.setTitleColor(.black, for: .normal)
        self.latitude = 28.70
        self.longitude = 77.10
    }
    
    @IBAction func selectNoidaAction(_ sender: Any) {
        self.delhiBTN.layer.backgroundColor = UIColor.lightGray.cgColor
        self.delhiBTN.setTitleColor(.black, for: .normal)
        self.noidaBtn.layer.backgroundColor = UIColor.blue.cgColor
        self.noidaBtn.setTitleColor(.white, for: .normal)
        self.mumbaiBTN.layer.backgroundColor = UIColor.lightGray.cgColor
        self.mumbaiBTN.setTitleColor(.black, for: .normal)
        self.latitude = 28.53
        self.longitude = 77.39
    }
    
    @IBAction func selectMumbaiAction(_ sender: Any) {
        self.delhiBTN.layer.backgroundColor = UIColor.lightGray.cgColor
        self.delhiBTN.setTitleColor(.black, for: .normal)
        self.noidaBtn.layer.backgroundColor = UIColor.lightGray.cgColor
        self.noidaBtn.setTitleColor(.black, for: .normal)
        self.mumbaiBTN.layer.backgroundColor = UIColor.blue.cgColor
        self.mumbaiBTN.setTitleColor(.white, for: .normal)
        self.latitude = 19.07
        self.longitude = 72.87
    }
    
    //MARK:- setMonthHeaderName() -  change monthHeader name when click previous and next btn
    func setMonthHeaderName(from visibleMonth: DateSegmentInfo){
        guard let date = visibleMonth.monthDates.first?.date else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        self.monthLBL.text = formatter.string(from: date)
    }
    
    //MARK:- get current month when start app
    func currentMonth(){
        let currentMonth = Date()
        self.calendarView.scrollToDate(currentMonth, animateScroll: false)
        self.calendarView.selectDates([currentMonth], triggerSelectionDelegate: true)
    }
    
    //MARK:- Calendar Scroll functionality
    func scrollCalendar(){
        self.calendarView.isScrollEnabled = false
        self.calendarView.scrollDirection = .horizontal
        self.calendarView.scrollingMode = .stopAtEachCalendarFrame
        self.calendarView.showsHorizontalScrollIndicator = false
    }
    
    func configureCell(view: JTACDayCell?, cellState: CellState) {
       guard let cell = view as? MonthViewCell  else { return }
       cell.dateLBL.text = cellState.text
       handleCellTextColor(cell: cell, cellState: cellState)
       handleCellSelectedColor(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: MonthViewCell, cellState: CellState) {
       if cellState.dateBelongsTo == .thisMonth {
        cell.dateLBL.textColor = UIColor.black
       } else {
        cell.dateLBL.textColor = UIColor.gray
       }
    }
    
    //MARK:- handleCellSelectedColor() - when click any date than background color change
    func handleCellSelectedColor(cell: MonthViewCell, cellState: CellState){
        if cellState.isSelected{
            cell.backGroundView.isHidden = false
            cell.backGroundView.layer.cornerRadius = 5
            cell.dateLBL.textColor = UIColor.white
        }else{
            cell.backGroundView.isHidden = true
        }
    }
    
    //MARK:- previousMonthBtnAction() - get previous month when click previous btn
    @IBAction func previousMonthBtnAction(_ sender: Any) {
        self.calendarView.scrollToSegment(.previous)
    }
    
    //MARK:- nextMonthBtnAction() - get next month when click next btn
    @IBAction func nextMonthBtnAction(_ sender: Any) {
        self.calendarView.scrollToSegment(.next)
    }
    
    func getWeatherResponse(dt: Int){
        if let lat = self.latitude, let lon = self.longitude{
            let url = "\(Constant.shared.secondBaseUrl)lat=\(lat)&lon=\(lon)&dt=\(dt)&appid=\(Constant.shared.API_KEY)"
            DecodeResponse.shared.getResponseByDT(apiEndPoint: url, completionHandler: {
                (response, status) in
                if status == "Success"{
                    if let weatherResponse = response{
                        self.weatherData = weatherResponse
                        DispatchQueue.main.async {
                            self.updateWeather()
                        }
                    }
                }
            })
        }
        
    }
    
    func updateWeather(){
        if let kelvinTemp = self.weatherData.current?.temp{
            let afterConvert = kelvinTemp.convertFromKelvinToCelcius()
            let celcius = afterConvert.roundToDecimal(2)
            if Constant.shared.celcius{
                self.tempratureLBL.text = "\(String(describing: celcius)) °C"
            }else{
                self.tempratureLBL.text = "\(String(describing: celcius.convertToFehrenheit())) °F"
            }
        }
        self.atmosphereLBL.text = self.weatherData.current?.weather?[0].main ?? "NA"
    }
    
}

extension CalendarVC: JTACMonthViewDataSource, JTACMonthViewDelegate{
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = Date()
        var dateComponent = DateComponents()
        dateComponent.year = 1
        let endDate = Calendar.current.date(byAdding: dateComponent, to: startDate)!
        return ConfigurationParameters(startDate: startDate, endDate: endDate, generateInDates: .forAllMonths, generateOutDates: .tillEndOfGrid)
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "monthViewCell", for: indexPath) as! MonthViewCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
        self.dateSelect = date
        self.getWeatherResponse(dt: Int(date.timeIntervalSince1970))
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setMonthHeaderName(from: visibleDates)
    }
    
    func calendar(_ calendar: JTACMonthView, willScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setMonthHeaderName(from: visibleDates)
    }
    
}
