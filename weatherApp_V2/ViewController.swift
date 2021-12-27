//
//  ViewController.swift
//  weatherApp_V2
//
//  Created by Hajar Alomari on 26/12/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var hiTempLabel: UILabel!
    @IBOutlet weak var loTempLabel: UILabel!
    
    let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=jeddah&units=metric&appid=16af880d4178964f12c73d68e482a647"
    
    
   // var result: Weather?
    var result: [List] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchWeather()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ForcastTableViewCell
        let item = result[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        cell.dayLabel.text = formatter.string(from: item.dt)
        print(item.dt)
        cell.weatherDescripLabel.text = item.weather[0].description
        cell.tempLabel.text = "\(item.main.temp)º"
        
        return cell
    }

    
    func fetchWeather(){
        guard let url = URL(string: urlString) else {
            return
        }
        //weak self to avoid memeory leak
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _ , error in
            
            guard let data = data  , error == nil else {
                return
                
            }
            do{
                let api = Weather.self
                let jsonResults = try JSONDecoder().decode(api, from: data)
                DispatchQueue.main.async {
                    self?.result = jsonResults.list
                    self?.cityNameLabel.text = jsonResults.city.name
                    self?.tempLabel.text = "\(jsonResults.list[0].main.temp)º"
                    self?.hiTempLabel.text = "Hi: \(jsonResults.list[0].main.temp_max)º"
                    self?.loTempLabel.text = "Lo: \(jsonResults.list[0].main.temp_min)º"
                    print(jsonResults.city.name)
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    self?.timeLabel.text =  formatter.string(from: jsonResults.city.timezone)
                    
                    self?.tableView.reloadData()
                }
               
                
            }catch{
                print("Failed to get data")
            }
            print(error.debugDescription)
        }
        task.resume()
        
    }

}

