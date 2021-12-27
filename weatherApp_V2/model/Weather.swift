//
//  Weather.swift
//  weatherApp_V2
//
//  Created by Hajar Alomari on 26/12/2021.
//

import Foundation
struct Weather: Codable {
    let list: [List]
    let city: City
}

struct List: Codable {
    let dt: Date
    let main: Main
    let weather : [Conditions]
}

struct Conditions: Codable{
    let description : String
}


struct Main: Codable {
    let temp : Double
    let temp_min: Double
    let temp_max: Double 
}

struct City: Codable{
    let name : String
    let timezone: Date
}
