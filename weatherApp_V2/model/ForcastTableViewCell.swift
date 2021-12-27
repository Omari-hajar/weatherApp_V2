//
//  ForcastTableViewCell.swift
//  weatherApp_V2
//
//  Created by Hajar Alomari on 26/12/2021.
//

import UIKit

class ForcastTableViewCell: UITableViewCell {

    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var weatherDescripLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    func setforcast(temp: String, weather: String, day: Date){
        tempLabel.text = temp
        weatherDescripLabel.text = weather
        let formatter = DateFormatter()
        let date = formatter.string(from: day)
        dayLabel.text = date
    }
}
